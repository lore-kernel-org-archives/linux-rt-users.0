Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C658C7EE26
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 May 2023 14:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbjESO5o (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 19 May 2023 10:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbjESO5n (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 19 May 2023 10:57:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E706AC4
        for <linux-rt-users@vger.kernel.org>; Fri, 19 May 2023 07:57:41 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684508259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LldjaLfYb76ho80XKTV86hUVMPTppvWm3OJfAvriQ1E=;
        b=m+Lraj4jhQsFo6563+j1BDT13F83Csohj6lBkwKImBX6xGisyATDeieXMa56KWuiFpClOp
        DoBw9Tu4rkpCT5bMDdBP2CgktK1cfaAIkdzQhT2Qsxdq/4oeRxjxpIG7ReBMhWLtHDrNY0
        E5feX0O9BoO1uQkXd5pXTtOEa6PbTH8ZSdUevx2bIytWc0Saz7BqXHhLDNBRkZSaS0ar9E
        0B78OOJwbYq0IPbRMyKOnds2GFlzT6m/MgBrG3j278nlF8biKqXlAqzO339LJN3aApSLXL
        kSDPoIGTsAtDO6FjlcNL42irxL4oO1DMiqCEDhbRTostUN7sT55cC+KdX6jNQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684508259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LldjaLfYb76ho80XKTV86hUVMPTppvWm3OJfAvriQ1E=;
        b=OCkVuzydKYV8IQcT7KmXlfPaecAv8Cl4WGmRWl4uDcVACybYaEQs7OA1yfnJlaQ1Hd1Rrt
        rG3xRWBP6pElZjAg==
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Pavel Pisa <pisa@cmp.felk.cvut.cz>, linux-rt-users@vger.kernel.org,
        Pavel Hronek <hronepa1@fel.cvut.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2/3] ARM: vfp: Use vfp_lock() in vfp_sync_hwstate().
Date:   Fri, 19 May 2023 16:57:30 +0200
Message-Id: <20230519145731.574867-3-bigeasy@linutronix.de>
In-Reply-To: <20230519145731.574867-1-bigeasy@linutronix.de>
References: <CAMj1kXFVutgNLYWpsM1QvrLBWsoNoSSEAK-oJKGL6bEqrh=nDg@mail.gmail.com>
 <20230519145731.574867-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

vfp_sync_hwstate() uses preempt_disable() followed by local_bh_disable()
to ensure that it won't get interrupted while checking the VFP state.
This harms PREEMPT_RT because softirq handling can get preempted and
local_bh_disable() synchronizes the related section with a sleeping lock
which does not work with disabled preemption.

Use the vfp_lock() to synchronize the access.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm/vfp/vfpmodule.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index 57f9527d1e50e..543dc7f5a27e3 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -542,11 +542,9 @@ static inline void vfp_pm_init(void) { }
  */
 void vfp_sync_hwstate(struct thread_info *thread)
 {
-	unsigned int cpu =3D get_cpu();
+	vfp_lock();
=20
-	local_bh_disable();
-
-	if (vfp_state_in_hw(cpu, thread)) {
+	if (vfp_state_in_hw(raw_smp_processor_id(), thread)) {
 		u32 fpexc =3D fmrx(FPEXC);
=20
 		/*
@@ -557,8 +555,7 @@ void vfp_sync_hwstate(struct thread_info *thread)
 		fmxr(FPEXC, fpexc);
 	}
=20
-	local_bh_enable();
-	put_cpu();
+	vfp_unlock();
 }
=20
 /* Ensure that the thread reloads the hardware VFP state on the next use. =
*/
--=20
2.40.1

