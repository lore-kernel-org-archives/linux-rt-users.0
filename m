From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v4 19/20] crypto: arm64/crct10dif-ce - yield NEON after every block of input
Date: Tue, 26 Dec 2017 10:29:39 +0000
Message-ID: <20171226102940.26908-20-ard.biesheuvel@linaro.org>
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
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40216 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751385AbdLZKbd (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 26 Dec 2017 05:31:33 -0500
Received: by mail-wm0-f68.google.com with SMTP id f206so34335112wmf.5
        for <linux-rt-users@vger.kernel.org>; Tue, 26 Dec 2017 02:31:33 -0800 (PST)
In-Reply-To: <20171226102940.26908-1-ard.biesheuvel@linaro.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Avoid excessive scheduling delays under a preemptible kernel by
yielding the NEON after every block of input.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/crypto/crct10dif-ce-core.S | 32 +++++++++++++++++---
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/crypto/crct10dif-ce-core.S b/arch/arm64/crypto/crct10dif-ce-core.S
index d5b5a8c038c8..5bce7833ca5f 100644
--- a/arch/arm64/crypto/crct10dif-ce-core.S
+++ b/arch/arm64/crypto/crct10dif-ce-core.S
@@ -74,13 +74,19 @@
 	.text
 	.cpu		generic+crypto
 
-	arg1_low32	.req	w0
-	arg2		.req	x1
-	arg3		.req	x2
+	arg1_low32	.req	w19
+	arg2		.req	x20
+	arg3		.req	x21
 
 	vzr		.req	v13
 
 ENTRY(crc_t10dif_pmull)
+	frame_push	3, 128
+
+	mov		arg1_low32, w0
+	mov		arg2, x1
+	mov		arg3, x2
+
 	movi		vzr.16b, #0		// init zero register
 
 	// adjust the 16-bit initial_crc value, scale it to 32 bits
@@ -175,8 +181,25 @@ CPU_LE(	ext		v12.16b, v12.16b, v12.16b, #8	)
 	subs		arg3, arg3, #128
 
 	// check if there is another 64B in the buffer to be able to fold
-	b.ge		_fold_64_B_loop
+	b.lt		_fold_64_B_end
+
+	if_will_cond_yield_neon
+	stp		q0, q1, [sp, #.Lframe_local_offset]
+	stp		q2, q3, [sp, #.Lframe_local_offset + 32]
+	stp		q4, q5, [sp, #.Lframe_local_offset + 64]
+	stp		q6, q7, [sp, #.Lframe_local_offset + 96]
+	do_cond_yield_neon
+	ldp		q0, q1, [sp, #.Lframe_local_offset]
+	ldp		q2, q3, [sp, #.Lframe_local_offset + 32]
+	ldp		q4, q5, [sp, #.Lframe_local_offset + 64]
+	ldp		q6, q7, [sp, #.Lframe_local_offset + 96]
+	ldr		q10, rk3
+	movi		vzr.16b, #0		// init zero register
+	endif_yield_neon
+
+	b		_fold_64_B_loop
 
+_fold_64_B_end:
 	// at this point, the buffer pointer is pointing at the last y Bytes
 	// of the buffer the 64B of folded data is in 4 of the vector
 	// registers: v0, v1, v2, v3
@@ -304,6 +327,7 @@ _barrett:
 _cleanup:
 	// scale the result back to 16 bits
 	lsr		x0, x0, #16
+	frame_pop
 	ret
 
 _less_than_128:
-- 
2.11.0

