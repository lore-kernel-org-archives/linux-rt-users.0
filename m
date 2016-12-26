From: Mike Galbraith <efault@gmx.de>
Subject: [rfc patch-rt] posix_cpu_timers: Kill hotplug cpu notifier
Date: Mon, 26 Dec 2016 08:00:54 +0100
Message-ID: <1482735654.4476.62.camel@gmx.de>
References: <20161223163213.szj43nv7rnelkbty@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.19]:52964 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751222AbcLZHBJ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 26 Dec 2016 02:01:09 -0500
In-Reply-To: <20161223163213.szj43nv7rnelkbty@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Shamelessly steal softirq.c thread initialization method.

Signed-off-by: Mike Galbraith <efault@gmx.de>
---
 include/linux/cpuhotplug.h     |    1 
 kernel/time/posix-cpu-timers.c |  158 ++++++++++++++---------------------------
 2 files changed, 56 insertions(+), 103 deletions(-)

--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -20,6 +20,7 @@ enum cpuhp_state {
 	CPUHP_SLUB_DEAD,
 	CPUHP_MM_WRITEBACK_DEAD,
 	CPUHP_SOFTIRQ_DEAD,
+	CPUHP_POSIXCPUTMR_DEAD,
 	CPUHP_NET_MVNETA_DEAD,
 	CPUHP_CPUIDLE_DEAD,
 	CPUHP_ARM64_FPSIMD_DEAD,
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -13,6 +13,8 @@
 #include <linux/random.h>
 #include <linux/tick.h>
 #include <linux/workqueue.h>
+#include <linux/smpboot.h>
+#include <linux/cpuhotplug.h>
 
 /*
  * Called after updating RLIMIT_CPU to run cpu timer and update
@@ -1220,62 +1222,36 @@ static void __run_posix_cpu_timers(struc
 DEFINE_PER_CPU(struct task_struct *, posix_timer_task);
 DEFINE_PER_CPU(struct task_struct *, posix_timer_tasklist);
 
-static int posix_cpu_timers_thread(void *data)
+static void posix_cpu_timers_thread(unsigned int cpu)
 {
-	int cpu = (long)data;
+	struct task_struct *tsk = NULL;
+	struct task_struct *next = NULL;
 
-	BUG_ON(per_cpu(posix_timer_task,cpu) != current);
+	/* grab task list */
+	raw_local_irq_disable();
+	tsk = per_cpu(posix_timer_tasklist, cpu);
+	per_cpu(posix_timer_tasklist, cpu) = NULL;
+	raw_local_irq_enable();
+
+	/* Process task list */
+	while (tsk) {
+		/* save next */
+		next = tsk->posix_timer_list;
 
-	while (!kthread_should_stop()) {
-		struct task_struct *tsk = NULL;
-		struct task_struct *next = NULL;
-
-		if (cpu_is_offline(cpu))
-			goto wait_to_die;
-
-		/* grab task list */
-		raw_local_irq_disable();
-		tsk = per_cpu(posix_timer_tasklist, cpu);
-		per_cpu(posix_timer_tasklist, cpu) = NULL;
-		raw_local_irq_enable();
-
-		/* its possible the list is empty, just return */
-		if (!tsk) {
-			set_current_state(TASK_INTERRUPTIBLE);
-			schedule();
-			__set_current_state(TASK_RUNNING);
-			continue;
-		}
-
-		/* Process task list */
-		while (1) {
-			/* save next */
-			next = tsk->posix_timer_list;
+		/* run the task timers, clear its ptr and
+		 * unreference it
+		 */
+		__run_posix_cpu_timers(tsk);
+		tsk->posix_timer_list = NULL;
+		put_task_struct(tsk);
 
-			/* run the task timers, clear its ptr and
-			 * unreference it
-			 */
-			__run_posix_cpu_timers(tsk);
-			tsk->posix_timer_list = NULL;
-			put_task_struct(tsk);
-
-			/* check if this is the last on the list */
-			if (next == tsk)
-				break;
-			tsk = next;
-		}
+		/* check if this is the last on the list */
+		if (next == tsk)
+			break;
+		tsk = next;
 	}
-	return 0;
 
-wait_to_die:
-	/* Wait for kthread_stop */
-	set_current_state(TASK_INTERRUPTIBLE);
-	while (!kthread_should_stop()) {
-		schedule();
-		set_current_state(TASK_INTERRUPTIBLE);
-	}
-	__set_current_state(TASK_RUNNING);
-	return 0;
+	return;
 }
 
 static inline int __fastpath_timer_check(struct task_struct *tsk)
@@ -1322,72 +1298,48 @@ void run_posix_cpu_timers(struct task_st
 	}
 }
 
-/*
- * posix_cpu_thread_call - callback that gets triggered when a CPU is added.
- * Here we can start up the necessary migration thread for the new CPU.
- */
-static int posix_cpu_thread_call(struct notifier_block *nfb,
-				 unsigned long action, void *hcpu)
+static void posix_cpu_thread_setup(unsigned int cpu)
 {
-	int cpu = (long)hcpu;
-	struct task_struct *p;
-	struct sched_param param;
+	struct sched_param param = { .sched_priority = MAX_RT_PRIO-1 };
 
-	switch (action) {
-	case CPU_UP_PREPARE:
-		p = kthread_create(posix_cpu_timers_thread, hcpu,
-					"posixcputmr/%d",cpu);
-		if (IS_ERR(p))
-			return NOTIFY_BAD;
-		p->flags |= PF_NOFREEZE;
-		kthread_bind(p, cpu);
-		/* Must be high prio to avoid getting starved */
-		param.sched_priority = MAX_RT_PRIO-1;
-		sched_setscheduler(p, SCHED_FIFO, &param);
-		per_cpu(posix_timer_task,cpu) = p;
-		break;
-	case CPU_ONLINE:
-		/* Strictly unneccessary, as first user will wake it. */
-		wake_up_process(per_cpu(posix_timer_task,cpu));
-		break;
-#ifdef CONFIG_HOTPLUG_CPU
-	case CPU_UP_CANCELED:
-		/* Unbind it from offline cpu so it can run.  Fall thru. */
-		kthread_bind(per_cpu(posix_timer_task, cpu),
-			     cpumask_any(cpu_online_mask));
-		kthread_stop(per_cpu(posix_timer_task,cpu));
-		per_cpu(posix_timer_task,cpu) = NULL;
-		break;
-	case CPU_DEAD:
-		kthread_stop(per_cpu(posix_timer_task,cpu));
-		per_cpu(posix_timer_task,cpu) = NULL;
-		break;
-#endif
-	}
-	return NOTIFY_OK;
+	current->flags |= PF_NOFREEZE;
+	sched_setscheduler(current, SCHED_FIFO, &param);
 }
 
-/* Register at highest priority so that task migration (migrate_all_tasks)
- * happens before everything else.
- */
-static struct notifier_block posix_cpu_thread_notifier = {
-	.notifier_call = posix_cpu_thread_call,
-	.priority = 10
+static void posix_cpu_thread_cleanup(unsigned int cpu, bool online)
+{
+	struct sched_param param = { .sched_priority = 0 };
+
+	current->flags &= ~PF_NOFREEZE;
+	sched_setscheduler(current, SCHED_NORMAL, &param);
+}
+
+static int posix_cpu_thread_should_run(unsigned int cpu)
+{
+	return !!per_cpu(posix_timer_tasklist, cpu);
+}
+
+static struct smp_hotplug_thread posix_timer_threads = {
+	.store			= &posix_timer_task,
+	.setup			= posix_cpu_thread_setup,
+	.cleanup		= posix_cpu_thread_cleanup,
+	.thread_should_run	= posix_cpu_thread_should_run,
+	.thread_fn		= posix_cpu_timers_thread,
+	.thread_comm		= "posixcputmr/%u",
 };
 
 static int __init posix_cpu_thread_init(void)
 {
-	void *hcpu = (void *)(long)smp_processor_id();
-	/* Start one for boot CPU. */
+	struct smp_hotplug_thread *t = &posix_timer_threads;
 	unsigned long cpu;
 
-	/* init the per-cpu posix_timer_tasklets */
+	/* init the per-cpu posix_timer_tasklist */
 	for_each_possible_cpu(cpu)
 		per_cpu(posix_timer_tasklist, cpu) = NULL;
 
-	posix_cpu_thread_call(&posix_cpu_thread_notifier, CPU_UP_PREPARE, hcpu);
-	posix_cpu_thread_call(&posix_cpu_thread_notifier, CPU_ONLINE, hcpu);
-	register_cpu_notifier(&posix_cpu_thread_notifier);
+	cpuhp_setup_state_nocalls(CPUHP_POSIXCPUTMR_DEAD, "posixcputmr:dead", NULL, NULL);
+	BUG_ON(smpboot_register_percpu_thread(t));
+
 	return 0;
 }
 early_initcall(posix_cpu_thread_init);
