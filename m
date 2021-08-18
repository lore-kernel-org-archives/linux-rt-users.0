Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D645C4338F
	for <linux-rt-users@archiver.kernel.org>; Wed, 18 Aug 2021 09:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F3966108D
	for <linux-rt-users@archiver.kernel.org>; Wed, 18 Aug 2021 09:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbhHRJCR (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 18 Aug 2021 05:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbhHRJCO (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 18 Aug 2021 05:02:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3022DC061764;
        Wed, 18 Aug 2021 02:01:40 -0700 (PDT)
Date:   Wed, 18 Aug 2021 11:01:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629277296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=Z4/b4auC0clY8G2dOp65pTgLSNOj6Plh/iqeSFiscFg=;
        b=0IO5NQ+9sa4oV1pAdKA04lQDQqTkvQlDdEZ2sxI4ALvfkOIBvyjUIw/hQkFqQc+Je4t/Y9
        DomDZ/4P6OLmfRPX0RTDLQwI4gwmMvFVEGSSJbPbz+ggKFyJ193Y/lAztERuBQJQNsPpCF
        lHgKmBKFBtTRznYvQjaDmEqf9xj6g6TFQEa2dCO2CZ20z7q0DaBhKvYOx2+hjA1yiBuEDK
        OOpkzWhRLj54uWGZ6s+1xhd5xGOX7NN8CxFjdwfsNSXMoBK5rk2HWNzwr8LKgDxn199pjO
        VmB7b5nvxvh9+jVtylys3EVfHlq7ZXBOghik6ruANm53zWZNQMcc4TM6tnZBhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629277296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=Z4/b4auC0clY8G2dOp65pTgLSNOj6Plh/iqeSFiscFg=;
        b=/qBKf2SVU60TUMbRVkk3BxLfzxcS2tpYMliq4xu16bkeRn42RNuqqeXoXHGJR6dcXEx4EH
        o05SKhb/wOGgCtCA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.14-rc6-rt11
Message-ID: <20210818090135.zdh3k4w2xkhzktax@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.14-rc6-rt11 patch set. 

Changes since v5.14-rc6-rt10:

  - The RCU & ARM64 patches by Valentin Schneider have been updated to
    v3. The logic in migratable() for UP has been changed and the
    function itself was renamed (which is different as posted to the
    list).

  - The printk.h includes a locking header directly. This unbreaks the
    POWER and POWER64 build and makes another patch (an earlier attempt
    to unbreak recursive includes) obsolete.

  - Update the SLUB series by Vlastimil Babka to slub-local-lock-v4r4:

      - Clark Williams reported a crash in the SLUB memory allocator. It
	was there since the SLUB rework in v5.13-rt1. Patch by Vlastimil
        Babka.
    
      - Sven Eckelmann reported a crash on non-RT with LOCKSTAT enabled.
        Patch by Vlastimil Babka.

  - rcutorture works again. Patch by Valentin Schneider.

  - Update RT's locking patches to what has been merge tip/locking/core.
    A visible change is the definition of local_lock_t on PREEMPT_RT. As
    a result the access to local_lock_t's dep_map is the same on RT &
    !RT.

Known issues
     - netconsole triggers WARN.

     - The "Memory controller" (CONFIG_MEMCG) has been disabled.

     - A RCU and ARM64 warning has been fixed by Valentin Schneider. It is
       still not clear if the RCU related change is correct.

     - Clark Williams reported issues in i915 (execlists_dequeue_irq())

     - Clark Williams reported issues with kcov enabled.

     - Valentin Schneider reported a few splats on ARM64, see
          https://https://lkml.kernel.org/r/.kernel.org/lkml/20210810134127.1394269-1-valentin.schneider@arm.com/

The delta patch against v5.14-rc6-rt10 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.14/incr/patch-5.14-rc6-rt10-rt11.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.14-rc6-rt11

The RT patch against v5.14-rc6 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.14/older/patch-5.14-rc6-rt11.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.14/older/patches-5.14-rc6-rt11.tar.xz

Sebastian

diff --git a/arch/alpha/include/asm/spinlock_types.h b/arch/alpha/include/asm/spinlock_types.h
index 1d5716bc060be..2526fd3be5fd7 100644
--- a/arch/alpha/include/asm/spinlock_types.h
+++ b/arch/alpha/include/asm/spinlock_types.h
@@ -2,7 +2,7 @@
 #ifndef _ALPHA_SPINLOCK_TYPES_H
 #define _ALPHA_SPINLOCK_TYPES_H
 
-#ifndef __LINUX_SPINLOCK_TYPES_H
+#ifndef __LINUX_SPINLOCK_TYPES_RAW_H
 # error "please don't include this file directly"
 #endif
 
diff --git a/arch/arm/include/asm/spinlock_types.h b/arch/arm/include/asm/spinlock_types.h
index 5976958647fe1..0c14b36ef1013 100644
--- a/arch/arm/include/asm/spinlock_types.h
+++ b/arch/arm/include/asm/spinlock_types.h
@@ -2,7 +2,7 @@
 #ifndef __ASM_SPINLOCK_TYPES_H
 #define __ASM_SPINLOCK_TYPES_H
 
-#ifndef __LINUX_SPINLOCK_TYPES_H
+#ifndef __LINUX_SPINLOCK_TYPES_RAW_H
 # error "please don't include this file directly"
 #endif
 
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 767a064beddeb..33eb9c4264bb7 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -995,7 +995,7 @@ static inline void update_mmu_cache(struct vm_area_struct *vma,
  */
 static inline bool arch_faults_on_old_pte(void)
 {
-	WARN_ON(!is_pcpu_safe());
+	WARN_ON(is_migratable());
 
 	return !cpu_has_hw_af();
 }
diff --git a/arch/arm64/include/asm/spinlock_types.h b/arch/arm64/include/asm/spinlock_types.h
index 18782f0c47212..11ab1c0776977 100644
--- a/arch/arm64/include/asm/spinlock_types.h
+++ b/arch/arm64/include/asm/spinlock_types.h
@@ -5,7 +5,7 @@
 #ifndef __ASM_SPINLOCK_TYPES_H
 #define __ASM_SPINLOCK_TYPES_H
 
-#if !defined(__LINUX_SPINLOCK_TYPES_H) && !defined(__ASM_SPINLOCK_H)
+#if !defined(__LINUX_SPINLOCK_TYPES_RAW_H) && !defined(__ASM_SPINLOCK_H)
 # error "please don't include this file directly"
 #endif
 
diff --git a/arch/csky/include/asm/spinlock_types.h b/arch/csky/include/asm/spinlock_types.h
index 8ff0f6ff3a006..db87a12c3827d 100644
--- a/arch/csky/include/asm/spinlock_types.h
+++ b/arch/csky/include/asm/spinlock_types.h
@@ -3,7 +3,7 @@
 #ifndef __ASM_CSKY_SPINLOCK_TYPES_H
 #define __ASM_CSKY_SPINLOCK_TYPES_H
 
-#ifndef __LINUX_SPINLOCK_TYPES_H
+#ifndef __LINUX_SPINLOCK_TYPES_RAW_H
 # error "please don't include this file directly"
 #endif
 
diff --git a/arch/hexagon/include/asm/spinlock_types.h b/arch/hexagon/include/asm/spinlock_types.h
index 19d233497ba52..d5f66495b670f 100644
--- a/arch/hexagon/include/asm/spinlock_types.h
+++ b/arch/hexagon/include/asm/spinlock_types.h
@@ -8,7 +8,7 @@
 #ifndef _ASM_SPINLOCK_TYPES_H
 #define _ASM_SPINLOCK_TYPES_H
 
-#ifndef __LINUX_SPINLOCK_TYPES_H
+#ifndef __LINUX_SPINLOCK_TYPES_RAW_H
 # error "please don't include this file directly"
 #endif
 
diff --git a/arch/ia64/include/asm/spinlock_types.h b/arch/ia64/include/asm/spinlock_types.h
index 6e345fefcdcab..14b8a161c1652 100644
--- a/arch/ia64/include/asm/spinlock_types.h
+++ b/arch/ia64/include/asm/spinlock_types.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_IA64_SPINLOCK_TYPES_H
 #define _ASM_IA64_SPINLOCK_TYPES_H
 
-#ifndef __LINUX_SPINLOCK_TYPES_H
+#ifndef __LINUX_SPINLOCK_TYPES_RAW_H
 # error "please don't include this file directly"
 #endif
 
diff --git a/arch/powerpc/include/asm/cmpxchg.h b/arch/powerpc/include/asm/cmpxchg.h
index 10b0abcdac563..05f246c0e36eb 100644
--- a/arch/powerpc/include/asm/cmpxchg.h
+++ b/arch/powerpc/include/asm/cmpxchg.h
@@ -5,7 +5,7 @@
 #ifdef __KERNEL__
 #include <linux/compiler.h>
 #include <asm/synch.h>
-#include <linux/bits.h>
+#include <linux/bug.h>
 
 #ifdef __BIG_ENDIAN
 #define BITOFF_CAL(size, off)	((sizeof(u32) - size - off) * BITS_PER_BYTE)
diff --git a/arch/powerpc/include/asm/simple_spinlock_types.h b/arch/powerpc/include/asm/simple_spinlock_types.h
index d45561e9e6bab..08243338069d2 100644
--- a/arch/powerpc/include/asm/simple_spinlock_types.h
+++ b/arch/powerpc/include/asm/simple_spinlock_types.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_POWERPC_SIMPLE_SPINLOCK_TYPES_H
 #define _ASM_POWERPC_SIMPLE_SPINLOCK_TYPES_H
 
-#if !defined(__LINUX_SPINLOCK_TYPES_H) && !defined(__LINUX_RT_MUTEX_H)
+#ifndef __LINUX_SPINLOCK_TYPES_RAW_H
 # error "please don't include this file directly"
 #endif
 
diff --git a/arch/powerpc/include/asm/spinlock_types.h b/arch/powerpc/include/asm/spinlock_types.h
index c5d742f18021d..d5f8a74ed2e8c 100644
--- a/arch/powerpc/include/asm/spinlock_types.h
+++ b/arch/powerpc/include/asm/spinlock_types.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_POWERPC_SPINLOCK_TYPES_H
 #define _ASM_POWERPC_SPINLOCK_TYPES_H
 
-#ifndef __LINUX_SPINLOCK_TYPES_H
+#ifndef __LINUX_SPINLOCK_TYPES_RAW_H
 # error "please don't include this file directly"
 #endif
 
diff --git a/arch/riscv/include/asm/spinlock_types.h b/arch/riscv/include/asm/spinlock_types.h
index f398e7638dd63..5a35a49505da2 100644
--- a/arch/riscv/include/asm/spinlock_types.h
+++ b/arch/riscv/include/asm/spinlock_types.h
@@ -6,7 +6,7 @@
 #ifndef _ASM_RISCV_SPINLOCK_TYPES_H
 #define _ASM_RISCV_SPINLOCK_TYPES_H
 
-#ifndef __LINUX_SPINLOCK_TYPES_H
+#ifndef __LINUX_SPINLOCK_TYPES_RAW_H
 # error "please don't include this file directly"
 #endif
 
diff --git a/arch/s390/include/asm/spinlock_types.h b/arch/s390/include/asm/spinlock_types.h
index a2bbfd7df85fa..b69695e399574 100644
--- a/arch/s390/include/asm/spinlock_types.h
+++ b/arch/s390/include/asm/spinlock_types.h
@@ -2,7 +2,7 @@
 #ifndef __ASM_SPINLOCK_TYPES_H
 #define __ASM_SPINLOCK_TYPES_H
 
-#ifndef __LINUX_SPINLOCK_TYPES_H
+#ifndef __LINUX_SPINLOCK_TYPES_RAW_H
 # error "please don't include this file directly"
 #endif
 
diff --git a/arch/sh/include/asm/spinlock_types.h b/arch/sh/include/asm/spinlock_types.h
index e82369f286a20..907bda4b1619a 100644
--- a/arch/sh/include/asm/spinlock_types.h
+++ b/arch/sh/include/asm/spinlock_types.h
@@ -2,7 +2,7 @@
 #ifndef __ASM_SH_SPINLOCK_TYPES_H
 #define __ASM_SH_SPINLOCK_TYPES_H
 
-#ifndef __LINUX_SPINLOCK_TYPES_H
+#ifndef __LINUX_SPINLOCK_TYPES_RAW_H
 # error "please don't include this file directly"
 #endif
 
diff --git a/arch/xtensa/include/asm/spinlock_types.h b/arch/xtensa/include/asm/spinlock_types.h
index 64c9389254f13..797aed7df3dd8 100644
--- a/arch/xtensa/include/asm/spinlock_types.h
+++ b/arch/xtensa/include/asm/spinlock_types.h
@@ -2,7 +2,7 @@
 #ifndef __ASM_SPINLOCK_TYPES_H
 #define __ASM_SPINLOCK_TYPES_H
 
-#if !defined(__LINUX_SPINLOCK_TYPES_H) && !defined(__ASM_SPINLOCK_H)
+#if !defined(__LINUX_SPINLOCK_TYPES_RAW_H) && !defined(__ASM_SPINLOCK_H)
 # error "please don't include this file directly"
 #endif
 
diff --git a/include/linux/local_lock_internal.h b/include/linux/local_lock_internal.h
index 4739a3061e107..975e33b793a77 100644
--- a/include/linux/local_lock_internal.h
+++ b/include/linux/local_lock_internal.h
@@ -101,26 +101,22 @@ do {								\
 #else /* !CONFIG_PREEMPT_RT */
 
 /*
- * On PREEMPT_RT local_lock maps to a per CPU spinlock which protects the
+ * On PREEMPT_RT local_lock maps to a per CPU spinlock, which protects the
  * critical section while staying preemptible.
  */
-typedef struct {
-	spinlock_t		lock;
-} local_lock_t;
+typedef spinlock_t local_lock_t;
 
-#define INIT_LOCAL_LOCK(lockname) {				\
-		__LOCAL_SPIN_LOCK_UNLOCKED((lockname).lock)	\
-	}
+#define INIT_LOCAL_LOCK(lockname) __LOCAL_SPIN_LOCK_UNLOCKED((lockname))
 
 #define __local_lock_init(l)					\
 	do {							\
-		local_spin_lock_init(&(l)->lock);		\
+		local_spin_lock_init((l));			\
 	} while (0)
 
 #define __local_lock(__lock)					\
 	do {							\
 		migrate_disable();				\
-		spin_lock(&(this_cpu_ptr((__lock)))->lock);	\
+		spin_lock(this_cpu_ptr((__lock)));		\
 	} while (0)
 
 #define __local_lock_irq(lock)			__local_lock(lock)
@@ -134,7 +130,7 @@ typedef struct {
 
 #define __local_unlock(__lock)					\
 	do {							\
-		spin_unlock(&(this_cpu_ptr((__lock)))->lock);	\
+		spin_unlock(this_cpu_ptr((__lock)));		\
 		migrate_enable();				\
 	} while (0)
 
diff --git a/include/linux/notifier.h b/include/linux/notifier.h
index 723bc2df63882..87069b8459af9 100644
--- a/include/linux/notifier.h
+++ b/include/linux/notifier.h
@@ -58,7 +58,7 @@ struct notifier_block {
 };
 
 struct atomic_notifier_head {
-	raw_spinlock_t lock;
+	spinlock_t lock;
 	struct notifier_block __rcu *head;
 };
 
@@ -78,7 +78,7 @@ struct srcu_notifier_head {
 };
 
 #define ATOMIC_INIT_NOTIFIER_HEAD(name) do {	\
-		raw_spin_lock_init(&(name)->lock);	\
+		spin_lock_init(&(name)->lock);	\
 		(name)->head = NULL;		\
 	} while (0)
 #define BLOCKING_INIT_NOTIFIER_HEAD(name) do {	\
@@ -95,7 +95,7 @@ extern void srcu_init_notifier_head(struct srcu_notifier_head *nh);
 		cleanup_srcu_struct(&(name)->srcu);
 
 #define ATOMIC_NOTIFIER_INIT(name) {				\
-		.lock = __RAW_SPIN_LOCK_UNLOCKED(name.lock),	\
+		.lock = __SPIN_LOCK_UNLOCKED(name.lock),	\
 		.head = NULL }
 #define BLOCKING_NOTIFIER_INIT(name) {				\
 		.rwsem = __RWSEM_INITIALIZER((name).rwsem),	\
@@ -168,8 +168,6 @@ extern int raw_notifier_call_chain(struct raw_notifier_head *nh,
 extern int srcu_notifier_call_chain(struct srcu_notifier_head *nh,
 		unsigned long val, void *v);
 
-extern int atomic_notifier_call_chain_robust(struct atomic_notifier_head *nh,
-		unsigned long val_up, unsigned long val_down, void *v);
 extern int blocking_notifier_call_chain_robust(struct blocking_notifier_head *nh,
 		unsigned long val_up, unsigned long val_down, void *v);
 extern int raw_notifier_call_chain_robust(struct raw_notifier_head *nh,
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 5922031ffab6e..7fda4fb85bdca 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -815,6 +815,15 @@ static inline int PageSlabPfmemalloc(struct page *page)
 	return PageActive(page);
 }
 
+/*
+ * A version of PageSlabPfmemalloc() for opportunistic checks where the page
+ * might have been freed under us and not be a PageSlab anymore.
+ */
+static inline int __PageSlabPfmemalloc(struct page *page)
+{
+	return PageActive(page);
+}
+
 static inline void SetPageSlabPfmemalloc(struct page *page)
 {
 	VM_BUG_ON_PAGE(!PageSlab(page), page);
diff --git a/include/linux/ratelimit_types.h b/include/linux/ratelimit_types.h
index b676aa419eef8..c21c7f8103e2b 100644
--- a/include/linux/ratelimit_types.h
+++ b/include/linux/ratelimit_types.h
@@ -4,7 +4,7 @@
 
 #include <linux/bits.h>
 #include <linux/param.h>
-#include <linux/spinlock_types.h>
+#include <linux/spinlock_types_raw.h>
 
 #define DEFAULT_RATELIMIT_INTERVAL	(5 * HZ)
 #define DEFAULT_RATELIMIT_BURST		10
diff --git a/include/linux/rbtree.h b/include/linux/rbtree.h
index 36a0e7226ec56..235047d7a1b5e 100644
--- a/include/linux/rbtree.h
+++ b/include/linux/rbtree.h
@@ -17,9 +17,10 @@
 #ifndef	_LINUX_RBTREE_H
 #define	_LINUX_RBTREE_H
 
+#include <linux/rbtree_types.h>
+
 #include <linux/kernel.h>
 #include <linux/stddef.h>
-#include <linux/rbtree_types.h>
 #include <linux/rcupdate.h>
 
 #define rb_parent(r)   ((struct rb_node *)((r)->__rb_parent_color & ~3))
diff --git a/include/linux/rwbase_rt.h b/include/linux/rwbase_rt.h
index 44573dcfaf643..1d264dd086250 100644
--- a/include/linux/rwbase_rt.h
+++ b/include/linux/rwbase_rt.h
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
-#ifndef _LINUX_RW_BASE_RT_H
-#define _LINUX_RW_BASE_RT_H
+#ifndef _LINUX_RWBASE_RT_H
+#define _LINUX_RWBASE_RT_H
 
 #include <linux/rtmutex.h>
 #include <linux/atomic.h>
@@ -35,4 +35,5 @@ static __always_inline bool rw_base_is_contended(struct rwbase_rt *rwb)
 {
 	return atomic_read(&rwb->readers) > 0;
 }
-#endif
+
+#endif /* _LINUX_RWBASE_RT_H */
diff --git a/include/linux/rwlock_rt.h b/include/linux/rwlock_rt.h
index 38048bf7d0636..49c1f3842ed5b 100644
--- a/include/linux/rwlock_rt.h
+++ b/include/linux/rwlock_rt.h
@@ -3,7 +3,7 @@
 #define __LINUX_RWLOCK_RT_H
 
 #ifndef __LINUX_SPINLOCK_RT_H
-#error Do not include directly. Use spinlock.h
+#error Do not #include directly. Use <linux/spinlock.h>.
 #endif
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
@@ -20,7 +20,7 @@ static inline void __rt_rwlock_init(rwlock_t *rwlock, char *name,
 do {							\
 	static struct lock_class_key __key;		\
 							\
-	init_rwbase_rt(&(rwl)->rwbase);		\
+	init_rwbase_rt(&(rwl)->rwbase);			\
 	__rt_rwlock_init(rwl, #rwl, &__key);		\
 } while (0)
 
@@ -137,4 +137,4 @@ static __always_inline void write_unlock_irqrestore(rwlock_t *rwlock,
 
 #define rwlock_is_contended(lock)		(((void)(lock), 0))
 
-#endif
+#endif /* __LINUX_RWLOCK_RT_H */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index b77d65f677f66..cd28dd2004af1 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1715,13 +1715,13 @@ static inline bool is_percpu_thread(void)
 #endif
 }
 
-/* Is the current task guaranteed not to be migrated elsewhere? */
-static inline bool is_pcpu_safe(void)
+/* Is the current task guaranteed to stay on its current CPU? */
+static inline bool is_migratable(void)
 {
 #ifdef CONFIG_SMP
-	return !preemptible() || is_percpu_thread() || current->migration_disabled;
+	return preemptible() && !current->migration_disabled;
 #else
-	return true;
+	return false;
 #endif
 }
 
diff --git a/include/linux/sched/wake_q.h b/include/linux/sched/wake_q.h
index 8e57a6660aad1..06cd8fb2f4098 100644
--- a/include/linux/sched/wake_q.h
+++ b/include/linux/sched/wake_q.h
@@ -62,4 +62,5 @@ static inline bool wake_q_empty(struct wake_q_head *head)
 extern void wake_q_add(struct wake_q_head *head, struct task_struct *task);
 extern void wake_q_add_safe(struct wake_q_head *head, struct task_struct *task);
 extern void wake_up_q(struct wake_q_head *head);
+
 #endif /* _LINUX_SCHED_WAKE_Q_H */
diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
index b5bcac29b979c..85499f0586b06 100644
--- a/include/linux/slub_def.h
+++ b/include/linux/slub_def.h
@@ -41,14 +41,18 @@ enum stat_item {
 	CPU_PARTIAL_DRAIN,	/* Drain cpu partial to node partial */
 	NR_SLUB_STAT_ITEMS };
 
+/*
+ * When changing the layout, make sure freelist and tid are still compatible
+ * with this_cpu_cmpxchg_double() alignment requirements.
+ */
 struct kmem_cache_cpu {
-	local_lock_t lock;	/* Protects the fields below except stat */
 	void **freelist;	/* Pointer to next available object */
 	unsigned long tid;	/* Globally unique transaction id */
 	struct page *page;	/* The slab from which we are allocating */
 #ifdef CONFIG_SLUB_CPU_PARTIAL
 	struct page *partial;	/* Partially allocated frozen slabs */
 #endif
+	local_lock_t lock;	/* Protects the fields above */
 #ifdef CONFIG_SLUB_STATS
 	unsigned stat[NR_SLUB_STAT_ITEMS];
 #endif
diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index 23925a6c489b1..45310ea1b1d78 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -326,7 +326,7 @@ static inline void do_raw_spin_unlock(raw_spinlock_t *lock) __releases(lock)
 # include <linux/spinlock_api_up.h>
 #endif
 
-/* Non PREEMPT_RT kernel map to raw spinlocks */
+/* Non PREEMPT_RT kernel, map to raw spinlocks: */
 #ifndef CONFIG_PREEMPT_RT
 
 /*
diff --git a/include/linux/spinlock_api_smp.h b/include/linux/spinlock_api_smp.h
index 51bf88c841339..6b8e1a0b137bd 100644
--- a/include/linux/spinlock_api_smp.h
+++ b/include/linux/spinlock_api_smp.h
@@ -187,7 +187,7 @@ static inline int __raw_spin_trylock_bh(raw_spinlock_t *lock)
 	return 0;
 }
 
-/* PREEMPT_RT has it's own rwlock implementation */
+/* PREEMPT_RT has its own rwlock implementation */
 #ifndef CONFIG_PREEMPT_RT
 #include <linux/rwlock_api_smp.h>
 #endif
diff --git a/include/linux/spinlock_types_raw.h b/include/linux/spinlock_types_raw.h
index 1b49628736c2b..91cb36b65a170 100644
--- a/include/linux/spinlock_types_raw.h
+++ b/include/linux/spinlock_types_raw.h
@@ -70,4 +70,4 @@ typedef struct raw_spinlock {
 
 #define DEFINE_RAW_SPINLOCK(x)  raw_spinlock_t x = __RAW_SPIN_LOCK_UNLOCKED(x)
 
-#endif
+#endif /* __LINUX_SPINLOCK_TYPES_RAW_H */
diff --git a/include/linux/spinlock_types_up.h b/include/linux/spinlock_types_up.h
index c09b6407ae1b3..7f86a2016ac5c 100644
--- a/include/linux/spinlock_types_up.h
+++ b/include/linux/spinlock_types_up.h
@@ -1,7 +1,7 @@
 #ifndef __LINUX_SPINLOCK_TYPES_UP_H
 #define __LINUX_SPINLOCK_TYPES_UP_H
 
-#ifndef __LINUX_SPINLOCK_TYPES_H
+#ifndef __LINUX_SPINLOCK_TYPES_RAW_H
 # error "please don't include this file directly"
 #endif
 
diff --git a/kernel/cpu_pm.c b/kernel/cpu_pm.c
index f7e1d0eccdbc6..246efc74e3f34 100644
--- a/kernel/cpu_pm.c
+++ b/kernel/cpu_pm.c
@@ -13,19 +13,32 @@
 #include <linux/spinlock.h>
 #include <linux/syscore_ops.h>
 
-static ATOMIC_NOTIFIER_HEAD(cpu_pm_notifier_chain);
+/*
+ * atomic_notifiers use a spinlock_t, which can block under PREEMPT_RT.
+ * Notifications for cpu_pm will be issued by the idle task itself, which can
+ * never block, IOW it requires using a raw_spinlock_t.
+ */
+static struct {
+	struct raw_notifier_head chain;
+	raw_spinlock_t lock;
+} cpu_pm_notifier = {
+	.chain = RAW_NOTIFIER_INIT(cpu_pm_notifier.chain),
+	.lock  = __RAW_SPIN_LOCK_UNLOCKED(cpu_pm_notifier.lock),
+};
 
 static int cpu_pm_notify(enum cpu_pm_event event)
 {
 	int ret;
 
 	/*
-	 * atomic_notifier_call_chain has a RCU read critical section, which
-	 * could be disfunctional in cpu idle. Copy RCU_NONIDLE code to let
-	 * RCU know this.
+	 * This introduces a RCU read critical section, which could be
+	 * disfunctional in cpu idle. Copy RCU_NONIDLE code to let RCU know
+	 * this.
 	 */
 	rcu_irq_enter_irqson();
-	ret = atomic_notifier_call_chain(&cpu_pm_notifier_chain, event, NULL);
+	rcu_read_lock();
+	ret = raw_notifier_call_chain(&cpu_pm_notifier.chain, event, NULL);
+	rcu_read_unlock();
 	rcu_irq_exit_irqson();
 
 	return notifier_to_errno(ret);
@@ -33,10 +46,13 @@ static int cpu_pm_notify(enum cpu_pm_event event)
 
 static int cpu_pm_notify_robust(enum cpu_pm_event event_up, enum cpu_pm_event event_down)
 {
+	unsigned long flags;
 	int ret;
 
 	rcu_irq_enter_irqson();
-	ret = atomic_notifier_call_chain_robust(&cpu_pm_notifier_chain, event_up, event_down, NULL);
+	raw_spin_lock_irqsave(&cpu_pm_notifier.lock, flags);
+	ret = raw_notifier_call_chain_robust(&cpu_pm_notifier.chain, event_up, event_down, NULL);
+	raw_spin_unlock_irqrestore(&cpu_pm_notifier.lock, flags);
 	rcu_irq_exit_irqson();
 
 	return notifier_to_errno(ret);
@@ -49,12 +65,17 @@ static int cpu_pm_notify_robust(enum cpu_pm_event event_up, enum cpu_pm_event ev
  * Add a driver to a list of drivers that are notified about
  * CPU and CPU cluster low power entry and exit.
  *
- * This function may sleep, and has the same return conditions as
- * raw_notifier_chain_register.
+ * This function has the same return conditions as raw_notifier_chain_register.
  */
 int cpu_pm_register_notifier(struct notifier_block *nb)
 {
-	return atomic_notifier_chain_register(&cpu_pm_notifier_chain, nb);
+	unsigned long flags;
+	int ret;
+
+	raw_spin_lock_irqsave(&cpu_pm_notifier.lock, flags);
+	ret = raw_notifier_chain_register(&cpu_pm_notifier.chain, nb);
+	raw_spin_unlock_irqrestore(&cpu_pm_notifier.lock, flags);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(cpu_pm_register_notifier);
 
@@ -64,12 +85,17 @@ EXPORT_SYMBOL_GPL(cpu_pm_register_notifier);
  *
  * Remove a driver from the CPU PM notifier list.
  *
- * This function may sleep, and has the same return conditions as
- * raw_notifier_chain_unregister.
+ * This function has the same return conditions as raw_notifier_chain_unregister.
  */
 int cpu_pm_unregister_notifier(struct notifier_block *nb)
 {
-	return atomic_notifier_chain_unregister(&cpu_pm_notifier_chain, nb);
+	unsigned long flags;
+	int ret;
+
+	raw_spin_lock_irqsave(&cpu_pm_notifier.lock, flags);
+	ret = raw_notifier_chain_unregister(&cpu_pm_notifier.chain, nb);
+	raw_spin_unlock_irqrestore(&cpu_pm_notifier.lock, flags);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(cpu_pm_unregister_notifier);
 
diff --git a/kernel/futex.c b/kernel/futex.c
index fcc0570868b7b..e7b4c6121da4e 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -2116,18 +2116,18 @@ static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
 		/*
 		 * futex_requeue() allows the caller to define the number
 		 * of waiters to wake up via the @nr_wake argument. With
-		 * REQUEUE_PI waking up more than one waiter is creating
+		 * REQUEUE_PI, waking up more than one waiter is creating
 		 * more problems than it solves. Waking up a waiter makes
 		 * only sense if the PI futex @uaddr2 is uncontended as
 		 * this allows the requeue code to acquire the futex
 		 * @uaddr2 before waking the waiter. The waiter can then
 		 * return to user space without further action. A secondary
 		 * wakeup would just make the futex_wait_requeue_pi()
-		 * handling more complex because that code would have to
+		 * handling more complex, because that code would have to
 		 * look up pi_state and do more or less all the handling
 		 * which the requeue code has to do for the to be requeued
 		 * waiters. So restrict the number of waiters to wake to
-		 * one and only wake it up when the PI futex is
+		 * one, and only wake it up when the PI futex is
 		 * uncontended. Otherwise requeue it and let the unlock of
 		 * the PI futex handle the wakeup.
 		 *
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 8d72995565305..c1c480c52f0e0 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1097,7 +1097,7 @@ static int __sched task_blocks_on_rt_mutex(struct rt_mutex_base *lock,
 	if (build_ww_mutex() && ww_ctx) {
 		struct rt_mutex *rtm;
 
-		/* Check whether the waiter should backout immediately */
+		/* Check whether the waiter should back out immediately */
 		rtm = container_of(lock, struct rt_mutex, rtmutex);
 		res = __ww_mutex_add_waiter(waiter, rtm, ww_ctx);
 		if (res)
@@ -1631,7 +1631,7 @@ static __always_inline int __rt_mutex_lock(struct rt_mutex_base *lock,
 
 /**
  * rtlock_slowlock_locked - Slow path lock acquisition for RT locks
- * @lock:	The underlying rt mutex
+ * @lock:	The underlying RT mutex
  */
 static void __sched rtlock_slowlock_locked(struct rt_mutex_base *lock)
 {
@@ -1651,7 +1651,7 @@ static void __sched rtlock_slowlock_locked(struct rt_mutex_base *lock)
 	task_blocks_on_rt_mutex(lock, &waiter, current, NULL, RT_MUTEX_MIN_CHAINWALK);
 
 	for (;;) {
-		/* Try to acquire the lock again. */
+		/* Try to acquire the lock again */
 		if (try_to_take_rt_mutex(lock, current, &waiter))
 			break;
 
@@ -1672,8 +1672,8 @@ static void __sched rtlock_slowlock_locked(struct rt_mutex_base *lock)
 	current_restore_rtlock_saved_state();
 
 	/*
-	 * try_to_take_rt_mutex() sets the waiter bit unconditionally. We
-	 * might have to fix that up:
+	 * try_to_take_rt_mutex() sets the waiter bit unconditionally.
+	 * We might have to fix that up:
 	 */
 	fixup_rt_mutex_waiters(lock);
 	debug_rt_mutex_free_waiter(&waiter);
diff --git a/kernel/locking/rtmutex_api.c b/kernel/locking/rtmutex_api.c
index 3155aa6f7ee24..900220941caac 100644
--- a/kernel/locking/rtmutex_api.c
+++ b/kernel/locking/rtmutex_api.c
@@ -241,11 +241,11 @@ void __sched rt_mutex_init_proxy_locked(struct rt_mutex_base *lock,
 	__rt_mutex_base_init(lock);
 	/*
 	 * On PREEMPT_RT the futex hashbucket spinlock becomes 'sleeping'
-	 * and rtmutex based. That causes a lockdep false positive because
+	 * and rtmutex based. That causes a lockdep false positive, because
 	 * some of the futex functions invoke spin_unlock(&hb->lock) with
 	 * the wait_lock of the rtmutex associated to the pi_futex held.
 	 * spin_unlock() in turn takes wait_lock of the rtmutex on which
-	 * the spinlock is based which makes lockdep notice a lock
+	 * the spinlock is based, which makes lockdep notice a lock
 	 * recursion. Give the futex/rtmutex wait_lock a separate key.
 	 */
 	lockdep_set_class(&lock->wait_lock, &pi_futex_key);
diff --git a/kernel/locking/rwbase_rt.c b/kernel/locking/rwbase_rt.c
index b77b4e8e88e04..4ba15088e6405 100644
--- a/kernel/locking/rwbase_rt.c
+++ b/kernel/locking/rwbase_rt.c
@@ -6,17 +6,17 @@
  * down_write/write_lock()
  *  1) Lock rtmutex
  *  2) Remove the reader BIAS to force readers into the slow path
- *  3) Wait until all readers have left the critical region
+ *  3) Wait until all readers have left the critical section
  *  4) Mark it write locked
  *
  * up_write/write_unlock()
  *  1) Remove the write locked marker
- *  2) Set the reader BIAS so readers can use the fast path again
- *  3) Unlock rtmutex to release blocked readers
+ *  2) Set the reader BIAS, so readers can use the fast path again
+ *  3) Unlock rtmutex, to release blocked readers
  *
  * down_read/read_lock()
  *  1) Try fast path acquisition (reader BIAS is set)
- *  2) Take tmutex::wait_lock which protects the writelocked flag
+ *  2) Take tmutex::wait_lock, which protects the writelocked flag
  *  3) If !writelocked, acquire it for read
  *  4) If writelocked, block on tmutex
  *  5) unlock rtmutex, goto 1)
@@ -67,7 +67,7 @@ static int __sched __rwbase_read_lock(struct rwbase_rt *rwb,
 
 	raw_spin_lock_irq(&rtm->wait_lock);
 	/*
-	 * Allow readers as long as the writer has not completely
+	 * Allow readers, as long as the writer has not completely
 	 * acquired the semaphore for write.
 	 */
 	if (atomic_read(&rwb->readers) != WRITER_BIAS) {
@@ -103,7 +103,7 @@ static int __sched __rwbase_read_lock(struct rwbase_rt *rwb,
 	 * rtmutex_lock(m)
 	 *
 	 * That would put Reader1 behind the writer waiting on
-	 * Reader2 to call up_read() which might be unbound.
+	 * Reader2 to call up_read(), which might be unbound.
 	 */
 
 	/*
@@ -161,7 +161,7 @@ static __always_inline void rwbase_read_unlock(struct rwbase_rt *rwb,
 {
 	/*
 	 * rwb->readers can only hit 0 when a writer is waiting for the
-	 * active readers to leave the critical region.
+	 * active readers to leave the critical section.
 	 */
 	if (unlikely(atomic_dec_and_test(&rwb->readers)))
 		__rwbase_read_unlock(rwb, state);
@@ -216,7 +216,7 @@ static int __sched rwbase_write_lock(struct rwbase_rt *rwb,
 	 */
 	rwbase_set_and_save_current_state(state);
 
-	/* Block until all readers have left the critical region. */
+	/* Block until all readers have left the critical section. */
 	for (; atomic_read(&rwb->readers);) {
 		/* Optimized out for rwlocks */
 		if (rwbase_signal_pending_state(state, current)) {
diff --git a/kernel/locking/spinlock_rt.c b/kernel/locking/spinlock_rt.c
index 7894c66045b52..d2912e44d61fd 100644
--- a/kernel/locking/spinlock_rt.c
+++ b/kernel/locking/spinlock_rt.c
@@ -2,16 +2,16 @@
 /*
  * PREEMPT_RT substitution for spin/rw_locks
  *
- * spin_lock and rw_lock on RT are based on rtmutex with a few twists to
- * resemble the non RT semantics
+ * spinlocks and rwlocks on RT are based on rtmutexes, with a few twists to
+ * resemble the non RT semantics:
  *
- * - Contrary to a plain rtmutex, spin_lock and rw_lock are state
+ * - Contrary to plain rtmutexes, spinlocks and rwlocks are state
  *   preserving. The task state is saved before blocking on the underlying
- *   rtmutex and restored when the lock has been acquired. Regular wakeups
+ *   rtmutex, and restored when the lock has been acquired. Regular wakeups
  *   during that time are redirected to the saved state so no wake up is
  *   missed.
  *
- * - Non RT spin/rw_locks disable preemption and eventually interrupts.
+ * - Non RT spin/rwlocks disable preemption and eventually interrupts.
  *   Disabling preemption has the side effect of disabling migration and
  *   preventing RCU grace periods.
  *
diff --git a/kernel/locking/ww_mutex.h b/kernel/locking/ww_mutex.h
index a077079e387ca..56f139201f246 100644
--- a/kernel/locking/ww_mutex.h
+++ b/kernel/locking/ww_mutex.h
@@ -228,7 +228,7 @@ static inline bool
 __ww_ctx_less(struct ww_acquire_ctx *a, struct ww_acquire_ctx *b)
 {
 /*
- * Can only do the RT prio for WW_RT because task->prio isn't stable due to PI,
+ * Can only do the RT prio for WW_RT, because task->prio isn't stable due to PI,
  * so the wait_list ordering will go wobbly. rt_mutex re-queues the waiter and
  * isn't affected by this.
  */
diff --git a/kernel/locking/ww_rt_mutex.c b/kernel/locking/ww_rt_mutex.c
index 519092ee5e88e..3f1fff7d27801 100644
--- a/kernel/locking/ww_rt_mutex.c
+++ b/kernel/locking/ww_rt_mutex.c
@@ -25,7 +25,7 @@ __ww_rt_mutex_lock(struct ww_mutex *lock, struct ww_acquire_ctx *ww_ctx,
 
 		/*
 		 * Reset the wounded flag after a kill. No other process can
-		 * race and wound us here since they can't have a valid owner
+		 * race and wound us here, since they can't have a valid owner
 		 * pointer if we don't have any locks held.
 		 */
 		if (ww_ctx->acquired == 0)
diff --git a/kernel/notifier.c b/kernel/notifier.c
index c20782f076432..b8251dc0bc0f1 100644
--- a/kernel/notifier.c
+++ b/kernel/notifier.c
@@ -142,9 +142,9 @@ int atomic_notifier_chain_register(struct atomic_notifier_head *nh,
 	unsigned long flags;
 	int ret;
 
-	raw_spin_lock_irqsave(&nh->lock, flags);
+	spin_lock_irqsave(&nh->lock, flags);
 	ret = notifier_chain_register(&nh->head, n);
-	raw_spin_unlock_irqrestore(&nh->lock, flags);
+	spin_unlock_irqrestore(&nh->lock, flags);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(atomic_notifier_chain_register);
@@ -164,33 +164,14 @@ int atomic_notifier_chain_unregister(struct atomic_notifier_head *nh,
 	unsigned long flags;
 	int ret;
 
-	raw_spin_lock_irqsave(&nh->lock, flags);
+	spin_lock_irqsave(&nh->lock, flags);
 	ret = notifier_chain_unregister(&nh->head, n);
-	raw_spin_unlock_irqrestore(&nh->lock, flags);
+	spin_unlock_irqrestore(&nh->lock, flags);
 	synchronize_rcu();
 	return ret;
 }
 EXPORT_SYMBOL_GPL(atomic_notifier_chain_unregister);
 
-int atomic_notifier_call_chain_robust(struct atomic_notifier_head *nh,
-		unsigned long val_up, unsigned long val_down, void *v)
-{
-	unsigned long flags;
-	int ret;
-
-	/*
-	 * Musn't use RCU; because then the notifier list can
-	 * change between the up and down traversal.
-	 */
-	raw_spin_lock_irqsave(&nh->lock, flags);
-	ret = notifier_call_chain_robust(&nh->head, val_up, val_down, v);
-	raw_spin_unlock_irqrestore(&nh->lock, flags);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(atomic_notifier_call_chain_robust);
-NOKPROBE_SYMBOL(atomic_notifier_call_chain_robust);
-
 /**
  *	atomic_notifier_call_chain - Call functions in an atomic notifier chain
  *	@nh: Pointer to head of the atomic notifier chain
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index eecd1caef71d3..f01368a05374d 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1548,6 +1548,13 @@ rcutorture_extend_mask(int oldmask, struct torture_random_state *trsp)
 	 * them on non-RT.
 	 */
 	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		/*
+		 * Can't disable bh in atomic context if bh was already
+		 * disabled by another task on the same CPU. Instead of
+		 * attempting to track this, just avoid disabling bh in atomic
+		 * context.
+		 */
+		mask &= ~atomic_bhs;
 		/*
 		 * Can't release the outermost rcu lock in an irq disabled
 		 * section without preemption also being disabled, if irqs
@@ -1559,16 +1566,6 @@ rcutorture_extend_mask(int oldmask, struct torture_random_state *trsp)
 		    !(mask & preempts))
 			mask |= RCUTORTURE_RDR_RCU;
 
-		/* Can't modify atomic bh in non-atomic context */
-		if ((oldmask & atomic_bhs) && (mask & atomic_bhs) &&
-		    !(mask & preempts_irq)) {
-			mask |= oldmask & preempts_irq;
-			if (mask & RCUTORTURE_RDR_IRQ)
-				mask |= oldmask & tmp;
-		}
-		if ((mask & atomic_bhs) && !(mask & preempts_irq))
-			mask |= RCUTORTURE_RDR_PREEMPT;
-
 		/* Can't modify non-atomic bh in atomic context */
 		tmp = nonatomic_bhs;
 		if (oldmask & preempts_irq)
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 51f24ecd94b26..caadfec994f3a 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -87,6 +87,7 @@ static DEFINE_PER_CPU_SHARED_ALIGNED(struct rcu_data, rcu_data) = {
 	.dynticks = ATOMIC_INIT(RCU_DYNTICK_CTRL_CTR),
 #ifdef CONFIG_RCU_NOCB_CPU
 	.cblist.flags = SEGCBLIST_SOFTIRQ_ONLY,
+	.nocb_local_lock =  INIT_LOCAL_LOCK(nocb_local_lock),
 #endif
 };
 static struct rcu_state rcu_state = {
@@ -2853,10 +2854,12 @@ static void rcu_cpu_kthread(unsigned int cpu)
 {
 	unsigned int *statusp = this_cpu_ptr(&rcu_data.rcu_cpu_kthread_status);
 	char work, *workp = this_cpu_ptr(&rcu_data.rcu_cpu_has_work);
+	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 	int spincnt;
 
 	trace_rcu_utilization(TPS("Start CPU kthread@rcu_run"));
 	for (spincnt = 0; spincnt < 10; spincnt++) {
+		rcu_nocb_local_lock(rdp);
 		local_bh_disable();
 		*statusp = RCU_KTHREAD_RUNNING;
 		local_irq_disable();
@@ -2866,6 +2869,7 @@ static void rcu_cpu_kthread(unsigned int cpu)
 		if (work)
 			rcu_core();
 		local_bh_enable();
+		rcu_nocb_local_unlock(rdp);
 		if (*workp == 0) {
 			trace_rcu_utilization(TPS("End CPU kthread@rcu_wait"));
 			*statusp = RCU_KTHREAD_WAITING;
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 305cf6aeb4086..aa6831255fec6 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -210,6 +210,8 @@ struct rcu_data {
 	struct timer_list nocb_timer;	/* Enforce finite deferral. */
 	unsigned long nocb_gp_adv_time;	/* Last call_rcu() CB adv (jiffies). */
 
+	local_lock_t nocb_local_lock;
+
 	/* The following fields are used by call_rcu, hence own cacheline. */
 	raw_spinlock_t nocb_bypass_lock ____cacheline_internodealigned_in_smp;
 	struct rcu_cblist nocb_bypass;	/* Lock-contention-bypass CB list. */
@@ -445,6 +447,8 @@ static void rcu_nocb_unlock(struct rcu_data *rdp);
 static void rcu_nocb_unlock_irqrestore(struct rcu_data *rdp,
 				       unsigned long flags);
 static void rcu_lockdep_assert_cblist_protected(struct rcu_data *rdp);
+static void rcu_nocb_local_lock(struct rcu_data *rdp);
+static void rcu_nocb_local_unlock(struct rcu_data *rdp);
 #ifdef CONFIG_RCU_NOCB_CPU
 static void __init rcu_organize_nocb_kthreads(void);
 #define rcu_nocb_lock_irqsave(rdp, flags)				\
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 9ecf4fd819d3e..27b7ec6b8b236 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -21,6 +21,11 @@ static inline int rcu_lockdep_is_held_nocb(struct rcu_data *rdp)
 	return lockdep_is_held(&rdp->nocb_lock);
 }
 
+static inline int rcu_lockdep_is_held_nocb_local(struct rcu_data *rdp)
+{
+	return lockdep_is_held(&rdp->nocb_local_lock);
+}
+
 static inline bool rcu_current_is_nocb_kthread(struct rcu_data *rdp)
 {
 	/* Race on early boot between thread creation and assignment */
@@ -38,7 +43,10 @@ static inline int rcu_lockdep_is_held_nocb(struct rcu_data *rdp)
 {
 	return 0;
 }
-
+static inline int rcu_lockdep_is_held_nocb_local(struct rcu_data *rdp)
+{
+	return 0;
+}
 static inline bool rcu_current_is_nocb_kthread(struct rcu_data *rdp)
 {
 	return false;
@@ -46,22 +54,44 @@ static inline bool rcu_current_is_nocb_kthread(struct rcu_data *rdp)
 
 #endif /* #ifdef CONFIG_RCU_NOCB_CPU */
 
+/*
+ * Is a local read of the rdp's offloaded state safe and stable?
+ * See rcu_nocb_local_lock() & family.
+ */
+static inline bool rcu_local_offload_access_safe(struct rcu_data *rdp)
+{
+	if (!preemptible())
+		return true;
+
+	if (!is_migratable()) {
+		if (!IS_ENABLED(CONFIG_RCU_NOCB))
+			return true;
+
+		return rcu_lockdep_is_held_nocb_local(rdp);
+	}
+
+	return false;
+}
+
 static bool rcu_rdp_is_offloaded(struct rcu_data *rdp)
 {
 	/*
-	 * In order to read the offloaded state of an rdp is a safe
-	 * and stable way and prevent from its value to be changed
-	 * under us, we must either hold the barrier mutex, the cpu
-	 * hotplug lock (read or write) or the nocb lock. Local
-	 * non-preemptible reads are also safe. NOCB kthreads and
-	 * timers have their own means of synchronization against the
-	 * offloaded state updaters.
+	 * In order to read the offloaded state of an rdp is a safe and stable
+	 * way and prevent from its value to be changed under us, we must either...
 	 */
 	RCU_LOCKDEP_WARN(
+		// ...hold the barrier mutex...
 		!(lockdep_is_held(&rcu_state.barrier_mutex) ||
+		  // ... the cpu hotplug lock (read or write)...
 		  (IS_ENABLED(CONFIG_HOTPLUG_CPU) && lockdep_is_cpus_held()) ||
+		  // ... or the NOCB lock.
 		  rcu_lockdep_is_held_nocb(rdp) ||
-		  (rdp == this_cpu_ptr(&rcu_data) && is_pcpu_safe()) ||
+		  // Local reads still require the local state to remain stable
+		  // (preemption disabled / local lock held)
+		  (rdp == this_cpu_ptr(&rcu_data) &&
+		   rcu_local_offload_access_safe(rdp)) ||
+		  // NOCB kthreads and timers have their own means of synchronization
+		  // against the offloaded state updaters.
 		  rcu_current_is_nocb_kthread(rdp)),
 		"Unsafe read of RCU_NOCB offloaded state"
 	);
@@ -1628,6 +1658,22 @@ static void rcu_nocb_unlock_irqrestore(struct rcu_data *rdp,
 	}
 }
 
+/*
+ * The invocation of rcu_core() within the RCU core kthreads remains preemptible
+ * under PREEMPT_RT, thus the offload state of a CPU could change while
+ * said kthreads are preempted. Prevent this from happening by protecting the
+ * offload state with a local_lock().
+ */
+static void rcu_nocb_local_lock(struct rcu_data *rdp)
+{
+	local_lock(&rcu_data.nocb_local_lock);
+}
+
+static void rcu_nocb_local_unlock(struct rcu_data *rdp)
+{
+	local_unlock(&rcu_data.nocb_local_lock);
+}
+
 /* Lockdep check that ->cblist may be safely accessed. */
 static void rcu_lockdep_assert_cblist_protected(struct rcu_data *rdp)
 {
@@ -2395,6 +2441,7 @@ static int rdp_offload_toggle(struct rcu_data *rdp,
 	if (rdp->nocb_cb_sleep)
 		rdp->nocb_cb_sleep = false;
 	rcu_nocb_unlock_irqrestore(rdp, flags);
+	rcu_nocb_local_unlock(rdp);
 
 	/*
 	 * Ignore former value of nocb_cb_sleep and force wake up as it could
@@ -2426,6 +2473,7 @@ static long rcu_nocb_rdp_deoffload(void *arg)
 
 	pr_info("De-offloading %d\n", rdp->cpu);
 
+	rcu_nocb_local_lock(rdp);
 	rcu_nocb_lock_irqsave(rdp, flags);
 	/*
 	 * Flush once and for all now. This suffices because we are
@@ -2508,6 +2556,7 @@ static long rcu_nocb_rdp_offload(void *arg)
 	 * Can't use rcu_nocb_lock_irqsave() while we are in
 	 * SEGCBLIST_SOFTIRQ_ONLY mode.
 	 */
+	rcu_nocb_local_lock(rdp);
 	raw_spin_lock_irqsave(&rdp->nocb_lock, flags);
 
 	/*
@@ -2867,6 +2916,16 @@ static void rcu_nocb_unlock_irqrestore(struct rcu_data *rdp,
 	local_irq_restore(flags);
 }
 
+/* No ->nocb_local_lock to acquire. */
+static void rcu_nocb_local_lock(struct rcu_data *rdp)
+{
+}
+
+/* No ->nocb_local_lock to release. */
+static void rcu_nocb_local_unlock(struct rcu_data *rdp)
+{
+}
+
 /* Lockdep check that ->cblist may be safely accessed. */
 static void rcu_lockdep_assert_cblist_protected(struct rcu_data *rdp)
 {
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c3b33afb3cd13..02718b6c7732d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3639,12 +3639,12 @@ bool ttwu_state_match(struct task_struct *p, unsigned int state, int *success)
 #ifdef CONFIG_PREEMPT_RT
 	/*
 	 * Saved state preserves the task state across blocking on
-	 * a RT lock.  If the state matches, set p::saved_state to
+	 * an RT lock.  If the state matches, set p::saved_state to
 	 * TASK_RUNNING, but do not wake the task because it waits
 	 * for a lock wakeup. Also indicate success because from
 	 * the regular waker's point of view this has succeeded.
 	 *
-	 * After acquiring the lock the task will restore p::state
+	 * After acquiring the lock the task will restore p::__state
 	 * from p::saved_state which ensures that the regular
 	 * wakeup is not lost. The restore will also set
 	 * p::saved_state to TASK_RUNNING so any further tests will
@@ -5869,8 +5869,8 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
  * Constants for the sched_mode argument of __schedule().
  *
  * The mode argument allows RT enabled kernels to differentiate a
- * preemption from blocking on an 'sleeping' spin/rwlock. Note, that
- * SM_MASK_PREEMPT for !RT has all bits set which allows the compiler to
+ * preemption from blocking on an 'sleeping' spin/rwlock. Note that
+ * SM_MASK_PREEMPT for !RT has all bits set, which allows the compiler to
  * optimize the AND operation out and just check for zero.
  */
 #define SM_NONE			0x0
diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index 415e3efec77ce..1266ea3726d73 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -1351,11 +1351,7 @@ GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion3_soft_wlock)
 # define I_MUTEX(x)	lockdep_reset_lock(&mutex_##x.dep_map)
 # define I_RWSEM(x)	lockdep_reset_lock(&rwsem_##x.dep_map)
 # define I_WW(x)	lockdep_reset_lock(&x.dep_map)
-# ifdef CONFIG_PREEMPT_RT
-#  define I_LOCAL_LOCK(x) lockdep_reset_lock(this_cpu_ptr(&local_##x.lock.dep_map))
-# else
-#  define I_LOCAL_LOCK(x) lockdep_reset_lock(this_cpu_ptr(&local_##x.dep_map))
-# endif
+# define I_LOCAL_LOCK(x) lockdep_reset_lock(this_cpu_ptr(&local_##x.dep_map))
 #ifdef CONFIG_RT_MUTEXES
 # define I_RTMUTEX(x)	lockdep_reset_lock(&rtmutex_##x.dep_map)
 #endif
diff --git a/localversion-rt b/localversion-rt
index d79dde624aaac..05c35cb580779 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt10
+-rt11
diff --git a/mm/slub.c b/mm/slub.c
index a263e9be40123..df1ac8aff86fe 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2778,6 +2778,19 @@ static inline bool pfmemalloc_match(struct page *page, gfp_t gfpflags)
 	return true;
 }
 
+/*
+ * A variant of pfmemalloc_match() that tests page flags without asserting
+ * PageSlab. Intended for opportunistic checks before taking a lock and
+ * rechecking that nobody else freed the page under us.
+ */
+static inline bool pfmemalloc_match_unsafe(struct page *page, gfp_t gfpflags)
+{
+	if (unlikely(__PageSlabPfmemalloc(page)))
+		return gfp_pfmemalloc_allowed(gfpflags);
+
+	return true;
+}
+
 /*
  * Check the page->freelist of a page and either transfer the freelist to the
  * per cpu freelist or deactivate the page.
@@ -2874,7 +2887,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	 * PFMEMALLOC but right now, we are losing the pfmemalloc
 	 * information when the page leaves the per-cpu allocator
 	 */
-	if (unlikely(!pfmemalloc_match(page, gfpflags)))
+	if (unlikely(!pfmemalloc_match_unsafe(page, gfpflags)))
 		goto deactivate_slab;
 
 	/* must check again c->page in case we got preempted and it changed */
@@ -2900,11 +2913,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 
 load_freelist:
 
-#ifdef CONFIG_PREEMPT_RT
-	lockdep_assert_held(this_cpu_ptr(&s->cpu_slab->lock.lock));
-#else
 	lockdep_assert_held(this_cpu_ptr(&s->cpu_slab->lock));
-#endif
 
 	/*
 	 * freelist is pointing to the list of objects to be used.
@@ -4522,7 +4531,7 @@ EXPORT_SYMBOL(kfree);
  * being allocated from last increasing the chance that the last objects
  * are freed in them.
  */
-int __kmem_cache_do_shrink(struct kmem_cache *s)
+static int __kmem_cache_do_shrink(struct kmem_cache *s)
 {
 	int node;
 	int i;
