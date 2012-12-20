From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: VirtualBox 4.2.4 freezes PC using RT_PREEMPT kernel
Date: Thu, 20 Dec 2012 19:20:14 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1212201856140.3148@ionos>
References: <F9467A784CC48947B1D879F07370839E0EBCEA22@fe20099s.ecn.etasgroup.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jan Kiszka <jan.kiszka@web.de>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: "Koehrer Mathias (ETAS/ESS2)" <mathias.koehrer@etas.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:50167 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750875Ab2LTSUR (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 20 Dec 2012 13:20:17 -0500
In-Reply-To: <F9467A784CC48947B1D879F07370839E0EBCEA22@fe20099s.ecn.etasgroup.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 19 Dec 2012, Koehrer Mathias (ETAS/ESS2) wrote:
> > >
> > > I have detected the following issue:
> > > I use an x86 PC using kernel 3.2.34-rt51 and I want to run VirtualBox 4.2.4 using
> > this PC as host.
> > 
> > > However, the PC freezes completely when loading the vbox driver "vboxdrv".
> > > Using the very same kernel without the RT_PREEMPT patch shows no issues.
> > >
> > > Using an older version of VirtualBox (V4.1.22) works fine as well.
> > >
> > > I know that this might be slightly off-topic. However there might be some
> > RT_PREEMPT users that have detected the same issue and know a solution for this.
> > >
> > > I have attached my kernel .config file.
> > >
> > > Thanks for any feedback on this.
> > 
> > Try enabling lock debugging. Likely there is an incompatibility in the
> > vbox driver or even a bug, and that may reveal more details.
> > 
> > Otherwise: KVM is the better choice on Linux hosts, and it works fine
> > over -rt.
> I am about to try this out in parallel. It looks promising...
> 
> 
> In addition, I did a long debug session (using a parallel port LED adapter any many PC resets...) to identify the issue.
> Lock debugging did not work as really everything was frozen or the PC.
> However, I finally identified the critical lines of code.
> The relevant source file is the attached file "spinlock-r0drv-linux.c" of the VirtualBox OSE V4.2.4.
> The freeze happens in line 158 (spin_unlock_irqrestore()).
> 
> ----------- BEGIN CODE FRAGMENT --------------------
> RTDECL(void) RTSpinlockRelease(RTSPINLOCK Spinlock)
> {
>     PRTSPINLOCKINTERNAL pThis = (PRTSPINLOCKINTERNAL)Spinlock;
>     RT_ASSERT_PREEMPT_CPUID_SPIN_RELEASE_VARS();
>     AssertMsg(pThis && pThis->u32Magic == RTSPINLOCK_MAGIC,
>               ("pThis=%p u32Magic=%08x\n", pThis, pThis ? (int)pThis->u32Magic : 0));
>     RT_ASSERT_PREEMPT_CPUID_SPIN_RELEASE(pThis);
> 
>     if (pThis->fFlags & RTSPINLOCK_FLAGS_INTERRUPT_SAFE)
>     {
>         unsigned long fIntSaved = pThis->fIntSaved;
>         pThis->fIntSaved = 0;
>         spin_unlock_irqrestore(&pThis->Spinlock, fIntSaved);   // <--- Here is the freeze!
>     }
>     else
>         spin_unlock(&pThis->Spinlock);
> 
>     RT_ASSERT_PREEMPT_CPUID();
> }
> RT_EXPORT_SYMBOL(RTSpinlockRelease);
> ----------- END CODE FRAGMENT --------------------

Was it really necessary to expose us to the camel case inflicted
horror of the VirtualBox spinlock abstraction layer just a few days
before Christmas?

> It has something to do with the spin locks used in VirtualBox.

Why am I not surprised?

> Likely it does not consider the RT_PREEMPT use case here...

I don't think so. That's a genuine problem unrelated to RT.

> Is there a way to make the spin lock calls compatible to the RT_PREEMPT patch?

No. The API usage seems to be correct, but RT might expose an
otherwise hard to trigger live time issue, data corruption or whatever
problem.

You said:
> Lock debugging did not work as really everything was frozen or the PC.

That's an indicator that something is really wrong. Can you just run
the same crap on a non-rt kernel with CONFIG_PROVE_LOCKING enabled ?

Thanks,

	tglx
