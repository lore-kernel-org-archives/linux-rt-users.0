From: Jan Engelhardt <jengelh@medozas.de>
Subject: [archival] 2.6.31-rt nvidia patches
Date: Sat, 12 Sep 2009 11:24:04 +0200 (CEST)
Message-ID: <alpine.LSU.2.00.0909121109100.8788@obet.zrqbmnf.qr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from borg.medozas.de ([188.40.89.202]:42450 "EHLO borg.medozas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752538AbZILJcB (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 12 Sep 2009 05:32:01 -0400
Received: from localhost (localhost [127.0.0.1])
	by borg.medozas.de (Postfix) with ESMTP id 85C8B4353D
	for <linux-rt-users@vger.kernel.org>; Sat, 12 Sep 2009 11:24:04 +0200 (CEST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


For interested parties and archival, patches to the four nvidia packages  
(185, 173, 96, 71) for 2.6.31-rt.
Tested {2.6.31-rc8-rt9 with 96}, which seems to work.

#
---
 nv-linux.h     |    2 +-
 os-interface.c |   30 ++++++++++++++++++------------
 2 files changed, 19 insertions(+), 13 deletions(-)

Index: nvidiaCUR-kernel/nv-linux.h
===================================================================
--- nvidiaCUR-kernel.orig/nv-linux.h
+++ nvidiaCUR-kernel/nv-linux.h
@@ -721,7 +721,7 @@ static inline int nv_execute_on_all_cpus
 #define nv_up(lock)                     up(&lock)
 
 #if defined(CONFIG_PREEMPT_RT)
-#define NV_INIT_MUTEX(mutex) init_MUTEX(mutex)
+#define NV_INIT_MUTEX(mutex) semaphore_init(mutex)
 #else
 #if !defined(__SEMAPHORE_INITIALIZER) && defined(__COMPAT_SEMAPHORE_INITIALIZER)
 #define __SEMAPHORE_INITIALIZER __COMPAT_SEMAPHORE_INITIALIZER
Index: nvidiaCUR-kernel/os-interface.c
===================================================================
--- nvidiaCUR-kernel.orig/os-interface.c
+++ nvidiaCUR-kernel/os-interface.c
@@ -88,9 +88,15 @@ typedef struct os_sema_s
     nv_stack_t        *sp;
     struct completion  completion;
 #if defined(CONFIG_PREEMPT_RT)
-    raw_spinlock_t     lock;
+    atomic_spinlock_t lock;
+#define nv_spin_lock_init(x) atomic_spin_lock_init(x)
+#define nv_spin_lock_irqsave(x, f) atomic_spin_lock_irqsave((x), (f))
+#define nv_spin_unlock_irqrestore(x, f) atomic_spin_unlock_irqrestore((x), (f))
 #else
     spinlock_t         lock;
+#define nv_spin_lock_init(x) spin_lock_init(x)
+#define nv_spin_lock_irqsave(x, f) spin_lock_irqsave((x), (f))
+#define nv_spin_unlock_irqrestore(x, f) spin_unlock_irqrestore((x), (f))
 #endif
     S032               count;
 } os_sema_t;
@@ -127,7 +133,7 @@ RM_STATUS NV_API_CALL os_alloc_sema
     os_sema = (os_sema_t *)*ppSema;
     os_sema->sp = sp;
     init_completion(&os_sema->completion);
-    spin_lock_init(&os_sema->lock);
+    nv_spin_lock_init(&os_sema->lock);
     os_sema->count = 1;
 
     return RM_OK;
@@ -171,18 +177,18 @@ RM_STATUS NV_API_CALL os_acquire_sema
     os_sema_t *os_sema = (os_sema_t *)pSema;
     unsigned long old_irq;
 
-    spin_lock_irqsave(&os_sema->lock, old_irq);
+    nv_spin_lock_irqsave(&os_sema->lock, old_irq);
     if (os_sema->count <= 0)
     {
         os_sema->count--;
-        spin_unlock_irqrestore(&os_sema->lock, old_irq);
+        nv_spin_unlock_irqrestore(&os_sema->lock, old_irq);
         wait_for_completion(&os_sema->completion);
     }
     else
     {
         os_sema->count--;
         rm_disable_interrupts(os_sema->sp);
-        spin_unlock_irqrestore(&os_sema->lock, old_irq);
+        nv_spin_unlock_irqrestore(&os_sema->lock, old_irq);
     }
 
     return RM_OK;
@@ -205,17 +211,17 @@ BOOL NV_API_CALL os_cond_acquire_sema
     os_sema_t *os_sema = (os_sema_t *)pSema;
     unsigned long old_irq;
 
-    spin_lock_irqsave(&os_sema->lock, old_irq);
+    nv_spin_lock_irqsave(&os_sema->lock, old_irq);
     if (os_sema->count <= 0)
     {
-        spin_unlock_irqrestore(&os_sema->lock, old_irq);
+        nv_spin_unlock_irqrestore(&os_sema->lock, old_irq);
         return FALSE;
     }
     else
     {
         os_sema->count--;
         rm_disable_interrupts(os_sema->sp);
-        spin_unlock_irqrestore(&os_sema->lock, old_irq);
+        nv_spin_unlock_irqrestore(&os_sema->lock, old_irq);
         return TRUE;
     }
 
@@ -239,7 +245,7 @@ RM_STATUS NV_API_CALL os_release_sema
     unsigned long old_irq;
     BOOL doWakeup;
 
-    spin_lock_irqsave(&os_sema->lock, old_irq);
+    nv_spin_lock_irqsave(&os_sema->lock, old_irq);
     if (os_sema->count < 0)
     {
         doWakeup = TRUE;
@@ -250,7 +256,7 @@ RM_STATUS NV_API_CALL os_release_sema
         rm_enable_interrupts(os_sema->sp);
     }
     os_sema->count++;
-    spin_unlock_irqrestore(&os_sema->lock, old_irq);
+    nv_spin_unlock_irqrestore(&os_sema->lock, old_irq);
 
     if (doWakeup)
         complete(&os_sema->completion);
@@ -1319,7 +1325,7 @@ NvU64 NV_API_CALL os_acquire_spinlock(vo
     unsigned long oldIrql;
 
     os_sema = (os_sema_t *) pSema;
-    spin_lock_irqsave(&os_sema->lock, oldIrql);
+    nv_spin_lock_irqsave(&os_sema->lock, oldIrql);
 
     return oldIrql;
 }
@@ -1330,7 +1336,7 @@ void NV_API_CALL os_release_spinlock(voi
     unsigned long old_irq = (unsigned long) oldIrql;
 
     os_sema = (os_sema_t *) pSema;
-    spin_unlock_irqrestore(&os_sema->lock, old_irq);
+    nv_spin_unlock_irqrestore(&os_sema->lock, old_irq);
 }
 
 


#
---
 nv-linux.h     |   11 +----------
 os-interface.c |   28 +++++++++++++++++-----------
 2 files changed, 18 insertions(+), 21 deletions(-)

Index: nvidia173-kernel/nv-linux.h
===================================================================
--- nvidia173-kernel.orig/nv-linux.h
+++ nvidia173-kernel/nv-linux.h
@@ -720,16 +720,7 @@ static inline int nv_execute_on_all_cpus
 #define nv_down(lock)                   down(&lock)
 #define nv_up(lock)                     up(&lock)
 
-#if defined(CONFIG_PREEMPT_RT)
-#define NV_INIT_MUTEX(mutex) init_MUTEX(mutex)
-#else
-#define NV_INIT_MUTEX(mutex)                       \
-    {                                              \
-        struct semaphore __mutex =                 \
-            __SEMAPHORE_INITIALIZER(*(mutex), 1);  \
-        *(mutex) = __mutex;                        \
-    }
-#endif
+#define NV_INIT_MUTEX(mutex) sema_init((mutex), 1)
 
 #if defined (KERNEL_2_4)
 #  define NV_IS_SUSER()                 suser()
Index: nvidia173-kernel/os-interface.c
===================================================================
--- nvidia173-kernel.orig/os-interface.c
+++ nvidia173-kernel/os-interface.c
@@ -87,10 +87,16 @@ typedef struct os_sema_s
 {
     nv_stack_t        *sp;
     struct completion  completion;
-#if defined(CONFIG_PREEMPT_RT)
-    raw_spinlock_t     lock;
+#ifdef CONFIG_PREEMPT_RT
+    atomic_spinlock_t lock;
+#define nv_spin_lock_init(x) atomic_spin_lock_init(x)
+#define nv_spin_lock_irqsave(x, f) atomic_spin_lock_irqsave((x), (f))
+#define nv_spin_unlock_irqrestore(x, f) atomic_spin_unlock_irqrestore((x), (f))
 #else
     spinlock_t         lock;
+#define nv_spin_lock_init(x) spin_lock_init(x)
+#define nv_spin_lock_irqsave(x, f) spin_lock_irqsave((x), (f))
+#define nv_spin_unlock_irqrestore(x, f) spin_unlock_irqrestore((x), (f))
 #endif
     S032               count;
 } os_sema_t;
@@ -127,7 +133,7 @@ RM_STATUS NV_API_CALL os_alloc_sema
     os_sema = (os_sema_t *)*ppSema;
     os_sema->sp = sp;
     init_completion(&os_sema->completion);
-    spin_lock_init(&os_sema->lock);
+    nv_spin_lock_init(&os_sema->lock);
     os_sema->count = 1;
 
     return RM_OK;
@@ -171,18 +177,18 @@ RM_STATUS NV_API_CALL os_acquire_sema
     os_sema_t *os_sema = (os_sema_t *)pSema;
     unsigned long old_irq;
 
-    spin_lock_irqsave(&os_sema->lock, old_irq);
+    nv_spin_lock_irqsave(&os_sema->lock, old_irq);
     if (os_sema->count <= 0)
     {
         os_sema->count--;
-        spin_unlock_irqrestore(&os_sema->lock, old_irq);
+        nv_spin_unlock_irqrestore(&os_sema->lock, old_irq);
         wait_for_completion(&os_sema->completion);
     }
     else
     {
         os_sema->count--;
         rm_disable_interrupts(os_sema->sp);
-        spin_unlock_irqrestore(&os_sema->lock, old_irq);
+        nv_spin_unlock_irqrestore(&os_sema->lock, old_irq);
     }
 
     return RM_OK;
@@ -205,17 +211,17 @@ BOOL NV_API_CALL os_cond_acquire_sema
     os_sema_t *os_sema = (os_sema_t *)pSema;
     unsigned long old_irq;
 
-    spin_lock_irqsave(&os_sema->lock, old_irq);
+    nv_spin_lock_irqsave(&os_sema->lock, old_irq);
     if (os_sema->count <= 0)
     {
-        spin_unlock_irqrestore(&os_sema->lock, old_irq);
+        nv_spin_unlock_irqrestore(&os_sema->lock, old_irq);
         return FALSE;
     }
     else
     {
         os_sema->count--;
         rm_disable_interrupts(os_sema->sp);
-        spin_unlock_irqrestore(&os_sema->lock, old_irq);
+        nv_spin_unlock_irqrestore(&os_sema->lock, old_irq);
         return TRUE;
     }
 
@@ -239,7 +245,7 @@ RM_STATUS NV_API_CALL os_release_sema
     unsigned long old_irq;
     BOOL doWakeup;
 
-    spin_lock_irqsave(&os_sema->lock, old_irq);
+    nv_spin_lock_irqsave(&os_sema->lock, old_irq);
     if (os_sema->count < 0)
     {
         doWakeup = TRUE;
@@ -250,7 +256,7 @@ RM_STATUS NV_API_CALL os_release_sema
         rm_enable_interrupts(os_sema->sp);
     }
     os_sema->count++;
-    spin_unlock_irqrestore(&os_sema->lock, old_irq);
+    nv_spin_unlock_irqrestore(&os_sema->lock, old_irq);
 
     if (doWakeup)
         complete(&os_sema->completion);


#
---
 nv-linux.h     |   11 +----------
 os-interface.c |   28 +++++++++++++++++-----------
 2 files changed, 18 insertions(+), 21 deletions(-)

Index: nvidia96-kernel/nv-linux.h
===================================================================
--- nvidia96-kernel.orig/nv-linux.h
+++ nvidia96-kernel/nv-linux.h
@@ -655,16 +655,7 @@ static inline int nv_execute_on_all_cpus
 #define nv_down(lock)                   down(&lock)
 #define nv_up(lock)                     up(&lock)
 
-#if defined(CONFIG_PREEMPT_RT)
-#define NV_INIT_MUTEX(mutex) init_MUTEX(mutex)
-#else
-#define NV_INIT_MUTEX(mutex)                       \
-    {                                              \
-        struct semaphore __mutex =                 \
-            __SEMAPHORE_INITIALIZER(*(mutex), 1);  \
-        *(mutex) = __mutex;                        \
-    }
-#endif
+#define NV_INIT_MUTEX(mutex) sema_init((mutex), 1)
 
 #if defined (KERNEL_2_4)
 #  define NV_IS_SUSER()                 suser()
Index: nvidia96-kernel/os-interface.c
===================================================================
--- nvidia96-kernel.orig/os-interface.c
+++ nvidia96-kernel/os-interface.c
@@ -74,10 +74,16 @@ RM_STATUS NV_API_CALL os_clear_smp_barri
 typedef struct os_sema_s
 {
     struct completion  completion;
-#if defined(CONFIG_PREEMPT_RT)
-    raw_spinlock_t     lock;
+#ifdef CONFIG_PREEMPT_RT
+    atomic_spinlock_t lock;
+#define nv_spin_lock_init(x) atomic_spin_lock_init(x)
+#define nv_spin_lock_irqsave(x, f) atomic_spin_lock_irqsave((x), (f))
+#define nv_spin_unlock_irqrestore(x, f) atomic_spin_unlock_irqrestore((x), (f))
 #else
     spinlock_t         lock;
+#define nv_spin_lock_init(x) spin_lock_init(x)
+#define nv_spin_lock_irqsave(x, f) spin_lock_irqsave((x), (f))
+#define nv_spin_unlock_irqrestore(x, f) spin_unlock_irqrestore((x), (f))
 #endif
     S032               count;
 } os_sema_t;
@@ -101,7 +107,7 @@ RM_STATUS NV_API_CALL os_alloc_sema
 
     os_sema = (os_sema_t *)*ppSema;
     init_completion(&os_sema->completion);
-    spin_lock_init(&os_sema->lock);
+    nv_spin_lock_init(&os_sema->lock);
     os_sema->count = 1;
 
     return RM_OK;
@@ -140,18 +146,18 @@ RM_STATUS NV_API_CALL os_acquire_sema
     os_sema_t *os_sema = (os_sema_t *)pSema;
     unsigned long old_irq;
 
-    spin_lock_irqsave(&os_sema->lock, old_irq);
+    nv_spin_lock_irqsave(&os_sema->lock, old_irq);
     if (os_sema->count <= 0)
     {
         os_sema->count--;
-        spin_unlock_irqrestore(&os_sema->lock, old_irq);
+        nv_spin_unlock_irqrestore(&os_sema->lock, old_irq);
         wait_for_completion(&os_sema->completion);
     }
     else
     {
         os_sema->count--;
         rm_disable_interrupts();
-        spin_unlock_irqrestore(&os_sema->lock, old_irq);
+        nv_spin_unlock_irqrestore(&os_sema->lock, old_irq);
     }
 
     return RM_OK;
@@ -174,17 +180,17 @@ BOOL NV_API_CALL os_cond_acquire_sema
     os_sema_t *os_sema = (os_sema_t *)pSema;
     unsigned long old_irq;
 
-    spin_lock_irqsave(&os_sema->lock, old_irq);
+    nv_spin_lock_irqsave(&os_sema->lock, old_irq);
     if (os_sema->count <= 0)
     {
-        spin_unlock_irqrestore(&os_sema->lock, old_irq);
+        nv_spin_unlock_irqrestore(&os_sema->lock, old_irq);
         return FALSE;
     }
     else
     {
         os_sema->count--;
         rm_disable_interrupts();
-        spin_unlock_irqrestore(&os_sema->lock, old_irq);
+        nv_spin_unlock_irqrestore(&os_sema->lock, old_irq);
         return TRUE;
     }
 
@@ -208,7 +214,7 @@ RM_STATUS NV_API_CALL os_release_sema
     unsigned long old_irq;
     BOOL doWakeup;
 
-    spin_lock_irqsave(&os_sema->lock, old_irq);
+    nv_spin_lock_irqsave(&os_sema->lock, old_irq);
     if (os_sema->count < 0)
     {
         doWakeup = TRUE;
@@ -219,7 +225,7 @@ RM_STATUS NV_API_CALL os_release_sema
         rm_enable_interrupts();
     }
     os_sema->count++;
-    spin_unlock_irqrestore(&os_sema->lock, old_irq);
+    nv_spin_unlock_irqrestore(&os_sema->lock, old_irq);
 
     if (doWakeup)
         complete(&os_sema->completion);


#
---
 nv-linux.h     |   11 +----------
 os-interface.c |   26 ++++++++++++++++----------
 2 files changed, 17 insertions(+), 20 deletions(-)

Index: nvidia71-kernel/nv-linux.h
===================================================================
--- nvidia71-kernel.orig/nv-linux.h
+++ nvidia71-kernel/nv-linux.h
@@ -648,16 +648,7 @@ static inline int nv_execute_on_all_cpus
 #define nv_down(lock)                   down(&lock)
 #define nv_up(lock)                     up(&lock)
 
-#if defined(CONFIG_PREEMPT_RT)
-#define NV_INIT_MUTEX(mutex) init_MUTEX(mutex)
-#else
-#define NV_INIT_MUTEX(mutex)                       \
-    {                                              \
-        struct semaphore __mutex =                 \
-            __SEMAPHORE_INITIALIZER(*(mutex), 1);  \
-        *(mutex) = __mutex;                        \
-    }
-#endif
+#define NV_INIT_MUTEX(mutex) sema_init((mutex), 1)
 
 #if defined (KERNEL_2_4)
 #  define NV_IS_SUSER()                 suser()
Index: nvidia71-kernel/os-interface.c
===================================================================
--- nvidia71-kernel.orig/os-interface.c
+++ nvidia71-kernel/os-interface.c
@@ -75,9 +75,15 @@ typedef struct os_sema_s
 {
     struct completion  completion;
 #if defined(CONFIG_PREEMPT_RT)
-    raw_spinlock_t   lock;
+    atomic_spinlock_t lock;
+#define nv_spin_lock_init(x) atomic_spin_lock_init(x)
+#define nv_spin_lock_irqsave(x, f) atomic_spin_lock_irqsave((x), (f))
+#define nv_spin_unlock_irqrestore(x, f) atomic_spin_unlock_irqrestore((x), (f))
 #else
     spinlock_t       lock;
+#define nv_spin_lock_init(x) spin_lock_init(x)
+#define nv_spin_lock_irqsave(x, f) spin_lock_irqsave((x), (f))
+#define nv_spin_unlock_irqrestore(x, f) spin_unlock_irqrestore((x), (f))
 #endif
     S032             count;
 } os_sema_t;
@@ -101,7 +107,7 @@ RM_STATUS NV_API_CALL os_alloc_sema
 
     os_sema = (os_sema_t *)*ppSema;
     init_completion(&os_sema->completion);
-    spin_lock_init(&os_sema->lock);
+    nv_spin_lock_init(&os_sema->lock);
     os_sema->count = 1;
 
     return RM_OK;
@@ -140,18 +146,18 @@ RM_STATUS NV_API_CALL os_acquire_sema
     os_sema_t *os_sema = (os_sema_t *)pSema;
     unsigned long old_irq;
 
-    spin_lock_irqsave(&os_sema->lock, old_irq);
+    nv_spin_lock_irqsave(&os_sema->lock, old_irq);
     if (os_sema->count <= 0)
     {
         os_sema->count--;
-        spin_unlock_irqrestore(&os_sema->lock, old_irq);
+        nv_spin_unlock_irqrestore(&os_sema->lock, old_irq);
         wait_for_completion(&os_sema->completion);
     }
     else
     {
         os_sema->count--;
         rm_disable_interrupts();
-        spin_unlock_irqrestore(&os_sema->lock, old_irq);
+        nv_spin_unlock_irqrestore(&os_sema->lock, old_irq);
     }
 
     return RM_OK;
@@ -174,17 +180,17 @@ BOOL NV_API_CALL os_cond_acquire_sema
     os_sema_t *os_sema = (os_sema_t *)pSema;
     unsigned long old_irq;
 
-    spin_lock_irqsave(&os_sema->lock, old_irq);
+    nv_spin_lock_irqsave(&os_sema->lock, old_irq);
     if (os_sema->count <= 0)
     {
-        spin_unlock_irqrestore(&os_sema->lock, old_irq);
+        nv_spin_unlock_irqrestore(&os_sema->lock, old_irq);
         return FALSE;
     }
     else
     {
         os_sema->count--;
         rm_disable_interrupts();
-        spin_unlock_irqrestore(&os_sema->lock, old_irq);
+        nv_spin_unlock_irqrestore(&os_sema->lock, old_irq);
         return TRUE;
     }
 
@@ -208,7 +214,7 @@ RM_STATUS NV_API_CALL os_release_sema
     unsigned long old_irq;
     BOOL doWakeup;
 
-    spin_lock_irqsave(&os_sema->lock, old_irq);
+    nv_spin_lock_irqsave(&os_sema->lock, old_irq);
     if (os_sema->count < 0)
     {
         doWakeup = TRUE;
@@ -219,7 +225,7 @@ RM_STATUS NV_API_CALL os_release_sema
         rm_enable_interrupts();
     }
     os_sema->count++;
-    spin_unlock_irqrestore(&os_sema->lock, old_irq);
+    nv_spin_unlock_irqrestore(&os_sema->lock, old_irq);
 
     if (doWakeup)
         complete(&os_sema->completion);
