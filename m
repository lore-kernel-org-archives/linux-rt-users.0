From: Haris Okanovic <haris.okanovic@ni.com>
Subject: [PATCH] timers: Don't wake ktimersoftd on every tick
Date: Fri, 3 Feb 2017 12:21:12 -0600
Message-ID: <20170203182112.18053-1-haris.okanovic@ni.com>
References: <20170203165151.qbpjothhaqctuzx5@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <haris.okanovic@ni.com>, <tglx@linutronix.de>,
        <julia.cartwright@ni.com>, <gratian.crisan@ni.com>
To: <linux-rt-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170203165151.qbpjothhaqctuzx5@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Collect expired timers in interrupt context to avoid overhead of waking
ktimersoftd on every tick. ktimersoftd now wakes only when one or more
timers are ready, which yields a minor reduction in small latency spikes.

This is implemented by storing lists of expired timers in timer_base,
updated on each tick. Any addition to the lists wakes ktimersoftd
(softirq) to process those timers.

Please refer to the following RFC threads for more details:
https://www.spinics.net/lists/linux-rt-users/msg16095.html
https://www.spinics.net/lists/linux-rt-users/msg16113.html

Signed-off-by: Haris Okanovic <haris.okanovic@ni.com>
---
 kernel/time/timer.c | 97 ++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 67 insertions(+), 30 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 08a5ab7..5ed1484 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -206,6 +206,8 @@ struct timer_base {
 	bool			is_idle;
 	DECLARE_BITMAP(pending_map, WHEEL_SIZE);
 	struct hlist_head	vectors[WHEEL_SIZE];
+	struct hlist_head	expired_lists[LVL_DEPTH];
+	int					expired_count;
 } ____cacheline_aligned;
 
 static DEFINE_PER_CPU(struct timer_base, timer_bases[NR_BASES]);
@@ -1353,7 +1355,8 @@ static void call_timer_fn(struct timer_list *timer, void (*fn)(unsigned long),
 	}
 }
 
-static void expire_timers(struct timer_base *base, struct hlist_head *head)
+static inline void __expire_timers(struct timer_base *base,
+							struct hlist_head *head)
 {
 	while (!hlist_empty(head)) {
 		struct timer_list *timer;
@@ -1370,7 +1373,7 @@ static void expire_timers(struct timer_base *base, struct hlist_head *head)
 		data = timer->data;
 
 		if (!IS_ENABLED(CONFIG_PREEMPT_RT_FULL) &&
-		    timer->flags & TIMER_IRQSAFE) {
+			timer->flags & TIMER_IRQSAFE) {
 			raw_spin_unlock(&base->lock);
 			call_timer_fn(timer, fn, data);
 			base->running_timer = NULL;
@@ -1384,21 +1387,37 @@ static void expire_timers(struct timer_base *base, struct hlist_head *head)
 	}
 }
 
-static int __collect_expired_timers(struct timer_base *base,
-				    struct hlist_head *heads)
+static void expire_timers(struct timer_base *base)
+{
+	struct hlist_head *head;
+
+	while (base->expired_count--) {
+		head = base->expired_lists + base->expired_count;
+		__expire_timers(base, head);
+	}
+	base->expired_count = 0;
+}
+
+static void __collect_expired_timers(struct timer_base *base)
 {
 	unsigned long clk = base->clk;
 	struct hlist_head *vec;
-	int i, levels = 0;
+	int i;
 	unsigned int idx;
 
+	/* expire_timers() must be called at least once before we can
+	 * collect more timers
+	 */
+	if (WARN_ON(base->expired_count))
+		return;
+
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
@@ -1406,7 +1425,6 @@ static int __collect_expired_timers(struct timer_base *base,
 		/* Shift clock for the next level granularity */
 		clk >>= LVL_CLK_SHIFT;
 	}
-	return levels;
 }
 
 #ifdef CONFIG_NO_HZ_COMMON
@@ -1599,8 +1617,7 @@ void timer_clear_idle(void)
 	base->is_idle = false;
 }
 
-static int collect_expired_timers(struct timer_base *base,
-				  struct hlist_head *heads)
+static void collect_expired_timers(struct timer_base *base)
 {
 	/*
 	 * NOHZ optimization. After a long idle sleep we need to forward the
@@ -1617,20 +1634,49 @@ static int collect_expired_timers(struct timer_base *base,
 		if (time_after(next, jiffies)) {
 			/* The call site will increment clock! */
 			base->clk = jiffies - 1;
-			return 0;
+			return;
 		}
 		base->clk = next;
 	}
-	return __collect_expired_timers(base, heads);
+	__collect_expired_timers(base);
 }
 #else
-static inline int collect_expired_timers(struct timer_base *base,
-					 struct hlist_head *heads)
+static inline void collect_expired_timers(struct timer_base *base)
 {
-	return __collect_expired_timers(base, heads);
+	__collect_expired_timers(base);
 }
 #endif
 
+static int find_expired_timers(struct timer_base *base)
+{
+	const unsigned long int end_clk = jiffies;
+
+	while (!base->expired_count && time_after_eq(end_clk, base->clk)) {
+		collect_expired_timers(base);
+		base->clk++;
+	}
+
+	return base->expired_count;
+}
+
+/* Called from cpu tick routine to quickly collect expired timers */
+static int tick_find_expired(struct timer_base *base)
+{
+	int count;
+
+	raw_spin_lock(&base->lock);
+
+	if (unlikely(time_after(jiffies, base->clk + HZ))) {
+		/* defer to ktimersoftd; don't spend too long in irq context */
+		count = -1;
+	} else
+		count = find_expired_timers(base);
+
+	raw_spin_unlock(&base->lock);
+
+	return count;
+}
+
 /*
  * Called from the timer interrupt handler to charge one tick to the current
  * process.  user_tick is 1 if the tick is user time, 0 for system.
@@ -1657,22 +1703,11 @@ void update_process_times(int user_tick)
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
-
-		levels = collect_expired_timers(base, heads);
-		base->clk++;
+	while (find_expired_timers(base))
+		expire_timers(base);
 
-		while (levels--)
-			expire_timers(base, heads + levels);
-	}
 	raw_spin_unlock_irq(&base->lock);
 	wakeup_timer_waiters(base);
 }
@@ -1700,12 +1735,12 @@ void run_local_timers(void)
 
 	hrtimer_run_queues();
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
 	raise_softirq(TIMER_SOFTIRQ);
@@ -1875,6 +1910,7 @@ int timers_dead_cpu(unsigned int cpu)
 		raw_spin_lock_nested(&old_base->lock, SINGLE_DEPTH_NESTING);
 
 		BUG_ON(old_base->running_timer);
+		BUG_ON(old_base->expired_count);
 
 		for (i = 0; i < WHEEL_SIZE; i++)
 			migrate_timer_list(new_base, old_base->vectors + i);
@@ -1901,6 +1937,7 @@ static void __init init_timer_cpu(int cpu)
 #ifdef CONFIG_PREEMPT_RT_FULL
 		init_swait_queue_head(&base->wait_for_running_timer);
 #endif
+		base->expired_count = 0;
 	}
 }
 
-- 
2.10.1
