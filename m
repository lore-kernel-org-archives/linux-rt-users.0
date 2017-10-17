From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [ANNOUNCE] v4.11.12-rt16
Date: Tue, 17 Oct 2017 15:54:19 +0200
Message-ID: <20171017135419.vyt5bxxkzyse2dsb@linutronix.de>
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

I'm pleased to announce the v4.11.12-rt16 patch set. 

Changes since v4.11.12-rt15:

  - Paul Gortmaker reported, that the unstable-TSC fixup on x86 need one
    additional patch from upstream.

  - Apparmor is protecting per-CPU variables with preempt-disable
    resulting in "sleeping while atomic" warnings.

Known issues
	None

The delta patch against v4.11.12-rt15 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.11/incr/patch-4.11.12-rt15-rt16.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.11.12-rt16

The RT patch against v4.11.12 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.11/older/patch-4.11.12-rt16.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.11/older/patches-4.11.12-rt16.tar.xz

Sebastian
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1127,6 +1127,15 @@ static void tsc_cs_mark_unstable(struct clocksource *cs)
 	pr_info("Marking TSC unstable due to clocksource watchdog\n");
 }
 
+static void tsc_cs_tick_stable(struct clocksource *cs)
+{
+	if (tsc_unstable)
+		return;
+
+	if (using_native_sched_clock())
+		sched_clock_tick_stable();
+}
+
 /*
  * .mask MUST be CLOCKSOURCE_MASK(64). See comment above read_tsc()
  */
@@ -1140,6 +1149,7 @@ static struct clocksource clocksource_tsc = {
 	.archdata               = { .vclock_mode = VCLOCK_TSC },
 	.resume			= tsc_resume,
 	.mark_unstable		= tsc_cs_mark_unstable,
+	.tick_stable		= tsc_cs_tick_stable,
 };
 
 void mark_tsc_unstable(char *reason)
diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -96,6 +96,7 @@ struct clocksource {
 	void (*suspend)(struct clocksource *cs);
 	void (*resume)(struct clocksource *cs);
 	void (*mark_unstable)(struct clocksource *cs);
+	void (*tick_stable)(struct clocksource *cs);
 
 	/* private: */
 #ifdef CONFIG_CLOCKSOURCE_WATCHDOG
diff --git a/include/linux/sched/clock.h b/include/linux/sched/clock.h
--- a/include/linux/sched/clock.h
+++ b/include/linux/sched/clock.h
@@ -63,8 +63,8 @@ extern void clear_sched_clock_stable(void);
  */
 extern u64 __sched_clock_offset;
 
-
 extern void sched_clock_tick(void);
+extern void sched_clock_tick_stable(void);
 extern void sched_clock_idle_sleep_event(void);
 extern void sched_clock_idle_wakeup_event(u64 delta_ns);
 
diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
--- a/kernel/sched/clock.c
+++ b/kernel/sched/clock.c
@@ -373,20 +373,38 @@ void sched_clock_tick(void)
 {
 	struct sched_clock_data *scd;
 
+	if (sched_clock_stable())
+		return;
+
+	if (unlikely(!sched_clock_running))
+		return;
+
 	WARN_ON_ONCE(!irqs_disabled());
 
-	/*
-	 * Update these values even if sched_clock_stable(), because it can
-	 * become unstable at any point in time at which point we need some
-	 * values to fall back on.
-	 *
-	 * XXX arguably we can skip this if we expose tsc_clocksource_reliable
-	 */
 	scd = this_scd();
 	__scd_stamp(scd);
+	sched_clock_local(scd);
+}
 
-	if (!sched_clock_stable() && likely(sched_clock_running))
-		sched_clock_local(scd);
+void sched_clock_tick_stable(void)
+{
+	u64 gtod, clock;
+
+	if (!sched_clock_stable())
+		return;
+
+	/*
+	 * Called under watchdog_lock.
+	 *
+	 * The watchdog just found this TSC to (still) be stable, so now is a
+	 * good moment to update our __gtod_offset. Because once we find the
+	 * TSC to be unstable, any computation will be computing crap.
+	 */
+	local_irq_disable();
+	gtod = ktime_get_ns();
+	clock = sched_clock();
+	__gtod_offset = (clock + __sched_clock_offset) - gtod;
+	local_irq_enable();
 }
 
 /*
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -233,6 +233,9 @@ static void clocksource_watchdog(unsigned long data)
 			continue;
 		}
 
+		if (cs == curr_clocksource && cs->tick_stable)
+			cs->tick_stable(cs);
+
 		if (!(cs->flags & CLOCK_SOURCE_VALID_FOR_HRES) &&
 		    (cs->flags & CLOCK_SOURCE_IS_CONTINUOUS) &&
 		    (watchdog->flags & CLOCK_SOURCE_IS_CONTINUOUS)) {
diff --git a/localversion-rt b/localversion-rt
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt15
+-rt16
diff --git a/security/apparmor/include/path.h b/security/apparmor/include/path.h
--- a/security/apparmor/include/path.h
+++ b/security/apparmor/include/path.h
@@ -38,9 +38,10 @@ struct aa_buffers {
 };
 
 #include <linux/percpu.h>
-#include <linux/preempt.h>
+#include <linux/locallock.h>
 
 DECLARE_PER_CPU(struct aa_buffers, aa_buffers);
+DECLARE_LOCAL_IRQ_LOCK(aa_buffers_lock);
 
 #define COUNT_ARGS(X...) COUNT_ARGS_HELPER(, ##X, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0)
 #define COUNT_ARGS_HELPER(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, n, X...) n
@@ -54,12 +55,24 @@ DECLARE_PER_CPU(struct aa_buffers, aa_buffers);
 
 #define for_each_cpu_buffer(I) for ((I) = 0; (I) < MAX_PATH_BUFFERS; (I)++)
 
-#ifdef CONFIG_DEBUG_PREEMPT
+#ifdef CONFIG_PREEMPT_RT_BASE
+
+static inline void AA_BUG_PREEMPT_ENABLED(const char *s)
+{
+	struct local_irq_lock *lv;
+
+	lv = this_cpu_ptr(&aa_buffers_lock);
+	WARN_ONCE(lv->owner != current,
+		  "__get_buffer without aa_buffers_lock\n");
+}
+
+#elif CONFIG_DEBUG_PREEMPT
 #define AA_BUG_PREEMPT_ENABLED(X) AA_BUG(preempt_count() <= 0, X)
 #else
 #define AA_BUG_PREEMPT_ENABLED(X) /* nop */
 #endif
 
+
 #define __get_buffer(N) ({					\
 	struct aa_buffers *__cpu_var; \
 	AA_BUG_PREEMPT_ENABLED("__get_buffer without preempt disabled");  \
@@ -72,14 +85,14 @@ DECLARE_PER_CPU(struct aa_buffers, aa_buffers);
 
 #define get_buffers(X...)	\
 do {				\
-	preempt_disable();	\
+	local_lock(aa_buffers_lock);	\
 	__get_buffers(X);	\
 } while (0)
 
 #define put_buffers(X, Y...)	\
 do {				\
 	__put_buffers(X, Y);	\
-	preempt_enable();	\
+	local_unlock(aa_buffers_lock);	\
 } while (0)
 
 #endif /* __AA_PATH_H */
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -42,7 +42,7 @@
 int apparmor_initialized __initdata;
 
 DEFINE_PER_CPU(struct aa_buffers, aa_buffers);
-
+DEFINE_LOCAL_IRQ_LOCK(aa_buffers_lock);
 
 /*
  * LSM hook functions
