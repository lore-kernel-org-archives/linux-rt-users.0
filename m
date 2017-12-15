From: Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] 4.9.65-rt57
Date: Thu, 14 Dec 2017 23:17:47 -0500
Message-ID: <20171214231747.0e837b6b@vmware.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com, Alex Shi <alex.shi@linaro.org>
To: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


Dear RT Folks,

I'm pleased to announce the 4.9.65-rt57 stable release.


You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.9-rt
  Head SHA1: 1dcf2103d80a19dc9562e63eb2fb0084e362c3f1


Or to build 4.9.65-rt57 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.9.tar.xz

  http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.9.65.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.9/patch-4.9.65-rt57.patch.xz



You can also build from 4.9.65-rt56 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.9/incr/patch-4.9.65-rt56-rt57.patch.xz



Enjoy,

-- Steve


Changes from v4.9.65-rt56:

---

Alex Shi (1):
      cpu_pm: replace raw_notifier to atomic_notifier

Mike Galbraith (2):
      rtmutex: Fix lock stealing logic
      kernel/hrtimer/hotplug: don't wake ktimersoftd while holding the hrtimer base lock

Sebastian Andrzej Siewior (10):
      Revert "fs: jbd2: pull your plug when waiting for space"
      PM / CPU: replace raw_notifier with atomic_notifier (fixup)
      kernel/hrtimer: migrate deferred timer on CPU down
      net: take the tcp_sk_lock lock with BH disabled
      kernel/hrtimer: don't wakeup a process while holding the hrtimer base lock
      Bluetooth: avoid recursive locking in hci_send_to_channel()
      iommu/amd: Use raw_cpu_ptr() instead of get_cpu_ptr() for ->flush_queue
      rt/locking: allow recursive local_trylock()
      locking/rtmutex: don't drop the wait_lock twice
      net: use trylock in icmp_sk

Steven Rostedt (VMware) (2):
      Revert "memcontrol: Prevent scheduling while atomic in cgroup code"
      Linux 4.9.65-rt57

----
 drivers/iommu/amd_iommu.c |  4 +--
 fs/jbd2/checkpoint.c      |  2 --
 include/linux/locallock.h |  9 ++++++
 kernel/cpu_pm.c           | 50 +++++++++-----------------------
 kernel/locking/rtmutex.c  | 74 +++++++++++++++++++++++------------------------
 kernel/time/hrtimer.c     | 35 ++++++++++++++++------
 localversion-rt           |  2 +-
 mm/memcontrol.c           | 13 ++++-----
 net/bluetooth/hci_sock.c  | 17 +++++++----
 net/ipv4/icmp.c           |  6 +++-
 net/ipv4/tcp_ipv4.c       |  8 ++---
 11 files changed, 112 insertions(+), 108 deletions(-)
---------------------------
diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index a88595b21111..ff5c2424eb9e 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2283,7 +2283,7 @@ static void queue_add(struct dma_ops_domain *dma_dom,
 	pages     = __roundup_pow_of_two(pages);
 	address >>= PAGE_SHIFT;
 
-	queue = get_cpu_ptr(&flush_queue);
+	queue = raw_cpu_ptr(&flush_queue);
 	spin_lock_irqsave(&queue->lock, flags);
 
 	if (queue->next == FLUSH_QUEUE_SIZE)
@@ -2300,8 +2300,6 @@ static void queue_add(struct dma_ops_domain *dma_dom,
 
 	if (atomic_cmpxchg(&queue_timer_on, 0, 1) == 0)
 		mod_timer(&queue_timer, jiffies + msecs_to_jiffies(10));
-
-	put_cpu_ptr(&flush_queue);
 }
 
 
diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
index 6e18a06aaabe..684996c8a3a4 100644
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
diff --git a/include/linux/locallock.h b/include/linux/locallock.h
index 845c77f1a5ca..280f884a05a3 100644
--- a/include/linux/locallock.h
+++ b/include/linux/locallock.h
@@ -77,6 +77,9 @@ static inline int __local_trylock(struct local_irq_lock *lv)
 		lv->owner = current;
 		lv->nestcnt = 1;
 		return 1;
+	} else if (lv->owner == current) {
+		lv->nestcnt++;
+		return 1;
 	}
 	return 0;
 }
@@ -250,6 +253,12 @@ static inline int __local_unlock_irqrestore(struct local_irq_lock *lv,
 
 static inline void local_irq_lock_init(int lvar) { }
 
+#define local_trylock(lvar)					\
+	({							\
+		preempt_disable();				\
+		1;						\
+	})
+
 #define local_lock(lvar)			preempt_disable()
 #define local_unlock(lvar)			preempt_enable()
 #define local_lock_irq(lvar)			local_irq_disable()
diff --git a/kernel/cpu_pm.c b/kernel/cpu_pm.c
index 009cc9a17d95..67b02e138a47 100644
--- a/kernel/cpu_pm.c
+++ b/kernel/cpu_pm.c
@@ -22,15 +22,21 @@
 #include <linux/spinlock.h>
 #include <linux/syscore_ops.h>
 
-static DEFINE_RWLOCK(cpu_pm_notifier_lock);
-static RAW_NOTIFIER_HEAD(cpu_pm_notifier_chain);
+static ATOMIC_NOTIFIER_HEAD(cpu_pm_notifier_chain);
 
 static int cpu_pm_notify(enum cpu_pm_event event, int nr_to_call, int *nr_calls)
 {
 	int ret;
 
-	ret = __raw_notifier_call_chain(&cpu_pm_notifier_chain, event, NULL,
+	/*
+	 * __atomic_notifier_call_chain has a RCU read critical section, which
+	 * could be disfunctional in cpu idle. Copy RCU_NONIDLE code to let
+	 * RCU know this.
+	 */
+	rcu_irq_enter_irqson();
+	ret = __atomic_notifier_call_chain(&cpu_pm_notifier_chain, event, NULL,
 		nr_to_call, nr_calls);
+	rcu_irq_exit_irqson();
 
 	return notifier_to_errno(ret);
 }
@@ -47,14 +53,7 @@ static int cpu_pm_notify(enum cpu_pm_event event, int nr_to_call, int *nr_calls)
  */
 int cpu_pm_register_notifier(struct notifier_block *nb)
 {
-	unsigned long flags;
-	int ret;
-
-	write_lock_irqsave(&cpu_pm_notifier_lock, flags);
-	ret = raw_notifier_chain_register(&cpu_pm_notifier_chain, nb);
-	write_unlock_irqrestore(&cpu_pm_notifier_lock, flags);
-
-	return ret;
+	return atomic_notifier_chain_register(&cpu_pm_notifier_chain, nb);
 }
 EXPORT_SYMBOL_GPL(cpu_pm_register_notifier);
 
@@ -69,14 +68,7 @@ EXPORT_SYMBOL_GPL(cpu_pm_register_notifier);
  */
 int cpu_pm_unregister_notifier(struct notifier_block *nb)
 {
-	unsigned long flags;
-	int ret;
-
-	write_lock_irqsave(&cpu_pm_notifier_lock, flags);
-	ret = raw_notifier_chain_unregister(&cpu_pm_notifier_chain, nb);
-	write_unlock_irqrestore(&cpu_pm_notifier_lock, flags);
-
-	return ret;
+	return atomic_notifier_chain_unregister(&cpu_pm_notifier_chain, nb);
 }
 EXPORT_SYMBOL_GPL(cpu_pm_unregister_notifier);
 
@@ -100,7 +92,6 @@ int cpu_pm_enter(void)
 	int nr_calls;
 	int ret = 0;
 
-	read_lock(&cpu_pm_notifier_lock);
 	ret = cpu_pm_notify(CPU_PM_ENTER, -1, &nr_calls);
 	if (ret)
 		/*
@@ -108,7 +99,6 @@ int cpu_pm_enter(void)
 		 * PM entry who are notified earlier to prepare for it.
 		 */
 		cpu_pm_notify(CPU_PM_ENTER_FAILED, nr_calls - 1, NULL);
-	read_unlock(&cpu_pm_notifier_lock);
 
 	return ret;
 }
@@ -128,13 +118,7 @@ EXPORT_SYMBOL_GPL(cpu_pm_enter);
  */
 int cpu_pm_exit(void)
 {
-	int ret;
-
-	read_lock(&cpu_pm_notifier_lock);
-	ret = cpu_pm_notify(CPU_PM_EXIT, -1, NULL);
-	read_unlock(&cpu_pm_notifier_lock);
-
-	return ret;
+	return cpu_pm_notify(CPU_PM_EXIT, -1, NULL);
 }
 EXPORT_SYMBOL_GPL(cpu_pm_exit);
 
@@ -159,7 +143,6 @@ int cpu_cluster_pm_enter(void)
 	int nr_calls;
 	int ret = 0;
 
-	read_lock(&cpu_pm_notifier_lock);
 	ret = cpu_pm_notify(CPU_CLUSTER_PM_ENTER, -1, &nr_calls);
 	if (ret)
 		/*
@@ -167,7 +150,6 @@ int cpu_cluster_pm_enter(void)
 		 * PM entry who are notified earlier to prepare for it.
 		 */
 		cpu_pm_notify(CPU_CLUSTER_PM_ENTER_FAILED, nr_calls - 1, NULL);
-	read_unlock(&cpu_pm_notifier_lock);
 
 	return ret;
 }
@@ -190,13 +172,7 @@ EXPORT_SYMBOL_GPL(cpu_cluster_pm_enter);
  */
 int cpu_cluster_pm_exit(void)
 {
-	int ret;
-
-	read_lock(&cpu_pm_notifier_lock);
-	ret = cpu_pm_notify(CPU_CLUSTER_PM_EXIT, -1, NULL);
-	read_unlock(&cpu_pm_notifier_lock);
-
-	return ret;
+	return cpu_pm_notify(CPU_CLUSTER_PM_EXIT, -1, NULL);
 }
 EXPORT_SYMBOL_GPL(cpu_cluster_pm_exit);
 
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index b73cd7c87551..3a8b5d44aaf8 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -235,25 +235,18 @@ static inline bool unlock_rt_mutex_safe(struct rt_mutex *lock,
 }
 #endif
 
-#define STEAL_NORMAL  0
-#define STEAL_LATERAL 1
 /*
  * Only use with rt_mutex_waiter_{less,equal}()
  */
-#define task_to_waiter(p)	\
-	&(struct rt_mutex_waiter){ .prio = (p)->prio, .deadline = (p)->dl.deadline }
+#define task_to_waiter(p) &(struct rt_mutex_waiter) \
+	{ .prio = (p)->prio, .deadline = (p)->dl.deadline, .task = (p) }
 
 static inline int
 rt_mutex_waiter_less(struct rt_mutex_waiter *left,
-		     struct rt_mutex_waiter *right, int mode)
+		     struct rt_mutex_waiter *right)
 {
-	if (mode == STEAL_NORMAL) {
-		if (left->prio < right->prio)
-			return 1;
-	} else {
-		if (left->prio <= right->prio)
-			return 1;
-	}
+	if (left->prio < right->prio)
+		return 1;
 
 	/*
 	 * If both waiters have dl_prio(), we check the deadlines of the
@@ -286,6 +279,27 @@ rt_mutex_waiter_equal(struct rt_mutex_waiter *left,
 	return 1;
 }
 
+#define STEAL_NORMAL  0
+#define STEAL_LATERAL 1
+
+static inline int
+rt_mutex_steal(struct rt_mutex *lock, struct rt_mutex_waiter *waiter, int mode)
+{
+	struct rt_mutex_waiter *top_waiter = rt_mutex_top_waiter(lock);
+
+	if (waiter == top_waiter || rt_mutex_waiter_less(waiter, top_waiter))
+		return 1;
+
+	/*
+	 * Note that RT tasks are excluded from lateral-steals
+	 * to prevent the introduction of an unbounded latency.
+	 */
+	if (mode == STEAL_NORMAL || rt_task(waiter->task))
+		return 0;
+
+	return rt_mutex_waiter_equal(waiter, top_waiter);
+}
+
 static void
 rt_mutex_enqueue(struct rt_mutex *lock, struct rt_mutex_waiter *waiter)
 {
@@ -297,7 +311,7 @@ rt_mutex_enqueue(struct rt_mutex *lock, struct rt_mutex_waiter *waiter)
 	while (*link) {
 		parent = *link;
 		entry = rb_entry(parent, struct rt_mutex_waiter, tree_entry);
-		if (rt_mutex_waiter_less(waiter, entry, STEAL_NORMAL)) {
+		if (rt_mutex_waiter_less(waiter, entry)) {
 			link = &parent->rb_left;
 		} else {
 			link = &parent->rb_right;
@@ -336,7 +350,7 @@ rt_mutex_enqueue_pi(struct task_struct *task, struct rt_mutex_waiter *waiter)
 	while (*link) {
 		parent = *link;
 		entry = rb_entry(parent, struct rt_mutex_waiter, pi_tree_entry);
-		if (rt_mutex_waiter_less(waiter, entry, STEAL_NORMAL)) {
+		if (rt_mutex_waiter_less(waiter, entry)) {
 			link = &parent->rb_left;
 		} else {
 			link = &parent->rb_right;
@@ -847,6 +861,7 @@ static int rt_mutex_adjust_prio_chain(struct task_struct *task,
  * @task:   The task which wants to acquire the lock
  * @waiter: The waiter that is queued to the lock's wait tree if the
  *	    callsite called task_blocked_on_lock(), otherwise NULL
+ * @mode:   Lock steal mode (STEAL_NORMAL, STEAL_LATERAL)
  */
 static int __try_to_take_rt_mutex(struct rt_mutex *lock,
 				  struct task_struct *task,
@@ -886,14 +901,11 @@ static int __try_to_take_rt_mutex(struct rt_mutex *lock,
 	 */
 	if (waiter) {
 		/*
-		 * If waiter is not the highest priority waiter of
-		 * @lock, give up.
+		 * If waiter is not the highest priority waiter of @lock,
+		 * or its peer when lateral steal is allowed, give up.
 		 */
-		if (waiter != rt_mutex_top_waiter(lock)) {
-			/* XXX rt_mutex_waiter_less() ? */
+		if (!rt_mutex_steal(lock, waiter, mode))
 			return 0;
-		}
-
 		/*
 		 * We can acquire the lock. Remove the waiter from the
 		 * lock waiters tree.
@@ -910,25 +922,12 @@ static int __try_to_take_rt_mutex(struct rt_mutex *lock,
 		 * not need to be dequeued.
 		 */
 		if (rt_mutex_has_waiters(lock)) {
-			struct task_struct *pown = rt_mutex_top_waiter(lock)->task;
-
-			if (task != pown)
-				return 0;
-
 			/*
-			 * Note that RT tasks are excluded from lateral-steals
-			 * to prevent the introduction of an unbounded latency.
+			 * If @task->prio is greater than the top waiter
+			 * priority (kernel view), or equal to it when a
+			 * lateral steal is forbidden, @task lost.
 			 */
-			if (rt_task(task))
-				mode = STEAL_NORMAL;
-			/*
-			 * If @task->prio is greater than or equal to
-			 * the top waiter priority (kernel view),
-			 * @task lost.
-			 */
-			if (!rt_mutex_waiter_less(task_to_waiter(task),
-						  rt_mutex_top_waiter(lock),
-						  mode))
+			if (!rt_mutex_steal(lock, task_to_waiter(task), mode))
 				return 0;
 			/*
 			 * The current top waiter stays enqueued. We
@@ -2313,7 +2312,6 @@ int __rt_mutex_start_proxy_lock(struct rt_mutex *lock,
 	raw_spin_lock(&task->pi_lock);
 	if (task->pi_blocked_on) {
 		raw_spin_unlock(&task->pi_lock);
-		raw_spin_unlock_irq(&lock->wait_lock);
 		return -EAGAIN;
 	}
 	task->pi_blocked_on = PI_REQUEUE_INPROGRESS;
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 0797bd6eadb4..369203af6406 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1440,7 +1440,7 @@ static inline int hrtimer_rt_defer(struct hrtimer *timer) { return 0; }
 
 static enum hrtimer_restart hrtimer_wakeup(struct hrtimer *timer);
 
-static void __hrtimer_run_queues(struct hrtimer_cpu_base *cpu_base, ktime_t now)
+static int __hrtimer_run_queues(struct hrtimer_cpu_base *cpu_base, ktime_t now)
 {
 	struct hrtimer_clock_base *base = cpu_base->clock_base;
 	unsigned int active = cpu_base->active_bases;
@@ -1490,8 +1490,7 @@ static void __hrtimer_run_queues(struct hrtimer_cpu_base *cpu_base, ktime_t now)
 				raise = 1;
 		}
 	}
-	if (raise)
-		raise_softirq_irqoff(HRTIMER_SOFTIRQ);
+	return raise;
 }
 
 #ifdef CONFIG_HIGH_RES_TIMERS
@@ -1505,6 +1504,7 @@ void hrtimer_interrupt(struct clock_event_device *dev)
 	struct hrtimer_cpu_base *cpu_base = this_cpu_ptr(&hrtimer_bases);
 	ktime_t expires_next, now, entry_time, delta;
 	int retries = 0;
+	int raise;
 
 	BUG_ON(!cpu_base->hres_active);
 	cpu_base->nr_events++;
@@ -1523,7 +1523,7 @@ void hrtimer_interrupt(struct clock_event_device *dev)
 	 */
 	cpu_base->expires_next.tv64 = KTIME_MAX;
 
-	__hrtimer_run_queues(cpu_base, now);
+	raise = __hrtimer_run_queues(cpu_base, now);
 
 	/* Reevaluate the clock bases for the next expiry */
 	expires_next = __hrtimer_get_next_event(cpu_base);
@@ -1534,6 +1534,8 @@ void hrtimer_interrupt(struct clock_event_device *dev)
 	cpu_base->expires_next = expires_next;
 	cpu_base->in_hrtirq = 0;
 	raw_spin_unlock(&cpu_base->lock);
+	if (raise)
+		raise_softirq_irqoff(HRTIMER_SOFTIRQ);
 
 	/* Reprogramming necessary ? */
 	if (!tick_program_event(expires_next, 0)) {
@@ -1613,6 +1615,7 @@ void hrtimer_run_queues(void)
 {
 	struct hrtimer_cpu_base *cpu_base = this_cpu_ptr(&hrtimer_bases);
 	ktime_t now;
+	int raise;
 
 	if (__hrtimer_hres_active(cpu_base))
 		return;
@@ -1631,8 +1634,10 @@ void hrtimer_run_queues(void)
 
 	raw_spin_lock(&cpu_base->lock);
 	now = hrtimer_update_base(cpu_base);
-	__hrtimer_run_queues(cpu_base, now);
+	raise = __hrtimer_run_queues(cpu_base, now);
 	raw_spin_unlock(&cpu_base->lock);
+	if (raise)
+		raise_softirq_irqoff(HRTIMER_SOFTIRQ);
 }
 
 /*
@@ -1832,7 +1837,7 @@ int hrtimers_prepare_cpu(unsigned int cpu)
 
 #ifdef CONFIG_HOTPLUG_CPU
 
-static void migrate_hrtimer_list(struct hrtimer_clock_base *old_base,
+static int migrate_hrtimer_list(struct hrtimer_clock_base *old_base,
 				struct hrtimer_clock_base *new_base)
 {
 	struct hrtimer *timer;
@@ -1860,12 +1865,21 @@ static void migrate_hrtimer_list(struct hrtimer_clock_base *old_base,
 		 */
 		enqueue_hrtimer(timer, new_base);
 	}
+#ifdef CONFIG_PREEMPT_RT_BASE
+	list_splice_tail(&old_base->expired, &new_base->expired);
+	/*
+	 * Tell the caller to raise HRTIMER_SOFTIRQ.  We can't safely
+	 * acquire ktimersoftd->pi_lock while the base lock is held.
+	 */
+	return !list_empty(&new_base->expired);
+#endif
+	return 0;
 }
 
 int hrtimers_dead_cpu(unsigned int scpu)
 {
 	struct hrtimer_cpu_base *old_base, *new_base;
-	int i;
+	int i, raise = 0;
 
 	BUG_ON(cpu_online(scpu));
 	tick_cancel_sched_timer(scpu);
@@ -1881,13 +1895,16 @@ int hrtimers_dead_cpu(unsigned int scpu)
 	raw_spin_lock_nested(&old_base->lock, SINGLE_DEPTH_NESTING);
 
 	for (i = 0; i < HRTIMER_MAX_CLOCK_BASES; i++) {
-		migrate_hrtimer_list(&old_base->clock_base[i],
-				     &new_base->clock_base[i]);
+		raise |= migrate_hrtimer_list(&old_base->clock_base[i],
+					      &new_base->clock_base[i]);
 	}
 
 	raw_spin_unlock(&old_base->lock);
 	raw_spin_unlock(&new_base->lock);
 
+	if (raise)
+		raise_softirq_irqoff(HRTIMER_SOFTIRQ);
+
 	/* Check, if we got expired work to do */
 	__hrtimer_peek_ahead_timers();
 	local_irq_enable();
diff --git a/localversion-rt b/localversion-rt
index fdb0f880c7e9..c06cc4356292 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt56
+-rt57
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 12b94909ba7b..c04403033aec 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1698,7 +1698,6 @@ struct memcg_stock_pcp {
 #define FLUSHING_CACHED_CHARGE	0
 };
 static DEFINE_PER_CPU(struct memcg_stock_pcp, memcg_stock);
-static DEFINE_LOCAL_IRQ_LOCK(memcg_stock_ll);
 static DEFINE_MUTEX(percpu_charge_mutex);
 
 /**
@@ -1721,7 +1720,7 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 	if (nr_pages > CHARGE_BATCH)
 		return ret;
 
-	local_lock_irqsave(memcg_stock_ll, flags);
+	local_irq_save(flags);
 
 	stock = this_cpu_ptr(&memcg_stock);
 	if (memcg == stock->cached && stock->nr_pages >= nr_pages) {
@@ -1729,7 +1728,7 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 		ret = true;
 	}
 
-	local_unlock_irqrestore(memcg_stock_ll, flags);
+	local_irq_restore(flags);
 
 	return ret;
 }
@@ -1756,13 +1755,13 @@ static void drain_local_stock(struct work_struct *dummy)
 	struct memcg_stock_pcp *stock;
 	unsigned long flags;
 
-	local_lock_irqsave(memcg_stock_ll, flags);
+	local_irq_save(flags);
 
 	stock = this_cpu_ptr(&memcg_stock);
 	drain_stock(stock);
 	clear_bit(FLUSHING_CACHED_CHARGE, &stock->flags);
 
-	local_unlock_irqrestore(memcg_stock_ll, flags);
+	local_irq_restore(flags);
 }
 
 /*
@@ -1774,7 +1773,7 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 	struct memcg_stock_pcp *stock;
 	unsigned long flags;
 
-	local_lock_irqsave(memcg_stock_ll, flags);
+	local_irq_save(flags);
 
 	stock = this_cpu_ptr(&memcg_stock);
 	if (stock->cached != memcg) { /* reset if necessary */
@@ -1783,7 +1782,7 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 	}
 	stock->nr_pages += nr_pages;
 
-	local_unlock_irqrestore(memcg_stock_ll, flags);
+	local_irq_restore(flags);
 }
 
 /*
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index c88a6007e643..5de85b55a821 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -251,15 +251,13 @@ void hci_send_to_sock(struct hci_dev *hdev, struct sk_buff *skb)
 }
 
 /* Send frame to sockets with specific channel */
-void hci_send_to_channel(unsigned short channel, struct sk_buff *skb,
-			 int flag, struct sock *skip_sk)
+static void __hci_send_to_channel(unsigned short channel, struct sk_buff *skb,
+				  int flag, struct sock *skip_sk)
 {
 	struct sock *sk;
 
 	BT_DBG("channel %u len %d", channel, skb->len);
 
-	read_lock(&hci_sk_list.lock);
-
 	sk_for_each(sk, &hci_sk_list.head) {
 		struct sk_buff *nskb;
 
@@ -285,6 +283,13 @@ void hci_send_to_channel(unsigned short channel, struct sk_buff *skb,
 			kfree_skb(nskb);
 	}
 
+}
+
+void hci_send_to_channel(unsigned short channel, struct sk_buff *skb,
+			 int flag, struct sock *skip_sk)
+{
+	read_lock(&hci_sk_list.lock);
+	__hci_send_to_channel(channel, skb, flag, skip_sk);
 	read_unlock(&hci_sk_list.lock);
 }
 
@@ -388,8 +393,8 @@ void hci_send_monitor_ctrl_event(struct hci_dev *hdev, u16 event,
 		hdr->index = index;
 		hdr->len = cpu_to_le16(skb->len - HCI_MON_HDR_SIZE);
 
-		hci_send_to_channel(HCI_CHANNEL_MONITOR, skb,
-				    HCI_SOCK_TRUSTED, NULL);
+		__hci_send_to_channel(HCI_CHANNEL_MONITOR, skb,
+				      HCI_SOCK_TRUSTED, NULL);
 		kfree_skb(skb);
 	}
 
diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index e6864ff11352..330224ef4174 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -219,7 +219,11 @@ static inline struct sock *icmp_xmit_lock(struct net *net)
 
 	local_bh_disable();
 
-	local_lock(icmp_sk_lock);
+	if (!local_trylock(icmp_sk_lock)) {
+		local_bh_enable();
+		return NULL;
+	}
+
 	sk = icmp_sk(net);
 
 	if (unlikely(!spin_trylock(&sk->sk_lock.slock))) {
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 3336e1534bc5..3b7298459c87 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -698,8 +698,8 @@ static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb)
 
 	arg.tos = ip_hdr(skb)->tos;
 
-	local_lock(tcp_sk_lock);
 	local_bh_disable();
+	local_lock(tcp_sk_lock);
 	ip_send_unicast_reply(*this_cpu_ptr(net->ipv4.tcp_sk),
 			      skb, &TCP_SKB_CB(skb)->header.h4.opt,
 			      ip_hdr(skb)->saddr, ip_hdr(skb)->daddr,
@@ -707,8 +707,8 @@ static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb)
 
 	__TCP_INC_STATS(net, TCP_MIB_OUTSEGS);
 	__TCP_INC_STATS(net, TCP_MIB_OUTRSTS);
-	local_bh_enable();
 	local_unlock(tcp_sk_lock);
+	local_bh_enable();
 
 #ifdef CONFIG_TCP_MD5SIG
 out:
@@ -784,16 +784,16 @@ static void tcp_v4_send_ack(struct net *net,
 	if (oif)
 		arg.bound_dev_if = oif;
 	arg.tos = tos;
-	local_lock(tcp_sk_lock);
 	local_bh_disable();
+	local_lock(tcp_sk_lock);
 	ip_send_unicast_reply(*this_cpu_ptr(net->ipv4.tcp_sk),
 			      skb, &TCP_SKB_CB(skb)->header.h4.opt,
 			      ip_hdr(skb)->saddr, ip_hdr(skb)->daddr,
 			      &arg, arg.iov[0].iov_len);
 
 	__TCP_INC_STATS(net, TCP_MIB_OUTSEGS);
-	local_bh_enable();
 	local_unlock(tcp_sk_lock);
+	local_bh_enable();
 }
 
 static void tcp_v4_timewait_ack(struct sock *sk, struct sk_buff *skb)
