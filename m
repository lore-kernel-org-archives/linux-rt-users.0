From: Joakim Hernberg <jbh@alchemy.lu>
Subject: patch for NVIDIA on -rt
Date: Mon, 16 Aug 2010 21:29:03 +0200
Message-ID: <201008162129.04308.jbh@alchemy.lu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from apollo.athome.lu ([80.90.45.149]:40155 "EHLO apollo.valain.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756046Ab0HPT3I convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 16 Aug 2010 15:29:08 -0400
Received: from tor.localnet (vodsl-8828.vo.lu [85.93.201.124])
	(authenticated bits=0)
	by apollo.valain.com (8.13.1/8.13.1) with ESMTP id o7GJT51h010719
	for <linux-rt-users@vger.kernel.org>; Mon, 16 Aug 2010 21:29:05 +0200
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

For those that might need it.

>From bff65cf087bae512ae9f485f4556e89d304f99a9 Mon Sep 17 00:00:00 2001
From: Joakim B Hernberg <jbh@alchemy.lu>
Date: Sun, 8 Aug 2010 12:39:34 +0200
Subject: [PATCH] Patch nvidia proprietary video driver 256.44 for rt patched 
kernel 2.6.33.7-rt29

---
 kernel/nv-linux.h |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/nv-linux.h b/kernel/nv-linux.h
index 3ba43e7..e95460a 100644
--- a/kernel/nv-linux.h
+++ b/kernel/nv-linux.h
@@ -218,16 +218,16 @@ extern int nv_pat_mode;
 #endif
 
 #if defined(CONFIG_PREEMPT_RT)
-typedef atomic_spinlock_t         nv_spinlock_t;
-#define NV_SPIN_LOCK_INIT(lock)   atomic_spin_lock_init(lock)
-#define NV_SPIN_LOCK_IRQ(lock)    atomic_spin_lock_irq(lock)
-#define NV_SPIN_UNLOCK_IRQ(lock)  atomic_spin_unlock_irq(lock)
-#define NV_SPIN_LOCK_IRQSAVE(lock,flags) atomic_spin_lock_irqsave(lock,flags)
+typedef raw_spinlock_t         nv_spinlock_t;
+#define NV_SPIN_LOCK_INIT(lock)   raw_spin_lock_init(lock)
+#define NV_SPIN_LOCK_IRQ(lock)    raw_spin_lock_irq(lock)
+#define NV_SPIN_UNLOCK_IRQ(lock)  raw_spin_unlock_irq(lock)
+#define NV_SPIN_LOCK_IRQSAVE(lock,flags) raw_spin_lock_irqsave(lock,flags)
 #define NV_SPIN_UNLOCK_IRQRESTORE(lock,flags) \
-  atomic_spin_unlock_irqrestore(lock,flags)
-#define NV_SPIN_LOCK(lock)        atomic_spin_lock(lock)
-#define NV_SPIN_UNLOCK(lock)      atomic_spin_unlock(lock)
-#define NV_SPIN_UNLOCK_WAIT(lock) atomic_spin_unlock_wait(lock)
+  raw_spin_unlock_irqrestore(lock,flags)
+#define NV_SPIN_LOCK(lock)        raw_spin_lock(lock)
+#define NV_SPIN_UNLOCK(lock)      raw_spin_unlock(lock)
+#define NV_SPIN_UNLOCK_WAIT(lock) raw_spin_unlock_wait(lock)
 #else
 typedef spinlock_t                nv_spinlock_t;
 #define NV_SPIN_LOCK_INIT(lock)   spin_lock_init(lock)
@@ -791,7 +791,7 @@ static inline int nv_execute_on_all_cpus(void (*func)(void 
*info), void *info)
 }
 
 #if defined(CONFIG_PREEMPT_RT)
-#define NV_INIT_MUTEX(mutex) semaphore_init(mutex)
+#define NV_INIT_MUTEX(mutex) sema_init(mutex,1)
 #else
 #if !defined(__SEMAPHORE_INITIALIZER) && 
defined(__COMPAT_SEMAPHORE_INITIALIZER)
 #define __SEMAPHORE_INITIALIZER __COMPAT_SEMAPHORE_INITIALIZER
-- 
1.7.2.1

