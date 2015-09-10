From: Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC][PATCH RT v2 3/3] [PATCH 3/3] rtmutex: Wake up all top trylock waiters on unlock
Date: Thu, 10 Sep 2015 10:50:58 -0400
Message-ID: <20150910150115.665506119@goodmis.org>
References: <20150910145055.948545589@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Clark Williams <clark.williams@gmail.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0003-rtmutex-Wake-up-all-top-trylock-waiters-on-unlock.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

A task that boosts an owner of a lock via spin_trylock_or_boost() is not a
real waiter of the lock in non PREEMPT_RT code. In non PREEMPT_RT, that task
is just spinning. But in PREEMPT_RT the call to cpu_chill() will touch the
lock. But there's nothing keeping the lock there.

As the lock is boosted via a trylock, it means something had to be done
before we got that lock with another lock held out of reverse order. That
means, if there's nothing using that lock, there's a possible code path that
can make that lock disappear. Here's a fictitious example:

    CPU0	     CPU1		CPU2
    ----	     ----		----
   [task0]	     [task1]		[task2]

  lock(dev->A)
		     lock(B)
		     trylock(dev->A)
		     unlock(B)
		     goto again
					lock(B)
					trylock(dev->A)
					unlock(B)
					goto again
  unlock(dev->A)
    wake(task1)
    remove_task1_links
  lock(B)
  free(dev)
  unlock(B)

At this moment, although task1 is running and ready to go, task2 is still on
dev->A->wait_list, and that will cause a panic when task2 does a cpu_chill().

Things are fine as long as there's a waiter that is from a rtmutex_lock().
Wake all the top tasks till a task is found that is blocked on the rtmutex
itself.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/locking/rtmutex.c | 65 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 59 insertions(+), 6 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 843b67f38e20..f26eebe5de87 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -254,17 +254,25 @@ rt_mutex_dequeue_pi(struct task_struct *task, struct rt_mutex_waiter *waiter)
 }
 
 #ifdef CONFIG_PREEMPT_RT_FULL
+static void rt_mutex_wake_waiter(struct rt_mutex_waiter *waiter);
 /*
- * Returns true if the task should be woken up, false otherwise.
+ * Returns true if this is a trylock waiter.
  */
 static inline bool rt_mutex_wake_trylock_waiter(struct rt_mutex_waiter *waiter)
 {
-	struct task_struct *task = waiter->task;
+	struct task_struct *task;
+	struct rt_mutex *lock;
 	unsigned long flags;
 	bool wakeup;
+	bool trylock_waiter = false;
+
+again:
+	task = waiter->task;
 
 	if (likely(waiter != &task->rt_waiter))
-		return true;
+		return trylock_waiter;
+
+	trylock_waiter = true;
 
 	/*
 	 * A task boosted current because it is within a trylock spin.
@@ -276,12 +284,57 @@ static inline bool rt_mutex_wake_trylock_waiter(struct rt_mutex_waiter *waiter)
 	 */
 	raw_spin_lock_irqsave(&task->pi_lock, flags);
 	rt_mutex_dequeue(waiter->lock, waiter);
+	lock = waiter->lock;
 	waiter->lock = NULL;
 
 	wakeup = waiter->wake_up;
+	get_task_struct(task);
 	raw_spin_unlock_irqrestore(&task->pi_lock, flags);
 
-	return wakeup;
+	if (wakeup)
+		rt_mutex_wake_waiter(waiter);
+
+	put_task_struct(task);
+
+	/*
+	 * All tasks that are trylock waiters need to be woken up,
+	 * otherwise there's a chance that the lock may go away from
+	 * under them. Here's the scenario:
+	 *
+	 *    CPU0	     CPU1		CPU2
+	 *    ----	     ----		----
+	 *   [task0]	     [task1]		[task2]
+	 *
+	 *  lock(dev->A)
+	 *		     lock(B)
+	 *		     trylock(dev->A)
+	 *		     unlock(B)
+	 *		     goto again
+	 *					lock(B)
+	 *					trylock(dev->A)
+	 *					unlock(B)
+	 *					goto again
+	 *  unlock(dev->A)
+	 *    wake(task1)
+	 *    remove_task1_links
+	 *  lock(B)
+	 *  free(dev)
+	 *  unlock(B)
+	 *
+	 * At this moment, although task1 is running and ready
+	 * to go, task2 is still on dev->wait_list, and that will
+	 * cause a panic when task2 does a cpu_chill().
+	 *
+	 * Things are fine as long as there's a waiter that is
+	 * from a rtmutex_lock(). Keep waking tasks until we find
+	 * a rtmutex_lock() waiter.
+	 */
+
+	if (!rt_mutex_has_waiters(lock))
+		return true;
+
+	waiter = rt_mutex_top_waiter(lock);
+	goto again;
 }
 
 static void __rt_mutex_adjust_prio(struct task_struct *task);
@@ -496,7 +549,7 @@ static inline struct task_struct *trylock_boost_owner(struct rt_mutex *lock)
 }
 static inline bool rt_mutex_wake_trylock_waiter(struct rt_mutex_waiter *waiter)
 {
-	return true;
+	return false;
 }
 static inline bool check_static_waiter(struct task_struct *task,
 				       struct rt_mutex *lock, bool ok)
@@ -1654,7 +1707,7 @@ static void wakeup_next_waiter(struct rt_mutex *lock)
 
 	raw_spin_unlock_irqrestore(&current->pi_lock, flags);
 
-	if (!rt_mutex_wake_trylock_waiter(waiter))
+	if (rt_mutex_wake_trylock_waiter(waiter))
 		return;
 
 	/*
-- 
2.5.1
