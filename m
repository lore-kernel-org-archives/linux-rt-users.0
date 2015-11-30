From: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [PATCH tip v5 5/5] rcu: use simple wait queues where possible in rcutree
Date: Mon, 30 Nov 2015 14:38:31 +0100
Message-ID: <1448890711-5812-6-git-send-email-daniel.wagner@bmw-carit.de>
References: <1448890711-5812-1-git-send-email-daniel.wagner@bmw-carit.de>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
	Daniel Wagner <daniel.wagner@bmw-carit.de>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kbuild@vger.kernel.org,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448890711-5812-1-git-send-email-daniel.wagner@bmw-carit.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Paul Gortmaker <paul.gortmaker@windriver.com>

As of commit dae6e64d2bcfd4b06304ab864c7e3a4f6b5fedf4 ("rcu: Introduce
proper blocking to no-CBs kthreads GP waits") the RCU subsystem started
making use of wait queues.

Here we convert all additions of RCU wait queues to use simple wait queues,
since they don't need the extra overhead of the full wait queue features.

Originally this was done for RT kernels[1], since we would get things like...

  BUG: sleeping function called from invalid context at kernel/rtmutex.c:659
  in_atomic(): 1, irqs_disabled(): 1, pid: 8, name: rcu_preempt
  Pid: 8, comm: rcu_preempt Not tainted
  Call Trace:
   [<ffffffff8106c8d0>] __might_sleep+0xd0/0xf0
   [<ffffffff817d77b4>] rt_spin_lock+0x24/0x50
   [<ffffffff8106fcf6>] __wake_up+0x36/0x70
   [<ffffffff810c4542>] rcu_gp_kthread+0x4d2/0x680
   [<ffffffff8105f910>] ? __init_waitqueue_head+0x50/0x50
   [<ffffffff810c4070>] ? rcu_gp_fqs+0x80/0x80
   [<ffffffff8105eabb>] kthread+0xdb/0xe0
   [<ffffffff8106b912>] ? finish_task_switch+0x52/0x100
   [<ffffffff817e0754>] kernel_thread_helper+0x4/0x10
   [<ffffffff8105e9e0>] ? __init_kthread_worker+0x60/0x60
   [<ffffffff817e0750>] ? gs_change+0xb/0xb

...and hence simple wait queues were deployed on RT out of necessity
(as simple wait uses a raw lock), but mainline might as well take
advantage of the more streamline support as well.

[1] This is a carry forward of work from v3.10-rt; the original conversion
was by Thomas on an earlier -rt version, and Sebastian extended it to
additional post-3.10 added RCU waiters; here I've added a commit log and
unified the RCU changes into one, and uprev'd it to match mainline RCU.

Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/rcu/tree.c        | 22 +++++++++++-----------
 kernel/rcu/tree.h        | 13 +++++++------
 kernel/rcu/tree_plugin.h | 26 +++++++++++++-------------
 3 files changed, 31 insertions(+), 30 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index ff02ffb..628ffb5 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1588,7 +1588,7 @@ static void rcu_gp_kthread_wake(struct rcu_state *rsp)
 	    !READ_ONCE(rsp->gp_flags) ||
 	    !rsp->gp_kthread)
 		return;
-	wake_up(&rsp->gp_wq);
+	swake_up(&rsp->gp_wq);
 }
 
 /*
@@ -1971,7 +1971,7 @@ static void rcu_gp_cleanup(struct rcu_state *rsp)
 	int nocb = 0;
 	struct rcu_data *rdp;
 	struct rcu_node *rnp = rcu_get_root(rsp);
-	wait_queue_head_t *sq;
+	struct swait_queue_head *sq;
 
 	WRITE_ONCE(rsp->gp_activity, jiffies);
 	raw_spin_lock_irq(&rnp->lock);
@@ -2059,7 +2059,7 @@ static int __noreturn rcu_gp_kthread(void *arg)
 					       READ_ONCE(rsp->gpnum),
 					       TPS("reqwait"));
 			rsp->gp_state = RCU_GP_WAIT_GPS;
-			wait_event_interruptible(rsp->gp_wq,
+			swait_event_interruptible(rsp->gp_wq,
 						 READ_ONCE(rsp->gp_flags) &
 						 RCU_GP_FLAG_INIT);
 			rsp->gp_state = RCU_GP_DONE_GPS;
@@ -2089,7 +2089,7 @@ static int __noreturn rcu_gp_kthread(void *arg)
 					       READ_ONCE(rsp->gpnum),
 					       TPS("fqswait"));
 			rsp->gp_state = RCU_GP_WAIT_FQS;
-			ret = wait_event_interruptible_timeout(rsp->gp_wq,
+			ret = swait_event_interruptible_timeout(rsp->gp_wq,
 					rcu_gp_fqs_check_wake(rsp, &gf), j);
 			rsp->gp_state = RCU_GP_DOING_FQS;
 			/* Locking provides needed memory barriers. */
@@ -2212,7 +2212,7 @@ static void rcu_report_qs_rsp(struct rcu_state *rsp, unsigned long flags)
 	WARN_ON_ONCE(!rcu_gp_in_progress(rsp));
 	WRITE_ONCE(rsp->gp_flags, READ_ONCE(rsp->gp_flags) | RCU_GP_FLAG_FQS);
 	raw_spin_unlock_irqrestore(&rcu_get_root(rsp)->lock, flags);
-	rcu_gp_kthread_wake(rsp);
+	swake_up(&rsp->gp_wq);  /* Memory barrier implied by swake_up() path. */
 }
 
 /*
@@ -2873,7 +2873,7 @@ static void force_quiescent_state(struct rcu_state *rsp)
 	}
 	WRITE_ONCE(rsp->gp_flags, READ_ONCE(rsp->gp_flags) | RCU_GP_FLAG_FQS);
 	raw_spin_unlock_irqrestore(&rnp_old->lock, flags);
-	rcu_gp_kthread_wake(rsp);
+	swake_up(&rsp->gp_wq); /* Memory barrier implied by swake_up() path. */
 }
 
 /*
@@ -3465,7 +3465,7 @@ static int synchronize_sched_expedited_cpu_stop(void *data)
 	/* We are here: If we are last, do the wakeup. */
 	rdp->exp_done = true;
 	if (atomic_dec_and_test(&rsp->expedited_need_qs))
-		wake_up(&rsp->expedited_wq);
+		swake_up(&rsp->expedited_wq);
 	return 0;
 }
 
@@ -3481,7 +3481,7 @@ static void synchronize_sched_expedited_wait(struct rcu_state *rsp)
 	jiffies_start = jiffies;
 
 	for (;;) {
-		ret = wait_event_interruptible_timeout(
+		ret = swait_event_timeout(
 				rsp->expedited_wq,
 				!atomic_read(&rsp->expedited_need_qs),
 				jiffies_stall);
@@ -3489,7 +3489,7 @@ static void synchronize_sched_expedited_wait(struct rcu_state *rsp)
 			return;
 		if (ret < 0) {
 			/* Hit a signal, disable CPU stall warnings. */
-			wait_event(rsp->expedited_wq,
+			swait_event(rsp->expedited_wq,
 				   !atomic_read(&rsp->expedited_need_qs));
 			return;
 		}
@@ -3558,7 +3558,7 @@ void synchronize_sched_expedited(void)
 	rcu_exp_gp_seq_start(rsp);
 
 	/* Stop each CPU that is online, non-idle, and not us. */
-	init_waitqueue_head(&rsp->expedited_wq);
+	init_swait_queue_head(&rsp->expedited_wq);
 	atomic_set(&rsp->expedited_need_qs, 1); /* Extra count avoids race. */
 	for_each_online_cpu(cpu) {
 		struct rcu_data *rdp = per_cpu_ptr(rsp->rda, cpu);
@@ -4180,7 +4180,7 @@ static void __init rcu_init_one(struct rcu_state *rsp,
 		}
 	}
 
-	init_waitqueue_head(&rsp->gp_wq);
+	init_swait_queue_head(&rsp->gp_wq);
 	rnp = rsp->level[rcu_num_lvls - 1];
 	for_each_possible_cpu(i) {
 		while (i > rnp->grphi)
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 00a12b7..02c29d3 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -27,6 +27,7 @@
 #include <linux/threads.h>
 #include <linux/cpumask.h>
 #include <linux/seqlock.h>
+#include <linux/swait.h>
 #include <linux/stop_machine.h>
 
 /*
@@ -244,7 +245,7 @@ struct rcu_node {
 				/* Refused to boost: not sure why, though. */
 				/*  This can happen due to race conditions. */
 #ifdef CONFIG_RCU_NOCB_CPU
-	wait_queue_head_t nocb_gp_wq[2];
+	struct swait_queue_head nocb_gp_wq[2];
 				/* Place for rcu_nocb_kthread() to wait GP. */
 #endif /* #ifdef CONFIG_RCU_NOCB_CPU */
 	int need_future_gp[2];
@@ -388,7 +389,7 @@ struct rcu_data {
 	atomic_long_t nocb_q_count_lazy; /*  invocation (all stages). */
 	struct rcu_head *nocb_follower_head; /* CBs ready to invoke. */
 	struct rcu_head **nocb_follower_tail;
-	wait_queue_head_t nocb_wq;	/* For nocb kthreads to sleep on. */
+	struct swait_queue_head nocb_wq; /* For nocb kthreads to sleep on. */
 	struct task_struct *nocb_kthread;
 	int nocb_defer_wakeup;		/* Defer wakeup of nocb_kthread. */
 
@@ -475,7 +476,7 @@ struct rcu_state {
 	unsigned long gpnum;			/* Current gp number. */
 	unsigned long completed;		/* # of last completed gp. */
 	struct task_struct *gp_kthread;		/* Task for grace periods. */
-	wait_queue_head_t gp_wq;		/* Where GP task waits. */
+	struct swait_queue_head gp_wq;		/* Where GP task waits. */
 	short gp_flags;				/* Commands for GP task. */
 	short gp_state;				/* GP kthread sleep state. */
 
@@ -507,7 +508,7 @@ struct rcu_state {
 	atomic_long_t expedited_workdone3;	/* # done by others #3. */
 	atomic_long_t expedited_normal;		/* # fallbacks to normal. */
 	atomic_t expedited_need_qs;		/* # CPUs left to check in. */
-	wait_queue_head_t expedited_wq;		/* Wait for check-ins. */
+	struct swait_queue_head expedited_wq;	/* Wait for check-ins. */
 
 	unsigned long jiffies_force_qs;		/* Time at which to invoke */
 						/*  force_quiescent_state(). */
@@ -608,8 +609,8 @@ static void zero_cpu_stall_ticks(struct rcu_data *rdp);
 static void increment_cpu_stall_ticks(void);
 static bool rcu_nocb_cpu_needs_barrier(struct rcu_state *rsp, int cpu);
 static void rcu_nocb_gp_set(struct rcu_node *rnp, int nrq);
-static wait_queue_head_t *rcu_nocb_gp_get(struct rcu_node *rnp);
-static void rcu_nocb_gp_cleanup(wait_queue_head_t *sq);
+static struct swait_queue_head *rcu_nocb_gp_get(struct rcu_node *rnp);
+static void rcu_nocb_gp_cleanup(struct swait_queue_head *sq);
 static void rcu_init_one_nocb(struct rcu_node *rnp);
 static bool __call_rcu_nocb(struct rcu_data *rdp, struct rcu_head *rhp,
 			    bool lazy, unsigned long flags);
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 07019b4..0c69868 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1777,9 +1777,9 @@ early_param("rcu_nocb_poll", parse_rcu_nocb_poll);
  * Wake up any no-CBs CPUs' kthreads that were waiting on the just-ended
  * grace period.
  */
-static void rcu_nocb_gp_cleanup(wait_queue_head_t *sq)
+static void rcu_nocb_gp_cleanup(struct swait_queue_head *sq)
 {
-	wake_up_all(sq);
+	swake_up_all(sq);
 }
 
 /*
@@ -1795,15 +1795,15 @@ static void rcu_nocb_gp_set(struct rcu_node *rnp, int nrq)
 	rnp->need_future_gp[(rnp->completed + 1) & 0x1] += nrq;
 }
 
-static wait_queue_head_t *rcu_nocb_gp_get(struct rcu_node *rnp)
+static struct swait_queue_head *rcu_nocb_gp_get(struct rcu_node *rnp)
 {
 	return &rnp->nocb_gp_wq[rnp->completed & 0x1];
 }
 
 static void rcu_init_one_nocb(struct rcu_node *rnp)
 {
-	init_waitqueue_head(&rnp->nocb_gp_wq[0]);
-	init_waitqueue_head(&rnp->nocb_gp_wq[1]);
+	init_swait_queue_head(&rnp->nocb_gp_wq[0]);
+	init_swait_queue_head(&rnp->nocb_gp_wq[1]);
 }
 
 #ifndef CONFIG_RCU_NOCB_CPU_ALL
@@ -1828,7 +1828,7 @@ static void wake_nocb_leader(struct rcu_data *rdp, bool force)
 	if (READ_ONCE(rdp_leader->nocb_leader_sleep) || force) {
 		/* Prior smp_mb__after_atomic() orders against prior enqueue. */
 		WRITE_ONCE(rdp_leader->nocb_leader_sleep, false);
-		wake_up(&rdp_leader->nocb_wq);
+		swake_up(&rdp_leader->nocb_wq);
 	}
 }
 
@@ -2041,7 +2041,7 @@ static void rcu_nocb_wait_gp(struct rcu_data *rdp)
 	 */
 	trace_rcu_future_gp(rnp, rdp, c, TPS("StartWait"));
 	for (;;) {
-		wait_event_interruptible(
+		swait_event_interruptible(
 			rnp->nocb_gp_wq[c & 0x1],
 			(d = ULONG_CMP_GE(READ_ONCE(rnp->completed), c)));
 		if (likely(d))
@@ -2069,7 +2069,7 @@ wait_again:
 	/* Wait for callbacks to appear. */
 	if (!rcu_nocb_poll) {
 		trace_rcu_nocb_wake(my_rdp->rsp->name, my_rdp->cpu, "Sleep");
-		wait_event_interruptible(my_rdp->nocb_wq,
+		swait_event_interruptible(my_rdp->nocb_wq,
 				!READ_ONCE(my_rdp->nocb_leader_sleep));
 		/* Memory barrier handled by smp_mb() calls below and repoll. */
 	} else if (firsttime) {
@@ -2144,7 +2144,7 @@ wait_again:
 			 * List was empty, wake up the follower.
 			 * Memory barriers supplied by atomic_long_add().
 			 */
-			wake_up(&rdp->nocb_wq);
+			swake_up(&rdp->nocb_wq);
 		}
 	}
 
@@ -2165,7 +2165,7 @@ static void nocb_follower_wait(struct rcu_data *rdp)
 		if (!rcu_nocb_poll) {
 			trace_rcu_nocb_wake(rdp->rsp->name, rdp->cpu,
 					    "FollowerSleep");
-			wait_event_interruptible(rdp->nocb_wq,
+			swait_event_interruptible(rdp->nocb_wq,
 						 READ_ONCE(rdp->nocb_follower_head));
 		} else if (firsttime) {
 			/* Don't drown trace log with "Poll"! */
@@ -2324,7 +2324,7 @@ void __init rcu_init_nohz(void)
 static void __init rcu_boot_init_nocb_percpu_data(struct rcu_data *rdp)
 {
 	rdp->nocb_tail = &rdp->nocb_head;
-	init_waitqueue_head(&rdp->nocb_wq);
+	init_swait_queue_head(&rdp->nocb_wq);
 	rdp->nocb_follower_tail = &rdp->nocb_follower_head;
 }
 
@@ -2474,7 +2474,7 @@ static bool rcu_nocb_cpu_needs_barrier(struct rcu_state *rsp, int cpu)
 	return false;
 }
 
-static void rcu_nocb_gp_cleanup(wait_queue_head_t *sq)
+static void rcu_nocb_gp_cleanup(struct swait_queue_head *sq)
 {
 }
 
@@ -2482,7 +2482,7 @@ static void rcu_nocb_gp_set(struct rcu_node *rnp, int nrq)
 {
 }
 
-static wait_queue_head_t *rcu_nocb_gp_get(struct rcu_node *rnp)
+static struct swait_queue_head *rcu_nocb_gp_get(struct rcu_node *rnp)
 {
 	return NULL;
 }
-- 
2.4.3
