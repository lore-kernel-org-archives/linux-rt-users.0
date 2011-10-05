From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: Patch to introduce RCU-bh QS where safe from softirq
Date: Wed, 5 Oct 2011 11:59:38 -0700
Message-ID: <20111005185938.GA20403@linux.vnet.ibm.com>
References: <20111005184518.GA21601@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org
To: tglx@linutronix.de
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e8.ny.us.ibm.com ([32.97.182.138]:57678 "EHLO e8.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933170Ab1JES7l (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 5 Oct 2011 14:59:41 -0400
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by e8.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p95IiTii030550
	for <linux-rt-users@vger.kernel.org>; Wed, 5 Oct 2011 14:44:29 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id p95IxeG0209312
	for <linux-rt-users@vger.kernel.org>; Wed, 5 Oct 2011 14:59:40 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id p95Ixdlc006799
	for <linux-rt-users@vger.kernel.org>; Wed, 5 Oct 2011 14:59:39 -0400
Content-Disposition: inline
In-Reply-To: <20111005184518.GA21601@linux.vnet.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Oct 05, 2011 at 11:45:18AM -0700, Paul E. McKenney wrote:
> Hello!
> 
> The below patch is a first cut for inserting RCU-bh quiescent states
> between successive calls to softirq handlers.  This applies on top of
> rcu-disable-the-rcu-bh-stuff-for-rt.patch, which implements RCU-bh
> in terms of RCU-preempt when CONFIG_PREEMPT_RT_FULL=y.
> 
> This patch is probably totally broken, so RFC only.
> 
> So, on to scripting running -rt under KVM...

And here is a version of rcu-disable-the-rcu-bh-stuff-for-rt.patch
with an updated changelog.

							Thanx, Paul

------------------------------------------------------------------------

rcu: Merge RCU-bh into RCU-preempt

The Linux kernel has long RCU-bh read-side critical sections that
intolerably increase scheduling latency under mainline's RCU-bh rules,
which include RCU-bh read-side critical sections being non-preemptible.
This patch therefore arranges for RCU-bh to be implemented in terms of
RCU-preempt for CONFIG_PREEMPT_RT_FULL=y.

This has the downside of defeating the purpose of RCU-bh, namely,
handling the case where the system is subjected to a network-based
denial-of-service attack that keeps at least one CPU doing full-time
softirq processing.  This issue will be fixed by a later commit.

The current commit will need some work to make it appropriate for
mainline use, for example, it needs to be extended to cover Tiny RCU.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index e8f9d18..8ca18f2 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -78,7 +78,13 @@ struct rcu_head {
 extern void call_rcu_sched(struct rcu_head *head,
 			   void (*func)(struct rcu_head *rcu));
 extern void synchronize_sched(void);
+
+#ifdef CONFIG_PREEMPT_RT_FULL
+# define rcu_barrier_bh		rcu_barrier
+#else
 extern void rcu_barrier_bh(void);
+#endif
+
 extern void rcu_barrier_sched(void);
 
 static inline void __rcu_read_lock_bh(void)
@@ -138,7 +144,13 @@ static inline int rcu_preempt_depth(void)
 
 /* Internal to kernel */
 extern void rcu_sched_qs(int cpu);
+
+#ifndef CONFIG_PREEMPT_RT_FULL
 extern void rcu_bh_qs(int cpu);
+#else
+static inline void rcu_bh_qs(int cpu) { }
+#endif
+
 extern void rcu_check_callbacks(int cpu, int user);
 struct notifier_block;
 
@@ -229,7 +241,14 @@ static inline int rcu_read_lock_held(void)
  * rcu_read_lock_bh_held() is defined out of line to avoid #include-file
  * hell.
  */
+#ifdef CONFIG_PREEMPT_RT_FULL
+static inline int rcu_read_lock_bh_held(void)
+{
+	return rcu_read_lock_held();
+}
+#else
 extern int rcu_read_lock_bh_held(void);
+#endif
 
 /**
  * rcu_read_lock_sched_held() - might we be in RCU-sched read-side critical section?
@@ -638,8 +657,13 @@ static inline void rcu_read_unlock(void)
 static inline void rcu_read_lock_bh(void)
 {
 	__rcu_read_lock_bh();
+
+#ifdef CONFIG_PREEMPT_RT_FULL
+	rcu_read_lock();
+#else
 	__acquire(RCU_BH);
 	rcu_read_acquire_bh();
+#endif
 }
 
 /*
@@ -649,8 +673,12 @@ static inline void rcu_read_lock_bh(void)
  */
 static inline void rcu_read_unlock_bh(void)
 {
+#ifdef CONFIG_PREEMPT_RT_FULL
+	rcu_read_unlock();
+#else
 	rcu_read_release_bh();
 	__release(RCU_BH);
+#endif
 	__rcu_read_unlock_bh();
 }
 
@@ -757,6 +785,9 @@ extern void call_rcu(struct rcu_head *head,
 
 #endif /* #else #ifdef CONFIG_PREEMPT_RCU */
 
+#ifdef CONFIG_PREEMPT_RT_FULL
+#define call_rcu_bh	call_rcu
+#else
 /**
  * call_rcu_bh() - Queue an RCU for invocation after a quicker grace period.
  * @head: structure to be used for queueing the RCU updates.
@@ -777,6 +808,7 @@ extern void call_rcu(struct rcu_head *head,
  */
 extern void call_rcu_bh(struct rcu_head *head,
 			void (*func)(struct rcu_head *head));
+#endif
 
 /*
  * debug_rcu_head_queue()/debug_rcu_head_unqueue() are used internally
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index e65d066..7a25aea 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -57,7 +57,11 @@ static inline void exit_rcu(void)
 
 #endif /* #else #ifdef CONFIG_TREE_PREEMPT_RCU */
 
+#ifndef CONFIG_PREEMPT_RT_FULL
 extern void synchronize_rcu_bh(void);
+#else
+# define synchronize_rcu_bh()	synchronize_rcu()
+#endif
 extern void synchronize_sched_expedited(void);
 extern void synchronize_rcu_expedited(void);
 
@@ -71,13 +75,19 @@ extern void rcu_barrier(void);
 extern unsigned long rcutorture_testseq;
 extern unsigned long rcutorture_vernum;
 extern long rcu_batches_completed(void);
-extern long rcu_batches_completed_bh(void);
 extern long rcu_batches_completed_sched(void);
 
 extern void rcu_force_quiescent_state(void);
-extern void rcu_bh_force_quiescent_state(void);
 extern void rcu_sched_force_quiescent_state(void);
 
+#ifndef CONFIG_PREEMPT_RT_FULL
+extern void rcu_bh_force_quiescent_state(void);
+extern long rcu_batches_completed_bh(void);
+#else
+# define rcu_bh_force_quiescent_state	rcu_force_quiescent_state
+# define rcu_batches_completed_bh	rcu_batches_completed
+#endif
+
 /* A context switch is a grace period for RCU-sched and RCU-bh. */
 static inline int rcu_blocking_is_gp(void)
 {
diff --git a/kernel/rcupdate.c b/kernel/rcupdate.c
index 7784bd2..5e0577b 100644
--- a/kernel/rcupdate.c
+++ b/kernel/rcupdate.c
@@ -72,6 +72,7 @@ int debug_lockdep_rcu_enabled(void)
 }
 EXPORT_SYMBOL_GPL(debug_lockdep_rcu_enabled);
 
+#ifndef CONFIG_PREEMPT_RT_FULL
 /**
  * rcu_read_lock_bh_held() - might we be in RCU-bh read-side critical section?
  *
@@ -91,6 +92,7 @@ int rcu_read_lock_bh_held(void)
 	return in_softirq() || irqs_disabled();
 }
 EXPORT_SYMBOL_GPL(rcu_read_lock_bh_held);
+#endif
 
 #endif /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
 
diff --git a/kernel/rcutree.c b/kernel/rcutree.c
index 4151bfc..3ffcc9d 100644
--- a/kernel/rcutree.c
+++ b/kernel/rcutree.c
@@ -166,6 +166,7 @@ void rcu_sched_qs(int cpu)
 	rdp->passed_quiesc = 1;
 }
 
+#ifndef CONFIG_PREEMPT_RT_FULL
 void rcu_bh_qs(int cpu)
 {
 	struct rcu_data *rdp = &per_cpu(rcu_bh_data, cpu);
@@ -174,6 +175,7 @@ void rcu_bh_qs(int cpu)
 	barrier();
 	rdp->passed_quiesc = 1;
 }
+#endif
 
 /*
  * Note a context switch.  This is a quiescent state for RCU-sched,
@@ -216,6 +218,7 @@ long rcu_batches_completed_sched(void)
 }
 EXPORT_SYMBOL_GPL(rcu_batches_completed_sched);
 
+#ifndef CONFIG_PREEMPT_RT_FULL
 /*
  * Return the number of RCU BH batches processed thus far for debug & stats.
  */
@@ -233,6 +236,7 @@ void rcu_bh_force_quiescent_state(void)
 	force_quiescent_state(&rcu_bh_state, 0);
 }
 EXPORT_SYMBOL_GPL(rcu_bh_force_quiescent_state);
+#endif
 
 /*
  * Record the number of times rcutorture tests have been initiated and
@@ -1579,6 +1583,7 @@ void call_rcu_sched(struct rcu_head *head, void (*func)(struct rcu_head *rcu))
 }
 EXPORT_SYMBOL_GPL(call_rcu_sched);
 
+#ifndef CONFIG_PREEMPT_RT_FULL
 /*
  * Queue an RCU for invocation after a quicker grace period.
  */
@@ -1587,6 +1592,7 @@ void call_rcu_bh(struct rcu_head *head, void (*func)(struct rcu_head *rcu))
 	__call_rcu(head, func, &rcu_bh_state);
 }
 EXPORT_SYMBOL_GPL(call_rcu_bh);
+#endif
 
 /**
  * synchronize_sched - wait until an rcu-sched grace period has elapsed.
@@ -1628,6 +1634,7 @@ void synchronize_sched(void)
 }
 EXPORT_SYMBOL_GPL(synchronize_sched);
 
+#ifndef CONFIG_PREEMPT_RT_FULL
 /**
  * synchronize_rcu_bh - wait until an rcu_bh grace period has elapsed.
  *
@@ -1653,6 +1660,7 @@ void synchronize_rcu_bh(void)
 	destroy_rcu_head_on_stack(&rcu.head);
 }
 EXPORT_SYMBOL_GPL(synchronize_rcu_bh);
+#endif
 
 /*
  * Check to see if there is any immediate RCU-related work to be done
@@ -1806,6 +1814,7 @@ static void _rcu_barrier(struct rcu_state *rsp,
 	mutex_unlock(&rcu_barrier_mutex);
 }
 
+#ifndef CONFIG_PREEMPT_RT_FULL
 /**
  * rcu_barrier_bh - Wait until all in-flight call_rcu_bh() callbacks complete.
  */
@@ -1814,6 +1823,7 @@ void rcu_barrier_bh(void)
 	_rcu_barrier(&rcu_bh_state, call_rcu_bh);
 }
 EXPORT_SYMBOL_GPL(rcu_barrier_bh);
+#endif
 
 /**
  * rcu_barrier_sched - Wait for in-flight call_rcu_sched() callbacks.
