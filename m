Return-Path: <SRS0=xxJu=ZV=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF8CC432C0
	for <linux-rt-users@archiver.kernel.org>; Fri, 29 Nov 2019 22:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D130B215E5
	for <linux-rt-users@archiver.kernel.org>; Fri, 29 Nov 2019 22:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575067914;
	bh=hbGhiafV9JzvT630X1Ah0m7sU44x5bb3bEL8Z3f5FxE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=XJa4qe1NWSKUm35YCu/QDk0Qs1IHvjESsPFWSBKCQo2PCDMeN/w75e+iRIncK76Fp
	 BrNQVilnX+hB7bUvXLS9ea/YuuFsZmcg6Cwv7H7tITJ2Y7zpOy0GvoJrb1D9fzJ8WB
	 JWGMjJ+wJjs2QtAT5O8Cp+O/o5CnDA4iiVRi5UmQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfK2Wvt (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 29 Nov 2019 17:51:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:49900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727124AbfK2Wvs (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 29 Nov 2019 17:51:48 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BE372086A;
        Fri, 29 Nov 2019 22:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575067907;
        bh=hbGhiafV9JzvT630X1Ah0m7sU44x5bb3bEL8Z3f5FxE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=AiE5Mys78qpEq49jzGC7em73f1tV08A5OIQmyyZkMrXtwUnYOZ+BD0Lb6E/GzOQ9y
         LH4bfrUUguh5dgvOoMIE1AMlW3x/kDYgvOiONpWMq6XQ1Fz9eZ2snf51Rb11NOJHMq
         EKn30bpXwppM3UCsNXn22oNq912Q6FLR8bDEvdNI=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 3BAE835227A4; Fri, 29 Nov 2019 14:51:47 -0800 (PST)
Date:   Fri, 29 Nov 2019 14:51:47 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH RT] locking: Make spinlock_t and rwlock_t a RCU section
 on RT
Message-ID: <20191129225147.GO2889@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191119084640.wgsxghvc62mxlqc3@linutronix.de>
 <20191119092149.06fd8f87@gandalf.local.home>
 <20191122180140.bspcwv6xtrwqhmu7@linutronix.de>
 <20191125122545.20e721d7@gandalf.local.home>
 <20191129154535.sla5s54xd7rfty2u@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191129154535.sla5s54xd7rfty2u@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, Nov 29, 2019 at 04:45:35PM +0100, Sebastian Andrzej Siewior wrote:
> On 2019-11-25 12:25:45 [-0500], Steven Rostedt wrote:
> > On Fri, 22 Nov 2019 19:01:40 +0100
> > Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> > 
> > > Let me give you an example how I got into this:
> > > 
> > > do_sigaction() acquires p->sighand->siglock and then iterates over list
> > > via for_each_thread() which is a list_for_each_entry_rcu(). No RCU lock
> > > is held, just the siglock.
> > > On removal side, __unhash_process() removes a task from the list but
> > > while doing so it holds the siglock and tasklist_lock. So it is
> > > perfectly fine.
> > > Later, we have:
> > > |do_exit()
> > > | -> exit_notify()
> > > |   -> write_lock_irq(&tasklist_lock);
> > > |   -> forget_original_parent()
> > > |      -> find_child_reaper()
> > > |        -> find_alive_thread()
> > > |           -> for_each_thread()
> > > 
> > > find_alive_thread() does the for_each_thread() and checks PF_EXITING.
> > > it might be enough for not operating on "removed" task_struct. It
> > > dereferences task_struct->flags while looking for PF_EXITING. At this
> > > point only tasklist_lock is acquired.
> > > I have *no* idea if the whole synchronisation based on siglock/
> > > PF_EXITING/ tasklist_lock is enough and RCU simply doesn't matter. It
> > > seems so.
> > > 
> > > I am a little worried if this construct here (or somewhere else) assumes
> > > that holding one of those locks, which disable preemption, is the same
> > > as rcu_read_lock() (or rcu_read_lock_sched()).
> > 
> > I'm wondering if instead, we should start throwing in rcu_read_lock()
> > and explicitly have the preempt disabled rcu use that as well, since
> > today it's basically one and the same.
> 
> Any comment from the RCU camp on this?
> Maybe just adding the missing RCU annotation for the list annotation is
> enough (like if lock X or Y is held then everything fine). !RT gets this
> implicit via preempt_disable(). I'm just worried if someone expects
> this kind of behaviour.
> If I remember correctly, Scott added rcu_read_lock() recently to
> local_bh_disable() because RCU-torture expected it.

Adding an explicit rcu_read_lock()/rcu_read_unlock() pair to the various
spinlock primitives for -rt seems quite sensible to me.  My guess is
that non-rt CONFIG_PREEMPT=y uses in mainline might not like the extra
overhead.

For the trylock primitives, would it make more sense to do the
rcu_read_lock() only after successful acquisition, or to do the
rcu_read_lock() to begin with and then do rcu_read_unlock() upon failure?
I would guess the latter, but don't feel strongly about it.

							Thanx, Paul
