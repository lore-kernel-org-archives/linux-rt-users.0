From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [ANNOUNCE] v4.9.9-rt6
Date: Fri, 10 Feb 2017 19:48:50 +0100
Message-ID: <20170210184849.rwrvbdrs2oz72l2a@linutronix.de>
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

I'm pleased to announce the v4.9.9-rt6 patch set. 

Changes since v4.9.9-rt5:

  - The timer softirq was woken up under certain circumstances where it
    could have been avoided. Patch by Haris Okanovic.

  - Alex Goins noticed that a GPL only symbol will be forced on -RT
    which is not the case on !RT configurations. This has been resolved.

Known issues
	- CPU hotplug got a little better but can deadlock.

The delta patch against v4.9.9-rt6 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.9/incr/patch-4.9.9-rt5-rt6.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.9.9-rt6

The RT patch against v4.9.9 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.9/older/patch-4.9.9-rt6.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.9/older/patches-4.9.9-rt6.tar.xz

Sebastian
diff --git a/include/linux/mutex_rt.h b/include/linux/mutex_rt.h
--- a/include/linux/mutex_rt.h
+++ b/include/linux/mutex_rt.h
@@ -43,7 +43,12 @@ extern void __lockfunc _mutex_unlock(struct mutex *lock);
 #define mutex_lock_killable(l)		_mutex_lock_killable(l)
 #define mutex_trylock(l)		_mutex_trylock(l)
 #define mutex_unlock(l)			_mutex_unlock(l)
+
+#ifdef CONFIG_DEBUG_MUTEXES
 #define mutex_destroy(l)		rt_mutex_destroy(&(l)->lock)
+#else
+static inline void mutex_destroy(struct mutex *lock) {}
+#endif
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 # define mutex_lock_nested(l, s)	_mutex_lock_nested(l, s)
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -2211,8 +2211,7 @@ void rt_mutex_destroy(struct rt_mutex *lock)
 	lock->magic = NULL;
 #endif
 }
-
-EXPORT_SYMBOL_GPL(rt_mutex_destroy);
+EXPORT_SYMBOL(rt_mutex_destroy);
 
 /**
  * __rt_mutex_init - initialize the rt lock
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -206,6 +206,8 @@ struct timer_base {
 	bool			is_idle;
 	DECLARE_BITMAP(pending_map, WHEEL_SIZE);
 	struct hlist_head	vectors[WHEEL_SIZE];
+	struct hlist_head	expired_lists[LVL_DEPTH];
+	int			expired_count;
 } ____cacheline_aligned;
 
 static DEFINE_PER_CPU(struct timer_base, timer_bases[NR_BASES]);
@@ -1353,7 +1355,8 @@ static void call_timer_fn(struct timer_list *timer, void (*fn)(unsigned long),
 	}
 }
 
-static void expire_timers(struct timer_base *base, struct hlist_head *head)
+static inline void __expire_timers(struct timer_base *base,
+				   struct hlist_head *head)
 {
 	while (!hlist_empty(head)) {
 		struct timer_list *timer;
@@ -1384,21 +1387,38 @@ static void expire_timers(struct timer_base *base, struct hlist_head *head)
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
 
+	/*
+	 * expire_timers() must be called at least once before we can
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
@@ -1406,7 +1426,6 @@ static int __collect_expired_timers(struct timer_base *base,
 		/* Shift clock for the next level granularity */
 		clk >>= LVL_CLK_SHIFT;
 	}
-	return levels;
 }
 
 #ifdef CONFIG_NO_HZ_COMMON
@@ -1599,8 +1618,7 @@ void timer_clear_idle(void)
 	base->is_idle = false;
 }
 
-static int collect_expired_timers(struct timer_base *base,
-				  struct hlist_head *heads)
+static void collect_expired_timers(struct timer_base *base)
 {
 	/*
 	 * NOHZ optimization. After a long idle sleep we need to forward the
@@ -1617,20 +1635,49 @@ static int collect_expired_timers(struct timer_base *base,
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
+/* Called from CPU tick routine to quickly collect expired timers */
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
@@ -1657,22 +1704,11 @@ void update_process_times(int user_tick)
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
@@ -1700,12 +1736,12 @@ void run_local_timers(void)
 
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
@@ -1875,6 +1911,7 @@ int timers_dead_cpu(unsigned int cpu)
 		raw_spin_lock_nested(&old_base->lock, SINGLE_DEPTH_NESTING);
 
 		BUG_ON(old_base->running_timer);
+		BUG_ON(old_base->expired_count);
 
 		for (i = 0; i < WHEEL_SIZE; i++)
 			migrate_timer_list(new_base, old_base->vectors + i);
@@ -1901,6 +1938,7 @@ static void __init init_timer_cpu(int cpu)
 #ifdef CONFIG_PREEMPT_RT_FULL
 		init_swait_queue_head(&base->wait_for_running_timer);
 #endif
+		base->expired_count = 0;
 	}
 }
 
diff --git a/localversion-rt b/localversion-rt
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt5
+-rt6
