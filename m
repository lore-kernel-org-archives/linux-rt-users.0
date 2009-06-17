From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Setting the priority of an IRQ thread
Date: Wed, 17 Jun 2009 07:38:54 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.0906170728580.2800@localhost.localdomain>
References: <loom.20090615T222836-377@post.gmane.org> <000001c9ee36$218cf3a0$a852c70a@dlh.st.com> <loom.20090616T074347-549@post.gmane.org> <20090616182734.GD13048@pengutronix.de> <alpine.LFD.2.00.0906170025080.2800@localhost.localdomain>
 <Pine.LNX.4.64.0906162009280.9500@goblin.caltech.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>, linux-rt-users@vger.kernel.org
To: Martin Shepherd <mcs@astro.caltech.edu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:42076 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751547AbZFQFjG (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 17 Jun 2009 01:39:06 -0400
In-Reply-To: <Pine.LNX.4.64.0906162009280.9500@goblin.caltech.edu>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 16 Jun 2009, Martin Shepherd wrote:
> #ifdef CONFIG_PREEMPT_HARDIRQS
> 
> int set_irq_thread_prio(unsigned int irq, int prio)
> {
>         struct irq_desc *desc = irq_to_desc(irq);
>         struct sched_param param = { 0, };
>         int status;
> 
>         param.sched_priority = prio;
> 
>         if(desc) {
>                 read_lock(&tasklist_lock);
>                 if(desc->thread)

That's racy. desc->thread can go away between the check and the
call. That needs locking of desc->lock, but that might have other
implications. Need to have a closer look at the semantics.

>                         status = sched_setscheduler(desc->thread, SCHED_FIFO,
>                                                     &param);
>                 else
>                         status = -ENODEV;
>                 read_unlock(&tasklist_lock);
>         } else {
>                 status = -ENODEV;
>         }
>         return status;
> }
> 
> EXPORT_SYMBOL(set_irq_thread_prio);

EXPORT_SYMBOL_GPL if any.

OTOH, I think that as I said in the other reply already that none of
this magic is really necessary. We need some sysfs based information
of the thread id in addition to the irq nr which is already
there. Then you can just use sched_setscheduler(2) or chrt(1) from user
space. You can do this already, the irq information in sysfs is
already there you just have to decode output of ps(1) to find the IRQ
thread.

Thanks,

	tglx
