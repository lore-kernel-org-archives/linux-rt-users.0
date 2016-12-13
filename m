From: Haris Okanovic <haris.okanovic@ni.com>
Subject: [RFC v2] timers: Don't wake ktimersoftd on every tick
Date: Tue, 13 Dec 2016 15:44:05 -0600
Message-ID: <20161213214405.28554-1-haris.okanovic@ni.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-kernel@vger.kernel.org>, <bigeasy@linutronix.de>,
        <tglx@linutronix.de>, <julia.cartwright@ni.com>,
        <gratian.crisan@ni.com>, <haris.okanovic@ni.com>
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Changed the way timers are collected per Julia and Thomas'
recommendation: Expired timers are now collected in interrupt context
and fired in ktimersoftd to avoid double-walk of `pending_map`.

This is implemented by storing lists of expired timers in timer_base,
which carries a memory overhead 9*sizeof(pointer) per CPU. The timer
system uses hlist's which don't have end-node references, making it
impossible to merge 2 hlist's in constant time. I.e. Merging requires
walking one list. I also considered switching `vectors` to regular
list's which don't have this limitations, but that approach has the same
memory overhead. list_head is bigger than hlist_head by sizeof(pointer)
and is instantiated 9+ times per CPU as `vectors`. I believe the only
way to trim overhead is to spend more CPU cycles in interrupt context
either in list merging (unbounded operation) or the original double-walk
implementation. Any suggestions/preferences?

As before, a 6h run of cyclictest without CPU affinity shows decrease in
22-70us latency range. No change in max jitter. No change when `-S` is
used.

[Before/after traces]

ftp://ftp.ni.com/outgoing/tp02-timer-peek-traces.tgz
(Email me if link dies. Server periodically purges old files.)

[Hardware/software/config]

 NI cRIO-9033
  2 core Intel Atom CPU

 Kernel 4.8.6-rt5
  CONFIG_HZ_PERIODIC=y

[Outstanding concerns/issues/questions]

I'm relatively new to the timer subsystem, so please feel free to poke
as many holes as possible in this change. A few things that concern me
at the moment are:

Can jiffies change while one or more cpus is inside tick_sched_timer(),
 in interrupt context? I'm copying jiffies to a local variable in
 find_expired_timers() to ensure it doesn't run unbounded, but I'm not
 sure if that's necessary.

Any special considerations for testing NO_HZ builds? (Other than letting
it run idle for a while)

timers_dead_cpu() presently asserts no timer callback is actively
running, which suggests that timers must be canceled prior to disabling
CPUs; otherwise, there's a race between active timers and hotplug
which can crash the whole kernel. Is this a safe assumption to make and
are there any special considerations for CPU hotplug testing?

Other tests/performance benchmark I should run?

Source: https://github.com/harisokanovic/linux/tree/dev/hokanovi/timer-peek-v2

Thanks,
Haris
---
 kernel/time/timer.c | 97 ++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 67 insertions(+), 30 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index ba53447..b0cee45 100644
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
@@ -1343,7 +1345,8 @@ static void call_timer_fn(struct timer_list *timer, void (*fn)(unsigned long),
 	}
 }
 
-static void expire_timers(struct timer_base *base, struct hlist_head *head)
+static inline void __expire_timers(struct timer_base *base,
+							struct hlist_head *head)
 {
 	while (!hlist_empty(head)) {
 		struct timer_list *timer;
@@ -1360,7 +1363,7 @@ static void expire_timers(struct timer_base *base, struct hlist_head *head)
 		data = timer->data;
 
 		if (!IS_ENABLED(CONFIG_PREEMPT_RT_FULL) &&
-		    timer->flags & TIMER_IRQSAFE) {
+			timer->flags & TIMER_IRQSAFE) {
 			raw_spin_unlock(&base->lock);
 			call_timer_fn(timer, fn, data);
 			base->running_timer = NULL;
@@ -1374,21 +1377,37 @@ static void expire_timers(struct timer_base *base, struct hlist_head *head)
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
@@ -1396,7 +1415,6 @@ static int __collect_expired_timers(struct timer_base *base,
 		/* Shift clock for the next level granularity */
 		clk >>= LVL_CLK_SHIFT;
 	}
-	return levels;
 }
 
 #ifdef CONFIG_NO_HZ_COMMON
@@ -1585,8 +1603,7 @@ void timer_clear_idle(void)
 	base->is_idle = false;
 }
 
-static int collect_expired_timers(struct timer_base *base,
-				  struct hlist_head *heads)
+static void collect_expired_timers(struct timer_base *base)
 {
 	/*
 	 * NOHZ optimization. After a long idle sleep we need to forward the
@@ -1603,20 +1620,49 @@ static int collect_expired_timers(struct timer_base *base,
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
@@ -1643,22 +1689,11 @@ void update_process_times(int user_tick)
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
@@ -1686,12 +1721,12 @@ void run_local_timers(void)
 
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
@@ -1861,6 +1896,7 @@ int timers_dead_cpu(unsigned int cpu)
 		raw_spin_lock_nested(&old_base->lock, SINGLE_DEPTH_NESTING);
 
 		BUG_ON(old_base->running_timer);
+		BUG_ON(old_base->expired_count);
 
 		for (i = 0; i < WHEEL_SIZE; i++)
 			migrate_timer_list(new_base, old_base->vectors + i);
@@ -1887,6 +1923,7 @@ static void __init init_timer_cpu(int cpu)
 #ifdef CONFIG_PREEMPT_RT_FULL
 		init_swait_queue_head(&base->wait_for_running_timer);
 #endif
+		base->expired_count = 0;
 	}
 }
 
-- 
2.10.1
