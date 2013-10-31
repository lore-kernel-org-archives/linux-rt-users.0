From: Mike Galbraith <bitbucket@online.de>
Subject: CONFIG_NO_HZ_FULL + CONFIG_PREEMPT_RT_FULL = nogo
Date: Thu, 31 Oct 2013 15:07:07 +0100
Message-ID: <1383228427.5272.36.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Peter Zijlstra <peterz@infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>
To: Frederic Weisbecker <fweisbec@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Frederic,

The tick wakes ksoftirqd, ensuring nr_running test ain't gonna happen
when an otherwise lonely task takes the timer interrupt.  Deferring to
softirq processing time..... works.

---
 kernel/sched/core.c      |    2 +-
 kernel/softirq.c         |   10 ++++++++++
 kernel/time/tick-sched.c |    2 ++
 3 files changed, 13 insertions(+), 1 deletion(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -704,7 +704,7 @@ bool sched_can_stop_tick(void)
        smp_rmb();
 
        /* More than one running task need preemption */
-       if (rq->nr_running > 1)
+       if (rq->nr_running - (rq->curr == this_cpu_ksoftirqd()) > 1)
                return false;
 
        return true;
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -529,6 +529,11 @@ static void do_current_softirqs(int need
 		softirq_clr_runner(i);
 		unlock_softirq(i);
 		WARN_ON(current->softirq_nestcnt != 1);
+
+#ifdef CONFIG_NO_HZ_COMMON
+		if (i == TIMER_SOFTIRQ && tick_nohz_full_cpu(raw_smp_processor_id()))
+			 tick_nohz_irq_exit();
+#endif
 	}
 }
 
@@ -728,6 +733,11 @@ static inline void tick_irq_exit(void)
 #ifdef CONFIG_NO_HZ_COMMON
 	int cpu = smp_processor_id();
 
+#ifdef CONFIG_PREEMPT_RT_FULL
+	if (tick_nohz_full_cpu(cpu))
+		return;
+#endif
+
 	/* Make sure that timer wheel updates are propagated */
 	if ((idle_cpu(cpu) && !need_resched()) || tick_nohz_full_cpu(cpu)) {
 		if (!in_interrupt())
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -157,7 +157,9 @@ bool have_nohz_full_mask;
 
 static bool can_stop_full_tick(void)
 {
+#ifndef CONFIG_PREEMPT_RT_FULL
 	WARN_ON_ONCE(!irqs_disabled());
+#endif
 
 	if (!sched_can_stop_tick()) {
 		trace_tick_stop(0, "more than 1 task in runqueue\n");
