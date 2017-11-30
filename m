From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH RT] crypto: limit more FPU-enabled sections
Date: Thu, 30 Nov 2017 15:22:17 +0100
Message-ID: <20171130142216.GB12606@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Those crypto drivers use SSE/AVX/… for their crypto work and in order to
do so in kernel they need to enable the "FPU" in kernel mode which
disables preemption.
There are two problems with the way they are used:
- the while loop which processes X bytes may create latency spikes and
  should be avoided or limited.
- the cipher-walk-next part may allocate/free memory and may use
  kmap_atomic().

The whole kernel_fpu_begin()/end() processing isn't probably that cheap.
It most likely makes sense to prcess as much of those as possible in one
go. The new *_fpu_sched_rt() shedules only if a RT task is pending.

Probably we should meassure the performance those ciphers in pure SW
mode and with this optimisations to see if it makes sense to keep them
for RT.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/crypto/camellia_aesni_avx2_glue.c | 32 ++++++++++++++++++++++++++
 arch/x86/crypto/camellia_aesni_avx_glue.c  | 30 ++++++++++++++++++++++++
 arch/x86/crypto/cast6_avx_glue.c           | 21 +++++++++++++----
 arch/x86/crypto/chacha20_glue.c            |  9 ++++----
 arch/x86/crypto/serpent_avx2_glue.c        | 29 +++++++++++++++++++++++
 arch/x86/crypto/serpent_avx_glue.c         | 20 ++++++++++++----
 arch/x86/crypto/serpent_sse2_glue.c        | 20 ++++++++++++----
 arch/x86/crypto/twofish_avx_glue.c         | 37 ++++++++++++++++++++++++++++--
 8 files changed, 179 insertions(+), 19 deletions(-)

diff --git a/arch/x86/crypto/camellia_aesni_avx2_glue.c b/arch/x86/crypto/camellia_aesni_avx2_glue.c
index 60907c139c4e..d7502c023475 100644
--- a/arch/x86/crypto/camellia_aesni_avx2_glue.c
+++ b/arch/x86/crypto/camellia_aesni_avx2_glue.c
@@ -206,6 +206,32 @@ struct crypt_priv {
 	bool fpu_enabled;
 };
 
+static void camellia_fpu_end_rt(struct crypt_priv *ctx)
+{
+#if CONFIG_PREEMPT_RT_FULL
+       bool fpu_enabled = ctx->fpu_enabled;
+
+       if (!fpu_enabled)
+               return;
+       camellia_fpu_end(fpu_enabled);
+       ctx->fpu_enabled = false;
+#endif
+}
+
+static void camellia_fpu_sched_rt(struct crypt_priv *ctx)
+{
+#if CONFIG_PREEMPT_RT_FULL
+       bool fpu_enabled = ctx->fpu_enabled;
+
+       if (!fpu_enabled || !tif_need_resched_now())
+               return;
+       camellia_fpu_end(fpu_enabled);
+       kernel_fpu_end();
+       /* schedule due to preemptible */
+       kernel_fpu_begin();
+#endif
+}
+
 static void encrypt_callback(void *priv, u8 *srcdst, unsigned int nbytes)
 {
 	const unsigned int bsize = CAMELLIA_BLOCK_SIZE;
@@ -221,16 +247,19 @@ static void encrypt_callback(void *priv, u8 *srcdst, unsigned int nbytes)
 	}
 
 	if (nbytes >= CAMELLIA_AESNI_PARALLEL_BLOCKS * bsize) {
+		camellia_fpu_sched_rt(ctx);
 		camellia_ecb_enc_16way(ctx->ctx, srcdst, srcdst);
 		srcdst += bsize * CAMELLIA_AESNI_PARALLEL_BLOCKS;
 		nbytes -= bsize * CAMELLIA_AESNI_PARALLEL_BLOCKS;
 	}
 
 	while (nbytes >= CAMELLIA_PARALLEL_BLOCKS * bsize) {
+		camellia_fpu_sched_rt(ctx);
 		camellia_enc_blk_2way(ctx->ctx, srcdst, srcdst);
 		srcdst += bsize * CAMELLIA_PARALLEL_BLOCKS;
 		nbytes -= bsize * CAMELLIA_PARALLEL_BLOCKS;
 	}
+	camellia_fpu_end_rt(ctx);
 
 	for (i = 0; i < nbytes / bsize; i++, srcdst += bsize)
 		camellia_enc_blk(ctx->ctx, srcdst, srcdst);
@@ -251,16 +280,19 @@ static void decrypt_callback(void *priv, u8 *srcdst, unsigned int nbytes)
 	}
 
 	if (nbytes >= CAMELLIA_AESNI_PARALLEL_BLOCKS * bsize) {
+		camellia_fpu_sched_rt(ctx);
 		camellia_ecb_dec_16way(ctx->ctx, srcdst, srcdst);
 		srcdst += bsize * CAMELLIA_AESNI_PARALLEL_BLOCKS;
 		nbytes -= bsize * CAMELLIA_AESNI_PARALLEL_BLOCKS;
 	}
 
 	while (nbytes >= CAMELLIA_PARALLEL_BLOCKS * bsize) {
+		camellia_fpu_sched_rt(ctx);
 		camellia_dec_blk_2way(ctx->ctx, srcdst, srcdst);
 		srcdst += bsize * CAMELLIA_PARALLEL_BLOCKS;
 		nbytes -= bsize * CAMELLIA_PARALLEL_BLOCKS;
 	}
+	camellia_fpu_end_rt(ctx);
 
 	for (i = 0; i < nbytes / bsize; i++, srcdst += bsize)
 		camellia_dec_blk(ctx->ctx, srcdst, srcdst);
diff --git a/arch/x86/crypto/camellia_aesni_avx_glue.c b/arch/x86/crypto/camellia_aesni_avx_glue.c
index d96429da88eb..ea98b57a4156 100644
--- a/arch/x86/crypto/camellia_aesni_avx_glue.c
+++ b/arch/x86/crypto/camellia_aesni_avx_glue.c
@@ -210,6 +210,32 @@ struct crypt_priv {
 	bool fpu_enabled;
 };
 
+static void camellia_fpu_end_rt(struct crypt_priv *ctx)
+{
+#if CONFIG_PREEMPT_RT_FULL
+	bool fpu_enabled = ctx->fpu_enabled;
+
+	if (!fpu_enabled)
+		return;
+	camellia_fpu_end(fpu_enabled);
+	ctx->fpu_enabled = false;
+#endif
+}
+
+static void camellia_fpu_sched_rt(struct crypt_priv *ctx)
+{
+#if CONFIG_PREEMPT_RT_FULL
+	bool fpu_enabled = ctx->fpu_enabled;
+
+	if (!fpu_enabled || !tif_need_resched_now())
+		return;
+	camellia_fpu_end(fpu_enabled);
+	kernel_fpu_end();
+	/* schedule due to preemptible */
+	kernel_fpu_begin();
+#endif
+}
+
 static void encrypt_callback(void *priv, u8 *srcdst, unsigned int nbytes)
 {
 	const unsigned int bsize = CAMELLIA_BLOCK_SIZE;
@@ -225,10 +251,12 @@ static void encrypt_callback(void *priv, u8 *srcdst, unsigned int nbytes)
 	}
 
 	while (nbytes >= CAMELLIA_PARALLEL_BLOCKS * bsize) {
+		camellia_fpu_sched_rt(ctx);
 		camellia_enc_blk_2way(ctx->ctx, srcdst, srcdst);
 		srcdst += bsize * CAMELLIA_PARALLEL_BLOCKS;
 		nbytes -= bsize * CAMELLIA_PARALLEL_BLOCKS;
 	}
+	camellia_fpu_end_rt(ctx);
 
 	for (i = 0; i < nbytes / bsize; i++, srcdst += bsize)
 		camellia_enc_blk(ctx->ctx, srcdst, srcdst);
@@ -249,10 +277,12 @@ static void decrypt_callback(void *priv, u8 *srcdst, unsigned int nbytes)
 	}
 
 	while (nbytes >= CAMELLIA_PARALLEL_BLOCKS * bsize) {
+		camellia_fpu_sched_rt(ctx);
 		camellia_dec_blk_2way(ctx->ctx, srcdst, srcdst);
 		srcdst += bsize * CAMELLIA_PARALLEL_BLOCKS;
 		nbytes -= bsize * CAMELLIA_PARALLEL_BLOCKS;
 	}
+	camellia_fpu_end_rt(ctx);
 
 	for (i = 0; i < nbytes / bsize; i++, srcdst += bsize)
 		camellia_dec_blk(ctx->ctx, srcdst, srcdst);
diff --git a/arch/x86/crypto/cast6_avx_glue.c b/arch/x86/crypto/cast6_avx_glue.c
index 50e684768c55..b16497b81623 100644
--- a/arch/x86/crypto/cast6_avx_glue.c
+++ b/arch/x86/crypto/cast6_avx_glue.c
@@ -205,19 +205,30 @@ struct crypt_priv {
 	bool fpu_enabled;
 };
 
+static void cast6_fpu_end_rt(struct crypt_priv *ctx)
+{
+#if CONFIG_PREEMPT_RT_FULL
+	bool fpu_enabled = ctx->fpu_enabled;
+
+	if (!fpu_enabled)
+		return;
+	cast6_fpu_end(fpu_enabled);
+	ctx->fpu_enabled = false;
+#endif
+}
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
@@ -228,10 +239,10 @@ static void decrypt_callback(void *priv, u8 *srcdst, unsigned int nbytes)
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
index 870f6d812a2d..03a86747b97d 100644
--- a/arch/x86/crypto/serpent_avx2_glue.c
+++ b/arch/x86/crypto/serpent_avx2_glue.c
@@ -184,6 +184,31 @@ struct crypt_priv {
 	bool fpu_enabled;
 };
 
+static void serpent_fpu_end_rt(struct crypt_priv *ctx)
+{
+#if CONFIG_PREEMPT_RT_FULL
+       bool fpu_enabled = ctx->fpu_enabled;
+
+       if (!fpu_enabled)
+               return;
+       serpent_fpu_end(fpu_enabled);
+       ctx->fpu_enabled = false;
+#endif
+}
+
+static void serpent_fpu_sched_rt(struct crypt_priv *ctx)
+{
+#if CONFIG_PREEMPT_RT_FULL
+	bool fpu_enabled = ctx->fpu_enabled;
+
+	if (!fpu_enabled || !tif_need_resched_now())
+		return;
+	kernel_fpu_end();
+	/* schedule due to preemptible */
+	kernel_fpu_begin();
+#endif
+}
+
 static void encrypt_callback(void *priv, u8 *srcdst, unsigned int nbytes)
 {
 	const unsigned int bsize = SERPENT_BLOCK_SIZE;
@@ -199,10 +224,12 @@ static void encrypt_callback(void *priv, u8 *srcdst, unsigned int nbytes)
 	}
 
 	while (nbytes >= SERPENT_PARALLEL_BLOCKS * bsize) {
+		serpent_fpu_sched_rt(ctx);
 		serpent_ecb_enc_8way_avx(ctx->ctx, srcdst, srcdst);
 		srcdst += bsize * SERPENT_PARALLEL_BLOCKS;
 		nbytes -= bsize * SERPENT_PARALLEL_BLOCKS;
 	}
+	serpent_fpu_end_rt(ctx);
 
 	for (i = 0; i < nbytes / bsize; i++, srcdst += bsize)
 		__serpent_encrypt(ctx->ctx, srcdst, srcdst);
@@ -223,10 +250,12 @@ static void decrypt_callback(void *priv, u8 *srcdst, unsigned int nbytes)
 	}
 
 	while (nbytes >= SERPENT_PARALLEL_BLOCKS * bsize) {
+		serpent_fpu_sched_rt(ctx);
 		serpent_ecb_dec_8way_avx(ctx->ctx, srcdst, srcdst);
 		srcdst += bsize * SERPENT_PARALLEL_BLOCKS;
 		nbytes -= bsize * SERPENT_PARALLEL_BLOCKS;
 	}
+	serpent_fpu_end_rt(ctx);
 
 	for (i = 0; i < nbytes / bsize; i++, srcdst += bsize)
 		__serpent_decrypt(ctx->ctx, srcdst, srcdst);
diff --git a/arch/x86/crypto/serpent_avx_glue.c b/arch/x86/crypto/serpent_avx_glue.c
index 6f778d3daa22..3bf94fb39e47 100644
--- a/arch/x86/crypto/serpent_avx_glue.c
+++ b/arch/x86/crypto/serpent_avx_glue.c
@@ -218,16 +218,28 @@ struct crypt_priv {
 	bool fpu_enabled;
 };
 
+static void serpent_fpu_end_rt(struct crypt_priv *ctx)
+{
+#if CONFIG_PREEMPT_RT_FULL
+	bool fpu_enabled = ctx->fpu_enabled;
+
+	if (!fpu_enabled)
+		return;
+	serpent_fpu_end(fpu_enabled);
+	ctx->fpu_enabled = false;
+#endif
+}
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
 
@@ -241,10 +253,10 @@ static void decrypt_callback(void *priv, u8 *srcdst, unsigned int nbytes)
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
index ac0e831943f5..66fd2a51836f 100644
--- a/arch/x86/crypto/serpent_sse2_glue.c
+++ b/arch/x86/crypto/serpent_sse2_glue.c
@@ -187,16 +187,28 @@ struct crypt_priv {
 	bool fpu_enabled;
 };
 
+static void serpent_fpu_end_rt(struct crypt_priv *ctx)
+{
+#if CONFIG_PREEMPT_RT_FULL
+	bool fpu_enabled = ctx->fpu_enabled;
+
+	if (!fpu_enabled)
+		return;
+	serpent_fpu_end(fpu_enabled);
+	ctx->fpu_enabled = false;
+#endif
+}
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
 
@@ -210,10 +222,10 @@ static void decrypt_callback(void *priv, u8 *srcdst, unsigned int nbytes)
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
index b7a3904b953c..b9c8f72c6f0b 100644
--- a/arch/x86/crypto/twofish_avx_glue.c
+++ b/arch/x86/crypto/twofish_avx_glue.c
@@ -218,6 +218,31 @@ struct crypt_priv {
 	bool fpu_enabled;
 };
 
+static void twofish_fpu_end_rt(struct crypt_priv *ctx)
+{
+#if CONFIG_PREEMPT_RT_FULL
+	bool fpu_enabled = ctx->fpu_enabled;
+
+	if (!fpu_enabled)
+		return;
+	twofish_fpu_end(fpu_enabled);
+	ctx->fpu_enabled = false;
+#endif
+}
+
+static void twofish_fpu_sched_rt(struct crypt_priv *ctx)
+{
+#if CONFIG_PREEMPT_RT_FULL
+	bool fpu_enabled = ctx->fpu_enabled;
+
+	if (!fpu_enabled || !tif_need_resched_now())
+		return;
+	kernel_fpu_end();
+	/* schedule due to preemptible */
+	kernel_fpu_begin();
+#endif
+}
+
 static void encrypt_callback(void *priv, u8 *srcdst, unsigned int nbytes)
 {
 	const unsigned int bsize = TF_BLOCK_SIZE;
@@ -228,12 +253,16 @@ static void encrypt_callback(void *priv, u8 *srcdst, unsigned int nbytes)
 
 	if (nbytes == bsize * TWOFISH_PARALLEL_BLOCKS) {
 		twofish_ecb_enc_8way(ctx->ctx, srcdst, srcdst);
+		twofish_fpu_end_rt(ctx);
 		return;
 	}
 
-	for (i = 0; i < nbytes / (bsize * 3); i++, srcdst += bsize * 3)
+	for (i = 0; i < nbytes / (bsize * 3); i++, srcdst += bsize * 3) {
+		twofish_fpu_sched_rt(ctx);
 		twofish_enc_blk_3way(ctx->ctx, srcdst, srcdst);
+	}
 
+	twofish_fpu_end_rt(ctx);
 	nbytes %= bsize * 3;
 
 	for (i = 0; i < nbytes / bsize; i++, srcdst += bsize)
@@ -250,11 +279,15 @@ static void decrypt_callback(void *priv, u8 *srcdst, unsigned int nbytes)
 
 	if (nbytes == bsize * TWOFISH_PARALLEL_BLOCKS) {
 		twofish_ecb_dec_8way(ctx->ctx, srcdst, srcdst);
+		twofish_fpu_end_rt(ctx);
 		return;
 	}
 
-	for (i = 0; i < nbytes / (bsize * 3); i++, srcdst += bsize * 3)
+	for (i = 0; i < nbytes / (bsize * 3); i++, srcdst += bsize * 3) {
+		twofish_fpu_sched_rt(ctx);
 		twofish_dec_blk_3way(ctx->ctx, srcdst, srcdst);
+	}
+	twofish_fpu_end_rt(ctx);
 
 	nbytes %= bsize * 3;
 
-- 
2.15.0
