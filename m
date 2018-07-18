From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT v2] arm64: fpsimd: use a local_lock() in addition to
 local_bh_disable()
Date: Wed, 18 Jul 2018 11:24:48 +0200
Message-ID: <20180718092448.v6j7wdahtsediqhh@linutronix.de>
References: <20180522131004.3012953c@gandalf.local.home>
 <20180522172115.fpqguqlsq6bavtxy@linutronix.de>
 <20180522132429.6f1dcf92@gandalf.local.home>
 <20180522173333.aawadhkcekzvrswp@linutronix.de>
 <20180711092555.268adf7f@gandalf.local.home>
 <20180711133157.bvrza5vmthu6lwjd@linutronix.de>
 <20180711093346.782af07a@gandalf.local.home>
 <20180713174937.5ddaqpylalcmc3jq@linutronix.de>
 <20180716151737.GO9486@e103592.cambridge.arm.com>
 <20180718091209.u76gzacanj5avhdl@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mike Galbraith <efault@gmx.de>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        linux-arm-kernel@lists.infradead.org
To: Dave Martin <Dave.Martin@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180718091209.u76gzacanj5avhdl@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2018-07-18 11:12:10 [+0200], To Dave Martin wrote:
> > > -	if (may_use_simd()) {
> > > +	if (!IS_ENABLED(CONFIG_PREEMPT_RT_BASE) && may_use_simd()) {
> > 
> > I suspect this is wrong -- see comments on the commit message.

I'm sorry, I pressed send too early, I was aiming for the draft folder.
So yes, based on that EFI that might be interruptible, let me try to
look at the initial issue again and maybe I get another idea how to deal
with this.
One question: If EFI is interruptible that means, we call into EFI - how
do we get out? Does EFI enable interrupts and the kernel receives an
interrupt and treats this EFI call like a regular context switch?

> > >  		kernel_neon_begin();
> > >  	} else {
> > 
> > [...]
> > 
> > Cheers
> > ---Dave

Sebastian
