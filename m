From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v4 11/20] arm64: assembler: add macros to conditionally yield the NEON under PREEMPT
Date: Tue, 26 Dec 2017 10:29:31 +0000
Message-ID: <20171226102940.26908-12-ard.biesheuvel@linaro.org>
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

Add support macros to conditionally yield the NEON (and thus the CPU)
that may be called from the assembler code.

In some cases, yielding the NEON involves saving and restoring a non
trivial amount of context (especially in the CRC folding algorithms),
and so the macro is split into three, and the code in between is only
executed when the yield path is taken, allowing the context to be preserved.
The third macro takes an optional label argument that marks the resume
path after a yield has been performed.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/assembler.h | 64 ++++++++++++++++++++
 arch/arm64/kernel/asm-offsets.c    |  2 +
 2 files changed, 66 insertions(+)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 9130be742a32..575d0f065d28 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -579,4 +579,68 @@ alternative_else_nop_endif
 #endif
 	.endm
 
+/*
+ * Check whether to yield to another runnable task from kernel mode NEON code
+ * (which runs with preemption disabled).
+ *
+ * if_will_cond_yield_neon
+ *        // pre-yield patchup code
+ * do_cond_yield_neon
+ *        // post-yield patchup code
+ * endif_yield_neon    <label>
+ *
+ * where <label> is optional, and marks the point where execution will resume
+ * after a yield has been performed. If omitted, execution resumes right after
+ * the endif_yield_neon invocation.
+ *
+ * Note that the patchup code does not support assembler directives that change
+ * the output section, any use of such directives is undefined.
+ *
+ * The yield itself consists of the following:
+ * - Check whether the preempt count is exactly 1, in which case disabling
+ *   preemption once will make the task preemptible. If this is not the case,
+ *   yielding is pointless.
+ * - Check whether TIF_NEED_RESCHED is set, and if so, disable and re-enable
+ *   kernel mode NEON (which will trigger a reschedule), and branch to the
+ *   yield fixup code.
+ *
+ * This macro sequence clobbers x0, x1 and the flags register unconditionally,
+ * and may clobber x2 .. x18 if the yield path is taken.
+ */
+
+	.macro		cond_yield_neon, lbl
+	if_will_cond_yield_neon
+	do_cond_yield_neon
+	endif_yield_neon	\lbl
+	.endm
+
+	.macro		if_will_cond_yield_neon
+#ifdef CONFIG_PREEMPT
+	get_thread_info	x0
+	ldr		w1, [x0, #TSK_TI_PREEMPT]
+	ldr		x0, [x0, #TSK_TI_FLAGS]
+	cmp		w1, #PREEMPT_DISABLE_OFFSET
+	csel		x0, x0, xzr, eq
+	tbnz		x0, #TIF_NEED_RESCHED, .Lyield_\@	// needs rescheduling?
+#endif
+	/* fall through to .Lyield_out_### below */
+	.subsection	1
+.Lyield_\@ :
+	.endm
+
+	.macro		do_cond_yield_neon
+	bl		kernel_neon_end
+	bl		kernel_neon_begin
+	.endm
+
+	.macro		endif_yield_neon, lbl
+	.ifnb		\lbl
+	b		\lbl
+	.else
+	b		.Lyield_out_\@
+	.endif
+	.previous
+.Lyield_out_\@ :
+	.endm
+
 #endif	/* __ASM_ASSEMBLER_H */
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 71bf088f1e4b..1e433ac2ef9c 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -91,6 +91,8 @@ int main(void)
   DEFINE(DMA_TO_DEVICE,		DMA_TO_DEVICE);
   DEFINE(DMA_FROM_DEVICE,	DMA_FROM_DEVICE);
   BLANK();
+  DEFINE(PREEMPT_DISABLE_OFFSET, PREEMPT_DISABLE_OFFSET);
+  BLANK();
   DEFINE(CLOCK_REALTIME,	CLOCK_REALTIME);
   DEFINE(CLOCK_MONOTONIC,	CLOCK_MONOTONIC);
   DEFINE(CLOCK_MONOTONIC_RAW,	CLOCK_MONOTONIC_RAW);
-- 
2.11.0
