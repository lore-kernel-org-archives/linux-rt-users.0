From: Thomas Pfaff <tpfaff@pcs.com>
Subject: Re: Setting the priority of an IRQ thread
Date: Wed, 17 Jun 2009 10:27:22 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0906171024250.6186@lxtpfaff.pcs.ditec.de>
References: <loom.20090615T222836-377@post.gmane.org>
 <000001c9ee36$218cf3a0$a852c70a@dlh.st.com> <loom.20090616T074347-549@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: Martin Shepherd <mcs@astro.caltech.edu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.pcs.de ([145.253.69.50]:58285 "EHLO mail.pcs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763478AbZFQIes (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 17 Jun 2009 04:34:48 -0400
In-Reply-To: <loom.20090616T074347-549@post.gmane.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Tue, 16 Jun 2009, Martin Shepherd wrote:

> Suresh Kumar SHUKLA <suresh.shukla <at> st.com> writes:
> > 	// get IRQ descriptor from IRQ, it contains pid
> > 	desc = &irq_desc[IRQ_BASIC_TIMER_3_1];
> 
> That's a very useful clue. I was thinking that I would have to walk the process
> tree to find the thread by name. Following up on this clue, it appears as though
> in kernel 2.6.29.4 I should be able to use desc=irq_to_desc(irq) to look up the
> IRQ descriptor, then use pid=get_task_pid(desc->thread), to get the PID of the
> IRQ thread, then use sys_sched_setscheduler(pid,...) to change its priority.
> I'll try that out in the morning.
> 

FYI, i use following code to set the interrupt thread prio on first interrupt 
and it works so far:

atomic_t first_irq;

static irqreturn_t irq_handler (int irq, void *devp)
{
#ifdef CONFIG_PREEMPT_HARDIRQS
	if (atomic_cmpxchg (&first_irq, 1, 0))
	{
		struct sched_param param = { .sched_priority = 55 };

		/* raise thread prio on first interrupt */
		sched_setscheduler(current, SCHED_FIFO, &param);
	}
#endif

	/* handle interrupt */

	return IRQ_RETVAL(IRQ_HANDLED);
}

static int init_irqhandler (void)
{
	request_irq (...);
	atomic_set (&dev->first_irq, 1);

	...
}

Thomas
