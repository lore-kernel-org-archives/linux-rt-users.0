From: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [RFC v0 2/3] sched/completion: convert completions to use simple wait queues
Date: Wed,  5 Aug 2015 15:30:47 +0200
Message-ID: <1438781448-10760-3-git-send-email-daniel.wagner@bmw-carit.de>
References: <1438781448-10760-1-git-send-email-daniel.wagner@bmw-carit.de>
Cc: paul.gortmaker@windriver.com, peterz@infradead.org,
	bigeasy@linutronix.de, tglx@linutronix.de,
	paulmck@linux.vnet.ibm.com, rostedt@goodmis.org
To: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438781448-10760-1-git-send-email-daniel.wagner@bmw-carit.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Paul Gortmaker <paul.gortmaker@windriver.com>

Completions have no long lasting callbacks and therefore do not need
the complex waitqueue variant.  Use simple waitqueues which reduces
the contention on the waitqueue lock.

This was a carry forward from v3.10-rt, with some RT specific chunks,
dropped, and updated to align with names that were chosen to match the
simple waitqueue support.

Originally-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 include/linux/completion.h |  8 ++++----
 kernel/sched/completion.c  | 32 ++++++++++++++++----------------
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/include/linux/completion.h b/include/linux/completion.h
index 5d5aaae..8b3bca8 100644
--- a/include/linux/completion.h
+++ b/include/linux/completion.h
@@ -8,7 +8,7 @@
  * See kernel/sched/completion.c for details.
  */
 
-#include <linux/wait.h>
+#include <linux/swait.h>
 
 /*
  * struct completion - structure used to maintain state for a "completion"
@@ -24,11 +24,11 @@
  */
 struct completion {
 	unsigned int done;
-	wait_queue_head_t wait;
+	struct swait_queue_head wait;
 };
 
 #define COMPLETION_INITIALIZER(work) \
-	{ 0, __WAIT_QUEUE_HEAD_INITIALIZER((work).wait) }
+	{ 0, __SWAIT_QUEUE_HEAD_INITIALIZER((work).wait) }
 
 #define COMPLETION_INITIALIZER_ONSTACK(work) \
 	({ init_completion(&work); work; })
@@ -73,7 +73,7 @@ struct completion {
 static inline void init_completion(struct completion *x)
 {
 	x->done = 0;
-	init_waitqueue_head(&x->wait);
+	init_swait_queue_head(&x->wait);
 }
 
 /**
diff --git a/kernel/sched/completion.c b/kernel/sched/completion.c
index 8d0f35d..b020159 100644
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
 
@@ -50,10 +50,10 @@ void complete_all(struct completion *x)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&x->wait.lock, flags);
+	raw_spin_lock_irqsave(&x->wait.lock, flags);
 	x->done += UINT_MAX/2;
-	__wake_up_locked(&x->wait, TASK_NORMAL, 0);
-	spin_unlock_irqrestore(&x->wait.lock, flags);
+	swake_up_locked(&x->wait);
+	raw_spin_unlock_irqrestore(&x->wait.lock, flags);
 }
 EXPORT_SYMBOL(complete_all);
 
@@ -62,20 +62,20 @@ do_wait_for_common(struct completion *x,
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
@@ -89,9 +89,9 @@ __wait_for_common(struct completion *x,
 {
 	might_sleep();
 
-	spin_lock_irq(&x->wait.lock);
+	raw_spin_lock_irq(&x->wait.lock);
 	timeout = do_wait_for_common(x, action, timeout, state);
-	spin_unlock_irq(&x->wait.lock);
+	raw_spin_unlock_irq(&x->wait.lock);
 	return timeout;
 }
 
@@ -277,12 +277,12 @@ bool try_wait_for_completion(struct completion *x)
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
@@ -311,7 +311,7 @@ bool completion_done(struct completion *x)
 	 * after it's acquired the lock.
 	 */
 	smp_rmb();
-	spin_unlock_wait(&x->wait.lock);
+	raw_spin_unlock_wait(&x->wait.lock);
 	return true;
 }
 EXPORT_SYMBOL(completion_done);
-- 
2.4.3
