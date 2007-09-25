From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC -rt] updated synchronize_all_irqs implementation
Date: Tue, 25 Sep 2007 13:22:03 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0709251317080.5676@gandalf.stny.rr.com>
References: <20070921054656.GA11708@linux.vnet.ibm.com>
 <20070923173432.GA10542@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org, mingo@elte.hu, tglx@linutronix.de,
	dvhltc@us.ibm.com, tytso@us.ibm.com, a.p.zijlstra@chello.nl,
	dmitry.torokhov@gmail.com, akpm@linux-foundation.org,
	nickpiggin@yahoo.com.au
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:63420 "EHLO
	ms-smtp-02.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752044AbXIYRXh (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 25 Sep 2007 13:23:37 -0400
In-Reply-To: <20070923173432.GA10542@linux.vnet.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


--
>
> Passes light testing (five rounds of kernbench) on an x86_64 box.
>
> Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> ---
>
>  include/linux/hardirq.h |    4 +++-
>  kernel/irq/handle.c     |    2 ++
>  kernel/irq/manage.c     |   25 +++++++++++++++++++++++++
>  3 files changed, 30 insertions(+), 1 deletion(-)
>
> diff -urpNa -X dontdiff linux-2.6.23-rc4-rt1/include/linux/hardirq.h linux-2.6.23-rc4-rt1-sairq/include/linux/hardirq.h
> --- linux-2.6.23-rc4-rt1/include/linux/hardirq.h	2007-09-20 17:34:52.000000000 -0700
> +++ linux-2.6.23-rc4-rt1-sairq/include/linux/hardirq.h	2007-09-20 18:35:53.000000000 -0700
> @@ -105,8 +105,10 @@
>
>  #ifdef CONFIG_SMP
>  extern void synchronize_irq(unsigned int irq);
> +extern void synchronize_all_irqs(void);
>  #else
> -# define synchronize_irq(irq)	barrier()
> +# define synchronize_irq(irq)		barrier()
> +# define synchronize_all_irqs(irq)	barrier()
>  #endif
>
>  struct task_struct;
> diff -urpNa -X dontdiff linux-2.6.23-rc4-rt1/kernel/irq/handle.c linux-2.6.23-rc4-rt1-sairq/kernel/irq/handle.c
> --- linux-2.6.23-rc4-rt1/kernel/irq/handle.c	2007-09-20 17:34:51.000000000 -0700
> +++ linux-2.6.23-rc4-rt1-sairq/kernel/irq/handle.c	2007-09-22 23:34:13.000000000 -0700
> @@ -150,7 +150,9 @@ irqreturn_t handle_IRQ_event(unsigned in
>  	do {
>  		unsigned int preempt_count = preempt_count();
>
> +		rcu_read_lock();
>  		ret = action->handler(irq, action->dev_id);
> +		rcu_read_unlock();
>  		if (preempt_count() != preempt_count) {
>  			stop_trace();
>  			print_symbol("BUG: unbalanced irq-handler preempt count in %s!\n", (unsigned long) action->handler);
> diff -urpNa -X dontdiff linux-2.6.23-rc4-rt1/kernel/irq/manage.c linux-2.6.23-rc4-rt1-sairq/kernel/irq/manage.c
> --- linux-2.6.23-rc4-rt1/kernel/irq/manage.c	2007-09-20 17:34:51.000000000 -0700
> +++ linux-2.6.23-rc4-rt1-sairq/kernel/irq/manage.c	2007-09-22 23:34:15.000000000 -0700
> @@ -45,6 +45,30 @@ void synchronize_irq(unsigned int irq)
>  EXPORT_SYMBOL(synchronize_irq);
>
>  /**
> + *	synchronize_all_irqs - wait for all pending IRQ handlers (on other CPUs)
> + *
> + *	This function waits for any pending IRQ handlers for this interrupt
> + *	to complete before returning. If you use this function while
> + *	holding a resource the IRQ handler may need you will deadlock.
> + *	If you use this function from an IRQ handler, you will immediately
> + *	self-deadlock.
> + *
> + *	Note that this function waits for -handlers-, not for pending
> + *	interrupts, and most especially not for pending interrupts that
> + *	have not yet been delivered to the CPU.  So if an interrupt
> + *	handler was just about to start executing when this function was
> + *	called, and if there are no other interrupt handlers executing,
> + *	this function is within its rights to return immediately.
> + */
> +void synchronize_all_irqs(void)
> +{
> +	if (hardirq_preemption)
> +		synchronize_rcu();	/* wait for threaded irq handlers. */
> +	synchronize_sched();		/* wait for hardware irq handlers. */

I don't undrestand the synchronize_sched part above. How does that wait
for all hardware irq handlers? Wouldn't the synchronize_rcu be sufficient?

-- Steve

> +}
> +EXPORT_SYMBOL_GPL(synchronize_all_irqs);
> +
> +/**
>   *	irq_can_set_affinity - Check if the affinity of a given irq can be set
>   *	@irq:		Interrupt to check
>   *
> @@ -886,3 +910,4 @@ void __init early_init_hardirqs(void)
>  	for (i = 0; i < NR_IRQS; i++)
>  		init_waitqueue_head(&irq_desc[i].wait_for_handler);
>  }
> +
> -
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
