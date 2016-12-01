From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [ANNOUNCE] v4.8.11-rt7
Date: Thu, 1 Dec 2016 18:08:00 +0100
Message-ID: <20161201170800.lo4qbxa6o566ifxu@linutronix.de>
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

I'm pleased to announce the v4.8.11-rt7 patch set. 

Changes since v4.8.11-rt6:

  - A fix for a race in the futex/rtmutex code which was there since the
    very beginning. Reported by David Daney, fixed Thomas Gleixner

  - A fix for the kprobe code on ARM by Yang Shi.

  - It is no longer possible to force an expedited RCU grace period on
    -RT. We had one spot in the network where it was disabled on RT
    due to high latencies it caused. Suggested by Luiz Capitulino and
    patched by Julia Cartwright.

  - Expedited RCU grace periods are now forced during boot which should
    speed the boot process (even on -RT).

Known issues
	- CPU hotplug got a little better but can deadlock.

The delta patch against 4.8.11-rt6 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.8/incr/patch-4.8.11-rt6-rt7.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.8.11-rt7

The RT patch against 4.8.11 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.8/patch-4.8.11-rt7.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.8/patches-4.8.11-rt7.tar.xz

Sebastian

diff --git a/arch/arm/kernel/patch.c b/arch/arm/kernel/patch.c
index 69bda1a5707e..1f665acaa6a9 100644
--- a/arch/arm/kernel/patch.c
+++ b/arch/arm/kernel/patch.c
@@ -15,7 +15,7 @@ struct patch {
 	unsigned int insn;
 };
 
-static DEFINE_SPINLOCK(patch_lock);
+static DEFINE_RAW_SPINLOCK(patch_lock);
 
 static void __kprobes *patch_map(void *addr, int fixmap, unsigned long *flags)
 	__acquires(&patch_lock)
@@ -32,7 +32,7 @@ static void __kprobes *patch_map(void *addr, int fixmap, unsigned long *flags)
 		return addr;
 
 	if (flags)
-		spin_lock_irqsave(&patch_lock, *flags);
+		raw_spin_lock_irqsave(&patch_lock, *flags);
 	else
 		__acquire(&patch_lock);
 
@@ -47,7 +47,7 @@ static void __kprobes patch_unmap(int fixmap, unsigned long *flags)
 	clear_fixmap(fixmap);
 
 	if (flags)
-		spin_unlock_irqrestore(&patch_lock, *flags);
+		raw_spin_unlock_irqrestore(&patch_lock, *flags);
 	else
 		__release(&patch_lock);
 }
diff --git a/init/Kconfig b/init/Kconfig
index b6c9166d878a..fe51bd3bbc61 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -771,19 +771,6 @@ config RCU_NOCB_CPU_ALL
 
 endchoice
 
-config RCU_EXPEDITE_BOOT
-	bool
-	default n
-	help
-	  This option enables expedited grace periods at boot time,
-	  as if rcu_expedite_gp() had been invoked early in boot.
-	  The corresponding rcu_unexpedite_gp() is invoked from
-	  rcu_end_inkernel_boot(), which is intended to be invoked
-	  at the end of the kernel-only boot sequence, just before
-	  init is exec'ed.
-
-	  Accept the default if unsure.
-
 endmenu # "RCU Subsystem"
 
 config BUILD_BIN2C
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 2576f7ccf8e2..6f2ded470af1 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -71,8 +71,72 @@ static inline void clear_rt_mutex_waiters(struct rt_mutex *lock)
 
 static void fixup_rt_mutex_waiters(struct rt_mutex *lock)
 {
-	if (!rt_mutex_has_waiters(lock))
-		clear_rt_mutex_waiters(lock);
+	unsigned long owner, *p = (unsigned long *) &lock->owner;
+
+	if (rt_mutex_has_waiters(lock))
+		return;
+
+	/*
+	 * The rbtree has no waiters enqueued, now make sure that the
+	 * lock->owner still has the waiters bit set, otherwise the
+	 * following can happen:
+	 *
+	 * CPU 0	CPU 1		CPU2
+	 * l->owner=T1
+	 *		rt_mutex_lock(l)
+	 *		lock(l->lock)
+	 *		l->owner = T1 | HAS_WAITERS;
+	 *		enqueue(T2)
+	 *		boost()
+	 *		  unlock(l->lock)
+	 *		block()
+	 *
+	 *				rt_mutex_lock(l)
+	 *				lock(l->lock)
+	 *				l->owner = T1 | HAS_WAITERS;
+	 *				enqueue(T3)
+	 *				boost()
+	 *				  unlock(l->lock)
+	 *				block()
+	 *		signal(->T2)	signal(->T3)
+	 *		lock(l->lock)
+	 *		dequeue(T2)
+	 *		deboost()
+	 *		  unlock(l->lock)
+	 *				lock(l->lock)
+	 *				dequeue(T3)
+	 *				 ==> wait list is empty
+	 *				deboost()
+	 *				 unlock(l->lock)
+	 *		lock(l->lock)
+	 *		fixup_rt_mutex_waiters()
+	 *		  if (wait_list_empty(l) {
+	 *		    l->owner = owner
+	 *		    owner = l->owner & ~HAS_WAITERS;
+	 *		      ==> l->owner = T1
+	 *		  }
+	 *				lock(l->lock)
+	 * rt_mutex_unlock(l)		fixup_rt_mutex_waiters()
+	 *				  if (wait_list_empty(l) {
+	 *				    owner = l->owner & ~HAS_WAITERS;
+	 * cmpxchg(l->owner, T1, NULL)
+	 *  ===> Success (l->owner = NULL)
+	 *
+	 *				    l->owner = owner
+	 *				      ==> l->owner = T1
+	 *				  }
+	 *
+	 * With the check for the waiter bit in place T3 on CPU2 will not
+	 * overwrite. All tasks fiddling with the waiters bit are
+	 * serialized by l->lock, so nothing else can modify the waiters
+	 * bit. If the bit is set then nothing can change l->owner either
+	 * so the simple RMW is safe. The cmpxchg() will simply fail if it
+	 * happens in the middle of the RMW because the waiters bit is
+	 * still set.
+	 */
+	owner = READ_ONCE(*p);
+	if (owner & RT_MUTEX_HAS_WAITERS)
+		WRITE_ONCE(*p, owner & ~RT_MUTEX_HAS_WAITERS);
 }
 
 static int rt_mutex_real_waiter(struct rt_mutex_waiter *waiter)
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index b40d3468ba4e..2025ad12d241 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -63,7 +63,7 @@ MODULE_ALIAS("rcupdate");
 #ifndef CONFIG_TINY_RCU
 module_param(rcu_expedited, int, 0);
 module_param(rcu_normal, int, 0);
-static int rcu_normal_after_boot;
+static int rcu_normal_after_boot = IS_ENABLED(CONFIG_PREEMPT_RT_FULL);
 module_param(rcu_normal_after_boot, int, 0);
 #endif /* #ifndef CONFIG_TINY_RCU */
 
@@ -130,8 +130,7 @@ bool rcu_gp_is_normal(void)
 }
 EXPORT_SYMBOL_GPL(rcu_gp_is_normal);
 
-static atomic_t rcu_expedited_nesting =
-	ATOMIC_INIT(IS_ENABLED(CONFIG_RCU_EXPEDITE_BOOT) ? 1 : 0);
+static atomic_t rcu_expedited_nesting =	ATOMIC_INIT(1);
 
 /*
  * Should normal grace-period primitives be expedited?  Intended for
@@ -179,8 +178,7 @@ EXPORT_SYMBOL_GPL(rcu_unexpedite_gp);
  */
 void rcu_end_inkernel_boot(void)
 {
-	if (IS_ENABLED(CONFIG_RCU_EXPEDITE_BOOT))
-		rcu_unexpedite_gp();
+	rcu_unexpedite_gp();
 	if (rcu_normal_after_boot)
 		WRITE_ONCE(rcu_normal, 1);
 }
diff --git a/localversion-rt b/localversion-rt
index 8fc605d80667..045478966e9f 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt6
+-rt7
diff --git a/net/core/dev.c b/net/core/dev.c
index a35311052845..4ba0c36fc389 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -7766,7 +7766,7 @@ EXPORT_SYMBOL(free_netdev);
 void synchronize_net(void)
 {
 	might_sleep();
-	if (rtnl_is_locked() && !IS_ENABLED(CONFIG_PREEMPT_RT_FULL))
+	if (rtnl_is_locked())
 		synchronize_rcu_expedited();
 	else
 		synchronize_rcu();
