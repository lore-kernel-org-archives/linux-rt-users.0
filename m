From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: [rfc patch 2/2]  rt/locking/hotplug: Fix rt_spin_lock_slowlock()
 migrate_disable() bug
Date: Tue, 05 Apr 2016 14:49:57 +0200
Message-ID: <1459860597.7776.2.camel@gmail.com>
References: <1455318168-7125-1-git-send-email-bigeasy@linutronix.de>
	 <1455318168-7125-4-git-send-email-bigeasy@linutronix.de>
	 <1458463425.3908.5.camel@gmail.com> <1458814024.23732.35.camel@gmail.com>
	 <alpine.DEB.2.11.1603241140510.3978@nanos>
	 <1459405903.14336.64.camel@gmail.com>
	 <20160401211105.GE29603@linutronix.de> <1459566735.3779.36.camel@gmail.com>
	 <1459837988.26938.16.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459837988.26938.16.camel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


I met a problem while testing shiny new hotplug machinery.

migrate_disable() -> pin_current_cpu() -> hotplug_lock() leads to..
	BUG_ON(rt_mutex_real_waiter(task->pi_blocked_on));

With hotplug_lock()/hotplug_unlock() now gone, there is no lock added by
the CPU pinning code, thus we're free to pin after lock acquisition, and
unpin before release with no ABBA worries.  Doing so will also save a few
cycles if we have to repeat the acquisition loop.

Fixes: e24b142cfb4a rt/locking: Reenable migration accross schedule
Signed-off-by: Mike Galbraith <umgwanakikbuti@gmailo.com>
---
 kernel/locking/rtmutex.c |   37 +++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -930,12 +930,12 @@ static inline void rt_spin_lock_fastlock
 {
 	might_sleep_no_state_check();
 
-	if (do_mig_dis)
-		migrate_disable();
-
-	if (likely(rt_mutex_cmpxchg_acquire(lock, NULL, current)))
+	if (likely(rt_mutex_cmpxchg_acquire(lock, NULL, current))) {
 		rt_mutex_deadlock_account_lock(lock, current);
-	else
+
+		if (do_mig_dis)
+			migrate_disable();
+	} else
 		slowfn(lock, do_mig_dis);
 }
 
@@ -995,12 +995,11 @@ static int task_blocks_on_rt_mutex(struc
  * the try_to_wake_up() code handles this accordingly.
  */
 static void  noinline __sched rt_spin_lock_slowlock(struct rt_mutex *lock,
-						    bool mg_off)
+						    bool do_mig_dis)
 {
 	struct task_struct *lock_owner, *self = current;
 	struct rt_mutex_waiter waiter, *top_waiter;
 	unsigned long flags;
-	int ret;
 
 	rt_mutex_init_waiter(&waiter, true);
 
@@ -1008,6 +1007,8 @@ static void  noinline __sched rt_spin_lo
 
 	if (__try_to_take_rt_mutex(lock, self, NULL, STEAL_LATERAL)) {
 		raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
+		if (do_mig_dis)
+			migrate_disable();
 		return;
 	}
 
@@ -1024,8 +1025,7 @@ static void  noinline __sched rt_spin_lo
 	__set_current_state_no_track(TASK_UNINTERRUPTIBLE);
 	raw_spin_unlock(&self->pi_lock);
 
-	ret = task_blocks_on_rt_mutex(lock, &waiter, self, RT_MUTEX_MIN_CHAINWALK);
-	BUG_ON(ret);
+	BUG_ON(task_blocks_on_rt_mutex(lock, &waiter, self, RT_MUTEX_MIN_CHAINWALK));
 
 	for (;;) {
 		/* Try to acquire the lock again. */
@@ -1039,13 +1039,8 @@ static void  noinline __sched rt_spin_lo
 
 		debug_rt_mutex_print_deadlock(&waiter);
 
-		if (top_waiter != &waiter || adaptive_wait(lock, lock_owner)) {
-			if (mg_off)
-				migrate_enable();
+		if (top_waiter != &waiter || adaptive_wait(lock, lock_owner))
 			schedule();
-			if (mg_off)
-				migrate_disable();
-		}
 
 		raw_spin_lock_irqsave(&lock->wait_lock, flags);
 
@@ -1077,6 +1072,9 @@ static void  noinline __sched rt_spin_lo
 
 	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 
+	if (do_mig_dis)
+		migrate_disable();
+
 	debug_rt_mutex_free_waiter(&waiter);
 }
 
@@ -1159,10 +1157,10 @@ EXPORT_SYMBOL(rt_spin_unlock__no_mg);
 
 void __lockfunc rt_spin_unlock(spinlock_t *lock)
 {
+	migrate_enable();
 	/* NOTE: we always pass in '1' for nested, for simplicity */
 	spin_release(&lock->dep_map, 1, _RET_IP_);
 	rt_spin_lock_fastunlock(&lock->lock, rt_spin_lock_slowunlock);
-	migrate_enable();
 }
 EXPORT_SYMBOL(rt_spin_unlock);
 
@@ -1204,12 +1202,11 @@ int __lockfunc rt_spin_trylock(spinlock_
 {
 	int ret;
 
-	migrate_disable();
 	ret = rt_mutex_trylock(&lock->lock);
-	if (ret)
+	if (ret) {
+		migrate_disable();
 		spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
-	else
-		migrate_enable();
+	}
 	return ret;
 }
 EXPORT_SYMBOL(rt_spin_trylock);
