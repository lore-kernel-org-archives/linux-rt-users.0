From: Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] 3.18.27-rt26
Date: Mon, 29 Feb 2016 12:05:12 -0500
Message-ID: <20160229120512.3830fb23@gandalf.local.home>
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

I'm pleased to announce the 3.18.27-rt26 stable release.


You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v3.18-rt
  Head SHA1: 9df6942317afb556a87b905a0c1137c06d6b53a3


Or to build 3.18.27-rt26 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.18.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.18.27.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.18/patch-3.18.27-rt26.patch.xz



You can also build from 3.18.27-rt25 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.18/incr/patch-3.18.27-rt25-rt26.patch.xz



Enjoy,

-- Steve


Changes from v3.18.27-rt25:

---

Grygorii Strashko (2):
      ARM: smp: Move clear_tasks_mm_cpumask() call to __cpu_die()
      net/core/cpuhotplug: Drain input_pkt_queue lockless

Josh Cartwright (1):
      net: Make synchronize_rcu_expedited() conditional on !RT_FULL

Peter Zijlstra (1):
      sched: Introduce the trace_sched_waking tracepoint

Sebastian Andrzej Siewior (2):
      cpufreq: Remove cpufreq_rwsem
      dump stack: don't disable preemption during trace

Steven Rostedt (Red Hat) (1):
      Linux 3.18.27-rt26

Thomas Gleixner (3):
      genirq: Handle force threading of interrupts with primary and thread handler
      rtmutex: Handle non enqueued waiters gracefully
      irqwork: Move irq safe work to irq context

Wolfgang M. Reimer (1):
      locking: locktorture: Do NOT include rwlock.h directly

bmouring@ni.com (1):
      rtmutex: Use chainwalking control enum

----
 arch/arm/kernel/smp.c             |   5 +-
 arch/x86/kernel/dumpstack_32.c    |   4 +-
 arch/x86/kernel/dumpstack_64.c    |   8 +-
 drivers/cpufreq/cpufreq.c         |  34 +-------
 include/linux/interrupt.h         |   2 +
 include/linux/irq_work.h          |   6 ++
 include/trace/events/sched.h      |  30 +++++---
 kernel/irq/manage.c               | 158 ++++++++++++++++++++++++++++----------
 kernel/irq_work.c                 |   9 +++
 kernel/locking/locktorture.c      |   1 -
 kernel/locking/rtmutex.c          |   4 +-
 kernel/sched/core.c               |   8 +-
 kernel/time/timer.c               |   6 +-
 kernel/trace/trace_sched_switch.c |   2 +-
 kernel/trace/trace_sched_wakeup.c |   2 +-
 lib/dump_stack.c                  |   6 +-
 localversion-rt                   |   2 +-
 net/core/dev.c                    |   4 +-
 18 files changed, 183 insertions(+), 108 deletions(-)
---------------------------
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index a8e32aaf0383..6e9b81666a23 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -208,8 +208,6 @@ int __cpu_disable(void)
 	flush_cache_louis();
 	local_flush_tlb_all();
 
-	clear_tasks_mm_cpumask(cpu);
-
 	return 0;
 }
 
@@ -225,6 +223,9 @@ void __cpu_die(unsigned int cpu)
 		pr_err("CPU%u: cpu didn't die\n", cpu);
 		return;
 	}
+
+	clear_tasks_mm_cpumask(cpu);
+
 	printk(KERN_NOTICE "CPU%u: shutdown\n", cpu);
 
 	/*
diff --git a/arch/x86/kernel/dumpstack_32.c b/arch/x86/kernel/dumpstack_32.c
index 5abd4cd4230c..1282817bb4c3 100644
--- a/arch/x86/kernel/dumpstack_32.c
+++ b/arch/x86/kernel/dumpstack_32.c
@@ -42,7 +42,7 @@ void dump_trace(struct task_struct *task, struct pt_regs *regs,
 		unsigned long *stack, unsigned long bp,
 		const struct stacktrace_ops *ops, void *data)
 {
-	const unsigned cpu = get_cpu();
+	const unsigned cpu = get_cpu_light();
 	int graph = 0;
 	u32 *prev_esp;
 
@@ -86,7 +86,7 @@ void dump_trace(struct task_struct *task, struct pt_regs *regs,
 			break;
 		touch_nmi_watchdog();
 	}
-	put_cpu();
+	put_cpu_light();
 }
 EXPORT_SYMBOL(dump_trace);
 
diff --git a/arch/x86/kernel/dumpstack_64.c b/arch/x86/kernel/dumpstack_64.c
index ff86f19b5758..4821f291890f 100644
--- a/arch/x86/kernel/dumpstack_64.c
+++ b/arch/x86/kernel/dumpstack_64.c
@@ -152,7 +152,7 @@ void dump_trace(struct task_struct *task, struct pt_regs *regs,
 		unsigned long *stack, unsigned long bp,
 		const struct stacktrace_ops *ops, void *data)
 {
-	const unsigned cpu = get_cpu();
+	const unsigned cpu = get_cpu_light();
 	struct thread_info *tinfo;
 	unsigned long *irq_stack = (unsigned long *)per_cpu(irq_stack_ptr, cpu);
 	unsigned long dummy;
@@ -241,7 +241,7 @@ void dump_trace(struct task_struct *task, struct pt_regs *regs,
 	 * This handles the process stack:
 	 */
 	bp = ops->walk_stack(tinfo, stack, bp, ops, data, NULL, &graph);
-	put_cpu();
+	put_cpu_light();
 }
 EXPORT_SYMBOL(dump_trace);
 
@@ -255,7 +255,7 @@ show_stack_log_lvl(struct task_struct *task, struct pt_regs *regs,
 	int cpu;
 	int i;
 
-	preempt_disable();
+	migrate_disable();
 	cpu = smp_processor_id();
 
 	irq_stack_end	= (unsigned long *)(per_cpu(irq_stack_ptr, cpu));
@@ -288,7 +288,7 @@ show_stack_log_lvl(struct task_struct *task, struct pt_regs *regs,
 		pr_cont(" %016lx", *stack++);
 		touch_nmi_watchdog();
 	}
-	preempt_enable();
+	migrate_enable();
 
 	pr_cont("\n");
 	show_trace_log_lvl(task, regs, sp, bp, log_lvl);
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 90e8deb6c15e..7a9c1a7ecfe5 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -53,12 +53,6 @@ static inline bool has_target(void)
 	return cpufreq_driver->target_index || cpufreq_driver->target;
 }
 
-/*
- * rwsem to guarantee that cpufreq driver module doesn't unload during critical
- * sections
- */
-static DECLARE_RWSEM(cpufreq_rwsem);
-
 /* internal prototypes */
 static int __cpufreq_governor(struct cpufreq_policy *policy,
 		unsigned int event);
@@ -205,9 +199,6 @@ struct cpufreq_policy *cpufreq_cpu_get(unsigned int cpu)
 	if (cpufreq_disabled() || (cpu >= nr_cpu_ids))
 		return NULL;
 
-	if (!down_read_trylock(&cpufreq_rwsem))
-		return NULL;
-
 	/* get the cpufreq driver */
 	read_lock_irqsave(&cpufreq_driver_lock, flags);
 
@@ -220,9 +211,6 @@ struct cpufreq_policy *cpufreq_cpu_get(unsigned int cpu)
 
 	read_unlock_irqrestore(&cpufreq_driver_lock, flags);
 
-	if (!policy)
-		up_read(&cpufreq_rwsem);
-
 	return policy;
 }
 EXPORT_SYMBOL_GPL(cpufreq_cpu_get);
@@ -233,7 +221,6 @@ void cpufreq_cpu_put(struct cpufreq_policy *policy)
 		return;
 
 	kobject_put(&policy->kobj);
-	up_read(&cpufreq_rwsem);
 }
 EXPORT_SYMBOL_GPL(cpufreq_cpu_put);
 
@@ -762,9 +749,6 @@ static ssize_t show(struct kobject *kobj, struct attribute *attr, char *buf)
 	struct freq_attr *fattr = to_attr(attr);
 	ssize_t ret;
 
-	if (!down_read_trylock(&cpufreq_rwsem))
-		return -EINVAL;
-
 	down_read(&policy->rwsem);
 
 	if (fattr->show)
@@ -773,7 +757,6 @@ static ssize_t show(struct kobject *kobj, struct attribute *attr, char *buf)
 		ret = -EIO;
 
 	up_read(&policy->rwsem);
-	up_read(&cpufreq_rwsem);
 
 	return ret;
 }
@@ -790,9 +773,6 @@ static ssize_t store(struct kobject *kobj, struct attribute *attr,
 	if (!cpu_online(policy->cpu))
 		goto unlock;
 
-	if (!down_read_trylock(&cpufreq_rwsem))
-		goto unlock;
-
 	down_write(&policy->rwsem);
 
 	if (fattr->store)
@@ -801,8 +781,6 @@ static ssize_t store(struct kobject *kobj, struct attribute *attr,
 		ret = -EIO;
 
 	up_write(&policy->rwsem);
-
-	up_read(&cpufreq_rwsem);
 unlock:
 	put_online_cpus();
 
@@ -1142,9 +1120,6 @@ static int __cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 	}
 #endif
 
-	if (!down_read_trylock(&cpufreq_rwsem))
-		return 0;
-
 #ifdef CONFIG_HOTPLUG_CPU
 	/* Check if this cpu was hot-unplugged earlier and has siblings */
 	read_lock_irqsave(&cpufreq_driver_lock, flags);
@@ -1152,7 +1127,6 @@ static int __cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 		if (cpumask_test_cpu(cpu, tpolicy->related_cpus)) {
 			read_unlock_irqrestore(&cpufreq_driver_lock, flags);
 			ret = cpufreq_add_policy_cpu(tpolicy, cpu, dev);
-			up_read(&cpufreq_rwsem);
 			return ret;
 		}
 	}
@@ -1288,7 +1262,6 @@ static int __cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 	up_write(&policy->rwsem);
 
 	kobject_uevent(&policy->kobj, KOBJ_ADD);
-	up_read(&cpufreq_rwsem);
 
 	pr_debug("initialization complete\n");
 
@@ -1314,8 +1287,6 @@ err_set_policy_cpu:
 	cpufreq_policy_free(policy);
 
 nomem_out:
-	up_read(&cpufreq_rwsem);
-
 	return ret;
 }
 
@@ -2528,19 +2499,20 @@ int cpufreq_unregister_driver(struct cpufreq_driver *driver)
 
 	pr_debug("unregistering driver %s\n", driver->name);
 
+	/* Protect against concurrent cpu hotplug */
+	get_online_cpus();
 	subsys_interface_unregister(&cpufreq_interface);
 	if (cpufreq_boost_supported())
 		cpufreq_sysfs_remove_file(&boost.attr);
 
 	unregister_hotcpu_notifier(&cpufreq_cpu_notifier);
 
-	down_write(&cpufreq_rwsem);
 	write_lock_irqsave(&cpufreq_driver_lock, flags);
 
 	cpufreq_driver = NULL;
 
 	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
-	up_write(&cpufreq_rwsem);
+	put_online_cpus();
 
 	return 0;
 }
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 33cfbc085a94..86628c733be7 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -100,6 +100,7 @@ typedef irqreturn_t (*irq_handler_t)(int, void *);
  * @flags:	flags (see IRQF_* above)
  * @thread_fn:	interrupt handler function for threaded interrupts
  * @thread:	thread pointer for threaded interrupts
+ * @secondary:	pointer to secondary irqaction (force threading)
  * @thread_flags:	flags related to @thread
  * @thread_mask:	bitmask for keeping track of @thread activity
  * @dir:	pointer to the proc/irq/NN/name entry
@@ -111,6 +112,7 @@ struct irqaction {
 	struct irqaction	*next;
 	irq_handler_t		thread_fn;
 	struct task_struct	*thread;
+	struct irqaction	*secondary;
 	unsigned int		irq;
 	unsigned int		flags;
 	unsigned long		thread_flags;
diff --git a/include/linux/irq_work.h b/include/linux/irq_work.h
index 30ef6c214e6f..af7ed9ad52c3 100644
--- a/include/linux/irq_work.h
+++ b/include/linux/irq_work.h
@@ -51,4 +51,10 @@ bool irq_work_needs_cpu(void);
 static inline bool irq_work_needs_cpu(void) { return false; }
 #endif
 
+#if defined(CONFIG_IRQ_WORK) && defined(CONFIG_PREEMPT_RT_FULL)
+void irq_work_tick_soft(void);
+#else
+static inline void irq_work_tick_soft(void) { }
+#endif
+
 #endif /* _LINUX_IRQ_WORK_H */
diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index a7d67bc14906..09f27eb85ef8 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -55,9 +55,9 @@ TRACE_EVENT(sched_kthread_stop_ret,
  */
 DECLARE_EVENT_CLASS(sched_wakeup_template,
 
-	TP_PROTO(struct task_struct *p, int success),
+	TP_PROTO(struct task_struct *p),
 
-	TP_ARGS(__perf_task(p), success),
+	TP_ARGS(__perf_task(p)),
 
 	TP_STRUCT__entry(
 		__array(	char,	comm,	TASK_COMM_LEN	)
@@ -71,25 +71,37 @@ DECLARE_EVENT_CLASS(sched_wakeup_template,
 		memcpy(__entry->comm, p->comm, TASK_COMM_LEN);
 		__entry->pid		= p->pid;
 		__entry->prio		= p->prio;
-		__entry->success	= success;
+		__entry->success	= 1; /* rudiment, kill when possible */
 		__entry->target_cpu	= task_cpu(p);
 	),
 
-	TP_printk("comm=%s pid=%d prio=%d success=%d target_cpu=%03d",
+	TP_printk("comm=%s pid=%d prio=%d target_cpu=%03d",
 		  __entry->comm, __entry->pid, __entry->prio,
-		  __entry->success, __entry->target_cpu)
+		  __entry->target_cpu)
 );
 
+/*
+ * Tracepoint called when waking a task; this tracepoint is guaranteed to be
+ * called from the waking context.
+ */
+DEFINE_EVENT(sched_wakeup_template, sched_waking,
+	     TP_PROTO(struct task_struct *p),
+	     TP_ARGS(p));
+
+/*
+ * Tracepoint called when the task is actually woken; p->state == TASK_RUNNNG.
+ * It it not always called from the waking context.
+ */
 DEFINE_EVENT(sched_wakeup_template, sched_wakeup,
-	     TP_PROTO(struct task_struct *p, int success),
-	     TP_ARGS(p, success));
+	     TP_PROTO(struct task_struct *p),
+	     TP_ARGS(p));
 
 /*
  * Tracepoint for waking up a new task:
  */
 DEFINE_EVENT(sched_wakeup_template, sched_wakeup_new,
-	     TP_PROTO(struct task_struct *p, int success),
-	     TP_ARGS(p, success));
+	     TP_PROTO(struct task_struct *p),
+	     TP_ARGS(p));
 
 #ifdef CREATE_TRACE_POINTS
 static inline long __trace_sched_switch_state(struct task_struct *p)
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 382cbe57abf3..70f59992c201 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -735,6 +735,12 @@ static irqreturn_t irq_nested_primary_handler(int irq, void *dev_id)
 	return IRQ_NONE;
 }
 
+static irqreturn_t irq_forced_secondary_handler(int irq, void *dev_id)
+{
+	WARN(1, "Secondary action handler called for irq %d\n", irq);
+	return IRQ_NONE;
+}
+
 static int irq_wait_for_interrupt(struct irqaction *action)
 {
 	set_current_state(TASK_INTERRUPTIBLE);
@@ -761,7 +767,8 @@ static int irq_wait_for_interrupt(struct irqaction *action)
 static void irq_finalize_oneshot(struct irq_desc *desc,
 				 struct irqaction *action)
 {
-	if (!(desc->istate & IRQS_ONESHOT))
+	if (!(desc->istate & IRQS_ONESHOT) ||
+	    action->handler == irq_forced_secondary_handler)
 		return;
 again:
 	chip_bus_lock(desc);
@@ -923,6 +930,18 @@ static void irq_thread_dtor(struct callback_head *unused)
 	irq_finalize_oneshot(desc, action);
 }
 
+static void irq_wake_secondary(struct irq_desc *desc, struct irqaction *action)
+{
+	struct irqaction *secondary = action->secondary;
+
+	if (WARN_ON_ONCE(!secondary))
+		return;
+
+	raw_spin_lock_irq(&desc->lock);
+	__irq_wake_thread(desc, secondary);
+	raw_spin_unlock_irq(&desc->lock);
+}
+
 /*
  * Interrupt handler thread
  */
@@ -953,6 +972,8 @@ static int irq_thread(void *data)
 		action_ret = handler_fn(desc, action);
 		if (action_ret == IRQ_HANDLED)
 			atomic_inc(&desc->threads_handled);
+		if (action_ret == IRQ_WAKE_THREAD)
+			irq_wake_secondary(desc, action);
 
 #ifdef CONFIG_PREEMPT_RT_FULL
 		migrate_disable();
@@ -1003,20 +1024,36 @@ void irq_wake_thread(unsigned int irq, void *dev_id)
 }
 EXPORT_SYMBOL_GPL(irq_wake_thread);
 
-static void irq_setup_forced_threading(struct irqaction *new)
+static int irq_setup_forced_threading(struct irqaction *new)
 {
 	if (!force_irqthreads)
-		return;
+		return 0;
 	if (new->flags & (IRQF_NO_THREAD | IRQF_PERCPU | IRQF_ONESHOT))
-		return;
+		return 0;
 
 	new->flags |= IRQF_ONESHOT;
 
-	if (!new->thread_fn) {
-		set_bit(IRQTF_FORCED_THREAD, &new->thread_flags);
-		new->thread_fn = new->handler;
-		new->handler = irq_default_primary_handler;
+	/*
+	 * Handle the case where we have a real primary handler and a
+	 * thread handler. We force thread them as well by creating a
+	 * secondary action.
+	 */
+	if (new->handler != irq_default_primary_handler && new->thread_fn) {
+		/* Allocate the secondary action */
+		new->secondary = kzalloc(sizeof(struct irqaction), GFP_KERNEL);
+		if (!new->secondary)
+			return -ENOMEM;
+		new->secondary->handler = irq_forced_secondary_handler;
+		new->secondary->thread_fn = new->thread_fn;
+		new->secondary->dev_id = new->dev_id;
+		new->secondary->irq = new->irq;
+		new->secondary->name = new->name;
 	}
+	/* Deal with the primary handler */
+	set_bit(IRQTF_FORCED_THREAD, &new->thread_flags);
+	new->thread_fn = new->handler;
+	new->handler = irq_default_primary_handler;
+	return 0;
 }
 
 static int irq_request_resources(struct irq_desc *desc)
@@ -1036,6 +1073,48 @@ static void irq_release_resources(struct irq_desc *desc)
 		c->irq_release_resources(d);
 }
 
+static int
+setup_irq_thread(struct irqaction *new, unsigned int irq, bool secondary)
+{
+	struct task_struct *t;
+	struct sched_param param = {
+		.sched_priority = MAX_USER_RT_PRIO/2,
+	};
+
+	if (!secondary) {
+		t = kthread_create(irq_thread, new, "irq/%d-%s", irq,
+				   new->name);
+	} else {
+		t = kthread_create(irq_thread, new, "irq/%d-s-%s", irq,
+				   new->name);
+		param.sched_priority += 1;
+	}
+
+	if (IS_ERR(t))
+		return PTR_ERR(t);
+
+	sched_setscheduler_nocheck(t, SCHED_FIFO, &param);
+
+	/*
+	 * We keep the reference to the task struct even if
+	 * the thread dies to avoid that the interrupt code
+	 * references an already freed task_struct.
+	 */
+	get_task_struct(t);
+	new->thread = t;
+	/*
+	 * Tell the thread to set its affinity. This is
+	 * important for shared interrupt handlers as we do
+	 * not invoke setup_affinity() for the secondary
+	 * handlers as everything is already set up. Even for
+	 * interrupts marked with IRQF_NO_BALANCE this is
+	 * correct as we want the thread to move to the cpu(s)
+	 * on which the requesting code placed the interrupt.
+	 */
+	set_bit(IRQTF_AFFINITY, &new->thread_flags);
+	return 0;
+}
+
 /*
  * Internal function to register an irqaction - typically used to
  * allocate special interrupts that are part of the architecture.
@@ -1056,6 +1135,8 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 	if (!try_module_get(desc->owner))
 		return -ENODEV;
 
+	new->irq = irq;
+
 	/*
 	 * Check whether the interrupt nests into another interrupt
 	 * thread.
@@ -1073,8 +1154,11 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 		 */
 		new->handler = irq_nested_primary_handler;
 	} else {
-		if (irq_settings_can_thread(desc))
-			irq_setup_forced_threading(new);
+		if (irq_settings_can_thread(desc)) {
+			ret = irq_setup_forced_threading(new);
+			if (ret)
+				goto out_mput;
+		}
 	}
 
 	/*
@@ -1083,37 +1167,14 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 	 * thread.
 	 */
 	if (new->thread_fn && !nested) {
-		struct task_struct *t;
-		static const struct sched_param param = {
-			.sched_priority = MAX_USER_RT_PRIO/2,
-		};
-
-		t = kthread_create(irq_thread, new, "irq/%d-%s", irq,
-				   new->name);
-		if (IS_ERR(t)) {
-			ret = PTR_ERR(t);
+		ret = setup_irq_thread(new, irq, false);
+		if (ret)
 			goto out_mput;
+		if (new->secondary) {
+			ret = setup_irq_thread(new->secondary, irq, true);
+			if (ret)
+				goto out_thread;
 		}
-
-		sched_setscheduler_nocheck(t, SCHED_FIFO, &param);
-
-		/*
-		 * We keep the reference to the task struct even if
-		 * the thread dies to avoid that the interrupt code
-		 * references an already freed task_struct.
-		 */
-		get_task_struct(t);
-		new->thread = t;
-		/*
-		 * Tell the thread to set its affinity. This is
-		 * important for shared interrupt handlers as we do
-		 * not invoke setup_affinity() for the secondary
-		 * handlers as everything is already set up. Even for
-		 * interrupts marked with IRQF_NO_BALANCE this is
-		 * correct as we want the thread to move to the cpu(s)
-		 * on which the requesting code placed the interrupt.
-		 */
-		set_bit(IRQTF_AFFINITY, &new->thread_flags);
 	}
 
 	if (!alloc_cpumask_var(&mask, GFP_KERNEL)) {
@@ -1289,7 +1350,6 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 				   irq, nmsk, omsk);
 	}
 
-	new->irq = irq;
 	*old_ptr = new;
 
 	irq_pm_install_action(desc, new);
@@ -1315,6 +1375,8 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 	 */
 	if (new->thread)
 		wake_up_process(new->thread);
+	if (new->secondary)
+		wake_up_process(new->secondary->thread);
 
 	register_irq_proc(irq, desc);
 	new->dir = NULL;
@@ -1345,6 +1407,13 @@ out_thread:
 		kthread_stop(t);
 		put_task_struct(t);
 	}
+	if (new->secondary && new->secondary->thread) {
+		struct task_struct *t = new->secondary->thread;
+
+		new->secondary->thread = NULL;
+		kthread_stop(t);
+		put_task_struct(t);
+	}
 out_mput:
 	module_put(desc->owner);
 	return ret;
@@ -1452,9 +1521,14 @@ static struct irqaction *__free_irq(unsigned int irq, void *dev_id)
 	if (action->thread) {
 		kthread_stop(action->thread);
 		put_task_struct(action->thread);
+		if (action->secondary && action->secondary->thread) {
+			kthread_stop(action->secondary->thread);
+			put_task_struct(action->secondary->thread);
+		}
 	}
 
 	module_put(desc->owner);
+	kfree(action->secondary);
 	return action;
 }
 
@@ -1593,8 +1667,10 @@ int request_threaded_irq(unsigned int irq, irq_handler_t handler,
 	retval = __setup_irq(irq, desc, action);
 	chip_bus_sync_unlock(desc);
 
-	if (retval)
+	if (retval) {
+		kfree(action->secondary);
 		kfree(action);
+	}
 
 #ifdef CONFIG_DEBUG_SHIRQ_FIXME
 	if (!retval && (irqflags & IRQF_SHARED)) {
diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index 9678fd1382a7..3d5a476b58b9 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -200,8 +200,17 @@ void irq_work_tick(void)
 
 	if (!llist_empty(raised) && !arch_irq_work_has_interrupt())
 		irq_work_run_list(raised);
+
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT_FULL))
+		irq_work_run_list(this_cpu_ptr(&lazy_list));
+}
+
+#if defined(CONFIG_IRQ_WORK) && defined(CONFIG_PREEMPT_RT_FULL)
+void irq_work_tick_soft(void)
+{
 	irq_work_run_list(this_cpu_ptr(&lazy_list));
 }
+#endif
 
 /*
  * Synchronize against the irq_work @entry, ensures the entry is not
diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index ec8cce259779..aa60d919e336 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -24,7 +24,6 @@
 #include <linux/module.h>
 #include <linux/kthread.h>
 #include <linux/spinlock.h>
-#include <linux/rwlock.h>
 #include <linux/mutex.h>
 #include <linux/rwsem.h>
 #include <linux/smp.h>
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 64973df0c686..8d950b4521fc 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1008,7 +1008,7 @@ static void  noinline __sched rt_spin_lock_slowlock(struct rt_mutex *lock)
 	__set_current_state(TASK_UNINTERRUPTIBLE);
 	pi_unlock(&self->pi_lock);
 
-	ret = task_blocks_on_rt_mutex(lock, &waiter, self, 0);
+	ret = task_blocks_on_rt_mutex(lock, &waiter, self, RT_MUTEX_MIN_CHAINWALK);
 	BUG_ON(ret);
 
 	for (;;) {
@@ -2144,7 +2144,7 @@ int rt_mutex_start_proxy_lock(struct rt_mutex *lock,
 		ret = 0;
 	}
 
-	if (unlikely(ret))
+	if (ret && rt_mutex_has_waiters(lock))
 		remove_waiter(lock, waiter);
 
 	raw_spin_unlock(&lock->wait_lock);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7e844b4f1701..9e01a8f358f8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1606,9 +1606,9 @@ static void
 ttwu_do_wakeup(struct rq *rq, struct task_struct *p, int wake_flags)
 {
 	check_preempt_curr(rq, p, wake_flags);
-	trace_sched_wakeup(p, true);
-
 	p->state = TASK_RUNNING;
+	trace_sched_wakeup(p);
+
 #ifdef CONFIG_SMP
 	if (p->sched_class->task_woken)
 		p->sched_class->task_woken(rq, p);
@@ -1832,6 +1832,8 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	if (!(wake_flags & WF_LOCK_SLEEPER))
 		p->saved_state = TASK_RUNNING;
 
+	trace_sched_waking(p);
+
 	success = 1; /* we're going to change ->state */
 	cpu = task_cpu(p);
 
@@ -2247,7 +2249,7 @@ void wake_up_new_task(struct task_struct *p)
 	rq = __task_rq_lock(p);
 	activate_task(rq, p, 0);
 	p->on_rq = TASK_ON_RQ_QUEUED;
-	trace_sched_wakeup_new(p, true);
+	trace_sched_wakeup_new(p);
 	check_preempt_curr(rq, p, WF_FORK);
 #ifdef CONFIG_SMP
 	if (p->sched_class->task_woken)
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 3a978d000fce..78e39b644780 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1451,7 +1451,7 @@ void update_process_times(int user_tick)
 	run_local_timers();
 	rcu_check_callbacks(cpu, user_tick);
 
-#if defined(CONFIG_IRQ_WORK) && !defined(CONFIG_PREEMPT_RT_FULL)
+#if defined(CONFIG_IRQ_WORK)
 	if (in_irq())
 		irq_work_tick();
 #endif
@@ -1467,9 +1467,7 @@ static void run_timer_softirq(struct softirq_action *h)
 
 	hrtimer_run_pending();
 
-#if defined(CONFIG_IRQ_WORK) && defined(CONFIG_PREEMPT_RT_FULL)
-	irq_work_tick();
-#endif
+	irq_work_tick_soft();
 
 	if (time_after_eq(jiffies, base->timer_jiffies))
 		__run_timers(base);
diff --git a/kernel/trace/trace_sched_switch.c b/kernel/trace/trace_sched_switch.c
index 3f34dc9b40f3..9586cde520b0 100644
--- a/kernel/trace/trace_sched_switch.c
+++ b/kernel/trace/trace_sched_switch.c
@@ -106,7 +106,7 @@ tracing_sched_wakeup_trace(struct trace_array *tr,
 }
 
 static void
-probe_sched_wakeup(void *ignore, struct task_struct *wakee, int success)
+probe_sched_wakeup(void *ignore, struct task_struct *wakee)
 {
 	struct trace_array_cpu *data;
 	unsigned long flags;
diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
index 19bd8928ce94..808258ccf6c5 100644
--- a/kernel/trace/trace_sched_wakeup.c
+++ b/kernel/trace/trace_sched_wakeup.c
@@ -460,7 +460,7 @@ static void wakeup_reset(struct trace_array *tr)
 }
 
 static void
-probe_wakeup(void *ignore, struct task_struct *p, int success)
+probe_wakeup(void *ignore, struct task_struct *p)
 {
 	struct trace_array_cpu *data;
 	int cpu = smp_processor_id();
diff --git a/lib/dump_stack.c b/lib/dump_stack.c
index c30d07e99dba..01ca6dae9414 100644
--- a/lib/dump_stack.c
+++ b/lib/dump_stack.c
@@ -25,7 +25,6 @@ static atomic_t dump_lock = ATOMIC_INIT(-1);
 
 asmlinkage __visible void dump_stack(void)
 {
-	unsigned long flags;
 	int was_locked;
 	int old;
 	int cpu;
@@ -34,8 +33,8 @@ asmlinkage __visible void dump_stack(void)
 	 * Permit this cpu to perform nested stack dumps while serialising
 	 * against other CPUs
 	 */
+	migrate_disable();
 retry:
-	local_irq_save(flags);
 	cpu = smp_processor_id();
 	old = atomic_cmpxchg(&dump_lock, -1, cpu);
 	if (old == -1) {
@@ -43,7 +42,6 @@ retry:
 	} else if (old == cpu) {
 		was_locked = 1;
 	} else {
-		local_irq_restore(flags);
 		cpu_relax();
 		goto retry;
 	}
@@ -53,7 +51,7 @@ retry:
 	if (!was_locked)
 		atomic_set(&dump_lock, -1);
 
-	local_irq_restore(flags);
+	migrate_enable();
 }
 #else
 asmlinkage __visible void dump_stack(void)
diff --git a/localversion-rt b/localversion-rt
index c5b71f9a229d..2e9afd4a0afd 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt25
+-rt26
diff --git a/net/core/dev.c b/net/core/dev.c
index 1cbcf08cc224..39d2a0ba38ed 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6813,7 +6813,7 @@ EXPORT_SYMBOL(free_netdev);
 void synchronize_net(void)
 {
 	might_sleep();
-	if (rtnl_is_locked())
+	if (rtnl_is_locked() && !IS_ENABLED(CONFIG_PREEMPT_RT_FULL))
 		synchronize_rcu_expedited();
 	else
 		synchronize_rcu();
@@ -7065,7 +7065,7 @@ static int dev_cpu_callback(struct notifier_block *nfb,
 		netif_rx_internal(skb);
 		input_queue_head_incr(oldsd);
 	}
-	while ((skb = skb_dequeue(&oldsd->input_pkt_queue))) {
+	while ((skb = __skb_dequeue(&oldsd->input_pkt_queue))) {
 		netif_rx_internal(skb);
 		input_queue_head_incr(oldsd);
 	}
