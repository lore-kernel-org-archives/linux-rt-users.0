From: Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH RT v2] arm64: fpsimd: use a local_lock() in addition to
 local_bh_disable()
Date: Sun, 15 Jul 2018 09:22:33 +0200
Message-ID: <1531639353.7900.76.camel@gmx.de>
References: <20180517124006.ohygrrpg7z2moqqt@linutronix.de>
 <20180522131004.3012953c@gandalf.local.home>
 <20180522172115.fpqguqlsq6bavtxy@linutronix.de>
 <20180522132429.6f1dcf92@gandalf.local.home>
 <20180522173333.aawadhkcekzvrswp@linutronix.de>
 <20180711092555.268adf7f@gandalf.local.home>
 <20180711133157.bvrza5vmthu6lwjd@linutronix.de>
 <20180711093346.782af07a@gandalf.local.home>
 <20180713174937.5ddaqpylalcmc3jq@linutronix.de>
 <1531519424.23898.68.camel@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 tglx@linutronix.de, linux-arm-kernel@lists.infradead.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Steven Rostedt
 <rostedt@goodmis.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1531519424.23898.68.camel@gmx.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-rt-users.vger.kernel.org

On Sat, 2018-07-14 at 00:03 +0200, Mike Galbraith wrote:
> On Fri, 2018-07-13 at 19:49 +0200, Sebastian Andrzej Siewior wrote:
> > In v4.16-RT I noticed a number of warnings from task_fpsimd_load(). The
> > code disables BH and expects that it is not preemptible. On -RT the
> > task remains preemptible but remains the same CPU. This may corrupt the
> > content of the SIMD registers if the task is preempted during
> > saving/restoring those registers.
> > Add a locallock around this process. This avoids that the any function
> > within the locallock block is invoked more than once on the same CPU.
> > 
> > The kernel_neon_begin() can't be kept preemptible. If the task-switch notices
> > TIF_FOREIGN_FPSTATE then it would restore task's SIMD state and we lose the
> > state of registers used for in-kernel-work. We would require additional storage
> > for the in-kernel copy of the registers. But then the NEON-crypto checks for
> > the need-resched flag so it shouldn't that bad.
> > The preempt_disable() avoids the context switch while the kernel uses the SIMD
> > registers. Unfortunately we have to balance out the migrate_disable() counter
> > because local_lock_bh() is invoked in different context compared to its unlock
> > counterpart.
> > 
> > __efi_fpsimd_begin() should not use kernel_fpu_begin() due to its
> > preempt_disable() context and instead save the registers always in its
> > extra spot on RT.
> > 
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > ---
> > 
> > This seems to make work (crypto chacha20-neon + cyclictest). I have no
> > EFI so I have no clue if saving SIMD while calling to EFI works.
> 
> All is not well on cavium test box.  I'm seeing random errors ala...
> 
> ./include/linux/fs.h:3137:11: internal compiler error: Segmentation fault
> ./include/linux/bio.h:175:1: internal compiler error: in grokdeclarator, at c/c-decl.c:7023
> 
> ...during make -j96 (2*cpus) kbuild.  Turns out 4.14-rt has this issue
> as well, which is unsurprising if it's related to fpsimd woes.  Box
> does not exhibit the issue with NONRT kernels, PREEMPT or NOPREEMPT.

Verified to be SIMD woes.  I backported your V2 to 4.14-rt, and the
CPUS*2 kbuild still reliably reproduced the corruption issue.  I then
did the below to both 4.14-rt and 4.16-rt, and the corruption is gone.

(this looks a bit like a patch, but is actually a functional yellow
sticky should I need to come back for another poke at it later)

arm64: fpsimd: disable preemption for RT where that is assumed

1. Per Sebastian's analysis, kernel_neon_begin() can't be made preemptible:
If the task-switch notices TIF_FOREIGN_FPSTATE then it would restore task's
SIMD state and we lose the state of registers used for in-kernel-work.  We
would require additional storage for the in-kernel copy of the registers.
But then the NEON-crypto checks for the need-resched flag so it shouldn't
that bad.

2. arch_efi_call_virt_setup/teardown() encapsulate __efi_fpsimd_begin/end()
in preempt disabled sections via efi_virtmap_load/unload().  That could be
fixed, but... 

3. A local lock solution which left preempt disabled sections 1 & 2 intact
failed, CPUS*2 parallel kbuild reliably reproduced memory corruption.

Given the two non-preemptible sections which could encapsulate something
painful remained intact with the local lock solution, and the fact that
the remaining BH disabled sections are all small, with empirical evidence
at hand that at LEAST one truely does require preemption be disabled,
the best solution for both RT and !RT is to simply disable preemption for
RT where !RT assumes preemption has been disabled.  That adds no cycles
to the !RT case, fewer cycles to the RT case, and requires no (ugly) work
around for the consequences of local_unlock() under preempt_disable().

Signed-off-by: Mike Galbraith <efault@gmx.de>
---
 arch/arm64/kernel/fpsimd.c |   18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -594,6 +594,7 @@ int sve_set_vector_length(struct task_st
 	 * non-SVE thread.
 	 */
 	if (task == current) {
+		preempt_disable_rt();
 		local_bh_disable();
 
 		task_fpsimd_save();
@@ -604,8 +605,10 @@ int sve_set_vector_length(struct task_st
 	if (test_and_clear_tsk_thread_flag(task, TIF_SVE))
 		sve_to_fpsimd(task);
 
-	if (task == current)
+	if (task == current) {
 		local_bh_enable();
+		preempt_enable_rt();
+	}
 
 	/*
 	 * Force reallocation of task SVE state to the correct size
@@ -837,6 +840,7 @@ asmlinkage void do_sve_acc(unsigned int
 
 	sve_alloc(current);
 
+	preempt_disable_rt();
 	local_bh_disable();
 
 	task_fpsimd_save();
@@ -850,6 +854,7 @@ asmlinkage void do_sve_acc(unsigned int
 		WARN_ON(1); /* SVE access shouldn't have trapped */
 
 	local_bh_enable();
+	preempt_enable_rt();
 }
 
 /*
@@ -925,6 +930,7 @@ void fpsimd_flush_thread(void)
 	if (!system_supports_fpsimd())
 		return;
 
+	preempt_disable_rt();
 	local_bh_disable();
 
 	memset(&current->thread.fpsimd_state, 0, sizeof(struct fpsimd_state));
@@ -968,6 +974,7 @@ void fpsimd_flush_thread(void)
 	set_thread_flag(TIF_FOREIGN_FPSTATE);
 
 	local_bh_enable();
+	preempt_enable_rt();
 }
 
 /*
@@ -979,9 +986,11 @@ void fpsimd_preserve_current_state(void)
 	if (!system_supports_fpsimd())
 		return;
 
+	preempt_disable_rt();
 	local_bh_disable();
 	task_fpsimd_save();
 	local_bh_enable();
+	preempt_enable_rt();
 }
 
 /*
@@ -1021,6 +1030,7 @@ void fpsimd_restore_current_state(void)
 	if (!system_supports_fpsimd())
 		return;
 
+	preempt_disable_rt();
 	local_bh_disable();
 
 	if (test_and_clear_thread_flag(TIF_FOREIGN_FPSTATE)) {
@@ -1029,6 +1039,7 @@ void fpsimd_restore_current_state(void)
 	}
 
 	local_bh_enable();
+	preempt_enable_rt();
 }
 
 /*
@@ -1041,6 +1052,7 @@ void fpsimd_update_current_state(struct
 	if (!system_supports_fpsimd())
 		return;
 
+	preempt_disable_rt();
 	local_bh_disable();
 
 	current->thread.fpsimd_state.user_fpsimd = *state;
@@ -1053,6 +1065,7 @@ void fpsimd_update_current_state(struct
 		fpsimd_bind_to_cpu();
 
 	local_bh_enable();
+	preempt_enable_rt();
 }
 
 /*
@@ -1115,6 +1128,7 @@ void kernel_neon_begin(void)
 
 	BUG_ON(!may_use_simd());
 
+	preempt_disable();
 	local_bh_disable();
 
 	__this_cpu_write(kernel_neon_busy, true);
@@ -1128,8 +1142,6 @@ void kernel_neon_begin(void)
 	/* Invalidate any task state remaining in the fpsimd regs: */
 	fpsimd_flush_cpu_state();
 
-	preempt_disable();
-
 	local_bh_enable();
 }
 EXPORT_SYMBOL(kernel_neon_begin);
