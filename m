From: Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC][PATCH v2] sched/rt: Use IPI to trigger RT task push migration
 instead of pulling
Date: Tue, 24 Feb 2015 13:39:46 -0500
Message-ID: <20150224133946.3948c4b7@gandalf.local.home>
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
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


When debugging the latencies on a 40 core box, where we hit 300 to
500 microsecond latencies, I found there was a huge contention on the
runqueue locks.

Investigating it further, running ftrace, I found that it was due to
the pulling of RT tasks.

The test that was run was the following:

 cyclictest --numa -p95 -m -d0 -i100

This created a thread on each CPU, that would set its wakeup in interations
of 100 microseconds. The -d0 means that all the threads had the same
interval (100us). Each thread sleeps for 100us and wakes up and measures
its latencies.

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
rq locks. As these locks were blocked, any wakeups or load balanceing
on these CPUs would also block on these locks, and the wait time escalated.

I've tried various methods to lesson the load, but things like an
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
could be lots of overloaded RT queues and on CPU lowers its priority. It would
then send an IPI to all the overloaded RT queues and they could then all try
to grab the rq lock of the CPU lowering its priority, and then we have the
same problem.

To avoid this, the CPU lowering its priority finds the highest rq in the RT
overloaded mask, and sends out a single IPI to that queue. If that rq can not
push a task, it will then look for other overloaded RT queues and send an IPI
to the next highest one that is lower than its priority (using irq work queues).
It ignores rqs that have a higher priority because that could cause an infinite
ping pong affect if the rqs could not migrate a task due to affinity. By limiting
it to only rqs of lower priority, the IPI should never hit the same CPU twice
(unless the rq itself did change, but still, it is limited by the priority of the
rq that originally lowered its prio, and the highest priority of the time it was
sent). There is no unbounded check here even if the state of the system constantly
changes.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

---
Changes since V1:

 o As already mentioned in the "update", a redesign was done to send
   only one IPI, and to the highest rt overloaded queue. If for some
   reason that could not push a task, it would look for the next rq and
   send an ipi (irq work actually) to the next one. Limits are in place
   to prevent any ping pong affect of two rqs sending IPIs back and
   forth.

 o Made this sched feature enabled by default instead of enabling it
   when we have 16 or more CPUs.

 kernel/sched/features.h |   11 ++
 kernel/sched/rt.c       |  202 ++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h    |    6 +
 3 files changed, 219 insertions(+)

Index: linux-rt.git/kernel/sched/rt.c
===================================================================
--- linux-rt.git.orig/kernel/sched/rt.c	2015-02-24 10:44:08.798785452 -0500
+++ linux-rt.git/kernel/sched/rt.c	2015-02-24 13:07:20.154735448 -0500
@@ -6,6 +6,7 @@
 #include "sched.h"
 
 #include <linux/slab.h>
+#include <linux/irq_work.h>
 
 int sched_rr_timeslice = RR_TIMESLICE;
 
@@ -59,6 +60,11 @@ static void start_rt_bandwidth(struct rt
 	raw_spin_unlock(&rt_b->rt_runtime_lock);
 }
 
+#ifdef CONFIG_SMP
+static void try_to_push_tasks(void *arg);
+static void push_irq_work_func(struct irq_work *work);
+#endif
+
 void init_rt_rq(struct rt_rq *rt_rq, struct rq *rq)
 {
 	struct rt_prio_array *array;
@@ -78,6 +84,11 @@ void init_rt_rq(struct rt_rq *rt_rq, str
 	rt_rq->rt_nr_migratory = 0;
 	rt_rq->overloaded = 0;
 	plist_head_init(&rt_rq->pushable_tasks);
+
+	rt_rq->push_csd.flags = 0;
+	rt_rq->push_csd.func = try_to_push_tasks;
+	rt_rq->push_csd.info = rt_rq;
+	init_irq_work(&rt_rq->push_csd_work, push_irq_work_func);
 #endif
 	/* We start is dequeued state, because no RT tasks are queued */
 	rt_rq->rt_queued = 0;
@@ -1760,11 +1771,171 @@ static void push_rt_tasks(struct rq *rq)
 		;
 }
 
+static void tell_cpu_to_push(int cpu, struct rq *rq, int prio)
+{
+	/* We should never be here if the IPI is already out. */
+	BUG_ON(rq->rt.push_csd_pending);
+
+	rq->rt.push_csd_pending = 1;
+	rq->rt.push_csd_cpu = cpu;
+	/* Save the prio that we used to find this CPU */
+	rq->rt.push_csd_prio = prio;
+
+	/* Make sure csd_cpu is visible before we send the ipi */
+	smp_mb();
+
+	smp_call_function_single_async(cpu, &rq->rt.push_csd);
+}
+
+static void try_to_push_tasks(void *arg)
+{
+	struct rt_rq *rt_rq = arg;
+	struct rq *rq, *next_rq;
+	int next_cpu = -1;
+	int next_prio = MAX_PRIO + 1;
+	int this_prio;
+	int src_prio;
+	int prio;
+	int this_cpu;
+	int success;
+	int cpu;
+
+	/* Make sure we can see csd_cpu */
+	smp_rmb();
+
+	this_cpu = rt_rq->push_csd_cpu;
+
+	/* Paranoid check */
+	BUG_ON(this_cpu != smp_processor_id());
+
+	rq = cpu_rq(this_cpu);
+
+	/*
+	 * If there's nothing to push here, then see if another queue
+	 * can push instead.
+	 */
+	if (!has_pushable_tasks(rq))
+		goto pass_the_ipi;
+
+	raw_spin_lock(&rq->lock);
+	success = push_rt_task(rq);
+	raw_spin_unlock(&rq->lock);
+
+	if (success)
+		goto done;
+
+	/* Nothing was pushed, try another queue */
+pass_the_ipi:
+
+	/*
+	 * We use the priority that determined to send to this CPU
+	 * even if the priority for this CPU changed. This is used
+	 * to determine what other CPUs to send to, to keep from
+	 * doing a ping pong from each CPU.
+	 */
+	this_prio = rt_rq->push_csd_prio;
+	src_prio = rt_rq->highest_prio.curr;
+
+	for_each_cpu(cpu, rq->rd->rto_mask) {
+		if (this_cpu == cpu)
+			continue;
+
+		/*
+		 * This function was called because some rq lowered its
+		 * priority. It then searched for the highest priority
+		 * rq that had overloaded tasks and sent an smp function
+		 * call to that cpu to call this function to push its
+		 * tasks. But when it got here, the task was either
+		 * already pushed, or due to affinity, could not move
+		 * the overloaded task.
+		 *
+		 * Now we need to see if there's another overloaded rq that
+		 * has an RT task that can migrate to that CPU.
+		 *
+		 * We need to be careful, we do not want to cause a ping
+		 * pong between this CPU and another CPU that has an RT task
+		 * that can migrate, but not to the CPU that lowered its
+		 * priority. Since the lowering priority CPU finds the highest
+		 * priority rq to send to, we will ignore any rq that is of higher
+		 * priority than this current one. That is, if a rq scheduled a
+		 * task of higher priority, the schedule itself would do the
+		 * push or pull then. We can safely ignore higher priority rqs.
+		 * And if there's one that is the same priority, since the CPUS
+		 * are searched in order we will ignore CPUS of the same priority
+		 * unless the CPU number is greater than this CPU's number.
+		 */
+		next_rq = cpu_rq(cpu);
+
+		/* Use a single read for the next prio for decision making */
+		prio = READ_ONCE(next_rq->rt.highest_prio.next);
+
+		/* Looking for highest priority */
+		if (prio >= next_prio)
+			continue;
+
+		/* Make sure that the rq can push to the source rq */
+		if (prio >= src_prio)
+			continue;
+
+		/* If the prio is higher than the current prio, ignore it */
+		if (prio < this_prio)
+			continue;
+
+		/*
+		 * If the prio is equal to the current prio, only use it
+		 * if the cpu number is greater than the current cpu.
+		 * This prevents a ping pong effect.
+		 */
+		if (prio == this_prio && cpu < this_cpu)
+			continue;
+
+		next_prio = prio;
+		next_cpu = cpu;
+	}
+
+	/* Nothing found, do nothing */
+	if (next_cpu < 0)
+		goto done;
+
+	/*
+	 * Now we can not send another smp async function due to locking,
+	 * use irq_work instead.
+	 */
+
+	rt_rq->push_csd_cpu = next_cpu;
+	rt_rq->push_csd_prio = next_prio;
+
+	/* Make sure the next cpu is seen on remote CPU */
+	smp_mb();
+
+	irq_work_queue_on(&rt_rq->push_csd_work, next_cpu);
+
+	return;
+
+done:
+	rt_rq->push_csd_pending = 0;
+
+	/* Now make sure the src CPU can see this update */
+	smp_wmb();
+}
+
+static void push_irq_work_func(struct irq_work *work)
+{
+	struct rt_rq *rt_rq = container_of(work, struct rt_rq, push_csd_work);
+
+	try_to_push_tasks(rt_rq);
+}
+
 static int pull_rt_task(struct rq *this_rq)
 {
 	int this_cpu = this_rq->cpu, ret = 0, cpu;
 	struct task_struct *p;
 	struct rq *src_rq;
+	bool push_pending = false;
+	bool use_ipi;
+	int next_cpu = -1;
+	int next_prio = MAX_PRIO + 1;
+	int src_prio;
 
 	if (likely(!rt_overloaded(this_rq)))
 		return 0;
@@ -1775,6 +1946,15 @@ static int pull_rt_task(struct rq *this_
 	 */
 	smp_rmb();
 
+	/* Use local just in case a feature is switched in the middle of this */
+	if ((use_ipi = sched_feat(RT_PUSH_IPI))) {
+		/* Make sure the update to pending is visible here. */
+		smp_rmb();
+
+		/* If a push ipi is out, then we must do the old method */
+		push_pending = READ_ONCE(this_rq->rt.push_csd_pending);
+	}
+
 	for_each_cpu(cpu, this_rq->rd->rto_mask) {
 		if (this_cpu == cpu)
 			continue;
@@ -1793,6 +1973,26 @@ static int pull_rt_task(struct rq *this_
 			continue;
 
 		/*
+		 * When the RT_PUSH_IPI sched feature is enabled, instead
+		 * of trying to grab the rq lock of the RT overloaded CPU
+		 * send an IPI to that CPU instead. This prevents heavy
+		 * contention from several CPUs lowering its priority
+		 * and all trying to grab the rq lock of that overloaded CPU.
+		 */
+		if (use_ipi && !push_pending) {
+			/*
+			 * We need to make sure the prio we use for comparisons
+			 * is the same throughout.
+			 */
+			src_prio = READ_ONCE(src_rq->rt.highest_prio.next);
+			if (src_prio < next_prio) {
+				next_prio = src_prio;
+				next_cpu = cpu;
+			}
+			continue;
+		}
+
+		/*
 		 * We can potentially drop this_rq's lock in
 		 * double_lock_balance, and another CPU could
 		 * alter this_rq
@@ -1839,6 +2039,8 @@ static int pull_rt_task(struct rq *this_
 skip:
 		double_unlock_balance(this_rq, src_rq);
 	}
+	if (use_ipi && !push_pending && next_cpu >= 0)
+		tell_cpu_to_push(next_cpu, this_rq, next_prio);
 
 	return ret;
 }
Index: linux-rt.git/kernel/sched/sched.h
===================================================================
--- linux-rt.git.orig/kernel/sched/sched.h	2015-02-24 10:44:08.798785452 -0500
+++ linux-rt.git/kernel/sched/sched.h	2015-02-24 11:58:25.799436421 -0500
@@ -6,6 +6,7 @@
 #include <linux/mutex.h>
 #include <linux/spinlock.h>
 #include <linux/stop_machine.h>
+#include <linux/irq_work.h>
 #include <linux/tick.h>
 #include <linux/slab.h>
 
@@ -435,6 +436,11 @@ struct rt_rq {
 	unsigned long rt_nr_total;
 	int overloaded;
 	struct plist_head pushable_tasks;
+	struct call_single_data push_csd;
+	int push_csd_pending;
+	int push_csd_cpu;
+	int push_csd_prio;
+	struct irq_work push_csd_work;
 #endif
 	int rt_queued;
 
Index: linux-rt.git/kernel/sched/features.h
===================================================================
--- linux-rt.git.orig/kernel/sched/features.h	2015-02-24 10:44:08.798785452 -0500
+++ linux-rt.git/kernel/sched/features.h	2015-02-24 13:06:20.471596597 -0500
@@ -56,6 +56,17 @@ SCHED_FEAT(NONTASK_CAPACITY, true)
  */
 SCHED_FEAT(TTWU_QUEUE, true)
 
+/*
+ * In order to avoid a thundering herd attack of CPUS that are
+ * lowering their priorities at the same time, and there being
+ * a single CPU that has an RT task that can migrate and is waiting
+ * to run, where the other CPUs will try to take that CPUs
+ * rq lock and possibly create a large contention, sending an
+ * IPI to that CPU and let that CPU push the RT task to where
+ * it should go may be a better scenario.
+ */
+SCHED_FEAT(RT_PUSH_IPI, true)
+
 SCHED_FEAT(FORCE_SD_OVERLAP, false)
 SCHED_FEAT(RT_RUNTIME_SHARE, true)
 SCHED_FEAT(LB_MIN, false)
