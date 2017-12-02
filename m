From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH] sched/rt: Do not pull from current CPU if only one cpu to
 pull
Date: Sat, 2 Dec 2017 13:04:54 -0500
Message-ID: <20171202130454.4cbbfe8d@vmware.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Daniel Wagner reported a crash on the beaglebone black. This is a
single CPU architecture, and does not have a functional:
arch_send_call_function_single_ipi() and can crash if that is called.

As it only has one CPU, it shouldn't be called, but if the kernel is
compiled for SMP, the push/pull RT scheduling logic now calls it for
irq_work if the one CPU is overloaded, it can use that function to call
itself and crash the kernel.

Ideally, we should disable the SCHED_FEAT(RT_PUSH_IPI) if the system
only has a single CPU. But SCHED_FEAT is a constant if sched debugging
is turned off. Another fix can also be used, and this should also help
with normal SMP machines. That is, do not initiate the pull code if
there's only one RT overloaded CPU, and that CPU happens to be the
current CPU that is scheduling in a lower priority task.

Even on a system with many CPUs, if there's many RT tasks waiting to
run on a single CPU, and that CPU schedules in another RT task of lower
priority, it will initiate the PULL logic in case there's a higher
priority RT task on another CPU that is waiting to run. But if there is
no other CPU with waiting RT tasks, it will initiate the RT pull logic
on itself (as it still has RT tasks waiting to run). This is a wasted
effort.

Not only does this help with SMP code where the current CPU is the only
one with RT overloaded tasks, it should also solve the issue that
Daniel encountered, because it will prevent the PULL logic from
executing, as there's only one CPU on the system, and the check added
here will cause it to exit the RT pull code.

Link: http://lkml.kernel.org/r/8c913cc2-b2e3-8c2e-e503-aff1428f8ff5@monom.org
Fixes: 4bdced5c9 ("sched/rt: Simplify the IPI based RT balancing logic")
Cc: stable@vger.kernel.org
Reported-by: Daniel Wagner <wagi@monom.org>
---
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 4056c19ca3f0..665ace2fc558 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2034,8 +2034,9 @@ static void pull_rt_task(struct rq *this_rq)
 	bool resched = false;
 	struct task_struct *p;
 	struct rq *src_rq;
+	int rt_overload_count = rt_overloaded(this_rq);
 
-	if (likely(!rt_overloaded(this_rq)))
+	if (likely(!rt_overload_count))
 		return;
 
 	/*
@@ -2044,6 +2045,11 @@ static void pull_rt_task(struct rq *this_rq)
 	 */
 	smp_rmb();
 
+	/* If we are the only overloaded CPU do nothing */
+	if (rt_overload_count == 1 &&
+	    cpumask_test_cpu(this_rq->cpu, this_rq->rd->rto_mask))
+		return;
+
 #ifdef HAVE_RT_PUSH_IPI
 	if (sched_feat(RT_PUSH_IPI)) {
 		tell_cpu_to_push(this_rq);
