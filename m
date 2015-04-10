From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [rfc patch v2] rt,nohz_full: fix nohz_full for PREEMPT_RT_FULL
Date: Fri, 10 Apr 2015 16:15:52 +0200
Message-ID: <20150410141552.GC3057@linutronix.de>
References: <20150216111822.GA21649@linutronix.de>
 <1424258514.3819.39.camel@gmail.com>
 <20150309134535.GA13768@linutronix.de>
 <1425911771.30469.8.camel@gmail.com>
 <1425980136.3507.17.camel@gmail.com>
 <1426153093.4190.2.camel@gmail.com>
 <1426222405.17611.7.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1426222405.17611.7.camel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Mike Galbraith | 2015-03-13 05:53:25 [+0100]:

>First of all, a task being ticked and trying to shut the tick down will
>fail to do so due to having just awakened ksoftirqd, so let ksoftirqd
>try to do that after SOFTIRQ_TIMER processing.  Secondly, should the
>tick be shut down, we may livelock in hrtimer-cancel() because in -rt
>a callback may be running.  Break the loop, and let tick_nohz_restart()
>know that the timer is busy so it can bail.

So with this patch
    http://marc.info/?l=linux-rt-users&m=142866940327602&w=2

you could drop the hrtimer hacks. Is this the remaining part all that is
required or we shorten the following patch a little more?

>--- a/kernel/sched/core.c
>+++ b/kernel/sched/core.c
>@@ -783,12 +783,18 @@ static inline bool got_nohz_idle_kick(vo
> #ifdef CONFIG_NO_HZ_FULL
> bool sched_can_stop_tick(void)
> {
>+	int ksoftirqd = !!(IS_ENABLED(CONFIG_PREEMPT_RT_FULL) &&
>+			   current == this_cpu_ksoftirqd());
>+
> 	/*
> 	 * More than one running task need preemption.
> 	 * nr_running update is assumed to be visible
> 	 * after IPI is sent from wakers.
>+	 *
>+	 * NOTE, RT: ksoftirqd tries to stop the tick for
>+	 * tasks as they exit irq, ergo subtracts itself.
> 	 */
>-	if (this_rq()->nr_running > 1)
>+	if (this_rq()->nr_running - ksoftirqd > 1)
> 		return false;
> 
> 	return true;
>--- a/kernel/softirq.c
>+++ b/kernel/softirq.c
>@@ -498,6 +498,22 @@ static void unlock_softirq(int which)
> 	local_unlock(local_softirq_locks[which]);
> }
> 
>+/*
>+ * Let ksoftirqd try to shut down the tick when awakened via
>+ * timer_interrupt->irq_exit()->invoke_softirq(), as the task
>+ * then calling tick_nohz_irq_exit() WILL fail to do so due
>+ * to that very wakeup having made rq->nr_running > 1.
>+ */
>+static void tick_nohz_sirq_timer_exit(int which)
>+{
>+	if (!IS_ENABLED(CONFIG_NO_HZ_FULL))
>+		return;
>+	if (!IS_ENABLED(CONFIG_PREEMPT_RT_FULL))
>+		return;
>+	if (which != TIMER_SOFTIRQ || current != this_cpu_ksoftirqd())
>+		return;
>+	tick_nohz_irq_exit();
>+}
> static void do_single_softirq(int which, int need_rcu_bh_qs)
> {
> 	unsigned long old_flags = current->flags;
>@@ -513,6 +529,7 @@ static void do_single_softirq(int which,
> 	current->flags &= ~PF_IN_SOFTIRQ;
> 	vtime_account_irq_enter(current);
> 	tsk_restore_flags(current, old_flags, PF_MEMALLOC);
>+	tick_nohz_sirq_timer_exit(which);
> }
> 
> /*
>--- a/kernel/time/tick-sched.c
>+++ b/kernel/time/tick-sched.c
>@@ -222,7 +222,12 @@ void __tick_nohz_full_check(void)
> 
> static void nohz_full_kick_work_func(struct irq_work *work)
> {
>+	unsigned long flags;
>+
>+	/* ksoftirqd processes sirqs with interrupts enabled */
>+	local_irq_save(flags);
> 	__tick_nohz_full_check();
>+	local_irq_restore(flags);
> }
> 
> static DEFINE_PER_CPU(struct irq_work, nohz_full_kick_work) = {
