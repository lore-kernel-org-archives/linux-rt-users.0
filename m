From: Sebastien Dugue <sebastien.dugue@bull.net>
Subject: Re: [PATCH][RT]: handle_IRQ_event() - fix thinko
Date: Thu, 25 Sep 2008 11:40:40 +0200
Message-ID: <20080925114040.25ca8aa7@bull.net>
References: <20080923101052.16574a0f@bull.net>
	<alpine.LFD.1.10.0809241744110.4413@apollo.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Linux-rt <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jean Pierre Dion <jean-pierre.dion@bull.net>,
	Gilles Carry <Gilles.Carry@ext.bull.net>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:59054 "EHLO
	ecfrec.frec.bull.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752978AbYIYJmK (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 25 Sep 2008 05:42:10 -0400
In-Reply-To: <alpine.LFD.1.10.0809241744110.4413@apollo.tec.linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 24 Sep 2008 17:45:36 +0200 (CEST) Thomas Gleixner <tglx@linutronix.de> wrote:

> On Tue, 23 Sep 2008, Sebastien Dugue wrote:
> 
> > 
> >   handle_IRQ_event() reenables interrupts for threaded IRQ handlers,
> > provided said handler does not need to run with IRQF_DISABLED.
> > 
> >   Therefore, unless I'm missing something, in the following:
> > 
> > if (!hardirq_count() || !(action->flags & IRQF_DISABLED))
> > 	local_irq_enable();
> > 
> >   the logical OR should be a logical AND:
> > 
> > if (!hardirq_count() && !(action->flags & IRQF_DISABLED))
> > 	local_irq_enable();
> 
> No. We don't want to run the threaded handler with interrupts disabled.
> 
> !hardirq_count() tells us that we are in thread context.

  OK, but then if a driver asked to run with IRQ disabled it will not
be honored with threaded hardirq.


  Sebastien.
