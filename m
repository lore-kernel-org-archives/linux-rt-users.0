From: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH RT] arm64: fpsimd: use a local_lock() in addition to
 local_bh_disable()
Date: Fri, 18 May 2018 13:46:36 +0100
Message-ID: <20180518124605.GA13470@e103592.cambridge.arm.com>
References: <20180517124006.ohygrrpg7z2moqqt@linutronix.de>
 <20180517181932.GW7753@e103592.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        tglx@linutronix.de, linux-arm-kernel@lists.infradead.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180517181932.GW7753@e103592.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, May 17, 2018 at 07:19:43PM +0100, Dave Martin wrote:

[...]

> kernel_neon_begin() could then do
> 
> 	local_fpsimd_context_lock();
> 
> 	/* ... */
> 
> 	preempt_disable();
> 	local_unlock(fpsimd_context_lock);
> 
> ... with the following in kernel_neon_end():
> 
> 	local_unlock(fpsimd_lock);
> 	preempt_enable();
> 
> 
> If kernel-mode NEON was considered harmful to RT due to the context
> switch overheads, then the above might be overkill.  SVE will be worse
> in that regard, and also needs thinking about at some point -- I've not
> looked at if from the RT angle at all.

Hmmm, !KERNEL_MODE_NEON breaks EFI, so this probably does want looking
at.  Ard's recent rework to enable voluntary preemption the crypto
backends for arm64 [1] should reduce the fpsimd_lock blackouts, but it
still depends on the backends playing nice.

Cheers
---Dave

[1] [PATCH resend 00/10] crypto: arm64 - play nice with CONFIG_PREEMPT
lists.infradead.org/pipermail/linux-arm-kernel/2018-April/574819.html
