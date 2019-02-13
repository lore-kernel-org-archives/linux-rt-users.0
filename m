From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RFC PATCH] arm64/fpsimd: Don't disable softirq when touching
 FPSIMD/SVE state
Date: Wed, 13 Feb 2019 17:50:34 +0100
Message-ID: <20190213165034.mda5rdfwsxbcdtfa@linutronix.de>
References: <20190208165513.8435-1-julien.grall@arm.com>
 <20190213143029.ad2kzg7vtuo3zpjk@linutronix.de>
 <20190213153630.GK3567@e103592.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: Julien Grall <julien.grall@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rt-users@vger.kernel.org, catalin.marinas@arm.com,
        will.deacon@arm.com, ard.biesheuvel@linaro.org,
        linux-kernel@vger.kernel.org
To: Dave Martin <Dave.Martin@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190213153630.GK3567@e103592.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2019-02-13 15:36:30 [+0000], Dave Martin wrote:
> On Wed, Feb 13, 2019 at 03:30:29PM +0100, Sebastian Andrzej Siewior wrote:
> > On 2019-02-08 16:55:13 [+0000], Julien Grall wrote:
> > > When the kernel is compiled with CONFIG_KERNEL_MODE_NEON, some part of
> > > the kernel may be able to use FPSIMD/SVE. This is for instance the case
> > > for crypto code.
> > > 
> > > Any use of FPSIMD/SVE in the kernel are clearly marked by using the
> > > function kernel_neon_{begin, end}. Furthermore, this can only be used
> > > when may_use_simd() returns true.
> > 
> > This is equal what x86 is currently doing. The naming is slightly
> > different, there is irq_fpu_usable().
> 
> Yes, I think it's basically the same idea.
> 
> It's been evolving a bit on both sides, but is quite similar now.

I though that this is complicated and wanted to submit a patch to remove
irq_fpu_usable() and disable BH as part of kernel_fpu_begin() (but have
currently the onother FPU series ongoing which I want to finish first).

…
> "Usually" is probably not good enough if another task can run: if the
> preempting task enters userspace then the vector registers are needed
> for its use, which is tricky to arrange if the registers are currently
> in use by context switch logic running in the first task.

Yes.

> My current feeling is that we probably have to stick with
> preempt_disable() here, but hopefully we can get rid of
> local_bh_disable() (as proposed) with no ill effects...
> 
> Does that sound sensible?

If you want to stick with may_use_simd() then yes.

> Cheers
> ---Dave

Sebastian
