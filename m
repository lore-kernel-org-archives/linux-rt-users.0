From: Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: kernel-rt rcuc lock contention problem
Date: Mon, 2 Feb 2015 16:24:50 -0200
Message-ID: <20150202182450.GA9526@amt.cnet>
References: <20150126141403.469dc92f@redhat.com>
 <20150127203752.GD19109@linux.vnet.ibm.com>
 <20150128015508.GA12233@amt.cnet>
 <20150128180335.GR19109@linux.vnet.ibm.com>
 <20150128182512.GB1259@amt.cnet>
 <20150128185552.GT19109@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Luiz Capitulino <lcapitulino@redhat.com>,
	linux-rt-users@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Steven Rostedt <srostedt@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55521 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754234AbbBBSZQ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 2 Feb 2015 13:25:16 -0500
Content-Disposition: inline
In-Reply-To: <20150128185552.GT19109@linux.vnet.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Jan 28, 2015 at 10:55:53AM -0800, Paul E. McKenney wrote:
> On Wed, Jan 28, 2015 at 04:25:12PM -0200, Marcelo Tosatti wrote:
> > On Wed, Jan 28, 2015 at 10:03:35AM -0800, Paul E. McKenney wrote:
> > > On Tue, Jan 27, 2015 at 11:55:08PM -0200, Marcelo Tosatti wrote:
> > > > On Tue, Jan 27, 2015 at 12:37:52PM -0800, Paul E. McKenney wrote:
> > > > > On Mon, Jan 26, 2015 at 02:14:03PM -0500, Luiz Capitulino wrote:
> > > > > > Paul,
> > > > > > 
> > > > > > We're running some measurements with cyclictest running inside a
> > > > > > KVM guest where we could observe spinlock contention among rcuc
> > > > > > threads.
> > > > > > 
> > > > > > Basically, we have a 16-CPU NUMA machine very well setup for RT.
> > > > > > This machine and the guest run the RT kernel. As our test-case
> > > > > > requires an application in the guest taking 100% of the CPU, the
> > > > > > RT priority configuration that gives the best latency is this one:
> > > > > > 
> > > > > >  263  FF   3  [rcuc/15]
> > > > > >   13  FF   3  [rcub/1]
> > > > > >   12  FF   3  [rcub/0]
> > > > > >  265  FF   2  [ksoftirqd/15]
> > > > > > 3181  FF   1  qemu-kvm
> > > > > > 
> > > > > > In this configuration, the rcuc can preempt the guest's vcpu
> > > > > > thread. This shouldn't be a problem, except for the fact that
> > > > > > we're seeing that in some cases the rcuc/15 thread spends 10us
> > > > > > or more spinning in this spinlock (note that IRQs are disabled
> > > > > > during this period):
> > > > > > 
> > > > > > __rcu_process_callbacks()
> > > > > > {
> > > > > > ...
> > > > > > 	local_irq_save(flags);
> > > > > > 	if (cpu_needs_another_gp(rsp, rdp)) {
> > > > > > 		raw_spin_lock(&rcu_get_root(rsp)->lock); /* irqs disabled. */
> > > > > > 		rcu_start_gp(rsp);
> > > > > > 		raw_spin_unlock_irqrestore(&rcu_get_root(rsp)->lock, flags);
> > > > > > ...
> > > > > 
> > > > > Life can be hard when irq-disabled spinlocks can be preempted!  But how
> > > > > often does this happen?  Also, does this happen on smaller systems, for
> > > > > example, with four or eight CPUs?  And I confess to be a bit surprised
> > > > > that you expect real-time response from a guest that is subject to
> > > > > preemption -- as I understand it, the usual approach is to give RT guests
> > > > > their own CPUs.
> > > > > 
> > > > > Or am I missing something?
> > > > 
> > > > We are trying to avoid relying on the guest VCPU to voluntarily yield
> > > > the CPU therefore allowing the critical services (such as rcu callback 
> > > > processing and sched tick processing) to execute.
> > > 
> > > These critical services executing in the context of the host?
> > > (If not, I am confused.  Actually, I am confused either way...)
> > 
> > The host. Imagine a Windows 95 guest running a realtime app.
> > That should help.
> 
> Then force the critical services to run on a housekeeping CPU.  If the
> host is permitted to preempt the guest, the latency blows you are seeing
> are expected behavior.
> 
> > > > > > We've tried playing with the rcu_nocbs= option. However, it
> > > > > > did not help because, for reasons we don't understand, the rcuc
> > > > > > threads have to handle grace period start even when callback
> > > > > > offloading is used. Handling this case requires this code path
> > > > > > to be executed.
> > > > > 
> > > > > Yep.  The rcu_nocbs= option offloads invocation of RCU callbacks, but not
> > > > > the per-CPU work required to inform RCU of quiescent states.
> > > > 
> > > > Can't you execute that on vCPU entry/exit? Those are quiescent states
> > > > after all.
> > > 
> > > I am guessing that we are talking about quiescent states in the guest.
> > 
> > Host.
> > 
> > > If so, can't vCPU entry/exit operations happen in guest interrupt
> > > handlers?  If so, these operations are not necessarily quiescent states.
> > 
> > vCPU entry/exit are quiescent states in the host.
> 
> As is execution in the guest.  If you build the host with NO_HZ_FULL
> and boot with the appropriate nohz_full= parameter, this will happen
> automatically.  If that is infeasible, then yes, it should be possible
> to add an explicit quiescent state in the host at vCPU entry/exit, at
> least assuming that the host is in a state permitting this.
> 
> > > > > > We've cooked the following extremely dirty patch, just to see
> > > > > > what would happen:
> > > > > > 
> > > > > > diff --git a/kernel/rcutree.c b/kernel/rcutree.c
> > > > > > index eaed1ef..c0771cc 100644
> > > > > > --- a/kernel/rcutree.c
> > > > > > +++ b/kernel/rcutree.c
> > > > > > @@ -2298,9 +2298,19 @@ __rcu_process_callbacks(struct rcu_state *rsp)
> > > > > >  	/* Does this CPU require a not-yet-started grace period? */
> > > > > >  	local_irq_save(flags);
> > > > > >  	if (cpu_needs_another_gp(rsp, rdp)) {
> > > > > > -		raw_spin_lock(&rcu_get_root(rsp)->lock); /* irqs disabled. */
> > > > > > -		rcu_start_gp(rsp);
> > > > > > -		raw_spin_unlock_irqrestore(&rcu_get_root(rsp)->lock, flags);
> > > > > > +		for (;;) {
> > > > > > +			if (!raw_spin_trylock(&rcu_get_root(rsp)->lock)) {
> > > > > > +				local_irq_restore(flags);
> > > > > > +				local_bh_enable();
> > > > > > +				schedule_timeout_interruptible(2);
> > > > > 
> > > > > Yes, the above will get you a splat in mainline kernels, which do not
> > > > > necessarily push softirq processing to the ksoftirqd kthreads.  ;-)
> > > > > 
> > > > > > +				local_bh_disable();
> > > > > > +				local_irq_save(flags);
> > > > > > +				continue;
> > > > > > +			}
> > > > > > +			rcu_start_gp(rsp);
> > > > > > +			raw_spin_unlock_irqrestore(&rcu_get_root(rsp)->lock, flags);
> > > > > > +			break;
> > > > > > +		}
> > > > > >  	} else {
> > > > > >  		local_irq_restore(flags);
> > > > > >  	}
> > > > > > 
> > > > > > With this patch rcuc is gone from our traces and the scheduling
> > > > > > latency is reduced by 3us in our CPU-bound test-case.
> > > > > > 
> > > > > > Could you please advice on how to solve this contention problem?
> > > > > 
> > > > > The usual advice would be to configure the system such that the guest's
> > > > > VCPUs do not get preempted.
> > > > 
> > > > The guest vcpus can consume 100% of CPU time (imagine a guest vcpu busy
> > > > spinning). In that case, rcuc would never execute, because it has a 
> > > > lower priority than guest VCPUs.
> > > 
> > > OK, this leads me to believe that you are talking about the rcuc kthreads
> > > in the host, not the guest.  In which case the usual approach is to
> > > reserve a CPU or two on the host which never runs guest VCPUs, and to
> > > force the rcuc kthreads there.  Note that CONFIG_NO_HZ_FULL will do this
> > > automatically for you, reserving the boot CPU.  And CONFIG_NO_HZ_FULL
> > > might well be very useful in this scenario.  And reserving a CPU or two
> > > for housekeeping purposes is quite common for heavy CPU-bound workloads.
> > > 
> > > Of course, you need to make sure that the reserved CPU or two is sufficient
> > > for all the rcuc kthreads, but if your guests are mostly CPU bound, this
> > > should not be a problem.
> > > 
> > > > I do not think we want that.
> > > 
> > > Assuming "that" is "rcuc would never execute" -- agreed, that would be
> > > very bad.  You would eventually OOM the system.
> > > 
> > > > > Or is the contention on the root rcu_node structure's ->lock field
> > > > > high for some other reason?
> > > > 
> > > > Luiz?
> > > > 
> > > > > > Can we test whether the local CPU is nocb, and in that case, 
> > > > > > skip rcu_start_gp entirely for example?
> > > > > 
> > > > > If you do that, you can see system hangs due to needed grace periods never
> > > > > getting started.
> > > > 
> > > > So it is not enough for CB CPUs to execute rcu_start_gp. Why is it
> > > > necessary for nocb CPUs to execute rcu_start_gp?
> > > 
> > > Sigh.  Are we in the host or the guest OS at this point?
> > 
> > Host.
> 
> Can you build the host with NO_HZ_FULL and boot with nohz_full=?
> That should get rid of of much of your problems here.
> 
> > > In any case, if you want the best real-time response for a CPU-bound
> > > workload on a given CPU, careful use of NO_HZ_FULL would prevent
> > > that CPU from ever invoking __rcu_process_callbacks() in the first
> > > place, which would have the beneficial side effect of preventing
> > > __rcu_process_callbacks() from ever invoking rcu_start_gp().
> > > 
> > > Of course, NO_HZ_FULL does have the drawback of increasing the cost
> > > of user-kernel transitions.
> > 
> > We need periodic processing of __run_timers to keep timer wheel
> > processing from falling behind too much.
> > 
> > See http://www.gossamer-threads.com/lists/linux/kernel/2094151.
> 
> Hmmm...  Do you have the following commits in your build?
> 
> fff421580f51 timers: Track total number of timers in list
> d550e81dc0dd timers: Reduce __run_timers() latency for empty list
> 16d937f88031 timers: Reduce future __run_timers() latency for newly emptied list
> 18d8cb64c9c0 timers: Reduce future __run_timers() latency for first add to empty list
> aea369b959be timers: Make internal_add_timer() update ->next_timer if ->active_timers == 0
> 
> Keeping extraneous processing off of the CPUs running the real-time
> guest will minimize the number of timers, allowing these commits to
> do their jobs.

Steven,

The second commit, d550e81dc0dd should be part of -RT, and currently is
not, because:

-> Any IRQ work item will raise timer softirq.
-> __run_timers will do a full round of processing,
ruining latency.

Even without any timer pending on the timer wheel.

And about NO_HZ_FULL and -RT, is it correct that NO_HZ_FULL
renders

commit 1a2de830b90e364c3bf95e0000173bffcb65ddb7
Author: Steven Rostedt <rostedt@goodmis.org>
Date:   Fri Jan 31 12:07:57 2014 -0500

    timer/rt: Always raise the softirq if there's irq_work to be done

Inactive? Should raise softirq from irq_work_queue directly?

