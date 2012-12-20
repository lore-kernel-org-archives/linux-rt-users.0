From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH RT] rtmutex: Use raw_spin_trylock() in
 rt_mutex_slowlock() to ease possible live locks
Date: Wed, 19 Dec 2012 22:44:02 -0500
Message-ID: <1355975042.5896.54.camel@gandalf.local.home>
References: <1355967118.5896.52.camel@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <cbe@osadl.org>,
	Clark Williams <clark@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Mike Galbraith <bitbucket@online.de>
To: LKML <linux-kernel@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:8231 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751397Ab2LTDoF (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 19 Dec 2012 22:44:05 -0500
In-Reply-To: <1355967118.5896.52.camel@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 2012-12-19 at 20:31 -0500, Steven Rostedt wrote:

> 
> This is just an RFC patch to start discussion, not for inclusion. I may
> send another patch that implements #2 above.


Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-rt.git/kernel/rtmutex.c
===================================================================
--- linux-rt.git.orig/kernel/rtmutex.c
+++ linux-rt.git/kernel/rtmutex.c
@@ -167,6 +167,39 @@ static void rt_mutex_wake_waiter(struct 
  */
 int max_lock_depth = 1024;
 
+static bool test_lock_waiter(struct task_struct *task,
+			     struct rt_mutex_waiter *waiter,
+			     struct rt_mutex_waiter *top_waiter,
+			     struct rt_mutex *orig_lock,
+			     struct rt_mutex_waiter *orig_waiter,
+			     int detect_deadlock)
+{
+	/*
+	 * Check the orig_waiter state. After we dropped the locks,
+	 * the previous owner of the lock might have released the lock.
+	 */
+	if (orig_waiter && !rt_mutex_owner(orig_lock))
+		return false;
+
+	/*
+	 * Drop out, when the task has no waiters. Note,
+	 * top_waiter can be NULL, when we are in the deboosting
+	 * mode!
+	 */
+	if (top_waiter && (!task_has_pi_waiters(task) ||
+			   top_waiter != task_top_pi_waiter(task)))
+		return false;
+
+	/*
+	 * When deadlock detection is off then we check, if further
+	 * priority adjustment is necessary.
+	 */
+	if (!detect_deadlock && waiter->list_entry.prio == task->prio)
+		return false;
+
+	return true;
+}
+
 /*
  * Adjust the priority chain. Also used for deadlock detection.
  * Decreases task's usage by one - may thus free the task.
@@ -225,34 +258,32 @@ static int rt_mutex_adjust_prio_chain(st
 	if (!rt_mutex_real_waiter(waiter))
 		goto out_unlock_pi;
 
-	/*
-	 * Check the orig_waiter state. After we dropped the locks,
-	 * the previous owner of the lock might have released the lock.
-	 */
-	if (orig_waiter && !rt_mutex_owner(orig_lock))
-		goto out_unlock_pi;
-
-	/*
-	 * Drop out, when the task has no waiters. Note,
-	 * top_waiter can be NULL, when we are in the deboosting
-	 * mode!
-	 */
-	if (top_waiter && (!task_has_pi_waiters(task) ||
-			   top_waiter != task_top_pi_waiter(task)))
-		goto out_unlock_pi;
-
-	/*
-	 * When deadlock detection is off then we check, if further
-	 * priority adjustment is necessary.
-	 */
-	if (!detect_deadlock && waiter->list_entry.prio == task->prio)
+	if (!test_lock_waiter(task, waiter, top_waiter,
+			      orig_lock, orig_waiter, deadlock_detect))
 		goto out_unlock_pi;
 
 	lock = waiter->lock;
 	if (!raw_spin_trylock(&lock->wait_lock)) {
 		raw_spin_unlock_irqrestore(&task->pi_lock, flags);
-		cpu_relax();
-		goto retry;
+		/*
+		 * As raw_spin_locks are FIFO, we need to avoid being
+		 * starved out by other tasks that may be grabbing
+		 * the wait_lock. Grab both locks in the proper
+		 * order and test if anything changed. If it did
+		 * we need to drop them and try again.
+		 */
+		raw_spin_lock(&lock->wait_lock);
+		raw_spin_lock_irqsave(&task->pi_lock, flags);
+		if (waiter != task->pi_blocked_on ||
+		    lock != waiter->lock ||
+		    !test_lock_waiter(task, waiter, top_waiter,
+				      orig_lock, orig_waiter,
+				      detect_deadlock)) {
+			raw_spin_unlock_irqrestore(&task->pi_lock, flags);
+			raw_spin_unlock(&lock->wait_lock);
+			cpu_relax();
+			goto retry;
+		}
 	}
 
 	/* Deadlock detection */


