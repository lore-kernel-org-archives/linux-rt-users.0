From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Protection of critical section in PREEMPT_RT
Date: Wed, 13 Feb 2013 12:31:42 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1302131228320.11905@ionos>
References: <CAHX1yNTSObcxNrvsBnPw8QzUWTb4zzs_faZZ1bbGU1L8xzgpsQ@mail.gmail.com> <50FE68EF.8060909@meduna.org> <CAHX1yNTKw8vr2v01Eft1tVV5YrP-7Zw=3fk9iF6YJYfbnBJ9LQ@mail.gmail.com> <510ACB87.3080007@am.sony.com> <CAHX1yNQgJXM292q1DWXLdQiR_BK5jZ-d+QHVoEEgksQm04YU6g@mail.gmail.com>
 <alpine.LFD.2.02.1302041138400.11905@ionos> <CAHX1yNTb92NMAi+9F0QCXqyvwEmerGOar5t4J1tLGznF2jD8Tg@mail.gmail.com> <alpine.LFD.2.02.1302051048170.11905@ionos> <CAHX1yNSCba2wc7A2UOfdyzZ9z-YTYp+p16s8kHcA0e+r9sy+BQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: frank.rowand@am.sony.com, Stanislav Meduna <stano@meduna.org>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Jacky Lam <lamshuyin@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:58215 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933658Ab3BMLbs (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 13 Feb 2013 06:31:48 -0500
In-Reply-To: <CAHX1yNSCba2wc7A2UOfdyzZ9z-YTYp+p16s8kHcA0e+r9sy+BQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Jacky,

On Wed, 6 Feb 2013, Jacky Lam wrote:
> On Tue, Feb 5, 2013 at 6:05 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > If all issues are resolved, move over to RT and enable the same debug
> > options. Run your code and if it still explodes, post code and kernel
> > dump so we can have a look instead of having this completely pointless
> > discussion over and over.
> >
> 
> I try to make an example to show the problem. Our hardware  use
> indirect method to access the SATA/USB controller internal registers,
> i.e CPU has a SATA/USB IO Addr register and a DATA register. In order
> to read from controller's internal register, I need to put the offset
> into IO Addr register and then read from the IO Data register. As this
> process cannot be interrupted, I need to put a spin_lock_irqsave to
> protect the code.

Right. That's the usual way to solve this.
 
> When driver code is reading the controller's registers and interrupt
> comes, interrupt handler (not the interrupt thread) need to clear the
> interrupt source first and return IRQ_WAKE_THREAD to wait for
> interrupt thread to actually handle the interrupt task. But in order
> to clear the interrupt source, I need to access the controller's
> internal registers. This is the problem I have now.

Do I understand you correct, that you use a threaded interrupt handler
already in the driver?

If yes, then RT is of course not force threading your primary
handler. In that case the protection of the indirect HW access must
use a raw_spinlock not a spinlock.

Thanks,

	tglx

 
