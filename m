From: Ng Oon-Ee <ngoonee@gmail.com>
Subject: Re: [archival] 2.6.31-rt nvidia patches
Date: Mon, 28 Sep 2009 01:21:09 +0800
Message-ID: <1254072069.22703.2.camel@localhost.localdomain>
References: <alpine.LSU.2.00.0909121109100.8788@obet.zrqbmnf.qr>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Jan Engelhardt <jengelh@medozas.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yw0-f174.google.com ([209.85.211.174]:43196 "EHLO
	mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750699AbZI0RUE (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 27 Sep 2009 13:20:04 -0400
Received: by ywh4 with SMTP id 4so4119136ywh.33
        for <linux-rt-users@vger.kernel.org>; Sun, 27 Sep 2009 10:20:08 -0700 (PDT)
In-Reply-To: <alpine.LSU.2.00.0909121109100.8788@obet.zrqbmnf.qr>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, 2009-09-12 at 11:24 +0200, Jan Engelhardt wrote:
> For interested parties and archival, patches to the four nvidia packages  
> (185, 173, 96, 71) for 2.6.31-rt.
> Tested {2.6.31-rc8-rt9 with 96}, which seems to work.

Adding on patch for nvidia-beta (currently at 190.36, also worked for
190.32). Tested against 2.6.31-rt11.

diff -Naur nv.orig/nv-linux.h nv/nv-linux.h
--- nv-linux.h	2009-09-02 18:42:19.000000000 +0800
+++ nv-linux.h	2009-09-22 19:31:12.285960428 +0800
@@ -743,7 +743,7 @@
 #define nv_up(lock)                     up(&lock)
 
 #if defined(CONFIG_PREEMPT_RT)
-#define NV_INIT_MUTEX(mutex) init_MUTEX(mutex)
+#define NV_INIT_MUTEX(mutex) semaphore_init(mutex)
 #else
 #if !defined(__SEMAPHORE_INITIALIZER) &&
defined(__COMPAT_SEMAPHORE_INITIALIZER)
 #define __SEMAPHORE_INITIALIZER __COMPAT_SEMAPHORE_INITIALIZER
diff -Naur nv.orig/os-interface.c nv/os-interface.c
--- os-interface.c	2009-09-02 18:42:17.000000000 +0800
+++ os-interface.c	2009-09-22 19:35:25.977961345 +0800
@@ -109,9 +109,15 @@
     nv_stack_t        *sp;
     struct completion  completion;
 #if defined(CONFIG_PREEMPT_RT)
-    raw_spinlock_t     lock;
+    atomic_spinlock_t lock;
+#define nv_spin_lock_init(x) atomic_spin_lock_init(x)
+#define nv_spin_lock_irqsave(x, f) atomic_spin_lock_irqsave((x), (f))
+#define nv_spin_unlock_irqrestore(x, f)
atomic_spin_unlock_irqrestore((x), (f))
 #else
     spinlock_t         lock;
+#define nv_spin_lock_init(x) spin_lock_init(x)
+#define nv_spin_lock_irqsave(x, f) spin_lock_irqsave((x), (f))
+#define nv_spin_unlock_irqrestore(x, f) spin_unlock_irqrestore((x),
(f))
 #endif
     S032               count;
 } os_sema_t;
@@ -148,7 +154,7 @@
     os_sema = (os_sema_t *)*ppSema;
     os_sema->sp = sp;
     init_completion(&os_sema->completion);
-    spin_lock_init(&os_sema->lock);
+    nv_spin_lock_init(&os_sema->lock);
     os_sema->count = 1;
 
     if (nv_os_smp_barrier_init())
@@ -199,18 +205,18 @@
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
@@ -233,17 +239,17 @@
     os_sema_t *os_sema = (os_sema_t *)pSema;
     unsigned long old_irq;
 
-    spin_lock_irqsave(&os_sema->lock, old_irq);
+    nv_spin_lock_irqsave(&os_sema->lock, old_irq);
     if (os_sema->count <= 0)
     {
-        spin_unlock_irqrestore(&os_sema->lock, old_irq);
+        nv_spin_unlock_irqrestore(&os_sema->lock, old_irq);
         return RM_ERROR;
     }
     else
     {
         os_sema->count--;
         rm_disable_interrupts(os_sema->sp);
-        spin_unlock_irqrestore(&os_sema->lock, old_irq);
+        nv_spin_unlock_irqrestore(&os_sema->lock, old_irq);
         return RM_OK;
     }
 
@@ -267,7 +273,7 @@
     unsigned long old_irq;
     BOOL doWakeup;
 
-    spin_lock_irqsave(&os_sema->lock, old_irq);
+    nv_spin_lock_irqsave(&os_sema->lock, old_irq);
     if (os_sema->count < 0)
     {
         doWakeup = TRUE;
@@ -278,7 +284,7 @@
         rm_enable_interrupts(os_sema->sp);
     }
     os_sema->count++;
-    spin_unlock_irqrestore(&os_sema->lock, old_irq);
+    nv_spin_unlock_irqrestore(&os_sema->lock, old_irq);
 
     if (doWakeup)
         complete(&os_sema->completion);
@@ -1383,7 +1389,7 @@
     unsigned long oldIrql;
 
     os_sema = (os_sema_t *) pSema;
-    spin_lock_irqsave(&os_sema->lock, oldIrql);
+    nv_spin_lock_irqsave(&os_sema->lock, oldIrql);
 
     return oldIrql;
 }
@@ -1394,7 +1400,7 @@
     unsigned long old_irq = (unsigned long) oldIrql;
 
     os_sema = (os_sema_t *) pSema;
-    spin_unlock_irqrestore(&os_sema->lock, old_irq);
+    nv_spin_unlock_irqrestore(&os_sema->lock, old_irq);
 }
 
 RM_STATUS NV_API_CALL os_get_address_space_info(

