From: Daniel Wagner <wagi@monom.org>
Subject: [RFC v1] sched/completion: convert completions to use simple wait queues
Date: Wed, 30 Mar 2016 16:53:05 +0200
Message-ID: <1459349585-6527-2-git-send-email-wagi@monom.org>
References: <1459349585-6527-1-git-send-email-wagi@monom.org>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Daniel Wagner <daniel.wagner@bmw-carit.de>
To: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459349585-6527-1-git-send-email-wagi@monom.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

Completions have no long lasting callbacks and therefore do not need
the complex waitqueue variant.  Use simple waitqueues which reduces
the contention on the waitqueue lock.

This was a carry forward from v3.10-rt, with some RT specific chunks,
dropped, and updated to align with names that were chosen to match the
simple waitqueue support.

[wagi: Added flag to defer swake_up_all() from irq context]

Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
---
 include/linux/completion.h | 23 ++++++++++++++++-------
 include/linux/swait.h      |  1 +
 kernel/sched/completion.c  | 43 ++++++++++++++++++++++++++-----------------
 kernel/sched/swait.c       | 24 ++++++++++++++++++++++++
 4 files changed, 67 insertions(+), 24 deletions(-)

diff --git a/include/linux/completion.h b/include/linux/completion.h
index 5d5aaae..45fd91a 100644
--- a/include/linux/completion.h
+++ b/include/linux/completion.h
@@ -8,7 +8,7 @@
  * See kernel/sched/completion.c for details.
  */
 
-#include <linux/wait.h>
+#include <linux/swait.h>
 
 /*
  * struct completion - structure used to maintain state for a "completion"
@@ -22,13 +22,22 @@
  * reinit_completion(), and macros DECLARE_COMPLETION(),
  * DECLARE_COMPLETION_ONSTACK().
  */
+
+#define COMPLETION_DEFER (1 << 0)
+
 struct completion {
-	unsigned int done;
-	wait_queue_head_t wait;
+	union {
+		struct {
+			unsigned short flags;
+			unsigned short done;
+		};
+		unsigned int val;
+	};
+	struct swait_queue_head wait;
 };
 
 #define COMPLETION_INITIALIZER(work) \
-	{ 0, __WAIT_QUEUE_HEAD_INITIALIZER((work).wait) }
+	{ 0, 0, __SWAIT_QUEUE_HEAD_INITIALIZER((work).wait) }
 
 #define COMPLETION_INITIALIZER_ONSTACK(work) \
 	({ init_completion(&work); work; })
@@ -72,8 +81,8 @@ struct completion {
  */
 static inline void init_completion(struct completion *x)
 {
-	x->done = 0;
-	init_waitqueue_head(&x->wait);
+	x->val = 0;
+	init_swait_queue_head(&x->wait);
 }
 
 /**
@@ -85,7 +94,7 @@ static inline void init_completion(struct completion *x)
  */
 static inline void reinit_completion(struct completion *x)
 {
-	x->done = 0;
+	x->val = 0;
 }
 
 extern void wait_for_completion(struct completion *);
diff --git a/include/linux/swait.h b/include/linux/swait.h
index c1f9c62..83f004a 100644
--- a/include/linux/swait.h
+++ b/include/linux/swait.h
@@ -87,6 +87,7 @@ static inline int swait_active(struct swait_queue_head *q)
 extern void swake_up(struct swait_queue_head *q);
 extern void swake_up_all(struct swait_queue_head *q);
 extern void swake_up_locked(struct swait_queue_head *q);
+extern void swake_up_all_locked(struct swait_queue_head *q);
 
 extern void __prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait);
 extern void prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait, int state);
diff --git a/kernel/sched/completion.c b/kernel/sched/completion.c
index 8d0f35d..d4dccd3 100644
--- a/kernel/sched/completion.c
+++ b/kernel/sched/completion.c
@@ -30,10 +30,10 @@ void complete(struct completion *x)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&x->wait.lock, flags);
+	raw_spin_lock_irqsave(&x->wait.lock, flags);
 	x->done++;
-	__wake_up_locked(&x->wait, TASK_NORMAL, 1);
-	spin_unlock_irqrestore(&x->wait.lock, flags);
+	swake_up_locked(&x->wait);
+	raw_spin_unlock_irqrestore(&x->wait.lock, flags);
 }
 EXPORT_SYMBOL(complete);
 
@@ -50,10 +50,15 @@ void complete_all(struct completion *x)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&x->wait.lock, flags);
-	x->done += UINT_MAX/2;
-	__wake_up_locked(&x->wait, TASK_NORMAL, 0);
-	spin_unlock_irqrestore(&x->wait.lock, flags);
+	raw_spin_lock_irqsave(&x->wait.lock, flags);
+	x->done += USHRT_MAX/2;
+	if (irqs_disabled_flags(flags)) {
+		x->flags = COMPLETION_DEFER;
+		swake_up_locked(&x->wait);
+	} else {
+		swake_up_all_locked(&x->wait);
+	}
+	raw_spin_unlock_irqrestore(&x->wait.lock, flags);
 }
 EXPORT_SYMBOL(complete_all);
 
@@ -62,20 +67,20 @@ do_wait_for_common(struct completion *x,
 		   long (*action)(long), long timeout, int state)
 {
 	if (!x->done) {
-		DECLARE_WAITQUEUE(wait, current);
+		DECLARE_SWAITQUEUE(wait);
 
-		__add_wait_queue_tail_exclusive(&x->wait, &wait);
+		__prepare_to_swait(&x->wait, &wait);
 		do {
 			if (signal_pending_state(state, current)) {
 				timeout = -ERESTARTSYS;
 				break;
 			}
 			__set_current_state(state);
-			spin_unlock_irq(&x->wait.lock);
+			raw_spin_unlock_irq(&x->wait.lock);
 			timeout = action(timeout);
-			spin_lock_irq(&x->wait.lock);
+			raw_spin_lock_irq(&x->wait.lock);
 		} while (!x->done && timeout);
-		__remove_wait_queue(&x->wait, &wait);
+		__finish_swait(&x->wait, &wait);
 		if (!x->done)
 			return timeout;
 	}
@@ -89,9 +94,13 @@ __wait_for_common(struct completion *x,
 {
 	might_sleep();
 
-	spin_lock_irq(&x->wait.lock);
+	raw_spin_lock_irq(&x->wait.lock);
 	timeout = do_wait_for_common(x, action, timeout, state);
-	spin_unlock_irq(&x->wait.lock);
+	raw_spin_unlock_irq(&x->wait.lock);
+	if (x->flags & COMPLETION_DEFER) {
+		x->flags = 0;
+		swake_up_all(&x->wait);
+	}
 	return timeout;
 }
 
@@ -277,12 +286,12 @@ bool try_wait_for_completion(struct completion *x)
 	if (!READ_ONCE(x->done))
 		return 0;
 
-	spin_lock_irqsave(&x->wait.lock, flags);
+	raw_spin_lock_irqsave(&x->wait.lock, flags);
 	if (!x->done)
 		ret = 0;
 	else
 		x->done--;
-	spin_unlock_irqrestore(&x->wait.lock, flags);
+	raw_spin_unlock_irqrestore(&x->wait.lock, flags);
 	return ret;
 }
 EXPORT_SYMBOL(try_wait_for_completion);
@@ -311,7 +320,7 @@ bool completion_done(struct completion *x)
 	 * after it's acquired the lock.
 	 */
 	smp_rmb();
-	spin_unlock_wait(&x->wait.lock);
+	raw_spin_unlock_wait(&x->wait.lock);
 	return true;
 }
 EXPORT_SYMBOL(completion_done);
diff --git a/kernel/sched/swait.c b/kernel/sched/swait.c
index 82f0dff..efe366b 100644
--- a/kernel/sched/swait.c
+++ b/kernel/sched/swait.c
@@ -72,6 +72,30 @@ void swake_up_all(struct swait_queue_head *q)
 }
 EXPORT_SYMBOL(swake_up_all);
 
+void swake_up_all_locked(struct swait_queue_head *q)
+{
+	struct swait_queue *curr;
+	LIST_HEAD(tmp);
+
+	if (!swait_active(q))
+		return;
+
+	list_splice_init(&q->task_list, &tmp);
+	while (!list_empty(&tmp)) {
+		curr = list_first_entry(&tmp, typeof(*curr), task_list);
+
+		wake_up_state(curr->task, TASK_NORMAL);
+		list_del_init(&curr->task_list);
+
+		if (list_empty(&tmp))
+			break;
+
+		raw_spin_unlock_irq(&q->lock);
+		raw_spin_lock_irq(&q->lock);
+	}
+}
+EXPORT_SYMBOL(swake_up_all_locked);
+
 void __prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait)
 {
 	wait->task = current;
-- 
2.5.5
