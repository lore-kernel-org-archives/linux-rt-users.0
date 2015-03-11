From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [patch-3.18.7-rt1] sched/context-tracking: fix PREEMPT_LAZY
 explosions
Date: Wed, 11 Mar 2015 07:18:56 +0100
Message-ID: <1426054736.30130.3.camel@gmail.com>
References: <20150216111822.GA21649@linutronix.de>
	 <1424258514.3819.39.camel@gmail.com> <20150309134535.GA13768@linutronix.de>
	 <1425911771.30469.8.camel@gmail.com> <1425980136.3507.17.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54]:38478 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798AbbCKGS7 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 11 Mar 2015 02:18:59 -0400
In-Reply-To: <1425980136.3507.17.camel@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2015-03-10 at 10:35 +0100, Mike Galbraith wrote:
> On Mon, 2015-03-09 at 15:36 +0100, Mike Galbraith wrote:
> > On Mon, 2015-03-09 at 14:45 +0100, Sebastian Andrzej Siewior wrote:
> > > * Mike Galbraith | 2015-02-18 12:21:54 [+0100]:
> > > 
> > > >On Mon, 2015-02-16 at 12:18 +0100, Sebastian Andrzej Siewior wrote:
> > > >
> > > >> Known issues:
> > > >>
> > > >>       - lazy preempt on x86_64 leads to a crash with some load.
> > > >
> > > >The below still works for me.  (it doesn't make nohz_full actually work
> > > >in rt, but at least folks who want to tinker with it can do so)
> > > So your box still crashes without it?
> > > 
> > > The thing is I tried to reproduce it and it does not occur anymore.
> > > Neither in KVM nor on real HW.
> > 
> > Heh, well that's interesting, I just presumed it would still explode
> > because you said it would.  I'll beat on it any let you know if I'm
> > carrying a placebo patch or not :)
> 
> Yup, someone made kaboom go away.  I was able to easily blow my box out
> of the water by running tbench + kbuild with nohz_full active.  No more.
> 
> nohz_full doesn't work though, due to an otherwise solo task trying to
> shut the tick down having just awakened ksoftirqd.. but no more kaboom.

FWIW, the hack below made nohz_full functional in my trees, and it still
doesn't explode, so seems it really really did get fixed up.

---
 kernel/sched/core.c      |    2 +-
 kernel/softirq.c         |   25 +++++++++++++++++++------
 kernel/time/hrtimer.c    |   10 +++++++++-
 kernel/time/tick-sched.c |   15 ++++++++++++++-
 4 files changed, 43 insertions(+), 9 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -810,7 +810,7 @@ bool sched_can_stop_tick(void)
 	 * nr_running update is assumed to be visible
 	 * after IPI is sent from wakers.
 	 */
-	if (this_rq()->nr_running > 1)
+	if (this_rq()->nr_running - task_is_softirqd(current) > 1)
 		return false;
 
 	return true;
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -517,19 +517,32 @@ static void unlock_softirq(int which)
 
 static void do_single_softirq(int which, int need_rcu_bh_qs)
 {
-	unsigned long old_flags = current->flags;
+	struct task_struct *p = current;
+	unsigned long old_flags = p->flags;
 
-	current->flags &= ~PF_MEMALLOC;
+	p->flags &= ~PF_MEMALLOC;
 	vtime_account_irq_enter(current);
-	current->flags |= PF_IN_SOFTIRQ;
+	p->flags |= PF_IN_SOFTIRQ;
 	lockdep_softirq_enter();
 	local_irq_enable();
 	handle_softirq(which);
 	local_irq_disable();
 	lockdep_softirq_exit();
-	current->flags &= ~PF_IN_SOFTIRQ;
-	vtime_account_irq_enter(current);
-	tsk_restore_flags(current, old_flags, PF_MEMALLOC);
+	p->flags &= ~PF_IN_SOFTIRQ;
+	vtime_account_irq_enter(p);
+	tsk_restore_flags(p, old_flags, PF_MEMALLOC);
+#if defined(CONFIG_NO_HZ_FULL) && defined(CONFIG_PREEMPT_RT_FULL)
+	/*
+	 * If a task calls irq_exit()->invoke_softirq(), it won't
+	 * be able to shut the tick down because it just woke us.
+	 * Try to shut it down now.
+	 */
+	if (tick_nohz_full_cpu(raw_smp_processor_id()) &&
+	    task_is_softirqd(p) && which == TIMER_SOFTIRQ &&
+	    sched_can_stop_tick()) {
+		tick_nohz_irq_exit();
+	}
+#endif
 }
 
 /*
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1141,7 +1141,6 @@ hrtimer_start(struct hrtimer *timer, kti
 }
 EXPORT_SYMBOL_GPL(hrtimer_start);
 
-
 /**
  * hrtimer_try_to_cancel - try to deactivate a timer
  * @timer:	hrtimer to stop
@@ -1162,6 +1161,15 @@ int hrtimer_try_to_cancel(struct hrtimer
 
 	if (!hrtimer_callback_running(timer))
 		ret = remove_hrtimer(timer, base);
+#if defined(CONFIG_PREEMPT_RT_FULL) && defined(CONFIG_NO_HZ_FULL)
+	else {
+		extern enum hrtimer_restart tick_sched_timer(struct hrtimer *timer);
+		int cpu = raw_smp_processor_id();
+
+		if (tick_nohz_full_cpu(cpu) && timer->function == tick_sched_timer)
+			ret = HRTIMER_STATE_CALLBACK;
+	}
+#endif
 
 	unlock_hrtimer_base(timer, &flags);
 
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -222,7 +222,14 @@ void __tick_nohz_full_check(void)
 
 static void nohz_full_kick_work_func(struct irq_work *work)
 {
+	unsigned long flags;
+
+	local_save_flags(flags);
+	/* ksoftirqd processes softirqs with interrupts enabled */
+	if (task_is_softirqd(current))
+		local_irq_disable_rt();
 	__tick_nohz_full_check();
+	local_irq_restore(flags);
 }
 
 static DEFINE_PER_CPU(struct irq_work, nohz_full_kick_work) = {
@@ -879,6 +886,12 @@ ktime_t tick_nohz_get_sleep_length(void)
 
 static void tick_nohz_restart(struct tick_sched *ts, ktime_t now)
 {
+#if defined(CONFIG_PREEMPT_RT_FULL) && defined(CONFIG_NO_HZ_FULL)
+	if (tick_nohz_full_cpu(raw_smp_processor_id()) &&
+	    hrtimer_cancel(&ts->sched_timer) == HRTIMER_STATE_CALLBACK)
+		return;
+	else
+#endif
 	hrtimer_cancel(&ts->sched_timer);
 	hrtimer_set_expires(&ts->sched_timer, ts->last_tick);
 
@@ -1108,7 +1121,7 @@ void tick_irq_enter(void)
  * We rearm the timer until we get disabled by the idle code.
  * Called with interrupts disabled.
  */
-static enum hrtimer_restart tick_sched_timer(struct hrtimer *timer)
+enum hrtimer_restart tick_sched_timer(struct hrtimer *timer)
 {
 	struct tick_sched *ts =
 		container_of(timer, struct tick_sched, sched_timer);


