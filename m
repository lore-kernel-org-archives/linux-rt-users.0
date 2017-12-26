From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v4 20/20] DO NOT MERGE
Date: Tue, 26 Dec 2017 10:29:40 +0000
Message-ID: <20171226102940.26908-21-ard.biesheuvel@linaro.org>
References: <20171226102940.26908-1-ard.biesheuvel@linaro.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-rt-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
To: linux-kernel@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:39339 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751389AbdLZKbg (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 26 Dec 2017 05:31:36 -0500
Received: by mail-wr0-f194.google.com with SMTP id o101so5667078wrb.6
        for <linux-rt-users@vger.kernel.org>; Tue, 26 Dec 2017 02:31:36 -0800 (PST)
In-Reply-To: <20171226102940.26908-1-ard.biesheuvel@linaro.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Test code to force a kernel_neon_end+begin sequence at every yield point,
and wipe the entire NEON state before resuming the algorithm.
---
 arch/arm64/include/asm/assembler.h | 33 ++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 575d0f065d28..295937b2f39b 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -622,6 +622,7 @@ alternative_else_nop_endif
 	cmp		w1, #PREEMPT_DISABLE_OFFSET
 	csel		x0, x0, xzr, eq
 	tbnz		x0, #TIF_NEED_RESCHED, .Lyield_\@	// needs rescheduling?
+	b		.Lyield_\@
 #endif
 	/* fall through to endif_yield_neon */
 	.subsection	1
@@ -631,6 +632,38 @@ alternative_else_nop_endif
 	.macro		do_cond_yield_neon
 	bl		kernel_neon_end
 	bl		kernel_neon_begin
+	movi		v0.16b, #0x55
+	movi		v1.16b, #0x55
+	movi		v2.16b, #0x55
+	movi		v3.16b, #0x55
+	movi		v4.16b, #0x55
+	movi		v5.16b, #0x55
+	movi		v6.16b, #0x55
+	movi		v7.16b, #0x55
+	movi		v8.16b, #0x55
+	movi		v9.16b, #0x55
+	movi		v10.16b, #0x55
+	movi		v11.16b, #0x55
+	movi		v12.16b, #0x55
+	movi		v13.16b, #0x55
+	movi		v14.16b, #0x55
+	movi		v15.16b, #0x55
+	movi		v16.16b, #0x55
+	movi		v17.16b, #0x55
+	movi		v18.16b, #0x55
+	movi		v19.16b, #0x55
+	movi		v20.16b, #0x55
+	movi		v21.16b, #0x55
+	movi		v22.16b, #0x55
+	movi		v23.16b, #0x55
+	movi		v24.16b, #0x55
+	movi		v25.16b, #0x55
+	movi		v26.16b, #0x55
+	movi		v27.16b, #0x55
+	movi		v28.16b, #0x55
+	movi		v29.16b, #0x55
+	movi		v30.16b, #0x55
+	movi		v31.16b, #0x55
 	.endm
 
 	.macro		endif_yield_neon, lbl
-- 
2.11.0

