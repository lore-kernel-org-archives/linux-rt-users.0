From: Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] 3.18.27-rt27
Date: Mon, 7 Mar 2016 15:52:32 -0500
Message-ID: <20160307155232.60a44030@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0043.hostedemail.com ([216.40.44.43]:41765 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753634AbcCGUwi (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 7 Mar 2016 15:52:38 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Dear RT Folks,

I'm pleased to announce the 3.18.27-rt27 stable release.


You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v3.18-rt
  Head SHA1: a69d68687e04e6f5e9b79a5ac8dacc9d86f195c7


Or to build 3.18.27-rt27 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.18.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.18.27.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.18/patch-3.18.27-rt27.patch.xz



You can also build from 3.18.27-rt26 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.18/incr/patch-3.18.27-rt26-rt27.patch.xz



Enjoy,

-- Steve


Changes from v3.18.27-rt26:

---

Clark Williams (1):
      rcu/torture: Comment out rcu_bh ops on PREEMPT_RT_FULL

Mike Galbraith (4):
      sched,rt: __always_inline preemptible_lazy()
      drm,radeon,i915: Use preempt_disable/enable_rt() where recommended
      drm,i915: Use local_lock/unlock_irq() in intel_pipe_update_start/end()
      tracing: Fix probe_wakeup_latency_hist_start() prototype

Sebastian Andrzej Siewior (11):
      sched: reset task's lockless wake-queues on fork()
      ptrace: don't open IRQs in ptrace_freeze_traced() too early
      net: move xmit_recursion to per-task variable on -RT
      preempt-lazy: Add the lazy-preemption check to preempt_schedule()
      softirq: split timer softirqs out of ksoftirqd
      net: provide a way to delegate processing a softirq to ksoftirqd
      latencyhist: disable jump-labels
      kernel: migrate_disable() do fastpath in atomic & irqs-off
      kernel: softirq: unlock with irqs on
      kernel/stop_machine: partly revert "stop_machine: Use raw spinlocks"
      kernel: sched: Fix preempt_disable_ip recodring for preempt_disable()

Steven Rostedt (Red Hat) (1):
      Linux 3.18.27-rt27

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
 drivers/gpu/drm/i915/intel_sprite.c     |  11 ++--
 drivers/gpu/drm/radeon/radeon_display.c |   2 +
 fs/f2fs/f2fs.h                          |   4 +-
 include/linux/ftrace.h                  |  12 ++++
 include/linux/interrupt.h               |   8 +++
 include/linux/netdevice.h               |   9 +++
 include/linux/sched.h                   |   3 +-
 include/trace/events/hist.h             |   1 +
 kernel/fork.c                           |   1 +
 kernel/ptrace.c                         |   6 +-
 kernel/rcu/rcutorture.c                 |   7 ++
 kernel/sched/core.c                     |  52 ++++++++-------
 kernel/softirq.c                        | 112 ++++++++++++++++++++++++++++----
 kernel/stop_machine.c                   |  40 +++---------
 kernel/time/tick-broadcast-hrtimer.c    |   1 +
 kernel/trace/latency_hist.c             |   4 +-
 kernel/trace/trace_irqsoff.c            |   8 +--
 localversion-rt                         |   2 +-
 net/core/dev.c                          |  43 ++++++++++--
 22 files changed, 251 insertions(+), 99 deletions(-)
---------------------------
diff --git a/arch/Kconfig b/arch/Kconfig
index 84d340b061a9..efb75aee313a 100644
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
index b056369fd47d..4c6f340c90fa 100644
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
index 23329b48766f..763e9c004f23 100644
--- a/drivers/gpu/drm/i915/i915_irq.c
+++ b/drivers/gpu/drm/i915/i915_irq.c
@@ -943,6 +943,7 @@ static int i915_get_crtc_scanoutpos(struct drm_device *dev, int pipe,
 	spin_lock_irqsave(&dev_priv->uncore.lock, irqflags);
 
 	/* preempt_disable_rt() should go right here in PREEMPT_RT patchset. */
+	preempt_disable_rt();
 
 	/* Get optional system timestamp before query. */
 	if (stime)
@@ -994,6 +995,7 @@ static int i915_get_crtc_scanoutpos(struct drm_device *dev, int pipe,
 		*etime = ktime_get();
 
 	/* preempt_enable_rt() should go right here in PREEMPT_RT patchset. */
+	preempt_enable_rt();
 
 	spin_unlock_irqrestore(&dev_priv->uncore.lock, irqflags);
 
diff --git a/drivers/gpu/drm/i915/intel_sprite.c b/drivers/gpu/drm/i915/intel_sprite.c
index 4edebce7f213..c7c118476758 100644
--- a/drivers/gpu/drm/i915/intel_sprite.c
+++ b/drivers/gpu/drm/i915/intel_sprite.c
@@ -36,6 +36,7 @@
 #include "intel_drv.h"
 #include <drm/i915_drm.h>
 #include "i915_drv.h"
+#include <linux/locallock.h>
 
 static int usecs_to_scanlines(const struct drm_display_mode *mode, int usecs)
 {
@@ -46,6 +47,8 @@ static int usecs_to_scanlines(const struct drm_display_mode *mode, int usecs)
 	return DIV_ROUND_UP(usecs * mode->crtc_clock, 1000 * mode->crtc_htotal);
 }
 
+static DEFINE_LOCAL_IRQ_LOCK(pipe_update_lock);
+
 static bool intel_pipe_update_start(struct intel_crtc *crtc, uint32_t *start_vbl_count)
 {
 	struct drm_device *dev = crtc->base.dev;
@@ -72,7 +75,7 @@ static bool intel_pipe_update_start(struct intel_crtc *crtc, uint32_t *start_vbl
 	if (WARN_ON(drm_vblank_get(dev, pipe)))
 		return false;
 
-	local_irq_disable();
+	local_lock_irq(pipe_update_lock);
 
 	trace_i915_pipe_update_start(crtc, min, max);
 
@@ -94,11 +97,11 @@ static bool intel_pipe_update_start(struct intel_crtc *crtc, uint32_t *start_vbl
 			break;
 		}
 
-		local_irq_enable();
+		local_unlock_irq(pipe_update_lock);
 
 		timeout = schedule_timeout(timeout);
 
-		local_irq_disable();
+		local_lock_irq(pipe_update_lock);
 	}
 
 	finish_wait(wq, &wait);
@@ -120,7 +123,7 @@ static void intel_pipe_update_end(struct intel_crtc *crtc, u32 start_vbl_count)
 
 	trace_i915_pipe_update_end(crtc, end_vbl_count);
 
-	local_irq_enable();
+	local_unlock_irq(pipe_update_lock);
 
 	if (start_vbl_count != end_vbl_count)
 		DRM_ERROR("Atomic update failure on pipe %c (start=%u end=%u)\n",
diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/radeon/radeon_display.c
index 21e6e9745d00..7acf4536c827 100644
--- a/drivers/gpu/drm/radeon/radeon_display.c
+++ b/drivers/gpu/drm/radeon/radeon_display.c
@@ -1784,6 +1784,7 @@ int radeon_get_crtc_scanoutpos(struct drm_device *dev, int crtc, unsigned int fl
 	struct radeon_device *rdev = dev->dev_private;
 
 	/* preempt_disable_rt() should go right here in PREEMPT_RT patchset. */
+	preempt_disable_rt();
 
 	/* Get optional system timestamp before query. */
 	if (stime)
@@ -1876,6 +1877,7 @@ int radeon_get_crtc_scanoutpos(struct drm_device *dev, int crtc, unsigned int fl
 		*etime = ktime_get();
 
 	/* preempt_enable_rt() should go right here in PREEMPT_RT patchset. */
+	preempt_enable_rt();
 
 	/* Decode into vertical and horizontal scanout position. */
 	*vpos = position & 0x1fff;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 8171e80b2ee9..5bb02f8e1f06 100644
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
 			sbi->need_fsck = true;				\
 		}							\
 	} while (0)
-#define f2fs_down_write(x, y)	down_write(x)
 #endif
 
 /*
@@ -699,7 +697,7 @@ static inline void f2fs_unlock_op(struct f2fs_sb_info *sbi)
 
 static inline void f2fs_lock_all(struct f2fs_sb_info *sbi)
 {
-	f2fs_down_write(&sbi->cp_rwsem, &sbi->cp_mutex);
+	down_write(&sbi->cp_rwsem);
 }
 
 static inline void f2fs_unlock_all(struct f2fs_sb_info *sbi)
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 662697babd48..7bb6024e935e 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -643,6 +643,18 @@ static inline void __ftrace_enabled_restore(int enabled)
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
index 86628c733be7..ce50b6ebd65d 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -444,6 +444,14 @@ extern void thread_do_softirq(void);
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
index ff0f50dcea4a..dab2603bcdba 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2130,11 +2130,20 @@ void netdev_freemem(struct net_device *dev);
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
index bdc27dbffbe2..acb9c0a2f15b 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -178,8 +178,6 @@ extern void get_iowait_load(unsigned long *nr_waiters, unsigned long *load);
 extern void calc_global_load(unsigned long ticks);
 extern void update_cpu_load_nohz(void);
 
-extern unsigned long get_parent_ip(unsigned long addr);
-
 extern void dump_cpu_task(int cpu);
 
 struct seq_file;
@@ -1523,6 +1521,7 @@ struct task_struct {
 	struct mutex_waiter *blocked_on;
 #endif
 #ifdef CONFIG_PREEMPT_RT_FULL
+	int xmit_recursion;
 	int pagefault_disabled;
 #endif
 #ifdef CONFIG_TRACE_IRQFLAGS
diff --git a/include/trace/events/hist.h b/include/trace/events/hist.h
index 6122e4286177..f7710de1b1f3 100644
--- a/include/trace/events/hist.h
+++ b/include/trace/events/hist.h
@@ -9,6 +9,7 @@
 
 #if !defined(CONFIG_PREEMPT_OFF_HIST) && !defined(CONFIG_INTERRUPT_OFF_HIST)
 #define trace_preemptirqsoff_hist(a, b)
+#define trace_preemptirqsoff_hist_rcuidle(a, b)
 #else
 TRACE_EVENT(preemptirqsoff_hist,
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 3a8ecfb38831..1c4edaf4ec36 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -364,6 +364,7 @@ static struct task_struct *dup_task_struct(struct task_struct *orig)
 #endif
 	tsk->splice_pipe = NULL;
 	tsk->task_frag.page = NULL;
+	tsk->wake_q.next = NULL;
 
 	account_kernel_stack(ti, 1);
 
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 09d76da725af..ac364db5622b 100644
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
index 240fa9094f83..ff0f2d5d6267 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -392,6 +392,7 @@ static struct rcu_torture_ops rcu_ops = {
 	.name		= "rcu"
 };
 
+#ifndef CONFIG_PREEMPT_RT_FULL
 /*
  * Definitions for rcu_bh torture testing.
  */
@@ -435,6 +436,12 @@ static struct rcu_torture_ops rcu_bh_ops = {
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
index 9e01a8f358f8..ecbc559abf7c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2704,16 +2704,6 @@ u64 scheduler_tick_max_deferment(void)
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
 
@@ -2735,7 +2725,7 @@ void preempt_count_add(int val)
 				PREEMPT_MASK - 10);
 #endif
 	if (preempt_count() == val) {
-		unsigned long ip = get_parent_ip(CALLER_ADDR1);
+		unsigned long ip = get_lock_parent_ip();
 #ifdef CONFIG_DEBUG_PREEMPT
 		current->preempt_disable_ip = ip;
 #endif
@@ -2762,7 +2752,7 @@ void preempt_count_sub(int val)
 #endif
 
 	if (preempt_count() == val)
-		trace_preempt_on(CALLER_ADDR0, get_parent_ip(CALLER_ADDR1));
+		trace_preempt_on(CALLER_ADDR0, get_lock_parent_ip());
 	__preempt_count_sub(val);
 }
 EXPORT_SYMBOL(preempt_count_sub);
@@ -2859,7 +2849,7 @@ void migrate_disable(void)
 {
 	struct task_struct *p = current;
 
-	if (in_atomic()) {
+	if (in_atomic() || irqs_disabled()) {
 #ifdef CONFIG_SCHED_DEBUG
 		p->migrate_disable_atomic++;
 #endif
@@ -2893,7 +2883,7 @@ void migrate_enable(void)
 	unsigned long flags;
 	struct rq *rq;
 
-	if (in_atomic()) {
+	if (in_atomic() || irqs_disabled()) {
 #ifdef CONFIG_SCHED_DEBUG
 		p->migrate_disable_atomic--;
 #endif
@@ -3164,6 +3154,30 @@ void __sched schedule_preempt_disabled(void)
 	preempt_disable();
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
@@ -3178,15 +3192,9 @@ asmlinkage __visible void __sched notrace preempt_schedule(void)
 	 */
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
index 3242af874438..89c490b405ad 100644
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
@@ -276,7 +291,7 @@ void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
 	raw_local_irq_restore(flags);
 
 	if (preempt_count() == cnt)
-		trace_preempt_off(CALLER_ADDR0, get_parent_ip(CALLER_ADDR1));
+		trace_preempt_off(CALLER_ADDR0, get_lock_parent_ip());
 }
 EXPORT_SYMBOL(__local_bh_disable_ip);
 #endif /* CONFIG_TRACE_IRQFLAGS */
@@ -474,7 +489,6 @@ void __raise_softirq_irqoff(unsigned int nr)
 static inline void local_bh_disable_nort(void) { local_bh_disable(); }
 static inline void _local_bh_enable_nort(void) { _local_bh_enable(); }
 static void ksoftirqd_set_sched_params(unsigned int cpu) { }
-static void ksoftirqd_clr_sched_params(unsigned int cpu, bool online) { }
 
 #else /* !PREEMPT_RT_FULL */
 
@@ -550,8 +564,10 @@ static void do_current_softirqs(int need_rcu_bh_qs)
 			do_single_softirq(i, need_rcu_bh_qs);
 		}
 		softirq_clr_runner(i);
-		unlock_softirq(i);
 		WARN_ON(current->softirq_nestcnt != 1);
+		local_irq_enable();
+		unlock_softirq(i);
+		local_irq_disable();
 	}
 }
 
@@ -649,8 +665,12 @@ void thread_do_softirq(void)
 
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
@@ -659,16 +679,51 @@ static void do_raise_softirq_irqoff(unsigned int nr)
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
@@ -694,7 +749,7 @@ void raise_softirq_irqoff(unsigned int nr)
 	 * raise a WARN() if the condition is met.
 	 */
 	if (!current->softirq_nestcnt)
-		wakeup_softirqd();
+		wakeup_proper_softirq(nr);
 }
 
 static inline int ksoftirqd_softirq_pending(void)
@@ -707,22 +762,37 @@ static inline void _local_bh_enable_nort(void) { }
 
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
@@ -772,6 +842,9 @@ static inline void invoke_softirq(void)
 	if (__this_cpu_read(ksoftirqd) &&
 			__this_cpu_read(ksoftirqd)->softirqs_raised)
 		wakeup_softirqd();
+	if (__this_cpu_read(ktimer_softirqd) &&
+			__this_cpu_read(ktimer_softirqd)->softirqs_raised)
+		wakeup_timer_softirqd();
 	local_irq_restore(flags);
 #endif
 }
@@ -1209,17 +1282,30 @@ static struct notifier_block cpu_nfb = {
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
diff --git a/kernel/trace/latency_hist.c b/kernel/trace/latency_hist.c
index 66a69eb5329c..b6c1d14b71c4 100644
--- a/kernel/trace/latency_hist.c
+++ b/kernel/trace/latency_hist.c
@@ -115,7 +115,7 @@ static DEFINE_PER_CPU(struct hist_data, wakeup_latency_hist_sharedprio);
 static char *wakeup_latency_hist_dir = "wakeup";
 static char *wakeup_latency_hist_dir_sharedprio = "sharedprio";
 static notrace void probe_wakeup_latency_hist_start(void *v,
-	struct task_struct *p, int success);
+	struct task_struct *p);
 static notrace void probe_wakeup_latency_hist_stop(void *v,
 	struct task_struct *prev, struct task_struct *next);
 static notrace void probe_sched_migrate_task(void *,
@@ -869,7 +869,7 @@ static notrace void probe_sched_migrate_task(void *v, struct task_struct *task,
 }
 
 static notrace void probe_wakeup_latency_hist_start(void *v,
-	struct task_struct *p, int success)
+	struct task_struct *p)
 {
 	unsigned long flags;
 	struct task_struct *curr = current;
diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index de4f1a812c41..d1940b095d85 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -436,13 +436,13 @@ void start_critical_timings(void)
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
@@ -487,7 +487,7 @@ inline void print_irqtrace_events(struct task_struct *curr)
  */
 void trace_hardirqs_on(void)
 {
-	trace_preemptirqsoff_hist(IRQS_ON, 0);
+	trace_preemptirqsoff_hist_rcuidle(IRQS_ON, 0);
 	if (!preempt_trace() && irq_trace())
 		stop_critical_timing(CALLER_ADDR0, CALLER_ADDR1);
 }
@@ -497,7 +497,7 @@ void trace_hardirqs_off(void)
 {
 	if (!preempt_trace() && irq_trace())
 		start_critical_timing(CALLER_ADDR0, CALLER_ADDR1);
-	trace_preemptirqsoff_hist(IRQS_OFF, 1);
+	trace_preemptirqsoff_hist_rcuidle(IRQS_OFF, 1);
 }
 EXPORT_SYMBOL(trace_hardirqs_off);
 
diff --git a/localversion-rt b/localversion-rt
index 2e9afd4a0afd..be1e37b64ad0 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt26
+-rt27
diff --git a/net/core/dev.c b/net/core/dev.c
index 39d2a0ba38ed..da674bb38606 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2861,9 +2861,44 @@ static void skb_update_prio(struct sk_buff *skb)
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
@@ -2965,7 +3000,7 @@ static int __dev_queue_xmit(struct sk_buff *skb, void *accel_priv)
 
 		if (txq->xmit_lock_owner != cpu) {
 
-			if (__this_cpu_read(xmit_recursion) > RECURSION_LIMIT)
+			if (xmit_rec_read() > RECURSION_LIMIT)
 				goto recursion_alert;
 
 			skb = validate_xmit_skb(skb, dev);
@@ -2975,9 +3010,9 @@ static int __dev_queue_xmit(struct sk_buff *skb, void *accel_priv)
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
@@ -4644,7 +4679,7 @@ out:
 
 softnet_break:
 	sd->time_squeeze++;
-	__raise_softirq_irqoff(NET_RX_SOFTIRQ);
+	__raise_softirq_irqoff_ksoft(NET_RX_SOFTIRQ);
 	goto out;
 }
 
