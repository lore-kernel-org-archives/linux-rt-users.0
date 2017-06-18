From: Mike Galbraith <efault@gmx.de>
Subject: [patch-rt] rtmutex: Fix lock stealing logic
Date: Sun, 18 Jun 2017 19:01:57 +0200
Message-ID: <1497805317.6229.3.camel@gmx.de>
References: <20170616105610.rbc6itylcrsla56l@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:65209 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751980AbdFRRCJ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 18 Jun 2017 13:02:09 -0400
In-Reply-To: <20170616105610.rbc6itylcrsla56l@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


1. When trying to acquire an rtmutex, we first try to grab it without
queueing the waiter, and explicitly check for that initial attempt
in the !waiter path of __try_to_take_rt_mutex().  Checking whether
the lock taker is top waiter before allowing a steal attempt in that
path is a thinko: the lock taker has not yet blocked.

2. It seems wrong to change the definition of rt_mutex_waiter_less()
to mean less or perhaps equal when we have an rt_mutex_waiter_equal().

Remove the thinko, and implement rt_mutex_stealable(steal_mode) using
a restored rt_mutex_waiter_less(), and rt_mutex_waiter_equal().

Signed-off-by: Mike Galbraith <efault@gmx.de>
Fixes: f34d077c6f28 ("rt: Add the preempt-rt lock replacement APIs")
---
 kernel/locking/rtmutex.c |   69 +++++++++++++++++++++++------------------------
 1 file changed, 35 insertions(+), 34 deletions(-)

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
@@ -287,6 +280,25 @@ rt_mutex_waiter_equal(struct rt_mutex_wa
 	return 1;
 }
 
+#define STEAL_NORMAL  0
+#define STEAL_LATERAL 1
+
+static inline int rt_mutex_stealable(struct rt_mutex_waiter *thief,
+				     struct rt_mutex_waiter *victim, int mode)
+{
+	if (rt_mutex_waiter_less(thief, victim))
+		return 1;
+
+	/*
+	 * Note that RT tasks are excluded from lateral-steals
+	 * to prevent the introduction of an unbounded latency.
+	 */
+	if (mode == STEAL_NORMAL || rt_task(thief->task))
+		return 0;
+
+	return rt_mutex_waiter_equal(thief, victim);
+}
+
 static void
 rt_mutex_enqueue(struct rt_mutex *lock, struct rt_mutex_waiter *waiter)
 {
@@ -298,7 +310,7 @@ rt_mutex_enqueue(struct rt_mutex *lock,
 	while (*link) {
 		parent = *link;
 		entry = rb_entry(parent, struct rt_mutex_waiter, tree_entry);
-		if (rt_mutex_waiter_less(waiter, entry, STEAL_NORMAL)) {
+		if (rt_mutex_waiter_less(waiter, entry)) {
 			link = &parent->rb_left;
 		} else {
 			link = &parent->rb_right;
@@ -337,7 +349,7 @@ rt_mutex_enqueue_pi(struct task_struct *
 	while (*link) {
 		parent = *link;
 		entry = rb_entry(parent, struct rt_mutex_waiter, pi_tree_entry);
-		if (rt_mutex_waiter_less(waiter, entry, STEAL_NORMAL)) {
+		if (rt_mutex_waiter_less(waiter, entry)) {
 			link = &parent->rb_left;
 		} else {
 			link = &parent->rb_right;
@@ -847,6 +859,7 @@ static int rt_mutex_adjust_prio_chain(st
  * @task:   The task which wants to acquire the lock
  * @waiter: The waiter that is queued to the lock's wait tree if the
  *	    callsite called task_blocked_on_lock(), otherwise NULL
+ * @mode:   Lock steal mode (STEAL_NORMAL, STEAL_LATERAL)
  */
 static int __try_to_take_rt_mutex(struct rt_mutex *lock,
 				  struct task_struct *task,
@@ -890,10 +903,9 @@ static int __try_to_take_rt_mutex(struct
 		 * @lock, give up.
 		 */
 		if (waiter != rt_mutex_top_waiter(lock)) {
-			/* XXX rt_mutex_waiter_less() ? */
+			/* XXX rt_mutex_stealable() ? */
 			return 0;
 		}
-
 		/*
 		 * We can acquire the lock. Remove the waiter from the
 		 * lock waiters tree.
@@ -910,25 +922,14 @@ static int __try_to_take_rt_mutex(struct
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
+			 * priority (kernel view), or equal to it when
+			 * lateral steal is forbidden, @task lost.
 			 */
-			if (!rt_mutex_waiter_less(task_to_waiter(task),
-						  rt_mutex_top_waiter(lock),
-						  mode))
+			if (!rt_mutex_stealable(task_to_waiter(task),
+						rt_mutex_top_waiter(lock),
+						mode))
 				return 0;
 			/*
 			 * The current top waiter stays enqueued. We
