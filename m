From: Julia Cartwright <julia@ni.com>
Subject: [ANNOUNCE] 4.1.42-rt50
Date: Wed, 16 Aug 2017 15:42:28 -0500
Message-ID: <20170816204228.GE8384@jcartwri.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
To: <linux-kernel@vger.kernel.org>, <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 4.1.42-rt50 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.1-rt
  Head SHA1: 2e2586f49c8f6b84ceeecce704901405a7e780df

Or to build 4.1.42-rt50 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.1.tar.xz

  http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.1.42.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.1/patch-4.1.42-rt50.patch.xz


You can also build from 4.1.42-rt49 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.1/incr/patch-4.1.42-rt49-rt50.patch.xz

Enjoy!
   Julia

Changes from v4.1.42-rt49:
---
Alex Shi (1):
      cpu_pm: replace raw_notifier to atomic_notifier

Julia Cartwright (1):
      Linux 4.1.42-rt50

Peter Zijlstra (2):
      lockdep: Fix per-cpu static objects
      sched: Remove TASK_ALL

Thomas Gleixner (2):
      rtmutex: Make lock_killable work
      sched: Prevent task state corruption by spurious lock wakeup
----
 include/linux/sched.h    |  1 -
 include/linux/smp.h      | 12 ++++++++++++
 init/main.c              |  8 ++++++++
 kernel/cpu_pm.c          | 43 ++++++-------------------------------------
 kernel/locking/rtmutex.c | 19 +++++++------------
 kernel/module.c          |  6 +++++-
 kernel/sched/core.c      |  2 +-
 localversion-rt          |  2 +-
 mm/percpu.c              |  5 ++++-
 9 files changed, 44 insertions(+), 54 deletions(-)
---------------------------
diff --git a/include/linux/sched.h b/include/linux/sched.h
index d51525ce2c41..7587d6181cd2 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -227,7 +227,6 @@ extern char ___assert_task_state[1 - 2*!!(
 
 /* Convenience macros for the sake of wake_up */
 #define TASK_NORMAL		(TASK_INTERRUPTIBLE | TASK_UNINTERRUPTIBLE)
-#define TASK_ALL		(TASK_NORMAL | __TASK_STOPPED | __TASK_TRACED)
 
 /* get_task_state() */
 #define TASK_REPORT		(TASK_RUNNING | TASK_INTERRUPTIBLE | \
diff --git a/include/linux/smp.h b/include/linux/smp.h
index e6ab36aeaaab..cbf6836524dc 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -120,6 +120,13 @@ extern unsigned int setup_max_cpus;
 extern void __init setup_nr_cpu_ids(void);
 extern void __init smp_init(void);
 
+extern int __boot_cpu_id;
+
+static inline int get_boot_cpu_id(void)
+{
+	return __boot_cpu_id;
+}
+
 #else /* !SMP */
 
 static inline void smp_send_stop(void) { }
@@ -158,6 +165,11 @@ static inline void smp_init(void) { up_late_init(); }
 static inline void smp_init(void) { }
 #endif
 
+static inline int get_boot_cpu_id(void)
+{
+	return 0;
+}
+
 #endif /* !SMP */
 
 /*
diff --git a/init/main.c b/init/main.c
index 0486a8e11fc0..e1bae15a2154 100644
--- a/init/main.c
+++ b/init/main.c
@@ -451,6 +451,10 @@ void __init parse_early_param(void)
  *	Activate the first processor.
  */
 
+#ifdef CONFIG_SMP
+int __boot_cpu_id;
+#endif
+
 static void __init boot_cpu_init(void)
 {
 	int cpu = smp_processor_id();
@@ -459,6 +463,10 @@ static void __init boot_cpu_init(void)
 	set_cpu_active(cpu, true);
 	set_cpu_present(cpu, true);
 	set_cpu_possible(cpu, true);
+
+#ifdef CONFIG_SMP
+	__boot_cpu_id = cpu;
+#endif
 }
 
 void __init __weak smp_setup_processor_id(void)
diff --git a/kernel/cpu_pm.c b/kernel/cpu_pm.c
index 9656a3c36503..9da42f83ee03 100644
--- a/kernel/cpu_pm.c
+++ b/kernel/cpu_pm.c
@@ -22,14 +22,13 @@
 #include <linux/spinlock.h>
 #include <linux/syscore_ops.h>
 
-static DEFINE_RWLOCK(cpu_pm_notifier_lock);
-static RAW_NOTIFIER_HEAD(cpu_pm_notifier_chain);
+static ATOMIC_NOTIFIER_HEAD(cpu_pm_notifier_chain);
 
 static int cpu_pm_notify(enum cpu_pm_event event, int nr_to_call, int *nr_calls)
 {
 	int ret;
 
-	ret = __raw_notifier_call_chain(&cpu_pm_notifier_chain, event, NULL,
+	ret = __atomic_notifier_call_chain(&cpu_pm_notifier_chain, event, NULL,
 		nr_to_call, nr_calls);
 
 	return notifier_to_errno(ret);
@@ -47,14 +46,7 @@ static int cpu_pm_notify(enum cpu_pm_event event, int nr_to_call, int *nr_calls)
  */
 int cpu_pm_register_notifier(struct notifier_block *nb)
 {
-	unsigned long flags;
-	int ret;
-
-	write_lock_irqsave(&cpu_pm_notifier_lock, flags);
-	ret = raw_notifier_chain_register(&cpu_pm_notifier_chain, nb);
-	write_unlock_irqrestore(&cpu_pm_notifier_lock, flags);
-
-	return ret;
+	return atomic_notifier_chain_register(&cpu_pm_notifier_chain, nb);
 }
 EXPORT_SYMBOL_GPL(cpu_pm_register_notifier);
 
@@ -69,14 +61,7 @@ EXPORT_SYMBOL_GPL(cpu_pm_register_notifier);
  */
 int cpu_pm_unregister_notifier(struct notifier_block *nb)
 {
-	unsigned long flags;
-	int ret;
-
-	write_lock_irqsave(&cpu_pm_notifier_lock, flags);
-	ret = raw_notifier_chain_unregister(&cpu_pm_notifier_chain, nb);
-	write_unlock_irqrestore(&cpu_pm_notifier_lock, flags);
-
-	return ret;
+	return atomic_notifier_chain_unregister(&cpu_pm_notifier_chain, nb);
 }
 EXPORT_SYMBOL_GPL(cpu_pm_unregister_notifier);
 
@@ -100,7 +85,6 @@ int cpu_pm_enter(void)
 	int nr_calls;
 	int ret = 0;
 
-	read_lock(&cpu_pm_notifier_lock);
 	ret = cpu_pm_notify(CPU_PM_ENTER, -1, &nr_calls);
 	if (ret)
 		/*
@@ -108,7 +92,6 @@ int cpu_pm_enter(void)
 		 * PM entry who are notified earlier to prepare for it.
 		 */
 		cpu_pm_notify(CPU_PM_ENTER_FAILED, nr_calls - 1, NULL);
-	read_unlock(&cpu_pm_notifier_lock);
 
 	return ret;
 }
@@ -128,13 +111,7 @@ EXPORT_SYMBOL_GPL(cpu_pm_enter);
  */
 int cpu_pm_exit(void)
 {
-	int ret;
-
-	read_lock(&cpu_pm_notifier_lock);
-	ret = cpu_pm_notify(CPU_PM_EXIT, -1, NULL);
-	read_unlock(&cpu_pm_notifier_lock);
-
-	return ret;
+	return cpu_pm_notify(CPU_PM_EXIT, -1, NULL);
 }
 EXPORT_SYMBOL_GPL(cpu_pm_exit);
 
@@ -159,7 +136,6 @@ int cpu_cluster_pm_enter(void)
 	int nr_calls;
 	int ret = 0;
 
-	read_lock(&cpu_pm_notifier_lock);
 	ret = cpu_pm_notify(CPU_CLUSTER_PM_ENTER, -1, &nr_calls);
 	if (ret)
 		/*
@@ -167,7 +143,6 @@ int cpu_cluster_pm_enter(void)
 		 * PM entry who are notified earlier to prepare for it.
 		 */
 		cpu_pm_notify(CPU_CLUSTER_PM_ENTER_FAILED, nr_calls - 1, NULL);
-	read_unlock(&cpu_pm_notifier_lock);
 
 	return ret;
 }
@@ -190,13 +165,7 @@ EXPORT_SYMBOL_GPL(cpu_cluster_pm_enter);
  */
 int cpu_cluster_pm_exit(void)
 {
-	int ret;
-
-	read_lock(&cpu_pm_notifier_lock);
-	ret = cpu_pm_notify(CPU_CLUSTER_PM_EXIT, -1, NULL);
-	read_unlock(&cpu_pm_notifier_lock);
-
-	return ret;
+	return cpu_pm_notify(CPU_CLUSTER_PM_EXIT, -1, NULL);
 }
 EXPORT_SYMBOL_GPL(cpu_cluster_pm_exit);
 
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index e0b0d9b419b5..3e45ceb862bd 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1511,18 +1511,13 @@ __rt_mutex_slowlock(struct rt_mutex *lock, int state,
 		if (try_to_take_rt_mutex(lock, current, waiter))
 			break;
 
-		/*
-		 * TASK_INTERRUPTIBLE checks for signals and
-		 * timeout. Ignored otherwise.
-		 */
-		if (unlikely(state == TASK_INTERRUPTIBLE)) {
-			/* Signal pending? */
-			if (signal_pending(current))
-				ret = -EINTR;
-			if (timeout && !timeout->task)
-				ret = -ETIMEDOUT;
-			if (ret)
-				break;
+		if (timeout && !timeout->task) {
+			ret = -ETIMEDOUT;
+			break;
+		}
+		if (signal_pending_state(state, current)) {
+			ret = -EINTR;
+			break;
 		}
 
 		if (ww_ctx && ww_ctx->acquired > 0) {
diff --git a/kernel/module.c b/kernel/module.c
index a7ac858fd1a1..982c57b2c2a1 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -542,8 +542,12 @@ bool __is_module_percpu_address(unsigned long addr, unsigned long *can_addr)
 			void *va = (void *)addr;
 
 			if (va >= start && va < start + mod->percpu_size) {
-				if (can_addr)
+				if (can_addr) {
 					*can_addr = (unsigned long) (va - start);
+					*can_addr += (unsigned long)
+						per_cpu_ptr(mod->percpu,
+							    get_boot_cpu_id());
+				}
 				preempt_enable();
 				return true;
 			}
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0d3a40b24304..ee11a59e53ff 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1876,7 +1876,7 @@ EXPORT_SYMBOL(wake_up_process);
  */
 int wake_up_lock_sleeper(struct task_struct *p)
 {
-	return try_to_wake_up(p, TASK_ALL, WF_LOCK_SLEEPER);
+	return try_to_wake_up(p, TASK_UNINTERRUPTIBLE, WF_LOCK_SLEEPER);
 }
 
 int wake_up_state(struct task_struct *p, unsigned int state)
diff --git a/localversion-rt b/localversion-rt
index 4b7dca68a5b4..42c384668389 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt49
+-rt50
diff --git a/mm/percpu.c b/mm/percpu.c
index 4146b00bfde7..b41c3960d5fb 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -1297,8 +1297,11 @@ bool __is_kernel_percpu_address(unsigned long addr, unsigned long *can_addr)
 		void *va = (void *)addr;
 
 		if (va >= start && va < start + static_size) {
-			if (can_addr)
+			if (can_addr) {
 				*can_addr = (unsigned long) (va - start);
+				*can_addr += (unsigned long)
+					per_cpu_ptr(base, get_boot_cpu_id());
+			}
 			return true;
 		}
 	}
