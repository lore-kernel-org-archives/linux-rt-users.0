From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC -rt] updated synchronize_all_irqs implementation
Date: Tue, 25 Sep 2007 12:34:54 -0700
Message-ID: <20070925193454.GH8432@linux.vnet.ibm.com>
References: <20070921054656.GA11708@linux.vnet.ibm.com> <20070923173432.GA10542@linux.vnet.ibm.com> <Pine.LNX.4.58.0709251317080.5676@gandalf.stny.rr.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org, mingo@elte.hu, tglx@linutronix.de,
	dvhltc@us.ibm.com, tytso@us.ibm.com, a.p.zijlstra@chello.nl,
	dmitry.torokhov@gmail.com, akpm@linux-foundation.org,
	nickpiggin@yahoo.com.au
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e3.ny.us.ibm.com ([32.97.182.143]:39443 "EHLO e3.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752095AbXIYTfB (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 25 Sep 2007 15:35:01 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l8PJYun1026263
	for <linux-rt-users@vger.kernel.org>; Tue, 25 Sep 2007 15:34:56 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id l8PJYuNY560548
	for <linux-rt-users@vger.kernel.org>; Tue, 25 Sep 2007 15:34:56 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l8PJYt9I029518
	for <linux-rt-users@vger.kernel.org>; Tue, 25 Sep 2007 15:34:56 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0709251317080.5676@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, Sep 25, 2007 at 01:22:03PM -0400, Steven Rostedt wrote:
> 
> --
> >
> > Passes light testing (five rounds of kernbench) on an x86_64 box.
> >
> > Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > ---
> >
> >  include/linux/hardirq.h |    4 +++-
> >  kernel/irq/handle.c     |    2 ++
> >  kernel/irq/manage.c     |   25 +++++++++++++++++++++++++
> >  3 files changed, 30 insertions(+), 1 deletion(-)
> >
> > diff -urpNa -X dontdiff linux-2.6.23-rc4-rt1/include/linux/hardirq.h linux-2.6.23-rc4-rt1-sairq/include/linux/hardirq.h
> > --- linux-2.6.23-rc4-rt1/include/linux/hardirq.h	2007-09-20 17:34:52.000000000 -0700
> > +++ linux-2.6.23-rc4-rt1-sairq/include/linux/hardirq.h	2007-09-20 18:35:53.000000000 -0700
> > @@ -105,8 +105,10 @@
> >
> >  #ifdef CONFIG_SMP
> >  extern void synchronize_irq(unsigned int irq);
> > +extern void synchronize_all_irqs(void);
> >  #else
> > -# define synchronize_irq(irq)	barrier()
> > +# define synchronize_irq(irq)		barrier()
> > +# define synchronize_all_irqs(irq)	barrier()
> >  #endif
> >
> >  struct task_struct;
> > diff -urpNa -X dontdiff linux-2.6.23-rc4-rt1/kernel/irq/handle.c linux-2.6.23-rc4-rt1-sairq/kernel/irq/handle.c
> > --- linux-2.6.23-rc4-rt1/kernel/irq/handle.c	2007-09-20 17:34:51.000000000 -0700
> > +++ linux-2.6.23-rc4-rt1-sairq/kernel/irq/handle.c	2007-09-22 23:34:13.000000000 -0700
> > @@ -150,7 +150,9 @@ irqreturn_t handle_IRQ_event(unsigned in
> >  	do {
> >  		unsigned int preempt_count = preempt_count();
> >
> > +		rcu_read_lock();
> >  		ret = action->handler(irq, action->dev_id);
> > +		rcu_read_unlock();
> >  		if (preempt_count() != preempt_count) {
> >  			stop_trace();
> >  			print_symbol("BUG: unbalanced irq-handler preempt count in %s!\n", (unsigned long) action->handler);
> > diff -urpNa -X dontdiff linux-2.6.23-rc4-rt1/kernel/irq/manage.c linux-2.6.23-rc4-rt1-sairq/kernel/irq/manage.c
> > --- linux-2.6.23-rc4-rt1/kernel/irq/manage.c	2007-09-20 17:34:51.000000000 -0700
> > +++ linux-2.6.23-rc4-rt1-sairq/kernel/irq/manage.c	2007-09-22 23:34:15.000000000 -0700
> > @@ -45,6 +45,30 @@ void synchronize_irq(unsigned int irq)
> >  EXPORT_SYMBOL(synchronize_irq);
> >
> >  /**
> > + *	synchronize_all_irqs - wait for all pending IRQ handlers (on other CPUs)
> > + *
> > + *	This function waits for any pending IRQ handlers for this interrupt
> > + *	to complete before returning. If you use this function while
> > + *	holding a resource the IRQ handler may need you will deadlock.
> > + *	If you use this function from an IRQ handler, you will immediately
> > + *	self-deadlock.
> > + *
> > + *	Note that this function waits for -handlers-, not for pending
> > + *	interrupts, and most especially not for pending interrupts that
> > + *	have not yet been delivered to the CPU.  So if an interrupt
> > + *	handler was just about to start executing when this function was
> > + *	called, and if there are no other interrupt handlers executing,
> > + *	this function is within its rights to return immediately.
> > + */
> > +void synchronize_all_irqs(void)
> > +{
> > +	if (hardirq_preemption)
> > +		synchronize_rcu();	/* wait for threaded irq handlers. */
> > +	synchronize_sched();		/* wait for hardware irq handlers. */
> 
> I don't undrestand the synchronize_sched part above. How does that wait
> for all hardware irq handlers? Wouldn't the synchronize_rcu be sufficient?

In practice, given the current implementations of RCU, agreed.  However,
an RCU implementation would be within its rights to return immediately
from synchronize_rcu() if it could somehow deduce that there happened
to be no RCU read-side critical sections in progress at that moment.
This could leave hardware interrupt handlers still running on other CPUs.

In fact, the QRCU implementation (http://lkml.org/lkml/2007/2/25/18)
is an example RCU implementation that is capable of returning from
synchronize_qrcu() extremely quickly if there are no QRCU readers (a
few tens of nanoseconds on a recent x86-64 box).  Hardware irq handlers
could easily be running for much longer (like if they take even a single
cache miss).

That said, having serialized delay that is almost never necessary is
not such a good thing.  One thing I could do would be to open-code
synchronize_rcu() in synchronize_all_irqs(), so that the delays for RCU
and for synchronize_sched() happened in parallel.  Something like:

	void synchronize_all_irqs(void)
	{
		struct rcu_synchronize rcu;

		if (hardirq_preemption) {
			init_completion(&rcu.completion);
			/* Will wake me after RCU finished */
			call_rcu(&rcu.head, wakeme_after_rcu);
		}

		/* wait for hardware irq handlers. */

		synchronize_sched();

		/* wait for threaded irq handlers. */

		if (hardirq_preemption)
			wait_for_completion(&rcu.completion);

	}

This would of course require that synchronize_all_irqs() be in the
RCU code rather than the irq code so that it could access the static
wakeme_after_rcu() definition and the rcu_synchronize structure.

Thoughts?

						Thanx, Paul

> > +EXPORT_SYMBOL_GPL(synchronize_all_irqs);
> > +
> > +/**
> >   *	irq_can_set_affinity - Check if the affinity of a given irq can be set
> >   *	@irq:		Interrupt to check
> >   *
> > @@ -886,3 +910,4 @@ void __init early_init_hardirqs(void)
> >  	for (i = 0; i < NR_IRQS; i++)
> >  		init_waitqueue_head(&irq_desc[i].wait_for_handler);
> >  }
> > +
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> >
> -
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
