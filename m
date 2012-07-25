From: Frank Rowand <frank.rowand@am.sony.com>
Subject: [PATCH RT] cpu unplug with PREEMPT_LL
Date: Tue, 24 Jul 2012 17:58:50 -0700
Message-ID: <500F44CA.40302@am.sony.com>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
To: <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>,
	<linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


With CONFIG_PREEMPT_LL, cpu unplug generates a bunch of
  BUG: sleeping function called from invalid context
  BUG: scheduling while atomic

To reproduce the problem:
  echo 0 > /sys/devices/system/cpu/cpu1/online

This patch is:

  - UGLY
  - lightly tested
  - should maybe not be included in the RT patch set

but it may be useful to anyone determined to use cpu hotplug with PREEMPT_LL.

This patch was tested on 3.0.36-rt58 since that release has the latest
hotplug patches.  I will re-test this on 3.5-rtX when that is available.

Signed-off-by: Frank Rowand <frank.rowand@am.sony.com>
---
 include/linux/preempt.h |    4 	4 +	0 -	0 !
 include/linux/sched.h   |    6 	3 +	3 -	0 !
 kernel/cpu.c            |   12 	12 +	0 -	0 !
 kernel/sched.c          |   18 	17 +	1 -	0 !
 4 files changed, 36 insertions(+), 4 deletions(-)

Index: b/include/linux/preempt.h
===================================================================
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -122,6 +122,10 @@ do { \
 # define preempt_enable_nort()		preempt_enable()
 # define migrate_disable()		preempt_disable()
 # define migrate_enable()		preempt_enable()
+#ifdef CONFIG_PREEMPT_LL
+   extern void __migrate_disable(void);
+   extern void __migrate_enable(void);
+#endif
 #endif
 
 #ifdef CONFIG_PREEMPT_NOTIFIERS
Index: b/kernel/cpu.c
===================================================================
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -500,11 +500,19 @@ static int __ref _cpu_down(unsigned int 
 	cpumask_andnot(cpumask, cpu_online_mask, cpumask_of(cpu));
 	set_cpus_allowed_ptr(current, cpumask);
 	free_cpumask_var(cpumask);
+#ifdef CONFIG_PREEMPT_LL
+	__migrate_disable();
+#else
 	migrate_disable();
+#endif
 	mycpu = smp_processor_id();
 	if (mycpu == cpu) {
 		printk(KERN_ERR "Yuck! Still on unplug CPU\n!");
+#ifdef CONFIG_PREEMPT_LL
+		__migrate_enable();
+#else
 		migrate_enable();
+#endif
 		return -EBUSY;
 	}
 
@@ -557,7 +565,11 @@ static int __ref _cpu_down(unsigned int 
 out_release:
 	cpu_unplug_done(cpu);
 out_cancel:
+#ifdef CONFIG_PREEMPT_LL
+	__migrate_enable();
+#else
 	migrate_enable();
+#endif
 	cpu_hotplug_done();
 	if (!err)
 		cpu_notify_nofail(CPU_POST_DEAD | mod, hcpu);
Index: b/kernel/sched.c
===================================================================
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -4192,7 +4192,7 @@ static inline void schedule_debug(struct
 	schedstat_inc(this_rq(), sched_count);
 }
 
-#if defined(CONFIG_PREEMPT_RT_FULL) && defined(CONFIG_SMP)
+#if (defined(CONFIG_PREEMPT_RT_FULL) || defined(CONFIG_PREEMPT_LL)) && defined(CONFIG_SMP)
 #define MIGRATE_DISABLE_SET_AFFIN	(1<<30) /* Can't make a negative */
 #define migrate_disabled_updated(p)	((p)->migrate_disable & MIGRATE_DISABLE_SET_AFFIN)
 #define migrate_disable_count(p)	((p)->migrate_disable & ~MIGRATE_DISABLE_SET_AFFIN)
@@ -4228,7 +4228,11 @@ static inline void update_migrate_disabl
 	p->migrate_disable |= MIGRATE_DISABLE_SET_AFFIN;
 }
 
+#ifdef CONFIG_PREEMPT_LL
+void __migrate_disable(void)
+#else
 void migrate_disable(void)
+#endif
 {
 	struct task_struct *p = current;
 
@@ -4254,9 +4258,17 @@ void migrate_disable(void)
 	p->migrate_disable = 1;
 	preempt_enable();
 }
+#ifdef CONFIG_PREEMPT_LL
+EXPORT_SYMBOL(__migrate_disable);
+#else
 EXPORT_SYMBOL(migrate_disable);
+#endif
 
+#ifdef CONFIG_PREEMPT_LL
+void __migrate_enable(void)
+#else
 void migrate_enable(void)
+#endif
 {
 	struct task_struct *p = current;
 	const struct cpumask *mask;
@@ -4306,7 +4318,11 @@ void migrate_enable(void)
 	unpin_current_cpu();
 	preempt_enable();
 }
+#ifdef CONFIG_PREEMPT_LL
+EXPORT_SYMBOL(__migrate_enable);
+#else
 EXPORT_SYMBOL(migrate_enable);
+#endif
 #else
 static inline void update_migrate_disable(struct task_struct *p) { }
 #define migrate_disabled_updated(p)		0
Index: b/include/linux/sched.h
===================================================================
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1260,7 +1260,7 @@ struct task_struct {
 #endif
 
 	unsigned int policy;
-#ifdef CONFIG_PREEMPT_RT_FULL
+#if defined(CONFIG_PREEMPT_RT_FULL) || defined(CONFIG_PREEMPT_LL)
 	int migrate_disable;
 #ifdef CONFIG_SCHED_DEBUG
 	int migrate_disable_atomic;
@@ -2678,7 +2678,7 @@ static inline void set_task_cpu(struct t
 
 static inline int __migrate_disabled(struct task_struct *p)
 {
-#ifdef CONFIG_PREEMPT_RT_FULL
+#if defined(CONFIG_PREEMPT_RT_FULL) || defined(CONFIG_PREEMPT_LL)
 	return p->migrate_disable;
 #else
 	return 0;
@@ -2688,7 +2688,7 @@ static inline int __migrate_disabled(str
 /* Future-safe accessor for struct task_struct's cpus_allowed. */
 static inline const struct cpumask *tsk_cpus_allowed(struct task_struct *p)
 {
-#ifdef CONFIG_PREEMPT_RT_FULL
+#if defined(CONFIG_PREEMPT_RT_FULL) || defined(CONFIG_PREEMPT_LL)
 	if (p->migrate_disable)
 		return cpumask_of(task_cpu(p));
 #endif
