From: Haris Okanovic <haris.okanovic@ni.com>
Subject: [PATCH v2] timers: Don't wake ktimersoftd on every tick
Date: Mon, 17 Jul 2017 17:04:30 -0500
Message-ID: <20170717220430.20117-1-haris.okanovic@ni.com>
References: <alpine.DEB.2.20.1706041558150.2813@nanos>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <haris.okanovic@ni.com>, <harisokn@gmail.com>,
        <bigeasy@linutronix.de>, <tglx@linutronix.de>,
        <julia.cartwright@ni.com>, <gratian.crisan@ni.com>,
        <anna-maria@linutronix.de>
To: <linux-rt-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.20.1706041558150.2813@nanos>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

We recently upgraded from 4.1 to 4.6 and noticed a minor latency
regression caused by an additional thread wakeup (ktimersoftd) in
interrupt context on every tick. The wakeups are from
run_local_timers() raising TIMER_SOFTIRQ. Both TIMER and SCHED softirq
coalesced into one ksoftirqd wakeup prior to Sebastian's change to split
timers into their own thread.

There's already logic in run_local_timers() to avoid some unnecessary
wakeups of ksoftirqd, but it doesn't seems to catch them all. In
particular, I've seen many unnecessary wakeups when jiffies increments
prior to run_local_timers().

Change the way timers are collected per Julia and Thomas'
recommendation: Expired timers are now collected in interrupt context
and fired in ktimersoftd to avoid double-walk of `pending_map`.

Collect expired timers in interrupt context to avoid overhead of waking
ktimersoftd on every tick. ktimersoftd now wakes only when one or more
timers are ready, which yields a minor reduction in small latency spikes.

This is implemented by storing lists of expired timers in timer_base,
updated on each tick. Any addition to the lists wakes ktimersoftd
(softirq) to process those timers.

https://github.com/harisokanovic/linux/tree/dev/hokanovi/timer-peek-v4

Signed-off-by: Haris Okanovic <haris.okanovic@ni.com>
---
[PATCH v2] Applied Thomas Gleixner's suggestions:
 - Fix expired_count race
 - Remove unneeded base->clk lookahead
 - Return expired_count in collect_expired_timers()
 - Add block_softirq
 - Rebase to v4.11.8-rt5
---
 kernel/time/timer.c | 122 +++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 92 insertions(+), 30 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 5730d42bfd67..e5b537f2308c 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -209,9 +209,12 @@ struct timer_base {
 	bool			is_idle;
 	DECLARE_BITMAP(pending_map, WHEEL_SIZE);
 	struct hlist_head	vectors[WHEEL_SIZE];
+	struct hlist_head	expired_lists[LVL_DEPTH];
+	int			expired_count;
 } ____cacheline_aligned;
 
 static DEFINE_PER_CPU(struct timer_base, timer_bases[NR_BASES]);
+static DEFINE_PER_CPU(int, block_softirqs);
 
 #if defined(CONFIG_SMP) && defined(CONFIG_NO_HZ_COMMON)
 unsigned int sysctl_timer_migration = 1;
@@ -1314,7 +1317,8 @@ static void call_timer_fn(struct timer_list *timer, void (*fn)(unsigned long),
 	}
 }
 
-static void expire_timers(struct timer_base *base, struct hlist_head *head)
+static inline void __expire_timers(struct timer_base *base,
+				   struct hlist_head *head)
 {
 	while (!hlist_empty(head)) {
 		struct timer_list *timer;
@@ -1344,21 +1348,45 @@ static void expire_timers(struct timer_base *base, struct hlist_head *head)
 	}
 }
 
-static int __collect_expired_timers(struct timer_base *base,
-				    struct hlist_head *heads)
+static void expire_timers(struct timer_base *base)
 {
-	unsigned long clk = base->clk;
+	struct hlist_head *head;
+	int count = READ_ONCE(base->expired_count);
+
+	while (count--) {
+		head = base->expired_lists + count;
+		__expire_timers(base, head);
+	}
+
+	/* Zero base->expired_count after processing all base->expired_lists
+	 * to signal it's ready to get re-populated. Otherwise, we race with
+	 * tick_find_expired() when base->lock is temporarily dropped in
+	 * __expire_timers() */
+	base->expired_count = 0;
+}
+
+static int __collect_expired_timers(struct timer_base *base)
+{
+	unsigned long clk;
 	struct hlist_head *vec;
-	int i, levels = 0;
+	int i;
 	unsigned int idx;
 
+	/*
+	 * expire_timers() must be called at least once before we can
+	 * collect more timers
+	 */
+	if (base->expired_count)
+		goto end;
+
+	clk = base->clk;
 	for (i = 0; i < LVL_DEPTH; i++) {
 		idx = (clk & LVL_MASK) + i * LVL_SIZE;
 
 		if (__test_and_clear_bit(idx, base->pending_map)) {
 			vec = base->vectors + idx;
-			hlist_move_list(vec, heads++);
-			levels++;
+			hlist_move_list(vec,
+				&base->expired_lists[base->expired_count++]);
 		}
 		/* Is it time to look at the next level? */
 		if (clk & LVL_CLK_MASK)
@@ -1366,7 +1394,8 @@ static int __collect_expired_timers(struct timer_base *base,
 		/* Shift clock for the next level granularity */
 		clk >>= LVL_CLK_SHIFT;
 	}
-	return levels;
+
+	end: return base->expired_count;
 }
 
 #ifdef CONFIG_NO_HZ_COMMON
@@ -1559,8 +1588,7 @@ void timer_clear_idle(void)
 	base->is_idle = false;
 }
 
-static int collect_expired_timers(struct timer_base *base,
-				  struct hlist_head *heads)
+static int collect_expired_timers(struct timer_base *base)
 {
 	/*
 	 * NOHZ optimization. After a long idle sleep we need to forward the
@@ -1581,16 +1609,41 @@ static int collect_expired_timers(struct timer_base *base,
 		}
 		base->clk = next;
 	}
-	return __collect_expired_timers(base, heads);
+	return __collect_expired_timers(base);
 }
 #else
-static inline int collect_expired_timers(struct timer_base *base,
-					 struct hlist_head *heads)
+static inline int collect_expired_timers(struct timer_base *base)
 {
-	return __collect_expired_timers(base, heads);
+	return __collect_expired_timers(base);
 }
 #endif
 
+/* Increments timer_base to current jiffies or until first expired
+ * timer is found. Return number of expired timers. */
+static int find_expired_timers(struct timer_base *base)
+{
+	const unsigned long int end_clk = jiffies;
+	int expired_count;
+
+	while ( !(expired_count = collect_expired_timers(base)) &&
+			time_after_eq(end_clk, base->clk) ) {
+		base->clk++;
+	}
+
+	return expired_count;
+}
+
+/* Called from CPU tick routine to collect expired timers up to current
+ * jiffies. Return number of expired timers. */
+static int tick_find_expired(struct timer_base *base)
+{
+	int count;
+	raw_spin_lock(&base->lock);
+	count = find_expired_timers(base);
+	raw_spin_unlock(&base->lock);
+	return count;
+}
+
 /*
  * Called from the timer interrupt handler to charge one tick to the current
  * process.  user_tick is 1 if the tick is user time, 0 for system.
@@ -1618,22 +1671,11 @@ void update_process_times(int user_tick)
  */
 static inline void __run_timers(struct timer_base *base)
 {
-	struct hlist_head heads[LVL_DEPTH];
-	int levels;
-
-	if (!time_after_eq(jiffies, base->clk))
-		return;
-
 	raw_spin_lock_irq(&base->lock);
 
-	while (time_after_eq(jiffies, base->clk)) {
+	while (find_expired_timers(base))
+		expire_timers(base);
 
-		levels = collect_expired_timers(base, heads);
-		base->clk++;
-
-		while (levels--)
-			expire_timers(base, heads + levels);
-	}
 	raw_spin_unlock_irq(&base->lock);
 	wakeup_timer_waiters(base);
 }
@@ -1644,12 +1686,16 @@ static inline void __run_timers(struct timer_base *base)
 static __latent_entropy void run_timer_softirq(struct softirq_action *h)
 {
 	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
+	int* block_softirq = this_cpu_ptr(&block_softirqs);
 
 	irq_work_tick_soft();
 
 	__run_timers(base);
 	if (IS_ENABLED(CONFIG_NO_HZ_COMMON) && base->nohz_active)
 		__run_timers(this_cpu_ptr(&timer_bases[BASE_DEF]));
+
+	/* Allow new TIMER_SOFTIRQs to get scheduled by run_local_timers() */
+	WRITE_ONCE(*block_softirq, 0);
 }
 
 /*
@@ -1657,18 +1703,28 @@ static __latent_entropy void run_timer_softirq(struct softirq_action *h)
  */
 void run_local_timers(void)
 {
-	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
+	int* block_softirq = this_cpu_ptr(&block_softirqs);
+	struct timer_base *base;
 
 	hrtimer_run_queues();
+
+	/* Skip if TIMER_SOFTIRQ is already running for this CPU */
+	if (READ_ONCE(*block_softirq))
+		return;
+
+	base = this_cpu_ptr(&timer_bases[BASE_STD]);
+
 	/* Raise the softirq only if required. */
-	if (time_before(jiffies, base->clk)) {
+	if (time_before(jiffies, base->clk) || !tick_find_expired(base)) {
 		if (!IS_ENABLED(CONFIG_NO_HZ_COMMON) || !base->nohz_active)
 			return;
 		/* CPU is awake, so check the deferrable base. */
 		base++;
-		if (time_before(jiffies, base->clk))
+		if (time_before(jiffies, base->clk) || !tick_find_expired(base))
 			return;
 	}
+
+	WRITE_ONCE(*block_softirq, 1);
 	raise_softirq(TIMER_SOFTIRQ);
 }
 
@@ -1826,6 +1882,7 @@ int timers_dead_cpu(unsigned int cpu)
 		raw_spin_lock_nested(&old_base->lock, SINGLE_DEPTH_NESTING);
 
 		BUG_ON(old_base->running_timer);
+		BUG_ON(old_base->expired_count);
 
 		for (i = 0; i < WHEEL_SIZE; i++)
 			migrate_timer_list(new_base, old_base->vectors + i);
@@ -1842,6 +1899,7 @@ int timers_dead_cpu(unsigned int cpu)
 static void __init init_timer_cpu(int cpu)
 {
 	struct timer_base *base;
+	int* block_softirq;
 	int i;
 
 	for (i = 0; i < NR_BASES; i++) {
@@ -1852,6 +1910,10 @@ static void __init init_timer_cpu(int cpu)
 #ifdef CONFIG_PREEMPT_RT_FULL
 		init_swait_queue_head(&base->wait_for_running_timer);
 #endif
+		base->expired_count = 0;
+
+		block_softirq = per_cpu_ptr(&block_softirqs, cpu);
+		*block_softirq = 0;
 	}
 }
 
-- 
2.13.2
