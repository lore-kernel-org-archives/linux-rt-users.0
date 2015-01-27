From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: kernel-rt rcuc lock contention problem
Date: Tue, 27 Jan 2015 12:37:52 -0800
Message-ID: <20150127203752.GD19109@linux.vnet.ibm.com>
References: <20150126141403.469dc92f@redhat.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org,
	Marcelo Tosatti <mtosatti@redhat.com>
To: Luiz Capitulino <lcapitulino@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:39793 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932613AbbA0Uh6 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 27 Jan 2015 15:37:58 -0500
Received: from /spool/local
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-rt-users@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Tue, 27 Jan 2015 13:37:57 -0700
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
	by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 7797A1FF001F
	for <linux-rt-users@vger.kernel.org>; Tue, 27 Jan 2015 13:29:06 -0700 (MST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t0RKc3cN36896980
	for <linux-rt-users@vger.kernel.org>; Tue, 27 Jan 2015 13:38:03 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t0RKbsaq009118
	for <linux-rt-users@vger.kernel.org>; Tue, 27 Jan 2015 13:37:54 -0700
Content-Disposition: inline
In-Reply-To: <20150126141403.469dc92f@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Jan 26, 2015 at 02:14:03PM -0500, Luiz Capitulino wrote:
> Paul,
> 
> We're running some measurements with cyclictest running inside a
> KVM guest where we could observe spinlock contention among rcuc
> threads.
> 
> Basically, we have a 16-CPU NUMA machine very well setup for RT.
> This machine and the guest run the RT kernel. As our test-case
> requires an application in the guest taking 100% of the CPU, the
> RT priority configuration that gives the best latency is this one:
> 
>  263  FF   3  [rcuc/15]
>   13  FF   3  [rcub/1]
>   12  FF   3  [rcub/0]
>  265  FF   2  [ksoftirqd/15]
> 3181  FF   1  qemu-kvm
> 
> In this configuration, the rcuc can preempt the guest's vcpu
> thread. This shouldn't be a problem, except for the fact that
> we're seeing that in some cases the rcuc/15 thread spends 10us
> or more spinning in this spinlock (note that IRQs are disabled
> during this period):
> 
> __rcu_process_callbacks()
> {
> ...
> 	local_irq_save(flags);
> 	if (cpu_needs_another_gp(rsp, rdp)) {
> 		raw_spin_lock(&rcu_get_root(rsp)->lock); /* irqs disabled. */
> 		rcu_start_gp(rsp);
> 		raw_spin_unlock_irqrestore(&rcu_get_root(rsp)->lock, flags);
> ...

Life can be hard when irq-disabled spinlocks can be preempted!  But how
often does this happen?  Also, does this happen on smaller systems, for
example, with four or eight CPUs?  And I confess to be a bit surprised
that you expect real-time response from a guest that is subject to
preemption -- as I understand it, the usual approach is to give RT guests
their own CPUs.

Or am I missing something?

> We've tried playing with the rcu_nocbs= option. However, it
> did not help because, for reasons we don't understand, the rcuc
> threads have to handle grace period start even when callback
> offloading is used. Handling this case requires this code path
> to be executed.

Yep.  The rcu_nocbs= option offloads invocation of RCU callbacks, but not
the per-CPU work required to inform RCU of quiescent states.

> We've cooked the following extremely dirty patch, just to see
> what would happen:
> 
> diff --git a/kernel/rcutree.c b/kernel/rcutree.c
> index eaed1ef..c0771cc 100644
> --- a/kernel/rcutree.c
> +++ b/kernel/rcutree.c
> @@ -2298,9 +2298,19 @@ __rcu_process_callbacks(struct rcu_state *rsp)
>  	/* Does this CPU require a not-yet-started grace period? */
>  	local_irq_save(flags);
>  	if (cpu_needs_another_gp(rsp, rdp)) {
> -		raw_spin_lock(&rcu_get_root(rsp)->lock); /* irqs disabled. */
> -		rcu_start_gp(rsp);
> -		raw_spin_unlock_irqrestore(&rcu_get_root(rsp)->lock, flags);
> +		for (;;) {
> +			if (!raw_spin_trylock(&rcu_get_root(rsp)->lock)) {
> +				local_irq_restore(flags);
> +				local_bh_enable();
> +				schedule_timeout_interruptible(2);

Yes, the above will get you a splat in mainline kernels, which do not
necessarily push softirq processing to the ksoftirqd kthreads.  ;-)

> +				local_bh_disable();
> +				local_irq_save(flags);
> +				continue;
> +			}
> +			rcu_start_gp(rsp);
> +			raw_spin_unlock_irqrestore(&rcu_get_root(rsp)->lock, flags);
> +			break;
> +		}
>  	} else {
>  		local_irq_restore(flags);
>  	}
> 
> With this patch rcuc is gone from our traces and the scheduling
> latency is reduced by 3us in our CPU-bound test-case.
> 
> Could you please advice on how to solve this contention problem?

The usual advice would be to configure the system such that the guest's
VCPUs do not get preempted.  Or is the contention on the root rcu_node
structure's ->lock field high for some other reason?

> Can we test whether the local CPU is nocb, and in that case, 
> skip rcu_start_gp entirely for example?

If you do that, you can see system hangs due to needed grace periods never
getting started.

Are you using the default value of 16 for CONFIG_RCU_FANOUT_LEAF?
If you are using a smaller value, it would be possible to rework the
code to reduce contention on ->lock, though if a VCPU does get preempted
while holding the root rcu_node structure's ->lock, life will be hard.

							Thanx, Paul

