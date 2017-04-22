From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH tip/sched/core] sched/rt: Simplify the IPI rt
 balancing logic
Date: Sat, 22 Apr 2017 14:41:52 -0400
Message-ID: <20170422144152.2a9fc2e1@gandalf.local.home>
References: <20170421224929.1a4bbeec@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:48390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1426524AbdDVSmA (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 22 Apr 2017 14:42:00 -0400
In-Reply-To: <20170421224929.1a4bbeec@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

[
  Here's a back port of my IPI simplified patch for 4.9.20-rt16.
]

When a CPU lowers its priority (schedules out a high priority task for a
lower priority one), a check is made to see if any other CPU has overloaded
RT tasks (more than one). It checks the rto_mask to determine this and if so
it will request to pull one of those tasks to itself if the non running RT
task is of higher priority than the new priority of the next task to run on
the current CPU.

When we deal with large number of CPUs, the original pull logic suffered
from large lock contention on a single CPU run queue, which caused a huge
latency across all CPUs. This was caused by only having one CPU having
overloaded RT tasks and a bunch of other CPUs lowering their priority. To
solve this issue, commit b6366f048e0c ("sched/rt: Use IPI to trigger RT task
push migration instead of pulling") changed the way to request a pull.
Instead of grabbing the lock of the overloaded CPU's runqueue, it simply
sent an IPI to that CPU to do the work.

Although the IPI logic worked very well in removing the large latency build
up, it still could suffer from a large number of IPIs being sent to a single
CPU. On a 80 CPU box, I measured over 200us of processing IPIs. Worse yet,
when I tested this on a 120 CPU box, with a stress test that had lots of
RT tasks scheduling on all CPUs, it actually triggered the hard lockup
detector! One CPU had so many IPIs sent to it, and due to the restart
mechanism, of if a source run queue changes status, the CPU spent minutes!
processing the IPIs.

Thinking about this further, I realized there's no reason for each run queue
to send its own IPI. As all CPUs with overloaded tasks must be scanned
regardless if there's one or many CPUs lowering their priority, because
there's no current way to find the CPU with the highest priority task that
can schedule to one of these CPUs, there really only needs to be one IPI
being sent around at a time.

This greatly simplifies the code!

The new approach is to have each root domain have its own irq work, as the
rto_mask is per root domain. The root domain has the following fields
attached to it:

  rto_push_work	 - the irq work to process each CPU set in rto_mask
  rto_lock	 - the lock to protect some of the other rto fields
  rto_loop_start - an atomic that keeps contention down on rto_lock
		    the first CPU scheduling in a lower priority task
		    is the one to kick off the process.
  rto_loop_next	 - an atomic that gets incremented for each CPU that
		    schedules in a lower priority task.
  rto_loop	 - a variable protected by rto_lock that is used to
		    compare against rto_loop_next
  rto_cpu	 - The cpu to send the next IPI to.

When a CPU schedules in a lower priority task and wants to make sure
overloaded CPUs know about it. It increments the rto_loop_next. Then it does
an atomic_inc_return() on rto_loop_start. If the returned value is not "1",
then it does atomic_dec() on rt_loop_start and returns. If the value is "1",
then it will take the rto_lock to synchronize with a possible IPI being sent
around to the overloaded CPUs.

If rto_cpu is greater than or equal to nr_cpu_ids, then there's either no
IPI being sent around, or one is about to finish. Then rto_cpu is set to the
first CPU in rto_mask and an IPI is sent to that CPU. If there's no CPUs set
in rto_mask, then there's nothing to be done.

When the CPU receives the IPI, it will first try to push any RT task that is
queued on the CPU but can't run because a higher priority RT task is
currently running on the CPU.

Then it takes the rto_lock and looks for the next CPU in the rto_mask. If it
finds one, it simply sends an IPI to that CPU and the process continues.

If there's no more CPUs in the rto_mask, then rto_loop is compared with
rto_loop_next. If they match, everything is done and the process is over. If
they do not match, then a CPU scheduled in a lower priority task as the IPI
was being passed around, and the process needs to start again. The first CPU
in rto_mask is sent the IPI.

This change removes duplication of work in the IPI logic, and greatly
lowers the latency caused by the IPIs. This removed the lockup happening on
the 120 CPU machine. It also simplifies the code tremendously. What else
could anyone ask for?

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
Index: linux-rt.git/kernel/sched/rt.c
===================================================================
--- linux-rt.git.orig/kernel/sched/rt.c
+++ linux-rt.git/kernel/sched/rt.c
@@ -73,10 +73,6 @@ static void start_rt_bandwidth(struct rt
 	raw_spin_unlock(&rt_b->rt_runtime_lock);
 }
 
-#if defined(CONFIG_SMP) && defined(HAVE_RT_PUSH_IPI)
-static void push_irq_work_func(struct irq_work *work);
-#endif
-
 void init_rt_rq(struct rt_rq *rt_rq)
 {
 	struct rt_prio_array *array;
@@ -96,14 +92,6 @@ void init_rt_rq(struct rt_rq *rt_rq)
 	rt_rq->rt_nr_migratory = 0;
 	rt_rq->overloaded = 0;
 	plist_head_init(&rt_rq->pushable_tasks);
-
-#ifdef HAVE_RT_PUSH_IPI
-	rt_rq->push_flags = 0;
-	rt_rq->push_cpu = nr_cpu_ids;
-	raw_spin_lock_init(&rt_rq->push_lock);
-	init_irq_work(&rt_rq->push_work, push_irq_work_func);
-	rt_rq->push_work.flags |= IRQ_WORK_HARD_IRQ;
-#endif
 #endif /* CONFIG_SMP */
 	/* We start is dequeued state, because no RT tasks are queued */
 	rt_rq->rt_queued = 0;
@@ -1866,160 +1854,150 @@ static void push_rt_tasks(struct rq *rq)
 }
 
 #ifdef HAVE_RT_PUSH_IPI
+
 /*
- * The search for the next cpu always starts at rq->cpu and ends
- * when we reach rq->cpu again. It will never return rq->cpu.
- * This returns the next cpu to check, or nr_cpu_ids if the loop
- * is complete.
+ * When a high priority task schedules out from a CPU and a lower priority
+ * task is scheduled in, a check is made to see if there's any RT tasks
+ * on other CPUs that are waiting to run because a higher priority RT task
+ * is currently running on its CPU. In this case, the CPU with multiple RT
+ * tasks queued on it (overloaded) needs to be notified that a CPU has opened
+ * up that may be able to run one of its non-running queued RT tasks.
+ *
+ * All CPUs with overloaded RT tasks need to be notified as there is currently
+ * no way to know which of these CPUs have the highest priority task waiting
+ * to run. Instead of trying to take a spinlock on each of these CPUs,
+ * which has shown to cause large latency when done on machines with many
+ * CPUs, sending an IPI to the CPUs to have them push off the overloaded
+ * RT tasks waiting to run.
+ *
+ * Just sending an IPI to each of the CPUs is also an issue, as on large
+ * count CPU machines, this can cause an IPI storm on a CPU, especially
+ * if its the only CPU with multiple RT tasks queued, and a large number
+ * of CPUs scheduling a lower priority task at the same time.
+ *
+ * Each root domain has its own irq work function that can iterate over
+ * all CPUs with RT overloaded tasks. Since all CPUs with overloaded RT
+ * tassk must be checked if there's one or many CPUs that are lowering
+ * their priority, there's a single irq work iterator that will try to
+ * push off RT tasks that are waiting to run.
+ *
+ * When a CPU schedules a lower priority task, it will kick off the
+ * irq work iterator that will jump to each CPU with overloaded RT tasks.
+ * As it only takes the first CPU that schedules a lower priority task
+ * to start the process, the rto_start variable is incremented and if
+ * the atomic result is one, then that CPU will try to take the rto_lock.
+ * This prevents high contention on the lock as the process handles all
+ * CPUs scheduling lower priority tasks.
+ *
+ * All CPUs that are scheduling a lower priority task will increment the
+ * rt_loop_next variable. This will make sure that the irq work iterator
+ * checks all RT overloaded CPUs whenever a CPU schedules a new lower
+ * priority task, even if the iterator is in the middle of a scan. Incrementing
+ * the rt_loop_next will cause the iterator to perform another scan.
  *
- * rq->rt.push_cpu holds the last cpu returned by this function,
- * or if this is the first instance, it must hold rq->cpu.
  */
 static int rto_next_cpu(struct rq *rq)
 {
-	int prev_cpu = rq->rt.push_cpu;
 	int cpu;
 
-	cpu = cpumask_next(prev_cpu, rq->rd->rto_mask);
-
 	/*
-	 * If the previous cpu is less than the rq's CPU, then it already
-	 * passed the end of the mask, and has started from the beginning.
-	 * We end if the next CPU is greater or equal to rq's CPU.
+	 * When starting the IPI RT pushing, the rto_cpu is set to nr_cpu_ids
+	 * or greater. rt_next_cpu() will simply return the first CPU found in
+	 * the rto_mask.
+	 *
+	 * If rto_next_cpu() is called with rto_cpu less than nr_cpu_ids, it
+	 * will return the next CPU found in the rto_mask.
+	 *
+	 * If there are no more CPUs left in the rto_mask, then a check is made
+	 * against rto_loop and rto_loop_next. rto_loop is only updated with
+	 * the rto_lock held, but any CPU may increment the rto_loop_next
+	 * without any locking.
 	 */
-	if (prev_cpu < rq->cpu) {
-		if (cpu >= rq->cpu)
-			return nr_cpu_ids;
-
-	} else if (cpu >= nr_cpu_ids) {
-		/*
-		 * We passed the end of the mask, start at the beginning.
-		 * If the result is greater or equal to the rq's CPU, then
-		 * the loop is finished.
-		 */
+again:
+	if (rq->rd->rto_cpu >= nr_cpu_ids) {
 		cpu = cpumask_first(rq->rd->rto_mask);
-		if (cpu >= rq->cpu)
-			return nr_cpu_ids;
+		rq->rd->rto_cpu = cpu;
+		/* If cpu is nr_cpu_ids, then there is no overloaded rqs */
+		return cpu;
 	}
-	rq->rt.push_cpu = cpu;
-
-	/* Return cpu to let the caller know if the loop is finished or not */
-	return cpu;
-}
 
-static int find_next_push_cpu(struct rq *rq)
-{
-	struct rq *next_rq;
-	int cpu;
+	cpu = cpumask_next(rq->rd->rto_cpu, rq->rd->rto_mask);
+	rq->rd->rto_cpu = cpu;
 
-	while (1) {
-		cpu = rto_next_cpu(rq);
-		if (cpu >= nr_cpu_ids)
-			break;
-		next_rq = cpu_rq(cpu);
+	if (cpu < nr_cpu_ids)
+		return cpu;
 
-		/* Make sure the next rq can push to this rq */
-		if (next_rq->rt.highest_prio.next < rq->rt.highest_prio.curr)
-			break;
-	}
+	if (rq->rd->rto_loop == atomic_read(&rq->rd->rto_loop_next))
+		return cpu;
 
-	return cpu;
+	rq->rd->rto_loop = atomic_read(&rq->rd->rto_loop_next);
+	goto again;
 }
 
-#define RT_PUSH_IPI_EXECUTING		1
-#define RT_PUSH_IPI_RESTART		2
-
 static void tell_cpu_to_push(struct rq *rq)
 {
-	int cpu;
+	int start;
+	int cpu = nr_cpu_ids;
 
-	if (rq->rt.push_flags & RT_PUSH_IPI_EXECUTING) {
-		raw_spin_lock(&rq->rt.push_lock);
-		/* Make sure it's still executing */
-		if (rq->rt.push_flags & RT_PUSH_IPI_EXECUTING) {
-			/*
-			 * Tell the IPI to restart the loop as things have
-			 * changed since it started.
-			 */
-			rq->rt.push_flags |= RT_PUSH_IPI_RESTART;
-			raw_spin_unlock(&rq->rt.push_lock);
-			return;
-		}
-		raw_spin_unlock(&rq->rt.push_lock);
-	}
+	/* Keep the loop going if the IPI is currently active */
+	atomic_inc_return(&rq->rd->rto_loop_next);
 
-	/* When here, there's no IPI going around */
+	/* Only one CPU can initiate a loop at a time */
+	start = atomic_inc_return(&rq->rd->rto_loop_start);
+	if (start != 1)
+		goto out;
 
-	rq->rt.push_cpu = rq->cpu;
-	cpu = find_next_push_cpu(rq);
-	if (cpu >= nr_cpu_ids)
-		return;
+	raw_spin_lock(&rq->rd->rto_lock);
 
-	rq->rt.push_flags = RT_PUSH_IPI_EXECUTING;
+	/*
+	 * The rto_cpu is updated under the lock, if it has a valid cpu
+	 * then the IPI is still running and will continue due to the
+	 * update to loop_next, and nothing needs to be done here.
+	 * Otherwise it is finishing up and an ipi needs to be sent.
+	 */
+	if (rq->rd->rto_cpu >= nr_cpu_ids)
+		cpu = rto_next_cpu(rq);
 
-	irq_work_queue_on(&rq->rt.push_work, cpu);
+	raw_spin_unlock(&rq->rd->rto_lock);
+
+	if (cpu < nr_cpu_ids)
+		irq_work_queue_on(&rq->rd->rto_push_work, cpu);
+out:
+	atomic_dec(&rq->rd->rto_loop_start);
 }
 
 /* Called from hardirq context */
-static void try_to_push_tasks(void *arg)
+void rto_push_irq_work_func(struct irq_work *work)
 {
-	struct rt_rq *rt_rq = arg;
-	struct rq *rq, *src_rq;
+	struct rq *rq;
 	int this_cpu;
 	int cpu;
 
-	this_cpu = rt_rq->push_cpu;
-
-	/* Paranoid check */
-	BUG_ON(this_cpu != smp_processor_id());
-
+	this_cpu = smp_processor_id();
 	rq = cpu_rq(this_cpu);
-	src_rq = rq_of_rt_rq(rt_rq);
 
-again:
+	/*
+	 * We do not need to grab the lock to check for has_pushable_tasks.
+	 * When it gets updated, a check is made if a push is possible.
+	 */
 	if (has_pushable_tasks(rq)) {
 		raw_spin_lock(&rq->lock);
-		push_rt_task(rq);
+		push_rt_tasks(rq);
 		raw_spin_unlock(&rq->lock);
 	}
 
-	/* Pass the IPI to the next rt overloaded queue */
-	raw_spin_lock(&rt_rq->push_lock);
-	/*
-	 * If the source queue changed since the IPI went out,
-	 * we need to restart the search from that CPU again.
-	 */
-	if (rt_rq->push_flags & RT_PUSH_IPI_RESTART) {
-		rt_rq->push_flags &= ~RT_PUSH_IPI_RESTART;
-		rt_rq->push_cpu = src_rq->cpu;
-	}
+	raw_spin_lock(&rq->rd->rto_lock);
 
-	cpu = find_next_push_cpu(src_rq);
+	/* Pass the IPI to the next rt overloaded queue */
+	cpu = rto_next_cpu(rq);
 
-	if (cpu >= nr_cpu_ids)
-		rt_rq->push_flags &= ~RT_PUSH_IPI_EXECUTING;
-	raw_spin_unlock(&rt_rq->push_lock);
+	raw_spin_unlock(&rq->rd->rto_lock);
 
 	if (cpu >= nr_cpu_ids)
 		return;
 
-	/*
-	 * It is possible that a restart caused this CPU to be
-	 * chosen again. Don't bother with an IPI, just see if we
-	 * have more to push.
-	 */
-	if (unlikely(cpu == rq->cpu))
-		goto again;
-
 	/* Try the next RT overloaded CPU */
-	irq_work_queue_on(&rt_rq->push_work, cpu);
-}
-
-static void push_irq_work_func(struct irq_work *work)
-{
-	struct rt_rq *rt_rq = container_of(work, struct rt_rq, push_work);
-
-	try_to_push_tasks(rt_rq);
+	irq_work_queue_on(&rq->rd->rto_push_work, cpu);
 }
 #endif /* HAVE_RT_PUSH_IPI */
 
Index: linux-rt.git/kernel/sched/sched.h
===================================================================
--- linux-rt.git.orig/kernel/sched/sched.h
+++ linux-rt.git/kernel/sched/sched.h
@@ -457,7 +457,7 @@ static inline int rt_bandwidth_enabled(v
 }
 
 /* RT IPI pull logic requires IRQ_WORK */
-#ifdef CONFIG_IRQ_WORK
+#if defined(CONFIG_IRQ_WORK) && defined(CONFIG_SMP)
 # define HAVE_RT_PUSH_IPI
 #endif
 
@@ -479,12 +479,6 @@ struct rt_rq {
 	unsigned long rt_nr_total;
 	int overloaded;
 	struct plist_head pushable_tasks;
-#ifdef HAVE_RT_PUSH_IPI
-	int push_flags;
-	int push_cpu;
-	struct irq_work push_work;
-	raw_spinlock_t push_lock;
-#endif
 #endif /* CONFIG_SMP */
 	int rt_queued;
 
@@ -566,6 +560,17 @@ struct root_domain {
 	struct dl_bw dl_bw;
 	struct cpudl cpudl;
 
+#ifdef HAVE_RT_PUSH_IPI
+	/*
+	 * For IPI pull requests, loop across the rto_mask.
+	 */
+	struct irq_work rto_push_work;
+	raw_spinlock_t rto_lock;
+	atomic_t rto_loop_next;
+	int rto_loop;
+	atomic_t rto_loop_start;
+	int rto_cpu;
+#endif
 	/*
 	 * The "RT overload" flag: it gets set if a CPU has more than
 	 * one runnable RT task.
@@ -578,6 +583,9 @@ struct root_domain {
 
 extern struct root_domain def_root_domain;
 
+#ifdef HAVE_RT_PUSH_IPI
+extern void rto_push_irq_work_func(struct irq_work *work);
+#endif
 #endif /* CONFIG_SMP */
 
 /*
Index: linux-rt.git/kernel/sched/core.c
===================================================================
--- linux-rt.git.orig/kernel/sched/core.c
+++ linux-rt.git/kernel/sched/core.c
@@ -6121,6 +6121,13 @@ static int init_rootdomain(struct root_d
 	if (!zalloc_cpumask_var(&rd->rto_mask, GFP_KERNEL))
 		goto free_dlo_mask;
 
+#ifdef HAVE_RT_PUSH_IPI
+	rd->rto_cpu = nr_cpu_ids;
+	raw_spin_lock_init(&rd->rto_lock);
+	init_irq_work(&rd->rto_push_work, rto_push_irq_work_func);
+	rd->rto_push_work.flags |= IRQ_WORK_HARD_IRQ;
+#endif
+
 	init_dl_bw(&rd->dl_bw);
 	if (cpudl_init(&rd->cpudl) != 0)
 		goto free_dlo_mask;
