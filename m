Return-Path: <SRS0=gYFm=DC=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0E4C4727C
	for <linux-rt-users@archiver.kernel.org>; Fri, 25 Sep 2020 13:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 381582399C
	for <linux-rt-users@archiver.kernel.org>; Fri, 25 Sep 2020 13:22:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rwHM8xHE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D06AJMXn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbgIYNWx (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 25 Sep 2020 09:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728121AbgIYNWx (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 25 Sep 2020 09:22:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C85DC0613CE;
        Fri, 25 Sep 2020 06:22:53 -0700 (PDT)
Date:   Fri, 25 Sep 2020 15:22:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601040171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=ZE2wdtAQuckIJAkaAczc0viTwVOqJYvbT3PrzMKxrtU=;
        b=rwHM8xHECHcBnaP95I4OlGIZeADpL9ky03d9L4EAQrByk5Sq82+hYk21idJaGpG/dlRP+O
        oD+Fr4DkTrM0b8td9GYxSAA/zgRtZN3U25ADvMca81IO5bYdB5++uI4DfGlUMAFO0+x/kB
        DvQUJgsCc+ZfD0MyKrhAIJiWV6rdnOompz0CqwbrG0PfgUNXjwCO3Xb4Z/UjoxbVs1R3vZ
        Ks2Ev82Czh1c/y6njLf/R+isAwaKAjuZGmQf6LTFejxx4e1oIiXkSE4GnoCATTE/lxRRwP
        TiNjUEDo6YaBWP+yJBZ6NVCUMnpBfA/JNwhj9udfgijcnN5wkrZywf0+POzCHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601040171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=ZE2wdtAQuckIJAkaAczc0viTwVOqJYvbT3PrzMKxrtU=;
        b=D06AJMXnS+vEz8N27FaksR1Mgf6T/DmEymDjQtMUYNva0AIUq7cW2JfUdNFpdb5BWKHNlZ
        W1co8Mfhnyi3ptBg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.9-rc6-rt9
Message-ID: <20200925132250.hgi4wpyd2zxc6wxd@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.9-rc6-rt9 patch set. 

Changes since v5.9-rc6-rt8:

  - Correct the tracing header output and labels. Patch by Thomas
    Gleixner.

  - Rework the softirq code. The semantic remains unchanged. Rework by
    Thomas Gleixner.

Known issues
     - It has been pointed out that due to changes to the printk code the
       internal buffer representation changed. This is only an issue if tools
       like `crash' are used to extract the printk buffer from a kernel memory
       image.

The delta patch against v5.9-rc6-rt8 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.9/incr/patch-5.9-rc6-rt8-rt9.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.9-rc6-rt9

The RT patch against v5.9-rc6 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.9/older/patch-5.9-rc6-rt9.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.9/older/patches-5.9-rc6-rt9.tar.xz

Sebastian

diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
index 1786e4d9f70e8..7959a9c10e5a2 100644
--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -34,12 +34,18 @@ extern void kernel_fpu_resched(void);
 static inline void fpregs_lock(void)
 {
 	preempt_disable();
-	local_bh_disable();
+	/*
+	 * On RT disabling preemption is good enough because bottom halfs
+	 * are always running in thread context.
+	 */
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		local_bh_disable();
 }
 
 static inline void fpregs_unlock(void)
 {
-	local_bh_enable();
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		local_bh_enable();
 	preempt_enable();
 }
 
diff --git a/include/linux/bottom_half.h b/include/linux/bottom_half.h
index ef2366a65ba2a..eed86eb0a1dea 100644
--- a/include/linux/bottom_half.h
+++ b/include/linux/bottom_half.h
@@ -4,11 +4,7 @@
 
 #include <linux/preempt.h>
 
-#ifdef CONFIG_PREEMPT_RT
-extern void __local_bh_disable_ip(unsigned long ip, unsigned int cnt);
-#else
-
-#ifdef CONFIG_TRACE_IRQFLAGS
+#if defined(CONFIG_PREEMPT_RT) || defined(CONFIG_TRACE_IRQFLAGS)
 extern void __local_bh_disable_ip(unsigned long ip, unsigned int cnt);
 #else
 static __always_inline void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
@@ -17,7 +13,6 @@ static __always_inline void __local_bh_disable_ip(unsigned long ip, unsigned int
 	barrier();
 }
 #endif
-#endif
 
 static inline void local_bh_disable(void)
 {
@@ -37,4 +32,10 @@ static inline void local_bh_enable(void)
 	__local_bh_enable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
 }
 
+#ifdef CONFIG_PREEMPT_RT
+extern bool local_bh_blocked(void);
+#else
+static inline bool local_bh_blocked(void) { return false; }
+#endif
+
 #endif /* _LINUX_BH_H */
diff --git a/include/linux/hardirq.h b/include/linux/hardirq.h
index c35b71f8644aa..41408d5e40149 100644
--- a/include/linux/hardirq.h
+++ b/include/linux/hardirq.h
@@ -8,6 +8,7 @@
 #include <linux/ftrace_irq.h>
 #include <linux/vtime.h>
 #include <asm/hardirq.h>
+#include <linux/sched.h>
 
 extern void synchronize_irq(unsigned int irq);
 extern bool synchronize_hardirq(unsigned int irq);
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 332678fc03325..a490d9f801aac 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -575,7 +575,6 @@ extern void __raise_softirq_irqoff(unsigned int nr);
 
 extern void raise_softirq_irqoff(unsigned int nr);
 extern void raise_softirq(unsigned int nr);
-extern void softirq_check_pending_idle(void);
 
 DECLARE_PER_CPU(struct task_struct *, ksoftirqd);
 
@@ -655,7 +654,7 @@ enum
 	TASKLET_STATE_RUN	/* Tasklet is running (SMP only) */
 };
 
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT)
 static inline int tasklet_trylock(struct tasklet_struct *t)
 {
 	return !test_and_set_bit(TASKLET_STATE_RUN, &(t)->state);
@@ -666,18 +665,11 @@ static inline void tasklet_unlock(struct tasklet_struct *t)
 	smp_mb__before_atomic();
 	clear_bit(TASKLET_STATE_RUN, &(t)->state);
 }
-
-static inline void tasklet_unlock_wait(struct tasklet_struct *t)
-{
-	while (test_bit(TASKLET_STATE_RUN, &(t)->state)) {
-		local_bh_disable();
-		local_bh_enable();
-	}
-}
+void tasklet_unlock_wait(struct tasklet_struct *t);
 #else
-#define tasklet_trylock(t) 1
-#define tasklet_unlock_wait(t) do { } while (0)
-#define tasklet_unlock(t) do { } while (0)
+static inline int tasklet_trylock(struct tasklet_struct *t) { return 1; }
+static inline void tasklet_unlock(struct tasklet_struct *t) { }
+static inline void tasklet_unlock_wait(struct tasklet_struct *t) { }
 #endif
 
 extern void __tasklet_schedule(struct tasklet_struct *t);
diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index d8a401c3a1df3..c5594c63c160f 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -77,9 +77,15 @@
 /* preempt_count() and related functions, depends on PREEMPT_NEED_RESCHED */
 #include <asm/preempt.h>
 
-#define hardirq_count()	(preempt_count() & HARDIRQ_MASK)
-#define irq_count()	(preempt_count() & (HARDIRQ_MASK | SOFTIRQ_MASK \
-				 | NMI_MASK))
+#define pc_nmi_count()		(preempt_count() & NMI_MASK)
+#define hardirq_count()		(preempt_count() & HARDIRQ_MASK)
+#ifdef CONFIG_PREEMPT_RT
+# define softirq_count()	(current->softirq_disable_cnt & SOFTIRQ_MASK)
+#else
+# define softirq_count()	(preempt_count() & SOFTIRQ_MASK)
+#endif
+#define irq_count()		(pc_nmi_count() | hardirq_count() | softirq_count())
+
 /*
  * Are we doing bottom half or hardware interrupt processing?
  *
@@ -93,24 +99,12 @@
  * Note: due to the BH disabled confusion: in_softirq(),in_interrupt() really
  *       should not be used in new code.
  */
+#define in_nmi()		(pc_nmi_count())
 #define in_irq()		(hardirq_count())
 #define in_interrupt()		(irq_count())
-#define in_nmi()		(preempt_count() & NMI_MASK)
-#define in_task()		(!(preempt_count() & \
-				   (NMI_MASK | HARDIRQ_MASK | SOFTIRQ_OFFSET)))
-#ifdef CONFIG_PREEMPT_RT
-
-#define softirq_count()		((long)current->softirq_count)
-#define in_softirq()		(softirq_count())
-#define in_serving_softirq()	(current->softirq_count & SOFTIRQ_OFFSET)
-
-#else
-
-#define softirq_count()		(preempt_count() & SOFTIRQ_MASK)
 #define in_softirq()		(softirq_count())
 #define in_serving_softirq()	(softirq_count() & SOFTIRQ_OFFSET)
-
-#endif
+#define in_task()		(!(irq_count() & (NMI_MASK | HARDIRQ_MASK | SOFTIRQ_OFFSET)))
 
 /*
  * The preempt_count offset after preempt_disable();
diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 2b594bfb520dd..76d19f339419c 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -319,7 +319,7 @@ static inline void rcu_preempt_sleep_check(void) { }
 #define rcu_sleep_check()						\
 	do {								\
 		rcu_preempt_sleep_check();				\
-		if (!IS_ENABLED(CONFIG_PREEMPT_RT))		\
+		if (!IS_ENABLED(CONFIG_PREEMPT_RT))			\
 		    RCU_LOCKDEP_WARN(lock_is_held(&rcu_bh_lock_map),	\
 				 "Illegal context switch in RCU-bh read-side critical section"); \
 		RCU_LOCKDEP_WARN(lock_is_held(&rcu_sched_lock_map),	\
diff --git a/include/linux/rwlock_rt.h b/include/linux/rwlock_rt.h
index a9c4c2ac4d1fa..ebd3ed1903887 100644
--- a/include/linux/rwlock_rt.h
+++ b/include/linux/rwlock_rt.h
@@ -23,7 +23,6 @@ extern void __rt_rwlock_init(rwlock_t *rwlock, char *name, struct lock_class_key
 
 static inline int __write_trylock_rt_irqsave(rwlock_t *lock, unsigned long *flags)
 {
-	/* XXX ARCH_IRQ_ENABLED */
 	*flags = 0;
 	return rt_write_trylock(lock);
 }
@@ -106,14 +105,4 @@ do {							\
 	__rt_rwlock_init(rwl, #rwl, &__key);		\
 } while (0)
 
-/*
- * Internal functions made global for CPU pinning
- */
-void __read_rt_lock(struct rt_rw_lock *lock);
-int __read_rt_trylock(struct rt_rw_lock *lock);
-void __write_rt_lock(struct rt_rw_lock *lock);
-int __write_rt_trylock(struct rt_rw_lock *lock);
-void __read_rt_unlock(struct rt_rw_lock *lock);
-void __write_rt_unlock(struct rt_rw_lock *lock);
-
 #endif
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 2453d40af7065..c0fd9b458d82e 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1028,7 +1028,7 @@ struct task_struct {
 	int				irq_config;
 #endif
 #ifdef CONFIG_PREEMPT_RT
-	int				softirq_count;
+	int				softirq_disable_cnt;
 #endif
 
 #ifdef CONFIG_LOCKDEP
diff --git a/include/linux/spinlock_rt.h b/include/linux/spinlock_rt.h
index 50f6456c9fd24..060cbcba0d466 100644
--- a/include/linux/spinlock_rt.h
+++ b/include/linux/spinlock_rt.h
@@ -19,8 +19,8 @@ do {							\
 } while (0)
 
 extern void __lockfunc rt_spin_lock(spinlock_t *lock);
-extern unsigned long __lockfunc rt_spin_lock_trace_flags(spinlock_t *lock);
 extern void __lockfunc rt_spin_lock_nested(spinlock_t *lock, int subclass);
+extern void __lockfunc rt_spin_lock_nest_lock(spinlock_t *lock, struct lockdep_map *nest_lock);
 extern void __lockfunc rt_spin_unlock(spinlock_t *lock);
 extern void __lockfunc rt_spin_lock_unlock(spinlock_t *lock);
 extern int __lockfunc rt_spin_trylock_irqsave(spinlock_t *lock, unsigned long *flags);
@@ -68,6 +68,12 @@ extern void __lockfunc __rt_spin_unlock(struct rt_mutex *lock);
 		rt_spin_lock_nested(lock, subclass);	\
 	} while (0)
 
+# define spin_lock_nest_lock(lock, nest_lock)		\
+	do {                                                           \
+		typecheck(struct lockdep_map *, &(nest_lock)->dep_map);	\
+		rt_spin_lock_nest_lock(lock, &(nest_lock)->dep_map);	\
+	} while (0)
+
 # define spin_lock_irqsave_nested(lock, flags, subclass) \
 	do {						 \
 		typecheck(unsigned long, flags);	 \
@@ -76,6 +82,7 @@ extern void __lockfunc __rt_spin_unlock(struct rt_mutex *lock);
 	} while (0)
 #else
 # define spin_lock_nested(lock, subclass)	spin_lock(lock)
+# define spin_lock_nest_lock(lock, nest_lock)	spin_lock(lock)
 # define spin_lock_bh_nested(lock, subclass)	spin_lock_bh(lock)
 
 # define spin_lock_irqsave_nested(lock, flags, subclass) \
@@ -93,20 +100,6 @@ extern void __lockfunc __rt_spin_unlock(struct rt_mutex *lock);
 		spin_lock(lock);			 \
 	} while (0)
 
-static inline unsigned long spin_lock_trace_flags(spinlock_t *lock)
-{
-	unsigned long flags = 0;
-#ifdef CONFIG_TRACE_IRQFLAGS
-	flags = rt_spin_lock_trace_flags(lock);
-#else
-	spin_lock(lock); /* lock_local */
-#endif
-	return flags;
-}
-
-/* FIXME: we need rt_spin_lock_nest_lock */
-#define spin_lock_nest_lock(lock, nest_lock) spin_lock_nested(lock, 0)
-
 #define spin_unlock(lock)			rt_spin_unlock(lock)
 
 #define spin_unlock_bh(lock)				\
@@ -127,8 +120,15 @@ static inline unsigned long spin_lock_trace_flags(spinlock_t *lock)
 #define spin_trylock_bh(lock)	__cond_lock(lock, rt_spin_trylock_bh(lock))
 #define spin_trylock_irq(lock)	spin_trylock(lock)
 
-#define spin_trylock_irqsave(lock, flags)	\
-	rt_spin_trylock_irqsave(lock, &(flags))
+#define spin_trylock_irqsave(lock, flags)		\
+({							\
+	int __locked;					\
+							\
+	typecheck(unsigned long, flags);		\
+	flags = 0;					\
+	__locked = spin_trylock(lock);			\
+	__locked;					\
+})
 
 #ifdef CONFIG_GENERIC_LOCKBREAK
 # define spin_is_contended(lock)	((lock)->break_lock)
diff --git a/kernel/Kconfig.locks b/kernel/Kconfig.locks
index 3de8fd11873b4..4198f0273ecdc 100644
--- a/kernel/Kconfig.locks
+++ b/kernel/Kconfig.locks
@@ -251,7 +251,7 @@ config ARCH_USE_QUEUED_RWLOCKS
 
 config QUEUED_RWLOCKS
 	def_bool y if ARCH_USE_QUEUED_RWLOCKS
-	depends on SMP
+	depends on SMP && !PREEMPT_RT
 
 config ARCH_HAS_MMIOWB
 	bool
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 110c4cced672e..881e13ec97093 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1175,12 +1175,12 @@ static int irq_thread(void *data)
 		if (action_ret == IRQ_WAKE_THREAD)
 			irq_wake_secondary(desc, action);
 
-#ifdef CONFIG_PREEMPT_RT
-		migrate_disable();
-		add_interrupt_randomness(action->irq, 0,
+		if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
+			migrate_disable();
+			add_interrupt_randomness(action->irq, 0,
 				 desc->random_ip ^ (unsigned long) action);
-		migrate_enable();
-#endif
+			migrate_enable();
+		}
 		wake_threads_waitq(desc);
 	}
 
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index c13d28ff22e55..b870708af5810 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -4128,7 +4128,7 @@ static int check_wait_context(struct task_struct *curr, struct held_lock *next)
 	 */
 	for (depth = curr->lockdep_depth - 1; depth >= 0; depth--) {
 		struct held_lock *prev = curr->held_locks + depth;
-		if (prev->check && prev->irq_context != next->irq_context)
+		if (prev->irq_context != next->irq_context)
 			break;
 	}
 	depth++;
@@ -4139,9 +4139,6 @@ static int check_wait_context(struct task_struct *curr, struct held_lock *next)
 		struct held_lock *prev = curr->held_locks + depth;
 		short prev_inner = hlock_class(prev)->wait_type_inner;
 
-		if (!prev->check)
-			continue;
-
 		if (prev_inner) {
 			/*
 			 * We can have a bigger inner than a previous one
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index ddd0508b0237a..9ba766cd37edd 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1161,6 +1161,17 @@ void __lockfunc rt_spin_lock_nested(spinlock_t *lock, int subclass)
 	rt_spin_lock_fastlock(&lock->lock, rt_spin_lock_slowlock);
 }
 EXPORT_SYMBOL(rt_spin_lock_nested);
+
+void __lockfunc rt_spin_lock_nest_lock(spinlock_t *lock,
+				       struct lockdep_map *nest_lock)
+{
+	sleeping_lock_inc();
+	rcu_read_lock();
+	migrate_disable();
+	spin_acquire_nest(&lock->dep_map, 0, 0, nest_lock, _RET_IP_);
+	rt_spin_lock_fastlock(&lock->lock, rt_spin_lock_slowlock);
+}
+EXPORT_SYMBOL(rt_spin_lock_nest_lock);
 #endif
 
 void __lockfunc rt_spin_unlock(spinlock_t *lock)
@@ -1227,22 +1238,6 @@ int __lockfunc rt_spin_trylock_bh(spinlock_t *lock)
 }
 EXPORT_SYMBOL(rt_spin_trylock_bh);
 
-int __lockfunc rt_spin_trylock_irqsave(spinlock_t *lock, unsigned long *flags)
-{
-	int ret;
-
-	*flags = 0;
-	ret = __rt_mutex_trylock(&lock->lock);
-	if (ret) {
-		sleeping_lock_inc();
-		rcu_read_lock();
-		migrate_disable();
-		spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
-	}
-	return ret;
-}
-EXPORT_SYMBOL(rt_spin_trylock_irqsave);
-
 void
 __rt_spin_lock_init(spinlock_t *lock, const char *name, struct lock_class_key *key)
 {
diff --git a/kernel/locking/rwlock-rt.c b/kernel/locking/rwlock-rt.c
index 3ccfbc432942d..2faa9bf62e145 100644
--- a/kernel/locking/rwlock-rt.c
+++ b/kernel/locking/rwlock-rt.c
@@ -79,7 +79,7 @@ int __read_rt_trylock(struct rt_rw_lock *lock)
 	return 0;
 }
 
-void __sched __read_rt_lock(struct rt_rw_lock *lock)
+static void __read_rt_lock(struct rt_rw_lock *lock)
 {
 	struct rt_mutex *m = &lock->rtmutex;
 	struct rt_mutex_waiter waiter;
@@ -142,7 +142,7 @@ void __sched __read_rt_lock(struct rt_rw_lock *lock)
 	debug_rt_mutex_free_waiter(&waiter);
 }
 
-void __read_rt_unlock(struct rt_rw_lock *lock)
+static void __read_rt_unlock(struct rt_rw_lock *lock)
 {
 	struct rt_mutex *m = &lock->rtmutex;
 	struct task_struct *tsk;
@@ -178,7 +178,7 @@ static void __write_unlock_common(struct rt_rw_lock *lock, int bias,
 	rt_spin_lock_slowunlock(m);
 }
 
-void __sched __write_rt_lock(struct rt_rw_lock *lock)
+static void __write_rt_lock(struct rt_rw_lock *lock)
 {
 	struct rt_mutex *m = &lock->rtmutex;
 	struct task_struct *self = current;
@@ -222,7 +222,7 @@ void __sched __write_rt_lock(struct rt_rw_lock *lock)
 	}
 }
 
-int __write_rt_trylock(struct rt_rw_lock *lock)
+static int __write_rt_trylock(struct rt_rw_lock *lock)
 {
 	struct rt_mutex *m = &lock->rtmutex;
 	unsigned long flags;
@@ -242,7 +242,7 @@ int __write_rt_trylock(struct rt_rw_lock *lock)
 	return 0;
 }
 
-void __write_rt_unlock(struct rt_rw_lock *lock)
+static void __write_rt_unlock(struct rt_rw_lock *lock)
 {
 	struct rt_mutex *m = &lock->rtmutex;
 	unsigned long flags;
@@ -251,43 +251,6 @@ void __write_rt_unlock(struct rt_rw_lock *lock)
 	__write_unlock_common(lock, WRITER_BIAS, flags);
 }
 
-/* Map the reader biased implementation */
-static inline int do_read_rt_trylock(rwlock_t *rwlock)
-{
-	return __read_rt_trylock(rwlock);
-}
-
-static inline int do_write_rt_trylock(rwlock_t *rwlock)
-{
-	return __write_rt_trylock(rwlock);
-}
-
-static inline void do_read_rt_lock(rwlock_t *rwlock)
-{
-	__read_rt_lock(rwlock);
-}
-
-static inline void do_write_rt_lock(rwlock_t *rwlock)
-{
-	__write_rt_lock(rwlock);
-}
-
-static inline void do_read_rt_unlock(rwlock_t *rwlock)
-{
-	__read_rt_unlock(rwlock);
-}
-
-static inline void do_write_rt_unlock(rwlock_t *rwlock)
-{
-	__write_rt_unlock(rwlock);
-}
-
-static inline void do_rwlock_rt_init(rwlock_t *rwlock, const char *name,
-				     struct lock_class_key *key)
-{
-	__rwlock_biased_rt_init(rwlock, name, key);
-}
-
 int __lockfunc rt_read_can_lock(rwlock_t *rwlock)
 {
 	return  atomic_read(&rwlock->readers) < 0;
@@ -307,7 +270,7 @@ int __lockfunc rt_read_trylock(rwlock_t *rwlock)
 
 	sleeping_lock_inc();
 	migrate_disable();
-	ret = do_read_rt_trylock(rwlock);
+	ret = __read_rt_trylock(rwlock);
 	if (ret) {
 		rwlock_acquire_read(&rwlock->dep_map, 0, 1, _RET_IP_);
 		rcu_read_lock();
@@ -325,7 +288,7 @@ int __lockfunc rt_write_trylock(rwlock_t *rwlock)
 
 	sleeping_lock_inc();
 	migrate_disable();
-	ret = do_write_rt_trylock(rwlock);
+	ret = __write_rt_trylock(rwlock);
 	if (ret) {
 		rwlock_acquire(&rwlock->dep_map, 0, 1, _RET_IP_);
 		rcu_read_lock();
@@ -343,7 +306,7 @@ void __lockfunc rt_read_lock(rwlock_t *rwlock)
 	rcu_read_lock();
 	migrate_disable();
 	rwlock_acquire_read(&rwlock->dep_map, 0, 0, _RET_IP_);
-	do_read_rt_lock(rwlock);
+	__read_rt_lock(rwlock);
 }
 EXPORT_SYMBOL(rt_read_lock);
 
@@ -353,14 +316,14 @@ void __lockfunc rt_write_lock(rwlock_t *rwlock)
 	rcu_read_lock();
 	migrate_disable();
 	rwlock_acquire(&rwlock->dep_map, 0, 0, _RET_IP_);
-	do_write_rt_lock(rwlock);
+	__write_rt_lock(rwlock);
 }
 EXPORT_SYMBOL(rt_write_lock);
 
 void __lockfunc rt_read_unlock(rwlock_t *rwlock)
 {
 	rwlock_release(&rwlock->dep_map, _RET_IP_);
-	do_read_rt_unlock(rwlock);
+	__read_rt_unlock(rwlock);
 	migrate_enable();
 	rcu_read_unlock();
 	sleeping_lock_dec();
@@ -370,7 +333,7 @@ EXPORT_SYMBOL(rt_read_unlock);
 void __lockfunc rt_write_unlock(rwlock_t *rwlock)
 {
 	rwlock_release(&rwlock->dep_map, _RET_IP_);
-	do_write_rt_unlock(rwlock);
+	__write_rt_unlock(rwlock);
 	migrate_enable();
 	rcu_read_unlock();
 	sleeping_lock_dec();
@@ -379,6 +342,6 @@ EXPORT_SYMBOL(rt_write_unlock);
 
 void __rt_rwlock_init(rwlock_t *rwlock, char *name, struct lock_class_key *key)
 {
-	do_rwlock_rt_init(rwlock, name, key);
+	__rwlock_biased_rt_init(rwlock, name, key);
 }
 EXPORT_SYMBOL(__rt_rwlock_init);
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 5cbadfe313c39..102f5553884c5 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -13,6 +13,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
+#include <linux/local_lock.h>
 #include <linux/mm.h>
 #include <linux/notifier.h>
 #include <linux/percpu.h>
@@ -25,9 +26,6 @@
 #include <linux/smpboot.h>
 #include <linux/tick.h>
 #include <linux/irq.h>
-#ifdef CONFIG_PREEMPT_RT
-#include <linux/local_lock.h>
-#endif
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/irq.h>
@@ -96,128 +94,224 @@ static bool ksoftirqd_running(unsigned long pending)
 }
 
 #ifdef CONFIG_TRACE_IRQFLAGS
-
 DEFINE_PER_CPU(int, hardirqs_enabled);
 DEFINE_PER_CPU(int, hardirq_context);
 EXPORT_PER_CPU_SYMBOL_GPL(hardirqs_enabled);
 EXPORT_PER_CPU_SYMBOL_GPL(hardirq_context);
-
 #endif
 
 /*
- * preempt_count and SOFTIRQ_OFFSET usage:
- * - preempt_count is changed by SOFTIRQ_OFFSET on entering or leaving
- *   softirq processing.
- * - preempt_count is changed by SOFTIRQ_DISABLE_OFFSET (= 2 * SOFTIRQ_OFFSET)
+ * SOFTIRQ_OFFSET usage:
+ *
+ * On !RT kernels 'count' is the preempt counter, on RT kernels this applies
+ * to a per CPU counter and to task::softirqs_disabled_cnt.
+ *
+ * - count is changed by SOFTIRQ_OFFSET on entering or leaving softirq
+ *   processing.
+ *
+ * - count is changed by SOFTIRQ_DISABLE_OFFSET (= 2 * SOFTIRQ_OFFSET)
  *   on local_bh_disable or local_bh_enable.
+ *
  * This lets us distinguish between whether we are currently processing
  * softirq and whether we just have bh disabled.
  */
 #ifdef CONFIG_PREEMPT_RT
 
-struct bh_lock {
-	local_lock_t l;
+/*
+ * RT accounts for BH disabled sections in task::softirqs_disabled_cnt and
+ * also in per CPU softirq_ctrl::cnt. This is necessary to allow tasks in a
+ * softirq disabled section to be preempted.
+ *
+ * The per task counter is used for softirq_count(), in_softirq() and
+ * in_serving_softirqs() because these counts are only valid when the task
+ * holding softirq_ctrl::lock is running.
+ *
+ * The per CPU counter prevents pointless wakeups of ksoftirqd in case that
+ * the task which is in a softirq disabled section is preempted or blocks.
+ */
+struct softirq_ctrl {
+	local_lock_t	lock;
+	int		cnt;
 };
 
-static DEFINE_PER_CPU(struct bh_lock, bh_lock) = {
-	.l      = INIT_LOCAL_LOCK(l),
+static DEFINE_PER_CPU(struct softirq_ctrl, softirq_ctrl) = {
+	.lock	= INIT_LOCAL_LOCK(softirq_ctrl.lock),
 };
 
-static DEFINE_PER_CPU(long, softirq_counter);
+/**
+ * local_bh_blocked() - Check for idle whether BH processing is blocked
+ *
+ * Returns false if the per CPU softirq::cnt is 0 otherwise true.
+ *
+ * This is invoked from the idle task to guard against false positive
+ * softirq pending warnings, which would happen when the task which holds
+ * softirq_ctrl::lock was the only running task on the CPU and blocks on
+ * some other lock.
+ */
+bool local_bh_blocked(void)
+{
+	return this_cpu_read(softirq_ctrl.cnt) != 0;
+}
 
 void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
 {
-	unsigned long __maybe_unused flags;
-	long soft_cnt;
+	unsigned long flags;
+	int newcnt;
 
 	WARN_ON_ONCE(in_irq());
-	if (!in_atomic()) {
-		local_lock(&bh_lock.l);
-		rcu_read_lock();
-	}
-	soft_cnt = this_cpu_inc_return(softirq_counter);
-	WARN_ON_ONCE(soft_cnt == 0);
-	current->softirq_count += SOFTIRQ_DISABLE_OFFSET;
 
-#ifdef CONFIG_TRACE_IRQFLAGS
-	local_irq_save(flags);
-	if (soft_cnt == 1)
+	/* First entry of a task into a BH disabled section? */
+	if (!current->softirq_disable_cnt) {
+		if (preemptible()) {
+			local_lock(&softirq_ctrl.lock);
+			rcu_read_lock();
+		} else {
+			DEBUG_LOCKS_WARN_ON(this_cpu_read(softirq_ctrl.cnt));
+		}
+	}
+
+	preempt_disable();
+	/*
+	 * Track the per CPU softirq disabled state. On RT this is per CPU
+	 * state to allow preemption of bottom half disabled sections.
+	 */
+	newcnt = this_cpu_add_return(softirq_ctrl.cnt, cnt);
+	/*
+	 * Reflect the result in the task state to prevent recursion on the
+	 * local lock and to make softirq_count() & al work.
+	 */
+	current->softirq_disable_cnt = newcnt;
+
+	if (IS_ENABLED(CONFIG_TRACE_IRQFLAGS) && newcnt == cnt) {
+		raw_local_irq_save(flags);
 		lockdep_softirqs_off(ip);
-	local_irq_restore(flags);
-#endif
+		raw_local_irq_restore(flags);
+	}
+	preempt_enable();
 }
 EXPORT_SYMBOL(__local_bh_disable_ip);
 
-static void local_bh_disable_rt(void)
+static void __local_bh_enable(unsigned int cnt, bool unlock)
 {
-	local_bh_disable();
-}
+	unsigned long flags;
+	int newcnt;
 
-void _local_bh_enable(void)
-{
-	unsigned long __maybe_unused flags;
-	long soft_cnt;
+	DEBUG_LOCKS_WARN_ON(current->softirq_disable_cnt !=
+			    this_cpu_read(softirq_ctrl.cnt));
 
-	soft_cnt = this_cpu_dec_return(softirq_counter);
-	WARN_ON_ONCE(soft_cnt < 0);
-
-#ifdef CONFIG_TRACE_IRQFLAGS
-	local_irq_save(flags);
-	if (soft_cnt == 0)
+	preempt_disable();
+	if (IS_ENABLED(CONFIG_TRACE_IRQFLAGS) && softirq_count() == cnt) {
+		raw_local_irq_save(flags);
 		lockdep_softirqs_on(_RET_IP_);
-	local_irq_restore(flags);
-#endif
-
-	current->softirq_count -= SOFTIRQ_DISABLE_OFFSET;
-	if (!in_atomic()) {
-		rcu_read_unlock();
-		local_unlock(&bh_lock.l);
+		raw_local_irq_restore(flags);
 	}
-}
 
-void _local_bh_enable_rt(void)
-{
-	_local_bh_enable();
+	newcnt = this_cpu_sub_return(softirq_ctrl.cnt, cnt);
+	current->softirq_disable_cnt = newcnt;
+	preempt_enable();
+
+	if (!newcnt && unlock) {
+		rcu_read_unlock();
+		local_unlock(&softirq_ctrl.lock);
+	}
 }
 
 void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
 {
+	bool preempt_on = preemptible();
+	unsigned long flags;
 	u32 pending;
-	long count;
+	int curcnt;
 
 	WARN_ON_ONCE(in_irq());
 	lockdep_assert_irqs_enabled();
 
-	local_irq_disable();
-	count = this_cpu_read(softirq_counter);
+	local_irq_save(flags);
+	curcnt = this_cpu_read(softirq_ctrl.cnt);
 
-	if (unlikely(count == 1)) {
-		pending = local_softirq_pending();
-		if (pending && !ksoftirqd_running(pending)) {
-			if (!in_atomic())
-				__do_softirq();
-			else
-				wakeup_softirqd();
-		}
-		lockdep_softirqs_on(ip);
-	}
-	count = this_cpu_dec_return(softirq_counter);
-	WARN_ON_ONCE(count < 0);
-	local_irq_enable();
+	/*
+	 * If this is not reenabling soft interrupts, no point in trying to
+	 * run pending ones.
+	 */
+	if (curcnt != cnt)
+		goto out;
 
-	if (!in_atomic()) {
-		rcu_read_unlock();
-		local_unlock(&bh_lock.l);
+	pending = local_softirq_pending();
+	if (!pending || ksoftirqd_running(pending))
+		goto out;
+
+	/*
+	 * If this was called from non preemptible context, wake up the
+	 * softirq daemon.
+	 */
+	if (!preempt_on) {
+		wakeup_softirqd();
+		goto out;
 	}
 
-	current->softirq_count -= SOFTIRQ_DISABLE_OFFSET;
-	preempt_check_resched();
+	/*
+	 * Adjust softirq count to SOFTIRQ_OFFSET which makes
+	 * in_serving_softirq() become true.
+	 */
+	cnt = SOFTIRQ_OFFSET;
+	__local_bh_enable(cnt, false);
+	__do_softirq();
+
+out:
+	__local_bh_enable(cnt, preempt_on);
+	local_irq_restore(flags);
 }
 EXPORT_SYMBOL(__local_bh_enable_ip);
 
-#else
-static void local_bh_disable_rt(void) { }
-static void _local_bh_enable_rt(void) { }
+/*
+ * Invoked from irq_enter_rcu() to prevent that tick_irq_enter()
+ * pointlessly wakes the softirq daemon. That's handled in __irq_exit_rcu().
+ * None of the above logic in the regular bh_disable/enable functions is
+ * required here.
+ */
+static inline void local_bh_disable_irq_enter(void)
+{
+	this_cpu_add(softirq_ctrl.cnt, SOFTIRQ_DISABLE_OFFSET);
+}
+
+static inline void local_bh_enable_irq_enter(void)
+{
+	this_cpu_sub(softirq_ctrl.cnt, SOFTIRQ_DISABLE_OFFSET);
+}
+
+/*
+ * Invoked from ksoftirqd_run() outside of the interrupt disabled section
+ * to acquire the per CPU local lock for reentrancy protection.
+ */
+static inline void ksoftirqd_run_begin(void)
+{
+	__local_bh_disable_ip(_RET_IP_, SOFTIRQ_OFFSET);
+	local_irq_disable();
+}
+
+/* Counterpart to ksoftirqd_run_begin() */
+static inline void ksoftirqd_run_end(void)
+{
+	__local_bh_enable(SOFTIRQ_OFFSET, true);
+	WARN_ON_ONCE(in_interrupt());
+	local_irq_enable();
+}
+
+static inline void softirq_handle_begin(void) { }
+static inline void softirq_handle_end(void) { }
+
+static inline void invoke_softirq(void)
+{
+	if (!this_cpu_read(softirq_ctrl.cnt))
+		wakeup_softirqd();
+}
+
+static inline bool should_wake_ksoftirqd(void)
+{
+	return !this_cpu_read(softirq_ctrl.cnt);
+}
+
+#else /* CONFIG_PREEMPT_RT */
 
 /*
  * This one is for softirq.c-internal use,
@@ -314,7 +408,67 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
 	preempt_check_resched();
 }
 EXPORT_SYMBOL(__local_bh_enable_ip);
+
+static inline void local_bh_disable_irq_enter(void)
+{
+	local_bh_disable();
+}
+
+static inline void local_bh_enable_irq_enter(void)
+{
+	_local_bh_enable();
+}
+
+static inline void softirq_handle_begin(void)
+{
+	__local_bh_disable_ip(_RET_IP_, SOFTIRQ_OFFSET);
+}
+
+static inline void softirq_handle_end(void)
+{
+	__local_bh_enable(SOFTIRQ_OFFSET);
+	WARN_ON_ONCE(in_interrupt());
+}
+
+static inline void ksoftirqd_run_begin(void)
+{
+	local_irq_disable();
+}
+
+static inline void ksoftirqd_run_end(void)
+{
+	local_irq_enable();
+}
+
+static inline void invoke_softirq(void)
+{
+	if (ksoftirqd_running(local_softirq_pending()))
+		return;
+
+	if (!force_irqthreads) {
+#ifdef CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK
+		/*
+		 * We can safely execute softirq on the current stack if
+		 * it is the irq stack, because it should be near empty
+		 * at this stage.
+		 */
+		__do_softirq();
+#else
+		/*
+		 * Otherwise, irq_exit() is called on the task stack that can
+		 * be potentially deep already. So call softirq in its own stack
+		 * to prevent from any overrun.
+		 */
+		do_softirq_own_stack();
 #endif
+	} else {
+		wakeup_softirqd();
+	}
+}
+
+static inline bool should_wake_ksoftirqd(void) { return true; }
+
+#endif /* !CONFIG_PREEMPT_RT */
 
 /*
  * We restart softirq processing for at most MAX_SOFTIRQ_RESTART times,
@@ -385,11 +539,7 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 	pending = local_softirq_pending();
 	account_irq_enter_time(current);
 
-#ifdef CONFIG_PREEMPT_RT
-	current->softirq_count |= SOFTIRQ_OFFSET;
-#else
-	__local_bh_disable_ip(_RET_IP_, SOFTIRQ_OFFSET);
-#endif
+	softirq_handle_begin();
 	in_hardirq = lockdep_softirq_start();
 
 restart:
@@ -423,10 +573,11 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 		h++;
 		pending >>= softirq_bit;
 	}
-#ifndef CONFIG_PREEMPT_RT
-	if (__this_cpu_read(ksoftirqd) == current)
+
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT) &&
+	    __this_cpu_read(ksoftirqd) == current)
 		rcu_softirq_qs();
-#endif
+
 	local_irq_disable();
 
 	pending = local_softirq_pending();
@@ -440,12 +591,7 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 
 	lockdep_softirq_end(in_hardirq);
 	account_irq_exit_time(current);
-#ifdef CONFIG_PREEMPT_RT
-	current->softirq_count &= ~SOFTIRQ_OFFSET;
-#else
-	__local_bh_enable(SOFTIRQ_OFFSET);
-#endif
-	WARN_ON_ONCE(in_interrupt());
+	softirq_handle_end();
 	current_restore_flags(old_flags, PF_MEMALLOC);
 }
 
@@ -479,9 +625,9 @@ void irq_enter_rcu(void)
 		 * Prevent raise_softirq from needlessly waking up ksoftirqd
 		 * here, as softirq will be serviced on return from interrupt.
 		 */
-		local_bh_disable();
+		local_bh_disable_irq_enter();
 		tick_irq_enter();
-		_local_bh_enable();
+		local_bh_enable_irq_enter();
 	}
 	__irq_enter();
 }
@@ -495,43 +641,6 @@ void irq_enter(void)
 	irq_enter_rcu();
 }
 
-#ifdef CONFIG_PREEMPT_RT
-
-static inline void invoke_softirq(void)
-{
-	if (this_cpu_read(softirq_counter) == 0)
-		wakeup_softirqd();
-}
-
-#else
-
-static inline void invoke_softirq(void)
-{
-	if (ksoftirqd_running(local_softirq_pending()))
-		return;
-
-	if (!force_irqthreads) {
-#ifdef CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK
-		/*
-		 * We can safely execute softirq on the current stack if
-		 * it is the irq stack, because it should be near empty
-		 * at this stage.
-		 */
-		__do_softirq();
-#else
-		/*
-		 * Otherwise, irq_exit() is called on the task stack that can
-		 * be potentially deep already. So call softirq in its own stack
-		 * to prevent from any overrun.
-		 */
-		do_softirq_own_stack();
-#endif
-	} else {
-		wakeup_softirqd();
-	}
-}
-#endif
-
 static inline void tick_irq_exit(void)
 {
 #ifdef CONFIG_NO_HZ_COMMON
@@ -588,27 +697,6 @@ void irq_exit(void)
 /*
  * This function must run with irqs disabled!
  */
-#ifdef CONFIG_PREEMPT_RT
-void raise_softirq_irqoff(unsigned int nr)
-{
-	__raise_softirq_irqoff(nr);
-
-	/*
-	 * If we're in an hard interrupt we let irq return code deal
-	 * with the wakeup of ksoftirqd.
-	 */
-	if (in_irq())
-		return;
-	/*
-	 * If were are not in BH-disabled section then we have to wake
-	 * ksoftirqd.
-	 */
-	if (this_cpu_read(softirq_counter) == 0)
-		wakeup_softirqd();
-}
-
-#else
-
 inline void raise_softirq_irqoff(unsigned int nr)
 {
 	__raise_softirq_irqoff(nr);
@@ -622,12 +710,10 @@ inline void raise_softirq_irqoff(unsigned int nr)
 	 * Otherwise we wake up ksoftirqd to make sure we
 	 * schedule the softirq soon.
 	 */
-	if (!in_interrupt())
+	if (!in_interrupt() && should_wake_ksoftirqd())
 		wakeup_softirqd();
 }
 
-#endif
-
 void raise_softirq(unsigned int nr)
 {
 	unsigned long flags;
@@ -764,6 +850,29 @@ void tasklet_init(struct tasklet_struct *t,
 }
 EXPORT_SYMBOL(tasklet_init);
 
+#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT)
+
+void tasklet_unlock_wait(struct tasklet_struct *t)
+{
+	while (test_bit(TASKLET_STATE_RUN, &(t)->state)) {
+		if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
+			/*
+			 * Prevent a live lock when current preempted soft
+			 * interrupt processing or prevents ksoftirqd from
+			 * running. If the tasklet runs on a different CPU
+			 * then this has no effect other than doing the BH
+			 * disable/enable dance for nothing.
+			 */
+			local_bh_disable();
+			local_bh_enable();
+		} else {
+			cpu_relax();
+		}
+	}
+}
+EXPORT_SYMBOL(tasklet_unlock_wait);
+#endif
+
 void tasklet_kill(struct tasklet_struct *t)
 {
 	if (in_interrupt())
@@ -771,8 +880,20 @@ void tasklet_kill(struct tasklet_struct *t)
 
 	while (test_and_set_bit(TASKLET_STATE_SCHED, &t->state)) {
 		do {
-			local_bh_disable();
-			local_bh_enable();
+			if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
+				/*
+				 * Prevent a live lock when current
+				 * preempted soft interrupt processing or
+				 * prevents ksoftirqd from running. If the
+				 * tasklet runs on a different CPU then
+				 * this has no effect other than doing the
+				 * BH disable/enable dance for nothing.
+				 */
+				local_bh_disable();
+				local_bh_enable();
+			} else {
+				yield();
+			}
 		} while (test_bit(TASKLET_STATE_SCHED, &t->state));
 	}
 	tasklet_unlock_wait(t);
@@ -802,21 +923,18 @@ static int ksoftirqd_should_run(unsigned int cpu)
 
 static void run_ksoftirqd(unsigned int cpu)
 {
-	local_bh_disable_rt();
-	local_irq_disable();
+	ksoftirqd_run_begin();
 	if (local_softirq_pending()) {
 		/*
 		 * We can safely run softirq on inline stack, as we are not deep
 		 * in the task stack here.
 		 */
 		__do_softirq();
-		local_irq_enable();
-		_local_bh_enable_rt();
+		ksoftirqd_run_end();
 		cond_resched();
 		return;
 	}
-	local_irq_enable();
-	_local_bh_enable_rt();
+	ksoftirqd_run_end();
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
@@ -890,13 +1008,6 @@ static struct smp_hotplug_thread softirq_threads = {
 
 static __init int spawn_ksoftirqd(void)
 {
-#ifdef CONFIG_PREEMPT_RT
-	int cpu;
-
-	for_each_possible_cpu(cpu)
-		lockdep_set_novalidate_class(per_cpu_ptr(&bh_lock.l.lock, cpu));
-#endif
-
 	cpuhp_setup_state_nocalls(CPUHP_SOFTIRQ_DEAD, "softirq:dead", NULL,
 				  takeover_tasklets);
 	BUG_ON(smpboot_register_percpu_thread(&softirq_threads));
@@ -905,75 +1016,6 @@ static __init int spawn_ksoftirqd(void)
 }
 early_initcall(spawn_ksoftirqd);
 
-#ifdef CONFIG_PREEMPT_RT
-
-/*
- * On preempt-rt a softirq running context might be blocked on a
- * lock. There might be no other runnable task on this CPU because the
- * lock owner runs on some other CPU. So we have to go into idle with
- * the pending bit set. Therefor we need to check this otherwise we
- * warn about false positives which confuses users and defeats the
- * whole purpose of this test.
- *
- * This code is called with interrupts disabled.
- */
-void softirq_check_pending_idle(void)
-{
-	struct task_struct *tsk = __this_cpu_read(ksoftirqd);
-	static int rate_limit;
-	bool okay = false;
-	u32 warnpending;
-
-	if (rate_limit >= 10)
-		return;
-
-	warnpending = local_softirq_pending() & SOFTIRQ_STOP_IDLE_MASK;
-	if (!warnpending)
-		return;
-
-	if (!tsk)
-		return;
-	/*
-	 * If ksoftirqd is blocked on a lock then we may go idle with pending
-	 * softirq.
-	 */
-	raw_spin_lock(&tsk->pi_lock);
-	if (tsk->pi_blocked_on || tsk->state == TASK_RUNNING ||
-	    (tsk->state == TASK_UNINTERRUPTIBLE && tsk->sleeping_lock)) {
-		okay = true;
-	}
-	raw_spin_unlock(&tsk->pi_lock);
-	if (okay)
-		return;
-	/*
-	 * The softirq lock is held in non-atomic context and the owner is
-	 * blocking on a lock. It will schedule softirqs once the counter goes
-	 * back to zero.
-	 */
-	if (this_cpu_read(softirq_counter) > 0)
-		return;
-
-	printk(KERN_ERR "NOHZ: local_softirq_pending %02x\n",
-	       warnpending);
-	rate_limit++;
-}
-
-#else
-
-void softirq_check_pending_idle(void)
-{
-	static int ratelimit;
-
-	if (ratelimit < 10 &&
-	    (local_softirq_pending() & SOFTIRQ_STOP_IDLE_MASK)) {
-		pr_warn("NOHZ: local_softirq_pending %02x\n",
-			(unsigned int) local_softirq_pending());
-		ratelimit++;
-	}
-}
-
-#endif
-
 /*
  * [ These __weak aliases are kept in a separate compilation unit, so that
  *   GCC does not inline them incorrectly. ]
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index d5dfd51f03ee8..1de4665dc52f4 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -923,7 +923,14 @@ static bool can_stop_idle_tick(int cpu, struct tick_sched *ts)
 		return false;
 
 	if (unlikely(local_softirq_pending())) {
-		softirq_check_pending_idle();
+		static int ratelimit;
+
+		if (ratelimit < 10 && !local_bh_blocked() &&
+		    (local_softirq_pending() & SOFTIRQ_STOP_IDLE_MASK)) {
+			pr_warn("NOHZ: local_softirq_pending %02x\n",
+				(unsigned int) local_softirq_pending());
+			ratelimit++;
+		}
 		return false;
 	}
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 6e74b066a0a4d..6b8e3c0ef4fad 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3786,16 +3786,17 @@ unsigned long trace_total_entries(struct trace_array *tr)
 
 static void print_lat_help_header(struct seq_file *m)
 {
-	seq_puts(m, "#                  _------=> CPU#            \n"
-		    "#                 / _-----=> irqs-off        \n"
-		    "#                | / _----=> need-resched    \n"
-		    "#                || / _----=> need-resched_lazy\n"
-		    "#                ||| / _---=> hardirq/softirq \n"
-		    "#                |||| / _--=> preempt-depth   \n"
-		    "#                ||||| / _-=> migrate-disable \n"
-		    "#                |||||| /     delay           \n"
-		    "#  cmd     pid   ||||||| time  |   caller     \n"
-		    "#     \\   /      ||||||   \\   |   /        \n");
+	seq_puts(m, "#                    _--------=> CPU#            \n"
+		    "#                   / _-------=> irqs-off        \n"
+		    "#                  | / _------=> need-resched    \n"
+		    "#                  || / _-----=> need-resched-lazy\n"
+		    "#                  ||| / _----=> hardirq/softirq \n"
+		    "#                  |||| / _---=> preempt-depth   \n"
+		    "#                  ||||| / _--=> preempt-lazy-depth\n"
+		    "#                  |||||| / _-=> migrate-disable \n"
+		    "#                  ||||||| /     delay           \n"
+		    "#  cmd     pid     |||||||| time  |   caller     \n"
+		    "#     \\   /        ||||||||  \\    |    /       \n");
 }
 
 static void print_event_info(struct array_buffer *buf, struct seq_file *m)
@@ -3816,27 +3817,29 @@ static void print_func_help_header(struct array_buffer *buf, struct seq_file *m,
 
 	print_event_info(buf, m);
 
-	seq_printf(m, "#           TASK-PID   %s  CPU#   TIMESTAMP  FUNCTION\n", tgid ? "TGID     " : "");
-	seq_printf(m, "#              | |     %s    |       |         |\n",	 tgid ? "  |      " : "");
+	seq_printf(m, "#           TASK-PID    %s CPU#     TIMESTAMP  FUNCTION\n", tgid ? "   TGID   " : "");
+	seq_printf(m, "#              | |      %s   |         |         |\n",      tgid ? "     |    " : "");
 }
 
 static void print_func_help_header_irq(struct array_buffer *buf, struct seq_file *m,
 				       unsigned int flags)
 {
 	bool tgid = flags & TRACE_ITER_RECORD_TGID;
-	const char *space = "          ";
-	int prec = tgid ? 10 : 2;
+	const char *space = "            ";
+	int prec = tgid ? 12 : 2;
 
 	print_event_info(buf, m);
 
-	seq_printf(m, "#                          %.*s  _-----=> irqs-off\n", prec, space);
-	seq_printf(m, "#                          %.*s / _----=> need-resched\n", prec, space);
-	seq_printf(m, "#                          %.*s| / _----=> need-resched\n", prec, space);
-	seq_printf(m, "#                          %.*s|| / _---=> hardirq/softirq\n", prec, space);
-	seq_printf(m, "#                          %.*s||| / _--=> preempt-depth\n", prec, space);
-	seq_printf(m, "#                          %.*s||||/     delay\n", prec, space);
-	seq_printf(m, "#           TASK-PID %.*sCPU#  |||||   TIMESTAMP  FUNCTION\n", prec, "   TGID   ");
-	seq_printf(m, "#              | |   %.*s  |   |||||      |         |\n", prec, "     |    ");
+	seq_printf(m, "#                            %.*s  _-------=> irqs-off\n", prec, space);
+	seq_printf(m, "#                            %.*s / _------=> need-resched\n", prec, space);
+	seq_printf(m, "#                            %.*s| / _-----=> need-resched-lazy\n", prec, space);
+	seq_printf(m, "#                            %.*s|| / _----=> hardirq/softirq\n", prec, space);
+	seq_printf(m, "#                            %.*s||| / _---=> preempt-depth\n", prec, space);
+	seq_printf(m, "#                            %.*s|||| / _--=> preempt-lazy-depth\n", prec, space);
+	seq_printf(m, "#                            %.*s||||| / _-=> migrate-disable\n", prec, space);
+	seq_printf(m, "#                            %.*s|||||| /     delay\n", prec, space);
+	seq_printf(m, "#           TASK-PID  %.*s CPU#  |||||||  TIMESTAMP  FUNCTION\n", prec, "     TGID   ");
+	seq_printf(m, "#              | |    %.*s   |   |||||||      |         |\n", prec, "       |    ");
 }
 
 void
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 38b332ce04b85..bc24ae8e3613a 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -512,7 +512,7 @@ lat_print_generic(struct trace_seq *s, struct trace_entry *entry, int cpu)
 
 	trace_find_cmdline(entry->pid, comm);
 
-	trace_seq_printf(s, "%8.8s-%-5d %3d",
+	trace_seq_printf(s, "%8.8s-%-7d %3d",
 			 comm, entry->pid, cpu);
 
 	return trace_print_lat_fmt(s, entry);
@@ -603,15 +603,15 @@ int trace_print_context(struct trace_iterator *iter)
 
 	trace_find_cmdline(entry->pid, comm);
 
-	trace_seq_printf(s, "%16s-%-5d ", comm, entry->pid);
+	trace_seq_printf(s, "%16s-%-7d ", comm, entry->pid);
 
 	if (tr->trace_flags & TRACE_ITER_RECORD_TGID) {
 		unsigned int tgid = trace_find_tgid(entry->pid);
 
 		if (!tgid)
-			trace_seq_printf(s, "(-----) ");
+			trace_seq_printf(s, "(-------) ");
 		else
-			trace_seq_printf(s, "(%5d) ", tgid);
+			trace_seq_printf(s, "(%7d) ", tgid);
 	}
 
 	trace_seq_printf(s, "[%03d] ", iter->cpu);
@@ -651,7 +651,7 @@ int trace_print_lat_context(struct trace_iterator *iter)
 		trace_find_cmdline(entry->pid, comm);
 
 		trace_seq_printf(
-			s, "%16s %5d %3d %d %08x %08lx ",
+			s, "%16s %7d %3d %d %08x %08lx ",
 			comm, entry->pid, iter->cpu, entry->flags,
 			entry->preempt_count, iter->idx);
 	} else {
@@ -932,7 +932,7 @@ static enum print_line_t trace_ctxwake_print(struct trace_iterator *iter,
 	S = task_index_to_char(field->prev_state);
 	trace_find_cmdline(field->next_pid, comm);
 	trace_seq_printf(&iter->seq,
-			 " %5d:%3d:%c %s [%03d] %5d:%3d:%c %s\n",
+			 " %7d:%3d:%c %s [%03d] %7d:%3d:%c %s\n",
 			 field->prev_pid,
 			 field->prev_prio,
 			 S, delim,
diff --git a/localversion-rt b/localversion-rt
index 700c857efd9ba..22746d6390a42 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt8
+-rt9
diff --git a/net/core/dev.c b/net/core/dev.c
index 2522ad241d546..2664217d432cc 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10653,7 +10653,7 @@ static int dev_cpu_dead(unsigned int oldcpu)
 		netif_rx_ni(skb);
 		input_queue_head_incr(oldsd);
 	}
-	while ((skb = skb_dequeue(&oldsd->input_pkt_queue))) {
+	while ((skb = __skb_dequeue(&oldsd->input_pkt_queue))) {
 		netif_rx_ni(skb);
 		input_queue_head_incr(oldsd);
 	}
diff --git a/net/core/sock.c b/net/core/sock.c
index 6c5c6b18eff4c..dc252f9aaf7e0 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3049,12 +3049,11 @@ void lock_sock_nested(struct sock *sk, int subclass)
 	if (sk->sk_lock.owned)
 		__lock_sock(sk);
 	sk->sk_lock.owned = 1;
-	spin_unlock(&sk->sk_lock.slock);
+	spin_unlock_bh(&sk->sk_lock.slock);
 	/*
 	 * The sk_lock has mutex_lock() semantics here:
 	 */
 	mutex_acquire(&sk->sk_lock.dep_map, subclass, 0, _RET_IP_);
-	local_bh_enable();
 }
 EXPORT_SYMBOL(lock_sock_nested);
 
@@ -3103,12 +3102,11 @@ bool lock_sock_fast(struct sock *sk)
 
 	__lock_sock(sk);
 	sk->sk_lock.owned = 1;
-	spin_unlock(&sk->sk_lock.slock);
+	spin_unlock_bh(&sk->sk_lock.slock);
 	/*
 	 * The sk_lock has mutex_lock() semantics here:
 	 */
 	mutex_acquire(&sk->sk_lock.dep_map, 0, 0, _RET_IP_);
-	local_bh_enable();
 	return true;
 }
 EXPORT_SYMBOL(lock_sock_fast);
