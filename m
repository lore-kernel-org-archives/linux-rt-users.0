From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [ANNOUNCE] v4.11.9-rt7
Date: Tue, 11 Jul 2017 18:15:48 +0200
Message-ID: <20170711161548.omcfjth6h66frhdb@linutronix.de>
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

I'm pleased to announce the v4.11.9-rt7 patch set. 

Changes since v4.11.9-rt6:

  - Alex Shi fixed a "scheduling while atomic" bug on arm64 in the
    CPU idle code.

  - Vikram Mulukutla reported a problem where a parked CPU-hotplug
    thread was still on the runqueue. Patched by Thomas Gleixner.

Known issues
	- CPU hotplug got a little better but can deadlock.

The delta patch against v4.11.9-rt6 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.11/incr/patch-4.11.9-rt6-rt7.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.11.9-rt7

The RT patch against v4.11.9 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.11/older/patch-4.11.9-rt7.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.11/older/patches-4.11.9-rt7.tar.xz

Sebastian
diff --git a/kernel/cpu.c b/kernel/cpu.c
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -627,13 +627,25 @@ void cpu_hotplug_enable(void)
 EXPORT_SYMBOL_GPL(cpu_hotplug_enable);
 #endif	/* CONFIG_HOTPLUG_CPU */
 
-/* Notifier wrappers for transitioning to state machine */
+static void __cpuhp_kick_ap_work(struct cpuhp_cpu_state *st);
 
 static int bringup_wait_for_ap(unsigned int cpu)
 {
 	struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, cpu);
 
+	/* Wait for the CPU to reach CPUHP_AP_ONLINE_IDLE */
 	wait_for_completion(&st->done);
+	BUG_ON(!cpu_online(cpu));
+
+	/* Unpark the stopper thread and the hotplug thread of the target cpu */
+	stop_machine_unpark(cpu);
+	kthread_unpark(st->thread);
+
+	/* Should we go further up ? */
+	if (st->target > CPUHP_AP_ONLINE_IDLE) {
+		__cpuhp_kick_ap_work(st);
+		wait_for_completion(&st->done);
+	}
 	return st->result;
 }
 
@@ -654,9 +666,7 @@ static int bringup_cpu(unsigned int cpu)
 	irq_unlock_sparse();
 	if (ret)
 		return ret;
-	ret = bringup_wait_for_ap(cpu);
-	BUG_ON(!cpu_online(cpu));
-	return ret;
+	return bringup_wait_for_ap(cpu);
 }
 
 /*
@@ -1181,31 +1191,20 @@ void notify_cpu_starting(unsigned int cpu)
 }
 
 /*
- * Called from the idle task. We need to set active here, so we can kick off
- * the stopper thread and unpark the smpboot threads. If the target state is
- * beyond CPUHP_AP_ONLINE_IDLE we kick cpuhp thread and let it bring up the
- * cpu further.
+ * Called from the idle task. Wake up the controlling task which brings the
+ * stopper and the hotplug thread of the upcoming CPU up and then delegates
+ * the rest of the online bringup to the hotplug thread.
  */
 void cpuhp_online_idle(enum cpuhp_state state)
 {
 	struct cpuhp_cpu_state *st = this_cpu_ptr(&cpuhp_state);
-	unsigned int cpu = smp_processor_id();
 
 	/* Happens for the boot cpu */
 	if (state != CPUHP_AP_ONLINE_IDLE)
 		return;
 
 	st->state = CPUHP_AP_ONLINE_IDLE;
-
-	/* Unpark the stopper thread and the hotplug thread of this cpu */
-	stop_machine_unpark(cpu);
-	kthread_unpark(st->thread);
-
-	/* Should we go further up ? */
-	if (st->target > CPUHP_AP_ONLINE_IDLE)
-		__cpuhp_kick_ap_work(st);
-	else
-		complete(&st->done);
+	complete(&st->done);
 }
 
 /* Requires cpu_add_remove_lock to be held */
diff --git a/kernel/cpu_pm.c b/kernel/cpu_pm.c
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
 
diff --git a/localversion-rt b/localversion-rt
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt6
+-rt7
