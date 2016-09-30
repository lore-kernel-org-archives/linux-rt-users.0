From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [ANNOUNCE] 4.6.7-rt14
Date: Fri, 30 Sep 2016 23:50:56 +0200
Message-ID: <20160930215056.3e6ysbsvktywg6wz@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Dear RT folks!

I'm pleased to announce the v4.6.7-rt14 patch set. 

Changes since v4.6.7-rt13:

  - It is possible that a task which got priority boosted, de-boosted
    itself too early in the unlock path. This leads to then priority
    inversion because the waiter with priority waits while a process
    with lower priority runs.

Known issues
	- CPU hotplug got a little better but can deadlock.

The delta patch against 4.6.7-rt13 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.6/incr/patch-4.6.7-rt13-rt14.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.6.7-rt14

The RT patch against 4.6.7 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.6/patch-4.6.7-rt14.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.6/patches-4.6.7-rt14.tar.xz

Sebastian

diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index b241cc044bd3..02928fa5499d 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -355,6 +355,12 @@ static __always_inline void spin_unlock(spinlock_t *lock)
 	raw_spin_unlock(&lock->rlock);
 }
 
+static __always_inline int spin_unlock_no_deboost(spinlock_t *lock)
+{
+	raw_spin_unlock(&lock->rlock);
+	return 0;
+}
+
 static __always_inline void spin_unlock_bh(spinlock_t *lock)
 {
 	raw_spin_unlock_bh(&lock->rlock);
diff --git a/include/linux/spinlock_rt.h b/include/linux/spinlock_rt.h
index 3b2825537531..7eb87584e843 100644
--- a/include/linux/spinlock_rt.h
+++ b/include/linux/spinlock_rt.h
@@ -26,6 +26,7 @@ extern void __lockfunc rt_spin_lock(spinlock_t *lock);
 extern unsigned long __lockfunc rt_spin_lock_trace_flags(spinlock_t *lock);
 extern void __lockfunc rt_spin_lock_nested(spinlock_t *lock, int subclass);
 extern void __lockfunc rt_spin_unlock(spinlock_t *lock);
+extern int __lockfunc rt_spin_unlock_no_deboost(spinlock_t *lock);
 extern void __lockfunc rt_spin_unlock_wait(spinlock_t *lock);
 extern int __lockfunc rt_spin_trylock_irqsave(spinlock_t *lock, unsigned long *flags);
 extern int __lockfunc rt_spin_trylock_bh(spinlock_t *lock);
@@ -112,6 +113,7 @@ static inline unsigned long spin_lock_trace_flags(spinlock_t *lock)
 #define spin_lock_nest_lock(lock, nest_lock) spin_lock_nested(lock, 0)
 
 #define spin_unlock(lock)			rt_spin_unlock(lock)
+#define spin_unlock_no_deboost(lock)		rt_spin_unlock_no_deboost(lock)
 
 #define spin_unlock_bh(lock)				\
 	do {						\
diff --git a/kernel/futex.c b/kernel/futex.c
index 2d572edcac53..e12dea2ef4d6 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1347,7 +1347,7 @@ static int wake_futex_pi(u32 __user *uaddr, u32 uval, struct futex_q *this,
 	 * deboost first (and lose our higher priority), then the task might get
 	 * scheduled away before the wake up can take place.
 	 */
-	spin_unlock(&hb->lock);
+	deboost |= spin_unlock_no_deboost(&hb->lock);
 	wake_up_q(&wake_q);
 	wake_up_q_sleeper(&wake_sleeper_q);
 	if (deboost)
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index fde5e54f1096..bea124d6cbee 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -939,13 +939,14 @@ static inline void rt_spin_lock_fastlock(struct rt_mutex *lock,
 		slowfn(lock, do_mig_dis);
 }
 
-static inline void rt_spin_lock_fastunlock(struct rt_mutex *lock,
-					   void  (*slowfn)(struct rt_mutex *lock))
+static inline int rt_spin_lock_fastunlock(struct rt_mutex *lock,
+					  int (*slowfn)(struct rt_mutex *lock))
 {
-	if (likely(rt_mutex_cmpxchg_release(lock, current, NULL)))
+	if (likely(rt_mutex_cmpxchg_release(lock, current, NULL))) {
 		rt_mutex_deadlock_account_unlock(current);
-	else
-		slowfn(lock);
+		return 0;
+	}
+	return slowfn(lock);
 }
 #ifdef CONFIG_SMP
 /*
@@ -1086,7 +1087,7 @@ static void mark_wakeup_next_waiter(struct wake_q_head *wake_q,
 /*
  * Slow path to release a rt_mutex spin_lock style
  */
-static void  noinline __sched rt_spin_lock_slowunlock(struct rt_mutex *lock)
+static int noinline __sched rt_spin_lock_slowunlock(struct rt_mutex *lock)
 {
 	unsigned long flags;
 	WAKE_Q(wake_q);
@@ -1101,7 +1102,7 @@ static void  noinline __sched rt_spin_lock_slowunlock(struct rt_mutex *lock)
 	if (!rt_mutex_has_waiters(lock)) {
 		lock->owner = NULL;
 		raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
-		return;
+		return 0;
 	}
 
 	mark_wakeup_next_waiter(&wake_q, &wake_sleeper_q, lock);
@@ -1112,6 +1113,33 @@ static void  noinline __sched rt_spin_lock_slowunlock(struct rt_mutex *lock)
 
 	/* Undo pi boosting.when necessary */
 	rt_mutex_adjust_prio(current);
+	return 0;
+}
+
+static int noinline __sched rt_spin_lock_slowunlock_no_deboost(struct rt_mutex *lock)
+{
+	unsigned long flags;
+	WAKE_Q(wake_q);
+	WAKE_Q(wake_sleeper_q);
+
+	raw_spin_lock_irqsave(&lock->wait_lock, flags);
+
+	debug_rt_mutex_unlock(lock);
+
+	rt_mutex_deadlock_account_unlock(current);
+
+	if (!rt_mutex_has_waiters(lock)) {
+		lock->owner = NULL;
+		raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
+		return 0;
+	}
+
+	mark_wakeup_next_waiter(&wake_q, &wake_sleeper_q, lock);
+
+	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
+	wake_up_q(&wake_q);
+	wake_up_q_sleeper(&wake_sleeper_q);
+	return 1;
 }
 
 void __lockfunc rt_spin_lock__no_mg(spinlock_t *lock)
@@ -1166,6 +1194,17 @@ void __lockfunc rt_spin_unlock(spinlock_t *lock)
 }
 EXPORT_SYMBOL(rt_spin_unlock);
 
+int __lockfunc rt_spin_unlock_no_deboost(spinlock_t *lock)
+{
+	int ret;
+
+	/* NOTE: we always pass in '1' for nested, for simplicity */
+	spin_release(&lock->dep_map, 1, _RET_IP_);
+	ret = rt_spin_lock_fastunlock(&lock->lock, rt_spin_lock_slowunlock_no_deboost);
+	migrate_enable();
+	return ret;
+}
+
 void __lockfunc __rt_spin_unlock(struct rt_mutex *lock)
 {
 	rt_spin_lock_fastunlock(lock, rt_spin_lock_slowunlock);
diff --git a/localversion-rt b/localversion-rt
index 9f7d0bdbffb1..08b3e75841ad 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt13
+-rt14
