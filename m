From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT] arm*: disable NEON in kernel mode
Date: Mon, 4 Dec 2017 10:21:46 +0100
Message-ID: <20171204092145.GE2255@linutronix.de>
References: <20171130142216.GB12606@linutronix.de>
 <20171130143028.GA1351@linutronix.de>
 <20171201104331.GB1612@linutronix.de>
 <20171201134506.GF1612@linutronix.de>
 <20171201141827.yip6pl3tt7kxzek7@lakrids.cambridge.arm.com>
 <20171201143648.GK1612@linutronix.de>
 <24FDBFF1-8351-46FC-885A-6B6F972F4C6C@linaro.org>
 <20171201175844.GT22781@e103592.cambridge.arm.com>
 <20171201180828.GN10595@n2100.armlinux.org.uk>
 <20171201182410.GU22781@e103592.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-rt-users@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        tglx@linutronix.de, linux-arm-kernel@lists.infradead.org
To: Dave Martin <Dave.Martin@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171201182410.GU22781@e103592.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2017-12-01 18:24:10 [+0000], Dave Martin wrote:
> > diff --git a/arch/arm64/crypto/Kconfig b/arch/arm64/crypto/Kconfig
> > index 70c517aa4501..2a5f05b5a19a 100644
> > --- a/arch/arm64/crypto/Kconfig
> > +++ b/arch/arm64/crypto/Kconfig
> > @@ -19,19 +19,19 @@ config CRYPTO_SHA512_ARM64
> >
> >  config CRYPTO_SHA1_ARM64_CE
> >     tristate "SHA-1 digest algorithm (ARMv8 Crypto Extensions)"
> > -   depends on KERNEL_MODE_NEON
> > +   depends on KERNEL_MODE_NEON && !PREEMPT_RT_BASE
> >     select CRYPTO_HASH
> >     select CRYPTO_SHA1
> 
> Sebastian, can you piont to where sha1 (say) hits this issue?
> I wonder whether this is really a sign that some refactoring is needed.

I disabled all NEON in one go. Looking at this, it shouldn't be a issue
with the block-walk. The only thing that might be a problem is that it
can do multiple blocks in one go.

> Cheers
> ---Dave

Sebastian
