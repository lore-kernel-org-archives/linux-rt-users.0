From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC -rt] updated synchronize_all_irqs implementation
Date: Tue, 25 Sep 2007 16:02:45 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0709251601240.14583@gandalf.stny.rr.com>
References: <20070921054656.GA11708@linux.vnet.ibm.com>
 <20070923173432.GA10542@linux.vnet.ibm.com> <Pine.LNX.4.58.0709251317080.5676@gandalf.stny.rr.com>
 <20070925193454.GH8432@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org, mingo@elte.hu, tglx@linutronix.de,
	dvhltc@us.ibm.com, tytso@us.ibm.com, a.p.zijlstra@chello.nl,
	dmitry.torokhov@gmail.com, akpm@linux-foundation.org,
	nickpiggin@yahoo.com.au
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-05.nyroc.rr.com ([24.24.2.59]:32796 "EHLO
	ms-smtp-05.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754088AbXIYUD5 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 25 Sep 2007 16:03:57 -0400
In-Reply-To: <20070925193454.GH8432@linux.vnet.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


--
> > > +void synchronize_all_irqs(void)
> > > +{
> > > +	if (hardirq_preemption)
> > > +		synchronize_rcu();	/* wait for threaded irq handlers. */
> > > +	synchronize_sched();		/* wait for hardware irq handlers. */
> >
> > I don't undrestand the synchronize_sched part above. How does that wait
> > for all hardware irq handlers? Wouldn't the synchronize_rcu be sufficient?
>
> In practice, given the current implementations of RCU, agreed.  However,
> an RCU implementation would be within its rights to return immediately
> from synchronize_rcu() if it could somehow deduce that there happened
> to be no RCU read-side critical sections in progress at that moment.
> This could leave hardware interrupt handlers still running on other CPUs.
>
> In fact, the QRCU implementation (http://lkml.org/lkml/2007/2/25/18)
> is an example RCU implementation that is capable of returning from
> synchronize_qrcu() extremely quickly if there are no QRCU readers (a
> few tens of nanoseconds on a recent x86-64 box).  Hardware irq handlers
> could easily be running for much longer (like if they take even a single
> cache miss).
>
> That said, having serialized delay that is almost never necessary is
> not such a good thing.  One thing I could do would be to open-code
> synchronize_rcu() in synchronize_all_irqs(), so that the delays for RCU
> and for synchronize_sched() happened in parallel.  Something like:
>
> 	void synchronize_all_irqs(void)
> 	{
> 		struct rcu_synchronize rcu;
>
> 		if (hardirq_preemption) {
> 			init_completion(&rcu.completion);
> 			/* Will wake me after RCU finished */
> 			call_rcu(&rcu.head, wakeme_after_rcu);
> 		}
>
> 		/* wait for hardware irq handlers. */
>
> 		synchronize_sched();
>
> 		/* wait for threaded irq handlers. */
>
> 		if (hardirq_preemption)
> 			wait_for_completion(&rcu.completion);
>
> 	}
>
> This would of course require that synchronize_all_irqs() be in the
> RCU code rather than the irq code so that it could access the static
> wakeme_after_rcu() definition and the rcu_synchronize structure.
>
> Thoughts?
>

I do like this better. Anyone else care to comment?

-- Steve
