From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v5] sched/rt: Use IPI to trigger RT task push migration
 instead of pulling
Date: Wed, 18 Mar 2015 14:49:46 -0400
Message-ID: <20150318144946.2f3cc982@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <williams@redhat.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Mike Galbraith <umgwanakikbuti@gmail.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	=?UTF-8?B?SsO2cm4=?= Engel <joern@purestorage.com>
To: LKML <linux-kernel@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0224.hostedemail.com ([216.40.44.224]:55708 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755824AbbCRStu (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 18 Mar 2015 14:49:50 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


When debugging the latencies on a 40 core box, where we hit 300 to
500 microsecond latencies, I found there was a huge contention on the
runqueue locks.

Investigating it further, running ftrace, I found that it was due to
the pulling of RT tasks.

The test that was run was the following:

 cyclictest --numa -p95 -m -d0 -i100

This created a thread on each CPU, that would set its wakeup in iterations
of 100 microseconds. The -d0 means that all the threads had the same
interval (100us). Each thread sleeps for 100us and wakes up and measures
its latencies.

cyclictest is maintained at:
 git://git.kernel.org/pub/scm/linux/kernel/git/clrkwllms/rt-tests.git

What happened was another RT task would be scheduled on one of the CPUs
that was running our test, when the other CPU tests went to sleep and
scheduled idle. This caused the "pull" operation to execute on all
these CPUs. Each one of these saw the RT task that was overloaded on
the CPU of the test that was still running, and each one tried
to grab that task in a thundering herd way.

To grab the task, each thread would do a double rq lock grab, grabbing
its own lock as well as the rq of the overloaded CPU. As the sched
domains on this box was rather flat for its size, I saw up to 12 CPUs
block on this lock at once. This caused a ripple affect with the
rq locks especially since the taking was done via a double rq lock, which
means that several of the CPUs had their own rq locks held while trying
to take this rq lock. As these locks were blocked, any wakeups or load
balanceing on these CPUs would also block on these locks, and the wait
time escalated.

I've tried various methods to lessen the load, but things like an
atomic counter to only let one CPU grab the task wont work, because
the task may have a limited affinity, and we may pick the wrong
CPU to take that lock and do the pull, to only find out that the
CPU we picked isn't in the task's affinity.

Instead of doing the PULL, I now have the CPUs that want the pull to
send over an IPI to the overloaded CPU, and let that CPU pick what
CPU to push the task to. No more need to grab the rq lock, and the
push/pull algorithm still works fine.

With this patch, the latency dropped to just 150us over a 20 hour run.
Without the patch, the huge latencies would trigger in seconds.

I've created a new sched feature called RT_PUSH_IPI, which is enabled
by default.

When RT_PUSH_IPI is not enabled, the old method of grabbing the rq locks
and having the pulling CPU do the work is implemented. When RT_PUSH_IPI
is enabled, the IPI is sent to the overloaded CPU to do a push.

To enabled or disable this at run time:

 # mount -t debugfs nodev /sys/kernel/debug
 # echo RT_PUSH_IPI > /sys/kernel/debug/sched_features
or
 # echo NO_RT_PUSH_IPI > /sys/kernel/debug/sched_features

Update: This original patch would send an IPI to all CPUs in the RT overload
list. But that could theoretically cause the reverse issue. That is, there
could be lots of overloaded RT queues and one CPU lowers its priority. It would
then send an IPI to all the overloaded RT queues and they could then all try
to grab the rq lock of the CPU lowering its priority, and then we have the
same problem.

The latest design sends out only one IPI to the first overloaded CPU. It tries to
push any tasks that it can, and then looks for the next overloaded CPU that can
push to the source CPU. The IPIs stop when all overloaded CPUs that have pushable
tasks that have priorities greater than the source CPU are covered. In case the
source CPU lowers its priority again, a flag is set to tell the IPI traversal to
restart with the first RT overloaded CPU after the source CPU.

Parts-suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

---
Changes since V4:

 o Fixed some whitespace issues, and changed CPUS to CPUs.

 o Only defined if CONFIG_IRQ_WORK is.

Changes since V3:

 o Removed extra compare in testing prios of source and destination rqs.

 o Removed change caused by typo before patch was applied, and then the typo
   was fixed in this patch.

Changes since V2:

 o Redesigned to mostly eliminate the covering of for each cpu on the rto mask.
   I say mostly, because it skips over any CPU that does not have a task that
   has high enough priority to push to the original CPU.

   The new design finds the next CPU that has an RT overload with a pushable
   task of priority greater than the source CPU and sends an IPI to it. Instead
   of stopping if that CPU succeeds in pushing a task, it instead will continue
   the IPI to the next CPU with a pushable task higher in priority than the
   source CPU tasks. It continues until it covers all the CPUs in the rto_mask
   up to the source CPU.

   There's also a "reset" flag that gets set if the source CPU changes its priority
   before the IPI loop completes. That is, the IPI will start again with the first
   overloaded CPU after the source CPU.

   This version is actually cleaner than the previous version.

Changes since V1:

 o As already mentioned in the "update", a redesign was done to send
   only one IPI, and to the highest rt overloaded queue. If for some
   reason that could not push a task, it would look for the next rq and
   send an ipi (irq work actually) to the next one. Limits are in place
   to prevent any ping pong affect of two rqs sending IPIs back and
   forth.

 o Made this sched feature enabled by default instead of enabling it
   when we have 16 or more CPUs.


 kernel/sched/features.h |   13 +++
 kernel/sched/rt.c       |  177 ++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h    |   12 +++
 3 files changed, 202 insertions(+)

Index: linux-rt.git/kernel/sched/rt.c
===================================================================
--- linux-rt.git.orig/kernel/sched/rt.c	2015-03-18 14:16:26.773346008 -0400
+++ linux-rt.git/kernel/sched/rt.c	2015-03-18 14:17:08.920810104 -0400
@@ -6,6 +6,7 @@
 #include "sched.h"
 
 #include <linux/slab.h>
+#include <linux/irq_work.h>
 
 int sched_rr_timeslice = RR_TIMESLICE;
 
@@ -59,6 +60,10 @@ static void start_rt_bandwidth(struct rt
 	raw_spin_unlock(&rt_b->rt_runtime_lock);
 }
 
+#ifdef CONFIG_SMP
+static void push_irq_work_func(struct irq_work *work);
+#endif
+
 void init_rt_rq(struct rt_rq *rt_rq, struct rq *rq)
 {
 	struct rt_prio_array *array;
@@ -78,7 +83,14 @@ void init_rt_rq(struct rt_rq *rt_rq, str
 	rt_rq->rt_nr_migratory = 0;
 	rt_rq->overloaded = 0;
 	plist_head_init(&rt_rq->pushable_tasks);
+
+#ifdef HAVE_RT_PUSH_IPI
+	rt_rq->push_flags = 0;
+	rt_rq->push_cpu = nr_cpu_ids;
+	raw_spin_lock_init(&rt_rq->push_lock);
+	init_irq_work(&rt_rq->push_work, push_irq_work_func);
 #endif
+#endif /* CONFIG_SMP */
 	/* We start is dequeued state, because no RT tasks are queued */
 	rt_rq->rt_queued = 0;
 
@@ -1778,6 +1790,164 @@ static void push_rt_tasks(struct rq *rq)
 		;
 }
 
+#ifdef HAVE_RT_PUSH_IPI
+/*
+ * The search for the next cpu always starts at rq->cpu and ends
+ * when we reach rq->cpu again. It will never return rq->cpu.
+ * This returns the next cpu to check, or nr_cpu_ids if the loop
+ * is complete.
+ *
+ * rq->rt.push_cpu holds the last cpu returned by this function,
+ * or if this is the first instance, it must hold rq->cpu.
+ */
+static int rto_next_cpu(struct rq *rq)
+{
+	int prev_cpu = rq->rt.push_cpu;
+	int cpu;
+
+	cpu = cpumask_next(prev_cpu, rq->rd->rto_mask);
+
+	/*
+	 * If the previous cpu is less than the rq's CPU, then it already
+	 * passed the end of the mask, and has started from the beginning.
+	 * We end if the next CPU is greater or equal to rq's CPU.
+	 */
+	if (prev_cpu < rq->cpu) {
+		if (cpu >= rq->cpu)
+			return nr_cpu_ids;
+
+	} else if (cpu >= nr_cpu_ids) {
+		/*
+		 * We passed the end of the mask, start at the beginning.
+		 * If the result is greater or equal to the rq's CPU, then
+		 * the loop is finished.
+		 */
+		cpu = cpumask_first(rq->rd->rto_mask);
+		if (cpu >= rq->cpu)
+			return nr_cpu_ids;
+	}
+	rq->rt.push_cpu = cpu;
+
+	/* Return cpu to let the caller know if the loop is finished or not */
+	return cpu;
+}
+
+static int find_next_push_cpu(struct rq *rq)
+{
+	struct rq *next_rq;
+	int cpu;
+
+	while (1) {
+		cpu = rto_next_cpu(rq);
+		if (cpu >= nr_cpu_ids)
+			break;
+		next_rq = cpu_rq(cpu);
+
+		/* Make sure the next rq can push to this rq */
+		if (next_rq->rt.highest_prio.next < rq->rt.highest_prio.curr)
+			break;
+	}
+
+	return cpu;
+}
+
+#define RT_PUSH_IPI_EXECUTING		1
+#define RT_PUSH_IPI_RESTART		2
+
+static void tell_cpu_to_push(struct rq *rq)
+{
+	int cpu;
+
+	if (rq->rt.push_flags & RT_PUSH_IPI_EXECUTING) {
+		raw_spin_lock(&rq->rt.push_lock);
+		/* Make sure it's still executing */
+		if (rq->rt.push_flags & RT_PUSH_IPI_EXECUTING) {
+			/*
+			 * Tell the IPI to restart the loop as things have
+			 * changed since it started.
+			 */
+			rq->rt.push_flags |= RT_PUSH_IPI_RESTART;
+			raw_spin_unlock(&rq->rt.push_lock);
+			return;
+		}
+		raw_spin_unlock(&rq->rt.push_lock);
+	}
+
+	/* When here, there's no IPI going around */
+
+	rq->rt.push_cpu = rq->cpu;
+	cpu = find_next_push_cpu(rq);
+	if (cpu >= nr_cpu_ids)
+		return;
+
+	rq->rt.push_flags = RT_PUSH_IPI_EXECUTING;
+
+	irq_work_queue_on(&rq->rt.push_work, cpu);
+}
+
+/* Called from hardirq context */
+static void try_to_push_tasks(void *arg)
+{
+	struct rt_rq *rt_rq = arg;
+	struct rq *rq, *src_rq;
+	int this_cpu;
+	int cpu;
+
+	this_cpu = rt_rq->push_cpu;
+
+	/* Paranoid check */
+	BUG_ON(this_cpu != smp_processor_id());
+
+	rq = cpu_rq(this_cpu);
+	src_rq = rq_of_rt_rq(rt_rq);
+
+again:
+	if (has_pushable_tasks(rq)) {
+		raw_spin_lock(&rq->lock);
+		push_rt_task(rq);
+		raw_spin_unlock(&rq->lock);
+	}
+
+	/* Pass the IPI to the next rt overloaded queue */
+	raw_spin_lock(&rt_rq->push_lock);
+	/*
+	 * If the source queue changed since the IPI went out,
+	 * we need to restart the search from that CPU again.
+	 */
+	if (rt_rq->push_flags & RT_PUSH_IPI_RESTART) {
+		rt_rq->push_flags &= ~RT_PUSH_IPI_RESTART;
+		rt_rq->push_cpu = src_rq->cpu;
+	}
+
+	cpu = find_next_push_cpu(src_rq);
+
+	if (cpu >= nr_cpu_ids)
+		rt_rq->push_flags &= ~RT_PUSH_IPI_EXECUTING;
+	raw_spin_unlock(&rt_rq->push_lock);
+
+	if (cpu >= nr_cpu_ids)
+		return;
+
+	/*
+	 * It is possible that a restart caused this CPU to be
+	 * chosen again. Don't bother with an IPI, just see if we
+	 * have more to push.
+	 */
+	if (unlikely(cpu == rq->cpu))
+		goto again;
+
+	/* Try the next RT overloaded CPU */
+	irq_work_queue_on(&rt_rq->push_work, cpu);
+}
+
+static void push_irq_work_func(struct irq_work *work)
+{
+	struct rt_rq *rt_rq = container_of(work, struct rt_rq, push_work);
+
+	try_to_push_tasks(rt_rq);
+}
+#endif /* HAVE_RT_PUSH_IPI */
+
 static int pull_rt_task(struct rq *this_rq)
 {
 	int this_cpu = this_rq->cpu, ret = 0, cpu;
@@ -1793,6 +1963,13 @@ static int pull_rt_task(struct rq *this_
 	 */
 	smp_rmb();
 
+#ifdef HAVE_RT_PUSH_IPI
+	if (sched_feat(RT_PUSH_IPI)) {
+		tell_cpu_to_push(this_rq);
+		return 0;
+	}
+#endif
+
 	for_each_cpu(cpu, this_rq->rd->rto_mask) {
 		if (this_cpu == cpu)
 			continue;
Index: linux-rt.git/kernel/sched/sched.h
===================================================================
--- linux-rt.git.orig/kernel/sched/sched.h	2015-03-18 14:16:26.773346008 -0400
+++ linux-rt.git/kernel/sched/sched.h	2015-03-18 14:17:08.921810092 -0400
@@ -6,6 +6,7 @@
 #include <linux/mutex.h>
 #include <linux/spinlock.h>
 #include <linux/stop_machine.h>
+#include <linux/irq_work.h>
 #include <linux/tick.h>
 #include <linux/slab.h>
 
@@ -418,6 +419,11 @@ static inline int rt_bandwidth_enabled(v
 	return sysctl_sched_rt_runtime >= 0;
 }
 
+/* RT IPI pull logic requires IRQ_WORK */
+#ifdef CONFIG_IRQ_WORK
+# define HAVE_RT_PUSH_IPI
+#endif
+
 /* Real-Time classes' related field in a runqueue: */
 struct rt_rq {
 	struct rt_prio_array active;
@@ -435,7 +441,13 @@ struct rt_rq {
 	unsigned long rt_nr_total;
 	int overloaded;
 	struct plist_head pushable_tasks;
+#ifdef HAVE_RT_PUSH_IPI
+	int push_flags;
+	int push_cpu;
+	struct irq_work push_work;
+	raw_spinlock_t push_lock;
 #endif
+#endif /* CONFIG_SMP */
 	int rt_queued;
 
 	int rt_throttled;
Index: linux-rt.git/kernel/sched/features.h
===================================================================
--- linux-rt.git.orig/kernel/sched/features.h	2015-03-18 14:16:26.773346008 -0400
+++ linux-rt.git/kernel/sched/features.h	2015-03-18 14:17:08.922810079 -0400
@@ -56,6 +56,19 @@ SCHED_FEAT(NONTASK_CAPACITY, true)
  */
 SCHED_FEAT(TTWU_QUEUE, true)
 
+#ifdef HAVE_RT_PUSH_IPI
+/*
+ * In order to avoid a thundering herd attack of CPUs that are
+ * lowering their priorities at the same time, and there being
+ * a single CPU that has an RT task that can migrate and is waiting
+ * to run, where the other CPUs will try to take that CPUs
+ * rq lock and possibly create a large contention, sending an
+ * IPI to that CPU and let that CPU push the RT task to where
+ * it should go may be a better scenario.
+ */
+SCHED_FEAT(RT_PUSH_IPI, true)
+#endif
+
 SCHED_FEAT(FORCE_SD_OVERLAP, false)
 SCHED_FEAT(RT_RUNTIME_SHARE, true)
 SCHED_FEAT(LB_MIN, false)
