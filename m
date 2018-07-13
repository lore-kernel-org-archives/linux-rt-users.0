From: Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH RT v2] arm64: fpsimd: use a local_lock() in addition to
 local_bh_disable()
Date: Sat, 14 Jul 2018 00:03:44 +0200
Message-ID: <1531519424.23898.68.camel@gmx.de>
References: <20180517124006.ohygrrpg7z2moqqt@linutronix.de>
         <20180522131004.3012953c@gandalf.local.home>
         <20180522172115.fpqguqlsq6bavtxy@linutronix.de>
         <20180522132429.6f1dcf92@gandalf.local.home>
         <20180522173333.aawadhkcekzvrswp@linutronix.de>
         <20180711092555.268adf7f@gandalf.local.home>
         <20180711133157.bvrza5vmthu6lwjd@linutronix.de>
         <20180711093346.782af07a@gandalf.local.home>
         <20180713174937.5ddaqpylalcmc3jq@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180713174937.5ddaqpylalcmc3jq@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 2018-07-13 at 19:49 +0200, Sebastian Andrzej Siewior wrote:
> In v4.16-RT I noticed a number of warnings from task_fpsimd_load(). The
> code disables BH and expects that it is not preemptible. On -RT the
> task remains preemptible but remains the same CPU. This may corrupt the
> content of the SIMD registers if the task is preempted during
> saving/restoring those registers.
> Add a locallock around this process. This avoids that the any function
> within the locallock block is invoked more than once on the same CPU.
> 
> The kernel_neon_begin() can't be kept preemptible. If the task-switch notices
> TIF_FOREIGN_FPSTATE then it would restore task's SIMD state and we lose the
> state of registers used for in-kernel-work. We would require additional storage
> for the in-kernel copy of the registers. But then the NEON-crypto checks for
> the need-resched flag so it shouldn't that bad.
> The preempt_disable() avoids the context switch while the kernel uses the SIMD
> registers. Unfortunately we have to balance out the migrate_disable() counter
> because local_lock_bh() is invoked in different context compared to its unlock
> counterpart.
> 
> __efi_fpsimd_begin() should not use kernel_fpu_begin() due to its
> preempt_disable() context and instead save the registers always in its
> extra spot on RT.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> 
> This seems to make work (crypto chacha20-neon + cyclictest). I have no
> EFI so I have no clue if saving SIMD while calling to EFI works.

All is not well on cavium test box.  I'm seeing random errors ala...

./include/linux/fs.h:3137:11: internal compiler error: Segmentation fault
./include/linux/bio.h:175:1: internal compiler error: in grokdeclarator, at c/c-decl.c:7023

...during make -j96 (2*cpus) kbuild.  Turns out 4.14-rt has this issue
as well, which is unsurprising if it's related to fpsimd woes.  Box
does not exhibit the issue with NONRT kernels, PREEMPT or NOPREEMPT.

To file under FWIW, arm64 configured SLE15-RT, 4.12 based kernel
containing virgin @stable arch/arm64/kernel/fpsimd.c, does not exhibit
the problem. (relevant? dunno, it may be unrelated to fpsimd.c).

	-Mike
