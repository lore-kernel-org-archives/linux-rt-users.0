From: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH RT] arm*: disable NEON in kernel mode
Date: Fri, 1 Dec 2017 18:24:10 +0000
Message-ID: <20171201182410.GU22781@e103592.cambridge.arm.com>
References: <20171130142216.GB12606@linutronix.de>
 <20171130143028.GA1351@linutronix.de>
 <20171201104331.GB1612@linutronix.de>
 <20171201134506.GF1612@linutronix.de>
 <20171201141827.yip6pl3tt7kxzek7@lakrids.cambridge.arm.com>
 <20171201143648.GK1612@linutronix.de>
 <24FDBFF1-8351-46FC-885A-6B6F972F4C6C@linaro.org>
 <20171201175844.GT22781@e103592.cambridge.arm.com>
 <20171201180828.GN10595@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Rutland <mark.rutland@arm.com>,
        linux-rt-users@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        tglx@linutronix.de, linux-arm-kernel@lists.infradead.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171201180828.GN10595@n2100.armlinux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, Dec 01, 2017 at 06:08:28PM +0000, Russell King - ARM Linux wrote:
> On Fri, Dec 01, 2017 at 05:58:45PM +0000, Dave Martin wrote:
> > +1, at least for arm64.  I don't see a really compelling reason for
> > holding kernel-mode NEON around memory management now that we have a
> > strict save-once-restore-lazily model.
> > 
> > This may not work so well for arm though -- I haven't looked at that
> > code for a while.
> > 
> > 
> > If there is memory manamement in any core loop, you already lost
> > the performance battle, and an extra
> > kernel_neon_end()+kernel_neon_begin() may not be that catastrophic.
> 
> Remember that we don't permit context switches while kernel neon is
> in use on ARM - if there's any possibility of scheduling to occur,
> the get_cpu() in kernel_neon_begin() should trigger a schedule-while-
> atomic warning.

Agreed, and an arm64 the same is true.  (Actually softirq is disabled
too, for tortuous reasons involving SVE.)

On 2017-12-01 11:43:32 [+0100], To linux-rt-users@vger.kernel.org wrote:
> NEON in kernel mode is used by the crypto algorithms and raid6 code.
> While the raid6 code looks okay, the crypto algorithms do not: NEON
> is enabled on first invocation and may allocate/free/map memory before
> the NEON mode is disabled again.
> This needs to be changed until it can be enabled.
> On ARM NEON in kernel mode can be simply disabled. on ARM64 it needs to
> stay on due to possible EFI callbacks so here I disable each algorithm.

[...]

> diff --git a/arch/arm64/crypto/Kconfig b/arch/arm64/crypto/Kconfig
> index 70c517aa4501..2a5f05b5a19a 100644
> --- a/arch/arm64/crypto/Kconfig
> +++ b/arch/arm64/crypto/Kconfig
> @@ -19,19 +19,19 @@ config CRYPTO_SHA512_ARM64
>
>  config CRYPTO_SHA1_ARM64_CE
>     tristate "SHA-1 digest algorithm (ARMv8 Crypto Extensions)"
> -   depends on KERNEL_MODE_NEON
> +   depends on KERNEL_MODE_NEON && !PREEMPT_RT_BASE
>     select CRYPTO_HASH
>     select CRYPTO_SHA1

Sebastian, can you piont to where sha1 (say) hits this issue?
I wonder whether this is really a sign that some refactoring is needed.

Cheers
---Dave
