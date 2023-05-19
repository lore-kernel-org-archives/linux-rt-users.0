Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 733C5C77B7F
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 May 2023 14:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbjESO5n (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 19 May 2023 10:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbjESO5n (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 19 May 2023 10:57:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84F6F1
        for <linux-rt-users@vger.kernel.org>; Fri, 19 May 2023 07:57:41 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684508259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jg1SUpykiUg9DonJuWHzO+vWBLY6fBSjbyxfmKOi1pg=;
        b=ET4+ZjY0TLgcc048Eu2nWALl4xl/3MdFxnbqmiH3KUNp+pkpPvxOASN0JlXqU6K+GtpI+n
        Q57niJ25+7ddfypYEFcQvZ+lj5Xc4u8wq3FH1wpZVn/xEtb4sdJ2tBdkrdRCv5Cb2dNySq
        +yYkQELCvEyX/FBd8vpJHZUk+rAj615F+Xddn1DYWYp0HGXxoq84VUFkMRDnMGXnutIHig
        JZKy8b75OLemoIF5vNDD5R4UKC6yb+f2L1RwFA0THVYzvLSIJhQySiR77Z/pApjO5VDKh9
        xT5/OQnxwW1AUUWXDB63LUNbbE+YO9inYN1YuQB5m/2IPDWvJU89M3jMTCMhag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684508259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jg1SUpykiUg9DonJuWHzO+vWBLY6fBSjbyxfmKOi1pg=;
        b=wVKToWd8WfHzaEl+rUblpAbTQSwuygnpK4efAEyHUFbJRloFTfoM6PeZA16KDiSL8xfDrc
        sxPPF8bwC2ueQgAg==
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Pavel Pisa <pisa@cmp.felk.cvut.cz>, linux-rt-users@vger.kernel.org,
        Pavel Hronek <hronepa1@fel.cvut.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/3] ARM: vfp: Provide vfp_lock() for VFP locking.
Date:   Fri, 19 May 2023 16:57:29 +0200
Message-Id: <20230519145731.574867-2-bigeasy@linutronix.de>
In-Reply-To: <20230519145731.574867-1-bigeasy@linutronix.de>
References: <CAMj1kXFVutgNLYWpsM1QvrLBWsoNoSSEAK-oJKGL6bEqrh=nDg@mail.gmail.com>
 <20230519145731.574867-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

kernel_neon_begin() uses local_bh_disable() to ensure exclusive access
to the VFP unit. This is broken on PREEMPT_RT because a BH disabled
section remains preemptible on PREEMPT_RT.

Introduce vfp_lock() which uses local_bh_disable() and preempt_disable()
on PREEMPT_RT. Since softirqs are processed always in thread context,
disabling preemption is enough to ensure that the current context won't
get interrupted by something that is using the VFP. Use it in
kernel_neon_begin().

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm/vfp/vfpmodule.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index 349dcb944a937..57f9527d1e50e 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -54,6 +54,34 @@ static unsigned int __initdata VFP_arch;
  */
 union vfp_state *vfp_current_hw_state[NR_CPUS];
=20
+/*
+ * Claim ownership of the VFP unit.
+ *
+ * The caller may change VFP registers until vfp_unlock() is called.
+ *
+ * local_bh_disable() is used to disable preemption and to disable VFP
+ * processing in softirq context. On PREEMPT_RT kernels local_bh_disable()=
 is
+ * not sufficient because it only serializes soft interrupt related sectio=
ns
+ * via a local lock, but stays preemptible. Disabling preemption is the ri=
ght
+ * choice here as bottom half processing is always in thread context on RT
+ * kernels so it implicitly prevents bottom half processing as well.
+ */
+static void vfp_lock(void)
+{
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		local_bh_disable();
+	else
+		preempt_disable();
+}
+
+static void vfp_unlock(void)
+{
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		local_bh_enable();
+	else
+		preempt_enable();
+}
+
 /*
  * Is 'thread's most up to date state stored in this CPUs hardware?
  * Must be called from non-preemptible context.
@@ -738,7 +766,7 @@ void kernel_neon_begin(void)
 	unsigned int cpu;
 	u32 fpexc;
=20
-	local_bh_disable();
+	vfp_lock();
=20
 	/*
 	 * Kernel mode NEON is only allowed outside of hardirq context with
@@ -769,7 +797,7 @@ void kernel_neon_end(void)
 {
 	/* Disable the NEON/VFP unit. */
 	fmxr(FPEXC, fmrx(FPEXC) & ~FPEXC_EN);
-	local_bh_enable();
+	vfp_unlock();
 }
 EXPORT_SYMBOL(kernel_neon_end);
=20
--=20
2.40.1

