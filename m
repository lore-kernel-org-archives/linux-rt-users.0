Return-Path: <SRS0=xxJu=ZV=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D277C432C0
	for <linux-rt-users@archiver.kernel.org>; Fri, 29 Nov 2019 15:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AB152075C
	for <linux-rt-users@archiver.kernel.org>; Fri, 29 Nov 2019 15:45:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbfK2Ppj (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 29 Nov 2019 10:45:39 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49073 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbfK2Ppi (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 29 Nov 2019 10:45:38 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iaiSd-000188-64; Fri, 29 Nov 2019 16:45:35 +0100
Date:   Fri, 29 Nov 2019 16:45:35 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH RT] locking: Make spinlock_t and rwlock_t a RCU section
 on RT
Message-ID: <20191129154535.sla5s54xd7rfty2u@linutronix.de>
References: <20191119084640.wgsxghvc62mxlqc3@linutronix.de>
 <20191119092149.06fd8f87@gandalf.local.home>
 <20191122180140.bspcwv6xtrwqhmu7@linutronix.de>
 <20191125122545.20e721d7@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191125122545.20e721d7@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-11-25 12:25:45 [-0500], Steven Rostedt wrote:
> On Fri, 22 Nov 2019 19:01:40 +0100
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
> > Let me give you an example how I got into this:
> > 
> > do_sigaction() acquires p->sighand->siglock and then iterates over list
> > via for_each_thread() which is a list_for_each_entry_rcu(). No RCU lock
> > is held, just the siglock.
> > On removal side, __unhash_process() removes a task from the list but
> > while doing so it holds the siglock and tasklist_lock. So it is
> > perfectly fine.
> > Later, we have:
> > |do_exit()
> > | -> exit_notify()
> > |   -> write_lock_irq(&tasklist_lock);
> > |   -> forget_original_parent()
> > |      -> find_child_reaper()
> > |        -> find_alive_thread()
> > |           -> for_each_thread()
> > 
> > find_alive_thread() does the for_each_thread() and checks PF_EXITING.
> > it might be enough for not operating on "removed" task_struct. It
> > dereferences task_struct->flags while looking for PF_EXITING. At this
> > point only tasklist_lock is acquired.
> > I have *no* idea if the whole synchronisation based on siglock/
> > PF_EXITING/ tasklist_lock is enough and RCU simply doesn't matter. It
> > seems so.
> > 
> > I am a little worried if this construct here (or somewhere else) assumes
> > that holding one of those locks, which disable preemption, is the same
> > as rcu_read_lock() (or rcu_read_lock_sched()).
> 
> I'm wondering if instead, we should start throwing in rcu_read_lock()
> and explicitly have the preempt disabled rcu use that as well, since
> today it's basically one and the same.

Any comment from the RCU camp on this?
Maybe just adding the missing RCU annotation for the list annotation is
enough (like if lock X or Y is held then everything fine). !RT gets this
implicit via preempt_disable(). I'm just worried if someone expects
this kind of behaviour.
If I remember correctly, Scott added rcu_read_lock() recently to
local_bh_disable() because RCU-torture expected it.

> Although, we still need to be careful for some special cases like
> function tracing, that uses its own kind of RCU. But that should be
> fixed when I introduce rcu_read_lock_tasks() :-)
> 
> -- Steve

Sebastian
