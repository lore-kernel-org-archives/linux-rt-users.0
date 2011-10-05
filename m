From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Patch to introduce RCU-bh QS where safe from softirq
Date: Wed, 5 Oct 2011 11:45:18 -0700
Message-ID: <20111005184518.GA21601@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org
To: tglx@linutronix.de
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e8.ny.us.ibm.com ([32.97.182.138]:54641 "EHLO e8.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933573Ab1JESpY (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 5 Oct 2011 14:45:24 -0400
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e8.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p95IUDxh014253
	for <linux-rt-users@vger.kernel.org>; Wed, 5 Oct 2011 14:30:13 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id p95IjMMJ1118434
	for <linux-rt-users@vger.kernel.org>; Wed, 5 Oct 2011 14:45:22 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id p95IjJeU029619
	for <linux-rt-users@vger.kernel.org>; Wed, 5 Oct 2011 14:45:22 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello!

The below patch is a first cut for inserting RCU-bh quiescent states
between successive calls to softirq handlers.  This applies on top of
rcu-disable-the-rcu-bh-stuff-for-rt.patch, which implements RCU-bh
in terms of RCU-preempt when CONFIG_PREEMPT_RT_FULL=y.

This patch is probably totally broken, so RFC only.

So, on to scripting running -rt under KVM...

							Thanx, Paul

------------------------------------------------------------------------

rcu: Make ksoftirqd do RCU quiescent states

Implementing RCU-bh in terms of RCU-preempt makes the system vulnerable
to network-based denial-of-service attacks.  This patch therefore
makes __do_softirq() invoke rcu_bh_qs(), but only when __do_softirq()
is running in ksoftirqd context.  A wrapper layer in interposed so that
other calls to __do_softirq() avoid invoking rcu_bh_qs().  The underlying
function __do_softirq_common() does the actual work.

The reason that rcu_bh_qs() is bad in these non-ksoftirqd contexts is
that there might be a local_bh_enable() inside an RCU-preempt read-side
critical section.  This local_bh_enable() can invoke __do_softirq()
directly, so if __do_softirq() were to invoke rcu_bh_qs() (which just
calls rcu_preempt_qs() in the PREEMPT_RT_FULL case), there would be
an illegal RCU-preempt quiescent state in the middle of an RCU-preempt
read-side critical section.  Therefore, quiescent states can only happen
in cases where __do_softirq() is invoked directly from ksoftirqd.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 8ca18f2..e8dc1d8 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -144,13 +144,7 @@ static inline int rcu_preempt_depth(void)
 
 /* Internal to kernel */
 extern void rcu_sched_qs(int cpu);
-
-#ifndef CONFIG_PREEMPT_RT_FULL
 extern void rcu_bh_qs(int cpu);
-#else
-static inline void rcu_bh_qs(int cpu) { }
-#endif
-
 extern void rcu_check_callbacks(int cpu, int user);
 struct notifier_block;
 
diff --git a/kernel/rcutree.c b/kernel/rcutree.c
index 3ffcc9d..71341ab 100644
--- a/kernel/rcutree.c
+++ b/kernel/rcutree.c
@@ -166,7 +166,12 @@ void rcu_sched_qs(int cpu)
 	rdp->passed_quiesc = 1;
 }
 
-#ifndef CONFIG_PREEMPT_RT_FULL
+#ifdef CONFIG_PREEMPT_RT_FULL
+void rcu_bh_qs(int cpu)
+{
+	rcu_preempt_qs(cpu);
+}
+#else
 void rcu_bh_qs(int cpu)
 {
 	struct rcu_data *rdp = &per_cpu(rcu_bh_data, cpu);
diff --git a/kernel/rcutree.h b/kernel/rcutree.h
index 7d91e1b..a8faf16 100644
--- a/kernel/rcutree.h
+++ b/kernel/rcutree.h
@@ -422,6 +422,7 @@ DECLARE_PER_CPU(struct rcu_data, rcu_preempt_data);
 /* Forward declarations for rcutree_plugin.h */
 static void rcu_bootup_announce(void);
 long rcu_batches_completed(void);
+static void rcu_preempt_qs(int cpu);
 static void rcu_preempt_note_context_switch(int cpu);
 static int rcu_preempt_blocked_readers_cgp(struct rcu_node *rnp);
 #ifdef CONFIG_HOTPLUG_CPU
diff --git a/kernel/rcutree_plugin.h b/kernel/rcutree_plugin.h
index 38549eb..2bc9a23 100644
--- a/kernel/rcutree_plugin.h
+++ b/kernel/rcutree_plugin.h
@@ -1892,7 +1892,7 @@ EXPORT_SYMBOL_GPL(synchronize_sched_expedited);
 
 #endif /* #else #ifndef CONFIG_SMP */
 
-#if !defined(CONFIG_RCU_FAST_NO_HZ)
+#if 1 /* !defined(CONFIG_RCU_FAST_NO_HZ) */
 
 /*
  * Check to see if any future RCU-related work will need to be done
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 1afd30b..fd27e9b 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -138,7 +138,7 @@ static void wakeup_softirqd(void)
 		wake_up_process(tsk);
 }
 
-static void handle_pending_softirqs(u32 pending, int cpu)
+static void handle_pending_softirqs(u32 pending, int cpu, int need_rcu_bh_qs)
 {
 	struct softirq_action *h = softirq_vec;
 	unsigned int prev_count = preempt_count();
@@ -161,7 +161,8 @@ static void handle_pending_softirqs(u32 pending, int cpu)
 			       prev_count, (unsigned int) preempt_count());
 			preempt_count() = prev_count;
 		}
-		rcu_bh_qs(cpu);
+		if (need_rcu_bh_qs)
+			rcu_bh_qs(cpu);
 	}
 	local_irq_disable();
 }
@@ -313,7 +314,7 @@ restart:
 	/* Reset the pending bitmask before enabling irqs */
 	set_softirq_pending(0);
 
-	handle_pending_softirqs(pending, cpu);
+	handle_pending_softirqs(pending, cpu, 1);
 
 	pending = local_softirq_pending();
 	if (pending && --max_restart)
@@ -383,7 +384,12 @@ static inline void ksoftirqd_clr_sched_params(void) { }
 static DEFINE_LOCAL_IRQ_LOCK(local_softirq_lock);
 static DEFINE_PER_CPU(struct task_struct *, local_softirq_runner);
 
-static void __do_softirq(void);
+static void __do_softirq_common(int need_rcu_bh_qs);
+
+void __do_softirq(void)
+{
+	__do_softirq_common(0);
+}
 
 void __init softirq_early_init(void)
 {
@@ -446,7 +452,7 @@ int in_serving_softirq(void)
  * Called with bh and local interrupts disabled. For full RT cpu must
  * be pinned.
  */
-static void __do_softirq(void)
+static void __do_softirq_common(int need_rcu_bh_qs)
 {
 	u32 pending = local_softirq_pending();
 	int cpu = smp_processor_id();
@@ -460,7 +466,7 @@ static void __do_softirq(void)
 
 	lockdep_softirq_enter();
 
-	handle_pending_softirqs(pending, cpu);
+	handle_pending_softirqs(pending, cpu, need_rcu_bh_qs);
 
 	pending = local_softirq_pending();
 	if (pending)
@@ -499,7 +505,7 @@ static int __thread_do_softirq(int cpu)
 	 * schedule!
 	 */
 	if (local_softirq_pending())
-		__do_softirq();
+		__do_softirq_common(cpu >= 0);
 	local_unlock(local_softirq_lock);
 	unpin_current_cpu();
 	preempt_disable();
