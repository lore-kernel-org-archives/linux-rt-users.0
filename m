From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: srcu: use cpu_online() instead custom check
Date: Thu, 8 Nov 2018 17:38:51 +0100
Message-ID: <20181108163850.sjedoaom64tzvqgc@linutronix.de>
References: <20181101231228.GA9118@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181101231228.GA9118@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2018-11-01 16:12:28 [-0700], Paul E. McKenney wrote:
> > The current check via srcu_online is slightly racy because after looking
> > at srcu_online there could be an interrupt that interrupted us long
> > enough until the CPU we checked against went offline.
> 
> I don't see how this can happen, even in -rt.  The call to
> srcu_offline_cpu() happens very early in the CPU removal process,
> which means that the synchronize_rcu_mult(call_rcu, call_rcu_sched)
> in sched_cpu_deactivate() would wait for the interrupt to complete.
> And for the enclosing preempt_disable region to complete.

Is this again a hidden RCU detail that preempt_disable() on CPU4 is
enough to ensure that CPU2 does not get marked offline between?

> Or is getting rid of that preempt_disable region the real reason for
> this change?

Well, that preempt_disable() + queue_(delayed_)work() does not work -RT.
But looking further, that preempt_disable() while looking at online CPUs
didn't look good.

> > An alternative would be to hold the hotplug rwsem (so the CPUs don't
> > change their state) and then check based on cpu_online() if we queue it
> > on a specific CPU or not. queue_work_on() itself can handle if something
> > is enqueued on an offline CPU but a timer which is enqueued on an offline
> > CPU won't fire until the CPU is back online.
> > 
> > I am not sure if the removal in rcu_init() is okay or not. I assume that
> > SRCU won't enqueue a work item before SRCU is up and ready.
> 
> That was the case before the current merge window, but use of call_srcu()
> by tracing means that SRCU needs to be able to deal with call_srcu()
> long before any initialization has happened.  The actual callbacks
> won't be invoked until much later, after the scheduler and workqueues
> are completely up and running, but call_srcu() can be invoked very early.
> 
> But I am not seeing any removal in rcu_init() in this patch, so I might
> be missing something.

The description is not up-to-date. There was this hunk:
|@@ -4236,8 +4232,6 @@ void __init rcu_init(void)
|       for_each_online_cpu(cpu) {
|               rcutree_prepare_cpu(cpu);
|               rcu_cpu_starting(cpu);
|-              if (IS_ENABLED(CONFIG_TREE_SRCU))
|-                      srcu_online_cpu(cpu);
|       }
| }

which got removed in v4.16.

> 							Thanx, Paul

Sebastian
