From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [ANNOUNCE] 4.4.1-rt6
Date: Sat, 13 Feb 2016 00:47:08 +0100
Message-ID: <20160212234708.GB7694@linutronix.de>
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

I'm pleased to announce the v4.4.1-rt6 patch set.
Changes since v4.4.1-rt5:

- The rtmutex wait_lock is taken with interrupts disabled again. It
  fixes a possible deadlock in the posix timer code. Patch by Thomas
  Gleixner.

- Don't disable interrupts around atomic_dec_and_lock() in
  wb_congested_put()

- use a RCU lock in call_step_hook() on ARM64 to avoid sleeping while
  atomic issue. Patch by Yang Shi.

- In migrate_disable() we use now the fast / atomic path if were are
  called with interrupts disabled. This avoids a recursion with lockdep
  in some cases.

- The migrate_disable()/_enable() invocation has been moved from the
  locking macro into the used rt_mutex functions. This makes the kernel a
  tiny bit smaller.

- We now try to invoke migrate_enable() before we schedule() out while
  waiting for a lock. This optimization should allow the scheduler to
  put the task on another CPU once it became runnable and the original
  CPU is busy. This does not work for nested locks. Patch by Thomas
  Gleixner.

- The stop_machine.c was converted to use raw_locks. This patch has been
  identified to cause problems during hotplug and was reverted.

- There is a useless rcu_bh thread which has been deactivated.

- Manish Jaggi reported that a sleeping while atomic issue on AMR64 with
  KVM. Josh Cartwright sent a patch.

Known issues:
  - bcache stays disabled

  - CPU hotplug got a little better but can deadlock.

  - The netlink_release() OOPS, reported by Clark, is still on the
    list, but unsolved due to lack of information.
    Since Clark can not reproduce it anymore and hasn't seen it, it will
    be removed from this list and moved to the bugzilla.

The delta patch against 4.4.1-rt5 is appended below and can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.4/incr/patch-4.4.1-rt5-rt6.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.4.1-rt6

The RT patch against 4.4.1 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.4/patch-4.4.1-rt6.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.4/patches-4.4.1-rt6.tar.xz

Sebastian

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 4f5c42a0924c..2ce9cc2717ac 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -568,7 +568,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 		 * involves poking the GIC, which must be done in a
 		 * non-preemptible context.
 		 */
-		preempt_disable();
+		migrate_disable();
 		kvm_timer_flush_hwstate(vcpu);
 		kvm_vgic_flush_hwstate(vcpu);
 
@@ -587,7 +587,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 			local_irq_enable();
 			kvm_timer_sync_hwstate(vcpu);
 			kvm_vgic_sync_hwstate(vcpu);
-			preempt_enable();
+			migrate_enable();
 			continue;
 		}
 
@@ -641,7 +641,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 
 		kvm_vgic_sync_hwstate(vcpu);
 
-		preempt_enable();
+		migrate_enable();
 
 		ret = handle_exit(vcpu, run, ret);
 	}
diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index 8aee3aeec3e6..c1492ba1f6d1 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -186,20 +186,21 @@ static void clear_regs_spsr_ss(struct pt_regs *regs)
 
 /* EL1 Single Step Handler hooks */
 static LIST_HEAD(step_hook);
-static DEFINE_RWLOCK(step_hook_lock);
+static DEFINE_SPINLOCK(step_hook_lock);
 
 void register_step_hook(struct step_hook *hook)
 {
-	write_lock(&step_hook_lock);
-	list_add(&hook->node, &step_hook);
-	write_unlock(&step_hook_lock);
+	spin_lock(&step_hook_lock);
+	list_add_rcu(&hook->node, &step_hook);
+	spin_unlock(&step_hook_lock);
 }
 
 void unregister_step_hook(struct step_hook *hook)
 {
-	write_lock(&step_hook_lock);
-	list_del(&hook->node);
-	write_unlock(&step_hook_lock);
+	spin_lock(&step_hook_lock);
+	list_del_rcu(&hook->node);
+	spin_unlock(&step_hook_lock);
+	synchronize_rcu();
 }
 
 /*
@@ -213,15 +214,15 @@ static int call_step_hook(struct pt_regs *regs, unsigned int esr)
 	struct step_hook *hook;
 	int retval = DBG_HOOK_ERROR;
 
-	read_lock(&step_hook_lock);
+	rcu_read_lock();
 
-	list_for_each_entry(hook, &step_hook, node)	{
+	list_for_each_entry_rcu(hook, &step_hook, node)	{
 		retval = hook->fn(regs, esr);
 		if (retval == DBG_HOOK_HANDLED)
 			break;
 	}
 
-	read_unlock(&step_hook_lock);
+	rcu_read_unlock();
 
 	return retval;
 }
diff --git a/include/linux/locallock.h b/include/linux/locallock.h
index 339ba00adb9a..6fe5928fc2ab 100644
--- a/include/linux/locallock.h
+++ b/include/linux/locallock.h
@@ -43,9 +43,9 @@ struct local_irq_lock {
  * for CONFIG_PREEMPT_BASE map to the normal spin_* calls.
  */
 #ifdef CONFIG_PREEMPT_RT_FULL
-# define spin_lock_local(lock)			rt_spin_lock(lock)
-# define spin_trylock_local(lock)		rt_spin_trylock(lock)
-# define spin_unlock_local(lock)		rt_spin_unlock(lock)
+# define spin_lock_local(lock)			rt_spin_lock__no_mg(lock)
+# define spin_trylock_local(lock)		rt_spin_trylock__no_mg(lock)
+# define spin_unlock_local(lock)		rt_spin_unlock__no_mg(lock)
 #else
 # define spin_lock_local(lock)			spin_lock(lock)
 # define spin_trylock_local(lock)		spin_trylock(lock)
diff --git a/include/linux/spinlock_rt.h b/include/linux/spinlock_rt.h
index f757096b230c..3b2825537531 100644
--- a/include/linux/spinlock_rt.h
+++ b/include/linux/spinlock_rt.h
@@ -18,6 +18,10 @@ do {							\
 	__rt_spin_lock_init(slock, #slock, &__key);	\
 } while (0)
 
+void __lockfunc rt_spin_lock__no_mg(spinlock_t *lock);
+void __lockfunc rt_spin_unlock__no_mg(spinlock_t *lock);
+int __lockfunc rt_spin_trylock__no_mg(spinlock_t *lock);
+
 extern void __lockfunc rt_spin_lock(spinlock_t *lock);
 extern unsigned long __lockfunc rt_spin_lock_trace_flags(spinlock_t *lock);
 extern void __lockfunc rt_spin_lock_nested(spinlock_t *lock, int subclass);
@@ -32,20 +36,16 @@ extern int atomic_dec_and_spin_lock(atomic_t *atomic, spinlock_t *lock);
  * lockdep-less calls, for derived types like rwlock:
  * (for trylock they can use rt_mutex_trylock() directly.
  */
+extern void __lockfunc __rt_spin_lock__no_mg(struct rt_mutex *lock);
 extern void __lockfunc __rt_spin_lock(struct rt_mutex *lock);
 extern void __lockfunc __rt_spin_unlock(struct rt_mutex *lock);
 extern int __lockfunc __rt_spin_trylock(struct rt_mutex *lock);
 
-#define spin_lock(lock)				\
-	do {					\
-		migrate_disable();		\
-		rt_spin_lock(lock);		\
-	} while (0)
+#define spin_lock(lock)			rt_spin_lock(lock)
 
 #define spin_lock_bh(lock)			\
 	do {					\
 		local_bh_disable();		\
-		migrate_disable();		\
 		rt_spin_lock(lock);		\
 	} while (0)
 
@@ -56,24 +56,19 @@ extern int __lockfunc __rt_spin_trylock(struct rt_mutex *lock);
 #define spin_trylock(lock)			\
 ({						\
 	int __locked;				\
-	migrate_disable();			\
 	__locked = spin_do_trylock(lock);	\
-	if (!__locked)				\
-		migrate_enable();		\
 	__locked;				\
 })
 
 #ifdef CONFIG_LOCKDEP
 # define spin_lock_nested(lock, subclass)		\
 	do {						\
-		migrate_disable();			\
 		rt_spin_lock_nested(lock, subclass);	\
 	} while (0)
 
 #define spin_lock_bh_nested(lock, subclass)		\
 	do {						\
 		local_bh_disable();			\
-		migrate_disable();			\
 		rt_spin_lock_nested(lock, subclass);	\
 	} while (0)
 
@@ -81,7 +76,6 @@ extern int __lockfunc __rt_spin_trylock(struct rt_mutex *lock);
 	do {						 \
 		typecheck(unsigned long, flags);	 \
 		flags = 0;				 \
-		migrate_disable();			 \
 		rt_spin_lock_nested(lock, subclass);	 \
 	} while (0)
 #else
@@ -117,16 +111,11 @@ static inline unsigned long spin_lock_trace_flags(spinlock_t *lock)
 /* FIXME: we need rt_spin_lock_nest_lock */
 #define spin_lock_nest_lock(lock, nest_lock) spin_lock_nested(lock, 0)
 
-#define spin_unlock(lock)				\
-	do {						\
-		rt_spin_unlock(lock);			\
-		migrate_enable();			\
-	} while (0)
+#define spin_unlock(lock)			rt_spin_unlock(lock)
 
 #define spin_unlock_bh(lock)				\
 	do {						\
 		rt_spin_unlock(lock);			\
-		migrate_enable();			\
 		local_bh_enable();			\
 	} while (0)
 
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 51aafc259546..8edd3c716092 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -127,8 +127,8 @@ struct hotplug_pcp {
 };
 
 #ifdef CONFIG_PREEMPT_RT_FULL
-# define hotplug_lock(hp) rt_spin_lock(&(hp)->lock)
-# define hotplug_unlock(hp) rt_spin_unlock(&(hp)->lock)
+# define hotplug_lock(hp) rt_spin_lock__no_mg(&(hp)->lock)
+# define hotplug_unlock(hp) rt_spin_unlock__no_mg(&(hp)->lock)
 #else
 # define hotplug_lock(hp) mutex_lock(&(hp)->mutex)
 # define hotplug_unlock(hp) mutex_unlock(&(hp)->mutex)
diff --git a/kernel/futex.c b/kernel/futex.c
index 11bca4377cd3..af4f1b4d682b 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1226,7 +1226,7 @@ static int wake_futex_pi(u32 __user *uaddr, u32 uval, struct futex_q *this,
 	if (pi_state->owner != current)
 		return -EINVAL;
 
-	raw_spin_lock(&pi_state->pi_mutex.wait_lock);
+	raw_spin_lock_irq(&pi_state->pi_mutex.wait_lock);
 	new_owner = rt_mutex_next_owner(&pi_state->pi_mutex);
 
 	/*
@@ -1252,22 +1252,22 @@ static int wake_futex_pi(u32 __user *uaddr, u32 uval, struct futex_q *this,
 	else if (curval != uval)
 		ret = -EINVAL;
 	if (ret) {
-		raw_spin_unlock(&pi_state->pi_mutex.wait_lock);
+		raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
 		return ret;
 	}
 
-	raw_spin_lock_irq(&pi_state->owner->pi_lock);
+	raw_spin_lock(&pi_state->owner->pi_lock);
 	WARN_ON(list_empty(&pi_state->list));
 	list_del_init(&pi_state->list);
-	raw_spin_unlock_irq(&pi_state->owner->pi_lock);
+	raw_spin_unlock(&pi_state->owner->pi_lock);
 
-	raw_spin_lock_irq(&new_owner->pi_lock);
+	raw_spin_lock(&new_owner->pi_lock);
 	WARN_ON(!list_empty(&pi_state->list));
 	list_add(&pi_state->list, &new_owner->pi_state_list);
 	pi_state->owner = new_owner;
-	raw_spin_unlock_irq(&new_owner->pi_lock);
+	raw_spin_unlock(&new_owner->pi_lock);
 
-	raw_spin_unlock(&pi_state->pi_mutex.wait_lock);
+	raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
 
 	deboost = rt_mutex_futex_unlock(&pi_state->pi_mutex, &wake_q,
 					&wake_sleeper_q);
@@ -2144,11 +2144,11 @@ static int fixup_owner(u32 __user *uaddr, struct futex_q *q, int locked)
 		 * we returned due to timeout or signal without taking the
 		 * rt_mutex. Too late.
 		 */
-		raw_spin_lock(&q->pi_state->pi_mutex.wait_lock);
+		raw_spin_lock_irq(&q->pi_state->pi_mutex.wait_lock);
 		owner = rt_mutex_owner(&q->pi_state->pi_mutex);
 		if (!owner)
 			owner = rt_mutex_next_owner(&q->pi_state->pi_mutex);
-		raw_spin_unlock(&q->pi_state->pi_mutex.wait_lock);
+		raw_spin_unlock_irq(&q->pi_state->pi_mutex.wait_lock);
 		ret = fixup_pi_state_owner(uaddr, q, owner);
 		goto out;
 	}
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index ba2a42a37025..8e89554aa345 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -2060,7 +2060,7 @@ EXPORT_SYMBOL_GPL(irq_get_irqchip_state);
  *	This call sets the internal irqchip state of an interrupt,
  *	depending on the value of @which.
  *
- *	This function should be called with preemption disabled if the
+ *	This function should be called with migration disabled if the
  *	interrupt controller has per-cpu registers.
  */
 int irq_set_irqchip_state(unsigned int irq, enum irqchip_irq_state which,
diff --git a/kernel/locking/lglock.c b/kernel/locking/lglock.c
index d8be4fcc14f8..51bfe64e7d16 100644
--- a/kernel/locking/lglock.c
+++ b/kernel/locking/lglock.c
@@ -10,7 +10,7 @@
 # define lg_do_unlock(l)	arch_spin_unlock(l)
 #else
 # define lg_lock_ptr		struct rt_mutex
-# define lg_do_lock(l)		__rt_spin_lock(l)
+# define lg_do_lock(l)		__rt_spin_lock__no_mg(l)
 # define lg_do_unlock(l)	__rt_spin_unlock(l)
 #endif
 /*
diff --git a/kernel/locking/rt.c b/kernel/locking/rt.c
index 1bbbcad5e360..d4ab61c1848b 100644
--- a/kernel/locking/rt.c
+++ b/kernel/locking/rt.c
@@ -235,7 +235,6 @@ EXPORT_SYMBOL(rt_read_trylock);
 void __lockfunc rt_write_lock(rwlock_t *rwlock)
 {
 	rwlock_acquire(&rwlock->dep_map, 0, 0, _RET_IP_);
-	migrate_disable();
 	__rt_spin_lock(&rwlock->lock);
 }
 EXPORT_SYMBOL(rt_write_lock);
@@ -249,7 +248,6 @@ void __lockfunc rt_read_lock(rwlock_t *rwlock)
 	 * recursive read locks succeed when current owns the lock
 	 */
 	if (rt_mutex_owner(lock) != current) {
-		migrate_disable();
 		rwlock_acquire(&rwlock->dep_map, 0, 0, _RET_IP_);
 		__rt_spin_lock(lock);
 	}
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index e1ddae39d56b..66971005cc12 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -111,13 +111,14 @@ static inline void mark_rt_mutex_waiters(struct rt_mutex *lock)
  * 2) Drop lock->wait_lock
  * 3) Try to unlock the lock with cmpxchg
  */
-static inline bool unlock_rt_mutex_safe(struct rt_mutex *lock)
+static inline bool unlock_rt_mutex_safe(struct rt_mutex *lock,
+					unsigned long flags)
 	__releases(lock->wait_lock)
 {
 	struct task_struct *owner = rt_mutex_owner(lock);
 
 	clear_rt_mutex_waiters(lock);
-	raw_spin_unlock(&lock->wait_lock);
+	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 	/*
 	 * If a new waiter comes in between the unlock and the cmpxchg
 	 * we have two situations:
@@ -159,11 +160,12 @@ static inline void mark_rt_mutex_waiters(struct rt_mutex *lock)
 /*
  * Simple slow path only version: lock->owner is protected by lock->wait_lock.
  */
-static inline bool unlock_rt_mutex_safe(struct rt_mutex *lock)
+static inline bool unlock_rt_mutex_safe(struct rt_mutex *lock,
+					unsigned long flags)
 	__releases(lock->wait_lock)
 {
 	lock->owner = NULL;
-	raw_spin_unlock(&lock->wait_lock);
+	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 	return true;
 }
 #endif
@@ -454,7 +456,6 @@ static int rt_mutex_adjust_prio_chain(struct task_struct *task,
 	int ret = 0, depth = 0;
 	struct rt_mutex *lock;
 	bool detect_deadlock;
-	unsigned long flags;
 	bool requeue = true;
 
 	detect_deadlock = rt_mutex_cond_detect_deadlock(orig_waiter, chwalk);
@@ -497,7 +498,7 @@ static int rt_mutex_adjust_prio_chain(struct task_struct *task,
 	/*
 	 * [1] Task cannot go away as we did a get_task() before !
 	 */
-	raw_spin_lock_irqsave(&task->pi_lock, flags);
+	raw_spin_lock_irq(&task->pi_lock);
 
 	/*
 	 * [2] Get the waiter on which @task is blocked on.
@@ -581,7 +582,7 @@ static int rt_mutex_adjust_prio_chain(struct task_struct *task,
 	 * operations.
 	 */
 	if (!raw_spin_trylock(&lock->wait_lock)) {
-		raw_spin_unlock_irqrestore(&task->pi_lock, flags);
+		raw_spin_unlock_irq(&task->pi_lock);
 		cpu_relax();
 		goto retry;
 	}
@@ -612,7 +613,7 @@ static int rt_mutex_adjust_prio_chain(struct task_struct *task,
 		/*
 		 * No requeue[7] here. Just release @task [8]
 		 */
-		raw_spin_unlock_irqrestore(&task->pi_lock, flags);
+		raw_spin_unlock(&task->pi_lock);
 		put_task_struct(task);
 
 		/*
@@ -620,14 +621,14 @@ static int rt_mutex_adjust_prio_chain(struct task_struct *task,
 		 * If there is no owner of the lock, end of chain.
 		 */
 		if (!rt_mutex_owner(lock)) {
-			raw_spin_unlock(&lock->wait_lock);
+			raw_spin_unlock_irq(&lock->wait_lock);
 			return 0;
 		}
 
 		/* [10] Grab the next task, i.e. owner of @lock */
 		task = rt_mutex_owner(lock);
 		get_task_struct(task);
-		raw_spin_lock_irqsave(&task->pi_lock, flags);
+		raw_spin_lock(&task->pi_lock);
 
 		/*
 		 * No requeue [11] here. We just do deadlock detection.
@@ -642,8 +643,8 @@ static int rt_mutex_adjust_prio_chain(struct task_struct *task,
 		top_waiter = rt_mutex_top_waiter(lock);
 
 		/* [13] Drop locks */
-		raw_spin_unlock_irqrestore(&task->pi_lock, flags);
-		raw_spin_unlock(&lock->wait_lock);
+		raw_spin_unlock(&task->pi_lock);
+		raw_spin_unlock_irq(&lock->wait_lock);
 
 		/* If owner is not blocked, end of chain. */
 		if (!next_lock)
@@ -664,7 +665,7 @@ static int rt_mutex_adjust_prio_chain(struct task_struct *task,
 	rt_mutex_enqueue(lock, waiter);
 
 	/* [8] Release the task */
-	raw_spin_unlock_irqrestore(&task->pi_lock, flags);
+	raw_spin_unlock(&task->pi_lock);
 	put_task_struct(task);
 
 	/*
@@ -685,14 +686,14 @@ static int rt_mutex_adjust_prio_chain(struct task_struct *task,
 		lock_top_waiter = rt_mutex_top_waiter(lock);
 		if (prerequeue_top_waiter != lock_top_waiter)
 			rt_mutex_wake_waiter(lock_top_waiter);
-		raw_spin_unlock(&lock->wait_lock);
+		raw_spin_unlock_irq(&lock->wait_lock);
 		return 0;
 	}
 
 	/* [10] Grab the next task, i.e. the owner of @lock */
 	task = rt_mutex_owner(lock);
 	get_task_struct(task);
-	raw_spin_lock_irqsave(&task->pi_lock, flags);
+	raw_spin_lock(&task->pi_lock);
 
 	/* [11] requeue the pi waiters if necessary */
 	if (waiter == rt_mutex_top_waiter(lock)) {
@@ -746,8 +747,8 @@ static int rt_mutex_adjust_prio_chain(struct task_struct *task,
 	top_waiter = rt_mutex_top_waiter(lock);
 
 	/* [13] Drop the locks */
-	raw_spin_unlock_irqrestore(&task->pi_lock, flags);
-	raw_spin_unlock(&lock->wait_lock);
+	raw_spin_unlock(&task->pi_lock);
+	raw_spin_unlock_irq(&lock->wait_lock);
 
 	/*
 	 * Make the actual exit decisions [12], based on the stored
@@ -770,7 +771,7 @@ static int rt_mutex_adjust_prio_chain(struct task_struct *task,
 	goto again;
 
  out_unlock_pi:
-	raw_spin_unlock_irqrestore(&task->pi_lock, flags);
+	raw_spin_unlock_irq(&task->pi_lock);
  out_put_task:
 	put_task_struct(task);
 
@@ -799,7 +800,7 @@ static inline int lock_is_stealable(struct task_struct *task,
 /*
  * Try to take an rt-mutex
  *
- * Must be called with lock->wait_lock held.
+ * Must be called with lock->wait_lock held and interrupts disabled
  *
  * @lock:   The lock to be acquired.
  * @task:   The task which wants to acquire the lock
@@ -810,8 +811,6 @@ static int __try_to_take_rt_mutex(struct rt_mutex *lock,
 				  struct task_struct *task,
 				  struct rt_mutex_waiter *waiter, int mode)
 {
-	unsigned long flags;
-
 	/*
 	 * Before testing whether we can acquire @lock, we set the
 	 * RT_MUTEX_HAS_WAITERS bit in @lock->owner. This forces all
@@ -894,7 +893,7 @@ static int __try_to_take_rt_mutex(struct rt_mutex *lock,
 	 * case, but conditionals are more expensive than a redundant
 	 * store.
 	 */
-	raw_spin_lock_irqsave(&task->pi_lock, flags);
+	raw_spin_lock(&task->pi_lock);
 	task->pi_blocked_on = NULL;
 	/*
 	 * Finish the lock acquisition. @task is the new owner. If
@@ -903,7 +902,7 @@ static int __try_to_take_rt_mutex(struct rt_mutex *lock,
 	 */
 	if (rt_mutex_has_waiters(lock))
 		rt_mutex_enqueue_pi(task, rt_mutex_top_waiter(lock));
-	raw_spin_unlock_irqrestore(&task->pi_lock, flags);
+	raw_spin_unlock(&task->pi_lock);
 
 takeit:
 	/* We got the lock. */
@@ -925,14 +924,19 @@ static int __try_to_take_rt_mutex(struct rt_mutex *lock,
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
@@ -979,9 +983,6 @@ static int adaptive_wait(struct rt_mutex *lock,
 }
 #endif
 
-# define pi_lock(lock)		raw_spin_lock_irq(lock)
-# define pi_unlock(lock)	raw_spin_unlock_irq(lock)
-
 static int task_blocks_on_rt_mutex(struct rt_mutex *lock,
 				   struct rt_mutex_waiter *waiter,
 				   struct task_struct *task,
@@ -993,18 +994,20 @@ static int task_blocks_on_rt_mutex(struct rt_mutex *lock,
  * We store the current state under p->pi_lock in p->saved_state and
  * the try_to_wake_up() code handles this accordingly.
  */
-static void  noinline __sched rt_spin_lock_slowlock(struct rt_mutex *lock)
+static void  noinline __sched rt_spin_lock_slowlock(struct rt_mutex *lock,
+						    bool mg_off)
 {
 	struct task_struct *lock_owner, *self = current;
 	struct rt_mutex_waiter waiter, *top_waiter;
+	unsigned long flags;
 	int ret;
 
 	rt_mutex_init_waiter(&waiter, true);
 
-	raw_spin_lock(&lock->wait_lock);
+	raw_spin_lock_irqsave(&lock->wait_lock, flags);
 
 	if (__try_to_take_rt_mutex(lock, self, NULL, STEAL_LATERAL)) {
-		raw_spin_unlock(&lock->wait_lock);
+		raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 		return;
 	}
 
@@ -1016,10 +1019,10 @@ static void  noinline __sched rt_spin_lock_slowlock(struct rt_mutex *lock)
 	 * as well. We are serialized via pi_lock against wakeups. See
 	 * try_to_wake_up().
 	 */
-	pi_lock(&self->pi_lock);
+	raw_spin_lock(&self->pi_lock);
 	self->saved_state = self->state;
 	__set_current_state_no_track(TASK_UNINTERRUPTIBLE);
-	pi_unlock(&self->pi_lock);
+	raw_spin_unlock(&self->pi_lock);
 
 	ret = task_blocks_on_rt_mutex(lock, &waiter, self, RT_MUTEX_MIN_CHAINWALK);
 	BUG_ON(ret);
@@ -1032,18 +1035,23 @@ static void  noinline __sched rt_spin_lock_slowlock(struct rt_mutex *lock)
 		top_waiter = rt_mutex_top_waiter(lock);
 		lock_owner = rt_mutex_owner(lock);
 
-		raw_spin_unlock(&lock->wait_lock);
+		raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 
 		debug_rt_mutex_print_deadlock(&waiter);
 
-		if (top_waiter != &waiter || adaptive_wait(lock, lock_owner))
+		if (top_waiter != &waiter || adaptive_wait(lock, lock_owner)) {
+			if (mg_off)
+				migrate_enable();
 			schedule();
+			if (mg_off)
+				migrate_disable();
+		}
 
-		raw_spin_lock(&lock->wait_lock);
+		raw_spin_lock_irqsave(&lock->wait_lock, flags);
 
-		pi_lock(&self->pi_lock);
+		raw_spin_lock(&self->pi_lock);
 		__set_current_state_no_track(TASK_UNINTERRUPTIBLE);
-		pi_unlock(&self->pi_lock);
+		raw_spin_unlock(&self->pi_lock);
 	}
 
 	/*
@@ -1053,10 +1061,10 @@ static void  noinline __sched rt_spin_lock_slowlock(struct rt_mutex *lock)
 	 * happened while we were blocked. Clear saved_state so
 	 * try_to_wakeup() does not get confused.
 	 */
-	pi_lock(&self->pi_lock);
+	raw_spin_lock(&self->pi_lock);
 	__set_current_state_no_track(self->saved_state);
 	self->saved_state = TASK_RUNNING;
-	pi_unlock(&self->pi_lock);
+	raw_spin_unlock(&self->pi_lock);
 
 	/*
 	 * try_to_take_rt_mutex() sets the waiter bit
@@ -1067,7 +1075,7 @@ static void  noinline __sched rt_spin_lock_slowlock(struct rt_mutex *lock)
 	BUG_ON(rt_mutex_has_waiters(lock) && &waiter == rt_mutex_top_waiter(lock));
 	BUG_ON(!RB_EMPTY_NODE(&waiter.tree_entry));
 
-	raw_spin_unlock(&lock->wait_lock);
+	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 
 	debug_rt_mutex_free_waiter(&waiter);
 }
@@ -1080,10 +1088,11 @@ static void mark_wakeup_next_waiter(struct wake_q_head *wake_q,
  */
 static void  noinline __sched rt_spin_lock_slowunlock(struct rt_mutex *lock)
 {
+	unsigned long flags;
 	WAKE_Q(wake_q);
 	WAKE_Q(wake_sleeper_q);
 
-	raw_spin_lock(&lock->wait_lock);
+	raw_spin_lock_irqsave(&lock->wait_lock, flags);
 
 	debug_rt_mutex_unlock(lock);
 
@@ -1091,13 +1100,13 @@ static void  noinline __sched rt_spin_lock_slowunlock(struct rt_mutex *lock)
 
 	if (!rt_mutex_has_waiters(lock)) {
 		lock->owner = NULL;
-		raw_spin_unlock(&lock->wait_lock);
+		raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 		return;
 	}
 
 	mark_wakeup_next_waiter(&wake_q, &wake_sleeper_q, lock);
 
-	raw_spin_unlock(&lock->wait_lock);
+	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 	wake_up_q(&wake_q);
 	wake_up_q_sleeper(&wake_sleeper_q);
 
@@ -1105,33 +1114,55 @@ static void  noinline __sched rt_spin_lock_slowunlock(struct rt_mutex *lock)
 	rt_mutex_adjust_prio(current);
 }
 
+void __lockfunc rt_spin_lock__no_mg(spinlock_t *lock)
+{
+	rt_spin_lock_fastlock(&lock->lock, rt_spin_lock_slowlock, false);
+	spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
+}
+EXPORT_SYMBOL(rt_spin_lock__no_mg);
+
 void __lockfunc rt_spin_lock(spinlock_t *lock)
 {
-	rt_spin_lock_fastlock(&lock->lock, rt_spin_lock_slowlock);
+	rt_spin_lock_fastlock(&lock->lock, rt_spin_lock_slowlock, true);
 	spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
 }
 EXPORT_SYMBOL(rt_spin_lock);
 
 void __lockfunc __rt_spin_lock(struct rt_mutex *lock)
 {
-	rt_spin_lock_fastlock(lock, rt_spin_lock_slowlock);
+	rt_spin_lock_fastlock(lock, rt_spin_lock_slowlock, true);
 }
 EXPORT_SYMBOL(__rt_spin_lock);
 
+void __lockfunc __rt_spin_lock__no_mg(struct rt_mutex *lock)
+{
+	rt_spin_lock_fastlock(lock, rt_spin_lock_slowlock, false);
+}
+EXPORT_SYMBOL(__rt_spin_lock__no_mg);
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 void __lockfunc rt_spin_lock_nested(spinlock_t *lock, int subclass)
 {
-	rt_spin_lock_fastlock(&lock->lock, rt_spin_lock_slowlock);
 	spin_acquire(&lock->dep_map, subclass, 0, _RET_IP_);
+	rt_spin_lock_fastlock(&lock->lock, rt_spin_lock_slowlock, true);
 }
 EXPORT_SYMBOL(rt_spin_lock_nested);
 #endif
 
+void __lockfunc rt_spin_unlock__no_mg(spinlock_t *lock)
+{
+	/* NOTE: we always pass in '1' for nested, for simplicity */
+	spin_release(&lock->dep_map, 1, _RET_IP_);
+	rt_spin_lock_fastunlock(&lock->lock, rt_spin_lock_slowunlock);
+}
+EXPORT_SYMBOL(rt_spin_unlock__no_mg);
+
 void __lockfunc rt_spin_unlock(spinlock_t *lock)
 {
 	/* NOTE: we always pass in '1' for nested, for simplicity */
 	spin_release(&lock->dep_map, 1, _RET_IP_);
 	rt_spin_lock_fastunlock(&lock->lock, rt_spin_lock_slowunlock);
+	migrate_enable();
 }
 EXPORT_SYMBOL(rt_spin_unlock);
 
@@ -1158,14 +1189,29 @@ int __lockfunc __rt_spin_trylock(struct rt_mutex *lock)
 	return rt_mutex_trylock(lock);
 }
 
-int __lockfunc rt_spin_trylock(spinlock_t *lock)
+int __lockfunc rt_spin_trylock__no_mg(spinlock_t *lock)
 {
-	int ret = rt_mutex_trylock(&lock->lock);
+	int ret;
 
+	ret = rt_mutex_trylock(&lock->lock);
 	if (ret)
 		spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
 	return ret;
 }
+EXPORT_SYMBOL(rt_spin_trylock__no_mg);
+
+int __lockfunc rt_spin_trylock(spinlock_t *lock)
+{
+	int ret;
+
+	migrate_disable();
+	ret = rt_mutex_trylock(&lock->lock);
+	if (ret)
+		spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
+	else
+		migrate_enable();
+	return ret;
+}
 EXPORT_SYMBOL(rt_spin_trylock);
 
 int __lockfunc rt_spin_trylock_bh(spinlock_t *lock)
@@ -1202,12 +1248,10 @@ int atomic_dec_and_spin_lock(atomic_t *atomic, spinlock_t *lock)
 	/* Subtract 1 from counter unless that drops it to 0 (ie. it was 1) */
 	if (atomic_add_unless(atomic, -1, 1))
 		return 0;
-	migrate_disable();
 	rt_spin_lock(lock);
 	if (atomic_dec_and_test(atomic))
 		return 1;
 	rt_spin_unlock(lock);
-	migrate_enable();
 	return 0;
 }
 EXPORT_SYMBOL(atomic_dec_and_spin_lock);
@@ -1273,7 +1317,7 @@ try_to_take_rt_mutex(struct rt_mutex *lock, struct task_struct *task,
  *
  * Prepare waiter and propagate pi chain
  *
- * This must be called with lock->wait_lock held.
+ * This must be called with lock->wait_lock held and interrupts disabled
  */
 static int task_blocks_on_rt_mutex(struct rt_mutex *lock,
 				   struct rt_mutex_waiter *waiter,
@@ -1284,7 +1328,6 @@ static int task_blocks_on_rt_mutex(struct rt_mutex *lock,
 	struct rt_mutex_waiter *top_waiter = waiter;
 	struct rt_mutex *next_lock;
 	int chain_walk = 0, res;
-	unsigned long flags;
 
 	/*
 	 * Early deadlock detection. We really don't want the task to
@@ -1298,7 +1341,7 @@ static int task_blocks_on_rt_mutex(struct rt_mutex *lock,
 	if (owner == task)
 		return -EDEADLK;
 
-	raw_spin_lock_irqsave(&task->pi_lock, flags);
+	raw_spin_lock(&task->pi_lock);
 
 	/*
 	 * In the case of futex requeue PI, this will be a proxy
@@ -1310,7 +1353,7 @@ static int task_blocks_on_rt_mutex(struct rt_mutex *lock,
 	 * the task if PI_WAKEUP_INPROGRESS is set.
 	 */
 	if (task != current && task->pi_blocked_on == PI_WAKEUP_INPROGRESS) {
-		raw_spin_unlock_irqrestore(&task->pi_lock, flags);
+		raw_spin_unlock(&task->pi_lock);
 		return -EAGAIN;
 	}
 
@@ -1328,12 +1371,12 @@ static int task_blocks_on_rt_mutex(struct rt_mutex *lock,
 
 	task->pi_blocked_on = waiter;
 
-	raw_spin_unlock_irqrestore(&task->pi_lock, flags);
+	raw_spin_unlock(&task->pi_lock);
 
 	if (!owner)
 		return 0;
 
-	raw_spin_lock_irqsave(&owner->pi_lock, flags);
+	raw_spin_lock(&owner->pi_lock);
 	if (waiter == rt_mutex_top_waiter(lock)) {
 		rt_mutex_dequeue_pi(owner, top_waiter);
 		rt_mutex_enqueue_pi(owner, waiter);
@@ -1348,7 +1391,7 @@ static int task_blocks_on_rt_mutex(struct rt_mutex *lock,
 	/* Store the lock on which owner is blocked or NULL */
 	next_lock = task_blocked_on_lock(owner);
 
-	raw_spin_unlock_irqrestore(&owner->pi_lock, flags);
+	raw_spin_unlock(&owner->pi_lock);
 	/*
 	 * Even if full deadlock detection is on, if the owner is not
 	 * blocked itself, we can avoid finding this out in the chain
@@ -1364,12 +1407,12 @@ static int task_blocks_on_rt_mutex(struct rt_mutex *lock,
 	 */
 	get_task_struct(owner);
 
-	raw_spin_unlock(&lock->wait_lock);
+	raw_spin_unlock_irq(&lock->wait_lock);
 
 	res = rt_mutex_adjust_prio_chain(owner, chwalk, lock,
 					 next_lock, waiter, task);
 
-	raw_spin_lock(&lock->wait_lock);
+	raw_spin_lock_irq(&lock->wait_lock);
 
 	return res;
 }
@@ -1378,16 +1421,15 @@ static int task_blocks_on_rt_mutex(struct rt_mutex *lock,
  * Remove the top waiter from the current tasks pi waiter tree and
  * queue it up.
  *
- * Called with lock->wait_lock held.
+ * Called with lock->wait_lock held and interrupts disabled.
  */
 static void mark_wakeup_next_waiter(struct wake_q_head *wake_q,
 				    struct wake_q_head *wake_sleeper_q,
 				    struct rt_mutex *lock)
 {
 	struct rt_mutex_waiter *waiter;
-	unsigned long flags;
 
-	raw_spin_lock_irqsave(&current->pi_lock, flags);
+	raw_spin_lock(&current->pi_lock);
 
 	waiter = rt_mutex_top_waiter(lock);
 
@@ -1409,7 +1451,7 @@ static void mark_wakeup_next_waiter(struct wake_q_head *wake_q,
 	 */
 	lock->owner = (void *) RT_MUTEX_HAS_WAITERS;
 
-	raw_spin_unlock_irqrestore(&current->pi_lock, flags);
+	raw_spin_unlock(&current->pi_lock);
 
 	if (waiter->savestate)
 		wake_q_add(wake_sleeper_q, waiter->task);
@@ -1420,7 +1462,7 @@ static void mark_wakeup_next_waiter(struct wake_q_head *wake_q,
 /*
  * Remove a waiter from a lock and give up
  *
- * Must be called with lock->wait_lock held and
+ * Must be called with lock->wait_lock held and interrupts disabled. I must
  * have just failed to try_to_take_rt_mutex().
  */
 static void remove_waiter(struct rt_mutex *lock,
@@ -1429,12 +1471,11 @@ static void remove_waiter(struct rt_mutex *lock,
 	bool is_top_waiter = (waiter == rt_mutex_top_waiter(lock));
 	struct task_struct *owner = rt_mutex_owner(lock);
 	struct rt_mutex *next_lock = NULL;
-	unsigned long flags;
 
-	raw_spin_lock_irqsave(&current->pi_lock, flags);
+	raw_spin_lock(&current->pi_lock);
 	rt_mutex_dequeue(lock, waiter);
 	current->pi_blocked_on = NULL;
-	raw_spin_unlock_irqrestore(&current->pi_lock, flags);
+	raw_spin_unlock(&current->pi_lock);
 
 	/*
 	 * Only update priority if the waiter was the highest priority
@@ -1443,7 +1484,7 @@ static void remove_waiter(struct rt_mutex *lock,
 	if (!owner || !is_top_waiter)
 		return;
 
-	raw_spin_lock_irqsave(&owner->pi_lock, flags);
+	raw_spin_lock(&owner->pi_lock);
 
 	rt_mutex_dequeue_pi(owner, waiter);
 
@@ -1456,7 +1497,7 @@ static void remove_waiter(struct rt_mutex *lock,
 	if (rt_mutex_real_waiter(owner->pi_blocked_on))
 		next_lock = task_blocked_on_lock(owner);
 
-	raw_spin_unlock_irqrestore(&owner->pi_lock, flags);
+	raw_spin_unlock(&owner->pi_lock);
 
 	/*
 	 * Don't walk the chain, if the owner task is not blocked
@@ -1468,12 +1509,12 @@ static void remove_waiter(struct rt_mutex *lock,
 	/* gets dropped in rt_mutex_adjust_prio_chain()! */
 	get_task_struct(owner);
 
-	raw_spin_unlock(&lock->wait_lock);
+	raw_spin_unlock_irq(&lock->wait_lock);
 
 	rt_mutex_adjust_prio_chain(owner, RT_MUTEX_MIN_CHAINWALK, lock,
 				   next_lock, NULL, current);
 
-	raw_spin_lock(&lock->wait_lock);
+	raw_spin_lock_irq(&lock->wait_lock);
 }
 
 /*
@@ -1509,11 +1550,11 @@ void rt_mutex_adjust_pi(struct task_struct *task)
  * __rt_mutex_slowlock() - Perform the wait-wake-try-to-take loop
  * @lock:		 the rt_mutex to take
  * @state:		 the state the task should block in (TASK_INTERRUPTIBLE
- * 			 or TASK_UNINTERRUPTIBLE)
+ *			 or TASK_UNINTERRUPTIBLE)
  * @timeout:		 the pre-initialized and started timer, or NULL for none
  * @waiter:		 the pre-initialized rt_mutex_waiter
  *
- * lock->wait_lock must be held by the caller.
+ * Must be called with lock->wait_lock held and interrupts disabled
  */
 static int __sched
 __rt_mutex_slowlock(struct rt_mutex *lock, int state,
@@ -1548,13 +1589,13 @@ __rt_mutex_slowlock(struct rt_mutex *lock, int state,
 				break;
 		}
 
-		raw_spin_unlock(&lock->wait_lock);
+		raw_spin_unlock_irq(&lock->wait_lock);
 
 		debug_rt_mutex_print_deadlock(waiter);
 
 		schedule();
 
-		raw_spin_lock(&lock->wait_lock);
+		raw_spin_lock_irq(&lock->wait_lock);
 		set_current_state(state);
 	}
 
@@ -1668,17 +1709,26 @@ rt_mutex_slowlock(struct rt_mutex *lock, int state,
 		  struct ww_acquire_ctx *ww_ctx)
 {
 	struct rt_mutex_waiter waiter;
+	unsigned long flags;
 	int ret = 0;
 
 	rt_mutex_init_waiter(&waiter, false);
 
-	raw_spin_lock(&lock->wait_lock);
+	/*
+	 * Technically we could use raw_spin_[un]lock_irq() here, but this can
+	 * be called in early boot if the cmpxchg() fast path is disabled
+	 * (debug, no architecture support). In this case we will acquire the
+	 * rtmutex with lock->wait_lock held. But we cannot unconditionally
+	 * enable interrupts in that early boot case. So we need to use the
+	 * irqsave/restore variants.
+	 */
+	raw_spin_lock_irqsave(&lock->wait_lock, flags);
 
 	/* Try to acquire the lock again: */
 	if (try_to_take_rt_mutex(lock, current, NULL)) {
 		if (ww_ctx)
 			ww_mutex_account_lock(lock, ww_ctx);
-		raw_spin_unlock(&lock->wait_lock);
+		raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 		return 0;
 	}
 
@@ -1717,7 +1767,7 @@ rt_mutex_slowlock(struct rt_mutex *lock, int state,
 	 */
 	fixup_rt_mutex_waiters(lock);
 
-	raw_spin_unlock(&lock->wait_lock);
+	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 
 	/* Remove pending timer: */
 	if (unlikely(timeout))
@@ -1733,6 +1783,7 @@ rt_mutex_slowlock(struct rt_mutex *lock, int state,
  */
 static inline int rt_mutex_slowtrylock(struct rt_mutex *lock)
 {
+	unsigned long flags;
 	int ret;
 
 	/*
@@ -1744,10 +1795,10 @@ static inline int rt_mutex_slowtrylock(struct rt_mutex *lock)
 		return 0;
 
 	/*
-	 * The mutex has currently no owner. Lock the wait lock and
-	 * try to acquire the lock.
+	 * The mutex has currently no owner. Lock the wait lock and try to
+	 * acquire the lock. We use irqsave here to support early boot calls.
 	 */
-	raw_spin_lock(&lock->wait_lock);
+	raw_spin_lock_irqsave(&lock->wait_lock, flags);
 
 	ret = try_to_take_rt_mutex(lock, current, NULL);
 
@@ -1757,7 +1808,7 @@ static inline int rt_mutex_slowtrylock(struct rt_mutex *lock)
 	 */
 	fixup_rt_mutex_waiters(lock);
 
-	raw_spin_unlock(&lock->wait_lock);
+	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 
 	return ret;
 }
@@ -1770,7 +1821,10 @@ static bool __sched rt_mutex_slowunlock(struct rt_mutex *lock,
 					struct wake_q_head *wake_q,
 					struct wake_q_head *wake_sleeper_q)
 {
-	raw_spin_lock(&lock->wait_lock);
+	unsigned long flags;
+
+	/* irqsave required to support early boot calls */
+	raw_spin_lock_irqsave(&lock->wait_lock, flags);
 
 	debug_rt_mutex_unlock(lock);
 
@@ -1809,10 +1863,10 @@ static bool __sched rt_mutex_slowunlock(struct rt_mutex *lock,
 	 */
 	while (!rt_mutex_has_waiters(lock)) {
 		/* Drops lock->wait_lock ! */
-		if (unlock_rt_mutex_safe(lock) == true)
+		if (unlock_rt_mutex_safe(lock, flags) == true)
 			return false;
 		/* Relock the rtmutex and try again */
-		raw_spin_lock(&lock->wait_lock);
+		raw_spin_lock_irqsave(&lock->wait_lock, flags);
 	}
 
 	/*
@@ -1823,7 +1877,7 @@ static bool __sched rt_mutex_slowunlock(struct rt_mutex *lock,
 	 */
 	mark_wakeup_next_waiter(wake_q, wake_sleeper_q, lock);
 
-	raw_spin_unlock(&lock->wait_lock);
+	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 
 	/* check PI boosting */
 	return true;
@@ -2135,10 +2189,10 @@ int rt_mutex_start_proxy_lock(struct rt_mutex *lock,
 {
 	int ret;
 
-	raw_spin_lock(&lock->wait_lock);
+	raw_spin_lock_irq(&lock->wait_lock);
 
 	if (try_to_take_rt_mutex(lock, task, NULL)) {
-		raw_spin_unlock(&lock->wait_lock);
+		raw_spin_unlock_irq(&lock->wait_lock);
 		return 1;
 	}
 
@@ -2161,14 +2215,14 @@ int rt_mutex_start_proxy_lock(struct rt_mutex *lock,
 	 * PI_REQUEUE_INPROGRESS, so that if the task is waking up
 	 * it will know that we are in the process of requeuing it.
 	 */
-	raw_spin_lock_irq(&task->pi_lock);
+	raw_spin_lock(&task->pi_lock);
 	if (task->pi_blocked_on) {
-		raw_spin_unlock_irq(&task->pi_lock);
-		raw_spin_unlock(&lock->wait_lock);
+		raw_spin_unlock(&task->pi_lock);
+		raw_spin_unlock_irq(&lock->wait_lock);
 		return -EAGAIN;
 	}
 	task->pi_blocked_on = PI_REQUEUE_INPROGRESS;
-	raw_spin_unlock_irq(&task->pi_lock);
+	raw_spin_unlock(&task->pi_lock);
 #endif
 
 	/* We enforce deadlock detection for futexes */
@@ -2188,7 +2242,7 @@ int rt_mutex_start_proxy_lock(struct rt_mutex *lock,
 	if (ret && rt_mutex_has_waiters(lock))
 		remove_waiter(lock, waiter);
 
-	raw_spin_unlock(&lock->wait_lock);
+	raw_spin_unlock_irq(&lock->wait_lock);
 
 	debug_rt_mutex_print_deadlock(waiter);
 
@@ -2236,7 +2290,7 @@ int rt_mutex_finish_proxy_lock(struct rt_mutex *lock,
 {
 	int ret;
 
-	raw_spin_lock(&lock->wait_lock);
+	raw_spin_lock_irq(&lock->wait_lock);
 
 	set_current_state(TASK_INTERRUPTIBLE);
 
@@ -2252,7 +2306,7 @@ int rt_mutex_finish_proxy_lock(struct rt_mutex *lock,
 	 */
 	fixup_rt_mutex_waiters(lock);
 
-	raw_spin_unlock(&lock->wait_lock);
+	raw_spin_unlock_irq(&lock->wait_lock);
 
 	return ret;
 }
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 5359091fecaa..64098d35de19 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -454,11 +454,13 @@ EXPORT_SYMBOL_GPL(rcu_batches_started_sched);
 /*
  * Return the number of RCU BH batches started thus far for debug & stats.
  */
+#ifndef CONFIG_PREEMPT_RT_FULL
 unsigned long rcu_batches_started_bh(void)
 {
 	return rcu_bh_state.gpnum;
 }
 EXPORT_SYMBOL_GPL(rcu_batches_started_bh);
+#endif
 
 /*
  * Return the number of RCU batches completed thus far for debug & stats.
@@ -563,9 +565,11 @@ void rcutorture_get_gp_data(enum rcutorture_type test_type, int *flags,
 	case RCU_FLAVOR:
 		rsp = rcu_state_p;
 		break;
+#ifndef CONFIG_PREEMPT_RT_FULL
 	case RCU_BH_FLAVOR:
 		rsp = &rcu_bh_state;
 		break;
+#endif
 	case RCU_SCHED_FLAVOR:
 		rsp = &rcu_sched_state;
 		break;
@@ -4695,7 +4699,9 @@ void __init rcu_init(void)
 
 	rcu_bootup_announce();
 	rcu_init_geometry();
+#ifndef CONFIG_PREEMPT_RT_FULL
 	rcu_init_one(&rcu_bh_state, &rcu_bh_data);
+#endif
 	rcu_init_one(&rcu_sched_state, &rcu_sched_data);
 	if (dump_tree)
 		rcu_dump_rcu_node_tree(&rcu_sched_state);
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 588509d94bbd..2ba8f6c2e81e 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -557,7 +557,9 @@ extern struct list_head rcu_struct_flavors;
  */
 extern struct rcu_state rcu_sched_state;
 
+#ifndef CONFIG_PREEMPT_RT_FULL
 extern struct rcu_state rcu_bh_state;
+#endif
 
 #ifdef CONFIG_PREEMPT_RCU
 extern struct rcu_state rcu_preempt_state;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1217926b500d..40c1e29416c0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3157,7 +3157,7 @@ void migrate_disable(void)
 {
 	struct task_struct *p = current;
 
-	if (in_atomic()) {
+	if (in_atomic() || irqs_disabled()) {
 #ifdef CONFIG_SCHED_DEBUG
 		p->migrate_disable_atomic++;
 #endif
@@ -3188,7 +3188,7 @@ void migrate_enable(void)
 {
 	struct task_struct *p = current;
 
-	if (in_atomic()) {
+	if (in_atomic() || irqs_disabled()) {
 #ifdef CONFIG_SCHED_DEBUG
 		p->migrate_disable_atomic--;
 #endif
diff --git a/kernel/softirq.c b/kernel/softirq.c
index d1e999e74d23..2ca63cc1469e 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -563,8 +563,10 @@ static void do_current_softirqs(void)
 			do_single_softirq(i);
 		}
 		softirq_clr_runner(i);
-		unlock_softirq(i);
 		WARN_ON(current->softirq_nestcnt != 1);
+		local_irq_enable();
+		unlock_softirq(i);
+		local_irq_disable();
 	}
 }
 
diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index 2c5acc882bad..f84d3b45cda7 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -30,7 +30,7 @@ struct cpu_stop_done {
 	atomic_t		nr_todo;	/* nr left to execute */
 	bool			executed;	/* actually executed? */
 	int			ret;		/* collected return value */
-	struct task_struct	*waiter;	/* woken when nr_todo reaches 0 */
+	struct completion	completion;	/* fired if nr_todo reaches 0 */
 };
 
 /* the actual stopper, one per every possible cpu, enabled on online cpus */
@@ -59,7 +59,7 @@ static void cpu_stop_init_done(struct cpu_stop_done *done, unsigned int nr_todo)
 {
 	memset(done, 0, sizeof(*done));
 	atomic_set(&done->nr_todo, nr_todo);
-	done->waiter = current;
+	init_completion(&done->completion);
 }
 
 /* signal completion unless @done is NULL */
@@ -68,10 +68,8 @@ static void cpu_stop_signal_done(struct cpu_stop_done *done, bool executed)
 	if (done) {
 		if (executed)
 			done->executed = true;
-		if (atomic_dec_and_test(&done->nr_todo)) {
-			wake_up_process(done->waiter);
-			done->waiter = NULL;
-		}
+		if (atomic_dec_and_test(&done->nr_todo))
+			complete(&done->completion);
 	}
 }
 
@@ -96,22 +94,6 @@ static void cpu_stop_queue_work(unsigned int cpu, struct cpu_stop_work *work)
 	raw_spin_unlock_irqrestore(&stopper->lock, flags);
 }
 
-static void wait_for_stop_done(struct cpu_stop_done *done)
-{
-	set_current_state(TASK_UNINTERRUPTIBLE);
-	while (atomic_read(&done->nr_todo)) {
-		schedule();
-		set_current_state(TASK_UNINTERRUPTIBLE);
-	}
-	/*
-	 * We need to wait until cpu_stop_signal_done() has cleared
-	 * done->waiter.
-	 */
-	while (done->waiter)
-		cpu_relax();
-	set_current_state(TASK_RUNNING);
-}
-
 /**
  * stop_one_cpu - stop a cpu
  * @cpu: cpu to stop
@@ -143,7 +125,7 @@ int stop_one_cpu(unsigned int cpu, cpu_stop_fn_t fn, void *arg)
 
 	cpu_stop_init_done(&done, 1);
 	cpu_stop_queue_work(cpu, &work);
-	wait_for_stop_done(&done);
+	wait_for_completion(&done.completion);
 	return done.executed ? done.ret : -ENOENT;
 }
 
@@ -302,7 +284,7 @@ int stop_two_cpus(unsigned int cpu1, unsigned int cpu2, cpu_stop_fn_t fn, void *
 
 	preempt_enable_nort();
 
-	wait_for_stop_done(&done);
+	wait_for_completion(&done.completion);
 
 	return done.executed ? done.ret : -ENOENT;
 }
@@ -364,7 +346,7 @@ static int __stop_cpus(const struct cpumask *cpumask,
 
 	cpu_stop_init_done(&done, cpumask_weight(cpumask));
 	queue_stop_cpus_work(cpumask, fn, arg, &done, false);
-	wait_for_stop_done(&done);
+	wait_for_completion(&done.completion);
 	return done.executed ? done.ret : -ENOENT;
 }
 
@@ -495,13 +477,7 @@ static void cpu_stopper_thread(unsigned int cpu)
 			  kallsyms_lookup((unsigned long)fn, NULL, NULL, NULL,
 					  ksym_buf), arg);
 
-		/*
-		 * Make sure that the wakeup and setting done->waiter
-		 * to NULL is atomic.
-		 */
-		local_irq_disable();
 		cpu_stop_signal_done(done, true);
-		local_irq_enable();
 		goto repeat;
 	}
 }
@@ -663,7 +639,7 @@ int stop_machine_from_inactive_cpu(cpu_stop_fn_t fn, void *data,
 	ret = multi_cpu_stop(&msdata);
 
 	/* Busy wait for completion. */
-	while (atomic_read(&done.nr_todo))
+	while (!completion_done(&done.completion))
 		cpu_relax();
 
 	mutex_unlock(&stop_cpus_mutex);
diff --git a/localversion-rt b/localversion-rt
index 0efe7ba1930e..8fc605d80667 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt5
+-rt6
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 7340353f8aea..b2ca2908b808 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -457,9 +457,9 @@ void wb_congested_put(struct bdi_writeback_congested *congested)
 {
 	unsigned long flags;
 
-	local_irq_save(flags);
+	local_irq_save_nort(flags);
 	if (!atomic_dec_and_lock(&congested->refcnt, &cgwb_lock)) {
-		local_irq_restore(flags);
+		local_irq_restore_nort(flags);
 		return;
 	}
 
