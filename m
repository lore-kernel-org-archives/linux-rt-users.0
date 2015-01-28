From: Luiz Capitulino <lcapitulino@redhat.com>
Subject: Re: kernel-rt rcuc lock contention problem
Date: Wed, 28 Jan 2015 09:18:36 -0500
Message-ID: <20150128091836.647d0eee@redhat.com>
References: <20150126141403.469dc92f@redhat.com>
	<20150127203752.GD19109@linux.vnet.ibm.com>
	<20150128015508.GA12233@amt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	linux-rt-users@vger.kernel.org
To: Marcelo Tosatti <mtosatti@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:10624 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759522AbbA1Uk3 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 28 Jan 2015 15:40:29 -0500
In-Reply-To: <20150128015508.GA12233@amt.cnet>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 27 Jan 2015 23:55:08 -0200
Marcelo Tosatti <mtosatti@redhat.com> wrote:

> On Tue, Jan 27, 2015 at 12:37:52PM -0800, Paul E. McKenney wrote:
> > On Mon, Jan 26, 2015 at 02:14:03PM -0500, Luiz Capitulino wrote:
> > > Paul,
> > > 
> > > We're running some measurements with cyclictest running inside a
> > > KVM guest where we could observe spinlock contention among rcuc
> > > threads.
> > > 
> > > Basically, we have a 16-CPU NUMA machine very well setup for RT.
> > > This machine and the guest run the RT kernel. As our test-case
> > > requires an application in the guest taking 100% of the CPU, the
> > > RT priority configuration that gives the best latency is this one:
> > > 
> > >  263  FF   3  [rcuc/15]
> > >   13  FF   3  [rcub/1]
> > >   12  FF   3  [rcub/0]
> > >  265  FF   2  [ksoftirqd/15]
> > > 3181  FF   1  qemu-kvm
> > > 
> > > In this configuration, the rcuc can preempt the guest's vcpu
> > > thread. This shouldn't be a problem, except for the fact that
> > > we're seeing that in some cases the rcuc/15 thread spends 10us
> > > or more spinning in this spinlock (note that IRQs are disabled
> > > during this period):
> > > 
> > > __rcu_process_callbacks()
> > > {
> > > ...
> > > 	local_irq_save(flags);
> > > 	if (cpu_needs_another_gp(rsp, rdp)) {
> > > 		raw_spin_lock(&rcu_get_root(rsp)->lock); /* irqs disabled. */
> > > 		rcu_start_gp(rsp);
> > > 		raw_spin_unlock_irqrestore(&rcu_get_root(rsp)->lock, flags);
> > > ...
> > 
> > Life can be hard when irq-disabled spinlocks can be preempted!  But how
> > often does this happen?  

I have to run cyclictest in the guest for 16m a few times to reproduce it.

> > Also, does this happen on smaller systems, for
> > example, with four or eight CPUs?  

Didn't test.

> > And I confess to be a bit surprised
> > that you expect real-time response from a guest that is subject to
> > preemption -- as I understand it, the usual approach is to give RT guests
> > their own CPUs.
> > 
> > Or am I missing something?
> 
> We are trying to avoid relying on the guest VCPU to voluntarily yield
> the CPU therefore allowing the critical services (such as rcu callback 
> processing and sched tick processing) to execute.

Yes. I hope I won't regret saying this, but what I'm observing is that
preempting-off the vcpu is not the end of the world as long as you're
quick.

> > > We've tried playing with the rcu_nocbs= option. However, it
> > > did not help because, for reasons we don't understand, the rcuc
> > > threads have to handle grace period start even when callback
> > > offloading is used. Handling this case requires this code path
> > > to be executed.
> > 
> > Yep.  The rcu_nocbs= option offloads invocation of RCU callbacks, but not
> > the per-CPU work required to inform RCU of quiescent states.
> 
> Can't you execute that on vCPU entry/exit? Those are quiescent states
> after all.
> 
> > > We've cooked the following extremely dirty patch, just to see
> > > what would happen:
> > > 
> > > diff --git a/kernel/rcutree.c b/kernel/rcutree.c
> > > index eaed1ef..c0771cc 100644
> > > --- a/kernel/rcutree.c
> > > +++ b/kernel/rcutree.c
> > > @@ -2298,9 +2298,19 @@ __rcu_process_callbacks(struct rcu_state *rsp)
> > >  	/* Does this CPU require a not-yet-started grace period? */
> > >  	local_irq_save(flags);
> > >  	if (cpu_needs_another_gp(rsp, rdp)) {
> > > -		raw_spin_lock(&rcu_get_root(rsp)->lock); /* irqs disabled. */
> > > -		rcu_start_gp(rsp);
> > > -		raw_spin_unlock_irqrestore(&rcu_get_root(rsp)->lock, flags);
> > > +		for (;;) {
> > > +			if (!raw_spin_trylock(&rcu_get_root(rsp)->lock)) {
> > > +				local_irq_restore(flags);
> > > +				local_bh_enable();
> > > +				schedule_timeout_interruptible(2);
> > 
> > Yes, the above will get you a splat in mainline kernels, which do not
> > necessarily push softirq processing to the ksoftirqd kthreads.  ;-)
> > 
> > > +				local_bh_disable();
> > > +				local_irq_save(flags);
> > > +				continue;
> > > +			}
> > > +			rcu_start_gp(rsp);
> > > +			raw_spin_unlock_irqrestore(&rcu_get_root(rsp)->lock, flags);
> > > +			break;
> > > +		}
> > >  	} else {
> > >  		local_irq_restore(flags);
> > >  	}
> > > 
> > > With this patch rcuc is gone from our traces and the scheduling
> > > latency is reduced by 3us in our CPU-bound test-case.
> > > 
> > > Could you please advice on how to solve this contention problem?
> > 
> > The usual advice would be to configure the system such that the guest's
> > VCPUs do not get preempted.
> 
> The guest vcpus can consume 100% of CPU time (imagine a guest vcpu busy
> spinning). In that case, rcuc would never execute, because it has a 
> lower priority than guest VCPUs.
> 
> I do not think we want that.
> 
> > Or is the contention on the root rcu_node structure's ->lock field
> > high for some other reason?

I didn't go far on trying to determine the reason. What I observed
was the rcuc preempting-off the vcpu and taking 10us+. I debugged it
and most of this time it spends spinning on the spinlock. The patch
above makes the rcuc disappear from our traces. This is all I've got.
I could try to debug it further if you have suggestions on how to
trace the cause.

> 
> Luiz?
> 
> > > Can we test whether the local CPU is nocb, and in that case, 
> > > skip rcu_start_gp entirely for example?
> > 
> > If you do that, you can see system hangs due to needed grace periods never
> > getting started.
> 
> So it is not enough for CB CPUs to execute rcu_start_gp. Why is it
> necessary for nocb CPUs to execute rcu_start_gp?
> 
> > Are you using the default value of 16 for CONFIG_RCU_FANOUT_LEAF?
> > If you are using a smaller value, it would be possible to rework the
> > code to reduce contention on ->lock, though if a VCPU does get preempted
> > while holding the root rcu_node structure's ->lock, life will be hard.
> 
> Its a raw spinlock, isnt it?
> 

