From: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH RT v2] arm64: fpsimd: use a local_lock() in addition to
 local_bh_disable()
Date: Tue, 24 Jul 2018 15:45:35 +0100
Message-ID: <20180724144522.GA4240@e103592.cambridge.arm.com>
References: <20180522172115.fpqguqlsq6bavtxy@linutronix.de>
 <20180522132429.6f1dcf92@gandalf.local.home>
 <20180522173333.aawadhkcekzvrswp@linutronix.de>
 <20180711092555.268adf7f@gandalf.local.home>
 <20180711133157.bvrza5vmthu6lwjd@linutronix.de>
 <20180711093346.782af07a@gandalf.local.home>
 <20180713174937.5ddaqpylalcmc3jq@linutronix.de>
 <20180716151737.GO9486@e103592.cambridge.arm.com>
 <20180718091209.u76gzacanj5avhdl@linutronix.de>
 <20180718092448.v6j7wdahtsediqhh@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mike Galbraith <efault@gmx.de>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        tglx@linutronix.de, linux-arm-kernel@lists.infradead.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180718092448.v6j7wdahtsediqhh@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, Jul 18, 2018 at 11:24:48AM +0200, Sebastian Andrzej Siewior wrote:
> On 2018-07-18 11:12:10 [+0200], To Dave Martin wrote:
> > > > -	if (may_use_simd()) {
> > > > +	if (!IS_ENABLED(CONFIG_PREEMPT_RT_BASE) && may_use_simd()) {
> > > 
> > > I suspect this is wrong -- see comments on the commit message.
> 
> I'm sorry, I pressed send too early, I was aiming for the draft folder.
> So yes, based on that EFI that might be interruptible, let me try to
> look at the initial issue again and maybe I get another idea how to deal
> with this.
> One question: If EFI is interruptible that means, we call into EFI - how
> do we get out? Does EFI enable interrupts and the kernel receives an
> interrupt and treats this EFI call like a regular context switch?

AFAIK the only safe way to get out permanently is for the call to
return.  Note, I've not gone through the spec in fine detail myself.

The OS may handle interrupts occurring during the EFI call, but we
still have to return to EFI afterwards to finish off the call.  From
the Linux perspective, I think this means that EFI calls are non-
preemptible.

Under RT, I'm pretty sure that we can't safely resume the interrupted
EFI call on a different cpu from the one it was interrupted on.  Even
if it doesn't say this explicitly in the UEFI spec, I think it will be
assumed in implementations.


Certain EFI calls are not long-running and may need to be called from
interrupt context in Linux, which means that there may be live kernel-
mode NEON state.  This is why there are separate FPSIMD/SVE percpu stash
buffers for EFI specifically.

Does this make sense?  It's is probably not very clear, but I'm trying
to hide the fact that I haven't looked at the UEFI spec for ages...

Cheers
---Dave
