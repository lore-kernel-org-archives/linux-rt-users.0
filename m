From: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [RFC PATCH] arm64/fpsimd: Don't disable softirq when touching
 FPSIMD/SVE state
Date: Wed, 13 Feb 2019 15:42:53 +0000
Message-ID: <20190213154252.GL3567@e103592.cambridge.arm.com>
References: <20190208165513.8435-1-julien.grall@arm.com>
 <20190213143029.ad2kzg7vtuo3zpjk@linutronix.de>
 <20190213153630.GK3567@e103592.cambridge.arm.com>
 <CAKv+Gu__0uy6Y-EJGSygSYH4RqpLDWMMNFE3yauF_x7-UNcgFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Julien Grall <julien.grall@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-rt-users@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKv+Gu__0uy6Y-EJGSygSYH4RqpLDWMMNFE3yauF_x7-UNcgFQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, Feb 13, 2019 at 04:40:00PM +0100, Ard Biesheuvel wrote:
> On Wed, 13 Feb 2019 at 16:36, Dave Martin <Dave.Martin@arm.com> wrote:
> >
> > On Wed, Feb 13, 2019 at 03:30:29PM +0100, Sebastian Andrzej Siewior wrote:
> > > On 2019-02-08 16:55:13 [+0000], Julien Grall wrote:
> > > > When the kernel is compiled with CONFIG_KERNEL_MODE_NEON, some part of
> > > > the kernel may be able to use FPSIMD/SVE. This is for instance the case
> > > > for crypto code.
> > > >
> > > > Any use of FPSIMD/SVE in the kernel are clearly marked by using the
> > > > function kernel_neon_{begin, end}. Furthermore, this can only be used
> > > > when may_use_simd() returns true.
> > >
> > > This is equal what x86 is currently doing. The naming is slightly
> > > different, there is irq_fpu_usable().
> >
> > Yes, I think it's basically the same idea.
> >
> > It's been evolving a bit on both sides, but is quite similar now.
> >
> 
> may_use_simd() only exists because we have a generic crypto SIMD
> helper, and so we needed something arch agnostic to wrap around
> irq_fpu_usable()

[...]

Sounds plausible.

Cheers
---Dave
