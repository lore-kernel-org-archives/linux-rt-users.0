From: Mike Galbraith <efault@gmx.de>
Subject: [patch-rt v2] rtmutex: Fix lock stealing logic
Date: Fri, 23 Jun 2017 09:37:14 +0200
Message-ID: <1498203434.3988.5.camel@gmx.de>
References: <20170616105610.rbc6itylcrsla56l@linutronix.de>
         <1497805317.6229.3.camel@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:61118 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753439AbdFWHh0 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 23 Jun 2017 03:37:26 -0400
In-Reply-To: <1497805317.6229.3.camel@gmx.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

V2 changes:
  - beautification (ymmv)
  - enable lock stealing when waiter is queued

rtmutex: Fix lock stealing logic

1. When trying to acquire an rtmutex, we first try to grab it without
queueing the waiter, and explicitly check for that initial attempt
in the !waiter path of __try_to_take_rt_mutex().  Checking whether
the lock taker is top waiter before allowing a steal attempt in that
path is a thinko: the lock taker has not yet blocked.

2. It seems wrong to change the definition of rt_mutex_waiter_less()
to mean less or perhaps equal when we have an rt_mutex_waiter_equal().

Remove the thinko, restore rt_mutex_waiter_less(), implement and use
rt_mutex_steal() based upon rt_mutex_waiter_less/equal(), moving all
qualification criteria into the function itself.

Signed-off-by: Mike Galbraith <efault@gmx.de>
---
 kernel/locking/rtmutex.c |   76 ++++++++++++++++++++++-------------------------
 1 file changed, 37 insertions(+), 39 deletions(-)

--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -236,26 +236,19 @@ static inline bool unlock_rt_mutex_safe(
 }
 #endif
 
-#define STEAL_NORMAL  0
-#define STEAL_LATERAL 1
-
 /*
  * Only use with rt_mutex_waiter_{less,equal}()
  */
-#define task_to_waiter(p)	\
-	&(struct rt_mutex_waiter){ .prio = (p)->prio, .deadline = (p)->dl.deadline }
+#define task_to_waiter(p) &(struct rt_mutex_waiter) \
+	{ .prio = (p)->prio, .deadline = (p)->dl.deadline, .task = (p) }
 
 static inline int
 rt_mutex_waiter_less(struct rt_mutex_waiter *left,
-		     struct rt_mutex_waiter *right, int mode)
+		     struct rt_mutex_waiter *right)
 {
-	if (mode == STEAL_NORMAL) {
-		if (left->prio < right->prio)
-			return 1;
-	} else {
-		if (left->prio <= right->prio)
-			return 1;
-	}
+	if (left->prio < right->prio)
+		return 1;
+
 	/*
 	 * If both waiters have dl_prio(), we check the deadlines of the
 	 * associated tasks.
@@ -287,6 +280,27 @@ rt_mutex_waiter_equal(struct rt_mutex_wa
 	return 1;
 }
 
+#define STEAL_NORMAL  0
+#define STEAL_LATERAL 1
+
+static inline int
+rt_mutex_steal(struct rt_mutex *lock, struct rt_mutex_waiter *waiter, int mode)
+{
+	struct rt_mutex_waiter *top_waiter = rt_mutex_top_waiter(lock);
+
+	if (waiter == top_waiter || rt_mutex_waiter_less(waiter, top_waiter))
+		return 1;
+
+	/*
+	 * Note that RT tasks are excluded from lateral-steals
+	 * to prevent the introduction of an unbounded latency.
+	 */
+	if (mode == STEAL_NORMAL || rt_task(waiter->task))
+		return 0;
+
+	return rt_mutex_waiter_equal(waiter, top_waiter);
+}
+
 static void
 rt_mutex_enqueue(struct rt_mutex *lock, struct rt_mutex_waiter *waiter)
 {
@@ -298,7 +312,7 @@ rt_mutex_enqueue(struct rt_mutex *lock,
 	while (*link) {
 		parent = *link;
 		entry = rb_entry(parent, struct rt_mutex_waiter, tree_entry);
-		if (rt_mutex_waiter_less(waiter, entry, STEAL_NORMAL)) {
+		if (rt_mutex_waiter_less(waiter, entry)) {
 			link = &parent->rb_left;
 		} else {
 			link = &parent->rb_right;
@@ -337,7 +351,7 @@ rt_mutex_enqueue_pi(struct task_struct *
 	while (*link) {
 		parent = *link;
 		entry = rb_entry(parent, struct rt_mutex_waiter, pi_tree_entry);
-		if (rt_mutex_waiter_less(waiter, entry, STEAL_NORMAL)) {
+		if (rt_mutex_waiter_less(waiter, entry)) {
 			link = &parent->rb_left;
 		} else {
 			link = &parent->rb_right;
@@ -847,6 +861,7 @@ static int rt_mutex_adjust_prio_chain(st
  * @task:   The task which wants to acquire the lock
  * @waiter: The waiter that is queued to the lock's wait tree if the
  *	    callsite called task_blocked_on_lock(), otherwise NULL
+ * @mode:   Lock steal mode (STEAL_NORMAL, STEAL_LATERAL)
  */
 static int __try_to_take_rt_mutex(struct rt_mutex *lock,
 				  struct task_struct *task,
@@ -886,20 +901,16 @@ static int __try_to_take_rt_mutex(struct
 	 */
 	if (waiter) {
 		/*
-		 * If waiter is not the highest priority waiter of
-		 * @lock, give up.
+		 * If waiter is not the highest priority waiter of @lock,
+		 * or its peer when lateral steal is allowed, give up.
 		 */
-		if (waiter != rt_mutex_top_waiter(lock)) {
-			/* XXX rt_mutex_waiter_less() ? */
+		if (!rt_mutex_steal(lock, waiter, mode))
 			return 0;
-		}
-
 		/*
 		 * We can acquire the lock. Remove the waiter from the
 		 * lock waiters tree.
 		 */
 		rt_mutex_dequeue(lock, waiter);
-
 	} else {
 		/*
 		 * If the lock has waiters already we check whether @task is
@@ -910,25 +921,12 @@ static int __try_to_take_rt_mutex(struct
 		 * not need to be dequeued.
 		 */
 		if (rt_mutex_has_waiters(lock)) {
-			struct task_struct *pown = rt_mutex_top_waiter(lock)->task;
-
-			if (task != pown)
-				return 0;
-
-			/*
-			 * Note that RT tasks are excluded from lateral-steals
-			 * to prevent the introduction of an unbounded latency.
-			 */
-			if (rt_task(task))
-				mode = STEAL_NORMAL;
 			/*
-			 * If @task->prio is greater than or equal to
-			 * the top waiter priority (kernel view),
-			 * @task lost.
+			 * If @task->prio is greater than the top waiter
+			 * priority (kernel view), or equal to it when a
+			 * lateral steal is forbidden, @task lost.
 			 */
-			if (!rt_mutex_waiter_less(task_to_waiter(task),
-						  rt_mutex_top_waiter(lock),
-						  mode))
+			if (!rt_mutex_steal(lock, task_to_waiter(task), mode))
 				return 0;
 			/*
 			 * The current top waiter stays enqueued. We
