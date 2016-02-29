From: Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] 3.12.54-rt73
Date: Mon, 29 Feb 2016 12:06:09 -0500
Message-ID: <20160229120609.549e80be@gandalf.local.home>
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
Received: from smtprelay0158.hostedemail.com ([216.40.44.158]:45542 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751930AbcB2RGP (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 29 Feb 2016 12:06:15 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Dear RT Folks,

I'm pleased to announce the 3.12.54-rt73 stable release.


You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v3.12-rt
  Head SHA1: ca4a3e96670bf4ad6a49a9020513f7bb99ded08b


Or to build 3.12.54-rt73 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.12.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.12.54.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.12/patch-3.12.54-rt73.patch.xz



You can also build from 3.12.54-rt72 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.12/incr/patch-3.12.54-rt72-rt73.patch.xz



Enjoy,

-- Steve


Changes from v3.12.54-rt72:

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
      Linux 3.12.54-rt73

Thomas Gleixner (2):
      rtmutex: Handle non enqueued waiters gracefully
      irqwork: Move irq safe work to irq context

bmouring@ni.com (1):
      rtmutex: Use chainwalking control enum

----
 arch/arm/kernel/smp.c             |  5 ++--
 arch/x86/kernel/dumpstack_64.c    |  8 +++----
 drivers/cpufreq/cpufreq.c         | 49 ++++++---------------------------------
 include/linux/irq_work.h          |  6 +++++
 include/trace/events/sched.h      | 30 +++++++++++++++++-------
 kernel/irq_work.c                 |  9 +++++++
 kernel/rtmutex.c                  |  4 ++--
 kernel/sched/core.c               |  8 ++++---
 kernel/timer.c                    |  6 ++---
 kernel/trace/trace_sched_switch.c |  2 +-
 kernel/trace/trace_sched_wakeup.c |  2 +-
 lib/dump_stack.c                  |  4 ++--
 localversion-rt                   |  2 +-
 net/core/dev.c                    |  4 ++--
 14 files changed, 66 insertions(+), 73 deletions(-)
---------------------------
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index bd1b9e633356..2f7325963bf5 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -207,8 +207,6 @@ int __cpu_disable(void)
 	flush_cache_louis();
 	local_flush_tlb_all();
 
-	clear_tasks_mm_cpumask(cpu);
-
 	return 0;
 }
 
@@ -224,6 +222,9 @@ void __cpu_die(unsigned int cpu)
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
index 8356b481e339..012d5169eee2 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -90,12 +90,6 @@ static void unlock_policy_rwsem_##mode(int cpu)				\
 unlock_policy_rwsem(read, cpu);
 unlock_policy_rwsem(write, cpu);
 
-/*
- * rwsem to guarantee that cpufreq driver module doesn't unload during critical
- * sections
- */
-static DECLARE_RWSEM(cpufreq_rwsem);
-
 /* internal prototypes */
 static int __cpufreq_governor(struct cpufreq_policy *policy,
 		unsigned int event);
@@ -191,9 +185,6 @@ struct cpufreq_policy *cpufreq_cpu_get(unsigned int cpu)
 	if (cpufreq_disabled() || (cpu >= nr_cpu_ids))
 		return NULL;
 
-	if (!down_read_trylock(&cpufreq_rwsem))
-		return NULL;
-
 	/* get the cpufreq driver */
 	read_lock_irqsave(&cpufreq_driver_lock, flags);
 
@@ -206,9 +197,6 @@ struct cpufreq_policy *cpufreq_cpu_get(unsigned int cpu)
 
 	read_unlock_irqrestore(&cpufreq_driver_lock, flags);
 
-	if (!policy)
-		up_read(&cpufreq_rwsem);
-
 	return policy;
 }
 EXPORT_SYMBOL_GPL(cpufreq_cpu_get);
@@ -219,7 +207,6 @@ void cpufreq_cpu_put(struct cpufreq_policy *policy)
 		return;
 
 	kobject_put(&policy->kobj);
-	up_read(&cpufreq_rwsem);
 }
 EXPORT_SYMBOL_GPL(cpufreq_cpu_put);
 
@@ -664,13 +651,10 @@ static ssize_t show(struct kobject *kobj, struct attribute *attr, char *buf)
 {
 	struct cpufreq_policy *policy = to_policy(kobj);
 	struct freq_attr *fattr = to_attr(attr);
-	ssize_t ret = -EINVAL;
-
-	if (!down_read_trylock(&cpufreq_rwsem))
-		goto exit;
+	ssize_t ret;
 
 	if (lock_policy_rwsem_read(policy->cpu) < 0)
-		goto up_read;
+		return -EINVAL;
 
 	if (fattr->show)
 		ret = fattr->show(policy, buf);
@@ -679,9 +663,6 @@ static ssize_t show(struct kobject *kobj, struct attribute *attr, char *buf)
 
 	unlock_policy_rwsem_read(policy->cpu);
 
-up_read:
-	up_read(&cpufreq_rwsem);
-exit:
 	return ret;
 }
 
@@ -697,11 +678,8 @@ static ssize_t store(struct kobject *kobj, struct attribute *attr,
 	if (!cpu_online(policy->cpu))
 		goto unlock;
 
-	if (!down_read_trylock(&cpufreq_rwsem))
-		goto unlock;
-
 	if (lock_policy_rwsem_write(policy->cpu) < 0)
-		goto up_read;
+		goto unlock;
 
 	if (fattr->store)
 		ret = fattr->store(policy, buf, count);
@@ -710,8 +688,6 @@ static ssize_t store(struct kobject *kobj, struct attribute *attr,
 
 	unlock_policy_rwsem_write(policy->cpu);
 
-up_read:
-	up_read(&cpufreq_rwsem);
 unlock:
 	put_online_cpus();
 
@@ -1011,9 +987,6 @@ static int __cpufreq_add_dev(struct device *dev, struct subsys_interface *sif,
 	}
 #endif
 
-	if (!down_read_trylock(&cpufreq_rwsem))
-		return 0;
-
 #ifdef CONFIG_HOTPLUG_CPU
 	/* Check if this cpu was hot-unplugged earlier and has siblings */
 	read_lock_irqsave(&cpufreq_driver_lock, flags);
@@ -1021,7 +994,6 @@ static int __cpufreq_add_dev(struct device *dev, struct subsys_interface *sif,
 		if (cpumask_test_cpu(cpu, tpolicy->related_cpus)) {
 			read_unlock_irqrestore(&cpufreq_driver_lock, flags);
 			ret = cpufreq_add_policy_cpu(tpolicy, cpu, dev, frozen);
-			up_read(&cpufreq_rwsem);
 			return ret;
 		}
 	}
@@ -1035,7 +1007,7 @@ static int __cpufreq_add_dev(struct device *dev, struct subsys_interface *sif,
 		policy = cpufreq_policy_alloc();
 
 	if (!policy)
-		goto nomem_out;
+		return ret;
 
 
 	/*
@@ -1106,7 +1078,6 @@ static int __cpufreq_add_dev(struct device *dev, struct subsys_interface *sif,
 	cpufreq_init_policy(policy);
 
 	kobject_uevent(&policy->kobj, KOBJ_ADD);
-	up_read(&cpufreq_rwsem);
 
 	pr_debug("initialization complete\n");
 
@@ -1120,8 +1091,6 @@ err_out_unregister:
 
 err_set_policy_cpu:
 	cpufreq_policy_free(policy);
-nomem_out:
-	up_read(&cpufreq_rwsem);
 
 	return ret;
 }
@@ -1474,9 +1443,6 @@ unsigned int cpufreq_get(unsigned int cpu)
 	if (cpufreq_disabled() || !cpufreq_driver)
 		return -ENOENT;
 
-	if (!down_read_trylock(&cpufreq_rwsem))
-		return 0;
-
 	if (unlikely(lock_policy_rwsem_read(cpu)))
 		goto out_policy;
 
@@ -1485,8 +1451,6 @@ unsigned int cpufreq_get(unsigned int cpu)
 	unlock_policy_rwsem_read(cpu);
 
 out_policy:
-	up_read(&cpufreq_rwsem);
-
 	return ret_freq;
 }
 EXPORT_SYMBOL(cpufreq_get);
@@ -2184,16 +2148,17 @@ int cpufreq_unregister_driver(struct cpufreq_driver *driver)
 
 	pr_debug("unregistering driver %s\n", driver->name);
 
+	/* Protect against concurrent cpu hotplug */
+	get_online_cpus();
 	subsys_interface_unregister(&cpufreq_interface);
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
index 2e7d9947a10d..004eb037865c 100644
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
diff --git a/kernel/rtmutex.c b/kernel/rtmutex.c
index 7601c1332a88..8061201b3163 100644
--- a/kernel/rtmutex.c
+++ b/kernel/rtmutex.c
@@ -1182,7 +1182,7 @@ static void  noinline __sched rt_spin_lock_slowlock(struct rt_mutex *lock)
 	__set_current_state(TASK_UNINTERRUPTIBLE);
 	pi_unlock(&self->pi_lock);
 
-	ret = task_blocks_on_rt_mutex(lock, &waiter, self, 0);
+	ret = task_blocks_on_rt_mutex(lock, &waiter, self, RT_MUTEX_MIN_CHAINWALK);
 	BUG_ON(ret);
 
 	for (;;) {
@@ -2065,7 +2065,7 @@ int rt_mutex_start_proxy_lock(struct rt_mutex *lock,
 		ret = 0;
 	}
 
-	if (unlikely(ret))
+	if (ret && rt_mutex_has_waiters(lock))
 		remove_waiter(lock, waiter);
 
 	raw_spin_unlock(&lock->wait_lock);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3e8b790e5c17..14b5ba66fa72 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1394,9 +1394,9 @@ static void
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
@@ -1581,6 +1581,8 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	if (!(wake_flags & WF_LOCK_SLEEPER))
 		p->saved_state = TASK_RUNNING;
 
+	trace_sched_waking(p);
+
 	success = 1; /* we're going to change ->state */
 	cpu = task_cpu(p);
 
@@ -1826,7 +1828,7 @@ void wake_up_new_task(struct task_struct *p)
 	rq = __task_rq_lock(p);
 	activate_task(rq, p, 0);
 	p->on_rq = 1;
-	trace_sched_wakeup_new(p, true);
+	trace_sched_wakeup_new(p);
 	check_preempt_curr(rq, p, WF_FORK);
 #ifdef CONFIG_SMP
 	if (p->sched_class->task_woken)
diff --git a/kernel/timer.c b/kernel/timer.c
index bf1277c2203b..400ef0bde253 100644
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
index 4e98e3b257a3..82fe794af532 100644
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
index fee77e15d815..8e967ca56006 100644
--- a/kernel/trace/trace_sched_wakeup.c
+++ b/kernel/trace/trace_sched_wakeup.c
@@ -458,7 +458,7 @@ static void wakeup_reset(struct trace_array *tr)
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
index 2c95a3cdbcb8..e8ada8cdb471 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt72
+-rt73
diff --git a/net/core/dev.c b/net/core/dev.c
index 30fd8898bcfb..cfec8a542d35 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6231,7 +6231,7 @@ EXPORT_SYMBOL(free_netdev);
 void synchronize_net(void)
 {
 	might_sleep();
-	if (rtnl_is_locked())
+	if (rtnl_is_locked() && !IS_ENABLED(CONFIG_PREEMPT_RT_FULL))
 		synchronize_rcu_expedited();
 	else
 		synchronize_rcu();
@@ -6481,7 +6481,7 @@ static int dev_cpu_callback(struct notifier_block *nfb,
 		netif_rx(skb);
 		input_queue_head_incr(oldsd);
 	}
-	while ((skb = skb_dequeue(&oldsd->input_pkt_queue))) {
+	while ((skb = __skb_dequeue(&oldsd->input_pkt_queue))) {
 		netif_rx(skb);
 		input_queue_head_incr(oldsd);
 	}
