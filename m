From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Quick review of -rt RCU-related patches
Date: Tue, 4 Oct 2011 10:47:56 -0700
Message-ID: <20111004174755.GA4762@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org
To: tglx@linutronix.de
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e2.ny.us.ibm.com ([32.97.182.142]:58558 "EHLO e2.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933156Ab1JDR6y (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 4 Oct 2011 13:58:54 -0400
Received: from /spool/local
	by us.ibm.com with XMail ESMTP
	for <linux-rt-users@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Tue, 4 Oct 2011 13:54:11 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id p94HrPpm233168
	for <linux-rt-users@vger.kernel.org>; Tue, 4 Oct 2011 13:53:25 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id p94HrOu5010501
	for <linux-rt-users@vger.kernel.org>; Tue, 4 Oct 2011 13:53:25 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello, Thomas,

A quick review of the RCU-related -rt patches, along with a list of
RCU bug fixes on their way to mainline.  One of these is not yet in
-tip, so the patch is included.

No smoking guns, at least unless the system is being hammered by a
network-based DoS attack.

							Thanx, Paul

------------------------------------------------------------------------

fs-add-missing-rcu-protection.patch

	Just adds a rcu_read_lock()/rcu_read_unlock() pair.
	Should be inoffensive.

rcu-reduce-lock-section.patch

	Prevents a wakeup within an irq-disabled raw spinlock.
	But which wakeup?

	o	rcu_report_exp_rnp() is only permitted to do a wakeup
		if called with rrupts enabled.

	o	All calls enable wakeups -except- for the call from
		sync_rcu_preempt_exp_init(), but in that case, there
		is nothing to wake up -- it is in fact running doing
		the initialization.

	In theory, this should be OK.  If it was broken, the symptom
	would be an expedited grace period blocking forever.

signal-fix-up-rcu-wreckage.patch

	Makes __lock_task_sighand() do local_irq_save_nort() instead
	of local_irq_save().  The RCU implementation should be OK with
	this.  The signal implementation might or might not.

sched-might-sleep-do-not-account-rcu-depth.patch

	Yow!!!  For CONFIG_PREEMPT_RT_FULL, this redefines
	sched_rcu_preempt_depth() to always return zero.

	This means that might_sleep() will never complain about
	blocking in an RCU read-side critical section.  I guess that
	this is necessary, though it would be better to have some
	way to complain for general sleeping (e.g., waiting on
	network receive) as opposed to blocking on a lock that is
	subject to priority inheritance.

rcu-force-preempt-rcu-for-rt.patch

	This one should be obsoleted by commit 8008e129dc9, which is
	queued in -tip, hopefully for 3.2.

	Except for the RT_GROUP_SCHED change, which is unrelated.

rcu-disable-the-rcu-bh-stuff-for-rt.patch

	This implements RCU-bh in terms of RCU-preempt, but disables
	BH around the resulting RCU-preempt read-side critical section.
	May be vulnerable to network-based denial-of-service attacks,
	which could OOM a system with this patch.

	The implementation of rcu_read_lock_bh_held() is weak, but OK.	In
	an ideal world, it would also complain if not local_bh_disable().

_paul_e__mckenney_-eliminate_-_rcu_boosted.patch

	Looks fine, but I might not be the best reviewer for this one.

peter_zijlstra-frob-rcu.patch

	Looks OK.  Hmmm...  Should this one go to mainline?
	Oh, looks equivalent, actually.  So why the change?

Possible fixes from the 3.2-bound RCU commits in -tip:

7eb4f455 (Make rcu_implicit_dynticks_qs() locals be correct size)

	Symptoms: misbehavior on 32-bit systems after a given CPU went
		through about 2^30 dyntick-idle transitions.  You would
		have to work pretty hard to get this one to happen.

5c51dd73 (Prevent early boot set_need_resched() from __rcu_pending())

	Symptoms: boot-time hangs for rare configurations.

037067a1 (Prohibit grace periods during early boot)

	Symptoms: boot-time hangs for rare configurations.

06ae115a (Avoid having just-onlined CPU resched itself when RCU is idle)

	Symptoms: boot-time hangs for rare configurations.

5b61b0ba (Wire up RCU_BOOST_PRIO for rcutree)

	Symptoms: The system uses RT priority 1 for boosting regardless
		of the value of CONFIG_RCU_BOOST_PRIO.

e90c53d3 (Remove rcu_needs_cpu_flush() to avoid false quiescent states)

	Symptoms: Too-short grace periods for RCU_FAST_NO_HZ=y.
		But simpler to set RCU_FAST_NO_HZ=n.

And the following is a patch to a theoretical problem with expedited
grace periods.

------------------------------------------------------------------------

rcu: Avoid RCU-preempt expedited grace-period botch

Because rcu_read_unlock_special() samples rcu_preempted_readers_exp(rnp)
after dropping rnp->lock, the following sequence of events is possible:

1.	Task A exits its RCU read-side critical section, and removes
	itself from the ->blkd_tasks list, releases rnp->lock, and is
	then preempted.  Task B remains on the ->blkd_tasks list, and
	blocks the current expedited grace period.

2.	Task B exits from its RCU read-side critical section and removes
	itself from the ->blkd_tasks list.  Because it is the last task
	blocking the current expedited grace period, it ends that
	expedited grace period.

3.	Task A resumes, and samples rcu_preempted_readers_exp(rnp) which
	of course indicates that nothing is blocking the nonexistent
	expedited grace period. Task A is again preempted.

4.	Some other CPU starts an expedited grace period.  There are several
	tasks blocking this expedited grace period queued on the
	same rcu_node structure that Task A was using in step 1 above.

5.	Task A examines its state and incorrectly concludes that it was
	the last task blocking the expedited grace period on the current
	rcu_node structure.  It therefore reports completion up the
	rcu_node tree.

6.	The expedited grace period can then incorrectly complete before
	the tasks blocked on this same rcu_node structure exit their
	RCU read-side critical sections.  Arbitrarily bad things happen.

This commit therefore takes a snapshot of rcu_preempted_readers_exp(rnp)
prior to dropping the lock, so that only the last task thinks that it is
the last task, thus avoiding the failure scenario laid out above.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

diff --git a/kernel/rcutree_plugin.h b/kernel/rcutree_plugin.h
index 4b9b9f8..7986053 100644
--- a/kernel/rcutree_plugin.h
+++ b/kernel/rcutree_plugin.h
@@ -312,6 +312,7 @@ static noinline void rcu_read_unlock_special(struct task_struct *t)
 {
 	int empty;
 	int empty_exp;
+	int empty_exp_now;
 	unsigned long flags;
 	struct list_head *np;
 #ifdef CONFIG_RCU_BOOST
@@ -382,8 +383,10 @@ static noinline void rcu_read_unlock_special(struct task_struct *t)
 		/*
 		 * If this was the last task on the current list, and if
 		 * we aren't waiting on any CPUs, report the quiescent state.
-		 * Note that rcu_report_unblock_qs_rnp() releases rnp->lock.
+		 * Note that rcu_report_unblock_qs_rnp() releases rnp->lock,
+		 * so we must take a snapshot of the expedited state.
 		 */
+		empty_exp_now = !rcu_preempted_readers_exp(rnp);
 		if (!empty && !rcu_preempt_blocked_readers_cgp(rnp)) {
 			trace_rcu_quiescent_state_report("preempt_rcu",
 							 rnp->gpnum,
@@ -406,7 +409,7 @@ static noinline void rcu_read_unlock_special(struct task_struct *t)
 		 * If this was the last task on the expedited lists,
 		 * then we need to report up the rcu_node hierarchy.
 		 */
-		if (!empty_exp && !rcu_preempted_readers_exp(rnp))
+		if (!empty_exp && empty_exp_now)
 			rcu_report_exp_rnp(&rcu_preempt_state, rnp);
 	} else {
 		local_irq_restore(flags);

