Return-Path: <SRS0=WSWX=2K=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED397C2D0C0
	for <linux-rt-users@archiver.kernel.org>; Fri, 20 Dec 2019 16:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B96CE21D7E
	for <linux-rt-users@archiver.kernel.org>; Fri, 20 Dec 2019 16:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfLTQA3 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 20 Dec 2019 11:00:29 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33858 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727181AbfLTQA3 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 20 Dec 2019 11:00:29 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iiKhT-0005zw-IF; Fri, 20 Dec 2019 17:00:23 +0100
Date:   Fri, 20 Dec 2019 17:00:23 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.4.5-rt3
Message-ID: <20191220160023.duw5exqnzkxxzxxi@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.4.5-rt3 patch set. 

Changes since v5.4.5-rt2:

  - Allow CPUMASK_OFFSTACK on RT again. The reason why it got disabled
    got fixed. I haven't seen anything new on x86-64/arm64.

  - Allow NEON in kernel on ARM*. The code got reworked in the meantime
    and the original problem was solved. I did not find any new reason
    to keep it disabled.

  - Address a "sleeping while atomic" issue in "userfaultfd".

Known issues
     - None

The delta patch against v5.4.5-rt2 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.4/incr/patch-5.4.5-rt2-rt3.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.4.5-rt3

The RT patch against v5.4.5 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.4/older/patch-5.4.5-rt3.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.4/older/patches-5.4.5-rt3.tar.xz

Sebastian
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index f42f0316aec0b..0e95b6d0bd74c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -2063,7 +2063,7 @@ config NEON
 
 config KERNEL_MODE_NEON
 	bool "Support for NEON in kernel mode"
-	depends on NEON && AEABI && !PREEMPT_RT
+	depends on NEON && AEABI
 	help
 	  Say Y to include support for NEON in kernel mode.
 
diff --git a/arch/arm64/crypto/Kconfig b/arch/arm64/crypto/Kconfig
index 79c804a5e02c4..4922c4451e7c3 100644
--- a/arch/arm64/crypto/Kconfig
+++ b/arch/arm64/crypto/Kconfig
@@ -19,50 +19,50 @@ config CRYPTO_SHA512_ARM64
 
 config CRYPTO_SHA1_ARM64_CE
 	tristate "SHA-1 digest algorithm (ARMv8 Crypto Extensions)"
-	depends on KERNEL_MODE_NEON && PREEMPT_RT
+	depends on KERNEL_MODE_NEON
 	select CRYPTO_HASH
 	select CRYPTO_SHA1
 
 config CRYPTO_SHA2_ARM64_CE
 	tristate "SHA-224/SHA-256 digest algorithm (ARMv8 Crypto Extensions)"
-	depends on KERNEL_MODE_NEON && PREEMPT_RT
+	depends on KERNEL_MODE_NEON
 	select CRYPTO_HASH
 	select CRYPTO_SHA256_ARM64
 
 config CRYPTO_SHA512_ARM64_CE
 	tristate "SHA-384/SHA-512 digest algorithm (ARMv8 Crypto Extensions)"
-	depends on KERNEL_MODE_NEON && PREEMPT_RT
+	depends on KERNEL_MODE_NEON
 	select CRYPTO_HASH
 	select CRYPTO_SHA512_ARM64
 
 config CRYPTO_SHA3_ARM64
 	tristate "SHA3 digest algorithm (ARMv8.2 Crypto Extensions)"
-	depends on KERNEL_MODE_NEON && PREEMPT_RT
+	depends on KERNEL_MODE_NEON
 	select CRYPTO_HASH
 	select CRYPTO_SHA3
 
 config CRYPTO_SM3_ARM64_CE
 	tristate "SM3 digest algorithm (ARMv8.2 Crypto Extensions)"
-	depends on KERNEL_MODE_NEON && PREEMPT_RT
+	depends on KERNEL_MODE_NEON
 	select CRYPTO_HASH
 	select CRYPTO_SM3
 
 config CRYPTO_SM4_ARM64_CE
 	tristate "SM4 symmetric cipher (ARMv8.2 Crypto Extensions)"
-	depends on KERNEL_MODE_NEON && PREEMPT_RT
+	depends on KERNEL_MODE_NEON
 	select CRYPTO_ALGAPI
 	select CRYPTO_SM4
 
 config CRYPTO_GHASH_ARM64_CE
 	tristate "GHASH/AES-GCM using ARMv8 Crypto Extensions"
-	depends on KERNEL_MODE_NEON && PREEMPT_RT
+	depends on KERNEL_MODE_NEON
 	select CRYPTO_HASH
 	select CRYPTO_GF128MUL
 	select CRYPTO_LIB_AES
 
 config CRYPTO_CRCT10DIF_ARM64_CE
 	tristate "CRCT10DIF digest algorithm using PMULL instructions"
-	depends on KERNEL_MODE_NEON && CRC_T10DIF && !PREEMPT_RT
+	depends on KERNEL_MODE_NEON && CRC_T10DIF
 	select CRYPTO_HASH
 
 config CRYPTO_AES_ARM64
@@ -71,13 +71,13 @@ config CRYPTO_AES_ARM64
 
 config CRYPTO_AES_ARM64_CE
 	tristate "AES core cipher using ARMv8 Crypto Extensions"
-	depends on ARM64 && KERNEL_MODE_NEON && PREEMPT_RT
+	depends on ARM64 && KERNEL_MODE_NEON
 	select CRYPTO_ALGAPI
 	select CRYPTO_LIB_AES
 
 config CRYPTO_AES_ARM64_CE_CCM
 	tristate "AES in CCM mode using ARMv8 Crypto Extensions"
-	depends on ARM64 && KERNEL_MODE_NEON && PREEMPT_RT
+	depends on ARM64 && KERNEL_MODE_NEON
 	select CRYPTO_ALGAPI
 	select CRYPTO_AES_ARM64_CE
 	select CRYPTO_AEAD
@@ -85,7 +85,7 @@ config CRYPTO_AES_ARM64_CE_CCM
 
 config CRYPTO_AES_ARM64_CE_BLK
 	tristate "AES in ECB/CBC/CTR/XTS modes using ARMv8 Crypto Extensions"
-	depends on KERNEL_MODE_NEON && !PREEMPT_RT
+	depends on KERNEL_MODE_NEON
 	select CRYPTO_BLKCIPHER
 	select CRYPTO_AES_ARM64_CE
 	select CRYPTO_AES_ARM64
@@ -93,7 +93,7 @@ config CRYPTO_AES_ARM64_CE_BLK
 
 config CRYPTO_AES_ARM64_NEON_BLK
 	tristate "AES in ECB/CBC/CTR/XTS modes using NEON instructions"
-	depends on KERNEL_MODE_NEON && PREEMPT_RT
+	depends on KERNEL_MODE_NEON
 	select CRYPTO_BLKCIPHER
 	select CRYPTO_AES_ARM64
 	select CRYPTO_LIB_AES
@@ -101,18 +101,18 @@ config CRYPTO_AES_ARM64_NEON_BLK
 
 config CRYPTO_CHACHA20_NEON
 	tristate "ChaCha20, XChaCha20, and XChaCha12 stream ciphers using NEON instructions"
-	depends on KERNEL_MODE_NEON && !PREEMPT_RT
+	depends on KERNEL_MODE_NEON
 	select CRYPTO_BLKCIPHER
 	select CRYPTO_CHACHA20
 
 config CRYPTO_NHPOLY1305_NEON
 	tristate "NHPoly1305 hash function using NEON instructions (for Adiantum)"
-	depends on KERNEL_MODE_NEON && !PREEMPT_RT
+	depends on KERNEL_MODE_NEON
 	select CRYPTO_NHPOLY1305
 
 config CRYPTO_AES_ARM64_BS
 	tristate "AES in ECB/CBC/CTR/XTS modes using bit-sliced NEON algorithm"
-	depends on KERNEL_MODE_NEON && !PREEMPT_RT
+	depends on KERNEL_MODE_NEON
 	select CRYPTO_BLKCIPHER
 	select CRYPTO_AES_ARM64_NEON_BLK
 	select CRYPTO_AES_ARM64
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 7f359aacf8148..4b77b3273051e 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -967,7 +967,7 @@ config CALGARY_IOMMU_ENABLED_BY_DEFAULT
 config MAXSMP
 	bool "Enable Maximum number of SMP Processors and NUMA Nodes"
 	depends on X86_64 && SMP && DEBUG_KERNEL
-	select CPUMASK_OFFSTACK if !PREEMPT_RT
+	select CPUMASK_OFFSTACK
 	---help---
 	  Enable maximum number of CPUS and NUMA Nodes for this architecture.
 	  If unsure, say N.
diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index f9fd18670e22d..92871bee05b39 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -61,7 +61,7 @@ struct userfaultfd_ctx {
 	/* waitqueue head for events */
 	wait_queue_head_t event_wqh;
 	/* a refile sequence protected by fault_pending_wqh lock */
-	struct seqcount refile_seq;
+	seqlock_t refile_seq;
 	/* pseudo fd refcounting */
 	refcount_t refcount;
 	/* userfaultfd syscall flags */
@@ -1063,7 +1063,7 @@ static ssize_t userfaultfd_ctx_read(struct userfaultfd_ctx *ctx, int no_wait,
 			 * waitqueue could become empty if this is the
 			 * only userfault.
 			 */
-			write_seqcount_begin(&ctx->refile_seq);
+			write_seqlock(&ctx->refile_seq);
 
 			/*
 			 * The fault_pending_wqh.lock prevents the uwq
@@ -1089,7 +1089,7 @@ static ssize_t userfaultfd_ctx_read(struct userfaultfd_ctx *ctx, int no_wait,
 			list_del(&uwq->wq.entry);
 			add_wait_queue(&ctx->fault_wqh, &uwq->wq);
 
-			write_seqcount_end(&ctx->refile_seq);
+			write_sequnlock(&ctx->refile_seq);
 
 			/* careful to always initialize msg if ret == 0 */
 			*msg = uwq->msg;
@@ -1262,11 +1262,11 @@ static __always_inline void wake_userfault(struct userfaultfd_ctx *ctx,
 	 * sure we've userfaults to wake.
 	 */
 	do {
-		seq = read_seqcount_begin(&ctx->refile_seq);
+		seq = read_seqbegin(&ctx->refile_seq);
 		need_wakeup = waitqueue_active(&ctx->fault_pending_wqh) ||
 			waitqueue_active(&ctx->fault_wqh);
 		cond_resched();
-	} while (read_seqcount_retry(&ctx->refile_seq, seq));
+	} while (read_seqretry(&ctx->refile_seq, seq));
 	if (need_wakeup)
 		__wake_userfault(ctx, range);
 }
@@ -1935,7 +1935,7 @@ static void init_once_userfaultfd_ctx(void *mem)
 	init_waitqueue_head(&ctx->fault_wqh);
 	init_waitqueue_head(&ctx->event_wqh);
 	init_waitqueue_head(&ctx->fd_wqh);
-	seqcount_init(&ctx->refile_seq);
+	seqlock_init(&ctx->refile_seq);
 }
 
 SYSCALL_DEFINE1(userfaultfd, int, flags)
diff --git a/lib/Kconfig b/lib/Kconfig
index 298b41298e487..3321d04dfa5a5 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -468,7 +468,6 @@ config CHECK_SIGNATURE
 
 config CPUMASK_OFFSTACK
 	bool "Force CPU masks off stack" if DEBUG_PER_CPU_MAPS
-	depends on !PREEMPT_RT
 	help
 	  Use dynamic allocation for cpumask_var_t, instead of putting
 	  them on the stack.  This is a bit more expensive, but avoids
diff --git a/localversion-rt b/localversion-rt
index c3054d08a1129..1445cd65885cd 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt2
+-rt3
diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 8b0b998cb5266..3a4259eeb5a0e 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -13,7 +13,7 @@
  *
  * The following locks and mutexes are used by kmemleak:
  *
- * - kmemleak_lock (raw spinlock): protects the object_list modifications and
+ * - kmemleak_lock (raw_spinlock_t): protects the object_list modifications and
  *   accesses to the object_tree_root. The object_list is the main list
  *   holding the metadata (struct kmemleak_object) for the allocated memory
  *   blocks. The object_tree_root is a red black tree used to look-up
@@ -22,13 +22,13 @@
  *   object_tree_root in the create_object() function called from the
  *   kmemleak_alloc() callback and removed in delete_object() called from the
  *   kmemleak_free() callback
- * - kmemleak_object.lock (spinlock): protects a kmemleak_object. Accesses to
- *   the metadata (e.g. count) are protected by this lock. Note that some
- *   members of this structure may be protected by other means (atomic or
- *   kmemleak_lock). This lock is also held when scanning the corresponding
- *   memory block to avoid the kernel freeing it via the kmemleak_free()
- *   callback. This is less heavyweight than holding a global lock like
- *   kmemleak_lock during scanning
+ * - kmemleak_object.lock (raw_spinlock_t): protects a kmemleak_object.
+ *   Accesses to the metadata (e.g. count) are protected by this lock. Note
+ *   that some members of this structure may be protected by other means
+ *   (atomic or kmemleak_lock). This lock is also held when scanning the
+ *   corresponding memory block to avoid the kernel freeing it via the
+ *   kmemleak_free() callback. This is less heavyweight than holding a global
+ *   lock like kmemleak_lock during scanning.
  * - scan_mutex (mutex): ensures that only one thread may scan the memory for
  *   unreferenced objects at a time. The gray_list contains the objects which
  *   are already referenced or marked as false positives and need to be
@@ -191,7 +191,7 @@ static int mem_pool_free_count = ARRAY_SIZE(mem_pool);
 static LIST_HEAD(mem_pool_free_list);
 /* search tree for object boundaries */
 static struct rb_root object_tree_root = RB_ROOT;
-/* rw_lock protecting the access to object_list and object_tree_root */
+/* protecting the access to object_list and object_tree_root */
 static DEFINE_RAW_SPINLOCK(kmemleak_lock);
 
 /* allocation caches for kmemleak internal data */
