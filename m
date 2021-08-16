Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A8A3C4338F
	for <linux-rt-users@archiver.kernel.org>; Mon, 16 Aug 2021 09:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BE6861B5E
	for <linux-rt-users@archiver.kernel.org>; Mon, 16 Aug 2021 09:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234902AbhHPJUK (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 16 Aug 2021 05:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235363AbhHPJTN (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 16 Aug 2021 05:19:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD148C061764;
        Mon, 16 Aug 2021 02:18:41 -0700 (PDT)
Date:   Mon, 16 Aug 2021 11:18:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629105519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=nwvOKhPSch6B1b8Fok+7KS9rMCdSud++flJk8D5+ApM=;
        b=e2lsT3WcIn091AMcS4Hk/PBGLK0RlM3g/g/Gn7P2AiQTLGolqv2Y7x/zXvKQpy2FPV3MA1
        hNIXBTyxDWdDCpF0w03V662fSCkOiR8BGTmEtY9erHBPtwJHOIYZkxu5ja7r/fAPiXTUcV
        ejKZ9JBmM7x5QTU7cOJuhjQDXRABKkukShp9z3jazkZnfeIFutkI22fo+DSi1QdrkBy9L9
        yapPeLF3SpYebG91CI1szP1YcUk7cf/ppzxaeIssUXpJuP2o7MO2RwMjqGIGm51roL9tnO
        YtzGA+tysDHlBcR42IavLDlv9plS1/30jVJDhHWY67JOZC8AfB868t6kw+k0dw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629105519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=nwvOKhPSch6B1b8Fok+7KS9rMCdSud++flJk8D5+ApM=;
        b=XZhlCArwhE0MVw1WcEZrN98dCAi3Gr/JCUoMQlOSpguNDceTmo5RojMNRKzu9E8aIW5cnv
        31qIhXtpZi4MTXDg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.14-rc6-rt10
Message-ID: <20210816091838.hbhq2qjs5ompvm5j@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.14-rc6-rt10 patch set. 

Changes since v5.14-rc6-rt9:

  - The locking bits haven been updated updated by Thomas Gleixner. They
    have been posted as v5 to the list.

  - The patches for locking's API selftest have been updated. As a
    result the locking selftest can be enabled.

Known issues
     - netconsole triggers WARN.

     - The "Memory controller" (CONFIG_MEMCG) has been disabled.

     - A RCU and ARM64 warning has been fixed by Valentin Schneider. It is
       still not clear if the RCU related change is correct.

     - Clark Williams reported issues in i915 (execlists_dequeue_irq())

     - Clark Williams reported issues with kcov enabled.

     - Valentin Schneider reported a few splats on ARM64, see
          https://https://lkml.kernel.org/r/.kernel.org/lkml/20210810134127.1394269-1-valentin.schneider@arm.com/

     - PPC64 does not build (due to atomic header includes).

     - Clark Williams reported a crash in the SLUB memory allocator. It does
       not look like a recent regression and might been there since the SLUB
       rework started in v5.13-rt1.

The delta patch against v5.14-rc6-rt9 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.14/incr/patch-5.14-rc6-rt9-rt10.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.14-rc6-rt10

The RT patch against v5.14-rc6 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.14/older/patch-5.14-rc6-rt10.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.14/older/patches-5.14-rc6-rt10.tar.xz

Sebastian

diff --git a/arch/alpha/include/asm/spinlock_types.h b/arch/alpha/include/asm/spinlock_types.h
index 6883bc952d224..1d5716bc060be 100644
--- a/arch/alpha/include/asm/spinlock_types.h
+++ b/arch/alpha/include/asm/spinlock_types.h
@@ -2,6 +2,10 @@
 #ifndef _ALPHA_SPINLOCK_TYPES_H
 #define _ALPHA_SPINLOCK_TYPES_H
 
+#ifndef __LINUX_SPINLOCK_TYPES_H
+# error "please don't include this file directly"
+#endif
+
 typedef struct {
 	volatile unsigned int lock;
 } arch_spinlock_t;
diff --git a/arch/arm/include/asm/spinlock_types.h b/arch/arm/include/asm/spinlock_types.h
index a37c0803954ba..5976958647fe1 100644
--- a/arch/arm/include/asm/spinlock_types.h
+++ b/arch/arm/include/asm/spinlock_types.h
@@ -2,6 +2,10 @@
 #ifndef __ASM_SPINLOCK_TYPES_H
 #define __ASM_SPINLOCK_TYPES_H
 
+#ifndef __LINUX_SPINLOCK_TYPES_H
+# error "please don't include this file directly"
+#endif
+
 #define TICKET_SHIFT	16
 
 typedef struct {
diff --git a/arch/arm64/include/asm/spinlock_types.h b/arch/arm64/include/asm/spinlock_types.h
index 6672b05350b4e..18782f0c47212 100644
--- a/arch/arm64/include/asm/spinlock_types.h
+++ b/arch/arm64/include/asm/spinlock_types.h
@@ -5,6 +5,10 @@
 #ifndef __ASM_SPINLOCK_TYPES_H
 #define __ASM_SPINLOCK_TYPES_H
 
+#if !defined(__LINUX_SPINLOCK_TYPES_H) && !defined(__ASM_SPINLOCK_H)
+# error "please don't include this file directly"
+#endif
+
 #include <asm-generic/qspinlock_types.h>
 #include <asm-generic/qrwlock_types.h>
 
diff --git a/arch/hexagon/include/asm/spinlock_types.h b/arch/hexagon/include/asm/spinlock_types.h
index de72fb23016dc..19d233497ba52 100644
--- a/arch/hexagon/include/asm/spinlock_types.h
+++ b/arch/hexagon/include/asm/spinlock_types.h
@@ -8,6 +8,10 @@
 #ifndef _ASM_SPINLOCK_TYPES_H
 #define _ASM_SPINLOCK_TYPES_H
 
+#ifndef __LINUX_SPINLOCK_TYPES_H
+# error "please don't include this file directly"
+#endif
+
 typedef struct {
 	volatile unsigned int lock;
 } arch_spinlock_t;
diff --git a/arch/ia64/include/asm/spinlock_types.h b/arch/ia64/include/asm/spinlock_types.h
index 681408d6816fb..6e345fefcdcab 100644
--- a/arch/ia64/include/asm/spinlock_types.h
+++ b/arch/ia64/include/asm/spinlock_types.h
@@ -2,6 +2,10 @@
 #ifndef _ASM_IA64_SPINLOCK_TYPES_H
 #define _ASM_IA64_SPINLOCK_TYPES_H
 
+#ifndef __LINUX_SPINLOCK_TYPES_H
+# error "please don't include this file directly"
+#endif
+
 typedef struct {
 	volatile unsigned int lock;
 } arch_spinlock_t;
diff --git a/arch/powerpc/include/asm/spinlock_types.h b/arch/powerpc/include/asm/spinlock_types.h
index cc6922a011ba1..c5d742f18021d 100644
--- a/arch/powerpc/include/asm/spinlock_types.h
+++ b/arch/powerpc/include/asm/spinlock_types.h
@@ -2,6 +2,10 @@
 #ifndef _ASM_POWERPC_SPINLOCK_TYPES_H
 #define _ASM_POWERPC_SPINLOCK_TYPES_H
 
+#ifndef __LINUX_SPINLOCK_TYPES_H
+# error "please don't include this file directly"
+#endif
+
 #ifdef CONFIG_PPC_QUEUED_SPINLOCKS
 #include <asm-generic/qspinlock_types.h>
 #include <asm-generic/qrwlock_types.h>
diff --git a/arch/s390/include/asm/spinlock_types.h b/arch/s390/include/asm/spinlock_types.h
index f059d282e766f..a2bbfd7df85fa 100644
--- a/arch/s390/include/asm/spinlock_types.h
+++ b/arch/s390/include/asm/spinlock_types.h
@@ -2,6 +2,10 @@
 #ifndef __ASM_SPINLOCK_TYPES_H
 #define __ASM_SPINLOCK_TYPES_H
 
+#ifndef __LINUX_SPINLOCK_TYPES_H
+# error "please don't include this file directly"
+#endif
+
 typedef struct {
 	int lock;
 } arch_spinlock_t;
diff --git a/arch/sh/include/asm/spinlock_types.h b/arch/sh/include/asm/spinlock_types.h
index 22ca9a98bbb8b..e82369f286a20 100644
--- a/arch/sh/include/asm/spinlock_types.h
+++ b/arch/sh/include/asm/spinlock_types.h
@@ -2,6 +2,10 @@
 #ifndef __ASM_SH_SPINLOCK_TYPES_H
 #define __ASM_SH_SPINLOCK_TYPES_H
 
+#ifndef __LINUX_SPINLOCK_TYPES_H
+# error "please don't include this file directly"
+#endif
+
 typedef struct {
 	volatile unsigned int lock;
 } arch_spinlock_t;
diff --git a/arch/xtensa/include/asm/spinlock_types.h b/arch/xtensa/include/asm/spinlock_types.h
index dc846323b1cd7..64c9389254f13 100644
--- a/arch/xtensa/include/asm/spinlock_types.h
+++ b/arch/xtensa/include/asm/spinlock_types.h
@@ -2,6 +2,10 @@
 #ifndef __ASM_SPINLOCK_TYPES_H
 #define __ASM_SPINLOCK_TYPES_H
 
+#if !defined(__LINUX_SPINLOCK_TYPES_H) && !defined(__ASM_SPINLOCK_H)
+# error "please don't include this file directly"
+#endif
+
 #include <asm-generic/qspinlock_types.h>
 #include <asm-generic/qrwlock_types.h>
 
diff --git a/include/linux/local_lock_internal.h b/include/linux/local_lock_internal.h
index f39fb28061645..4739a3061e107 100644
--- a/include/linux/local_lock_internal.h
+++ b/include/linux/local_lock_internal.h
@@ -16,29 +16,14 @@ typedef struct {
 } local_lock_t;
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
-# define LL_DEP_MAP_INIT(lockname)			\
+# define LOCAL_LOCK_DEBUG_INIT(lockname)		\
 	.dep_map = {					\
 		.name = #lockname,			\
 		.wait_type_inner = LD_WAIT_CONFIG,	\
-		.lock_type = LD_LOCK_PERCPU,			\
-	}
-#else
-# define LL_DEP_MAP_INIT(lockname)
-#endif
+		.lock_type = LD_LOCK_PERCPU,		\
+	},						\
+	.owner = NULL,
 
-#define INIT_LOCAL_LOCK(lockname)	{ LL_DEP_MAP_INIT(lockname) }
-
-#define __local_lock_init(lock)					\
-do {								\
-	static struct lock_class_key __key;			\
-								\
-	debug_check_no_locks_freed((void *)lock, sizeof(*lock));\
-	lockdep_init_map_type(&(lock)->dep_map, #lock, &__key, 0, \
-			      LD_WAIT_CONFIG, LD_WAIT_INV,	\
-			      LD_LOCK_PERCPU);			\
-} while (0)
-
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
 static inline void local_lock_acquire(local_lock_t *l)
 {
 	lock_map_acquire(&l->dep_map);
@@ -53,103 +38,108 @@ static inline void local_lock_release(local_lock_t *l)
 	lock_map_release(&l->dep_map);
 }
 
+static inline void local_lock_debug_init(local_lock_t *l)
+{
+	l->owner = NULL;
+}
 #else /* CONFIG_DEBUG_LOCK_ALLOC */
+# define LOCAL_LOCK_DEBUG_INIT(lockname)
 static inline void local_lock_acquire(local_lock_t *l) { }
 static inline void local_lock_release(local_lock_t *l) { }
+static inline void local_lock_debug_init(local_lock_t *l) { }
 #endif /* !CONFIG_DEBUG_LOCK_ALLOC */
 
-#define ll_preempt_disable()		preempt_disable()
-#define ll_preempt_enable()		preempt_enable()
-#define ll_local_irq_disable()		local_irq_disable()
-#define ll_local_irq_enable()		local_irq_enable()
-#define ll_local_irq_save(flags)	local_irq_save(flags)
-#define ll_local_irq_restore(flags)	local_irq_restore(flags)
+#define INIT_LOCAL_LOCK(lockname)	{ LOCAL_LOCK_DEBUG_INIT(lockname) }
 
-#else /* !CONFIG_PREEMPT_RT */
-
-/*
- * The preempt RT mapping of local locks: a spinlock.
- */
-typedef struct {
-	spinlock_t		lock;
-} local_lock_t;
-
-#define INIT_LOCAL_LOCK(lockname)	{	\
-	__SPIN_LOCK_UNLOCKED((lockname).lock),	\
-	}
-
-#define __local_lock_init(l)					\
+#define __local_lock_init(lock)					\
 do {								\
-	spin_lock_init(&(l)->lock);				\
+	static struct lock_class_key __key;			\
+								\
+	debug_check_no_locks_freed((void *)lock, sizeof(*lock));\
+	lockdep_init_map_type(&(lock)->dep_map, #lock, &__key,  \
+			      0, LD_WAIT_CONFIG, LD_WAIT_INV,	\
+			      LD_LOCK_PERCPU);			\
+	local_lock_debug_init(lock);				\
 } while (0)
 
-static inline void local_lock_acquire(local_lock_t *l)
-{
-	spin_lock(&l->lock);
-}
-
-static inline void local_lock_release(local_lock_t *l)
-{
-	spin_unlock(&l->lock);
-}
-
-/*
- * On RT enabled kernels the serialization is guaranteed by the spinlock in
- * local_lock_t, so the only guarantee to make is to not leave the CPU.
- */
-#define ll_preempt_disable()		migrate_disable()
-#define ll_preempt_enable()		migrate_enable()
-#define ll_local_irq_disable()		migrate_disable()
-#define ll_local_irq_enable()		migrate_enable()
-
-#define ll_local_irq_save(flags)			\
-	do {						\
-		typecheck(unsigned long, flags);	\
-		flags = 0;				\
-		migrate_disable();			\
-	} while (0)
-
-#define ll_local_irq_restore(flags)			\
-	do {						\
-		typecheck(unsigned long, flags);	\
-		(void)flags;				\
-		migrate_enable();			\
-	} while (0)
-
-#endif /* CONFIG_PREEMPT_RT */
-
 #define __local_lock(lock)					\
 	do {							\
-		ll_preempt_disable();				\
+		preempt_disable();				\
 		local_lock_acquire(this_cpu_ptr(lock));		\
 	} while (0)
 
 #define __local_lock_irq(lock)					\
 	do {							\
-		ll_local_irq_disable();				\
+		local_irq_disable();				\
 		local_lock_acquire(this_cpu_ptr(lock));		\
 	} while (0)
 
 #define __local_lock_irqsave(lock, flags)			\
 	do {							\
-		ll_local_irq_save(flags);			\
+		local_irq_save(flags);				\
 		local_lock_acquire(this_cpu_ptr(lock));		\
 	} while (0)
 
 #define __local_unlock(lock)					\
 	do {							\
 		local_lock_release(this_cpu_ptr(lock));		\
-		ll_preempt_enable();				\
+		preempt_enable();				\
 	} while (0)
 
 #define __local_unlock_irq(lock)				\
 	do {							\
 		local_lock_release(this_cpu_ptr(lock));		\
-		ll_local_irq_enable();				\
+		local_irq_enable();				\
 	} while (0)
 
 #define __local_unlock_irqrestore(lock, flags)			\
 	do {							\
 		local_lock_release(this_cpu_ptr(lock));		\
-		ll_local_irq_restore(flags);			\
+		local_irq_restore(flags);			\
 	} while (0)
+
+#else /* !CONFIG_PREEMPT_RT */
+
+/*
+ * On PREEMPT_RT local_lock maps to a per CPU spinlock which protects the
+ * critical section while staying preemptible.
+ */
+typedef struct {
+	spinlock_t		lock;
+} local_lock_t;
+
+#define INIT_LOCAL_LOCK(lockname) {				\
+		__LOCAL_SPIN_LOCK_UNLOCKED((lockname).lock)	\
+	}
+
+#define __local_lock_init(l)					\
+	do {							\
+		local_spin_lock_init(&(l)->lock);		\
+	} while (0)
+
+#define __local_lock(__lock)					\
+	do {							\
+		migrate_disable();				\
+		spin_lock(&(this_cpu_ptr((__lock)))->lock);	\
+	} while (0)
+
+#define __local_lock_irq(lock)			__local_lock(lock)
+
+#define __local_lock_irqsave(lock, flags)			\
+	do {							\
+		typecheck(unsigned long, flags);		\
+		flags = 0;					\
+		__local_lock(lock);				\
+	} while (0)
+
+#define __local_unlock(__lock)					\
+	do {							\
+		spin_unlock(&(this_cpu_ptr((__lock)))->lock);	\
+		migrate_enable();				\
+	} while (0)
+
+#define __local_unlock_irq(lock)		__local_unlock(lock)
+
+#define __local_unlock_irqrestore(lock, flags)	__local_unlock(lock)
+
+#endif /* CONFIG_PREEMPT_RT */
diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index c0e1f955547fe..8f226d460f51c 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -156,19 +156,18 @@ static inline void mutex_destroy(struct mutex *lock) { }
 
 #define mutex_is_locked(l)	rt_mutex_base_is_locked(&(l)->rtmutex)
 
-#define mutex_init(mutex)				\
-do {							\
-	static struct lock_class_key __key;		\
-							\
-	rt_mutex_base_init(&(mutex)->rtmutex);		\
-	__mutex_rt_init((mutex), #mutex, &__key);	\
-} while (0)
-
 #define __mutex_init(mutex, name, key)			\
 do {							\
 	rt_mutex_base_init(&(mutex)->rtmutex);		\
 	__mutex_rt_init((mutex), name, key);		\
 } while (0)
+
+#define mutex_init(mutex)				\
+do {							\
+	static struct lock_class_key __key;		\
+							\
+	__mutex_init((mutex), #mutex, &__key);		\
+} while (0)
 #endif /* CONFIG_PREEMPT_RT */
 
 /*
diff --git a/include/linux/rtmutex.h b/include/linux/rtmutex.h
index 531cb503d4c49..7d049883a08ac 100644
--- a/include/linux/rtmutex.h
+++ b/include/linux/rtmutex.h
@@ -13,10 +13,10 @@
 #ifndef __LINUX_RT_MUTEX_H
 #define __LINUX_RT_MUTEX_H
 
+#include <linux/compiler.h>
 #include <linux/linkage.h>
 #include <linux/rbtree_types.h>
 #include <linux/spinlock_types_raw.h>
-#include <linux/compiler.h>
 
 extern int max_lock_depth; /* for sysctl */
 
@@ -77,15 +77,18 @@ do { \
 } while (0)
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
-#define __DEP_MAP_RT_MUTEX_INITIALIZER(mutexname) \
-	, .dep_map = { .name = #mutexname }
+#define __DEP_MAP_RT_MUTEX_INITIALIZER(mutexname)	\
+	.dep_map = {					\
+		.name = #mutexname,			\
+		.wait_type_inner = LD_WAIT_SLEEP,	\
+	}
 #else
 #define __DEP_MAP_RT_MUTEX_INITIALIZER(mutexname)
 #endif
 
 #define __RT_MUTEX_INITIALIZER(mutexname)				\
 {									\
-	.rtmutex = __RT_MUTEX_BASE_INITIALIZER(mutexname.rtmutex)	\
+	.rtmutex = __RT_MUTEX_BASE_INITIALIZER(mutexname.rtmutex),	\
 	__DEP_MAP_RT_MUTEX_INITIALIZER(mutexname)			\
 }
 
@@ -96,13 +99,22 @@ extern void __rt_mutex_init(struct rt_mutex *lock, const char *name, struct lock
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 extern void rt_mutex_lock_nested(struct rt_mutex *lock, unsigned int subclass);
+extern void _rt_mutex_lock_nest_lock(struct rt_mutex *lock, struct lockdep_map *nest_lock);
 #define rt_mutex_lock(lock) rt_mutex_lock_nested(lock, 0)
+#define rt_mutex_lock_nest_lock(lock, nest_lock)			\
+	do {								\
+		typecheck(struct lockdep_map *, &(nest_lock)->dep_map);	\
+		_rt_mutex_lock_nest_lock(lock, &(nest_lock)->dep_map);	\
+	} while (0)
+
 #else
 extern void rt_mutex_lock(struct rt_mutex *lock);
 #define rt_mutex_lock_nested(lock, subclass) rt_mutex_lock(lock)
+#define rt_mutex_lock_nest_lock(lock, nest_lock) rt_mutex_lock(lock)
 #endif
 
 extern int rt_mutex_lock_interruptible(struct rt_mutex *lock);
+extern int rt_mutex_lock_killable(struct rt_mutex *lock);
 extern int rt_mutex_trylock(struct rt_mutex *lock);
 
 extern void rt_mutex_unlock(struct rt_mutex *lock);
diff --git a/include/linux/rwlock_types.h b/include/linux/rwlock_types.h
index 243339e3e27c3..1948442e77501 100644
--- a/include/linux/rwlock_types.h
+++ b/include/linux/rwlock_types.h
@@ -5,6 +5,16 @@
 # error "Do not include directly, include spinlock_types.h"
 #endif
 
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+# define RW_DEP_MAP_INIT(lockname)					\
+	.dep_map = {							\
+		.name = #lockname,					\
+		.wait_type_inner = LD_WAIT_CONFIG,			\
+	}
+#else
+# define RW_DEP_MAP_INIT(lockname)
+#endif
+
 #ifndef CONFIG_PREEMPT_RT
 /*
  * generic rwlock type definitions and initializers
@@ -25,16 +35,6 @@ typedef struct {
 
 #define RWLOCK_MAGIC		0xdeaf1eed
 
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-# define RW_DEP_MAP_INIT(lockname)					\
-	.dep_map = {							\
-		.name = #lockname,					\
-		.wait_type_inner = LD_WAIT_CONFIG,			\
-	}
-#else
-# define RW_DEP_MAP_INIT(lockname)
-#endif
-
 #ifdef CONFIG_DEBUG_SPINLOCK
 #define __RW_LOCK_UNLOCKED(lockname)					\
 	(rwlock_t)	{	.raw_lock = __ARCH_RW_LOCK_UNLOCKED,	\
@@ -62,23 +62,17 @@ typedef struct {
 #endif
 } rwlock_t;
 
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-# define RW_DEP_MAP_INIT(lockname)	.dep_map = { .name = #lockname }
-#else
-# define RW_DEP_MAP_INIT(lockname)
-#endif
-
-#define __RW_LOCK_UNLOCKED(name) __RWLOCK_RT_INITIALIZER(name)
-
-#define DEFINE_RWLOCK(name) \
-	rwlock_t name = __RW_LOCK_UNLOCKED(name)
-
 #define __RWLOCK_RT_INITIALIZER(name)					\
 {									\
 	.rwbase = __RWBASE_INITIALIZER(name),				\
 	RW_DEP_MAP_INIT(name)						\
 }
 
+#define __RW_LOCK_UNLOCKED(name) __RWLOCK_RT_INITIALIZER(name)
+
+#define DEFINE_RWLOCK(name)						\
+	rwlock_t name = __RW_LOCK_UNLOCKED(name)
+
 #endif /* CONFIG_PREEMPT_RT */
 
 #endif /* __LINUX_RWLOCK_TYPES_H */
diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index 08b7aa6e5b4f1..426e98e0b675c 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -17,6 +17,16 @@
 #include <linux/atomic.h>
 #include <linux/err.h>
 
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+# define __RWSEM_DEP_MAP_INIT(lockname)			\
+	.dep_map = {					\
+		.name = #lockname,			\
+		.wait_type_inner = LD_WAIT_SLEEP,	\
+	},
+#else
+# define __RWSEM_DEP_MAP_INIT(lockname)
+#endif
+
 #ifndef CONFIG_PREEMPT_RT
 
 #ifdef CONFIG_RWSEM_SPIN_ON_OWNER
@@ -67,16 +77,6 @@ static inline int rwsem_is_locked(struct rw_semaphore *sem)
 
 /* Common initializer macros and functions */
 
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-# define __RWSEM_DEP_MAP_INIT(lockname)			\
-	.dep_map = {					\
-		.name = #lockname,			\
-		.wait_type_inner = LD_WAIT_SLEEP,	\
-	},
-#else
-# define __RWSEM_DEP_MAP_INIT(lockname)
-#endif
-
 #ifdef CONFIG_DEBUG_RWSEMS
 # define __RWSEM_DEBUG_INIT(lockname) .magic = &lockname,
 #else
@@ -136,7 +136,7 @@ struct rw_semaphore {
 #define __RWSEM_INITIALIZER(name)				\
 	{							\
 		.rwbase = __RWBASE_INITIALIZER(name),		\
-		RW_DEP_MAP_INIT(name)				\
+		__RWSEM_DEP_MAP_INIT(name)			\
 	}
 
 #define DECLARE_RWSEM(lockname) \
diff --git a/include/linux/spinlock_rt.h b/include/linux/spinlock_rt.h
index 4fc72199cc9d2..835aedaf68acd 100644
--- a/include/linux/spinlock_rt.h
+++ b/include/linux/spinlock_rt.h
@@ -8,20 +8,28 @@
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 extern void __rt_spin_lock_init(spinlock_t *lock, const char *name,
-				struct lock_class_key *key);
+				struct lock_class_key *key, bool percpu);
 #else
 static inline void __rt_spin_lock_init(spinlock_t *lock, const char *name,
-				       struct lock_class_key *key)
+				struct lock_class_key *key, bool percpu)
 {
 }
 #endif
 
-#define spin_lock_init(slock)				\
-do {							\
-	static struct lock_class_key __key;		\
-							\
-	rt_mutex_base_init(&(slock)->lock);		\
-	__rt_spin_lock_init(slock, #slock, &__key);	\
+#define spin_lock_init(slock)					\
+do {								\
+	static struct lock_class_key __key;			\
+								\
+	rt_mutex_base_init(&(slock)->lock);			\
+	__rt_spin_lock_init(slock, #slock, &__key, false);	\
+} while (0)
+
+#define local_spin_lock_init(slock)				\
+do {								\
+	static struct lock_class_key __key;			\
+								\
+	rt_mutex_base_init(&(slock)->lock);			\
+	__rt_spin_lock_init(slock, #slock, &__key, true);	\
 } while (0)
 
 extern void rt_spin_lock(spinlock_t *lock);
diff --git a/include/linux/spinlock_types.h b/include/linux/spinlock_types.h
index 8a9aadbaf2938..2dfa35ffec761 100644
--- a/include/linux/spinlock_types.h
+++ b/include/linux/spinlock_types.h
@@ -60,6 +60,12 @@ typedef struct spinlock {
 		SPIN_DEP_MAP_INIT(name)				\
 	}
 
+#define __LOCAL_SPIN_LOCK_UNLOCKED(name)			\
+	{							\
+		.lock = __RT_MUTEX_BASE_INITIALIZER(name.lock),	\
+		LOCAL_SPIN_DEP_MAP_INIT(name)			\
+	}
+
 #define DEFINE_SPINLOCK(name)					\
 	spinlock_t name = __SPIN_LOCK_UNLOCKED(name)
 
diff --git a/include/linux/spinlock_types_raw.h b/include/linux/spinlock_types_raw.h
index 1d4a180e983d7..1b49628736c2b 100644
--- a/include/linux/spinlock_types_raw.h
+++ b/include/linux/spinlock_types_raw.h
@@ -37,9 +37,17 @@ typedef struct raw_spinlock {
 		.name = #lockname,			\
 		.wait_type_inner = LD_WAIT_CONFIG,	\
 	}
+
+# define LOCAL_SPIN_DEP_MAP_INIT(lockname)		\
+	.dep_map = {					\
+		.name = #lockname,			\
+		.wait_type_inner = LD_WAIT_CONFIG,	\
+		.lock_type = LD_LOCK_PERCPU,		\
+	}
 #else
 # define RAW_SPIN_DEP_MAP_INIT(lockname)
 # define SPIN_DEP_MAP_INIT(lockname)
+# define LOCAL_SPIN_DEP_MAP_INIT(lockname)
 #endif
 
 #ifdef CONFIG_DEBUG_SPINLOCK
diff --git a/kernel/locking/mutex.h b/kernel/locking/mutex.h
index 8d1b0ee490627..0b2a79c4013bd 100644
--- a/kernel/locking/mutex.h
+++ b/kernel/locking/mutex.h
@@ -35,16 +35,11 @@ extern void debug_mutex_unlock(struct mutex *lock);
 extern void debug_mutex_init(struct mutex *lock, const char *name,
 			     struct lock_class_key *key);
 #else /* CONFIG_DEBUG_MUTEXES */
-
-#define debug_mutex_wake_waiter(lock, waiter)		do { } while (0)
-#define debug_mutex_free_waiter(waiter)			do { } while (0)
-#define debug_mutex_add_waiter(lock, waiter, ti)	do { } while (0)
-#define debug_mutex_remove_waiter(lock, waiter, ti)     do { } while (0)
-#define debug_mutex_unlock(lock)			do { } while (0)
-#define debug_mutex_init(lock, name, key)		do { } while (0)
-
-static inline void
-debug_mutex_lock_common(struct mutex *lock, struct mutex_waiter *waiter)
-{
-}
+# define debug_mutex_lock_common(lock, waiter)		do { } while (0)
+# define debug_mutex_wake_waiter(lock, waiter)		do { } while (0)
+# define debug_mutex_free_waiter(waiter)		do { } while (0)
+# define debug_mutex_add_waiter(lock, waiter, ti)	do { } while (0)
+# define debug_mutex_remove_waiter(lock, waiter, ti)	do { } while (0)
+# define debug_mutex_unlock(lock)			do { } while (0)
+# define debug_mutex_init(lock, name, key)		do { } while (0)
 #endif /* !CONFIG_DEBUG_MUTEXES */
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 25b089db5f510..8d72995565305 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1059,8 +1059,26 @@ static int __sched task_blocks_on_rt_mutex(struct rt_mutex_base *lock,
 	 * which is wrong, as the other waiter is not in a deadlock
 	 * situation.
 	 */
-	if (owner == task)
+	if (owner == task) {
+#if defined(DEBUG_WW_MUTEXES) && defined(CONFIG_DEBUG_LOCKING_API_SELFTESTS)
+		/*
+		 * The lockdep selftest for ww-mutex assumes in a few cases
+		 * the ww_ctx->contending_lock assignment via
+		 * __ww_mutex_check_kill() which does not happen if the rtmutex
+		 * detects the deadlock early.
+		 */
+		if (build_ww_mutex() && ww_ctx) {
+			struct rt_mutex *rtm;
+
+			/* Check whether the waiter should backout immediately */
+			rtm = container_of(lock, struct rt_mutex, rtmutex);
+
+			__ww_mutex_add_waiter(waiter, rtm, ww_ctx);
+			__ww_mutex_check_kill(rtm, waiter, ww_ctx);
+		}
+#endif
 		return -EDEADLK;
+	}
 
 	raw_spin_lock(&task->pi_lock);
 	waiter->task = task;
diff --git a/kernel/locking/rtmutex_api.c b/kernel/locking/rtmutex_api.c
index 6875d9ee04704..3155aa6f7ee24 100644
--- a/kernel/locking/rtmutex_api.c
+++ b/kernel/locking/rtmutex_api.c
@@ -21,12 +21,13 @@ int max_lock_depth = 1024;
  */
 static __always_inline int __rt_mutex_lock_common(struct rt_mutex *lock,
 						  unsigned int state,
+						  struct lockdep_map *nest_lock,
 						  unsigned int subclass)
 {
 	int ret;
 
 	might_sleep();
-	mutex_acquire(&lock->dep_map, subclass, 0, _RET_IP_);
+	mutex_acquire_nest(&lock->dep_map, subclass, 0, nest_lock, _RET_IP_);
 	ret = __rt_mutex_lock(&lock->rtmutex, state);
 	if (ret)
 		mutex_release(&lock->dep_map, _RET_IP_);
@@ -48,10 +49,16 @@ EXPORT_SYMBOL(rt_mutex_base_init);
  */
 void __sched rt_mutex_lock_nested(struct rt_mutex *lock, unsigned int subclass)
 {
-	__rt_mutex_lock_common(lock, TASK_UNINTERRUPTIBLE, subclass);
+	__rt_mutex_lock_common(lock, TASK_UNINTERRUPTIBLE, NULL, subclass);
 }
 EXPORT_SYMBOL_GPL(rt_mutex_lock_nested);
 
+void __sched _rt_mutex_lock_nest_lock(struct rt_mutex *lock, struct lockdep_map *nest_lock)
+{
+	__rt_mutex_lock_common(lock, TASK_UNINTERRUPTIBLE, nest_lock, 0);
+}
+EXPORT_SYMBOL_GPL(_rt_mutex_lock_nest_lock);
+
 #else /* !CONFIG_DEBUG_LOCK_ALLOC */
 
 /**
@@ -61,7 +68,7 @@ EXPORT_SYMBOL_GPL(rt_mutex_lock_nested);
  */
 void __sched rt_mutex_lock(struct rt_mutex *lock)
 {
-	__rt_mutex_lock_common(lock, TASK_UNINTERRUPTIBLE, 0);
+	__rt_mutex_lock_common(lock, TASK_UNINTERRUPTIBLE, NULL, 0);
 }
 EXPORT_SYMBOL_GPL(rt_mutex_lock);
 #endif
@@ -77,10 +84,25 @@ EXPORT_SYMBOL_GPL(rt_mutex_lock);
  */
 int __sched rt_mutex_lock_interruptible(struct rt_mutex *lock)
 {
-	return __rt_mutex_lock_common(lock, TASK_INTERRUPTIBLE, 0);
+	return __rt_mutex_lock_common(lock, TASK_INTERRUPTIBLE, NULL, 0);
 }
 EXPORT_SYMBOL_GPL(rt_mutex_lock_interruptible);
 
+/**
+ * rt_mutex_lock_killable - lock a rt_mutex killable
+ *
+ * @lock:		the rt_mutex to be locked
+ *
+ * Returns:
+ *  0		on success
+ * -EINTR	when interrupted by a signal
+ */
+int __sched rt_mutex_lock_killable(struct rt_mutex *lock)
+{
+	return __rt_mutex_lock_common(lock, TASK_KILLABLE, NULL, 0);
+}
+EXPORT_SYMBOL_GPL(rt_mutex_lock_killable);
+
 /**
  * rt_mutex_trylock - try to lock a rt_mutex
  *
@@ -189,11 +211,11 @@ void __sched rt_mutex_futex_unlock(struct rt_mutex_base *lock)
  * Initializing of a locked rt_mutex is not allowed
  */
 void __sched __rt_mutex_init(struct rt_mutex *lock, const char *name,
-		     struct lock_class_key *key)
+			     struct lock_class_key *key)
 {
 	debug_check_no_locks_freed((void *)lock, sizeof(*lock));
 	__rt_mutex_base_init(&lock->rtmutex);
-	lockdep_init_map(&lock->dep_map, name, key, 0);
+	lockdep_init_map_wait(&lock->dep_map, name, key, 0, LD_WAIT_SLEEP);
 }
 EXPORT_SYMBOL_GPL(__rt_mutex_init);
 
@@ -473,7 +495,7 @@ void __mutex_rt_init(struct mutex *mutex, const char *name,
 		     struct lock_class_key *key)
 {
 	debug_check_no_locks_freed((void *)mutex, sizeof(*mutex));
-	lockdep_init_map(&mutex->dep_map, name, key, 0);
+	lockdep_init_map_wait(&mutex->dep_map, name, key, 0, LD_WAIT_SLEEP);
 }
 EXPORT_SYMBOL(__mutex_rt_init);
 
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 4f7d9ccd6ef1b..64aafd39b2fdd 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -1381,7 +1381,7 @@ void __rwsem_init(struct rw_semaphore *sem, const char *name,
 		  struct lock_class_key *key)
 {
 	debug_check_no_locks_freed((void *)sem, sizeof(*sem));
-	lockdep_init_map(&sem->dep_map, name, key, 0);
+	lockdep_init_map_wait(&sem->dep_map, name, key, 0, LD_WAIT_SLEEP);
 }
 EXPORT_SYMBOL(__rwsem_init);
 #endif
diff --git a/kernel/locking/spinlock_rt.c b/kernel/locking/spinlock_rt.c
index d54681d6ad078..7894c66045b52 100644
--- a/kernel/locking/spinlock_rt.c
+++ b/kernel/locking/spinlock_rt.c
@@ -120,10 +120,13 @@ EXPORT_SYMBOL(rt_spin_trylock_bh);
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 void __rt_spin_lock_init(spinlock_t *lock, const char *name,
-			 struct lock_class_key *key)
+			 struct lock_class_key *key, bool percpu)
 {
+	u8 type = percpu ? LD_LOCK_PERCPU : LD_LOCK_NORMAL;
+
 	debug_check_no_locks_freed((void *)lock, sizeof(*lock));
-	lockdep_init_map(&lock->dep_map, name, key, 0);
+	lockdep_init_map_type(&lock->dep_map, name, key, 0, LD_WAIT_CONFIG,
+			      LD_WAIT_INV, type);
 }
 EXPORT_SYMBOL(__rt_spin_lock_init);
 #endif
@@ -207,6 +210,7 @@ EXPORT_SYMBOL(rt_write_trylock);
 
 void __sched rt_read_lock(rwlock_t *rwlock)
 {
+	___might_sleep(__FILE__, __LINE__, 0);
 	rwlock_acquire_read(&rwlock->dep_map, 0, 0, _RET_IP_);
 	rwbase_read_lock(&rwlock->rwbase, TASK_RTLOCK_WAIT);
 	rcu_read_lock();
@@ -216,6 +220,7 @@ EXPORT_SYMBOL(rt_read_lock);
 
 void __sched rt_write_lock(rwlock_t *rwlock)
 {
+	___might_sleep(__FILE__, __LINE__, 0);
 	rwlock_acquire(&rwlock->dep_map, 0, 0, _RET_IP_);
 	rwbase_write_lock(&rwlock->rwbase, TASK_RTLOCK_WAIT);
 	rcu_read_lock();
@@ -252,7 +257,7 @@ void __rt_rwlock_init(rwlock_t *rwlock, const char *name,
 		      struct lock_class_key *key)
 {
 	debug_check_no_locks_freed((void *)rwlock, sizeof(*rwlock));
-	lockdep_init_map(&rwlock->dep_map, name, key, 0);
+	lockdep_init_map_wait(&rwlock->dep_map, name, key, 0, LD_WAIT_CONFIG);
 }
 EXPORT_SYMBOL(__rt_rwlock_init);
 #endif
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e0b90561ef711..c3b33afb3cd13 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2164,6 +2164,8 @@ void migrate_enable(void)
 	if (p->migration_disabled > 1) {
 		p->migration_disabled--;
 		return;
+	} else if (WARN_ON_ONCE(p->migration_disabled == 0)) {
+		return;
 	}
 
 	/*
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 73c255ecb5fb1..e5cdf98f50c2d 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1452,7 +1452,7 @@ config DEBUG_ATOMIC_SLEEP
 
 config DEBUG_LOCKING_API_SELFTESTS
 	bool "Locking API boot-time self-tests"
-	depends on DEBUG_KERNEL && !PREEMPT_RT
+	depends on DEBUG_KERNEL
 	help
 	  Say Y here if you want the kernel to run a short self-test during
 	  bootup. The self-test checks whether common types of locking bugs
diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index 25b5330bfcc55..415e3efec77ce 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -26,6 +26,12 @@
 #include <linux/rtmutex.h>
 #include <linux/local_lock.h>
 
+#ifdef CONFIG_PREEMPT_RT
+# define NON_RT(...)
+#else
+# define NON_RT(...)	__VA_ARGS__
+#endif
+
 /*
  * Change this to 1 if you want to see the failure printouts:
  */
@@ -139,7 +145,7 @@ static DEFINE_RT_MUTEX(rtmutex_Z2);
 
 #endif
 
-static local_lock_t local_A = INIT_LOCAL_LOCK(local_A);
+static DEFINE_PER_CPU(local_lock_t, local_A);
 
 /*
  * non-inlined runtime initializers, to let separate locks share
@@ -712,12 +718,18 @@ GENERATE_TESTCASE(ABCDBCDA_rtmutex);
 
 #undef E
 
+#ifdef CONFIG_PREEMPT_RT
+# define RT_PREPARE_DBL_UNLOCK()	{ migrate_disable(); rcu_read_lock(); }
+#else
+# define RT_PREPARE_DBL_UNLOCK()
+#endif
 /*
  * Double unlock:
  */
 #define E()					\
 						\
 	LOCK(A);				\
+	RT_PREPARE_DBL_UNLOCK();		\
 	UNLOCK(A);				\
 	UNLOCK(A); /* fail */
 
@@ -796,14 +808,13 @@ GENERATE_TESTCASE(init_held_rtmutex);
 #include "locking-selftest-spin-hardirq.h"
 GENERATE_PERMUTATIONS_2_EVENTS(irqsafe1_hard_spin)
 
-#ifndef CONFIG_PREEMPT_RT
-
 #include "locking-selftest-rlock-hardirq.h"
 GENERATE_PERMUTATIONS_2_EVENTS(irqsafe1_hard_rlock)
 
 #include "locking-selftest-wlock-hardirq.h"
 GENERATE_PERMUTATIONS_2_EVENTS(irqsafe1_hard_wlock)
 
+#ifndef CONFIG_PREEMPT_RT
 #include "locking-selftest-spin-softirq.h"
 GENERATE_PERMUTATIONS_2_EVENTS(irqsafe1_soft_spin)
 
@@ -812,7 +823,6 @@ GENERATE_PERMUTATIONS_2_EVENTS(irqsafe1_soft_rlock)
 
 #include "locking-selftest-wlock-softirq.h"
 GENERATE_PERMUTATIONS_2_EVENTS(irqsafe1_soft_wlock)
-
 #endif
 
 #undef E1
@@ -876,14 +886,13 @@ GENERATE_PERMUTATIONS_2_EVENTS(irqsafe2A_rlock)
 #include "locking-selftest-spin-hardirq.h"
 GENERATE_PERMUTATIONS_2_EVENTS(irqsafe2B_hard_spin)
 
-#ifndef CONFIG_PREEMPT_RT
-
 #include "locking-selftest-rlock-hardirq.h"
 GENERATE_PERMUTATIONS_2_EVENTS(irqsafe2B_hard_rlock)
 
 #include "locking-selftest-wlock-hardirq.h"
 GENERATE_PERMUTATIONS_2_EVENTS(irqsafe2B_hard_wlock)
 
+#ifndef CONFIG_PREEMPT_RT
 #include "locking-selftest-spin-softirq.h"
 GENERATE_PERMUTATIONS_2_EVENTS(irqsafe2B_soft_spin)
 
@@ -892,7 +901,6 @@ GENERATE_PERMUTATIONS_2_EVENTS(irqsafe2B_soft_rlock)
 
 #include "locking-selftest-wlock-softirq.h"
 GENERATE_PERMUTATIONS_2_EVENTS(irqsafe2B_soft_wlock)
-
 #endif
 
 #undef E1
@@ -926,14 +934,13 @@ GENERATE_PERMUTATIONS_2_EVENTS(irqsafe2B_soft_wlock)
 #include "locking-selftest-spin-hardirq.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irqsafe3_hard_spin)
 
-#ifndef CONFIG_PREEMPT_RT
-
 #include "locking-selftest-rlock-hardirq.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irqsafe3_hard_rlock)
 
 #include "locking-selftest-wlock-hardirq.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irqsafe3_hard_wlock)
 
+#ifndef CONFIG_PREEMPT_RT
 #include "locking-selftest-spin-softirq.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irqsafe3_soft_spin)
 
@@ -942,7 +949,6 @@ GENERATE_PERMUTATIONS_3_EVENTS(irqsafe3_soft_rlock)
 
 #include "locking-selftest-wlock-softirq.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irqsafe3_soft_wlock)
-
 #endif
 
 #undef E1
@@ -978,14 +984,13 @@ GENERATE_PERMUTATIONS_3_EVENTS(irqsafe3_soft_wlock)
 #include "locking-selftest-spin-hardirq.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irqsafe4_hard_spin)
 
-#ifndef CONFIG_PREEMPT_RT
-
 #include "locking-selftest-rlock-hardirq.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irqsafe4_hard_rlock)
 
 #include "locking-selftest-wlock-hardirq.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irqsafe4_hard_wlock)
 
+#ifndef CONFIG_PREEMPT_RT
 #include "locking-selftest-spin-softirq.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irqsafe4_soft_spin)
 
@@ -994,15 +999,12 @@ GENERATE_PERMUTATIONS_3_EVENTS(irqsafe4_soft_rlock)
 
 #include "locking-selftest-wlock-softirq.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irqsafe4_soft_wlock)
-
 #endif
 
 #undef E1
 #undef E2
 #undef E3
 
-#ifndef CONFIG_PREEMPT_RT
-
 /*
  * read-lock / write-lock irq inversion.
  *
@@ -1052,6 +1054,7 @@ GENERATE_PERMUTATIONS_3_EVENTS(irq_inversion_hard_rlock)
 #include "locking-selftest-wlock-hardirq.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irq_inversion_hard_wlock)
 
+#ifndef CONFIG_PREEMPT_RT
 #include "locking-selftest-spin-softirq.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irq_inversion_soft_spin)
 
@@ -1060,6 +1063,7 @@ GENERATE_PERMUTATIONS_3_EVENTS(irq_inversion_soft_rlock)
 
 #include "locking-selftest-wlock-softirq.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irq_inversion_soft_wlock)
+#endif
 
 #undef E1
 #undef E2
@@ -1192,11 +1196,6 @@ GENERATE_PERMUTATIONS_3_EVENTS(W1W2_R2R3_R3W1)
 #undef E1
 #undef E2
 #undef E3
-
-#endif
-
-#ifndef CONFIG_PREEMPT_RT
-
 /*
  * read-lock / write-lock recursion that is actually safe.
  */
@@ -1232,19 +1231,19 @@ GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion_hard_rlock)
 #include "locking-selftest-wlock.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion_hard_wlock)
 
+#ifndef CONFIG_PREEMPT_RT
 #include "locking-selftest-softirq.h"
 #include "locking-selftest-rlock.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion_soft_rlock)
 
 #include "locking-selftest-wlock.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion_soft_wlock)
+#endif
 
 #undef E1
 #undef E2
 #undef E3
 
-#endif
-
 /*
  * read-lock / write-lock recursion that is unsafe.
  */
@@ -1280,12 +1279,14 @@ GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion2_hard_rlock)
 #include "locking-selftest-wlock.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion2_hard_wlock)
 
+#ifndef CONFIG_PREEMPT_RT
 #include "locking-selftest-softirq.h"
 #include "locking-selftest-rlock.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion2_soft_rlock)
 
 #include "locking-selftest-wlock.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion2_soft_wlock)
+#endif
 
 #undef E1
 #undef E2
@@ -1334,12 +1335,14 @@ GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion3_hard_rlock)
 #include "locking-selftest-wlock.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion3_hard_wlock)
 
+#ifndef CONFIG_PREEMPT_RT
 #include "locking-selftest-softirq.h"
 #include "locking-selftest-rlock.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion3_soft_rlock)
 
 #include "locking-selftest-wlock.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion3_soft_wlock)
+#endif
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 # define I_SPINLOCK(x)	lockdep_reset_lock(&lock_##x.dep_map)
@@ -1348,7 +1351,11 @@ GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion3_soft_wlock)
 # define I_MUTEX(x)	lockdep_reset_lock(&mutex_##x.dep_map)
 # define I_RWSEM(x)	lockdep_reset_lock(&rwsem_##x.dep_map)
 # define I_WW(x)	lockdep_reset_lock(&x.dep_map)
-# define I_LOCAL_LOCK(x) lockdep_reset_lock(&local_##x.dep_map)
+# ifdef CONFIG_PREEMPT_RT
+#  define I_LOCAL_LOCK(x) lockdep_reset_lock(this_cpu_ptr(&local_##x.lock.dep_map))
+# else
+#  define I_LOCAL_LOCK(x) lockdep_reset_lock(this_cpu_ptr(&local_##x.dep_map))
+# endif
 #ifdef CONFIG_RT_MUTEXES
 # define I_RTMUTEX(x)	lockdep_reset_lock(&rtmutex_##x.dep_map)
 #endif
@@ -1408,7 +1415,7 @@ static void reset_locks(void)
 	init_shared_classes();
 	raw_spin_lock_init(&raw_lock_A);
 	raw_spin_lock_init(&raw_lock_B);
-	local_lock_init(&local_A);
+	local_lock_init(this_cpu_ptr(&local_A));
 
 	ww_mutex_init(&o, &ww_lockdep); ww_mutex_init(&o2, &ww_lockdep); ww_mutex_init(&o3, &ww_lockdep);
 	memset(&t, 0, sizeof(t)); memset(&t2, 0, sizeof(t2));
@@ -1426,7 +1433,13 @@ static int unexpected_testcase_failures;
 
 static void dotest(void (*testcase_fn)(void), int expected, int lockclass_mask)
 {
-	unsigned long saved_preempt_count = preempt_count();
+	int saved_preempt_count = preempt_count();
+#ifdef CONFIG_PREEMPT_RT
+#ifdef CONFIG_SMP
+	int saved_mgd_count = current->migration_disabled;
+#endif
+	int saved_rcu_count = current->rcu_read_lock_nesting;
+#endif
 
 	WARN_ON(irqs_disabled());
 
@@ -1460,6 +1473,18 @@ static void dotest(void (*testcase_fn)(void), int expected, int lockclass_mask)
 	 * count, so restore it:
 	 */
 	preempt_count_set(saved_preempt_count);
+
+#ifdef CONFIG_PREEMPT_RT
+#ifdef CONFIG_SMP
+	while (current->migration_disabled > saved_mgd_count)
+		migrate_enable();
+#endif
+
+	while (current->rcu_read_lock_nesting > saved_rcu_count)
+		rcu_read_unlock();
+	WARN_ON_ONCE(current->rcu_read_lock_nesting < saved_rcu_count);
+#endif
+
 #ifdef CONFIG_TRACE_IRQFLAGS
 	if (softirq_count())
 		current->softirqs_enabled = 0;
@@ -1527,7 +1552,7 @@ static inline void print_testname(const char *testname)
 
 #define DO_TESTCASE_2x2RW(desc, name, nr)			\
 	DO_TESTCASE_2RW("hard-"desc, name##_hard, nr)		\
-	DO_TESTCASE_2RW("soft-"desc, name##_soft, nr)		\
+	NON_RT(DO_TESTCASE_2RW("soft-"desc, name##_soft, nr))	\
 
 #define DO_TESTCASE_6x2x2RW(desc, name)				\
 	DO_TESTCASE_2x2RW(desc, name, 123);			\
@@ -1575,19 +1600,19 @@ static inline void print_testname(const char *testname)
 
 #define DO_TESTCASE_2I(desc, name, nr)				\
 	DO_TESTCASE_1("hard-"desc, name##_hard, nr);		\
-	DO_TESTCASE_1("soft-"desc, name##_soft, nr);
+	NON_RT(DO_TESTCASE_1("soft-"desc, name##_soft, nr));
 
 #define DO_TESTCASE_2IB(desc, name, nr)				\
 	DO_TESTCASE_1B("hard-"desc, name##_hard, nr);		\
-	DO_TESTCASE_1B("soft-"desc, name##_soft, nr);
+	NON_RT(DO_TESTCASE_1B("soft-"desc, name##_soft, nr));
 
 #define DO_TESTCASE_6I(desc, name, nr)				\
 	DO_TESTCASE_3("hard-"desc, name##_hard, nr);		\
-	DO_TESTCASE_3("soft-"desc, name##_soft, nr);
+	NON_RT(DO_TESTCASE_3("soft-"desc, name##_soft, nr));
 
 #define DO_TESTCASE_6IRW(desc, name, nr)			\
 	DO_TESTCASE_3RW("hard-"desc, name##_hard, nr);		\
-	DO_TESTCASE_3RW("soft-"desc, name##_soft, nr);
+	NON_RT(DO_TESTCASE_3RW("soft-"desc, name##_soft, nr));
 
 #define DO_TESTCASE_2x3(desc, name)				\
 	DO_TESTCASE_3(desc, name, 12);				\
@@ -1679,6 +1704,20 @@ static void ww_test_fail_acquire(void)
 #endif
 }
 
+#ifdef CONFIG_PREEMPT_RT
+#define ww_mutex_base_lock(b)			rt_mutex_lock(b)
+#define ww_mutex_base_lock_nest_lock(b, b2)	rt_mutex_lock_nest_lock(b, b2)
+#define ww_mutex_base_lock_interruptible(b)	rt_mutex_lock_interruptible(b)
+#define ww_mutex_base_lock_killable(b)		rt_mutex_lock_killable(b)
+#define ww_mutex_base_unlock(b)			rt_mutex_unlock(b)
+#else
+#define ww_mutex_base_lock(b)			mutex_lock(b)
+#define ww_mutex_base_lock_nest_lock(b, b2)	mutex_lock_nest_lock(b, b2)
+#define ww_mutex_base_lock_interruptible(b)	mutex_lock_interruptible(b)
+#define ww_mutex_base_lock_killable(b)		mutex_lock_killable(b)
+#define ww_mutex_base_unlock(b)			mutex_unlock(b)
+#endif
+
 static void ww_test_normal(void)
 {
 	int ret;
@@ -1693,50 +1732,50 @@ static void ww_test_normal(void)
 
 	/* mutex_lock (and indirectly, mutex_lock_nested) */
 	o.ctx = (void *)~0UL;
-	mutex_lock(&o.base);
-	mutex_unlock(&o.base);
+	ww_mutex_base_lock(&o.base);
+	ww_mutex_base_unlock(&o.base);
 	WARN_ON(o.ctx != (void *)~0UL);
 
 	/* mutex_lock_interruptible (and *_nested) */
 	o.ctx = (void *)~0UL;
-	ret = mutex_lock_interruptible(&o.base);
+	ret = ww_mutex_base_lock_interruptible(&o.base);
 	if (!ret)
-		mutex_unlock(&o.base);
+		ww_mutex_base_unlock(&o.base);
 	else
 		WARN_ON(1);
 	WARN_ON(o.ctx != (void *)~0UL);
 
 	/* mutex_lock_killable (and *_nested) */
 	o.ctx = (void *)~0UL;
-	ret = mutex_lock_killable(&o.base);
+	ret = ww_mutex_base_lock_killable(&o.base);
 	if (!ret)
-		mutex_unlock(&o.base);
+		ww_mutex_base_unlock(&o.base);
 	else
 		WARN_ON(1);
 	WARN_ON(o.ctx != (void *)~0UL);
 
 	/* trylock, succeeding */
 	o.ctx = (void *)~0UL;
-	ret = mutex_trylock(&o.base);
+	ret = ww_mutex_base_trylock(&o.base);
 	WARN_ON(!ret);
 	if (ret)
-		mutex_unlock(&o.base);
+		ww_mutex_base_unlock(&o.base);
 	else
 		WARN_ON(1);
 	WARN_ON(o.ctx != (void *)~0UL);
 
 	/* trylock, failing */
 	o.ctx = (void *)~0UL;
-	mutex_lock(&o.base);
-	ret = mutex_trylock(&o.base);
+	ww_mutex_base_lock(&o.base);
+	ret = ww_mutex_base_trylock(&o.base);
 	WARN_ON(ret);
-	mutex_unlock(&o.base);
+	ww_mutex_base_unlock(&o.base);
 	WARN_ON(o.ctx != (void *)~0UL);
 
 	/* nest_lock */
 	o.ctx = (void *)~0UL;
-	mutex_lock_nest_lock(&o.base, &t);
-	mutex_unlock(&o.base);
+	ww_mutex_base_lock_nest_lock(&o.base, &t);
+	ww_mutex_base_unlock(&o.base);
 	WARN_ON(o.ctx != (void *)~0UL);
 }
 
@@ -1749,7 +1788,7 @@ static void ww_test_two_contexts(void)
 static void ww_test_diff_class(void)
 {
 	WWAI(&t);
-#ifdef CONFIG_DEBUG_MUTEXES
+#ifdef DEBUG_WW_MUTEXES
 	t.ww_class = NULL;
 #endif
 	WWL(&o, &t);
@@ -1813,7 +1852,7 @@ static void ww_test_edeadlk_normal(void)
 {
 	int ret;
 
-	mutex_lock(&o2.base);
+	ww_mutex_base_lock(&o2.base);
 	o2.ctx = &t2;
 	mutex_release(&o2.base.dep_map, _THIS_IP_);
 
@@ -1829,7 +1868,7 @@ static void ww_test_edeadlk_normal(void)
 
 	o2.ctx = NULL;
 	mutex_acquire(&o2.base.dep_map, 0, 1, _THIS_IP_);
-	mutex_unlock(&o2.base);
+	ww_mutex_base_unlock(&o2.base);
 	WWU(&o);
 
 	WWL(&o2, &t);
@@ -1839,7 +1878,7 @@ static void ww_test_edeadlk_normal_slow(void)
 {
 	int ret;
 
-	mutex_lock(&o2.base);
+	ww_mutex_base_lock(&o2.base);
 	mutex_release(&o2.base.dep_map, _THIS_IP_);
 	o2.ctx = &t2;
 
@@ -1855,7 +1894,7 @@ static void ww_test_edeadlk_normal_slow(void)
 
 	o2.ctx = NULL;
 	mutex_acquire(&o2.base.dep_map, 0, 1, _THIS_IP_);
-	mutex_unlock(&o2.base);
+	ww_mutex_base_unlock(&o2.base);
 	WWU(&o);
 
 	ww_mutex_lock_slow(&o2, &t);
@@ -1865,7 +1904,7 @@ static void ww_test_edeadlk_no_unlock(void)
 {
 	int ret;
 
-	mutex_lock(&o2.base);
+	ww_mutex_base_lock(&o2.base);
 	o2.ctx = &t2;
 	mutex_release(&o2.base.dep_map, _THIS_IP_);
 
@@ -1881,7 +1920,7 @@ static void ww_test_edeadlk_no_unlock(void)
 
 	o2.ctx = NULL;
 	mutex_acquire(&o2.base.dep_map, 0, 1, _THIS_IP_);
-	mutex_unlock(&o2.base);
+	ww_mutex_base_unlock(&o2.base);
 
 	WWL(&o2, &t);
 }
@@ -1890,7 +1929,7 @@ static void ww_test_edeadlk_no_unlock_slow(void)
 {
 	int ret;
 
-	mutex_lock(&o2.base);
+	ww_mutex_base_lock(&o2.base);
 	mutex_release(&o2.base.dep_map, _THIS_IP_);
 	o2.ctx = &t2;
 
@@ -1906,7 +1945,7 @@ static void ww_test_edeadlk_no_unlock_slow(void)
 
 	o2.ctx = NULL;
 	mutex_acquire(&o2.base.dep_map, 0, 1, _THIS_IP_);
-	mutex_unlock(&o2.base);
+	ww_mutex_base_unlock(&o2.base);
 
 	ww_mutex_lock_slow(&o2, &t);
 }
@@ -1915,7 +1954,7 @@ static void ww_test_edeadlk_acquire_more(void)
 {
 	int ret;
 
-	mutex_lock(&o2.base);
+	ww_mutex_base_lock(&o2.base);
 	mutex_release(&o2.base.dep_map, _THIS_IP_);
 	o2.ctx = &t2;
 
@@ -1936,7 +1975,7 @@ static void ww_test_edeadlk_acquire_more_slow(void)
 {
 	int ret;
 
-	mutex_lock(&o2.base);
+	ww_mutex_base_lock(&o2.base);
 	mutex_release(&o2.base.dep_map, _THIS_IP_);
 	o2.ctx = &t2;
 
@@ -1957,11 +1996,11 @@ static void ww_test_edeadlk_acquire_more_edeadlk(void)
 {
 	int ret;
 
-	mutex_lock(&o2.base);
+	ww_mutex_base_lock(&o2.base);
 	mutex_release(&o2.base.dep_map, _THIS_IP_);
 	o2.ctx = &t2;
 
-	mutex_lock(&o3.base);
+	ww_mutex_base_lock(&o3.base);
 	mutex_release(&o3.base.dep_map, _THIS_IP_);
 	o3.ctx = &t2;
 
@@ -1983,11 +2022,11 @@ static void ww_test_edeadlk_acquire_more_edeadlk_slow(void)
 {
 	int ret;
 
-	mutex_lock(&o2.base);
+	ww_mutex_base_lock(&o2.base);
 	mutex_release(&o2.base.dep_map, _THIS_IP_);
 	o2.ctx = &t2;
 
-	mutex_lock(&o3.base);
+	ww_mutex_base_lock(&o3.base);
 	mutex_release(&o3.base.dep_map, _THIS_IP_);
 	o3.ctx = &t2;
 
@@ -2008,7 +2047,7 @@ static void ww_test_edeadlk_acquire_wrong(void)
 {
 	int ret;
 
-	mutex_lock(&o2.base);
+	ww_mutex_base_lock(&o2.base);
 	mutex_release(&o2.base.dep_map, _THIS_IP_);
 	o2.ctx = &t2;
 
@@ -2033,7 +2072,7 @@ static void ww_test_edeadlk_acquire_wrong_slow(void)
 {
 	int ret;
 
-	mutex_lock(&o2.base);
+	ww_mutex_base_lock(&o2.base);
 	mutex_release(&o2.base.dep_map, _THIS_IP_);
 	o2.ctx = &t2;
 
@@ -2674,8 +2713,8 @@ static void wait_context_tests(void)
 
 static void local_lock_2(void)
 {
-	local_lock_acquire(&local_A);	/* IRQ-ON */
-	local_lock_release(&local_A);
+	local_lock(&local_A);	/* IRQ-ON */
+	local_unlock(&local_A);
 
 	HARDIRQ_ENTER();
 	spin_lock(&lock_A);		/* IN-IRQ */
@@ -2684,18 +2723,18 @@ static void local_lock_2(void)
 
 	HARDIRQ_DISABLE();
 	spin_lock(&lock_A);
-	local_lock_acquire(&local_A);	/* IN-IRQ <-> IRQ-ON cycle, false */
-	local_lock_release(&local_A);
+	local_lock(&local_A);	/* IN-IRQ <-> IRQ-ON cycle, false */
+	local_unlock(&local_A);
 	spin_unlock(&lock_A);
 	HARDIRQ_ENABLE();
 }
 
 static void local_lock_3A(void)
 {
-	local_lock_acquire(&local_A);	/* IRQ-ON */
+	local_lock(&local_A);	/* IRQ-ON */
 	spin_lock(&lock_B);		/* IRQ-ON */
 	spin_unlock(&lock_B);
-	local_lock_release(&local_A);
+	local_unlock(&local_A);
 
 	HARDIRQ_ENTER();
 	spin_lock(&lock_A);		/* IN-IRQ */
@@ -2704,18 +2743,18 @@ static void local_lock_3A(void)
 
 	HARDIRQ_DISABLE();
 	spin_lock(&lock_A);
-	local_lock_acquire(&local_A);	/* IN-IRQ <-> IRQ-ON cycle only if we count local_lock(), false */
-	local_lock_release(&local_A);
+	local_lock(&local_A);	/* IN-IRQ <-> IRQ-ON cycle only if we count local_lock(), false */
+	local_unlock(&local_A);
 	spin_unlock(&lock_A);
 	HARDIRQ_ENABLE();
 }
 
 static void local_lock_3B(void)
 {
-	local_lock_acquire(&local_A);	/* IRQ-ON */
+	local_lock(&local_A);	/* IRQ-ON */
 	spin_lock(&lock_B);		/* IRQ-ON */
 	spin_unlock(&lock_B);
-	local_lock_release(&local_A);
+	local_unlock(&local_A);
 
 	HARDIRQ_ENTER();
 	spin_lock(&lock_A);		/* IN-IRQ */
@@ -2724,8 +2763,8 @@ static void local_lock_3B(void)
 
 	HARDIRQ_DISABLE();
 	spin_lock(&lock_A);
-	local_lock_acquire(&local_A);	/* IN-IRQ <-> IRQ-ON cycle only if we count local_lock(), false */
-	local_lock_release(&local_A);
+	local_lock(&local_A);	/* IN-IRQ <-> IRQ-ON cycle only if we count local_lock(), false */
+	local_unlock(&local_A);
 	spin_unlock(&lock_A);
 	HARDIRQ_ENABLE();
 
@@ -2840,7 +2879,7 @@ void locking_selftest(void)
 	printk("------------------------\n");
 	printk("| Locking API testsuite:\n");
 	printk("----------------------------------------------------------------------------\n");
-	printk("                                 | spin |wlock |rlock |mutex | wsem | rsem |\n");
+	printk("                                 | spin |wlock |rlock |mutex | wsem | rsem |rtmutex\n");
 	printk("  --------------------------------------------------------------------------\n");
 
 	init_shared_classes();
@@ -2913,13 +2952,11 @@ void locking_selftest(void)
 	DO_TESTCASE_6x1RR("rlock W1R2/R2R3/W3W1", W1R2_R2R3_W3W1);
 
 	printk("  --------------------------------------------------------------------------\n");
-
-#ifndef CONFIG_PREEMPT_RT
 	/*
 	 * irq-context testcases:
 	 */
 	DO_TESTCASE_2x6("irqs-on + irq-safe-A", irqsafe1);
-	DO_TESTCASE_2x3("sirq-safe-A => hirqs-on", irqsafe2A);
+	NON_RT(DO_TESTCASE_2x3("sirq-safe-A => hirqs-on", irqsafe2A));
 	DO_TESTCASE_2x6("safe-A + irqs-on", irqsafe2B);
 	DO_TESTCASE_6x6("safe-A + unsafe-B #1", irqsafe3);
 	DO_TESTCASE_6x6("safe-A + unsafe-B #2", irqsafe4);
@@ -2929,28 +2966,6 @@ void locking_selftest(void)
 	DO_TESTCASE_6x2x2RW("irq read-recursion #2", irq_read_recursion2);
 	DO_TESTCASE_6x2x2RW("irq read-recursion #3", irq_read_recursion3);
 
-#else
-	/* On -rt, we only do hardirq context test for raw spinlock */
-	DO_TESTCASE_1B("hard-irqs-on + irq-safe-A", irqsafe1_hard_spin, 12);
-	DO_TESTCASE_1B("hard-irqs-on + irq-safe-A", irqsafe1_hard_spin, 21);
-
-	DO_TESTCASE_1B("hard-safe-A + irqs-on", irqsafe2B_hard_spin, 12);
-	DO_TESTCASE_1B("hard-safe-A + irqs-on", irqsafe2B_hard_spin, 21);
-
-	DO_TESTCASE_1B("hard-safe-A + unsafe-B #1", irqsafe3_hard_spin, 123);
-	DO_TESTCASE_1B("hard-safe-A + unsafe-B #1", irqsafe3_hard_spin, 132);
-	DO_TESTCASE_1B("hard-safe-A + unsafe-B #1", irqsafe3_hard_spin, 213);
-	DO_TESTCASE_1B("hard-safe-A + unsafe-B #1", irqsafe3_hard_spin, 231);
-	DO_TESTCASE_1B("hard-safe-A + unsafe-B #1", irqsafe3_hard_spin, 312);
-	DO_TESTCASE_1B("hard-safe-A + unsafe-B #1", irqsafe3_hard_spin, 321);
-
-	DO_TESTCASE_1B("hard-safe-A + unsafe-B #2", irqsafe4_hard_spin, 123);
-	DO_TESTCASE_1B("hard-safe-A + unsafe-B #2", irqsafe4_hard_spin, 132);
-	DO_TESTCASE_1B("hard-safe-A + unsafe-B #2", irqsafe4_hard_spin, 213);
-	DO_TESTCASE_1B("hard-safe-A + unsafe-B #2", irqsafe4_hard_spin, 231);
-	DO_TESTCASE_1B("hard-safe-A + unsafe-B #2", irqsafe4_hard_spin, 312);
-	DO_TESTCASE_1B("hard-safe-A + unsafe-B #2", irqsafe4_hard_spin, 321);
-#endif
 	ww_tests();
 
 	force_read_lock_recursive = 0;
diff --git a/localversion-rt b/localversion-rt
index 22746d6390a42..d79dde624aaac 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt9
+-rt10
