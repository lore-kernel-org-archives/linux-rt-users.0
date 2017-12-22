From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [ANNOUNCE] v4.14.8-rt9
Date: Fri, 22 Dec 2017 17:41:03 +0100
Message-ID: <20171222164103.jbmpxybwgftdi3ue@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:58090 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751966AbdLVQlG (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 22 Dec 2017 11:41:06 -0500
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Dear RT folks!

I'm pleased to announce the v4.14.8-rt9 patch set. 

Changes since v4.14.8-rt8:

  - Tom Zanussi's "tracing: Inter-event (e.g. latency) support" patch
    has been updated to v8.

  - The hrtimer-softirq rewrite by Anna-Maria has been updated to v4
    (last I claimed I updated to v4 I updated to v3). This update includes
    the following fix:
    - Add bh_disable/enable() with a comment in hrtimers_dead_cpu().
      Lockdep complained about a possible deadlock, reported by Grygorii
      Strashko.

  - Merge the series "timer/nohz: Fix timer/nohz woes" with NOHZ / timer
    related fixes by Anna-Maria and Thomas Gleixner.

  - The known issue "crash on UP system with a SMP kernel" reported last
    time has been resolved by a patch in from Steven Rostedt which is
    part of v4.14.8.

Known issues
     - A warning triggered in "rcu_note_context_switch" originated from
       SyS_timer_gettime(). The issue was always there, it is now
       visible. Reported by Grygorii Strashko and Daniel Wagner.

The delta patch against v4.14.8-rt8 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.14/incr/patch-4.14.8-rt8-rt9.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.14.8-rt9

The RT patch against v4.14.8 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.14/older/patch-4.14.8-rt9.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.14/older/patches-4.14.8-rt9.tar.xz

Sebastian

diff --git a/kernel/softirq.c b/kernel/softirq.c
index d9fbc5ff378f..5c9ecaed3645 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -838,7 +838,8 @@ static inline void tick_irq_exit(void)
 	int cpu = smp_processor_id();
 
 	/* Make sure that timer wheel updates are propagated */
-	if ((idle_cpu(cpu) && !need_resched()) || tick_nohz_full_cpu(cpu)) {
+	if ((idle_cpu(cpu) || tick_nohz_full_cpu(cpu)) &&
+	    !need_resched() && !local_softirq_pending()) {
 		if (!in_interrupt())
 			tick_nohz_irq_exit();
 	}
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index c2c344fda487..fb3413d2b738 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -68,9 +68,6 @@
 #define HRTIMER_ACTIVE_SOFT	(HRTIMER_ACTIVE_HARD << MASK_SHIFT)
 #define HRTIMER_ACTIVE_ALL	(HRTIMER_ACTIVE_SOFT | HRTIMER_ACTIVE_HARD)
 
-/* Define for debug mode check */
-#define HRTIMER_MODECHECK	true
-
 /*
  * The timer bases:
  *
@@ -415,18 +412,8 @@ static inline void debug_hrtimer_init(struct hrtimer *timer)
 }
 
 static inline void debug_hrtimer_activate(struct hrtimer *timer,
-					  enum hrtimer_mode mode,
-					  bool modecheck)
+					  enum hrtimer_mode mode)
 {
-	/*
-	 * Check whether the HRTIMER_MODE_SOFT bit and hrtimer.is_soft
-	 * match, when a timer is started via__hrtimer_start_range_ns().
-	 */
-#ifndef CONFIG_PREEMPT_RT_BASE
-	if (modecheck)
-		WARN_ON_ONCE(!(mode & HRTIMER_MODE_SOFT) ^ !timer->is_soft);
-#endif
-
 	debug_object_activate(timer, &hrtimer_debug_descr);
 }
 
@@ -461,8 +448,7 @@ EXPORT_SYMBOL_GPL(destroy_hrtimer_on_stack);
 
 static inline void debug_hrtimer_init(struct hrtimer *timer) { }
 static inline void debug_hrtimer_activate(struct hrtimer *timer,
-					  enum hrtimer_mode mode,
-					  bool modecheck) { }
+					  enum hrtimer_mode mode) { }
 static inline void debug_hrtimer_deactivate(struct hrtimer *timer) { }
 #endif
 
@@ -475,10 +461,9 @@ debug_init(struct hrtimer *timer, clockid_t clockid,
 }
 
 static inline void debug_activate(struct hrtimer *timer,
-				  enum hrtimer_mode mode,
-				  bool modecheck)
+				  enum hrtimer_mode mode)
 {
-	debug_hrtimer_activate(timer, mode, modecheck);
+	debug_hrtimer_activate(timer, mode);
 	trace_hrtimer_start(timer, mode);
 }
 
@@ -491,15 +476,15 @@ static inline void debug_deactivate(struct hrtimer *timer)
 static struct hrtimer_clock_base *
 __next_base(struct hrtimer_cpu_base *cpu_base, unsigned int *active)
 {
-	struct hrtimer_clock_base *base = NULL;
+	unsigned int idx;
 
-	if (*active) {
-		unsigned int idx = __ffs(*active);
-		*active &= ~(1U << idx);
-		base = &cpu_base->clock_base[idx];
-	}
+	if (!*active)
+		return NULL;
 
-	return base;
+	idx = __ffs(*active);
+	*active &= ~(1U << idx);
+
+	return &cpu_base->clock_base[idx];
 }
 
 #define for_each_active_base(base, cpu_base, active)	\
@@ -546,11 +531,11 @@ static ktime_t __hrtimer_next_event_base(struct hrtimer_cpu_base *cpu_base,
  * hrtimer_run_softirq(), hrtimer_update_softirq_timer() will re-add these bases.
  *
  * Therefore softirq values are those from the HRTIMER_ACTIVE_SOFT clock bases.
- * The !softirq values are the minima across HRTIMER_ACTIVE, unless an actual
+ * The !softirq values are the minima across HRTIMER_ACTIVE_ALL, unless an actual
  * softirq is pending, in which case they're the minima of HRTIMER_ACTIVE_HARD.
  *
  * @active_mask must be one of:
- *  - HRTIMER_ACTIVE,
+ *  - HRTIMER_ACTIVE_ALL,
  *  - HRTIMER_ACTIVE_SOFT, or
  *  - HRTIMER_ACTIVE_HARD.
  */
@@ -801,6 +786,13 @@ static void hrtimer_reprogram(struct hrtimer *timer, bool reprogram)
 		expires = 0;
 
 	if (timer->is_soft) {
+		/*
+		 * soft hrtimer could be started on a remote CPU. In this
+		 * case softirq_expires_next needs to be updated on the
+		 * remote CPU. The soft hrtimer will not expire before the
+		 * first hard hrtimer on the remote CPU -
+		 * hrtimer_check_target() prevents this case.
+		 */
 		struct hrtimer_cpu_base *timer_cpu_base = base->cpu_base;
 
 		if (timer_cpu_base->softirq_activated)
@@ -995,10 +987,9 @@ void hrtimer_wait_for_timer(const struct hrtimer *timer)
  */
 static int enqueue_hrtimer(struct hrtimer *timer,
 			   struct hrtimer_clock_base *base,
-			   enum hrtimer_mode mode,
-			   bool modecheck)
+			   enum hrtimer_mode mode)
 {
-	debug_activate(timer, mode, modecheck);
+	debug_activate(timer, mode);
 
 	base->cpu_base->active_bases |= 1 << base->index;
 
@@ -1104,7 +1095,7 @@ hrtimer_update_softirq_timer(struct hrtimer_cpu_base *cpu_base, bool reprogram)
 	 * hrtimer expires at the same time than the next hard
 	 * hrtimer. cpu_base->softirq_expires_next needs to be updated!
 	 */
-	if (!reprogram || expires == KTIME_MAX)
+	if (expires == KTIME_MAX)
 		return;
 
 	/*
@@ -1133,8 +1124,9 @@ static int __hrtimer_start_range_ns(struct hrtimer *timer, ktime_t tim,
 	/* Switch the timer base, if necessary: */
 	new_base = switch_hrtimer_base(timer, base, mode & HRTIMER_MODE_PINNED);
 
-	return enqueue_hrtimer(timer, new_base, mode, HRTIMER_MODECHECK);
+	return enqueue_hrtimer(timer, new_base, mode);
 }
+
 /**
  * hrtimer_start_range_ns - (re)start an hrtimer
  * @timer:	the timer to be added
@@ -1150,6 +1142,14 @@ void hrtimer_start_range_ns(struct hrtimer *timer, ktime_t tim,
 	struct hrtimer_clock_base *base;
 	unsigned long flags;
 
+	/*
+	 * Check whether the HRTIMER_MODE_SOFT bit and hrtimer.is_soft
+	 * match.
+	 */
+#ifndef CONFIG_PREEMPT_RT_BASE
+	WARN_ON_ONCE(!(mode & HRTIMER_MODE_SOFT) ^ !timer->is_soft);
+#endif
+
 	base = lock_hrtimer_base(timer, &flags);
 
 	if (__hrtimer_start_range_ns(timer, tim, delta_ns, mode, base))
@@ -1424,8 +1424,7 @@ static void __run_hrtimer(struct hrtimer_cpu_base *cpu_base,
 	 */
 	if (restart != HRTIMER_NORESTART &&
 	    !(timer->state & HRTIMER_STATE_ENQUEUED))
-		enqueue_hrtimer(timer, base, HRTIMER_MODE_ABS,
-				!HRTIMER_MODECHECK);
+		enqueue_hrtimer(timer, base, HRTIMER_MODE_ABS);
 
 	/*
 	 * Separate the ->running assignment from the ->state assignment.
@@ -1939,8 +1938,7 @@ static void migrate_hrtimer_list(struct hrtimer_clock_base *old_base,
 		 * sort out already expired timers and reprogram the
 		 * event device.
 		 */
-		enqueue_hrtimer(timer, new_base, HRTIMER_MODE_ABS,
-				!HRTIMER_MODECHECK);
+		enqueue_hrtimer(timer, new_base, HRTIMER_MODE_ABS);
 	}
 }
 
@@ -1952,6 +1950,12 @@ int hrtimers_dead_cpu(unsigned int scpu)
 	BUG_ON(cpu_online(scpu));
 	tick_cancel_sched_timer(scpu);
 
+	/*
+	 * this BH disable ensures that raise_softirq_irqoff() does
+	 * not wakeup ksoftirqd (and acquire the pi-lock) while
+	 * holding the cpu_base lock
+	 */
+	local_bh_disable();
 	local_irq_disable();
 	old_base = &per_cpu(hrtimer_bases, scpu);
 	new_base = this_cpu_ptr(&hrtimer_bases);
@@ -1979,6 +1983,7 @@ int hrtimers_dead_cpu(unsigned int scpu)
 	/* Check, if we got expired work to do */
 	__hrtimer_peek_ahead_timers();
 	local_irq_enable();
+	local_bh_enable();
 	return 0;
 }
 
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 40ac38728b7a..26210086c562 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -844,11 +844,10 @@ static inline struct timer_base *get_timer_cpu_base(u32 tflags, u32 cpu)
 	struct timer_base *base = per_cpu_ptr(&timer_bases[BASE_STD], cpu);
 
 	/*
-	 * If the timer is deferrable and nohz is active then we need to use
-	 * the deferrable base.
+	 * If the timer is deferrable and NO_HZ_COMMON is set then we need
+	 * to use the deferrable base.
 	 */
-	if (is_timers_nohz_active() &&
-	    (tflags & TIMER_DEFERRABLE))
+	if (IS_ENABLED(CONFIG_NO_HZ_COMMON) && (tflags & TIMER_DEFERRABLE))
 		base = per_cpu_ptr(&timer_bases[BASE_DEF], cpu);
 	return base;
 }
@@ -858,11 +857,10 @@ static inline struct timer_base *get_timer_this_cpu_base(u32 tflags)
 	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
 
 	/*
-	 * If the timer is deferrable and nohz is active then we need to use
-	 * the deferrable base.
+	 * If the timer is deferrable and NO_HZ_COMMON is set then we need
+	 * to use the deferrable base.
 	 */
-	if (is_timers_nohz_active() &&
-	    (tflags & TIMER_DEFERRABLE))
+	if (IS_ENABLED(CONFIG_NO_HZ_COMMON) && (tflags & TIMER_DEFERRABLE))
 		base = this_cpu_ptr(&timer_bases[BASE_DEF]);
 	return base;
 }
@@ -1005,8 +1003,6 @@ __mod_timer(struct timer_list *timer, unsigned long expires, bool pending_only)
 	if (!ret && pending_only)
 		goto out_unlock;
 
-	debug_activate(timer, expires);
-
 	new_base = get_target_base(base, timer->flags);
 
 	if (base != new_base) {
@@ -1030,6 +1026,8 @@ __mod_timer(struct timer_list *timer, unsigned long expires, bool pending_only)
 		}
 	}
 
+	debug_activate(timer, expires);
+
 	timer->expires = expires;
 	/*
 	 * If 'idx' was calculated above and the base time did not advance
@@ -1696,7 +1694,7 @@ static __latent_entropy void run_timer_softirq(struct softirq_action *h)
 	base->must_forward_clk = false;
 
 	__run_timers(base);
-	if (is_timers_nohz_active())
+	if (IS_ENABLED(CONFIG_NO_HZ_COMMON))
 		__run_timers(this_cpu_ptr(&timer_bases[BASE_DEF]));
 }
 
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index e244f26d4761..8a00d4da91f2 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -613,7 +613,7 @@ static enum print_line_t print_synth_event(struct trace_iterator *iter,
 		/* parameter values */
 		if (se->fields[i]->is_string) {
 			trace_seq_printf(s, print_fmt, se->fields[i]->name,
-					 (char *)(long)entry->fields[n_u64],
+					 (char *)&entry->fields[n_u64],
 					 i == se->n_fields - 1 ? "" : " ");
 			n_u64 += STR_VAR_LEN_MAX / sizeof(u64);
 		} else {
@@ -1500,37 +1500,25 @@ static struct trace_event_file *find_var_file(struct trace_array *tr,
 {
 	struct hist_trigger_data *var_hist_data;
 	struct hist_var_data *var_data;
-	struct trace_event_call *call;
 	struct trace_event_file *file, *found = NULL;
-	const char *name;
+
+	if (system)
+		return find_event_file(tr, system, event_name);
 
 	list_for_each_entry(var_data, &tr->hist_vars, list) {
 		var_hist_data = var_data->hist_data;
 		file = var_hist_data->event_file;
 		if (file == found)
 			continue;
-		call = file->event_call;
-		name = trace_event_name(call);
 
-		if (!system || !event_name) {
-			if (find_var(var_hist_data, file, var_name)) {
-				if (found) {
-					hist_err_event("Variable name not unique, need to use fully qualified name (subsys.event.var) for variable: ", system, event_name, var_name);
-					return NULL;
-				}
-
-				found = file;
+		if (find_var_field(var_hist_data, var_name)) {
+			if (found) {
+				hist_err_event("Variable name not unique, need to use fully qualified name (subsys.event.var) for variable: ", system, event_name, var_name);
+				return NULL;
 			}
-			continue;
+
+			found = file;
 		}
-
-		if (strcmp(event_name, name) != 0)
-			continue;
-		if (strcmp(system, call->class->system) != 0)
-			continue;
-
-		found = file;
-		break;
 	}
 
 	return found;
@@ -1977,7 +1965,7 @@ static void hist_trigger_elt_data_free(struct tracing_map_elt *elt)
 static int hist_trigger_elt_data_alloc(struct tracing_map_elt *elt)
 {
 	struct hist_trigger_data *hist_data = elt->map->private_data;
-	unsigned int size = TASK_COMM_LEN + 1;
+	unsigned int size = TASK_COMM_LEN;
 	struct hist_elt_data *elt_data;
 	struct hist_field *key_field;
 	unsigned int i, n_str;
diff --git a/lib/timerqueue.c b/lib/timerqueue.c
index 4a720ed4fdaf..0d54bcbc8170 100644
--- a/lib/timerqueue.c
+++ b/lib/timerqueue.c
@@ -33,8 +33,9 @@
  * @head: head of timerqueue
  * @node: timer node to be added
  *
- * Adds the timer node to the timerqueue, sorted by the
- * node's expires value.
+ * Adds the timer node to the timerqueue, sorted by the node's expires
+ * value. Returns true if the newly added timer is the first expiring timer in
+ * the queue.
  */
 bool timerqueue_add(struct timerqueue_head *head, struct timerqueue_node *node)
 {
@@ -70,7 +71,8 @@ EXPORT_SYMBOL_GPL(timerqueue_add);
  * @head: head of timerqueue
  * @node: timer node to be removed
  *
- * Removes the timer node from the timerqueue.
+ * Removes the timer node from the timerqueue. Returns true if the queue is
+ * not empty after the remove.
  */
 bool timerqueue_del(struct timerqueue_head *head, struct timerqueue_node *node)
 {
diff --git a/localversion-rt b/localversion-rt
index 700c857efd9b..22746d6390a4 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt8
+-rt9
