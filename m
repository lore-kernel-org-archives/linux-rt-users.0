Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C266C77B7F
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 May 2023 14:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbjESO5q (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 19 May 2023 10:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbjESO5o (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 19 May 2023 10:57:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E841EC7
        for <linux-rt-users@vger.kernel.org>; Fri, 19 May 2023 07:57:41 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684508259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lmDTjAl7MUm9Q0gpDHLAu7fYdFAPH5buoM5UBt1JBHI=;
        b=BIK89wxcTSSj3nBrnJPjprCQGzKBIq1JMGc/ZrT743NBqlaRpBu2dt1kUA/A371jG1LALp
        asVqtc/eINwEMJGhB7CvOEYbwkPUBBNl1m4JMadWNUkV4Ob2f2IuweJA8k46Ss3zpiKFrf
        76nj5NpAO00LM07Cd3E67PDCmIfpuhnUVVOwHtnI6YIHjBUZwq3FHqnhSRzVxbRunjxEkk
        j3N5Mxb251GvotypexYbXzNWEXgC/CnEbOhLrBIUy6qUc3MDPqMXzyuH1oIhFL/nxUoNjl
        AdeFhDbW/Mlxbp66NyYFMCekXI/BuMTk72YeRwqn1KFxL743bbQcFp0D1P2UYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684508259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lmDTjAl7MUm9Q0gpDHLAu7fYdFAPH5buoM5UBt1JBHI=;
        b=RzEPCnh/92e1WwBSgj5GD3sR3+ecOwDGeLCYvT3AMNRV1+0WLmHJUMFV0icBieBc0Ph2rR
        7K1Dg7KSMHmLBKCw==
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Pavel Pisa <pisa@cmp.felk.cvut.cz>, linux-rt-users@vger.kernel.org,
        Pavel Hronek <hronepa1@fel.cvut.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 3/3] ARM: vfp: Use vfp_lock() in vfp_entry().
Date:   Fri, 19 May 2023 16:57:31 +0200
Message-Id: <20230519145731.574867-4-bigeasy@linutronix.de>
In-Reply-To: <20230519145731.574867-1-bigeasy@linutronix.de>
References: <CAMj1kXFVutgNLYWpsM1QvrLBWsoNoSSEAK-oJKGL6bEqrh=nDg@mail.gmail.com>
 <20230519145731.574867-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

vfp_entry() is invoked from exception handler and is fully preemptible.
It uses local_bh_disable() to remain uninterrupted while checking the
VFP state.
This is not working on PREEMPT_RT because local_bh_disable()
synchronizes the relevant section but the context remains fully
preemptible.

Use vfp_lock() for uninterrupted access.

VFP_bounce() is invoked from within vfp_entry() and may send a signal.
Sending a signal uses spinlock_t which becomes a sleeping lock
on PREEMPT_RT and must not be acquired within a preempt-disabled
section. Move the vfp_raise_sigfpe() block outside of the
preempt-disabled section.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm/vfp/vfphw.S     |  7 ++-----
 arch/arm/vfp/vfpmodule.c | 30 ++++++++++++++++++++----------
 2 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/arch/arm/vfp/vfphw.S b/arch/arm/vfp/vfphw.S
index a4610d0f32152..860512042bc21 100644
--- a/arch/arm/vfp/vfphw.S
+++ b/arch/arm/vfp/vfphw.S
@@ -180,10 +180,7 @@ ENTRY(vfp_support_entry)
 					@ always subtract 4 from the following
 					@ instruction address.
=20
-local_bh_enable_and_ret:
-	adr	r0, .
-	mov	r1, #SOFTIRQ_DISABLE_OFFSET
-	b	__local_bh_enable_ip	@ tail call
+	b	vfp_exit	@ tail call
=20
 look_for_VFP_exceptions:
 	@ Check for synchronous or asynchronous exception
@@ -206,7 +203,7 @@ ENTRY(vfp_support_entry)
 	@ not recognised by VFP
=20
 	DBGSTR	"not VFP"
-	b	local_bh_enable_and_ret
+	b	vfp_exit	@ tail call
=20
 process_exception:
 	DBGSTR	"bounce"
diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index 543dc7f5a27e3..a2745d17e9c71 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -267,7 +267,7 @@ static void vfp_panic(char *reason, u32 inst)
 /*
  * Process bitmask of exception conditions.
  */
-static void vfp_raise_exceptions(u32 exceptions, u32 inst, u32 fpscr, stru=
ct pt_regs *regs)
+static int vfp_raise_exceptions(u32 exceptions, u32 inst, u32 fpscr)
 {
 	int si_code =3D 0;
=20
@@ -275,8 +275,7 @@ static void vfp_raise_exceptions(u32 exceptions, u32 in=
st, u32 fpscr, struct pt_
=20
 	if (exceptions =3D=3D VFP_EXCEPTION_ERROR) {
 		vfp_panic("unhandled bounce", inst);
-		vfp_raise_sigfpe(FPE_FLTINV, regs);
-		return;
+		return FPE_FLTINV;
 	}
=20
 	/*
@@ -304,8 +303,7 @@ static void vfp_raise_exceptions(u32 exceptions, u32 in=
st, u32 fpscr, struct pt_
 	RAISE(FPSCR_OFC, FPSCR_OFE, FPE_FLTOVF);
 	RAISE(FPSCR_IOC, FPSCR_IOE, FPE_FLTINV);
=20
-	if (si_code)
-		vfp_raise_sigfpe(si_code, regs);
+	return si_code;
 }
=20
 /*
@@ -350,6 +348,8 @@ static u32 vfp_emulate_instruction(u32 inst, u32 fpscr,=
 struct pt_regs *regs)
 void VFP_bounce(u32 trigger, u32 fpexc, struct pt_regs *regs)
 {
 	u32 fpscr, orig_fpscr, fpsid, exceptions;
+	int si_code2 =3D 0;
+	int si_code =3D 0;
=20
 	pr_debug("VFP: bounce: trigger %08x fpexc %08x\n", trigger, fpexc);
=20
@@ -397,7 +397,7 @@ void VFP_bounce(u32 trigger, u32 fpexc, struct pt_regs =
*regs)
 		 * unallocated VFP instruction but with FPSCR.IXE set and not
 		 * on VFP subarch 1.
 		 */
-		 vfp_raise_exceptions(VFP_EXCEPTION_ERROR, trigger, fpscr, regs);
+		si_code =3D vfp_raise_exceptions(VFP_EXCEPTION_ERROR, trigger, fpscr);
 		goto exit;
 	}
=20
@@ -422,7 +422,7 @@ void VFP_bounce(u32 trigger, u32 fpexc, struct pt_regs =
*regs)
 	 */
 	exceptions =3D vfp_emulate_instruction(trigger, fpscr, regs);
 	if (exceptions)
-		vfp_raise_exceptions(exceptions, trigger, orig_fpscr, regs);
+		si_code2 =3D vfp_raise_exceptions(exceptions, trigger, orig_fpscr);
=20
 	/*
 	 * If there isn't a second FP instruction, exit now. Note that
@@ -441,9 +441,14 @@ void VFP_bounce(u32 trigger, u32 fpexc, struct pt_regs=
 *regs)
  emulate:
 	exceptions =3D vfp_emulate_instruction(trigger, orig_fpscr, regs);
 	if (exceptions)
-		vfp_raise_exceptions(exceptions, trigger, orig_fpscr, regs);
+		si_code =3D vfp_raise_exceptions(exceptions, trigger, orig_fpscr);
+
  exit:
-	local_bh_enable();
+	vfp_unlock();
+	if (si_code2)
+		vfp_raise_sigfpe(si_code2, regs);
+	if (si_code)
+		vfp_raise_sigfpe(si_code, regs);
 }
=20
 static void vfp_enable(void *unused)
@@ -684,10 +689,15 @@ asmlinkage void vfp_entry(u32 trigger, struct thread_=
info *ti, u32 resume_pc,
 	if (unlikely(!have_vfp))
 		return;
=20
-	local_bh_disable();
+	vfp_lock();
 	vfp_support_entry(trigger, ti, resume_pc, resume_return_address);
 }
=20
+asmlinkage void vfp_exit(void)
+{
+	vfp_unlock();
+}
+
 #ifdef CONFIG_KERNEL_MODE_NEON
=20
 static int vfp_kmode_exception(struct pt_regs *regs, unsigned int instr)
--=20
2.40.1

