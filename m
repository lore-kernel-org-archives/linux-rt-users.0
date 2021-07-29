Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D0FC4338F
	for <linux-rt-users@archiver.kernel.org>; Thu, 29 Jul 2021 01:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D8416101C
	for <linux-rt-users@archiver.kernel.org>; Thu, 29 Jul 2021 01:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233052AbhG2BEs (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 28 Jul 2021 21:04:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:54528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232837AbhG2BEs (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 28 Jul 2021 21:04:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C6BA56054E;
        Thu, 29 Jul 2021 01:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627520685;
        bh=6uCA6dq+V8ph083FJUgVYiyyZQvKKUJPCn1QR6+u9m4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=uqy5xdH22H5q5F29Kx5oD7z26+y3Sd+n7TvVDBkRwKJWqy73l1if9EKoPtaFeJ5+D
         n48Ii9NKvW3cjoYp5NQv17dP06J+atMCkna8hG9qsUCodAABSafAQ2QLcXWA9Kz0rl
         sTNvuAozBOJnOTQzS/QsmHIHHdqQsTdkqnHOcdNTucDt5IcGclUiOn/ZO7Gm/rkSIO
         GYq6vFrhLyenM8s+PJWGONeaXVfZNsOn9nGb6PJlErcRxmHKt4g2sqCmEebAdTR6L9
         mMnjgs+i1VRdvijzwcic/wbSl69gnO05H24+sZGMFlBzDmSpqY+0MCyI5OLOCaPmZ5
         29o7pehIyE4vQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 93B405C048D; Wed, 28 Jul 2021 18:04:45 -0700 (PDT)
Date:   Wed, 28 Jul 2021 18:04:45 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rt-users@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Steven Price <steven.price@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 2/3] rcu/nocb: Check for migratability rather than pure
 preemptability
Message-ID: <20210729010445.GO4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210721115118.729943-1-valentin.schneider@arm.com>
 <20210721115118.729943-3-valentin.schneider@arm.com>
 <20210727230814.GC283787@lothringen>
 <87pmv2kzbd.mognet@arm.com>
 <20210728220137.GD293265@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210728220137.GD293265@lothringen>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, Jul 29, 2021 at 12:01:37AM +0200, Frederic Weisbecker wrote:
> On Wed, Jul 28, 2021 at 08:34:14PM +0100, Valentin Schneider wrote:
> > On 28/07/21 01:08, Frederic Weisbecker wrote:
> > > On Wed, Jul 21, 2021 at 12:51:17PM +0100, Valentin Schneider wrote:
> > >> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> > >> ---
> > >>  kernel/rcu/tree_plugin.h | 3 +--
> > >>  1 file changed, 1 insertion(+), 2 deletions(-)
> > >>
> > >> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > >> index ad0156b86937..6c3c4100da83 100644
> > >> --- a/kernel/rcu/tree_plugin.h
> > >> +++ b/kernel/rcu/tree_plugin.h
> > >> @@ -70,8 +70,7 @@ static bool rcu_rdp_is_offloaded(struct rcu_data *rdp)
> > >>              !(lockdep_is_held(&rcu_state.barrier_mutex) ||
> > >>                (IS_ENABLED(CONFIG_HOTPLUG_CPU) && lockdep_is_cpus_held()) ||
> > >>                rcu_lockdep_is_held_nocb(rdp) ||
> > >> -		  (rdp == this_cpu_ptr(&rcu_data) &&
> > >> -		   !(IS_ENABLED(CONFIG_PREEMPT_COUNT) && preemptible())) ||
> > >> +		  (rdp == this_cpu_ptr(&rcu_data) && is_pcpu_safe()) ||
> > >
> > > I fear that won't work. We really need any caller of rcu_rdp_is_offloaded()
> > > on the local rdp to have preemption disabled and not just migration disabled,
> > > because we must protect against concurrent offloaded state changes.
> > >
> > > The offloaded state is changed by a workqueue that executes on the target rdp.
> > >
> > > Here is a practical example where it matters:
> > >
> > >            CPU 0
> > >            -----
> > >            // =======> task rcuc running
> > >            rcu_core {
> > >              rcu_nocb_lock_irqsave(rdp, flags) {
> > >                    if (!rcu_segcblist_is_offloaded(rdp->cblist)) {
> > >                      // is not offloaded right now, so it's going
> > >                        // to just disable IRQs. Oh no wait:
> > >            // preemption
> > >            // ========> workqueue running
> > >            rcu_nocb_rdp_offload();
> > >            // ========> task rcuc resume
> > >                      local_irq_disable();
> > >                    }
> > >                }
> > >              ....
> > >                      rcu_nocb_unlock_irqrestore(rdp, flags) {
> > >                    if (rcu_segcblist_is_offloaded(rdp->cblist)) {
> > >                        // is offloaded right now so:
> > >                        raw_spin_unlock_irqrestore(rdp, flags);
> > >
> > > And that will explode because that's an impaired unlock on nocb_lock.
> > 
> > Harumph, that doesn't look good, thanks for pointing this out.
> > 
> > AFAICT PREEMPT_RT doesn't actually require to disable softirqs here (since
> > it forces RCU callbacks on the RCU kthreads), but disabled softirqs seem to
> > be a requirement for much of the underlying functions and even some of the
> > callbacks (delayed_put_task_struct() ~> vfree() pays close attention to
> > in_interrupt() for instance).
> > 
> > Now, if the offloaded state was (properly) protected by a local_lock, do
> > you reckon we could then keep preemption enabled?
> 
> I guess we could take such a local lock on the update side
> (rcu_nocb_rdp_offload) and then take it on rcuc kthread/softirqs
> and maybe other places.
> 
> But we must make sure that rcu_core() is preempt-safe from a general perspective
> in the first place. From a quick glance I can't find obvious issues...yet.
> 
> Paul maybe you can see something?

Let's see...

o	Extra context switches in rcu_core() mean extra quiescent
	states.  It therefore might be necessary to wrap rcu_core()
	in an rcu_read_lock() / rcu_read_unlock() pair, because
	otherwise an RCU grace period won't wait for rcu_core().

	Actually, better have local_bh_disable() imply
	rcu_read_lock() and local_bh_enable() imply rcu_read_unlock().
	But I would hope that this already happened.

o	The rcu_preempt_deferred_qs() check should still be fine,
	unless there is a raw_bh_disable() in -rt. 

o	The set_tsk_need_resched() and set_preempt_need_resched()
	might preempt immediately.  I cannot think of a problem
	with that, but careful testing is clearly in order.

o	The values checked by rcu_check_quiescent_state() could now
	change while this function is running.	I don't immediately
	see a problematic sequence of events, but here be dragons.
	I therefore suggest disabling preemption across this function.
	Or if that is impossible, taking a very careful look at the
	proposed expansion of the state space of this function.

o	I don't see any new races in the grace-period/callback check.
	New callbacks can appear in interrupt handlers, after all.

o	The rcu_check_gp_start_stall() function looks similarly
	unproblematic.

o	Callback invocation can now be preempted, but then again it
	recently started being concurrent, so this should be no
	added risk over offloading/de-offloading.

o	I don't see any problem with do_nocb_deferred_wakeup().

o	The CONFIG_RCU_STRICT_GRACE_PERIOD check should not be
	impacted.

So some adjustments might be needed, but I don't see a need for
major surgery.

This of course might be a failure of imagination on my part, so it
wouldn't hurt to double-check my observations.

> > From a naive outsider PoV, rdp->nocb_lock looks like a decent candidate,
> > but it's a *raw* spinlock (I can't tell right now whether changing this is
> > a horrible idea or not), and then there's
> 
> Yeah that's not possible, nocb_lock is too low level and has to be called with
> IRQs disabled. So if we take that local_lock solution, we need a new lock.

No argument here!

							Thanx, Paul
