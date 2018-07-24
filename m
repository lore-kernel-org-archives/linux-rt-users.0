From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH RT v2] arm64: fpsimd: use a local_lock() in addition to local_bh_disable()
Date: Tue, 24 Jul 2018 17:15:20 +0200
Message-ID: <CAKv+Gu_WdooOKAvqBJCespZmYYNLcmYsy2cxJ-MP4pjKhPaqrw@mail.gmail.com>
References: <20180522172115.fpqguqlsq6bavtxy@linutronix.de>
 <20180522132429.6f1dcf92@gandalf.local.home> <20180522173333.aawadhkcekzvrswp@linutronix.de>
 <20180711092555.268adf7f@gandalf.local.home> <20180711133157.bvrza5vmthu6lwjd@linutronix.de>
 <20180711093346.782af07a@gandalf.local.home> <20180713174937.5ddaqpylalcmc3jq@linutronix.de>
 <20180716151737.GO9486@e103592.cambridge.arm.com> <20180718091209.u76gzacanj5avhdl@linutronix.de>
 <20180718092448.v6j7wdahtsediqhh@linutronix.de> <20180724144522.GA4240@e103592.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mike Galbraith <efault@gmx.de>,
        Will Deacon <will.deacon@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
To: Dave Martin <Dave.Martin@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180724144522.GA4240@e103592.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 24 July 2018 at 16:45, Dave Martin <Dave.Martin@arm.com> wrote:
> On Wed, Jul 18, 2018 at 11:24:48AM +0200, Sebastian Andrzej Siewior wrote:
>> On 2018-07-18 11:12:10 [+0200], To Dave Martin wrote:
>> > > > -       if (may_use_simd()) {
>> > > > +       if (!IS_ENABLED(CONFIG_PREEMPT_RT_BASE) && may_use_simd()) {
>> > >
>> > > I suspect this is wrong -- see comments on the commit message.
>>
>> I'm sorry, I pressed send too early, I was aiming for the draft folder.
>> So yes, based on that EFI that might be interruptible, let me try to
>> look at the initial issue again and maybe I get another idea how to deal
>> with this.
>> One question: If EFI is interruptible that means, we call into EFI - how
>> do we get out? Does EFI enable interrupts and the kernel receives an
>> interrupt and treats this EFI call like a regular context switch?
>
> AFAIK the only safe way to get out permanently is for the call to
> return.  Note, I've not gone through the spec in fine detail myself.
>
> The OS may handle interrupts occurring during the EFI call, but we
> still have to return to EFI afterwards to finish off the call.  From
> the Linux perspective, I think this means that EFI calls are non-
> preemptible.
>
> Under RT, I'm pretty sure that we can't safely resume the interrupted
> EFI call on a different cpu from the one it was interrupted on.  Even
> if it doesn't say this explicitly in the UEFI spec, I think it will be
> assumed in implementations.
>

This is a can of worms I would rather not open, although I don't think
the UEFI spec makes it explicit that you cannot migrate runtime
service calls while in progress.

Also, I don't think EFI calls are worth obsessing about, given that
they shouldn't be that common under normal operation. I know that RT
is not about the common case but about the worst case, though. What
problem is migrating a non-preemptible task intended to solve?

>
> Certain EFI calls are not long-running and may need to be called from
> interrupt context in Linux,

This suggests that the need to be called in interrupt context is a
property of the firmware implementation but it is not.

In the kernel, we have efi-pstore which may attempt to invoke runtime
services to record the kernel's dying gasp into a EFI variable. Other
than that, I don't think there are any reasons to call EFI services
from non-process context.

> which means that there may be live kernel-
> mode NEON state.  This is why there are separate FPSIMD/SVE percpu stash
> buffers for EFI specifically.
>

So given the above, and the fact that you can panic() in an interrupt
handler, we needed those buffers, although I wonder if we'd ever reach
the point where we end up resuming execution of the code that uses the
restored contents of those buffers.

> Does this make sense?  It's is probably not very clear, but I'm trying
> to hide the fact that I haven't looked at the UEFI spec for ages...
>
> Cheers
> ---Dave
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
