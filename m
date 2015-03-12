From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 02/36] create-rt-enqueue
Date: Thu, 12 Mar 2015 15:21:41 -0400
Message-ID: <20150312192154.821830165@goodmis.org>
References: <20150312192139.799127123@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.228]:42218 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755759AbbCLTV5 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 12 Mar 2015 15:21:57 -0400
Content-Disposition: inline; filename=0002-create-rt-enqueue.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

3.12.38-rt53-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Steven Rostedt <rostedt@goodmis.org>

To ease backporting patches, replace the plist functions with
rt_mutex_enqueue{_pi}() and rt_mutex_dequeue{_pi}() like upstream -rt does.
This will lower the conflicts in backporting patches.

This also makes sure that every time a waiter is added to the pi_list it
matches the priority of the waiter list.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/rtmutex.c | 58 ++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 40 insertions(+), 18 deletions(-)

diff --git a/kernel/rtmutex.c b/kernel/rtmutex.c
index 5c70d7914f4d..41c42591ef8c 100644
--- a/kernel/rtmutex.c
+++ b/kernel/rtmutex.c
@@ -156,6 +156,31 @@ static inline bool unlock_rt_mutex_safe(struct rt_mutex *lock)
 }
 #endif
 
+static inline void
+rt_mutex_enqueue(struct rt_mutex *lock, struct rt_mutex_waiter *waiter)
+{
+	plist_add(&waiter->list_entry, &lock->wait_list);
+}
+
+static inline void
+rt_mutex_dequeue(struct rt_mutex *lock, struct rt_mutex_waiter *waiter)
+{
+	plist_del(&waiter->list_entry, &lock->wait_list);
+}
+
+static inline void
+rt_mutex_enqueue_pi(struct task_struct *task, struct rt_mutex_waiter *waiter)
+{
+	waiter->pi_list_entry.prio = waiter->list_entry.prio;
+	plist_add(&waiter->pi_list_entry, &task->pi_waiters);
+}
+
+static inline void
+rt_mutex_dequeue_pi(struct task_struct *task, struct rt_mutex_waiter *waiter)
+{
+	plist_del(&waiter->pi_list_entry, &task->pi_waiters);
+}
+
 static inline void init_lists(struct rt_mutex *lock)
 {
 	if (unlikely(!lock->wait_list.node_list.prev))
@@ -379,9 +404,9 @@ static int rt_mutex_adjust_prio_chain(struct task_struct *task,
 	top_waiter = rt_mutex_top_waiter(lock);
 
 	/* Requeue the waiter */
-	plist_del(&waiter->list_entry, &lock->wait_list);
+	rt_mutex_dequeue(lock, waiter);
 	waiter->list_entry.prio = task->prio;
-	plist_add(&waiter->list_entry, &lock->wait_list);
+	rt_mutex_enqueue(lock, waiter);
 
 	/* Release the task */
 	raw_spin_unlock_irqrestore(&task->pi_lock, flags);
@@ -407,17 +432,15 @@ static int rt_mutex_adjust_prio_chain(struct task_struct *task,
 
 	if (waiter == rt_mutex_top_waiter(lock)) {
 		/* Boost the owner */
-		plist_del(&top_waiter->pi_list_entry, &task->pi_waiters);
-		waiter->pi_list_entry.prio = waiter->list_entry.prio;
-		plist_add(&waiter->pi_list_entry, &task->pi_waiters);
+		rt_mutex_dequeue_pi(task, top_waiter);
+		rt_mutex_enqueue_pi(task, waiter);
 		__rt_mutex_adjust_prio(task);
 
 	} else if (top_waiter == waiter) {
 		/* Deboost the owner */
-		plist_del(&waiter->pi_list_entry, &task->pi_waiters);
+		rt_mutex_dequeue_pi(task, waiter);
 		waiter = rt_mutex_top_waiter(lock);
-		waiter->pi_list_entry.prio = waiter->list_entry.prio;
-		plist_add(&waiter->pi_list_entry, &task->pi_waiters);
+		rt_mutex_enqueue_pi(task, waiter);
 		__rt_mutex_adjust_prio(task);
 	}
 
@@ -533,7 +556,7 @@ __try_to_take_rt_mutex(struct rt_mutex *lock, struct task_struct *task,
 
 		/* remove the queued waiter. */
 		if (waiter) {
-			plist_del(&waiter->list_entry, &lock->wait_list);
+			rt_mutex_dequeue(lock, waiter);
 			task->pi_blocked_on = NULL;
 		}
 
@@ -543,8 +566,7 @@ __try_to_take_rt_mutex(struct rt_mutex *lock, struct task_struct *task,
 		 */
 		if (rt_mutex_has_waiters(lock)) {
 			top = rt_mutex_top_waiter(lock);
-			top->pi_list_entry.prio = top->list_entry.prio;
-			plist_add(&top->pi_list_entry, &task->pi_waiters);
+			rt_mutex_enqueue_pi(task, top);
 		}
 		raw_spin_unlock_irqrestore(&task->pi_lock, flags);
 	}
@@ -622,7 +644,7 @@ static int task_blocks_on_rt_mutex(struct rt_mutex *lock,
 	/* Get the top priority waiter on the lock */
 	if (rt_mutex_has_waiters(lock))
 		top_waiter = rt_mutex_top_waiter(lock);
-	plist_add(&waiter->list_entry, &lock->wait_list);
+	rt_mutex_enqueue(lock, waiter);
 
 	task->pi_blocked_on = waiter;
 
@@ -633,8 +655,8 @@ static int task_blocks_on_rt_mutex(struct rt_mutex *lock,
 
 	raw_spin_lock_irqsave(&owner->pi_lock, flags);
 	if (waiter == rt_mutex_top_waiter(lock)) {
-		plist_del(&top_waiter->pi_list_entry, &owner->pi_waiters);
-		plist_add(&waiter->pi_list_entry, &owner->pi_waiters);
+		rt_mutex_dequeue_pi(owner, top_waiter);
+		rt_mutex_enqueue_pi(owner, waiter);
 
 		__rt_mutex_adjust_prio(owner);
 		if (rt_mutex_real_waiter(owner->pi_blocked_on))
@@ -695,7 +717,7 @@ static void wakeup_next_waiter(struct rt_mutex *lock)
 	 * boosted mode and go back to normal after releasing
 	 * lock->wait_lock.
 	 */
-	plist_del(&waiter->pi_list_entry, &current->pi_waiters);
+	rt_mutex_dequeue_pi(current, waiter);
 
 	/*
 	 * As we are waking up the top waiter, and the waiter stays
@@ -732,7 +754,7 @@ static void remove_waiter(struct rt_mutex *lock,
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&current->pi_lock, flags);
-	plist_del(&waiter->list_entry, &lock->wait_list);
+	rt_mutex_dequeue(lock, waiter);
 	current->pi_blocked_on = NULL;
 	raw_spin_unlock_irqrestore(&current->pi_lock, flags);
 
@@ -743,13 +765,13 @@ static void remove_waiter(struct rt_mutex *lock,
 
 		raw_spin_lock_irqsave(&owner->pi_lock, flags);
 
-		plist_del(&waiter->pi_list_entry, &owner->pi_waiters);
+		rt_mutex_dequeue_pi(owner, waiter);
 
 		if (rt_mutex_has_waiters(lock)) {
 			struct rt_mutex_waiter *next;
 
 			next = rt_mutex_top_waiter(lock);
-			plist_add(&next->pi_list_entry, &owner->pi_waiters);
+			rt_mutex_enqueue_pi(owner, next);
 		}
 		__rt_mutex_adjust_prio(owner);
 
-- 
2.1.4


