From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH][RT]: handle_IRQ_event() - fix thinko
Date: Sat, 27 Sep 2008 11:41:53 +0200 (CEST)
Message-ID: <alpine.LFD.1.10.0809271139340.27026@apollo.tec.linutronix.de>
References: <20080923101052.16574a0f@bull.net> <alpine.LFD.1.10.0809241744110.4413@apollo.tec.linutronix.de> <20080925114040.25ca8aa7@bull.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linux-rt <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jean Pierre Dion <jean-pierre.dion@bull.net>,
	Gilles Carry <Gilles.Carry@ext.bull.net>
To: Sebastien Dugue <sebastien.dugue@bull.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:35793 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751748AbYI0Jmz (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 27 Sep 2008 05:42:55 -0400
In-Reply-To: <20080925114040.25ca8aa7@bull.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 25 Sep 2008, Sebastien Dugue wrote:
> On Wed, 24 Sep 2008 17:45:36 +0200 (CEST) Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > On Tue, 23 Sep 2008, Sebastien Dugue wrote:
> > 
> > > 
> > >   handle_IRQ_event() reenables interrupts for threaded IRQ handlers,
> > > provided said handler does not need to run with IRQF_DISABLED.
> > > 
> > >   Therefore, unless I'm missing something, in the following:
> > > 
> > > if (!hardirq_count() || !(action->flags & IRQF_DISABLED))
> > > 	local_irq_enable();
> > > 
> > >   the logical OR should be a logical AND:
> > > 
> > > if (!hardirq_count() && !(action->flags & IRQF_DISABLED))
> > > 	local_irq_enable();
> > 
> > No. We don't want to run the threaded handler with interrupts disabled.
> > 
> > !hardirq_count() tells us that we are in thread context.
> 
>   OK, but then if a driver asked to run with IRQ disabled it will not
> be honored with threaded hardirq.

Err, no. We switch all interrupts (except timer) to threaded with
PREEMPT_RT=y. And we simply keep interrupts enabled across the thread
the same way as we ignore the interrupt disable/enable of the
spinlock_irqXX functions when we switch them to sleeping rt_mutex
based locks.

Thanks,

	tglx
