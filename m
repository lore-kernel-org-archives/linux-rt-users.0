From: Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] 4.1.15-rt18
Date: Mon, 7 Mar 2016 15:52:05 -0500
Message-ID: <20160307155205.21f1bb95@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


Dear RT Folks,

I'm pleased to announce the 4.1.15-rt18 stable release.


You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.1-rt
  Head SHA1: 609a831b25ff68704219f035ae514e2a57647d29


Or to build 4.1.15-rt18 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-4.1.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-4.1.15.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.1/patch-4.1.15-rt18.patch.xz



You can also build from 4.1.15-rt17 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.1/incr/patch-4.1.15-rt17-rt18.patch.xz



Enjoy,

-- Steve


Changes from v4.1.15-rt17:

---

Clark Williams (1):
      rcu/torture: Comment out rcu_bh ops on PREEMPT_RT_FULL

Mike Galbraith (3):
      sched,rt: __always_inline preemptible_lazy()
      drm,radeon,i915: Use preempt_disable/enable_rt() where recommended
      drm,i915: Use local_lock/unlock_irq() in intel_pipe_update_start/end()

Sebastian Andrzej Siewior (13):
      sched: reset task's lockless wake-queues on fork()
      ptrace: don't open IRQs in ptrace_freeze_traced() too early
      net: move xmit_recursion to per-task variable on -RT
      kernel/softirq: use cond_resched_rcu_qs() on -RT as well (run_ksoftirqd())
      net/core: protect users of napi_alloc_cache against reentrance
      preempt-lazy: Add the lazy-preemption check to preempt_schedule()
      softirq: split timer softirqs out of ksoftirqd
      net: provide a way to delegate processing a softirq to ksoftirqd
      latencyhist: disable jump-labels
      kernel: migrate_disable() do fastpath in atomic & irqs-off
      kernel: softirq: unlock with irqs on
      kernel/stop_machine: partly revert "stop_machine: Use raw spinlocks"
      kernel: sched: Fix preempt_disable_ip recodring for preempt_disable()

Steven Rostedt (Red Hat) (1):
      Linux 4.1.15-rt18

Thomas Gleixner (1):
      tick/broadcast: Make broadcast hrtimer irqsafe

Yang Shi (3):
      arm64: replace read_lock to rcu lock in call_step_hook
      trace: Use rcuidle version for preemptoff_hist trace point
      f2fs: Mutex can't be used by down_write_nest_lock()

----
 arch/Kconfig                            |   1 +
 arch/arm64/kernel/debug-monitors.c      |  21 +++---
 drivers/gpu/drm/i915/i915_irq.c         |   2 +
 drivers/gpu/drm/i915/intel_sprite.c     |  11 +--
 drivers/gpu/drm/radeon/radeon_display.c |   2 +
 fs/f2fs/f2fs.h                          |   4 +-
 include/linux/ftrace.h                  |  12 ++++
 include/linux/interrupt.h               |   8 +++
 include/linux/netdevice.h               |   9 +++
 include/linux/sched.h                   |   5 +-
 kernel/fork.c                           |   1 +
 kernel/ptrace.c                         |   6 +-
 kernel/rcu/rcutorture.c                 |   7 ++
 kernel/sched/core.c                     |  54 +++++++++------
 kernel/softirq.c                        | 116 +++++++++++++++++++++++++++-----
 kernel/stop_machine.c                   |  40 +++--------
 kernel/time/tick-broadcast-hrtimer.c    |   1 +
 kernel/trace/trace_irqsoff.c            |   8 +--
 localversion-rt                         |   2 +-
 net/core/dev.c                          |  43 ++++++++++--
 net/core/skbuff.c                       |   8 ++-
 21 files changed, 261 insertions(+), 100 deletions(-)
---------------------------
diff --git a/arch/Kconfig b/arch/Kconfig
index cb27d367b24a..78d3ed24484a 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -50,6 +50,7 @@ config KPROBES
 config JUMP_LABEL
        bool "Optimize very unlikely/likely branches"
        depends on HAVE_ARCH_JUMP_LABEL
+       depends on (!INTERRUPT_OFF_HIST && !PREEMPT_OFF_HIST && !WAKEUP_LATENCY_HIST && !MISSED_TIMER_OFFSETS_HIST)
        help
          This option enables a transparent branch optimization that
 	 makes certain almost-always-true or almost-always-false branch
diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index 70654d843d9b..0d1d675f2cce 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -184,20 +184,21 @@ static void clear_regs_spsr_ss(struct pt_regs *regs)
 
 /* EL1 Single Step Handler hooks */
 static LIST_HEAD(step_hook);
-static DEFINE_RWLOCK(step_hook_lock);
+static DEFINE_SPINLOCK(step_hook_lock);
 
 void register_step_hook(struct step_hook *hook)
 {
-	write_lock(&step_hook_lock);
-	list_add(&hook->node, &step_hook);
-	write_unlock(&step_hook_lock);
+	spin_lock(&step_hook_lock);
+	list_add_rcu(&hook->node, &step_hook);
+	spin_unlock(&step_hook_lock);
 }
 
 void unregister_step_hook(struct step_hook *hook)
 {
-	write_lock(&step_hook_lock);
-	list_del(&hook->node);
-	write_unlock(&step_hook_lock);
+	spin_lock(&step_hook_lock);
+	list_del_rcu(&hook->node);
+	spin_unlock(&step_hook_lock);
+	synchronize_rcu();
 }
 
 /*
@@ -211,15 +212,15 @@ static int call_step_hook(struct pt_regs *regs, unsigned int esr)
 	struct step_hook *hook;
 	int retval = DBG_HOOK_ERROR;
 
-	read_lock(&step_hook_lock);
+	rcu_read_lock();
 
-	list_for_each_entry(hook, &step_hook, node)	{
+	list_for_each_entry_rcu(hook, &step_hook, node)	{
 		retval = hook->fn(regs, esr);
 		if (retval == DBG_HOOK_HANDLED)
 			break;
 	}
 
-	read_unlock(&step_hook_lock);
+	rcu_read_unlock();
 
 	return retval;
 }
diff --git a/drivers/gpu/drm/i915/i915_irq.c b/drivers/gpu/drm/i915/i915_irq.c
index b0df8d10482a..8d34df020842 100644
--- a/drivers/gpu/drm/i915/i915_irq.c
+++ b/drivers/gpu/drm/i915/i915_irq.c
@@ -676,6 +676,7 @@ static int i915_get_crtc_scanoutpos(struct drm_device *dev, int pipe,
 	spin_lock_irqsave(&dev_priv->uncore.lock, irqflags);
 
 	/* preempt_disable_rt() should go right here in PREEMPT_RT patchset. */
+	preempt_disable_rt();
 
 	/* Get optional system timestamp before query. */
 	if (stime)
@@ -727,6 +728,7 @@ static int i915_get_crtc_scanoutpos(struct drm_device *dev, int pipe,
 		*etime = ktime_get();
 
 	/* preempt_enable_rt() should go right here in PREEMPT_RT patchset. */
+	preempt_enable_rt();
 
 	spin_unlock_irqrestore(&dev_priv->uncore.lock, irqflags);
 
diff --git a/drivers/gpu/drm/i915/intel_sprite.c b/drivers/gpu/drm/i915/intel_sprite.c
index a4c0a04b5044..6da459fe20b2 100644
--- a/drivers/gpu/drm/i915/intel_sprite.c
+++ b/drivers/gpu/drm/i915/intel_sprite.c
@@ -37,6 +37,7 @@
 #include "intel_drv.h"
 #include <drm/i915_drm.h>
 #include "i915_drv.h"
+#include <linux/locallock.h>
 
 static bool
 format_is_yuv(uint32_t format)
@@ -61,6 +62,8 @@ static int usecs_to_scanlines(const struct drm_display_mode *mode, int usecs)
 	return DIV_ROUND_UP(usecs * mode->crtc_clock, 1000 * mode->crtc_htotal);
 }
 
+static DEFINE_LOCAL_IRQ_LOCK(pipe_update_lock);
+
 /**
  * intel_pipe_update_start() - start update of a set of display registers
  * @crtc: the crtc of which the registers are going to be updated
@@ -101,7 +104,7 @@ bool intel_pipe_update_start(struct intel_crtc *crtc, uint32_t *start_vbl_count)
 	if (WARN_ON(drm_crtc_vblank_get(&crtc->base)))
 		return false;
 
-	local_irq_disable();
+	local_lock_irq(pipe_update_lock);
 
 	trace_i915_pipe_update_start(crtc, min, max);
 
@@ -123,11 +126,11 @@ bool intel_pipe_update_start(struct intel_crtc *crtc, uint32_t *start_vbl_count)
 			break;
 		}
 
-		local_irq_enable();
+		local_unlock_irq(pipe_update_lock);
 
 		timeout = schedule_timeout(timeout);
 
-		local_irq_disable();
+		local_lock_irq(pipe_update_lock);
 	}
 
 	finish_wait(wq, &wait);
@@ -158,7 +161,7 @@ void intel_pipe_update_end(struct intel_crtc *crtc, u32 start_vbl_count)
 
 	trace_i915_pipe_update_end(crtc, end_vbl_count);
 
-	local_irq_enable();
+	local_unlock_irq(pipe_update_lock);
 
 	if (start_vbl_count != end_vbl_count)
 		DRM_ERROR("Atomic update failure on pipe %c (start=%u end=%u)\n",
diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/radeon/radeon_display.c
index 6743174acdbc..8ad198bbc24d 100644
--- a/drivers/gpu/drm/radeon/radeon_display.c
+++ b/drivers/gpu/drm/radeon/radeon_display.c
@@ -1798,6 +1798,7 @@ int radeon_get_crtc_scanoutpos(struct drm_device *dev, int crtc, unsigned int fl
 	struct radeon_device *rdev = dev->dev_private;
 
 	/* preempt_disable_rt() should go right here in PREEMPT_RT patchset. */
+	preempt_disable_rt();
 
 	/* Get optional system timestamp before query. */
 	if (stime)
@@ -1890,6 +1891,7 @@ int radeon_get_crtc_scanoutpos(struct drm_device *dev, int crtc, unsigned int fl
 		*etime = ktime_get();
 
 	/* preempt_enable_rt() should go right here in PREEMPT_RT patchset. */
+	preempt_enable_rt();
 
 	/* Decode into vertical and horizontal scanout position. */
 	*vpos = position & 0x1fff;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 8de34ab6d5b1..4e80270703a4 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -22,7 +22,6 @@
 
 #ifdef CONFIG_F2FS_CHECK_FS
 #define f2fs_bug_on(sbi, condition)	BUG_ON(condition)
-#define f2fs_down_write(x, y)	down_write_nest_lock(x, y)
 #else
 #define f2fs_bug_on(sbi, condition)					\
 	do {								\
@@ -31,7 +30,6 @@
 			set_sbi_flag(sbi, SBI_NEED_FSCK);		\
 		}							\
 	} while (0)
-#define f2fs_down_write(x, y)	down_write(x)
 #endif
 
 /*
@@ -838,7 +836,7 @@ static inline void f2fs_unlock_op(struct f2fs_sb_info *sbi)
 
 static inline void f2fs_lock_all(struct f2fs_sb_info *sbi)
 {
-	f2fs_down_write(&sbi->cp_rwsem, &sbi->cp_mutex);
+	down_write(&sbi->cp_rwsem);
 }
 
 static inline void f2fs_unlock_all(struct f2fs_sb_info *sbi)
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 6cd8c0ee4b6f..1ec37fef6355 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -682,6 +682,18 @@ static inline void __ftrace_enabled_restore(int enabled)
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
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index fe254555cf95..d11fd0a440ff 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -463,6 +463,14 @@ extern void thread_do_softirq(void);
 extern void open_softirq(int nr, void (*action)(struct softirq_action *));
 extern void softirq_init(void);
 extern void __raise_softirq_irqoff(unsigned int nr);
+#ifdef CONFIG_PREEMPT_RT_FULL
+extern void __raise_softirq_irqoff_ksoft(unsigned int nr);
+#else
+static inline void __raise_softirq_irqoff_ksoft(unsigned int nr)
+{
+	__raise_softirq_irqoff(nr);
+}
+#endif
 
 extern void raise_softirq_irqoff(unsigned int nr);
 extern void raise_softirq(unsigned int nr);
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 7a289e802a23..d24fe5d9980d 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2192,11 +2192,20 @@ void netdev_freemem(struct net_device *dev);
 void synchronize_net(void);
 int init_dummy_netdev(struct net_device *dev);
 
+#ifdef CONFIG_PREEMPT_RT_FULL
+static inline int dev_recursion_level(void)
+{
+	return current->xmit_recursion;
+}
+
+#else
+
 DECLARE_PER_CPU(int, xmit_recursion);
 static inline int dev_recursion_level(void)
 {
 	return this_cpu_read(xmit_recursion);
 }
+#endif
 
 struct net_device *dev_get_by_index(struct net *net, int ifindex);
 struct net_device *__dev_get_by_index(struct net *net, int ifindex);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 1a56c0512491..0f4a133f0abd 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -176,8 +176,6 @@ extern void get_iowait_load(unsigned long *nr_waiters, unsigned long *load);
 extern void calc_global_load(unsigned long ticks);
 extern void update_cpu_load_nohz(void);
 
-extern unsigned long get_parent_ip(unsigned long addr);
-
 extern void dump_cpu_task(int cpu);
 
 struct seq_file;
@@ -1806,6 +1804,9 @@ struct task_struct {
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
 	unsigned long	task_state_change;
 #endif
+#ifdef CONFIG_PREEMPT_RT_FULL
+	int xmit_recursion;
+#endif
 	int pagefault_disabled;
 };
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 1b0e656f60e8..8f8a0a13d212 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -387,6 +387,7 @@ static struct task_struct *dup_task_struct(struct task_struct *orig)
 #endif
 	tsk->splice_pipe = NULL;
 	tsk->task_frag.page = NULL;
+	tsk->wake_q.next = NULL;
 
 	account_kernel_stack(ti, 1);
 
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index b8d001b89047..b90be3ae3a10 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -129,12 +129,14 @@ static bool ptrace_freeze_traced(struct task_struct *task)
 
 	spin_lock_irq(&task->sighand->siglock);
 	if (task_is_traced(task) && !__fatal_signal_pending(task)) {
-		raw_spin_lock_irq(&task->pi_lock);
+		unsigned long flags;
+
+		raw_spin_lock_irqsave(&task->pi_lock, flags);
 		if (task->state & __TASK_TRACED)
 			task->state = __TASK_TRACED;
 		else
 			task->saved_state = __TASK_TRACED;
-		raw_spin_unlock_irq(&task->pi_lock);
+		raw_spin_unlock_irqrestore(&task->pi_lock, flags);
 		ret = true;
 	}
 	spin_unlock_irq(&task->sighand->siglock);
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 8dbe27611ec3..7b6170a46409 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -389,6 +389,7 @@ static struct rcu_torture_ops rcu_ops = {
 	.name		= "rcu"
 };
 
+#ifndef CONFIG_PREEMPT_RT_FULL
 /*
  * Definitions for rcu_bh torture testing.
  */
@@ -428,6 +429,12 @@ static struct rcu_torture_ops rcu_bh_ops = {
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
index d21091f2fd1f..3b5d43a884e8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2643,16 +2643,6 @@ u64 scheduler_tick_max_deferment(void)
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
 
@@ -2674,7 +2664,7 @@ void preempt_count_add(int val)
 				PREEMPT_MASK - 10);
 #endif
 	if (preempt_count() == val) {
-		unsigned long ip = get_parent_ip(CALLER_ADDR1);
+		unsigned long ip = get_lock_parent_ip();
 #ifdef CONFIG_DEBUG_PREEMPT
 		current->preempt_disable_ip = ip;
 #endif
@@ -2701,7 +2691,7 @@ void preempt_count_sub(int val)
 #endif
 
 	if (preempt_count() == val)
-		trace_preempt_on(CALLER_ADDR0, get_parent_ip(CALLER_ADDR1));
+		trace_preempt_on(CALLER_ADDR0, get_lock_parent_ip());
 	__preempt_count_sub(val);
 }
 EXPORT_SYMBOL(preempt_count_sub);
@@ -2798,7 +2788,7 @@ void migrate_disable(void)
 {
 	struct task_struct *p = current;
 
-	if (in_atomic()) {
+	if (in_atomic() || irqs_disabled()) {
 #ifdef CONFIG_SCHED_DEBUG
 		p->migrate_disable_atomic++;
 #endif
@@ -2832,7 +2822,7 @@ void migrate_enable(void)
 	unsigned long flags;
 	struct rq *rq;
 
-	if (in_atomic()) {
+	if (in_atomic() || irqs_disabled()) {
 #ifdef CONFIG_SCHED_DEBUG
 		p->migrate_disable_atomic--;
 #endif
@@ -3116,6 +3106,30 @@ static void __sched notrace preempt_schedule_common(void)
 	} while (need_resched());
 }
 
+#ifdef CONFIG_PREEMPT_LAZY
+/*
+ * If TIF_NEED_RESCHED is then we allow to be scheduled away since this is
+ * set by a RT task. Oterwise we try to avoid beeing scheduled out as long as
+ * preempt_lazy_count counter >0.
+ */
+static __always_inline int preemptible_lazy(void)
+{
+	if (test_thread_flag(TIF_NEED_RESCHED))
+		return 1;
+	if (current_thread_info()->preempt_lazy_count)
+		return 0;
+	return 1;
+}
+
+#else
+
+static int preemptible_lazy(void)
+{
+	return 1;
+}
+
+#endif
+
 #ifdef CONFIG_PREEMPT
 /*
  * this is the entry point to schedule() from in-kernel preemption
@@ -3130,6 +3144,8 @@ asmlinkage __visible void __sched notrace preempt_schedule(void)
 	 */
 	if (likely(!preemptible()))
 		return;
+	if (!preemptible_lazy())
+		return;
 
 	preempt_schedule_common();
 }
@@ -3157,15 +3173,9 @@ asmlinkage __visible void __sched notrace preempt_schedule_context(void)
 
 	if (likely(!preemptible()))
 		return;
-
-#ifdef CONFIG_PREEMPT_LAZY
-	/*
-	 * Check for lazy preemption
-	 */
-	if (current_thread_info()->preempt_lazy_count &&
-			!test_thread_flag(TIF_NEED_RESCHED))
+	if (!preemptible_lazy())
 		return;
-#endif
+
 	do {
 		__preempt_count_add(PREEMPT_ACTIVE);
 		/*
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 0fd93311536f..cb9c1d5dee10 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -58,6 +58,10 @@ EXPORT_SYMBOL(irq_stat);
 static struct softirq_action softirq_vec[NR_SOFTIRQS] __cacheline_aligned_in_smp;
 
 DEFINE_PER_CPU(struct task_struct *, ksoftirqd);
+#ifdef CONFIG_PREEMPT_RT_FULL
+#define TIMER_SOFTIRQS	((1 << TIMER_SOFTIRQ) | (1 << HRTIMER_SOFTIRQ))
+DEFINE_PER_CPU(struct task_struct *, ktimer_softirqd);
+#endif
 
 const char * const softirq_to_name[NR_SOFTIRQS] = {
 	"HI", "TIMER", "NET_TX", "NET_RX", "BLOCK", "BLOCK_IOPOLL",
@@ -171,6 +175,17 @@ static void wakeup_softirqd(void)
 		wake_up_process(tsk);
 }
 
+#ifdef CONFIG_PREEMPT_RT_FULL
+static void wakeup_timer_softirqd(void)
+{
+	/* Interrupts are disabled: no need to stop preemption */
+	struct task_struct *tsk = __this_cpu_read(ktimer_softirqd);
+
+	if (tsk && tsk->state != TASK_RUNNING)
+		wake_up_process(tsk);
+}
+#endif
+
 static void handle_softirq(unsigned int vec_nr)
 {
 	struct softirq_action *h = softirq_vec + vec_nr;
@@ -272,9 +287,9 @@ void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
 
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
@@ -473,7 +488,6 @@ void __raise_softirq_irqoff(unsigned int nr)
 static inline void local_bh_disable_nort(void) { local_bh_disable(); }
 static inline void _local_bh_enable_nort(void) { _local_bh_enable(); }
 static void ksoftirqd_set_sched_params(unsigned int cpu) { }
-static void ksoftirqd_clr_sched_params(unsigned int cpu, bool online) { }
 
 #else /* !PREEMPT_RT_FULL */
 
@@ -549,8 +563,10 @@ static void do_current_softirqs(void)
 			do_single_softirq(i);
 		}
 		softirq_clr_runner(i);
-		unlock_softirq(i);
 		WARN_ON(current->softirq_nestcnt != 1);
+		local_irq_enable();
+		unlock_softirq(i);
+		local_irq_disable();
 	}
 }
 
@@ -599,8 +615,8 @@ static void run_ksoftirqd(unsigned int cpu)
 
 	do_current_softirqs();
 	current->softirq_nestcnt--;
-	rcu_note_context_switch();
 	local_irq_enable();
+	cond_resched_rcu_qs();
 }
 
 /*
@@ -618,8 +634,12 @@ void thread_do_softirq(void)
 
 static void do_raise_softirq_irqoff(unsigned int nr)
 {
+	unsigned int mask;
+
+	mask = 1UL << nr;
+
 	trace_softirq_raise(nr);
-	or_softirq_pending(1UL << nr);
+	or_softirq_pending(mask);
 
 	/*
 	 * If we are not in a hard interrupt and inside a bh disabled
@@ -628,16 +648,51 @@ static void do_raise_softirq_irqoff(unsigned int nr)
 	 * delegate it to ksoftirqd.
 	 */
 	if (!in_irq() && current->softirq_nestcnt)
-		current->softirqs_raised |= (1U << nr);
-	else if (__this_cpu_read(ksoftirqd))
-		__this_cpu_read(ksoftirqd)->softirqs_raised |= (1U << nr);
+		current->softirqs_raised |= mask;
+	else if (!__this_cpu_read(ksoftirqd) || !__this_cpu_read(ktimer_softirqd))
+		return;
+
+	if (mask & TIMER_SOFTIRQS)
+		__this_cpu_read(ktimer_softirqd)->softirqs_raised |= mask;
+	else
+		__this_cpu_read(ksoftirqd)->softirqs_raised |= mask;
 }
 
+static void wakeup_proper_softirq(unsigned int nr)
+{
+	if ((1UL << nr) & TIMER_SOFTIRQS)
+		wakeup_timer_softirqd();
+	else
+		wakeup_softirqd();
+}
+
+
 void __raise_softirq_irqoff(unsigned int nr)
 {
 	do_raise_softirq_irqoff(nr);
 	if (!in_irq() && !current->softirq_nestcnt)
-		wakeup_softirqd();
+		wakeup_proper_softirq(nr);
+}
+
+/*
+ * Same as __raise_softirq_irqoff() but will process them in ksoftirqd
+ */
+void __raise_softirq_irqoff_ksoft(unsigned int nr)
+{
+	unsigned int mask;
+
+	if (WARN_ON_ONCE(!__this_cpu_read(ksoftirqd) ||
+			 !__this_cpu_read(ktimer_softirqd)))
+		return;
+	mask = 1UL << nr;
+
+	trace_softirq_raise(nr);
+	or_softirq_pending(mask);
+	if (mask & TIMER_SOFTIRQS)
+		__this_cpu_read(ktimer_softirqd)->softirqs_raised |= mask;
+	else
+		__this_cpu_read(ksoftirqd)->softirqs_raised |= mask;
+	wakeup_proper_softirq(nr);
 }
 
 /*
@@ -663,7 +718,7 @@ void raise_softirq_irqoff(unsigned int nr)
 	 * raise a WARN() if the condition is met.
 	 */
 	if (!current->softirq_nestcnt)
-		wakeup_softirqd();
+		wakeup_proper_softirq(nr);
 }
 
 static inline int ksoftirqd_softirq_pending(void)
@@ -676,22 +731,37 @@ static inline void _local_bh_enable_nort(void) { }
 
 static inline void ksoftirqd_set_sched_params(unsigned int cpu)
 {
+	/* Take over all but timer pending softirqs when starting */
+	local_irq_disable();
+	current->softirqs_raised = local_softirq_pending() & ~TIMER_SOFTIRQS;
+	local_irq_enable();
+}
+
+static inline void ktimer_softirqd_set_sched_params(unsigned int cpu)
+{
 	struct sched_param param = { .sched_priority = 1 };
 
 	sched_setscheduler(current, SCHED_FIFO, &param);
-	/* Take over all pending softirqs when starting */
+
+	/* Take over timer pending softirqs when starting */
 	local_irq_disable();
-	current->softirqs_raised = local_softirq_pending();
+	current->softirqs_raised = local_softirq_pending() & TIMER_SOFTIRQS;
 	local_irq_enable();
 }
 
-static inline void ksoftirqd_clr_sched_params(unsigned int cpu, bool online)
+static inline void ktimer_softirqd_clr_sched_params(unsigned int cpu,
+						    bool online)
 {
 	struct sched_param param = { .sched_priority = 0 };
 
 	sched_setscheduler(current, SCHED_NORMAL, &param);
 }
 
+static int ktimer_softirqd_should_run(unsigned int cpu)
+{
+	return current->softirqs_raised;
+}
+
 #endif /* PREEMPT_RT_FULL */
 /*
  * Enter an interrupt context.
@@ -741,6 +811,9 @@ static inline void invoke_softirq(void)
 	if (__this_cpu_read(ksoftirqd) &&
 			__this_cpu_read(ksoftirqd)->softirqs_raised)
 		wakeup_softirqd();
+	if (__this_cpu_read(ktimer_softirqd) &&
+			__this_cpu_read(ktimer_softirqd)->softirqs_raised)
+		wakeup_timer_softirqd();
 	local_irq_restore(flags);
 #endif
 }
@@ -1173,17 +1246,30 @@ static struct notifier_block cpu_nfb = {
 static struct smp_hotplug_thread softirq_threads = {
 	.store			= &ksoftirqd,
 	.setup			= ksoftirqd_set_sched_params,
-	.cleanup		= ksoftirqd_clr_sched_params,
 	.thread_should_run	= ksoftirqd_should_run,
 	.thread_fn		= run_ksoftirqd,
 	.thread_comm		= "ksoftirqd/%u",
 };
 
+#ifdef CONFIG_PREEMPT_RT_FULL
+static struct smp_hotplug_thread softirq_timer_threads = {
+	.store			= &ktimer_softirqd,
+	.setup			= ktimer_softirqd_set_sched_params,
+	.cleanup		= ktimer_softirqd_clr_sched_params,
+	.thread_should_run	= ktimer_softirqd_should_run,
+	.thread_fn		= run_ksoftirqd,
+	.thread_comm		= "ktimersoftd/%u",
+};
+#endif
+
 static __init int spawn_ksoftirqd(void)
 {
 	register_cpu_notifier(&cpu_nfb);
 
 	BUG_ON(smpboot_register_percpu_thread(&softirq_threads));
+#ifdef CONFIG_PREEMPT_RT_FULL
+	BUG_ON(smpboot_register_percpu_thread(&softirq_timer_threads));
+#endif
 
 	return 0;
 }
diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index 1af29ad20970..d3ea2452e291 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -30,7 +30,7 @@ struct cpu_stop_done {
 	atomic_t		nr_todo;	/* nr left to execute */
 	bool			executed;	/* actually executed? */
 	int			ret;		/* collected return value */
-	struct task_struct	*waiter;	/* woken when nr_todo reaches 0 */
+	struct completion	completion;	/* fired if nr_todo reaches 0 */
 };
 
 /* the actual stopper, one per every possible cpu, enabled on online cpus */
@@ -56,7 +56,7 @@ static void cpu_stop_init_done(struct cpu_stop_done *done, unsigned int nr_todo)
 {
 	memset(done, 0, sizeof(*done));
 	atomic_set(&done->nr_todo, nr_todo);
-	done->waiter = current;
+	init_completion(&done->completion);
 }
 
 /* signal completion unless @done is NULL */
@@ -65,10 +65,8 @@ static void cpu_stop_signal_done(struct cpu_stop_done *done, bool executed)
 	if (done) {
 		if (executed)
 			done->executed = true;
-		if (atomic_dec_and_test(&done->nr_todo)) {
-			wake_up_process(done->waiter);
-			done->waiter = NULL;
-		}
+		if (atomic_dec_and_test(&done->nr_todo))
+			complete(&done->completion);
 	}
 }
 
@@ -91,22 +89,6 @@ static void cpu_stop_queue_work(unsigned int cpu, struct cpu_stop_work *work)
 	raw_spin_unlock_irqrestore(&stopper->lock, flags);
 }
 
-static void wait_for_stop_done(struct cpu_stop_done *done)
-{
-	set_current_state(TASK_UNINTERRUPTIBLE);
-	while (atomic_read(&done->nr_todo)) {
-		schedule();
-		set_current_state(TASK_UNINTERRUPTIBLE);
-	}
-	/*
-	 * We need to wait until cpu_stop_signal_done() has cleared
-	 * done->waiter.
-	 */
-	while (done->waiter)
-		cpu_relax();
-	set_current_state(TASK_RUNNING);
-}
-
 /**
  * stop_one_cpu - stop a cpu
  * @cpu: cpu to stop
@@ -138,7 +120,7 @@ int stop_one_cpu(unsigned int cpu, cpu_stop_fn_t fn, void *arg)
 
 	cpu_stop_init_done(&done, 1);
 	cpu_stop_queue_work(cpu, &work);
-	wait_for_stop_done(&done);
+	wait_for_completion(&done.completion);
 	return done.executed ? done.ret : -ENOENT;
 }
 
@@ -315,7 +297,7 @@ int stop_two_cpus(unsigned int cpu1, unsigned int cpu2, cpu_stop_fn_t fn, void *
 	lg_local_unlock(&stop_cpus_lock);
 	preempt_enable_nort();
 
-	wait_for_stop_done(&done);
+	wait_for_completion(&done.completion);
 
 	return done.executed ? done.ret : -ENOENT;
 }
@@ -380,7 +362,7 @@ static int __stop_cpus(const struct cpumask *cpumask,
 
 	cpu_stop_init_done(&done, cpumask_weight(cpumask));
 	queue_stop_cpus_work(cpumask, fn, arg, &done, false);
-	wait_for_stop_done(&done);
+	wait_for_completion(&done.completion);
 	return done.executed ? done.ret : -ENOENT;
 }
 
@@ -511,13 +493,7 @@ repeat:
 			  kallsyms_lookup((unsigned long)fn, NULL, NULL, NULL,
 					  ksym_buf), arg);
 
-		/*
-		 * Make sure that the wakeup and setting done->waiter
-		 * to NULL is atomic.
-		 */
-		local_irq_disable();
 		cpu_stop_signal_done(done, true);
-		local_irq_enable();
 		goto repeat;
 	}
 }
@@ -676,7 +652,7 @@ int stop_machine_from_inactive_cpu(int (*fn)(void *), void *data,
 	ret = multi_cpu_stop(&msdata);
 
 	/* Busy wait for completion. */
-	while (atomic_read(&done.nr_todo))
+	while (!completion_done(&done.completion))
 		cpu_relax();
 
 	mutex_unlock(&stop_cpus_mutex);
diff --git a/kernel/time/tick-broadcast-hrtimer.c b/kernel/time/tick-broadcast-hrtimer.c
index 6aac4beedbbe..943c03395e46 100644
--- a/kernel/time/tick-broadcast-hrtimer.c
+++ b/kernel/time/tick-broadcast-hrtimer.c
@@ -109,5 +109,6 @@ void tick_setup_hrtimer_broadcast(void)
 {
 	hrtimer_init(&bctimer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
 	bctimer.function = bc_handler;
+	bctimer.irqsafe = true;
 	clockevents_register_device(&ce_broadcast_hrtimer);
 }
diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index d0e1d0e48640..0f2d3e3545e8 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -434,13 +434,13 @@ void start_critical_timings(void)
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
@@ -485,7 +485,7 @@ inline void print_irqtrace_events(struct task_struct *curr)
  */
 void trace_hardirqs_on(void)
 {
-	trace_preemptirqsoff_hist(IRQS_ON, 0);
+	trace_preemptirqsoff_hist_rcuidle(IRQS_ON, 0);
 	if (!preempt_trace() && irq_trace())
 		stop_critical_timing(CALLER_ADDR0, CALLER_ADDR1);
 }
@@ -495,7 +495,7 @@ void trace_hardirqs_off(void)
 {
 	if (!preempt_trace() && irq_trace())
 		start_critical_timing(CALLER_ADDR0, CALLER_ADDR1);
-	trace_preemptirqsoff_hist(IRQS_OFF, 1);
+	trace_preemptirqsoff_hist_rcuidle(IRQS_OFF, 1);
 }
 EXPORT_SYMBOL(trace_hardirqs_off);
 
diff --git a/localversion-rt b/localversion-rt
index 1e584b47c987..9e7cd66d9f44 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt17
+-rt18
diff --git a/net/core/dev.c b/net/core/dev.c
index 16fbef81024d..90c4c45b206c 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2883,9 +2883,44 @@ static void skb_update_prio(struct sk_buff *skb)
 #define skb_update_prio(skb)
 #endif
 
+#ifdef CONFIG_PREEMPT_RT_FULL
+
+static inline int xmit_rec_read(void)
+{
+       return current->xmit_recursion;
+}
+
+static inline void xmit_rec_inc(void)
+{
+       current->xmit_recursion++;
+}
+
+static inline void xmit_rec_dec(void)
+{
+       current->xmit_recursion--;
+}
+
+#else
+
 DEFINE_PER_CPU(int, xmit_recursion);
 EXPORT_SYMBOL(xmit_recursion);
 
+static inline int xmit_rec_read(void)
+{
+	return __this_cpu_read(xmit_recursion);
+}
+
+static inline void xmit_rec_inc(void)
+{
+	__this_cpu_inc(xmit_recursion);
+}
+
+static inline int xmit_rec_dec(void)
+{
+	__this_cpu_dec(xmit_recursion);
+}
+#endif
+
 #define RECURSION_LIMIT 10
 
 /**
@@ -2987,7 +3022,7 @@ static int __dev_queue_xmit(struct sk_buff *skb, void *accel_priv)
 
 		if (txq->xmit_lock_owner != cpu) {
 
-			if (__this_cpu_read(xmit_recursion) > RECURSION_LIMIT)
+			if (xmit_rec_read() > RECURSION_LIMIT)
 				goto recursion_alert;
 
 			skb = validate_xmit_skb(skb, dev);
@@ -2997,9 +3032,9 @@ static int __dev_queue_xmit(struct sk_buff *skb, void *accel_priv)
 			HARD_TX_LOCK(dev, txq, cpu);
 
 			if (!netif_xmit_stopped(txq)) {
-				__this_cpu_inc(xmit_recursion);
+				xmit_rec_inc();
 				skb = dev_hard_start_xmit(skb, dev, txq, &rc);
-				__this_cpu_dec(xmit_recursion);
+				xmit_rec_dec();
 				if (dev_xmit_complete(rc)) {
 					HARD_TX_UNLOCK(dev, txq);
 					goto out;
@@ -4755,7 +4790,7 @@ static void net_rx_action(struct softirq_action *h)
 	list_splice_tail(&repoll, &list);
 	list_splice(&list, &sd->poll_list);
 	if (!list_empty(&sd->poll_list))
-		__raise_softirq_irqoff(NET_RX_SOFTIRQ);
+		__raise_softirq_irqoff_ksoft(NET_RX_SOFTIRQ);
 
 	net_rps_action_and_irq_enable(sd);
 }
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 36c138197f37..df293d45e0cd 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -358,6 +358,7 @@ struct netdev_alloc_cache {
 static DEFINE_PER_CPU(struct netdev_alloc_cache, netdev_alloc_cache);
 static DEFINE_PER_CPU(struct netdev_alloc_cache, napi_alloc_cache);
 static DEFINE_LOCAL_IRQ_LOCK(netdev_alloc_lock);
+static DEFINE_LOCAL_IRQ_LOCK(napi_alloc_cache_lock);
 
 static struct page *__page_frag_refill(struct netdev_alloc_cache *nc,
 				       gfp_t gfp_mask)
@@ -456,7 +457,12 @@ EXPORT_SYMBOL(netdev_alloc_frag);
 
 static void *__napi_alloc_frag(unsigned int fragsz, gfp_t gfp_mask)
 {
-	return __alloc_page_frag(&napi_alloc_cache, fragsz, gfp_mask);
+	void *data;
+
+	local_lock(napi_alloc_cache_lock);
+	data = __alloc_page_frag(&napi_alloc_cache, fragsz, gfp_mask);
+	local_unlock(napi_alloc_cache_lock);
+	return data;
 }
 
 void *napi_alloc_frag(unsigned int fragsz)
