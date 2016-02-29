From: Thomas Gleixner <tglx@linutronix.de>
Subject: [ANNOUNCE] v4.4.3-rt9
Date: Mon, 29 Feb 2016 13:46:50 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1602291212180.3638@nanos>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Sebastian Sewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Dear RT folks!

I'm pleased to announce the v4.4.3-rt9 patch set. v4.4.2-rt7 and v4.4.3-rt8
are non-announced updates to incorporate the linux-4.4.y stable tree.

There is one change caused by the 4.4.3 update:

  The relaxed handling of dump_stack() on RT has been dropped as there is
  actually a potential deadlock lurking around the corner. See: commit
  d7ce36924344 upstream. This does not effect the other facilities which
  gather stack traces.

RT changes since v4.4.3-rt8:

  Clark Williams (1):
      rcu/torture: Comment out rcu_bh ops on PREEMPT_RT_FULL

  Josh Cartwright (1):
      sc16is7xx: Drop bogus use of IRQF_ONESHOT

  Mike Galbraith (4):
      sched,rt: __always_inline preemptible_lazy()
      locking/lglocks: Use preempt_enable/disable_nort() in lg_double_[un]lock
      drm,radeon,i915: Use preempt_disable/enable_rt() where recommended
      drm,i915: Use local_lock/unlock_irq() in intel_pipe_update_start/end()

  Sebastian Andrzej Siewior (1):
      kernel: sched: Fix preempt_disable_ip recording for preempt_disable()

  Thomas Gleixner (4):
      iommu/amd: Use WARN_ON_NORT in __attach_device()
      tick/broadcast: Make broadcast hrtimer irqsafe
      trace/writeback: Block cgroup path tracing on RT
      v4.4.3-rt9

  Yang Shi (2):
      trace: Use rcuidle version for preemptoff_hist trace point
      f2fs: Mutex can't be used by down_write_nest_lock()

Known issues:

  - bcache stays disabled

  - CPU hotplug is not better than before

  - The netlink_release() OOPS, reported by Clark, is still on the
    list, but unsolved due to lack of information

The delta patch against 4.4.3-rt8 is appended below and can be found here:

    https://www.kernel.org/pub/linux/kernel/projects/rt/4.4/incr/patch-4.4.3-rt8-rt9.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.4.3-rt9

The RT patch against 4.4.3 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.4/patch-4.4.3-rt9.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.4/patches-4.4.3-rt9.tar.xz

Enjoy!

	tglx

8<---------------

diff --git a/drivers/gpu/drm/i915/i915_irq.c b/drivers/gpu/drm/i915/i915_irq.c
index 0d228f909dcb..708b40a842f3 100644
--- a/drivers/gpu/drm/i915/i915_irq.c
+++ b/drivers/gpu/drm/i915/i915_irq.c
@@ -812,6 +812,7 @@ static int i915_get_crtc_scanoutpos(struct drm_device *dev, unsigned int pipe,
 	spin_lock_irqsave(&dev_priv->uncore.lock, irqflags);
 
 	/* preempt_disable_rt() should go right here in PREEMPT_RT patchset. */
+	preempt_disable_rt();
 
 	/* Get optional system timestamp before query. */
 	if (stime)
@@ -863,6 +864,7 @@ static int i915_get_crtc_scanoutpos(struct drm_device *dev, unsigned int pipe,
 		*etime = ktime_get();
 
 	/* preempt_enable_rt() should go right here in PREEMPT_RT patchset. */
+	preempt_enable_rt();
 
 	spin_unlock_irqrestore(&dev_priv->uncore.lock, irqflags);
 
diff --git a/drivers/gpu/drm/i915/intel_sprite.c b/drivers/gpu/drm/i915/intel_sprite.c
index 56dc132e8e20..8771d6646e91 100644
--- a/drivers/gpu/drm/i915/intel_sprite.c
+++ b/drivers/gpu/drm/i915/intel_sprite.c
@@ -38,6 +38,7 @@
 #include "intel_drv.h"
 #include <drm/i915_drm.h>
 #include "i915_drv.h"
+#include <linux/locallock.h>
 
 static bool
 format_is_yuv(uint32_t format)
@@ -64,6 +65,8 @@ static int usecs_to_scanlines(const struct drm_display_mode *adjusted_mode,
 			    1000 * adjusted_mode->crtc_htotal);
 }
 
+static DEFINE_LOCAL_IRQ_LOCK(pipe_update_lock);
+
 /**
  * intel_pipe_update_start() - start update of a set of display registers
  * @crtc: the crtc of which the registers are going to be updated
@@ -96,7 +99,7 @@ void intel_pipe_update_start(struct intel_crtc *crtc)
 	min = vblank_start - usecs_to_scanlines(adjusted_mode, 100);
 	max = vblank_start - 1;
 
-	local_irq_disable();
+	local_lock_irq(pipe_update_lock);
 
 	if (min <= 0 || max <= 0)
 		return;
@@ -126,11 +129,11 @@ void intel_pipe_update_start(struct intel_crtc *crtc)
 			break;
 		}
 
-		local_irq_enable();
+		local_unlock_irq(pipe_update_lock);
 
 		timeout = schedule_timeout(timeout);
 
-		local_irq_disable();
+		local_lock_irq(pipe_update_lock);
 	}
 
 	finish_wait(wq, &wait);
@@ -164,7 +167,7 @@ void intel_pipe_update_end(struct intel_crtc *crtc)
 
 	trace_i915_pipe_update_end(crtc, end_vbl_count, scanline_end);
 
-	local_irq_enable();
+	local_unlock_irq(pipe_update_lock);
 
 	if (crtc->debug.start_vbl_count &&
 	    crtc->debug.start_vbl_count != end_vbl_count) {
diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/radeon/radeon_display.c
index 1eca0acac016..99c234ae3f7b 100644
--- a/drivers/gpu/drm/radeon/radeon_display.c
+++ b/drivers/gpu/drm/radeon/radeon_display.c
@@ -1849,6 +1849,7 @@ int radeon_get_crtc_scanoutpos(struct drm_device *dev, unsigned int pipe,
 	struct radeon_device *rdev = dev->dev_private;
 
 	/* preempt_disable_rt() should go right here in PREEMPT_RT patchset. */
+	preempt_disable_rt();
 
 	/* Get optional system timestamp before query. */
 	if (stime)
@@ -1941,6 +1942,7 @@ int radeon_get_crtc_scanoutpos(struct drm_device *dev, unsigned int pipe,
 		*etime = ktime_get();
 
 	/* preempt_enable_rt() should go right here in PREEMPT_RT patchset. */
+	preempt_enable_rt();
 
 	/* Decode into vertical and horizontal scanout position. */
 	*vpos = position & 0x1fff;
diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index fc836f523afa..c20d23cdf0e6 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1952,10 +1952,10 @@ static int __attach_device(struct iommu_dev_data *dev_data,
 	int ret;
 
 	/*
-	 * Must be called with IRQs disabled. Warn here to detect early
-	 * when its not.
+	 * Must be called with IRQs disabled on a non RT kernel. Warn here to
+	 * detect early when its not.
 	 */
-	WARN_ON(!irqs_disabled());
+	WARN_ON_NONRT(!irqs_disabled());
 
 	/* lock domain */
 	spin_lock(&domain->lock);
@@ -2118,10 +2118,10 @@ static void __detach_device(struct iommu_dev_data *dev_data)
 	struct protection_domain *domain;
 
 	/*
-	 * Must be called with IRQs disabled. Warn here to detect early
-	 * when its not.
+	 * Must be called with IRQs disabled on a non RT kernel. Warn here to
+	 * detect early when its not.
 	 */
-	WARN_ON(!irqs_disabled());
+	WARN_ON_NONRT(!irqs_disabled());
 
 	if (WARN_ON(!dev_data->domain))
 		return;
diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index edb5305b9d4d..7d5ee8a13ac6 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1230,7 +1230,7 @@ static int sc16is7xx_probe(struct device *dev,
 
 	/* Setup interrupt */
 	ret = devm_request_irq(dev, irq, sc16is7xx_irq,
-			       IRQF_ONESHOT | flags, dev_name(dev), s);
+			       flags, dev_name(dev), s);
 	if (!ret)
 		return 0;
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 9db5500d63d9..5951c495d124 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -24,7 +24,6 @@
 
 #ifdef CONFIG_F2FS_CHECK_FS
 #define f2fs_bug_on(sbi, condition)	BUG_ON(condition)
-#define f2fs_down_write(x, y)	down_write_nest_lock(x, y)
 #else
 #define f2fs_bug_on(sbi, condition)					\
 	do {								\
@@ -33,7 +32,6 @@
 			set_sbi_flag(sbi, SBI_NEED_FSCK);		\
 		}							\
 	} while (0)
-#define f2fs_down_write(x, y)	down_write(x)
 #endif
 
 /*
@@ -959,7 +957,7 @@ static inline void f2fs_unlock_op(struct f2fs_sb_info *sbi)
 
 static inline void f2fs_lock_all(struct f2fs_sb_info *sbi)
 {
-	f2fs_down_write(&sbi->cp_rwsem, &sbi->cp_mutex);
+	down_write(&sbi->cp_rwsem);
 }
 
 static inline void f2fs_unlock_all(struct f2fs_sb_info *sbi)
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 60048c50404e..f2cd67624f18 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -694,6 +694,18 @@ static inline void __ftrace_enabled_restore(int enabled)
 #define CALLER_ADDR5 ((unsigned long)ftrace_return_address(5))
 #define CALLER_ADDR6 ((unsigned long)ftrace_return_address(6))
 
+static inline unsigned long get_lock_parent_ip(void)
+{
+	unsigned long addr = CALLER_ADDR0;
+
+	if (!in_lock_functions(addr))
+		return addr;
+	addr = CALLER_ADDR1;
+	if (!in_lock_functions(addr))
+		return addr;
+	return CALLER_ADDR2;
+}
+
 #ifdef CONFIG_IRQSOFF_TRACER
   extern void time_hardirqs_on(unsigned long a0, unsigned long a1);
   extern void time_hardirqs_off(unsigned long a0, unsigned long a1);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index b6a2358eb793..58c5ec8c3742 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -183,8 +183,6 @@ extern void update_cpu_load_nohz(void);
 static inline void update_cpu_load_nohz(void) { }
 #endif
 
-extern unsigned long get_parent_ip(unsigned long addr);
-
 extern void dump_cpu_task(int cpu);
 
 struct seq_file;
diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
index fff846b512e6..253ef2833c46 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -132,7 +132,7 @@ DEFINE_EVENT(writeback_dirty_inode_template, writeback_dirty_inode,
 );
 
 #ifdef CREATE_TRACE_POINTS
-#ifdef CONFIG_CGROUP_WRITEBACK
+#if defined(CONFIG_CGROUP_WRITEBACK) && !defined(CONFIG_PREEMPT_RT_FULL)
 
 static inline size_t __trace_wb_cgroup_size(struct bdi_writeback *wb)
 {
diff --git a/kernel/locking/lglock.c b/kernel/locking/lglock.c
index 51bfe64e7d16..57e0ea72c28a 100644
--- a/kernel/locking/lglock.c
+++ b/kernel/locking/lglock.c
@@ -86,7 +86,7 @@ void lg_double_lock(struct lglock *lg, int cpu1, int cpu2)
 	if (cpu2 < cpu1)
 		swap(cpu1, cpu2);
 
-	preempt_disable();
+	preempt_disable_nort();
 	lock_acquire_shared(&lg->lock_dep_map, 0, 0, NULL, _RET_IP_);
 	lg_do_lock(per_cpu_ptr(lg->lock, cpu1));
 	lg_do_lock(per_cpu_ptr(lg->lock, cpu2));
@@ -97,7 +97,7 @@ void lg_double_unlock(struct lglock *lg, int cpu1, int cpu2)
 	lock_release(&lg->lock_dep_map, 1, _RET_IP_);
 	lg_do_unlock(per_cpu_ptr(lg->lock, cpu1));
 	lg_do_unlock(per_cpu_ptr(lg->lock, cpu2));
-	preempt_enable();
+	preempt_enable_nort();
 }
 
 void lg_global_lock(struct lglock *lg)
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index d89328e260df..5bb3364a6284 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -390,6 +390,7 @@ static struct rcu_torture_ops rcu_ops = {
 	.name		= "rcu"
 };
 
+#ifndef CONFIG_PREEMPT_RT_FULL
 /*
  * Definitions for rcu_bh torture testing.
  */
@@ -429,6 +430,12 @@ static struct rcu_torture_ops rcu_bh_ops = {
 	.name		= "rcu_bh"
 };
 
+#else
+static struct rcu_torture_ops rcu_bh_ops = {
+	.ttype		= INVALID_RCU_FLAVOR,
+};
+#endif
+
 /*
  * Don't even think about trying any of these in real life!!!
  * The names includes "busted", and they really means it!
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e6627288b03d..94827a59301e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3039,16 +3039,6 @@ u64 scheduler_tick_max_deferment(void)
 }
 #endif
 
-notrace unsigned long get_parent_ip(unsigned long addr)
-{
-	if (in_lock_functions(addr)) {
-		addr = CALLER_ADDR2;
-		if (in_lock_functions(addr))
-			addr = CALLER_ADDR3;
-	}
-	return addr;
-}
-
 #if defined(CONFIG_PREEMPT) && (defined(CONFIG_DEBUG_PREEMPT) || \
 				defined(CONFIG_PREEMPT_TRACER))
 
@@ -3070,7 +3060,7 @@ void preempt_count_add(int val)
 				PREEMPT_MASK - 10);
 #endif
 	if (preempt_count() == val) {
-		unsigned long ip = get_parent_ip(CALLER_ADDR1);
+		unsigned long ip = get_lock_parent_ip();
 #ifdef CONFIG_DEBUG_PREEMPT
 		current->preempt_disable_ip = ip;
 #endif
@@ -3097,7 +3087,7 @@ void preempt_count_sub(int val)
 #endif
 
 	if (preempt_count() == val)
-		trace_preempt_on(CALLER_ADDR0, get_parent_ip(CALLER_ADDR1));
+		trace_preempt_on(CALLER_ADDR0, get_lock_parent_ip());
 	__preempt_count_sub(val);
 }
 EXPORT_SYMBOL(preempt_count_sub);
@@ -3469,7 +3459,7 @@ static void __sched notrace preempt_schedule_common(void)
  * set by a RT task. Oterwise we try to avoid beeing scheduled out as long as
  * preempt_lazy_count counter >0.
  */
-static int preemptible_lazy(void)
+static __always_inline int preemptible_lazy(void)
 {
 	if (test_thread_flag(TIF_NEED_RESCHED))
 		return 1;
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 2ca63cc1469e..cb9c1d5dee10 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -287,9 +287,9 @@ void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
 
 	if (preempt_count() == cnt) {
 #ifdef CONFIG_DEBUG_PREEMPT
-		current->preempt_disable_ip = get_parent_ip(CALLER_ADDR1);
+		current->preempt_disable_ip = get_lock_parent_ip();
 #endif
-		trace_preempt_off(CALLER_ADDR0, get_parent_ip(CALLER_ADDR1));
+		trace_preempt_off(CALLER_ADDR0, get_lock_parent_ip());
 	}
 }
 EXPORT_SYMBOL(__local_bh_disable_ip);
diff --git a/kernel/time/tick-broadcast-hrtimer.c b/kernel/time/tick-broadcast-hrtimer.c
index 53d7184da0be..1b4ac3361c3f 100644
--- a/kernel/time/tick-broadcast-hrtimer.c
+++ b/kernel/time/tick-broadcast-hrtimer.c
@@ -106,5 +106,6 @@ void tick_setup_hrtimer_broadcast(void)
 {
 	hrtimer_init(&bctimer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
 	bctimer.function = bc_handler;
+	bctimer.irqsafe = true;
 	clockevents_register_device(&ce_broadcast_hrtimer);
 }
diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index 36e584fdf863..069942c22b6b 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -421,13 +421,13 @@ void start_critical_timings(void)
 {
 	if (preempt_trace() || irq_trace())
 		start_critical_timing(CALLER_ADDR0, CALLER_ADDR1);
-	trace_preemptirqsoff_hist(TRACE_START, 1);
+	trace_preemptirqsoff_hist_rcuidle(TRACE_START, 1);
 }
 EXPORT_SYMBOL_GPL(start_critical_timings);
 
 void stop_critical_timings(void)
 {
-	trace_preemptirqsoff_hist(TRACE_STOP, 0);
+	trace_preemptirqsoff_hist_rcuidle(TRACE_STOP, 0);
 	if (preempt_trace() || irq_trace())
 		stop_critical_timing(CALLER_ADDR0, CALLER_ADDR1);
 }
@@ -437,7 +437,7 @@ EXPORT_SYMBOL_GPL(stop_critical_timings);
 #ifdef CONFIG_PROVE_LOCKING
 void time_hardirqs_on(unsigned long a0, unsigned long a1)
 {
-	trace_preemptirqsoff_hist(IRQS_ON, 0);
+	trace_preemptirqsoff_hist_rcuidle(IRQS_ON, 0);
 	if (!preempt_trace() && irq_trace())
 		stop_critical_timing(a0, a1);
 }
@@ -446,7 +446,7 @@ void time_hardirqs_off(unsigned long a0, unsigned long a1)
 {
 	if (!preempt_trace() && irq_trace())
 		start_critical_timing(a0, a1);
-	trace_preemptirqsoff_hist(IRQS_OFF, 1);
+	trace_preemptirqsoff_hist_rcuidle(IRQS_OFF, 1);
 }
 
 #else /* !CONFIG_PROVE_LOCKING */
diff --git a/localversion-rt b/localversion-rt
index 700c857efd9b..22746d6390a4 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt8
+-rt9
