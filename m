From: Joakim Hernberg <jbh@alchemy.lu>
Subject: rt patch for closed NVIDIA driver.
Date: Mon, 16 Aug 2010 09:55:35 +0200
Message-ID: <201008160955.35490.jbh@alchemy.lu>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_37OaMr5THcFgN+c"
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from apollo.athome.lu ([80.90.45.149]:55628 "EHLO apollo.valain.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751599Ab0IUXUx (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 21 Sep 2010 19:20:53 -0400
Received: from tor.localnet (vodsl-8828.vo.lu [85.93.201.124])
	(authenticated bits=0)
	by apollo.valain.com (8.13.1/8.13.1) with ESMTP id o7G7tZA0010719
	for <linux-rt-users@vger.kernel.org>; Mon, 16 Aug 2010 09:55:36 +0200
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Boundary-00=_37OaMr5THcFgN+c
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit

Thought i'd post this patch in case someone needs it.

---

   Jack

--Boundary-00=_37OaMr5THcFgN+c
Content-Type: text/x-patch;
  charset="UTF-8";
  name="0001-Patch-nvidia-for-rt-.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-Patch-nvidia-for-rt-.patch"

=46rom bff65cf087bae512ae9f485f4556e89d304f99a9 Mon Sep 17 00:00:00 2001
=46rom: Joakim B Hernberg <jbh@alchemy.lu>
Date: Sun, 8 Aug 2010 12:39:34 +0200
Subject: [PATCH] Patch nvidia proprietary video driver 256.44 for rt patche=
d kernel 2.6.33.7-rt29

=2D--
 kernel/nv-linux.h |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/nv-linux.h b/kernel/nv-linux.h
index 3ba43e7..e95460a 100644
=2D-- a/kernel/nv-linux.h
+++ b/kernel/nv-linux.h
@@ -218,16 +218,16 @@ extern int nv_pat_mode;
 #endif
=20
 #if defined(CONFIG_PREEMPT_RT)
=2Dtypedef atomic_spinlock_t         nv_spinlock_t;
=2D#define NV_SPIN_LOCK_INIT(lock)   atomic_spin_lock_init(lock)
=2D#define NV_SPIN_LOCK_IRQ(lock)    atomic_spin_lock_irq(lock)
=2D#define NV_SPIN_UNLOCK_IRQ(lock)  atomic_spin_unlock_irq(lock)
=2D#define NV_SPIN_LOCK_IRQSAVE(lock,flags) atomic_spin_lock_irqsave(lock,f=
lags)
+typedef raw_spinlock_t         nv_spinlock_t;
+#define NV_SPIN_LOCK_INIT(lock)   raw_spin_lock_init(lock)
+#define NV_SPIN_LOCK_IRQ(lock)    raw_spin_lock_irq(lock)
+#define NV_SPIN_UNLOCK_IRQ(lock)  raw_spin_unlock_irq(lock)
+#define NV_SPIN_LOCK_IRQSAVE(lock,flags) raw_spin_lock_irqsave(lock,flags)
 #define NV_SPIN_UNLOCK_IRQRESTORE(lock,flags) \
=2D  atomic_spin_unlock_irqrestore(lock,flags)
=2D#define NV_SPIN_LOCK(lock)        atomic_spin_lock(lock)
=2D#define NV_SPIN_UNLOCK(lock)      atomic_spin_unlock(lock)
=2D#define NV_SPIN_UNLOCK_WAIT(lock) atomic_spin_unlock_wait(lock)
+  raw_spin_unlock_irqrestore(lock,flags)
+#define NV_SPIN_LOCK(lock)        raw_spin_lock(lock)
+#define NV_SPIN_UNLOCK(lock)      raw_spin_unlock(lock)
+#define NV_SPIN_UNLOCK_WAIT(lock) raw_spin_unlock_wait(lock)
 #else
 typedef spinlock_t                nv_spinlock_t;
 #define NV_SPIN_LOCK_INIT(lock)   spin_lock_init(lock)
@@ -791,7 +791,7 @@ static inline int nv_execute_on_all_cpus(void (*func)(v=
oid *info), void *info)
 }
=20
 #if defined(CONFIG_PREEMPT_RT)
=2D#define NV_INIT_MUTEX(mutex) semaphore_init(mutex)
+#define NV_INIT_MUTEX(mutex) sema_init(mutex,1)
 #else
 #if !defined(__SEMAPHORE_INITIALIZER) && defined(__COMPAT_SEMAPHORE_INITIA=
LIZER)
 #define __SEMAPHORE_INITIALIZER __COMPAT_SEMAPHORE_INITIALIZER
=2D-=20
1.7.2.1


--Boundary-00=_37OaMr5THcFgN+c--
