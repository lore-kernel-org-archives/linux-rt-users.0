From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [ANNOUNCE] v4.14.1-rt3
Date: Fri, 24 Nov 2017 21:32:44 +0100
Message-ID: <20171124203244.GA14261@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Dear RT folks!

I'm pleased to announce the v4.14.1-rt3 patch set. 

Changes since v4.14.1-rt2:

  - The "memcontrol Prevent scheduling while atomic in cgroup code"
    caused harm in a 4.4-RT kernel. Uppon investigation it turned out
    that the patch was no longer required and reverting would avoid the
    problem and the old issue won't show up again. Reported by Haiyang HY1
    Tan and patched by Steven Rostedt.

  - A workaround for a deadlock in jbd2 code has been dropped. It
    shouldn't be required since the "device mapper deadlock fix"  in the last
    RT release.

  - Clark Williams reported latency spikes on bigger iron (around 80
    CPUs) caused by IPI based RT balancing logic. A patch from Steven
    Rostedt fixes the problem.

  - Tom Zanussi's "tracing: Inter-event (e.g. latency) support" patch
    has been updated to v6.

  - The hrtimer-softirq rewrite by Anna-Maria has been updated to
    upcoming v4.

Known issues
	None

The delta patch appended at the bottom of this email contains all the
changes except tracing due to the size of the tracing delta. For
complete diff please visit
      https://git.kernel.org/rt/linux-rt-devel/d/v4.14.1-rt3/v4.14.1-rt2

The delta patch against v4.14.1-rt2 can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.14/incr/patch-4.14.1-rt2-rt3.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.14.1-rt3

The RT patch against v4.14.1 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.14/older/patch-4.14.1-rt3.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.14/older/patches-4.14.1-rt3.tar.xz

Sebastian
diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
--- a/fs/jbd2/checkpoint.c
+++ b/fs/jbd2/checkpoint.c
@@ -116,8 +116,6 @@ void __jbd2_log_wait_for_space(journal_t *journal)
 	nblocks = jbd2_space_needed(journal);
 	while (jbd2_log_space_left(journal) < nblocks) {
 		write_unlock(&journal->j_state_lock);
-		if (current->plug)
-			io_schedule();
 		mutex_lock(&journal->j_checkpoint_mutex);
 
 		/*
diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -110,6 +110,7 @@ enum hrtimer_restart {
  * @base:	pointer to the timer base (per cpu and per clock)
  * @state:	state information (See bit values above)
  * @is_rel:	Set if the timer was armed relative
+ * @is_soft:	Set if hrtimer will be expired in soft interrupt context.
  *
  * The hrtimer structure must be initialized by hrtimer_init()
  */
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -74,10 +74,6 @@ static void start_rt_bandwidth(struct rt_bandwidth *rt_b)
 	raw_spin_unlock(&rt_b->rt_runtime_lock);
 }
 
-#if defined(CONFIG_SMP) && defined(HAVE_RT_PUSH_IPI)
-static void push_irq_work_func(struct irq_work *work);
-#endif
-
 void init_rt_rq(struct rt_rq *rt_rq)
 {
 	struct rt_prio_array *array;
@@ -97,14 +93,6 @@ void init_rt_rq(struct rt_rq *rt_rq)
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
@@ -1877,68 +1865,6 @@ static void push_rt_tasks(struct rq *rq)
 }
 
 #ifdef HAVE_RT_PUSH_IPI
-/*
- * The search for the next cpu always starts at rq->cpu and ends
- * when we reach rq->cpu again. It will never return rq->cpu.
- * This returns the next cpu to check, or nr_cpu_ids if the loop
- * is complete.
- *
- * rq->rt.push_cpu holds the last cpu returned by this function,
- * or if this is the first instance, it must hold rq->cpu.
- */
-static int rto_next_cpu(struct rq *rq)
-{
-	int prev_cpu = rq->rt.push_cpu;
-	int cpu;
-
-	cpu = cpumask_next(prev_cpu, rq->rd->rto_mask);
-
-	/*
-	 * If the previous cpu is less than the rq's CPU, then it already
-	 * passed the end of the mask, and has started from the beginning.
-	 * We end if the next CPU is greater or equal to rq's CPU.
-	 */
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
-		cpu = cpumask_first(rq->rd->rto_mask);
-		if (cpu >= rq->cpu)
-			return nr_cpu_ids;
-	}
-	rq->rt.push_cpu = cpu;
-
-	/* Return cpu to let the caller know if the loop is finished or not */
-	return cpu;
-}
-
-static int find_next_push_cpu(struct rq *rq)
-{
-	struct rq *next_rq;
-	int cpu;
-
-	while (1) {
-		cpu = rto_next_cpu(rq);
-		if (cpu >= nr_cpu_ids)
-			break;
-		next_rq = cpu_rq(cpu);
-
-		/* Make sure the next rq can push to this rq */
-		if (next_rq->rt.highest_prio.next < rq->rt.highest_prio.curr)
-			break;
-	}
-
-	return cpu;
-}
-
-#define RT_PUSH_IPI_EXECUTING		1
-#define RT_PUSH_IPI_RESTART		2
 
 /*
  * When a high priority task schedules out from a CPU and a lower priority
@@ -1948,170 +1874,157 @@ static int find_next_push_cpu(struct rq *rq)
  * tasks queued on it (overloaded) needs to be notified that a CPU has opened
  * up that may be able to run one of its non-running queued RT tasks.
  *
- * On large CPU boxes, there's the case that several CPUs could schedule
- * a lower priority task at the same time, in which case it will look for
- * any overloaded CPUs that it could pull a task from. To do this, the runqueue
- * lock must be taken from that overloaded CPU. Having 10s of CPUs all fighting
- * for a single overloaded CPU's runqueue lock can produce a large latency.
- * (This has actually been observed on large boxes running cyclictest).
- * Instead of taking the runqueue lock of the overloaded CPU, each of the
- * CPUs that scheduled a lower priority task simply sends an IPI to the
- * overloaded CPU. An IPI is much cheaper than taking an runqueue lock with
- * lots of contention. The overloaded CPU will look to push its non-running
- * RT task off, and if it does, it can then ignore the other IPIs coming
- * in, and just pass those IPIs off to any other overloaded CPU.
+ * All CPUs with overloaded RT tasks need to be notified as there is currently
+ * no way to know which of these CPUs have the highest priority task waiting
+ * to run. Instead of trying to take a spinlock on each of these CPUs,
+ * which has shown to cause large latency when done on machines with many
+ * CPUs, sending an IPI to the CPUs to have them push off the overloaded
+ * RT tasks waiting to run.
  *
- * When a CPU schedules a lower priority task, it only sends an IPI to
- * the "next" CPU that has overloaded RT tasks. This prevents IPI storms,
- * as having 10 CPUs scheduling lower priority tasks and 10 CPUs with
- * RT overloaded tasks, would cause 100 IPIs to go out at once.
+ * Just sending an IPI to each of the CPUs is also an issue, as on large
+ * count CPU machines, this can cause an IPI storm on a CPU, especially
+ * if its the only CPU with multiple RT tasks queued, and a large number
+ * of CPUs scheduling a lower priority task at the same time.
  *
- * The overloaded RT CPU, when receiving an IPI, will try to push off its
- * overloaded RT tasks and then send an IPI to the next CPU that has
- * overloaded RT tasks. This stops when all CPUs with overloaded RT tasks
- * have completed. Just because a CPU may have pushed off its own overloaded
- * RT task does not mean it should stop sending the IPI around to other
- * overloaded CPUs. There may be another RT task waiting to run on one of
- * those CPUs that are of higher priority than the one that was just
- * pushed.
+ * Each root domain has its own irq work function that can iterate over
+ * all CPUs with RT overloaded tasks. Since all CPUs with overloaded RT
+ * tassk must be checked if there's one or many CPUs that are lowering
+ * their priority, there's a single irq work iterator that will try to
+ * push off RT tasks that are waiting to run.
  *
- * An optimization that could possibly be made is to make a CPU array similar
- * to the cpupri array mask of all running RT tasks, but for the overloaded
- * case, then the IPI could be sent to only the CPU with the highest priority
- * RT task waiting, and that CPU could send off further IPIs to the CPU with
- * the next highest waiting task. Since the overloaded case is much less likely
- * to happen, the complexity of this implementation may not be worth it.
- * Instead, just send an IPI around to all overloaded CPUs.
+ * When a CPU schedules a lower priority task, it will kick off the
+ * irq work iterator that will jump to each CPU with overloaded RT tasks.
+ * As it only takes the first CPU that schedules a lower priority task
+ * to start the process, the rto_start variable is incremented and if
+ * the atomic result is one, then that CPU will try to take the rto_lock.
+ * This prevents high contention on the lock as the process handles all
+ * CPUs scheduling lower priority tasks.
  *
- * The rq->rt.push_flags holds the status of the IPI that is going around.
- * A run queue can only send out a single IPI at a time. The possible flags
- * for rq->rt.push_flags are:
+ * All CPUs that are scheduling a lower priority task will increment the
+ * rt_loop_next variable. This will make sure that the irq work iterator
+ * checks all RT overloaded CPUs whenever a CPU schedules a new lower
+ * priority task, even if the iterator is in the middle of a scan. Incrementing
+ * the rt_loop_next will cause the iterator to perform another scan.
  *
- *    (None or zero):		No IPI is going around for the current rq
- *    RT_PUSH_IPI_EXECUTING:	An IPI for the rq is being passed around
- *    RT_PUSH_IPI_RESTART:	The priority of the running task for the rq
- *				has changed, and the IPI should restart
- *				circulating the overloaded CPUs again.
- *
- * rq->rt.push_cpu contains the CPU that is being sent the IPI. It is updated
- * before sending to the next CPU.
- *
- * Instead of having all CPUs that schedule a lower priority task send
- * an IPI to the same "first" CPU in the RT overload mask, they send it
- * to the next overloaded CPU after their own CPU. This helps distribute
- * the work when there's more than one overloaded CPU and multiple CPUs
- * scheduling in lower priority tasks.
- *
- * When a rq schedules a lower priority task than what was currently
- * running, the next CPU with overloaded RT tasks is examined first.
- * That is, if CPU 1 and 5 are overloaded, and CPU 3 schedules a lower
- * priority task, it will send an IPI first to CPU 5, then CPU 5 will
- * send to CPU 1 if it is still overloaded. CPU 1 will clear the
- * rq->rt.push_flags if RT_PUSH_IPI_RESTART is not set.
- *
- * The first CPU to notice IPI_RESTART is set, will clear that flag and then
- * send an IPI to the next overloaded CPU after the rq->cpu and not the next
- * CPU after push_cpu. That is, if CPU 1, 4 and 5 are overloaded when CPU 3
- * schedules a lower priority task, and the IPI_RESTART gets set while the
- * handling is being done on CPU 5, it will clear the flag and send it back to
- * CPU 4 instead of CPU 1.
- *
- * Note, the above logic can be disabled by turning off the sched_feature
- * RT_PUSH_IPI. Then the rq lock of the overloaded CPU will simply be
- * taken by the CPU requesting a pull and the waiting RT task will be pulled
- * by that CPU. This may be fine for machines with few CPUs.
  */
-static void tell_cpu_to_push(struct rq *rq)
+static int rto_next_cpu(struct rq *rq)
 {
+	struct root_domain *rd = rq->rd;
+	int next;
 	int cpu;
 
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
+	/*
+	 * When starting the IPI RT pushing, the rto_cpu is set to -1,
+	 * rt_next_cpu() will simply return the first CPU found in
+	 * the rto_mask.
+	 *
+	 * If rto_next_cpu() is called with rto_cpu is a valid cpu, it
+	 * will return the next CPU found in the rto_mask.
+	 *
+	 * If there are no more CPUs left in the rto_mask, then a check is made
+	 * against rto_loop and rto_loop_next. rto_loop is only updated with
+	 * the rto_lock held, but any CPU may increment the rto_loop_next
+	 * without any locking.
+	 */
+	for (;;) {
+
+		/* When rto_cpu is -1 this acts like cpumask_first() */
+		cpu = cpumask_next(rd->rto_cpu, rd->rto_mask);
+
+		rd->rto_cpu = cpu;
+
+		if (cpu < nr_cpu_ids)
+			return cpu;
+
+		rd->rto_cpu = -1;
+
+		/*
+		 * ACQUIRE ensures we see the @rto_mask changes
+		 * made prior to the @next value observed.
+		 *
+		 * Matches WMB in rt_set_overload().
+		 */
+		next = atomic_read_acquire(&rd->rto_loop_next);
+
+		if (rd->rto_loop == next)
+			break;
+
+		rd->rto_loop = next;
 	}
 
-	/* When here, there's no IPI going around */
+	return -1;
+}
 
-	rq->rt.push_cpu = rq->cpu;
-	cpu = find_next_push_cpu(rq);
-	if (cpu >= nr_cpu_ids)
+static inline bool rto_start_trylock(atomic_t *v)
+{
+	return !atomic_cmpxchg_acquire(v, 0, 1);
+}
+
+static inline void rto_start_unlock(atomic_t *v)
+{
+	atomic_set_release(v, 0);
+}
+
+static void tell_cpu_to_push(struct rq *rq)
+{
+	int cpu = -1;
+
+	/* Keep the loop going if the IPI is currently active */
+	atomic_inc(&rq->rd->rto_loop_next);
+
+	/* Only one CPU can initiate a loop at a time */
+	if (!rto_start_trylock(&rq->rd->rto_loop_start))
 		return;
 
-	rq->rt.push_flags = RT_PUSH_IPI_EXECUTING;
+	raw_spin_lock(&rq->rd->rto_lock);
 
-	irq_work_queue_on(&rq->rt.push_work, cpu);
+	/*
+	 * The rto_cpu is updated under the lock, if it has a valid cpu
+	 * then the IPI is still running and will continue due to the
+	 * update to loop_next, and nothing needs to be done here.
+	 * Otherwise it is finishing up and an ipi needs to be sent.
+	 */
+	if (rq->rd->rto_cpu < 0)
+		cpu = rto_next_cpu(rq);
+
+	raw_spin_unlock(&rq->rd->rto_lock);
+
+	rto_start_unlock(&rq->rd->rto_loop_start);
+
+	if (cpu >= 0)
+		irq_work_queue_on(&rq->rd->rto_push_work, cpu);
 }
 
 /* Called from hardirq context */
-static void try_to_push_tasks(void *arg)
+void rto_push_irq_work_func(struct irq_work *work)
 {
-	struct rt_rq *rt_rq = arg;
-	struct rq *rq, *src_rq;
-	int this_cpu;
+	struct rq *rq;
 	int cpu;
 
-	this_cpu = rt_rq->push_cpu;
+	rq = this_rq();
 
-	/* Paranoid check */
-	BUG_ON(this_cpu != smp_processor_id());
-
-	rq = cpu_rq(this_cpu);
-	src_rq = rq_of_rt_rq(rt_rq);
-
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
 
+	raw_spin_lock(&rq->rd->rto_lock);
+
 	/* Pass the IPI to the next rt overloaded queue */
-	raw_spin_lock(&rt_rq->push_lock);
-	/*
-	 * If the source queue changed since the IPI went out,
-	 * we need to restart the search from that CPU again.
-	 */
-	if (rt_rq->push_flags & RT_PUSH_IPI_RESTART) {
-		rt_rq->push_flags &= ~RT_PUSH_IPI_RESTART;
-		rt_rq->push_cpu = src_rq->cpu;
-	}
+	cpu = rto_next_cpu(rq);
 
-	cpu = find_next_push_cpu(src_rq);
+	raw_spin_unlock(&rq->rd->rto_lock);
 
-	if (cpu >= nr_cpu_ids)
-		rt_rq->push_flags &= ~RT_PUSH_IPI_EXECUTING;
-	raw_spin_unlock(&rt_rq->push_lock);
-
-	if (cpu >= nr_cpu_ids)
+	if (cpu < 0)
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
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -502,7 +502,7 @@ static inline int rt_bandwidth_enabled(void)
 }
 
 /* RT IPI pull logic requires IRQ_WORK */
-#ifdef CONFIG_IRQ_WORK
+#if defined(CONFIG_IRQ_WORK) && defined(CONFIG_SMP)
 # define HAVE_RT_PUSH_IPI
 #endif
 
@@ -524,12 +524,6 @@ struct rt_rq {
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
 
@@ -638,6 +632,19 @@ struct root_domain {
 	struct dl_bw dl_bw;
 	struct cpudl cpudl;
 
+#ifdef HAVE_RT_PUSH_IPI
+	/*
+	 * For IPI pull requests, loop across the rto_mask.
+	 */
+	struct irq_work rto_push_work;
+	raw_spinlock_t rto_lock;
+	/* These are only updated and read within rto_lock */
+	int rto_loop;
+	int rto_cpu;
+	/* These atomics are updated outside of a lock */
+	atomic_t rto_loop_next;
+	atomic_t rto_loop_start;
+#endif
 	/*
 	 * The "RT overload" flag: it gets set if a CPU has more than
 	 * one runnable RT task.
@@ -655,6 +662,9 @@ extern void init_defrootdomain(void);
 extern int sched_init_domains(const struct cpumask *cpu_map);
 extern void rq_attach_root(struct rq *rq, struct root_domain *rd);
 
+#ifdef HAVE_RT_PUSH_IPI
+extern void rto_push_irq_work_func(struct irq_work *work);
+#endif
 #endif /* CONFIG_SMP */
 
 /*
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -269,6 +269,13 @@ static int init_rootdomain(struct root_domain *rd)
 	if (!zalloc_cpumask_var(&rd->rto_mask, GFP_KERNEL))
 		goto free_dlo_mask;
 
+#ifdef HAVE_RT_PUSH_IPI
+	rd->rto_cpu = -1;
+	raw_spin_lock_init(&rd->rto_lock);
+	init_irq_work(&rd->rto_push_work, rto_push_irq_work_func);
+	rd->rto_push_work.flags |= IRQ_WORK_HARD_IRQ;
+#endif
+
 	init_dl_bw(&rd->dl_bw);
 	if (cpudl_init(&rd->cpudl) != 0)
 		goto free_rto_mask;
diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -151,11 +151,10 @@ static inline void tick_nohz_init(void) { }
 #ifdef CONFIG_NO_HZ_COMMON
 extern unsigned long tick_nohz_active;
 extern void timers_update_nohz(void);
-
-#ifdef CONFIG_SMP
+# ifdef CONFIG_SMP
 extern struct static_key_false timers_migration_enabled;
-#endif
-#else
+# endif
+#else /* CONFIG_NO_HZ_COMMON */
 static inline void timers_update_nohz(void) { }
 #define tick_nohz_active (0)
 #endif
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -276,14 +276,8 @@ static inline bool is_timers_nohz_active(void)
 {
 	return static_branch_unlikely(&timers_nohz_active);
 }
-
 #else
-
-static inline bool is_timers_nohz_active(void)
-{
-	return false;
-}
-
+static inline bool is_timers_nohz_active(void) { return false; }
 #endif /* NO_HZ_COMMON */
 
 static unsigned long round_jiffies_common(unsigned long j, int cpu,
diff --git a/localversion-rt b/localversion-rt
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt2
+-rt3
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1723,7 +1723,6 @@ struct memcg_stock_pcp {
 #define FLUSHING_CACHED_CHARGE	0
 };
 static DEFINE_PER_CPU(struct memcg_stock_pcp, memcg_stock);
-static DEFINE_LOCAL_IRQ_LOCK(memcg_stock_ll);
 static DEFINE_MUTEX(percpu_charge_mutex);
 
 /**
@@ -1746,7 +1745,7 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 	if (nr_pages > CHARGE_BATCH)
 		return ret;
 
-	local_lock_irqsave(memcg_stock_ll, flags);
+	local_irq_save(flags);
 
 	stock = this_cpu_ptr(&memcg_stock);
 	if (memcg == stock->cached && stock->nr_pages >= nr_pages) {
@@ -1754,7 +1753,7 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 		ret = true;
 	}
 
-	local_unlock_irqrestore(memcg_stock_ll, flags);
+	local_irq_restore(flags);
 
 	return ret;
 }
@@ -1785,13 +1784,13 @@ static void drain_local_stock(struct work_struct *dummy)
 	 * The only protection from memory hotplug vs. drain_stock races is
 	 * that we always operate on local CPU stock here with IRQ disabled
 	 */
-	local_lock_irqsave(memcg_stock_ll, flags);
+	local_irq_save(flags);
 
 	stock = this_cpu_ptr(&memcg_stock);
 	drain_stock(stock);
 	clear_bit(FLUSHING_CACHED_CHARGE, &stock->flags);
 
-	local_unlock_irqrestore(memcg_stock_ll, flags);
+	local_irq_restore(flags);
 }
 
 /*
@@ -1803,7 +1802,7 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 	struct memcg_stock_pcp *stock;
 	unsigned long flags;
 
-	local_lock_irqsave(memcg_stock_ll, flags);
+	local_irq_save(flags);
 
 	stock = this_cpu_ptr(&memcg_stock);
 	if (stock->cached != memcg) { /* reset if necessary */
@@ -1815,7 +1814,7 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 	if (stock->nr_pages > CHARGE_BATCH)
 		drain_stock(stock);
 
-	local_unlock_irqrestore(memcg_stock_ll, flags);
+	local_irq_restore(flags);
 }
 
 /*
