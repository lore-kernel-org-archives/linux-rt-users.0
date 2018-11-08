From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: srcu: use cpu_online() instead custom check
Date: Thu, 8 Nov 2018 09:10:24 -0800
Message-ID: <20181108171024.GM4170@linux.ibm.com>
References: <20181101231228.GA9118@linux.ibm.com>
 <20181108163850.sjedoaom64tzvqgc@linutronix.de>
Reply-To: paulmck@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181108163850.sjedoaom64tzvqgc@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, Nov 08, 2018 at 05:38:51PM +0100, Sebastian Andrzej Siewior wrote:
> On 2018-11-01 16:12:28 [-0700], Paul E. McKenney wrote:
> > > The current check via srcu_online is slightly racy because after looking
> > > at srcu_online there could be an interrupt that interrupted us long
> > > enough until the CPU we checked against went offline.
> > 
> > I don't see how this can happen, even in -rt.  The call to
> > srcu_offline_cpu() happens very early in the CPU removal process,
> > which means that the synchronize_rcu_mult(call_rcu, call_rcu_sched)
> > in sched_cpu_deactivate() would wait for the interrupt to complete.
> > And for the enclosing preempt_disable region to complete.
> 
> Is this again a hidden RCU detail that preempt_disable() on CPU4 is
> enough to ensure that CPU2 does not get marked offline between?

The call_rcu_sched parameter to synchronize_rcu_mult() makes this work.
This synchronize_rcu_mult() call is in sched_cpu_deactivate(), so it
is a hidden sched/RCU detail, I guess.

Or am I missing the point of your question?

> > Or is getting rid of that preempt_disable region the real reason for
> > this change?
> 
> Well, that preempt_disable() + queue_(delayed_)work() does not work -RT.
> But looking further, that preempt_disable() while looking at online CPUs
> didn't look good.

That is why it is invoked from the very early CPU-hotplug notifier.  That
early in the process, the preempt_disable() does prevent the current CPU
from being taken offline twice:  Once due to synchronize_rcu_mult(), and
once due to the stop-machine call.

> > > An alternative would be to hold the hotplug rwsem (so the CPUs don't
> > > change their state) and then check based on cpu_online() if we queue it
> > > on a specific CPU or not. queue_work_on() itself can handle if something
> > > is enqueued on an offline CPU but a timer which is enqueued on an offline
> > > CPU won't fire until the CPU is back online.
> > > 
> > > I am not sure if the removal in rcu_init() is okay or not. I assume that
> > > SRCU won't enqueue a work item before SRCU is up and ready.
> > 
> > That was the case before the current merge window, but use of call_srcu()
> > by tracing means that SRCU needs to be able to deal with call_srcu()
> > long before any initialization has happened.  The actual callbacks
> > won't be invoked until much later, after the scheduler and workqueues
> > are completely up and running, but call_srcu() can be invoked very early.
> > 
> > But I am not seeing any removal in rcu_init() in this patch, so I might
> > be missing something.
> 
> The description is not up-to-date. There was this hunk:
> |@@ -4236,8 +4232,6 @@ void __init rcu_init(void)
> |       for_each_online_cpu(cpu) {
> |               rcutree_prepare_cpu(cpu);
> |               rcu_cpu_starting(cpu);
> |-              if (IS_ENABLED(CONFIG_TREE_SRCU))
> |-                      srcu_online_cpu(cpu);
> |       }
> | }
> 
> which got removed in v4.16.

Ah!  Here is the current rcu_init() code:

	for_each_online_cpu(cpu) {
		rcutree_prepare_cpu(cpu);
		rcu_cpu_starting(cpu);
		rcutree_online_cpu(cpu);
	}

And rcutree_online_cpu() calls srcu_online_cpu() when CONFIG_TREE_SRCU
is enabled, so no need for the direct call from rcu_init().

							Thanx, Paul
