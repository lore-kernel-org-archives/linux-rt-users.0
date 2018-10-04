From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH RT 1/2] x86/kconfig: Use ticket spinlocks for -rt
Date: Thu, 4 Oct 2018 23:21:09 +0200 (CEST)
Message-ID: <alpine.DEB.2.21.1810042303040.29948@nanos.tec.linutronix.de>
References: <20181004134622.23181-1-daniel.wagner@siemens.com> <20181004134622.23181-2-daniel.wagner@siemens.com> <20181004140846.uerpx7txvx7pj6yc@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Daniel Wagner <daniel.wagner@siemens.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Julia Cartwright <julia@ni.com>,
        Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181004140846.uerpx7txvx7pj6yc@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 4 Oct 2018, Sebastian Andrzej Siewior wrote:

> On 2018-10-04 15:46:21 [+0200], Daniel Wagner wrote:
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index 6df130a37d41..21f9418d850f 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -42,7 +42,7 @@ config X86
> >  	select ARCH_USE_BUILTIN_BSWAP
> >  	select ARCH_USE_CMPXCHG_LOCKREF		if X86_64
> >  	select ARCH_USE_QUEUED_RWLOCKS
> > -	select ARCH_USE_QUEUED_SPINLOCKS
> > +	select ARCH_USE_QUEUED_SPINLOCKS	if !PREEMPT_RT_FULL
> >  	select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
> >  	select ARCH_WANTS_DYNAMIC_TASK_STRUCT
> >  	select ARCH_WANT_FRAME_POINTERS
> 
> I would argue, that RT exposes a problem and we should not limit it to
> RT only. Anyone?

It has absolutely nothing to do with RT, really. RT is merily exposing the
problem in an observable way. The same issue happens with upstream, it's
harder to trigger and it's harder to observe for obvious reasons.

If you read through the discussions then you really see that there is an
upstream issue with the x86 qrlock implementation and Peter has posted fixes
which resolve it, both at the practical and the theoretical level.

So making this depend on RT is just shooting the messenger and sending the
totally wrong signal.

The original x86 ticket lock implementation does not have this issue by
design, so switching back to ticket locks on 4.4 is the right thing to do
because backporting a gazillion of updates and fixes for qrlocks to 4.4 is
worse.

While I agree that we want to fix that for 4.4-RT ASAP because it can be
triggered, the real solution is to fix that in 4.4 stable as well. In fact
all stable trees need too be fixed because the issue can be triggered on
all versions.

   4.4:  Trivial by switching back to ticket locks.

   4.9:  Decide whether bringing back ticket locks or backporting all qrlock
   	 fixes. Sebastian has done the latter already and it's probably the
   	 right solution

   4.14:
   4.18: Backporting the qrlock fixes

   4.19: Either the fix ends up in 4.19 final or it needs to be backported

Aside of that there is no solution for ARM64 yet. aside of the horrible
hack of adding the delay loop into cpu_relax(). Still working on that, but
won't be able to do more investigation before monday.

Thanks,

	tglx
