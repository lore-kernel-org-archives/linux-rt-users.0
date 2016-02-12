From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH RT 4/6] rt/locking: Reenable migration accross schedule
Date: Sat, 13 Feb 2016 00:02:46 +0100
Message-ID: <1455318168-7125-4-git-send-email-bigeasy@linutronix.de>
References: <1455318168-7125-1-git-send-email-bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
	Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455318168-7125-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

We currently disable migration across lock acquisition. That includes the part
where we block on the lock and schedule out. We cannot disable migration after
taking the lock as that would cause a possible lock inversion.

But we can be smart and enable migration when we block and schedule out. That
allows the scheduler to place the task freely at least if this is the first
migrate disable level. For nested locking this does not help at all.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/locking/rtmutex.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 913aa40f3b5e..66971005cc12 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -924,14 +924,19 @@ static int __try_to_take_rt_mutex(struct rt_mutex *lock,
  * preemptible spin_lock functions:
  */
 static inline void rt_spin_lock_fastlock(struct rt_mutex *lock,
-					 void  (*slowfn)(struct rt_mutex *lock))
+					 void  (*slowfn)(struct rt_mutex *lock,
+							 bool mg_off),
+					 bool do_mig_dis)
 {
 	might_sleep_no_state_check();
 
+	if (do_mig_dis)
+		migrate_disable();
+
 	if (likely(rt_mutex_cmpxchg_acquire(lock, NULL, current)))
 		rt_mutex_deadlock_account_lock(lock, current);
 	else
-		slowfn(lock);
+		slowfn(lock, do_mig_dis);
 }
 
 static inline void rt_spin_lock_fastunlock(struct rt_mutex *lock,
@@ -989,7 +994,8 @@ static int task_blocks_on_rt_mutex(struct rt_mutex *lock,
  * We store the current state under p->pi_lock in p->saved_state and
  * the try_to_wake_up() code handles this accordingly.
  */
-static void  noinline __sched rt_spin_lock_slowlock(struct rt_mutex *lock)
+static void  noinline __sched rt_spin_lock_slowlock(struct rt_mutex *lock,
+						    bool mg_off)
 {
 	struct task_struct *lock_owner, *self = current;
 	struct rt_mutex_waiter waiter, *top_waiter;
@@ -1033,8 +1039,13 @@ static void  noinline __sched rt_spin_lock_slowlock(struct rt_mutex *lock)
 
 		debug_rt_mutex_print_deadlock(&waiter);
 
-		if (top_waiter != &waiter || adaptive_wait(lock, lock_owner))
+		if (top_waiter != &waiter || adaptive_wait(lock, lock_owner)) {
+			if (mg_off)
+				migrate_enable();
 			schedule();
+			if (mg_off)
+				migrate_disable();
+		}
 
 		raw_spin_lock_irqsave(&lock->wait_lock, flags);
 
@@ -1105,38 +1116,35 @@ static void  noinline __sched rt_spin_lock_slowunlock(struct rt_mutex *lock)
 
 void __lockfunc rt_spin_lock__no_mg(spinlock_t *lock)
 {
-	rt_spin_lock_fastlock(&lock->lock, rt_spin_lock_slowlock);
+	rt_spin_lock_fastlock(&lock->lock, rt_spin_lock_slowlock, false);
 	spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
 }
 EXPORT_SYMBOL(rt_spin_lock__no_mg);
 
 void __lockfunc rt_spin_lock(spinlock_t *lock)
 {
-	migrate_disable();
-	rt_spin_lock_fastlock(&lock->lock, rt_spin_lock_slowlock);
+	rt_spin_lock_fastlock(&lock->lock, rt_spin_lock_slowlock, true);
 	spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
 }
 EXPORT_SYMBOL(rt_spin_lock);
 
 void __lockfunc __rt_spin_lock(struct rt_mutex *lock)
 {
-	migrate_disable();
-	rt_spin_lock_fastlock(lock, rt_spin_lock_slowlock);
+	rt_spin_lock_fastlock(lock, rt_spin_lock_slowlock, true);
 }
 EXPORT_SYMBOL(__rt_spin_lock);
 
 void __lockfunc __rt_spin_lock__no_mg(struct rt_mutex *lock)
 {
-	rt_spin_lock_fastlock(lock, rt_spin_lock_slowlock);
+	rt_spin_lock_fastlock(lock, rt_spin_lock_slowlock, false);
 }
 EXPORT_SYMBOL(__rt_spin_lock__no_mg);
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 void __lockfunc rt_spin_lock_nested(spinlock_t *lock, int subclass)
 {
-	migrate_disable();
-	rt_spin_lock_fastlock(&lock->lock, rt_spin_lock_slowlock);
 	spin_acquire(&lock->dep_map, subclass, 0, _RET_IP_);
+	rt_spin_lock_fastlock(&lock->lock, rt_spin_lock_slowlock, true);
 }
 EXPORT_SYMBOL(rt_spin_lock_nested);
 #endif
-- 
2.7.0
