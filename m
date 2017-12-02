From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [ANNOUNCE] v4.14.3-rt5
Date: Sat, 2 Dec 2017 22:12:34 +0100
Message-ID: <20171202211234.GA450@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:55010 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751941AbdLBVMh (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 2 Dec 2017 16:12:37 -0500
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Dear RT folks!

I'm pleased to announce the v4.14.3-rt5 patch set. 

Changes since v4.14.3-rt4:

  - More FPU loop unbreaks (enable/disable) in the SSE/AVX accelerate
    functions on x86.

  - Disabling NEON in kernel mode on ARM/ARM64. This is only avoid
    unbreaking the loops in NEON code as it has been on x86.

  - Added a spinlock to the mcrypd driver which is used for locking
    instead a preempt_disable section.

  - A change in goldfish tty driver make allmodconfig build again.

  - A different fix for the opencoded spinlock init in i915 driver.

Known issues
	An UP System compiled with SMP support may crash while the
	scheduler is looking for a RT task. A workaround is to compile
	an UP kernel for single CPU system. Reported by Daniel Wagner.

The delta patch against v4.14.3-rt4 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.14/incr/patch-4.14.3-rt4-rt5.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.14.3-rt5

The RT patch against v4.14.3 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.14/older/patch-4.14.3-rt5.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.14/older/patches-4.14.3-rt5.tar.xz

Sebastian
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a817cb14dcb5..558b0995e94a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -2165,7 +2165,7 @@ config NEON
 
 config KERNEL_MODE_NEON
 	bool "Support for NEON in kernel mode"
-	depends on NEON && AEABI
+	depends on NEON && AEABI && !PREEMPT_RT_BASE
 	help
 	  Say Y to include support for NEON in kernel mode.
 
diff --git a/arch/arm64/crypto/Kconfig b/arch/arm64/crypto/Kconfig
index 70c517aa4501..2a5f05b5a19a 100644
--- a/arch/arm64/crypto/Kconfig
+++ b/arch/arm64/crypto/Kconfig
@@ -19,19 +19,19 @@ config CRYPTO_SHA512_ARM64
 
 config CRYPTO_SHA1_ARM64_CE
 	tristate "SHA-1 digest algorithm (ARMv8 Crypto Extensions)"
-	depends on KERNEL_MODE_NEON
+	depends on KERNEL_MODE_NEON && !PREEMPT_RT_BASE
 	select CRYPTO_HASH
 	select CRYPTO_SHA1
 
 config CRYPTO_SHA2_ARM64_CE
 	tristate "SHA-224/SHA-256 digest algorithm (ARMv8 Crypto Extensions)"
-	depends on KERNEL_MODE_NEON
+	depends on KERNEL_MODE_NEON && !PREEMPT_RT_BASE
 	select CRYPTO_HASH
 	select CRYPTO_SHA256_ARM64
 
 config CRYPTO_GHASH_ARM64_CE
 	tristate "GHASH/AES-GCM using ARMv8 Crypto Extensions"
-	depends on KERNEL_MODE_NEON
+	depends on KERNEL_MODE_NEON && !PREEMPT_RT_BASE
 	select CRYPTO_HASH
 	select CRYPTO_GF128MUL
 	select CRYPTO_AES
@@ -39,7 +39,7 @@ config CRYPTO_GHASH_ARM64_CE
 
 config CRYPTO_CRCT10DIF_ARM64_CE
 	tristate "CRCT10DIF digest algorithm using PMULL instructions"
-	depends on KERNEL_MODE_NEON && CRC_T10DIF
+	depends on KERNEL_MODE_NEON && CRC_T10DIF && !PREEMPT_RT_BASE
 	select CRYPTO_HASH
 
 config CRYPTO_CRC32_ARM64_CE
@@ -53,13 +53,13 @@ config CRYPTO_AES_ARM64
 
 config CRYPTO_AES_ARM64_CE
 	tristate "AES core cipher using ARMv8 Crypto Extensions"
-	depends on ARM64 && KERNEL_MODE_NEON
+	depends on ARM64 && KERNEL_MODE_NEON && !PREEMPT_RT_BASE
 	select CRYPTO_ALGAPI
 	select CRYPTO_AES_ARM64
 
 config CRYPTO_AES_ARM64_CE_CCM
 	tristate "AES in CCM mode using ARMv8 Crypto Extensions"
-	depends on ARM64 && KERNEL_MODE_NEON
+	depends on ARM64 && KERNEL_MODE_NEON && !PREEMPT_RT_BASE
 	select CRYPTO_ALGAPI
 	select CRYPTO_AES_ARM64_CE
 	select CRYPTO_AES_ARM64
@@ -67,7 +67,7 @@ config CRYPTO_AES_ARM64_CE_CCM
 
 config CRYPTO_AES_ARM64_CE_BLK
 	tristate "AES in ECB/CBC/CTR/XTS modes using ARMv8 Crypto Extensions"
-	depends on KERNEL_MODE_NEON
+	depends on KERNEL_MODE_NEON && !PREEMPT_RT_BASE
 	select CRYPTO_BLKCIPHER
 	select CRYPTO_AES_ARM64_CE
 	select CRYPTO_AES_ARM64
@@ -75,7 +75,7 @@ config CRYPTO_AES_ARM64_CE_BLK
 
 config CRYPTO_AES_ARM64_NEON_BLK
 	tristate "AES in ECB/CBC/CTR/XTS modes using NEON instructions"
-	depends on KERNEL_MODE_NEON
+	depends on KERNEL_MODE_NEON && !PREEMPT_RT_BASE
 	select CRYPTO_BLKCIPHER
 	select CRYPTO_AES_ARM64
 	select CRYPTO_AES
@@ -83,13 +83,13 @@ config CRYPTO_AES_ARM64_NEON_BLK
 
 config CRYPTO_CHACHA20_NEON
 	tristate "NEON accelerated ChaCha20 symmetric cipher"
-	depends on KERNEL_MODE_NEON
+	depends on KERNEL_MODE_NEON && !PREEMPT_RT_BASE
 	select CRYPTO_BLKCIPHER
 	select CRYPTO_CHACHA20
 
 config CRYPTO_AES_ARM64_BS
 	tristate "AES in ECB/CBC/CTR/XTS modes using bit-sliced NEON algorithm"
-	depends on KERNEL_MODE_NEON
+	depends on KERNEL_MODE_NEON && !PREEMPT_RT_BASE
 	select CRYPTO_BLKCIPHER
 	select CRYPTO_AES_ARM64_NEON_BLK
 	select CRYPTO_AES_ARM64
diff --git a/arch/arm64/crypto/crc32-ce-glue.c b/arch/arm64/crypto/crc32-ce-glue.c
index 624f4137918c..599de95cd86d 100644
--- a/arch/arm64/crypto/crc32-ce-glue.c
+++ b/arch/arm64/crypto/crc32-ce-glue.c
@@ -206,7 +206,8 @@ static struct shash_alg crc32_pmull_algs[] = { {
 
 static int __init crc32_pmull_mod_init(void)
 {
-	if (IS_ENABLED(CONFIG_KERNEL_MODE_NEON) && (elf_hwcap & HWCAP_PMULL)) {
+	if (IS_ENABLED(CONFIG_KERNEL_MODE_NEON) &&
+	    !IS_ENABLED(CONFIG_PREEMPT_RT_BASE) && (elf_hwcap & HWCAP_PMULL)) {
 		crc32_pmull_algs[0].update = crc32_pmull_update;
 		crc32_pmull_algs[1].update = crc32c_pmull_update;
 
diff --git a/arch/x86/crypto/camellia_aesni_avx2_glue.c b/arch/x86/crypto/camellia_aesni_avx2_glue.c
index 60907c139c4e..0902db7d326a 100644
--- a/arch/x86/crypto/camellia_aesni_avx2_glue.c
+++ b/arch/x86/crypto/camellia_aesni_avx2_glue.c
@@ -206,6 +206,20 @@ struct crypt_priv {
 	bool fpu_enabled;
 };
 
+#ifdef CONFIG_PREEMPT_RT_FULL
+static void camellia_fpu_end_rt(struct crypt_priv *ctx)
+{
+       bool fpu_enabled = ctx->fpu_enabled;
+
+       if (!fpu_enabled)
+               return;
+       camellia_fpu_end(fpu_enabled);
+       ctx->fpu_enabled = false;
+}
+#else
+static void camellia_fpu_end_rt(struct crypt_priv *ctx) { }
+#endif
+
 static void encrypt_callback(void *priv, u8 *srcdst, unsigned int nbytes)
 {
 	const unsigned int bsize = CAMELLIA_BLOCK_SIZE;
@@ -221,16 +235,19 @@ static void encrypt_callback(void *priv, u8 *srcdst, unsigned int nbytes)
 	}
 
 	if (nbytes >= CAMELLIA_AESNI_PARALLEL_BLOCKS * bsize) {
+		kernel_fpu_resched();
 		camellia_ecb_enc_16way(ctx->ctx, srcdst, srcdst);
 		srcdst += bsize * CAMELLIA_AESNI_PARALLEL_BLOCKS;
 		nbytes -= bsize * CAMELLIA_AESNI_PARALLEL_BLOCKS;
 	}
 
 	while (nbytes >= CAMELLIA_PARALLEL_BLOCKS * bsize) {
+		kernel_fpu_resched();
 		camellia_enc_blk_2way(ctx->ctx, srcdst, srcdst);
 		srcdst += bsize * CAMELLIA_PARALLEL_BLOCKS;
 		nbytes -= bsize * CAMELLIA_PARALLEL_BLOCKS;
 	}
+	camellia_fpu_end_rt(ctx);
 
 	for (i = 0; i < nbytes / bsize; i++, srcdst += bsize)
 		camellia_enc_blk(ctx->ctx, srcdst, srcdst);
@@ -251,16 +268,19 @@ static void decrypt_callback(void *priv, u8 *srcdst, unsigned int nbytes)
 	}
 
 	if (nbytes >= CAMELLIA_AESNI_PARALLEL_BLOCKS * bsize) {
+		kernel_fpu_resched();
 		camellia_ecb_dec_16way(ctx->ctx, srcdst, srcdst);
 		srcdst += bsize * CAMELLIA_AESNI_PARALLEL_BLOCKS;
 		nbytes -= bsize * CAMELLIA_AESNI_PARALLEL_BLOCKS;
 	}
 
 	while (nbytes >= CAMELLIA_PARALLEL_BLOCKS * bsize) {
+		kernel_fpu_resched();
 		camellia_dec_blk_2way(ctx->ctx, srcdst, srcdst);
 		srcdst += bsize * CAMELLIA_PARALLEL_BLOCKS;
 		nbytes -= bsize * CAMELLIA_PARALLEL_BLOCKS;
 	}
+	camellia_fpu_end_rt(ctx);
 
 	for (i = 0; i < nbytes / bsize; i++, srcdst += bsize)
 		camellia_dec_blk(ctx->ctx, srcdst, srcdst);
diff --git a/arch/x86/crypto/camellia_aesni_avx_glue.c b/arch/x86/crypto/camellia_aesni_avx_glue.c
index d96429da88eb..3b8e91841039 100644
--- a/arch/x86/crypto/camellia_aesni_avx_glue.c
+++ b/arch/x86/crypto/camellia_aesni_avx_glue.c
@@ -210,6 +210,21 @@ struct crypt_priv {
 	bool fpu_enabled;
 };
 
+#ifdef CONFIG_PREEMPT_RT_FULL
+static void camellia_fpu_end_rt(struct crypt_priv *ctx)
+{
+	bool fpu_enabled = ctx->fpu_enabled;
+
+	if (!fpu_enabled)
+		return;
+	camellia_fpu_end(fpu_enabled);
+	ctx->fpu_enabled = false;
+}
+
+#else
+static void camellia_fpu_end_rt(struct crypt_priv *ctx) { }
+#endif
+
 static void encrypt_callback(void *priv, u8 *srcdst, unsigned int nbytes)
 {
 	const unsigned int bsize = CAMELLIA_BLOCK_SIZE;
@@ -225,10 +240,12 @@ static void encrypt_callback(void *priv, u8 *srcdst, unsigned int nbytes)
 	}
 
 	while (nbytes >= CAMELLIA_PARALLEL_BLOCKS * bsize) {
+		kernel_fpu_resched();
 		camellia_enc_blk_2way(ctx->ctx, srcdst, srcdst);
 		srcdst += bsize * CAMELLIA_PARALLEL_BLOCKS;
 		nbytes -= bsize * CAMELLIA_PARALLEL_BLOCKS;
 	}
+	camellia_fpu_end_rt(ctx);
 
 	for (i = 0; i < nbytes / bsize; i++, srcdst += bsize)
 		camellia_enc_blk(ctx->ctx, srcdst, srcdst);
@@ -249,10 +266,12 @@ static void decrypt_callback(void *priv, u8 *srcdst, unsigned int nbytes)
 	}
 
 	while (nbytes >= CAMELLIA_PARALLEL_BLOCKS * bsize) {
+		kernel_fpu_resched();
 		camellia_dec_blk_2way(ctx->ctx, srcdst, srcdst);
 		srcdst += bsize * CAMELLIA_PARALLEL_BLOCKS;
 		nbytes -= bsize * CAMELLIA_PARALLEL_BLOCKS;
 	}
+	camellia_fpu_end_rt(ctx);
 
 	for (i = 0; i < nbytes / bsize; i++, srcdst += bsize)
 		camellia_dec_blk(ctx->ctx, srcdst, srcdst);
diff --git a/arch/x86/crypto/cast6_avx_glue.c b/arch/x86/crypto/cast6_avx_glue.c
index 50e684768c55..8caf9ba8c1da 100644
--- a/arch/x86/crypto/cast6_avx_glue.c
+++ b/arch/x86/crypto/cast6_avx_glue.c
@@ -205,19 +205,33 @@ struct crypt_priv {
 	bool fpu_enabled;
 };
 
+#ifdef CONFIG_PREEMPT_RT_FULL
+static void cast6_fpu_end_rt(struct crypt_priv *ctx)
+{
+	bool fpu_enabled = ctx->fpu_enabled;
+
+	if (!fpu_enabled)
+		return;
+	cast6_fpu_end(fpu_enabled);
+	ctx->fpu_enabled = false;
+}
+
+#else
+static void cast6_fpu_end_rt(struct crypt_priv *ctx) { }
+#endif
+
 static void encrypt_callback(void *priv, u8 *srcdst, unsigned int nbytes)
 {
 	const unsigned int bsize = CAST6_BLOCK_SIZE;
 	struct crypt_priv *ctx = priv;
 	int i;
 
-	ctx->fpu_enabled = cast6_fpu_begin(ctx->fpu_enabled, nbytes);
-
 	if (nbytes == bsize * CAST6_PARALLEL_BLOCKS) {
+		ctx->fpu_enabled = cast6_fpu_begin(ctx->fpu_enabled, nbytes);
 		cast6_ecb_enc_8way(ctx->ctx, srcdst, srcdst);
+		cast6_fpu_end_rt(ctx);
 		return;
 	}
-
 	for (i = 0; i < nbytes / bsize; i++, srcdst += bsize)
 		__cast6_encrypt(ctx->ctx, srcdst, srcdst);
 }
@@ -228,10 +242,10 @@ static void decrypt_callback(void *priv, u8 *srcdst, unsigned int nbytes)
 	struct crypt_priv *ctx = priv;
 	int i;
 
-	ctx->fpu_enabled = cast6_fpu_begin(ctx->fpu_enabled, nbytes);
-
 	if (nbytes == bsize * CAST6_PARALLEL_BLOCKS) {
+		ctx->fpu_enabled = cast6_fpu_begin(ctx->fpu_enabled, nbytes);
 		cast6_ecb_dec_8way(ctx->ctx, srcdst, srcdst);
+		cast6_fpu_end_rt(ctx);
 		return;
 	}
 
diff --git a/arch/x86/crypto/chacha20_glue.c b/arch/x86/crypto/chacha20_glue.c
index 1e6af1b35f7b..e7809fd2a4fd 100644
--- a/arch/x86/crypto/chacha20_glue.c
+++ b/arch/x86/crypto/chacha20_glue.c
@@ -81,23 +81,24 @@ static int chacha20_simd(struct skcipher_request *req)
 
 	crypto_chacha20_init(state, ctx, walk.iv);
 
-	kernel_fpu_begin();
-
 	while (walk.nbytes >= CHACHA20_BLOCK_SIZE) {
+		kernel_fpu_begin();
+
 		chacha20_dosimd(state, walk.dst.virt.addr, walk.src.virt.addr,
 				rounddown(walk.nbytes, CHACHA20_BLOCK_SIZE));
+		kernel_fpu_end();
 		err = skcipher_walk_done(&walk,
 					 walk.nbytes % CHACHA20_BLOCK_SIZE);
 	}
 
 	if (walk.nbytes) {
+		kernel_fpu_begin();
 		chacha20_dosimd(state, walk.dst.virt.addr, walk.src.virt.addr,
 				walk.nbytes);
+		kernel_fpu_end();
 		err = skcipher_walk_done(&walk, 0);
 	}
 
-	kernel_fpu_end();
-
 	return err;
 }
 
diff --git a/arch/x86/crypto/serpent_avx2_glue.c b/arch/x86/crypto/serpent_avx2_glue.c
index 870f6d812a2d..5c806bf39f1d 100644
--- a/arch/x86/crypto/serpent_avx2_glue.c
+++ b/arch/x86/crypto/serpent_avx2_glue.c
@@ -184,6 +184,21 @@ struct crypt_priv {
 	bool fpu_enabled;
 };
 
+#ifdef CONFIG_PREEMPT_RT_FULL
+static void serpent_fpu_end_rt(struct crypt_priv *ctx)
+{
+       bool fpu_enabled = ctx->fpu_enabled;
+
+       if (!fpu_enabled)
+               return;
+       serpent_fpu_end(fpu_enabled);
+       ctx->fpu_enabled = false;
+}
+
+#else
+static void serpent_fpu_end_rt(struct crypt_priv *ctx) { }
+#endif
+
 static void encrypt_callback(void *priv, u8 *srcdst, unsigned int nbytes)
 {
 	const unsigned int bsize = SERPENT_BLOCK_SIZE;
@@ -199,10 +214,12 @@ static void encrypt_callback(void *priv, u8 *srcdst, unsigned int nbytes)
 	}
 
 	while (nbytes >= SERPENT_PARALLEL_BLOCKS * bsize) {
+		kernel_fpu_resched();
 		serpent_ecb_enc_8way_avx(ctx->ctx, srcdst, srcdst);
 		srcdst += bsize * SERPENT_PARALLEL_BLOCKS;
 		nbytes -= bsize * SERPENT_PARALLEL_BLOCKS;
 	}
+	serpent_fpu_end_rt(ctx);
 
 	for (i = 0; i < nbytes / bsize; i++, srcdst += bsize)
 		__serpent_encrypt(ctx->ctx, srcdst, srcdst);
@@ -223,10 +240,12 @@ static void decrypt_callback(void *priv, u8 *srcdst, unsigned int nbytes)
 	}
 
 	while (nbytes >= SERPENT_PARALLEL_BLOCKS * bsize) {
+		kernel_fpu_resched();
 		serpent_ecb_dec_8way_avx(ctx->ctx, srcdst, srcdst);
 		srcdst += bsize * SERPENT_PARALLEL_BLOCKS;
 		nbytes -= bsize * SERPENT_PARALLEL_BLOCKS;
 	}
+	serpent_fpu_end_rt(ctx);
 
 	for (i = 0; i < nbytes / bsize; i++, srcdst += bsize)
 		__serpent_decrypt(ctx->ctx, srcdst, srcdst);
diff --git a/arch/x86/crypto/serpent_avx_glue.c b/arch/x86/crypto/serpent_avx_glue.c
index 6f778d3daa22..46dcbdbd0518 100644
--- a/arch/x86/crypto/serpent_avx_glue.c
+++ b/arch/x86/crypto/serpent_avx_glue.c
@@ -218,16 +218,31 @@ struct crypt_priv {
 	bool fpu_enabled;
 };
 
+#ifdef CONFIG_PREEMPT_RT_FULL
+static void serpent_fpu_end_rt(struct crypt_priv *ctx)
+{
+	bool fpu_enabled = ctx->fpu_enabled;
+
+	if (!fpu_enabled)
+		return;
+	serpent_fpu_end(fpu_enabled);
+	ctx->fpu_enabled = false;
+}
+
+#else
+static void serpent_fpu_end_rt(struct crypt_priv *ctx) { }
+#endif
+
 static void encrypt_callback(void *priv, u8 *srcdst, unsigned int nbytes)
 {
 	const unsigned int bsize = SERPENT_BLOCK_SIZE;
 	struct crypt_priv *ctx = priv;
 	int i;
 
-	ctx->fpu_enabled = serpent_fpu_begin(ctx->fpu_enabled, nbytes);
-
 	if (nbytes == bsize * SERPENT_PARALLEL_BLOCKS) {
+		ctx->fpu_enabled = serpent_fpu_begin(ctx->fpu_enabled, nbytes);
 		serpent_ecb_enc_8way_avx(ctx->ctx, srcdst, srcdst);
+		serpent_fpu_end_rt(ctx);
 		return;
 	}
 
@@ -241,10 +256,10 @@ static void decrypt_callback(void *priv, u8 *srcdst, unsigned int nbytes)
 	struct crypt_priv *ctx = priv;
 	int i;
 
-	ctx->fpu_enabled = serpent_fpu_begin(ctx->fpu_enabled, nbytes);
-
 	if (nbytes == bsize * SERPENT_PARALLEL_BLOCKS) {
+		ctx->fpu_enabled = serpent_fpu_begin(ctx->fpu_enabled, nbytes);
 		serpent_ecb_dec_8way_avx(ctx->ctx, srcdst, srcdst);
+		serpent_fpu_end_rt(ctx);
 		return;
 	}
 
diff --git a/arch/x86/crypto/serpent_sse2_glue.c b/arch/x86/crypto/serpent_sse2_glue.c
index ac0e831943f5..d35f607d067f 100644
--- a/arch/x86/crypto/serpent_sse2_glue.c
+++ b/arch/x86/crypto/serpent_sse2_glue.c
@@ -187,16 +187,31 @@ struct crypt_priv {
 	bool fpu_enabled;
 };
 
+#ifdef CONFIG_PREEMPT_RT_FULL
+static void serpent_fpu_end_rt(struct crypt_priv *ctx)
+{
+	bool fpu_enabled = ctx->fpu_enabled;
+
+	if (!fpu_enabled)
+		return;
+	serpent_fpu_end(fpu_enabled);
+	ctx->fpu_enabled = false;
+}
+
+#else
+static void serpent_fpu_end_rt(struct crypt_priv *ctx) { }
+#endif
+
 static void encrypt_callback(void *priv, u8 *srcdst, unsigned int nbytes)
 {
 	const unsigned int bsize = SERPENT_BLOCK_SIZE;
 	struct crypt_priv *ctx = priv;
 	int i;
 
-	ctx->fpu_enabled = serpent_fpu_begin(ctx->fpu_enabled, nbytes);
-
 	if (nbytes == bsize * SERPENT_PARALLEL_BLOCKS) {
+		ctx->fpu_enabled = serpent_fpu_begin(ctx->fpu_enabled, nbytes);
 		serpent_enc_blk_xway(ctx->ctx, srcdst, srcdst);
+		serpent_fpu_end_rt(ctx);
 		return;
 	}
 
@@ -210,10 +225,10 @@ static void decrypt_callback(void *priv, u8 *srcdst, unsigned int nbytes)
 	struct crypt_priv *ctx = priv;
 	int i;
 
-	ctx->fpu_enabled = serpent_fpu_begin(ctx->fpu_enabled, nbytes);
-
 	if (nbytes == bsize * SERPENT_PARALLEL_BLOCKS) {
+		ctx->fpu_enabled = serpent_fpu_begin(ctx->fpu_enabled, nbytes);
 		serpent_dec_blk_xway(ctx->ctx, srcdst, srcdst);
+		serpent_fpu_end_rt(ctx);
 		return;
 	}
 
diff --git a/arch/x86/crypto/twofish_avx_glue.c b/arch/x86/crypto/twofish_avx_glue.c
index b7a3904b953c..de00fe24927e 100644
--- a/arch/x86/crypto/twofish_avx_glue.c
+++ b/arch/x86/crypto/twofish_avx_glue.c
@@ -218,6 +218,21 @@ struct crypt_priv {
 	bool fpu_enabled;
 };
 
+#ifdef CONFIG_PREEMPT_RT_FULL
+static void twofish_fpu_end_rt(struct crypt_priv *ctx)
+{
+	bool fpu_enabled = ctx->fpu_enabled;
+
+	if (!fpu_enabled)
+		return;
+	twofish_fpu_end(fpu_enabled);
+	ctx->fpu_enabled = false;
+}
+
+#else
+static void twofish_fpu_end_rt(struct crypt_priv *ctx) { }
+#endif
+
 static void encrypt_callback(void *priv, u8 *srcdst, unsigned int nbytes)
 {
 	const unsigned int bsize = TF_BLOCK_SIZE;
@@ -228,12 +243,16 @@ static void encrypt_callback(void *priv, u8 *srcdst, unsigned int nbytes)
 
 	if (nbytes == bsize * TWOFISH_PARALLEL_BLOCKS) {
 		twofish_ecb_enc_8way(ctx->ctx, srcdst, srcdst);
+		twofish_fpu_end_rt(ctx);
 		return;
 	}
 
-	for (i = 0; i < nbytes / (bsize * 3); i++, srcdst += bsize * 3)
+	for (i = 0; i < nbytes / (bsize * 3); i++, srcdst += bsize * 3) {
+		kernel_fpu_resched();
 		twofish_enc_blk_3way(ctx->ctx, srcdst, srcdst);
+	}
 
+	twofish_fpu_end_rt(ctx);
 	nbytes %= bsize * 3;
 
 	for (i = 0; i < nbytes / bsize; i++, srcdst += bsize)
@@ -250,11 +269,15 @@ static void decrypt_callback(void *priv, u8 *srcdst, unsigned int nbytes)
 
 	if (nbytes == bsize * TWOFISH_PARALLEL_BLOCKS) {
 		twofish_ecb_dec_8way(ctx->ctx, srcdst, srcdst);
+		twofish_fpu_end_rt(ctx);
 		return;
 	}
 
-	for (i = 0; i < nbytes / (bsize * 3); i++, srcdst += bsize * 3)
+	for (i = 0; i < nbytes / (bsize * 3); i++, srcdst += bsize * 3) {
+		kernel_fpu_resched();
 		twofish_dec_blk_3way(ctx->ctx, srcdst, srcdst);
+	}
+	twofish_fpu_end_rt(ctx);
 
 	nbytes %= bsize * 3;
 
diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
index a9caac9d4a72..18b31f22ca5d 100644
--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -25,6 +25,7 @@ extern void __kernel_fpu_begin(void);
 extern void __kernel_fpu_end(void);
 extern void kernel_fpu_begin(void);
 extern void kernel_fpu_end(void);
+extern void kernel_fpu_resched(void);
 extern bool irq_fpu_usable(void);
 
 /*
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index f92a6593de1e..7128beaf594c 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -137,6 +137,18 @@ void kernel_fpu_end(void)
 }
 EXPORT_SYMBOL_GPL(kernel_fpu_end);
 
+void kernel_fpu_resched(void)
+{
+	WARN_ON_FPU(!this_cpu_read(in_kernel_fpu));
+
+	if (should_resched(PREEMPT_OFFSET)) {
+		kernel_fpu_end();
+		cond_resched();
+		kernel_fpu_begin();
+	}
+}
+EXPORT_SYMBOL_GPL(kernel_fpu_resched);
+
 /*
  * Save the FPU state (mark it for reload if necessary):
  *
diff --git a/crypto/mcryptd.c b/crypto/mcryptd.c
index 4e6472658852..eca04d3729b3 100644
--- a/crypto/mcryptd.c
+++ b/crypto/mcryptd.c
@@ -81,6 +81,7 @@ static int mcryptd_init_queue(struct mcryptd_queue *queue,
 		pr_debug("cpu_queue #%d %p\n", cpu, queue->cpu_queue);
 		crypto_init_queue(&cpu_queue->queue, max_cpu_qlen);
 		INIT_WORK(&cpu_queue->work, mcryptd_queue_worker);
+		spin_lock_init(&cpu_queue->q_lock);
 	}
 	return 0;
 }
@@ -104,15 +105,16 @@ static int mcryptd_enqueue_request(struct mcryptd_queue *queue,
 	int cpu, err;
 	struct mcryptd_cpu_queue *cpu_queue;
 
-	cpu = get_cpu();
-	cpu_queue = this_cpu_ptr(queue->cpu_queue);
-	rctx->tag.cpu = cpu;
+	cpu_queue = raw_cpu_ptr(queue->cpu_queue);
+	spin_lock(&cpu_queue->q_lock);
+	cpu = smp_processor_id();
+	rctx->tag.cpu = smp_processor_id();
 
 	err = crypto_enqueue_request(&cpu_queue->queue, request);
 	pr_debug("enqueue request: cpu %d cpu_queue %p request %p\n",
 		 cpu, cpu_queue, request);
+	spin_unlock(&cpu_queue->q_lock);
 	queue_work_on(cpu, kcrypto_wq, &cpu_queue->work);
-	put_cpu();
 
 	return err;
 }
@@ -161,16 +163,11 @@ static void mcryptd_queue_worker(struct work_struct *work)
 	cpu_queue = container_of(work, struct mcryptd_cpu_queue, work);
 	i = 0;
 	while (i < MCRYPTD_BATCH || single_task_running()) {
-		/*
-		 * preempt_disable/enable is used to prevent
-		 * being preempted by mcryptd_enqueue_request()
-		 */
-		local_bh_disable();
-		preempt_disable();
+
+		spin_lock_bh(&cpu_queue->q_lock);
 		backlog = crypto_get_backlog(&cpu_queue->queue);
 		req = crypto_dequeue_request(&cpu_queue->queue);
-		preempt_enable();
-		local_bh_enable();
+		spin_unlock_bh(&cpu_queue->q_lock);
 
 		if (!req) {
 			mcryptd_opportunistic_flush();
@@ -185,7 +182,7 @@ static void mcryptd_queue_worker(struct work_struct *work)
 		++i;
 	}
 	if (cpu_queue->queue.qlen)
-		queue_work(kcrypto_wq, &cpu_queue->work);
+		queue_work_on(smp_processor_id(), kcrypto_wq, &cpu_queue->work);
 }
 
 void mcryptd_flusher(struct work_struct *__work)
diff --git a/drivers/gpu/drm/i915/i915_gem_timeline.c b/drivers/gpu/drm/i915/i915_gem_timeline.c
index ef91ff6dc330..c1108d3921f8 100644
--- a/drivers/gpu/drm/i915/i915_gem_timeline.c
+++ b/drivers/gpu/drm/i915/i915_gem_timeline.c
@@ -33,16 +33,8 @@ static void __intel_timeline_init(struct intel_timeline *tl,
 {
 	tl->fence_context = context;
 	tl->common = parent;
-#ifdef CONFIG_DEBUG_SPINLOCK
-# ifdef CONFIG_PREEMPT_RT_FULL
-	rt_mutex_init(&tl->lock.lock);
-	__rt_spin_lock_init(&tl->lock, lockname, lockclass);
-# else
-	__raw_spin_lock_init(&tl->lock.rlock, lockname, lockclass);
-# endif
-#else
 	spin_lock_init(&tl->lock);
-#endif
+	lockdep_set_class_and_name(&tl->lock, lockclass, lockname);
 	init_request_active(&tl->last_request, NULL);
 	INIT_LIST_HEAD(&tl->requests);
 	i915_syncmap_init(&tl->sync);
diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
index cc2b4d9433ed..b811442c5ce6 100644
--- a/drivers/tty/Kconfig
+++ b/drivers/tty/Kconfig
@@ -394,10 +394,14 @@ config GOLDFISH_TTY
 	depends on GOLDFISH
 	select SERIAL_CORE
 	select SERIAL_CORE_CONSOLE
-	select SERIAL_EARLYCON
 	help
 	  Console and system TTY driver for the Goldfish virtual platform.
 
+config GOLDFISH_TTY_EARLY_CONSOLE
+	bool
+	default y if GOLDFISH_TTY=y
+	select SERIAL_EARLYCON
+
 config DA_TTY
 	bool "DA TTY"
 	depends on METAG_DA
diff --git a/drivers/tty/goldfish.c b/drivers/tty/goldfish.c
index 381e981dee06..85a500ddbcaa 100644
--- a/drivers/tty/goldfish.c
+++ b/drivers/tty/goldfish.c
@@ -442,6 +442,7 @@ static int goldfish_tty_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_GOLDFISH_TTY_EARLY_CONSOLE
 static void gf_early_console_putchar(struct uart_port *port, int ch)
 {
 	__raw_writel(ch, port->membase);
@@ -465,6 +466,7 @@ static int __init gf_earlycon_setup(struct earlycon_device *device,
 }
 
 OF_EARLYCON_DECLARE(early_gf_tty, "google,goldfish-tty", gf_earlycon_setup);
+#endif
 
 static const struct of_device_id goldfish_tty_of_match[] = {
 	{ .compatible = "google,goldfish-tty", },
diff --git a/include/crypto/mcryptd.h b/include/crypto/mcryptd.h
index cceafa01f907..b67404fc4b34 100644
--- a/include/crypto/mcryptd.h
+++ b/include/crypto/mcryptd.h
@@ -27,6 +27,7 @@ static inline struct mcryptd_ahash *__mcryptd_ahash_cast(
 
 struct mcryptd_cpu_queue {
 	struct crypto_queue queue;
+	spinlock_t q_lock;
 	struct work_struct work;
 };
 
diff --git a/localversion-rt b/localversion-rt
index ad3da1bcab7e..0efe7ba1930e 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt4
+-rt5
