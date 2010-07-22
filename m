From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Trouble booting PREEMPT_RT kernel on ARM platform, 2.6.33
Date: Thu, 22 Jul 2010 18:44:44 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.1007221842000.2616@localhost.localdomain>
References: <AANLkTilabvtaFnJKo8RKOfgP98F2rre4YQ8BF-o-uz92@mail.gmail.com> <4C469FF9.1040607@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeremy Brown <jhbrown@repinvariant.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: gowrishankar <gowrishankar.m@linux.vnet.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:46437 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752057Ab0GVQow (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 22 Jul 2010 12:44:52 -0400
In-Reply-To: <4C469FF9.1040607@linux.vnet.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 21 Jul 2010, gowrishankar wrote:

> On Wednesday 21 July 2010 03:56 AM, Jeremy Brown wrote:
> > We're trying to get a PREEMPT_RT kernel running on a BeagleBoard C4
> > (OMAP3 Arm architecture).  We're using kernel version 2.6.33, with
> >    
> 2.6.33 ! not 2.6.33.6 ???
> > patches from
> > patch-2.6.33.6-rt26.gz
> > 
> > On boot, we start seeing messages of this form:
> > 
> > ----
> > [ 4528.227294] BUG: sleeping function called from invalid context at
> > kernel/rtmutex.c:684
> > [ 4528.227294] pcnt: 1 0 in_atomic(): 1, irqs_disabled(): 128, pid:
> > 223, name: modprobe
> > [ 4528.227355] [<c0044490>] (unwind_backtrace+0x0/0xe8) from
> > [<c04cb4e4>] (rt_spin_lock+0x30/0x5c)
> > [ 4528.227386] [<c04cb4e4>] (rt_spin_lock+0x30/0x5c) from [<c032e3b0>]
> > (twl4030_sih_set_type+0x3c/0xac)
> >    
> sleeping spin lock is called while preempt/interrupt is disabled.
> 
> Can you try the below patch ?
> 
> Signed-off-by: Gowrishankar <gowrishankar.m@in.ibm.com>
> 
> Index: linux-2.6.33.6-rt26/drivers/mfd/twl4030-irq.c
> ===================================================================
> --- linux-2.6.33.6-rt26.orig/drivers/mfd/twl4030-irq.c    2010-07-21
> 12:40:42.000000000 +0530
> +++ linux-2.6.33.6-rt26/drivers/mfd/twl4030-irq.c    2010-07-21
> 12:41:16.000000000 +0530
> @@ -633,14 +633,14 @@
>      if (trigger & ~(IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_EDGE_RISING))
>          return -EINVAL;
> 
> -    spin_lock_irqsave(&sih_agent_lock, flags);
> +    raw_spin_lock_irqsave(&sih_agent_lock, flags);
>      if ((desc->status & IRQ_TYPE_SENSE_MASK) != trigger) {
>          desc->status &= ~IRQ_TYPE_SENSE_MASK;
>          desc->status |= trigger;
>          sih->edge_change |= BIT(irq - sih->irq_base);
>          queue_work(wq, &sih->edge_work);
>      }
> -    spin_unlock_irqrestore(&sih_agent_lock, flags);
> +    raw_spin_unlock_irqrestore(&sih_agent_lock, flags);

Nope, that's not going to fly. First it does not compile and second
you trigger the same problem in queue_work() which is called inside
that section. That needs a bit more work, will have a look. (/me
mentions, that todo list is already overly full, so do not expect
wonders).

Thanks,

	tglx
