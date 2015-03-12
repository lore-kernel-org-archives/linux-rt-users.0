From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 05/39] rtmutex: Clarify the boost/deboost part
Date: Thu, 12 Mar 2015 15:13:12 -0400
Message-ID: <20150312191407.937766220@goodmis.org>
References: <20150312191307.081068717@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0005-rtmutex-Clarify-the-boost-deboost-part.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.14.34-rt32-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

upstream commit: a57594a13a446d1a6ab1dcd48339f799ce586843

Add a separate local variable for the boost/deboost logic to make the
code more readable. Add comments where appropriate.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Conflicts:
	kernel/locking/rtmutex.c
---
 kernel/locking/rtmutex.c | 57 ++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 48 insertions(+), 9 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 901a29345451..85f5369e27f3 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -366,9 +366,10 @@ static int rt_mutex_adjust_prio_chain(struct task_struct *task,
 				      struct rt_mutex_waiter *orig_waiter,
 				      struct task_struct *top_task)
 {
-	struct rt_mutex *lock;
 	struct rt_mutex_waiter *waiter, *top_waiter = orig_waiter;
+	struct rt_mutex_waiter *prerequeue_top_waiter;
 	int detect_deadlock, ret = 0, depth = 0;
+	struct rt_mutex *lock;
 	unsigned long flags;
 
 	detect_deadlock = debug_rt_mutex_detect_deadlock(orig_waiter,
@@ -475,9 +476,14 @@ static int rt_mutex_adjust_prio_chain(struct task_struct *task,
 		goto out_unlock_pi;
 	}
 
-	top_waiter = rt_mutex_top_waiter(lock);
+	/*
+	 * Store the current top waiter before doing the requeue
+	 * operation on @lock. We need it for the boost/deboost
+	 * decision below.
+	 */
+	prerequeue_top_waiter = rt_mutex_top_waiter(lock);
 
-	/* Requeue the waiter */
+	/* Requeue the waiter in the lock waiter list. */
 	rt_mutex_dequeue(lock, waiter);
 	waiter->prio = task->prio;
 	rt_mutex_enqueue(lock, waiter);
@@ -486,6 +492,11 @@ static int rt_mutex_adjust_prio_chain(struct task_struct *task,
 	raw_spin_unlock_irqrestore(&task->pi_lock, flags);
 	put_task_struct(task);
 
+	/*
+	 * We must abort the chain walk if there is no lock owner even
+	 * in the dead lock detection case, as we have nothing to
+	 * follow here. This is the end of the chain we are walking.
+	 */
 	if (!rt_mutex_owner(lock)) {
 		struct rt_mutex_waiter *lock_top_waiter;
 
@@ -494,29 +505,48 @@ static int rt_mutex_adjust_prio_chain(struct task_struct *task,
 		 * to wake the new top waiter up to try to get the lock.
 		 */
 		lock_top_waiter = rt_mutex_top_waiter(lock);
-		if (top_waiter != lock_top_waiter)
+		if (prerequeue_top_waiter != lock_top_waiter)
 			rt_mutex_wake_waiter(lock_top_waiter);
 		raw_spin_unlock(&lock->wait_lock);
 		return 0;
 	}
 
-	/* Grab the next task */
+	/* Grab the next task, i.e. the owner of @lock */
 	task = rt_mutex_owner(lock);
 	get_task_struct(task);
 	raw_spin_lock_irqsave(&task->pi_lock, flags);
 
 	if (waiter == rt_mutex_top_waiter(lock)) {
-		/* Boost the owner */
-		rt_mutex_dequeue_pi(task, top_waiter);
+		/*
+		 * The waiter became the new top (highest priority)
+		 * waiter on the lock. Replace the previous top waiter
+		 * in the owner tasks pi waiters list with this waiter
+		 * and adjust the priority of the owner.
+		 */
+		rt_mutex_dequeue_pi(task, prerequeue_top_waiter);
 		rt_mutex_enqueue_pi(task, waiter);
 		__rt_mutex_adjust_prio(task);
 
-	} else if (top_waiter == waiter) {
-		/* Deboost the owner */
+	} else if (prerequeue_top_waiter == waiter) {
+		/*
+		 * The waiter was the top waiter on the lock, but is
+		 * no longer the top prority waiter. Replace waiter in
+		 * the owner tasks pi waiters list with the new top
+		 * (highest priority) waiter and adjust the priority
+		 * of the owner.
+		 * The new top waiter is stored in @waiter so that
+		 * @waiter == @top_waiter evaluates to true below and
+		 * we continue to deboost the rest of the chain.
+		 */
 		rt_mutex_dequeue_pi(task, waiter);
 		waiter = rt_mutex_top_waiter(lock);
 		rt_mutex_enqueue_pi(task, waiter);
 		__rt_mutex_adjust_prio(task);
+	} else {
+		/*
+		 * Nothing changed. No need to do any priority
+		 * adjustment.
+		 */
 	}
 
 	/*
@@ -529,6 +559,10 @@ static int rt_mutex_adjust_prio_chain(struct task_struct *task,
 
 	raw_spin_unlock_irqrestore(&task->pi_lock, flags);
 
+	/*
+	 * Store the top waiter of @lock for the end of chain walk
+	 * decision below.
+	 */
 	top_waiter = rt_mutex_top_waiter(lock);
 	raw_spin_unlock(&lock->wait_lock);
 
@@ -539,6 +573,11 @@ static int rt_mutex_adjust_prio_chain(struct task_struct *task,
 	if (!next_lock)
 		goto out_put_task;
 
+	/*
+	 * If the current waiter is not the top waiter on the lock,
+	 * then we can stop the chain walk here if we are not in full
+	 * deadlock detection mode.
+	 */
 	if (!detect_deadlock && waiter != top_waiter)
 		goto out_put_task;
 
-- 
2.1.4
