From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Protection of critical section in PREEMPT_RT
Date: Tue, 5 Feb 2013 11:05:27 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1302051048170.11905@ionos>
References: <CAHX1yNTSObcxNrvsBnPw8QzUWTb4zzs_faZZ1bbGU1L8xzgpsQ@mail.gmail.com> <50FE68EF.8060909@meduna.org> <CAHX1yNTKw8vr2v01Eft1tVV5YrP-7Zw=3fk9iF6YJYfbnBJ9LQ@mail.gmail.com> <510ACB87.3080007@am.sony.com> <CAHX1yNQgJXM292q1DWXLdQiR_BK5jZ-d+QHVoEEgksQm04YU6g@mail.gmail.com>
 <alpine.LFD.2.02.1302041138400.11905@ionos> <CAHX1yNTb92NMAi+9F0QCXqyvwEmerGOar5t4J1tLGznF2jD8Tg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: frank.rowand@am.sony.com, Stanislav Meduna <stano@meduna.org>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Jacky Lam <lamshuyin@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:48316 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750842Ab3BEKFe (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 5 Feb 2013 05:05:34 -0500
In-Reply-To: <CAHX1yNTb92NMAi+9F0QCXqyvwEmerGOar5t4J1tLGznF2jD8Tg@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Jacky,

On Tue, 5 Feb 2013, Jacky Lam wrote:
> On Mon, Feb 4, 2013 at 6:40 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > Probably. First of all you don't tell us which driver you are
> > using. And w/o seing the code and the output of the kernel crash, we
> > can't help you at all.
> >
> 
> I am sorry for that. But it is a driver for our in-house hardware. It
> seems meaningless even I post the source here. Please tell me if it
> did help. 

Sure does posting the code help. W/o seing the code and the crash we
have no idea what your driver is doing and why you think you need
special code constructs.

> From your statement above, it seems PREEMPT_RT patch do not work
> with USB stack. Is it true?

How do you read that into what I wrote ?
 
> I am happy to post the fix here if I can fix that.

There is nothing to fix. The USB stack works perfectly fine on RT at
least with those drivers which are written correctly.

> While I am porting my drivers to PREEMPT_RT patched kernel, I find a
> common problem. In stock kernel, whenever I need to touch some data
> structures in driver code and also in interrupt handler, we can
> protect them by spin_lock_irqsave(). But in PREEMT_RT kernel, while
> the driver code touching the data structures, interrupt can still come
> in.

And how does that matter? The interrupt comes in and wakes the
interrupt thread. The interrupt thread either preempts your code or it
does not. If if preempts then it will contend on the spin lock and go
to sleep until the code which holds the lock releases it. So what's
the problem with using spin_lock_irqsave() here and let RT substitute
it with a "sleeping" PI lock?

> If I don't protect the data structure by spinlcok, the data
> structures will corrupt. If I put it, rt_spin_lock function will cause
> a kernel dump.

And how about posting that kernel dump, so we have at least an idea
what's going on?

> Of course, I can use raw_spin_lock_irqsave() instead.

You can, but this will cause other failures.

> But for the case like USB stack and SATA stack, if I disable the
> interrupt just like what I did for ata_qc_issue(). It seems not very
> good idea.

Definitely not. I told you already that disabling interrupts around
ata_qc_issue() is completely wrong. Why do you insist on your claims
that ATA and USB is broken on RT? It's not broken. Your drivers are
doing something really wrong.
  
> Is there any rule to resolve such conflict?

Sure. Run your driver on a non-RT patched kernel, turn on the
following debug options:

 - CONFIG_DEBUG_RT_MUTEXES
 - CONFIG_DEBUG_SPINLOCK
 - CONFIG_DEBUG_MUTEXES
 - CONFIG_DEBUG_LOCK_ALLOC
 - CONFIG_PROVE_LOCKING
 - CONFIG_DEBUG_SPINLOCK_SLEEP
 - CONFIG_DEBUG_PREEMPT

If these debug mechanisms cannot find an issue with your driver, then
it should work out of the box with RT. If they find an issue, then you
better fix it before even thinking about using RT.

If all issues are resolved, move over to RT and enable the same debug
options. Run your code and if it still explodes, post code and kernel
dump so we can have a look instead of having this completely pointless
discussion over and over.

Thanks,

	tglx


