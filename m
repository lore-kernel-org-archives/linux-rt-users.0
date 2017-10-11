From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [ANNOUNCE] v4.11.12-rt15
Date: Wed, 11 Oct 2017 12:35:33 +0200
Message-ID: <20171011103530.llpmvu36bekaixzh@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:60528 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752099AbdJKKfg (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 11 Oct 2017 06:35:36 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Dear RT folks!

I'm pleased to announce the v4.11.12-rt15 patch set. 

Changes since v4.11.12-rt14:

  - Programmed wake ups (nanosleep, clock_nanosleep, …) by a task with
    RT priority will still be carried out in the hardirq context
    (nothing changes). If it is programmed by task with a normal
    priority then the wake up will be carried out in the softirq
    context via the ktimersoftd thread.
    The advantage is that multiple wake ups of non-RT tasks won't
    disturb the RT task. Reported by Gratian Crisan.

  - Paul Gortmaker reported splat during boot when TSC (on x86) becomes
    unstable and kernel switches to an alternative. This has been fixed
    by cherry-picking a patch from upstream.

  - After the hrtimer rework, certain wake ups (like those programmed in
    the past using the softirq context) won't fire. Reported by Mike
    Galbraith, patched by Anna-Maria Gleixner.

  - After the hrtimer rework, wake ups using CLOCK_REALTIME and a
    relative delay were affected by clock_settime() (they should have
    not been). Reported by Mike Galbraith.

Known issues
	None

The delta patch against v4.11.12-rt14 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.11/incr/patch-4.11.12-rt14-rt15.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.11.12-rt15

The RT patch against v4.11.12 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.11/older/patch-4.11.12-rt15.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.11/older/patches-4.11.12-rt15.tar.xz

Sebastian
diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
--- a/kernel/sched/clock.c
+++ b/kernel/sched/clock.c
@@ -124,6 +124,12 @@ int sched_clock_stable(void)
 	return static_branch_likely(&__sched_clock_stable);
 }
 
+static void __scd_stamp(struct sched_clock_data *scd)
+{
+	scd->tick_gtod = ktime_get_ns();
+	scd->tick_raw = sched_clock();
+}
+
 static void __set_sched_clock_stable(void)
 {
 	struct sched_clock_data *scd;
@@ -148,8 +154,37 @@ static void __set_sched_clock_stable(void)
 	tick_dep_clear(TICK_DEP_BIT_CLOCK_UNSTABLE);
 }
 
+/*
+ * If we ever get here, we're screwed, because we found out -- typically after
+ * the fact -- that TSC wasn't good. This means all our clocksources (including
+ * ktime) could have reported wrong values.
+ *
+ * What we do here is an attempt to fix up and continue sort of where we left
+ * off in a coherent manner.
+ *
+ * The only way to fully avoid random clock jumps is to boot with:
+ * "tsc=unstable".
+ */
 static void __sched_clock_work(struct work_struct *work)
 {
+	struct sched_clock_data *scd;
+	int cpu;
+
+	/* take a current timestamp and set 'now' */
+	preempt_disable();
+	scd = this_scd();
+	__scd_stamp(scd);
+	scd->clock = scd->tick_gtod + __gtod_offset;
+	preempt_enable();
+
+	/* clone to all CPUs */
+	for_each_possible_cpu(cpu)
+		per_cpu(sched_clock_data, cpu) = *scd;
+
+	printk(KERN_INFO "sched_clock: Marking unstable (%lld, %lld)<-(%lld, %lld)\n",
+			scd->tick_gtod, __gtod_offset,
+			scd->tick_raw,  __sched_clock_offset);
+
 	static_branch_disable(&__sched_clock_stable);
 }
 
@@ -157,27 +192,11 @@ static DECLARE_WORK(sched_clock_work, __sched_clock_work);
 
 static void __clear_sched_clock_stable(void)
 {
-	struct sched_clock_data *scd = this_scd();
-
-	/*
-	 * Attempt to make the stable->unstable transition continuous.
-	 *
-	 * Trouble is, this is typically called from the TSC watchdog
-	 * timer, which is late per definition. This means the tick
-	 * values can already be screwy.
-	 *
-	 * Still do what we can.
-	 */
-	__gtod_offset = (scd->tick_raw + __sched_clock_offset) - (scd->tick_gtod);
-
-	printk(KERN_INFO "sched_clock: Marking unstable (%lld, %lld)<-(%lld, %lld)\n",
-			scd->tick_gtod, __gtod_offset,
-			scd->tick_raw,  __sched_clock_offset);
+	if (!sched_clock_stable())
+		return;
 
 	tick_dep_set(TICK_DEP_BIT_CLOCK_UNSTABLE);
-
-	if (sched_clock_stable())
-		schedule_work(&sched_clock_work);
+	schedule_work(&sched_clock_work);
 }
 
 void clear_sched_clock_stable(void)
@@ -364,8 +383,7 @@ void sched_clock_tick(void)
 	 * XXX arguably we can skip this if we expose tsc_clocksource_reliable
 	 */
 	scd = this_scd();
-	scd->tick_raw  = sched_clock();
-	scd->tick_gtod = ktime_get_ns();
+	__scd_stamp(scd);
 
 	if (!sched_clock_stable() && likely(sched_clock_running))
 		sched_clock_local(scd);
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -562,8 +562,14 @@ static inline ktime_t hrtimer_update_base(struct hrtimer_cpu_base *base)
 	ktime_t *offs_boot = &base->clock_base[HRTIMER_BASE_BOOTTIME].offset;
 	ktime_t *offs_tai = &base->clock_base[HRTIMER_BASE_TAI].offset;
 
-	return ktime_get_update_offsets_now(&base->clock_was_set_seq,
+	ktime_t now = ktime_get_update_offsets_now(&base->clock_was_set_seq,
 					    offs_real, offs_boot, offs_tai);
+
+	base->clock_base[HRTIMER_BASE_REALTIME_SOFT].offset = *offs_real;
+	base->clock_base[HRTIMER_BASE_BOOTTIME_SOFT].offset = *offs_boot;
+	base->clock_base[HRTIMER_BASE_TAI_SOFT].offset = *offs_tai;
+
+	return now;
 }
 
 /*
@@ -1252,6 +1258,8 @@ static void __hrtimer_init(struct hrtimer *timer, clockid_t clock_id,
 			clock_id = CLOCK_MONOTONIC;
 		else if (clock_id == CLOCK_REALTIME_SOFT)
 			clock_id = CLOCK_MONOTONIC_SOFT;
+		else if (clock_id == CLOCK_REALTIME_HARD)
+			clock_id = CLOCK_MONOTONIC_HARD;
 	}
 
 	base = hrtimer_clockid_to_base(clock_id);
@@ -1622,14 +1630,31 @@ static enum hrtimer_restart hrtimer_wakeup(struct hrtimer *timer)
 	return HRTIMER_NORESTART;
 }
 
+#ifdef CONFIG_PREEMPT_RT_FULL
+static bool task_is_elevated(struct task_struct *tsk)
+{
+	int policy = tsk->policy;
+
+	if (policy == SCHED_FIFO || policy == SCHED_RR)
+		return true;
+	if (policy == SCHED_DEADLINE)
+		return true;
+	return false;
+}
+#endif
+
 static void __hrtimer_init_sleeper(struct hrtimer_sleeper *sl,
 				   clockid_t clock_id,
 				   enum hrtimer_mode mode,
 				   struct task_struct *task)
 {
 #ifdef CONFIG_PREEMPT_RT_FULL
-	if (!(clock_id & HRTIMER_BASE_SOFT_MASK))
-		clock_id |= HRTIMER_BASE_HARD_MASK;
+	if (!(clock_id & (HRTIMER_BASE_HARD_MASK | HRTIMER_BASE_SOFT_MASK))) {
+		if (task_is_elevated(current) || system_state != SYSTEM_RUNNING)
+			clock_id |= HRTIMER_BASE_HARD_MASK;
+		else
+			clock_id |= HRTIMER_BASE_SOFT_MASK;
+	}
 #endif
 	__hrtimer_init(&sl->timer, clock_id, mode);
 	sl->timer.function = hrtimer_wakeup;
diff --git a/localversion-rt b/localversion-rt
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt14
+-rt15
