From: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [RFC PATCH] arm64/fpsimd: Don't disable softirq when touching
 FPSIMD/SVE state
Date: Wed, 13 Feb 2019 15:36:30 +0000
Message-ID: <20190213153630.GK3567@e103592.cambridge.arm.com>
References: <20190208165513.8435-1-julien.grall@arm.com>
 <20190213143029.ad2kzg7vtuo3zpjk@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Julien Grall <julien.grall@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rt-users@vger.kernel.org, catalin.marinas@arm.com,
        will.deacon@arm.com, ard.biesheuvel@linaro.org,
        linux-kernel@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190213143029.ad2kzg7vtuo3zpjk@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, Feb 13, 2019 at 03:30:29PM +0100, Sebastian Andrzej Siewior wrote:
> On 2019-02-08 16:55:13 [+0000], Julien Grall wrote:
> > When the kernel is compiled with CONFIG_KERNEL_MODE_NEON, some part of
> > the kernel may be able to use FPSIMD/SVE. This is for instance the case
> > for crypto code.
> > 
> > Any use of FPSIMD/SVE in the kernel are clearly marked by using the
> > function kernel_neon_{begin, end}. Furthermore, this can only be used
> > when may_use_simd() returns true.
> 
> This is equal what x86 is currently doing. The naming is slightly
> different, there is irq_fpu_usable().

Yes, I think it's basically the same idea.

It's been evolving a bit on both sides, but is quite similar now.

> > The current implementation of may_use_simd() allows softirq to use
> > FPSIMD/SVE unless it is currently in used (i.e kernel_neon_busy is true).
> > When in used, softirqs usually fallback to a software method.
> > 
> > At the moment, as a softirq may use FPSIMD/SVE, softirqs are disabled
> > when touching the FPSIMD/SVE context. This has the drawback to disable
> > all softirqs even if they are not using FPSIMD/SVE.
> 
> Is this bad? This means also that your crypto code will not be
> interrupted by a softirq. Also if you would get rid of it, you could
> avoid the software fallback in case may_use_simd() says false.

Masking softirqs during kernel_neon_begin()..._end() is unlikely to be a
huge problem, but currently we block softirq during all context switch
operations that act on the CPU vector registers.

The reasons for this are somewhat historical, and IIRC predated the
requirement for softirq users of kernel-mode NEON to include the
may_use_simd() check and implement a fallback path on arm64.

Now that softirq code is required to work around kernel-mode NEON being
temporarily unusable, masking softirqs completely during context switch
etc. should no longer be necessary.

> > As a softirq should not rely on been able to use simd at a given time,
> > there are limited reason to keep softirq disabled when touching the
> > FPSIMD/SVE context. Instead, we can only disable preemption and tell
> > the NEON unit is currently in use.
> > 
> > This patch introduces two new helpers kernel_neon_{disable, enable} to
> > mark the area using FPSIMD/SVE context and use them in replacement of
> > local_bh_{disable, enable}. The functions kernel_neon_{begin, end} are
> > also re-implemented to use the new helpers.
> > 
> > Signed-off-by: Julien Grall <julien.grall@arm.com>
> > 
> > ---
> > 
> > I have been exploring this solution as an alternative approach to the RT
> > patch "arm64: fpsimd: use preemp_disable in addition to local_bh_disable()".
> > 
> > So far, the patch has only been lightly tested.
> > 
> > For RT-linux, it might be possible to use migrate_{enable, disable}. I
> > am quite new with RT and have some trouble to understand the semantics
> > of migrate_{enable, disable}. So far, I am still unsure if it is possible
> > to run another userspace task on the same CPU while getting preempted
> > when the migration is disabled.
> 
> In RT:
> - preemt_disable() is the same as !RT. A thread can not be suspend. An
>   interrupt may interrupt. However on RT we have threaded interrupts so
>   the interrupt is limited to the first-level handler (not the threaded
>   handler).
> 
> - migrate_disable() means that the thread can not be moved to another
>   CPU. It can be suspended.
> 
> - local_bh_disable() disables the BH: No softirq can run. In RT
>   local_bh_disable() does not inherit preempt_disable(). Two different
>   softirqs can be executed in parallel.
>   The BH is usually invoked at the end of the threaded interrupt
>   (because the threaded interrupt handler raises the softirq). It can
>   also run in the ksoftirqd.
> 
> Usually you should not get preempted in a migrate_disable() section. A
> SCHED_OTHER task should not interrupt another SCHED_OTHER task in a
> migrate_disable() section. A task with a higher priority (a RT/DL task)
> will. Since threaded interrupts run with a RT priority of 50, they will
> interrupt your task in a migrate_disable() section.

"Usually" is probably not good enough if another task can run: if the
preempting task enters userspace then the vector registers are needed
for its use, which is tricky to arrange if the registers are currently
in use by context switch logic running in the first task.

My current feeling is that we probably have to stick with
preempt_disable() here, but hopefully we can get rid of
local_bh_disable() (as proposed) with no ill effects...

Does that sound sensible?

Cheers
---Dave
