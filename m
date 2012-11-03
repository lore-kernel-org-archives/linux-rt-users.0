From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH RFC] irq: Honor /proc/irq core affinity when an IRQ thread
 is created
Date: Sat, 3 Nov 2012 11:50:28 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1211031132460.2756@ionos>
References: <CAFQPvXe0siyupbZvnEVFQi-nog4qObGejX9HxgxeVgOphJoyTA@mail.gmail.com> <alpine.LFD.2.02.1209041738200.2754@ionos> <CAFQPvXdrxEpD-LSnsZGE-s7JVHWJz5qOP=ZPiwB+UC5nXAm5Dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Sankara Muthukrishnan <sankara.m@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:40280 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750846Ab2KCKub (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 3 Nov 2012 06:50:31 -0400
In-Reply-To: <CAFQPvXdrxEpD-LSnsZGE-s7JVHWJz5qOP=ZPiwB+UC5nXAm5Dw@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 5 Sep 2012, Sankara Muthukrishnan wrote:
> On Tue, Sep 4, 2012 at 10:43 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > Does the following patch fix the problem for both shared and non
> > shared interrupts ?
> 
> Thanks Thomas. Your suggestion works for non-shared. I do not have
> devices sharing interrupts on my board to quickly verify. However, I
> hacked a kernel module to simulate shared irq's and the kernel source
> (to set the affinity before waiting for interrupts in the irq thread)
> and verified that it works for "shared interrupts" also.
> 
> However, I was wondering whether we are relaxing some checks that
> setup_affinity does (like checking for flags such as
> IRQD_NO_BALANCING) by setting the flag IRQTF_AFFINITY after creating
> the kernel thread directly as you suggested. May be, it does not have
> practical implications. But, I was wondering whether it is a good idea
> to go through all the checks as the checks are done when someone
> writes to /proc/irq/.../smp_affinity file for consistency. Is the
> following patch a bad idea (basically call setup_affinity for both
> shared and non-shared interrupts)? This also works in my testing. I am
> curious why "setup_affinity" was called only under "if (!shared)" case
> in the released kernel.

The reason is that it is sufficient to do that for the first interrupt
which gets set up. If another interrupt handler gets registered in the
shared case then its pointless to call setup_affinity() as everything
is already in place. The only thing which does not follow is the
shared thread.

So now for the IRQTF_AFFINITY flag. We really want to set that
unconditionally so all irq threads even if the NO_BALANCING flag is
set move to the cpu(s) on which the interrupt is assigned
to. NO_BALANCING is just making sure that the user space irq balancer
cannot move around the interrupt, but it still has an affinity
assigned.

Thanks,

	tglx


