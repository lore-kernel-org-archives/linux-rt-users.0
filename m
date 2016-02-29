From: Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] 3.14.61-rt63
Date: Mon, 29 Feb 2016 12:05:38 -0500
Message-ID: <20160229120538.7d6c04fc@gandalf.local.home>
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

I'm pleased to announce the 3.14.61-rt63 stable release.


You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v3.14-rt
  Head SHA1: 816f701e4c913df9650b5e5d7beef56659b93c47


Or to build 3.14.61-rt63 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.14.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.14.61.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.14/patch-3.14.61-rt63.patch.xz



You can also build from 3.14.61-rt62 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.14/incr/patch-3.14.61-rt62-rt63.patch.xz



Enjoy,

-- Steve


Changes from v3.14.61-rt62:

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
      Linux 3.14.61-rt63

Thomas Gleixner (2):
      rtmutex: Handle non enqueued waiters gracefully
      irqwork: Move irq safe work to irq context

bmouring@ni.com (1):
      rtmutex: Use chainwalking control enum

----
 arch/arm/kernel/smp.c             |  5 +++--
 arch/x86/kernel/dumpstack_64.c    |  8 ++++----
 drivers/cpufreq/cpufreq.c         | 34 +++-------------------------------
 include/linux/irq_work.h          |  6 ++++++
 include/trace/events/sched.h      | 30 +++++++++++++++++++++---------
 kernel/irq_work.c                 |  9 +++++++++
 kernel/locking/rtmutex.c          |  4 ++--
 kernel/sched/core.c               |  8 +++++---
 kernel/timer.c                    |  6 ++----
 kernel/trace/trace_sched_switch.c |  2 +-
 kernel/trace/trace_sched_wakeup.c |  2 +-
 lib/dump_stack.c                  |  4 ++--
 localversion-rt                   |  2 +-
 net/core/dev.c                    |  4 ++--
 14 files changed, 62 insertions(+), 62 deletions(-)
---------------------------
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 8cd3724714fe..0480b2685da0 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -209,8 +209,6 @@ int __cpu_disable(void)
 	flush_cache_louis();
 	local_flush_tlb_all();
 
-	clear_tasks_mm_cpumask(cpu);
-
 	return 0;
 }
 
@@ -226,6 +224,9 @@ void __cpu_die(unsigned int cpu)
 		pr_err("CPU%u: cpu didn't die\n", cpu);
 		return;
 	}
+
+	clear_tasks_mm_cpumask(cpu);
+
 	printk(KERN_NOTICE "CPU%u: shutdown\n", cpu);
 
 	/*
diff --git a/arch/x86/kernel/dumpstack_64.c b/arch/x86/kernel/dumpstack_64.c
index 66e274a3d968..37aee503a7ba 100644
--- a/arch/x86/kernel/dumpstack_64.c
+++ b/arch/x86/kernel/dumpstack_64.c
@@ -114,7 +114,7 @@ void dump_trace(struct task_struct *task, struct pt_regs *regs,
 		unsigned long *stack, unsigned long bp,
 		const struct stacktrace_ops *ops, void *data)
 {
-	const unsigned cpu = get_cpu();
+	const unsigned cpu = get_cpu_light();
 	unsigned long *irq_stack_end =
 		(unsigned long *)per_cpu(irq_stack_ptr, cpu);
 	unsigned used = 0;
@@ -191,7 +191,7 @@ void dump_trace(struct task_struct *task, struct pt_regs *regs,
 	 * This handles the process stack:
 	 */
 	bp = ops->walk_stack(tinfo, stack, bp, ops, data, NULL, &graph);
-	put_cpu();
+	put_cpu_light();
 }
 EXPORT_SYMBOL(dump_trace);
 
@@ -205,7 +205,7 @@ show_stack_log_lvl(struct task_struct *task, struct pt_regs *regs,
 	int cpu;
 	int i;
 
-	preempt_disable();
+	migrate_disable();
 	cpu = smp_processor_id();
 
 	irq_stack_end	= (unsigned long *)(per_cpu(irq_stack_ptr, cpu));
@@ -238,7 +238,7 @@ show_stack_log_lvl(struct task_struct *task, struct pt_regs *regs,
 		pr_cont(" %016lx", *stack++);
 		touch_nmi_watchdog();
 	}
-	preempt_enable();
+	migrate_enable();
 
 	pr_cont("\n");
 	show_trace_log_lvl(task, regs, sp, bp, log_lvl);
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index ef3b8adb9d47..885d441c0af3 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -52,12 +52,6 @@ static inline bool has_target(void)
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
@@ -198,9 +192,6 @@ struct cpufreq_policy *cpufreq_cpu_get(unsigned int cpu)
 	if (cpufreq_disabled() || (cpu >= nr_cpu_ids))
 		return NULL;
 
-	if (!down_read_trylock(&cpufreq_rwsem))
-		return NULL;
-
 	/* get the cpufreq driver */
 	read_lock_irqsave(&cpufreq_driver_lock, flags);
 
@@ -213,9 +204,6 @@ struct cpufreq_policy *cpufreq_cpu_get(unsigned int cpu)
 
 	read_unlock_irqrestore(&cpufreq_driver_lock, flags);
 
-	if (!policy)
-		up_read(&cpufreq_rwsem);
-
 	return policy;
 }
 EXPORT_SYMBOL_GPL(cpufreq_cpu_get);
@@ -226,7 +214,6 @@ void cpufreq_cpu_put(struct cpufreq_policy *policy)
 		return;
 
 	kobject_put(&policy->kobj);
-	up_read(&cpufreq_rwsem);
 }
 EXPORT_SYMBOL_GPL(cpufreq_cpu_put);
 
@@ -710,9 +697,6 @@ static ssize_t show(struct kobject *kobj, struct attribute *attr, char *buf)
 	struct freq_attr *fattr = to_attr(attr);
 	ssize_t ret;
 
-	if (!down_read_trylock(&cpufreq_rwsem))
-		return -EINVAL;
-
 	down_read(&policy->rwsem);
 
 	if (fattr->show)
@@ -721,7 +705,6 @@ static ssize_t show(struct kobject *kobj, struct attribute *attr, char *buf)
 		ret = -EIO;
 
 	up_read(&policy->rwsem);
-	up_read(&cpufreq_rwsem);
 
 	return ret;
 }
@@ -738,9 +721,6 @@ static ssize_t store(struct kobject *kobj, struct attribute *attr,
 	if (!cpu_online(policy->cpu))
 		goto unlock;
 
-	if (!down_read_trylock(&cpufreq_rwsem))
-		goto unlock;
-
 	down_write(&policy->rwsem);
 
 	if (fattr->store)
@@ -749,8 +729,6 @@ static ssize_t store(struct kobject *kobj, struct attribute *attr,
 		ret = -EIO;
 
 	up_write(&policy->rwsem);
-
-	up_read(&cpufreq_rwsem);
 unlock:
 	put_online_cpus();
 
@@ -1065,9 +1043,6 @@ static int __cpufreq_add_dev(struct device *dev, struct subsys_interface *sif,
 	}
 #endif
 
-	if (!down_read_trylock(&cpufreq_rwsem))
-		return 0;
-
 #ifdef CONFIG_HOTPLUG_CPU
 	/* Check if this cpu was hot-unplugged earlier and has siblings */
 	read_lock_irqsave(&cpufreq_driver_lock, flags);
@@ -1075,7 +1050,6 @@ static int __cpufreq_add_dev(struct device *dev, struct subsys_interface *sif,
 		if (cpumask_test_cpu(cpu, tpolicy->related_cpus)) {
 			read_unlock_irqrestore(&cpufreq_driver_lock, flags);
 			ret = cpufreq_add_policy_cpu(tpolicy, cpu, dev);
-			up_read(&cpufreq_rwsem);
 			return ret;
 		}
 	}
@@ -1223,7 +1197,6 @@ static int __cpufreq_add_dev(struct device *dev, struct subsys_interface *sif,
 	up_write(&policy->rwsem);
 
 	kobject_uevent(&policy->kobj, KOBJ_ADD);
-	up_read(&cpufreq_rwsem);
 
 	pr_debug("initialization complete\n");
 
@@ -1249,8 +1222,6 @@ err_set_policy_cpu:
 	cpufreq_policy_free(policy);
 
 nomem_out:
-	up_read(&cpufreq_rwsem);
-
 	return ret;
 }
 
@@ -2399,19 +2370,20 @@ int cpufreq_unregister_driver(struct cpufreq_driver *driver)
 
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
diff --git a/include/linux/irq_work.h b/include/linux/irq_work.h
index 4a8c7a2df480..ccd736ebee9e 100644
--- a/include/linux/irq_work.h
+++ b/include/linux/irq_work.h
@@ -44,4 +44,10 @@ bool irq_work_needs_cpu(void);
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
index dc7bb01f580f..67b26cdf3f52 100644
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
diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index af8ceafc94e4..883bb73698b9 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -163,8 +163,17 @@ void irq_work_tick(void)
 
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
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index ee4e7e747e06..4bd9790dece5 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1251,7 +1251,7 @@ static void  noinline __sched rt_spin_lock_slowlock(struct rt_mutex *lock)
 	__set_current_state(TASK_UNINTERRUPTIBLE);
 	pi_unlock(&self->pi_lock);
 
-	ret = task_blocks_on_rt_mutex(lock, &waiter, self, 0);
+	ret = task_blocks_on_rt_mutex(lock, &waiter, self, RT_MUTEX_MIN_CHAINWALK);
 	BUG_ON(ret);
 
 	for (;;) {
@@ -2138,7 +2138,7 @@ int rt_mutex_start_proxy_lock(struct rt_mutex *lock,
 		ret = 0;
 	}
 
-	if (unlikely(ret))
+	if (ret && rt_mutex_has_waiters(lock))
 		remove_waiter(lock, waiter);
 
 	raw_spin_unlock(&lock->wait_lock);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a570a5846af2..edacb6d1d2bf 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1481,9 +1481,9 @@ static void
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
@@ -1676,6 +1676,8 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	if (!(wake_flags & WF_LOCK_SLEEPER))
 		p->saved_state = TASK_RUNNING;
 
+	trace_sched_waking(p);
+
 	success = 1; /* we're going to change ->state */
 	cpu = task_cpu(p);
 
@@ -2078,7 +2080,7 @@ void wake_up_new_task(struct task_struct *p)
 	rq = __task_rq_lock(p);
 	activate_task(rq, p, 0);
 	p->on_rq = 1;
-	trace_sched_wakeup_new(p, true);
+	trace_sched_wakeup_new(p);
 	check_preempt_curr(rq, p, WF_FORK);
 #ifdef CONFIG_SMP
 	if (p->sched_class->task_woken)
diff --git a/kernel/timer.c b/kernel/timer.c
index 300870358b4f..3796af212c95 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -1450,7 +1450,7 @@ void update_process_times(int user_tick)
 	scheduler_tick();
 	run_local_timers();
 	rcu_check_callbacks(cpu, user_tick);
-#if defined(CONFIG_IRQ_WORK) && !defined(CONFIG_PREEMPT_RT_FULL)
+#if defined(CONFIG_IRQ_WORK)
 	if (in_irq())
 		irq_work_run();
 #endif
@@ -1466,9 +1466,7 @@ static void run_timer_softirq(struct softirq_action *h)
 
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
index 6e32635e5e57..32eea7ba8c4a 100644
--- a/kernel/trace/trace_sched_wakeup.c
+++ b/kernel/trace/trace_sched_wakeup.c
@@ -462,7 +462,7 @@ static void wakeup_reset(struct trace_array *tr)
 }
 
 static void
-probe_wakeup(void *ignore, struct task_struct *p, int success)
+probe_wakeup(void *ignore, struct task_struct *p)
 {
 	struct trace_array_cpu *data;
 	int cpu = smp_processor_id();
diff --git a/lib/dump_stack.c b/lib/dump_stack.c
index f23b63f0a1c3..b39c60b1f12c 100644
--- a/lib/dump_stack.c
+++ b/lib/dump_stack.c
@@ -33,7 +33,7 @@ asmlinkage void dump_stack(void)
 	 * Permit this cpu to perform nested stack dumps while serialising
 	 * against other CPUs
 	 */
-	preempt_disable();
+	migrate_disable();
 
 retry:
 	cpu = smp_processor_id();
@@ -52,7 +52,7 @@ retry:
 	if (!was_locked)
 		atomic_set(&dump_lock, -1);
 
-	preempt_enable();
+	migrate_enable();
 }
 #else
 asmlinkage void dump_stack(void)
diff --git a/localversion-rt b/localversion-rt
index 40d81d8e61b6..b0e8dd7bd707 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt62
+-rt63
diff --git a/net/core/dev.c b/net/core/dev.c
index 6febdc96835f..055dc9c98b10 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6638,7 +6638,7 @@ EXPORT_SYMBOL(free_netdev);
 void synchronize_net(void)
 {
 	might_sleep();
-	if (rtnl_is_locked())
+	if (rtnl_is_locked() && !IS_ENABLED(CONFIG_PREEMPT_RT_FULL))
 		synchronize_rcu_expedited();
 	else
 		synchronize_rcu();
@@ -6890,7 +6890,7 @@ static int dev_cpu_callback(struct notifier_block *nfb,
 		netif_rx_internal(skb);
 		input_queue_head_incr(oldsd);
 	}
-	while ((skb = skb_dequeue(&oldsd->input_pkt_queue))) {
+	while ((skb = __skb_dequeue(&oldsd->input_pkt_queue))) {
 		netif_rx_internal(skb);
 		input_queue_head_incr(oldsd);
 	}
