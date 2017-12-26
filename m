From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v4 10/20] arm64: assembler: add utility macros to push/pop stack frames
Date: Tue, 26 Dec 2017 10:29:30 +0000
Message-ID: <20171226102940.26908-11-ard.biesheuvel@linaro.org>
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
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171226102940.26908-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

We are going to add code to all the NEON crypto routines that will
turn them into non-leaf functions, so we need to manage the stack
frames. To make this less tedious and error prone, add some macros
that take the number of callee saved registers to preserve and the
extra size to allocate in the stack frame (for locals) and emit
the ldp/stp sequences.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/assembler.h | 57 ++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 8b168280976f..9130be742a32 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -499,6 +499,63 @@ alternative_else_nop_endif
 #endif
 	.endm
 
+	/*
+	 * frame_push - Push @regcount callee saved registers to the stack,
+	 *              starting at x19, as well as x29/x30, and set x29 to
+	 *              the new value of sp. Add @extra bytes of stack space
+	 *              for locals.
+	 */
+	.macro		frame_push, regcount:req, extra
+	__frame		st, \regcount, \extra
+	.endm
+
+	/*
+	 * frame_pop  - Pop the callee saved registers from the stack that were
+	 *              pushed in the most recent call to frame_push, as well
+	 *              as x29/x30 and any extra stack space that may have been
+	 *              allocated.
+	 */
+	.macro		frame_pop
+	__frame		ld
+	.endm
+
+	.macro		__frame_regs, reg1, reg2, op, num
+	.if		.Lframe_regcount == \num
+	\op\()r		\reg1, [sp, #(\num + 1) * 8]
+	.elseif		.Lframe_regcount > \num
+	\op\()p		\reg1, \reg2, [sp, #(\num + 1) * 8]
+	.endif
+	.endm
+
+	.macro		__frame, op, regcount, extra=0
+	.ifc		\op, st
+	.if		(\regcount) < 0 || (\regcount) > 10
+	.error		"regcount should be in the range [0 ... 10]"
+	.endif
+	.if		((\extra) % 16) != 0
+	.error		"extra should be a multiple of 16 bytes"
+	.endif
+	.set		.Lframe_regcount, \regcount
+	.set		.Lframe_extra, \extra
+	.set		.Lframe_local_offset, ((\regcount + 3) / 2) * 16
+	stp		x29, x30, [sp, #-.Lframe_local_offset - .Lframe_extra]!
+	mov		x29, sp
+	.elseif		.Lframe_regcount == -1 // && op == 'ld'
+	.error		"frame_push/frame_pop may not be nested"
+	.endif
+
+	__frame_regs	x19, x20, \op, 1
+	__frame_regs	x21, x22, \op, 3
+	__frame_regs	x23, x24, \op, 5
+	__frame_regs	x25, x26, \op, 7
+	__frame_regs	x27, x28, \op, 9
+
+	.ifc		\op, ld
+	ldp		x29, x30, [sp], #.Lframe_local_offset + .Lframe_extra
+	.set		.Lframe_regcount, -1
+	.endif
+	.endm
+
 /*
  * Errata workaround post TTBR0_EL1 update.
  */
-- 
2.11.0
