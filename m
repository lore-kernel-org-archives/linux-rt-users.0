Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD6CC433F5
	for <linux-rt-users@archiver.kernel.org>; Tue, 16 Nov 2021 14:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1B2C61A64
	for <linux-rt-users@archiver.kernel.org>; Tue, 16 Nov 2021 14:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237056AbhKPOFw (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 16 Nov 2021 09:05:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:36022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236984AbhKPOFw (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 16 Nov 2021 09:05:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DFE6863210;
        Tue, 16 Nov 2021 14:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637071375;
        bh=oCd2oAyI2QiyWmWZpaiHJhFs5UwwWvhjHdKfm9Byeqg=;
        h=Date:From:To:Cc:Subject:From;
        b=c44/u5pnCMPUsshOVChekqlUMKFxj4wsAXp2yslPBbQTXtGVT0v9bk3NYLBGhi6uv
         MUSuQnhbGpECaoh+XMeRS7OYHwy68p4UEn7VkMy7LcSi4VUm6KWjXKIbCUS6zUCi8J
         Tg4cMzThOzpDA9RM6oDQLqaWJOaOgVj1+NQlYFOTlwKree7FeUhhZEbRpqeWct1uFf
         kWIVZZsXsAHRi1w4n33tC6zcBXOLHAIejjsyu0RcHZcZj9tgRk7CXc6c2xmQIN/B/5
         W03DZpFbmttX1adp0DzeCap3ijVvyzaHQPnLRg2YUvWw9HUZN6Acn2PRr2XiqO8vct
         vjsqbzdzM+86Q==
Date:   Tue, 16 Nov 2021 15:02:52 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mike Galbraith <efault@gmx.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Ogness <john.ogness@linutronix.de>,
        Roman Penyaev <rpenyaev@suse.de>,
        Davidlohr Bueso <dbueso@suse.de>,
        Jason Baron <jbaron@akamai.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [RFC] How to fix eventpoll rwlock based priority inversion on
 PREEMPT_RT?
Message-ID: <20211116140252.GA348770@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

I'm iterating again on this topic, this time with the author of
the patch Cc'ed.

The following commit:

    a218cc491420 (epoll: use rwlock in order to reduce ep_poll
                  callback() contention)

has changed the ep->lock into an rwlock. This can cause priority inversion
on PREEMPT_RT. Here is an example:


1) High priority task A waits for events on epoll_wait(), nothing shows up so
   it goes to sleep for new events in the ep_poll() loop.

2) Lower prio task B brings new events in ep_poll_callback(), waking up A
   while still holding read_lock(ep->lock)

3) Task A wakes up immediately, tries to grab write_lock(ep->lock) but it has
   to wait for task B to release read_lock(ep->lock). Unfortunately there is
   no priority inheritance when write_lock() is called on an rwlock that is
   already read_lock'ed. So back to task B that may even be preempted by
   yet another task before releasing read_lock(ep->lock).


Now how to solve this? Several possibilities:


== Delay the wake up after releasing the read_lock()? ==

That solves part of the problem only. If another event comes up
concurrently we are back to the original issue.

== Make rwlock more fair ? ==

Currently read_lock() only acquires the rtmutex if the lock is already
write-held (or write_lock() is waiting to acquire). So if read_lock() happens
after write_lock(), fairness is observed but if write_lock() happens after
read_lock(), priority inheritance doesn't happen.

I think there has been attempts to solve this by the past but some issues
arised (don't know the exact details, comments on rwbase_rt.c bring some clues).

== Convert the rwlock to RCU ? ==

Traditionally, we try to convert rwlocks bringing issues to RCU. I'm not sure the
situation fits here because the rwlock is used the other way around:
the epoll consumer does the write_lock() and the producers do read_lock(). Then
concurrent producers use ad-hoc concurrent list add (see list_add_tail_lockless)
to handle racy modifications.

There are also list modifications on both side. There are added from the
producers and read and deleted (even re-added sometimes) on the consumer side.

Perhaps RCU could be used with keeping locking on the consumer side...

== Convert to llist ? ==

It's a possibility but some operations like single element deletion may be
costly because only llist_add() and llist_del_all() are atomic on llist.
!CONFIG_PREEMPT_RT might not be happy about it.

== Consider epoll not PREEMPT_RT friendly? ==

A last resort is to simply consider epoll is not RT-friendly and suggest
using more simple alternatives like poll()....

Any thoughts?


