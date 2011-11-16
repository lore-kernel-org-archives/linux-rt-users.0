From: Thomas Schauss <schauss@tum.de>
Subject: Re: 3.2-rc1 and nvidia drivers
Date: Wed, 16 Nov 2011 10:40:13 +0100
Message-ID: <4EC384FD.1040106@tum.de>
References: <CAOLSsAysHCVAHsSRMTXUpXm_qjK5D5DRagHCS0ZYrxGQ8mDkfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010900030904020409000700"
Cc: RT <linux-rt-users@vger.kernel.org>
To: Javier Sanz <jsanza@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailrelay1.lrz-muenchen.de ([129.187.254.106]:33772 "EHLO
	mailrelay1.lrz-muenchen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755037Ab1KPJ4A (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 16 Nov 2011 04:56:00 -0500
In-Reply-To: <CAOLSsAysHCVAHsSRMTXUpXm_qjK5D5DRagHCS0ZYrxGQ8mDkfw@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is a multi-part message in MIME format.
--------------010900030904020409000700
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

actually I have wanted to write to this list about NVIDIA-drivers for 
some time and will use this opportunity.

Generally, it is obviously preferable to use the nouveau-driver if 
possible which is working just fine. At our institute however, we need 
to use the rt-patch in combination with the proprietary NVIDIA driver as 
we need CUDA-support combined with low-latency control (e.g. for visual 
servoing). And I am sure we are not the only ones requiring this 
combination.

We have been using the 2.6.33-rt29 for some time now without any issues 
and with very satisfactory latency. This required a small patch to the 
NVIDIA-driver (there is a check for PREEMPT_RT) as atomic_spin* was 
renamed to raw_spin* in one of the 2.6-rt-patches.

3.0-rt requires an additional slight modification as CONFIG_PREEMPT_RT 
is not defined anymore and we must check instead for 
CONFIG_PREEMPT_RT_FULL to decide whether to use raw spin_locks. Using 
this patch it is then not necessary to change any EXPORT_SYMBOL_GPL to 
EXPORT_SYMBOL in the kernel as was proposed in some other threads here.

You can find the patches for the nvidia-driver for 2.6.33-rt and 3.0-rt 
below.

Unfortunately, with 3.0-rt and the nvidia-driver we get complete system 
freezes when starting X on several different hardware setups (a few 
systems work fine). This is certainly caused by this combination. When 
using the nouveau-driver everything works fine.

I tested this with rt13 through rt20 and will check with the current 
version tomorrow. If it still fails I will put together a list of 
working vs. non-working hardware setups.

Unfortunately, apart from that I am not sure how to debug this issue, as 
the complete system freezes (including the serial console) and I can't 
find any suspicious messages in the logs. Any ideas?

Btw, changing EXPORT_SYMBOL_GPL to EXPORT_SYMBOL for 
migrate_enable/disable, ... and then using the non-raw spinlocks results 
in exactly the same behavior.

Best Regards,
Thomas Schauss

====================================================================

Patch for 3.0-rt:

--- a/nv-linux.h        2011-10-26 13:35:32.866579965 +0200
+++ b/nv-linux.h        2011-10-26 13:35:47.265117607 +0200
@@ -262,17 +262,17 @@
  #endif
  #endif

-#if defined(CONFIG_PREEMPT_RT)
-typedef atomic_spinlock_t         nv_spinlock_t;
-#define NV_SPIN_LOCK_INIT(lock)   atomic_spin_lock_init(lock)
-#define NV_SPIN_LOCK_IRQ(lock)    atomic_spin_lock_irq(lock)
-#define NV_SPIN_UNLOCK_IRQ(lock)  atomic_spin_unlock_irq(lock)
-#define NV_SPIN_LOCK_IRQSAVE(lock,flags) 
atomic_spin_lock_irqsave(lock,flags)
+#if defined(CONFIG_PREEMPT_RT_FULL)
+typedef raw_spinlock_t            nv_spinlock_t;
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
@@ -854,8 +854,8 @@
      return ret;
  }

-#if defined(CONFIG_PREEMPT_RT)
-#define NV_INIT_MUTEX(mutex) semaphore_init(mutex)
+#if defined(CONFIG_PREEMPT_RT_FULL)
+#define NV_INIT_MUTEX(mutex) sema_init(mutex,1)
  #else
  #if !defined(__SEMAPHORE_INITIALIZER) && 
defined(__COMPAT_SEMAPHORE_INITIALIZER)
  #define __SEMAPHORE_INITIALIZER __COMPAT_SEMAPHORE_INITIALIZER

====================================================================

Patch for 2.6.33-rt:

--- a/nv-linux.h        2011-10-28 10:31:47.416915958 +0200
+++ b/nv-linux.h        2011-10-28 10:32:48.592195509 +0200
@@ -263,16 +263,16 @@
  #endif

  #if defined(CONFIG_PREEMPT_RT)
-typedef atomic_spinlock_t         nv_spinlock_t;
-#define NV_SPIN_LOCK_INIT(lock)   atomic_spin_lock_init(lock)
-#define NV_SPIN_LOCK_IRQ(lock)    atomic_spin_lock_irq(lock)
-#define NV_SPIN_UNLOCK_IRQ(lock)  atomic_spin_unlock_irq(lock)
-#define NV_SPIN_LOCK_IRQSAVE(lock,flags) 
atomic_spin_lock_irqsave(lock,flags)
+typedef raw_spinlock_t            nv_spinlock_t;
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
@@ -855,7 +855,7 @@
  }

  #if defined(CONFIG_PREEMPT_RT)
-#define NV_INIT_MUTEX(mutex) semaphore_init(mutex)
+#define NV_INIT_MUTEX(mutex) sema_init(mutex,1)
  #else
  #if !defined(__SEMAPHORE_INITIALIZER) && 
defined(__COMPAT_SEMAPHORE_INITIALIZER)
  #define __SEMAPHORE_INITIALIZER __COMPAT_SEMAPHORE_INITIALIZER

--------------010900030904020409000700
Content-Type: text/x-vcard; charset=utf-8;
 name="schauss.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="schauss.vcf"

begin:vcard
fn:Thomas Schauss
n:Schauss;Thomas
org:Technische Universitaet Muenchen (TUM);Institute of Automatic Control Engineering (LSR)
adr:;;Theresienstr. 90;Munich;;80333;Germany
email;internet:schauss@tum.de
title:Dipl.-Ing. (Univ.)
tel;work:+49 89 289 23406
tel;fax:+49 89 289 28340
url:http://www.lsr.ei.tum.de
version:2.1
end:vcard


--------------010900030904020409000700--
