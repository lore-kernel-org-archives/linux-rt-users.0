Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F8EC32771
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Aug 2022 09:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347949AbiHSJY6 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 19 Aug 2022 05:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346913AbiHSJY4 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 19 Aug 2022 05:24:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641BBF2CAB;
        Fri, 19 Aug 2022 02:24:53 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1660901092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pi5wqDEO3CX7P7BoxBLg1L8FwXjPDN25w39/5gddS0Q=;
        b=a/UXWr23wKbEz8msK1outfgTN6m7p5WJ9UerG7Id/oDInDpv239N0/GC65eOxfez+AF5wx
        AItHF6tGZCyqc9AUEH6dp+BY83RX51+5Kug0t3LrmNra2OcF8uBk4U6y8Ho7yVE9MLLLZ6
        geY0pfelc4mAa6pVx5vfaXr7epWzlFONaIweDgMh5j8G6rythjpLR/HsgY99lR2zK0fzql
        10Vf/jR2dveoaGRHkM075SFgnq0k8JPO3rd+GPb2B/bb+GOt7pnW7zHbJSoXK4sZ/CoZIE
        PM8evwkiYIXeMBot5oAN7z5xZBiT0bKiIKsM8j6RqsBFxNTi65TGb/jN8UizeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1660901092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pi5wqDEO3CX7P7BoxBLg1L8FwXjPDN25w39/5gddS0Q=;
        b=pN1/+wUyCLNN8J4BXiJeGzEucxRvHogzw8Y38Z6cy1AUlz7pcBHtJg6v2O1e5jVwwwmMIa
        CE1Tlum0R5BGnaDw==
To:     Mark Gross <markgross@kernel.org>
Cc:     linux-rt-users@vger.kernel.org, stable-rt@vger.kernel.org,
        Salvatore Bonaccorso <carnil@debian.org>
Subject: [PATCH 1/9] random: Bring back the local_locks
Date:   Fri, 19 Aug 2022 11:24:38 +0200
Message-Id: <20220819092446.980320-2-bigeasy@linutronix.de>
In-Reply-To: <20220819092446.980320-1-bigeasy@linutronix.de>
References: <20220819092446.980320-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

As part of the backports the random code lost its local_lock_t type and
the whole operation became a local_irq_{disable|enable}() simply because
the older kernel did not provide those primitives.

RT as of v4.9 has a slightly different variant of local_locks.
Replace the local_irq_*() operations with matching local_lock_irq*()
operations which were there as part of commit
   77760fd7f7ae3 ("random: remove batched entropy locking")

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/char/random.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 8e701ea78b0da..860dc427000e9 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -53,6 +53,7 @@
 #include <linux/uuid.h>
 #include <linux/siphash.h>
 #include <linux/uio.h>
+#include <linux/locallock.h>
 #include <crypto/chacha20.h>
 #include <crypto/blake2s.h>
 #include <asm/processor.h>
@@ -230,10 +231,12 @@ static struct {
 struct crng {
 	u8 key[CHACHA20_KEY_SIZE];
 	unsigned long generation;
+	struct local_irq_lock lock;
 };
=20
 static DEFINE_PER_CPU(struct crng, crngs) =3D {
-	.generation =3D ULONG_MAX
+	.generation =3D ULONG_MAX,
+	.lock.lock =3D __SPIN_LOCK_UNLOCKED(crngs.lock.lock),
 };
=20
 /* Used by crng_reseed() and crng_make_state() to extract a new seed from =
the input pool. */
@@ -363,7 +366,7 @@ static void crng_make_state(u32 chacha_state[CHACHA20_B=
LOCK_SIZE / sizeof(u32)],
 	if (unlikely(crng_has_old_seed()))
 		crng_reseed();
=20
-	local_irq_save(flags);
+	local_lock_irqsave(crngs.lock, flags);
 	crng =3D raw_cpu_ptr(&crngs);
=20
 	/*
@@ -388,7 +391,7 @@ static void crng_make_state(u32 chacha_state[CHACHA20_B=
LOCK_SIZE / sizeof(u32)],
 	 * should wind up here immediately.
 	 */
 	crng_fast_key_erasure(crng->key, chacha_state, random_data, random_data_l=
en);
-	local_irq_restore(flags);
+	local_unlock_irqrestore(crngs.lock, flags);
 }
=20
 static void _get_random_bytes(void *buf, size_t len)
@@ -506,11 +509,13 @@ struct batch_ ##type {								\
 	 * formula of (integer_blocks + 0.5) * CHACHA20_BLOCK_SIZE.		\
 	 */									\
 	type entropy[CHACHA20_BLOCK_SIZE * 3 / (2 * sizeof(type))];		\
+	struct local_irq_lock lock;						\
 	unsigned long generation;						\
 	unsigned int position;							\
 };										\
 										\
 static DEFINE_PER_CPU(struct batch_ ##type, batched_entropy_ ##type) =3D {=
	\
+	.lock.lock =3D __SPIN_LOCK_UNLOCKED(batched_entropy_ ##type.lock.lock),	\
 	.position =3D UINT_MAX							\
 };										\
 										\
@@ -528,7 +533,7 @@ type get_random_ ##type(void)							\
 		return ret;							\
 	}									\
 										\
-	local_irq_save(flags);		\
+	local_lock_irqsave(batched_entropy_ ##type.lock, flags);		\
 	batch =3D raw_cpu_ptr(&batched_entropy_##type);				\
 										\
 	next_gen =3D READ_ONCE(base_crng.generation);				\
@@ -542,7 +547,7 @@ type get_random_ ##type(void)							\
 	ret =3D batch->entropy[batch->position];					\
 	batch->entropy[batch->position] =3D 0;					\
 	++batch->position;							\
-	local_irq_restore(flags);		\
+	local_unlock_irqrestore(batched_entropy_ ##type.lock, flags);		\
 	return ret;								\
 }										\
 EXPORT_SYMBOL(get_random_ ##type);
--=20
2.37.2

