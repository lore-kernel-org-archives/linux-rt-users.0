From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [rfc patch v2] rt,nohz_full: fix nohz_full for PREEMPT_RT_FULL
Date: Sat, 11 Apr 2015 15:15:59 +0200
Message-ID: <1428758159.10417.13.camel@gmail.com>
References: <20150216111822.GA21649@linutronix.de>
	 <1424258514.3819.39.camel@gmail.com> <20150309134535.GA13768@linutronix.de>
	 <1425911771.30469.8.camel@gmail.com> <1425980136.3507.17.camel@gmail.com>
	 <1426153093.4190.2.camel@gmail.com> <1426222405.17611.7.camel@gmail.com>
	 <20150410141552.GC3057@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:33951 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753843AbbDKNQE (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 11 Apr 2015 09:16:04 -0400
In-Reply-To: <20150410141552.GC3057@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2015-04-10 at 16:15 +0200, Sebastian Andrzej Siewior wrote:
> * Mike Galbraith | 2015-03-13 05:53:25 [+0100]:
> 
> > First of all, a task being ticked and trying to shut the tick down 
> > will
> > fail to do so due to having just awakened ksoftirqd, so let 
> > ksoftirqd
> > try to do that after SOFTIRQ_TIMER processing.  Secondly, should 
> > the
> > tick be shut down, we may livelock in hrtimer-cancel() because in -
> > rt
> > a callback may be running.  Break the loop, and let 
> > tick_nohz_restart()
> > know that the timer is busy so it can bail.
> 
> So with this patch
>     http://marc.info/?l=linux-rt-users&m=142866940327602&w=2


@@ -117,10 +113,8 @@ bool irq_work_queue(struct irq_work *wor
        if (work->flags & IRQ_WORK_HARD_IRQ) {
                if (llist_add(&work->llnode, this_cpu_ptr(&hirq_work_list)))
                        arch_irq_work_raise();
-       } else {
-               if (llist_add(&work->llnode, this_cpu_ptr(&lazy_list)))
-                       arch_irq_work_raise();
-       }
+       } /* for lazy_list we have the timer irq */

If we don't queue work without IRQ_WORK_HARD_IRQ set, how does it run?

Anyway, box did not livelock, nor did it with that bit reverted.

> you could drop the hrtimer hacks. Is this the remaining part all 
> that is
> required or we shorten the following patch a little more?

rt, nohz_full: fix nohz_full for PREEMPT_RT_FULL

A task being ticked and trying to shut the tick down will fail due
to having just awakened ksoftirqd, subtract it from nr_running.

Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>
---
 kernel/sched/core.c      |   17 ++++++++++++++++-
 kernel/time/tick-sched.c |    5 +++++
 2 files changed, 21 insertions(+), 1 deletion(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -781,14 +781,29 @@ static inline bool got_nohz_idle_kick(vo
 #endif /* CONFIG_NO_HZ_COMMON */
 
 #ifdef CONFIG_NO_HZ_FULL
+
+static int ksoftirqd_running(void)
+{
+       struct task_struct *softirqd;
+
+       if (!IS_ENABLED(CONFIG_PREEMPT_RT_FULL))
+               return 0;
+       softirqd = this_cpu_ksoftirqd();
+       if (softirqd && softirqd->on_rq)
+               return 1;
+       return 0;
+}
+
 bool sched_can_stop_tick(void)
 {
        /*
         * More than one running task need preemption.
         * nr_running update is assumed to be visible
         * after IPI is sent from wakers.
+        *
+        * NOTE, RT: if ksoftirqd is awake, subtract it.
         */
-       if (this_rq()->nr_running > 1)
+       if (this_rq()->nr_running - ksoftirqd_running() > 1)
                return false;
 
        return true;
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -227,7 +227,12 @@ void __tick_nohz_full_check(void)
 
 static void nohz_full_kick_work_func(struct irq_work *work)
 {
+       unsigned long flags;
+
+       /* ksoftirqd processes sirqs with interrupts enabled */
+       local_irq_save(flags);
        __tick_nohz_full_check();
+       local_irq_restore(flags);
 }
 
 static DEFINE_PER_CPU(struct irq_work, nohz_full_kick_work) = {
