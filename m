From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: srcu: use cpu_online() instead custom check
Date: Thu, 8 Nov 2018 10:05:17 -0800
Message-ID: <20181108180517.GR4170@linux.ibm.com>
References: <20181101231228.GA9118@linux.ibm.com>
 <20181108163850.sjedoaom64tzvqgc@linutronix.de>
 <20181108171024.GM4170@linux.ibm.com>
 <20181108174655.mnm3cr4wn2hrrtep@linutronix.de>
Reply-To: paulmck@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: tglx@linutronix.de, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181108174655.mnm3cr4wn2hrrtep@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, Nov 08, 2018 at 06:46:55PM +0100, Sebastian Andrzej Siewior wrote:
> On 2018-11-08 09:10:24 [-0800], Paul E. McKenney wrote:
> > > Is this again a hidden RCU detail that preempt_disable() on CPU4 is
> > > enough to ensure that CPU2 does not get marked offline between?
> > 
> > The call_rcu_sched parameter to synchronize_rcu_mult() makes this work.
> > This synchronize_rcu_mult() call is in sched_cpu_deactivate(), so it
> > is a hidden sched/RCU detail, I guess.
> > 
> > Or am I missing the point of your question?
> 
> No, this answers it.
> 
> > > > Or is getting rid of that preempt_disable region the real reason for
> > > > this change?
> > > 
> > > Well, that preempt_disable() + queue_(delayed_)work() does not work -RT.
> > > But looking further, that preempt_disable() while looking at online CPUs
> > > didn't look good.
> > 
> > That is why it is invoked from the very early CPU-hotplug notifier.  That
> > early in the process, the preempt_disable() does prevent the current CPU
> > from being taken offline twice:  Once due to synchronize_rcu_mult(), and
> > once due to the stop-machine call.
> 
> :)
>  
> > > The description is not up-to-date. There was this hunk:
> > > |@@ -4236,8 +4232,6 @@ void __init rcu_init(void)
> > > |       for_each_online_cpu(cpu) {
> > > |               rcutree_prepare_cpu(cpu);
> > > |               rcu_cpu_starting(cpu);
> > > |-              if (IS_ENABLED(CONFIG_TREE_SRCU))
> > > |-                      srcu_online_cpu(cpu);
> > > |       }
> > > | }
> > > 
> > > which got removed in v4.16.
> > 
> > Ah!  Here is the current rcu_init() code:
> > 
> > 	for_each_online_cpu(cpu) {
> > 		rcutree_prepare_cpu(cpu);
> > 		rcu_cpu_starting(cpu);
> > 		rcutree_online_cpu(cpu);
> > 	}
> > 
> > And rcutree_online_cpu() calls srcu_online_cpu() when CONFIG_TREE_SRCU
> > is enabled, so no need for the direct call from rcu_init().
> 
> So if a CPU goes down, the timer gets migrated to another CPU. If the
> CPU is already offline the timer can be programmed and nothing happens.
> If timer_add_on() would return an error we could have fallback code.
> Looking at the users of queue_delayed_work_on() there are only two using
> it really (the others are using smp_processor_id()) and one of them is
> using get_online_cpus().
> It does not look like there a lot of users affected. Would be reasonable
> to avoid adding timers to offlined CPUs?

Just to make sure I understand, this is the call to queue_delayed_work_on()
from srcu_queue_delayed_work_on(), right?

And if I am guessing correctly, you would like to get rid of the
constraint requiring CPUHP_RCUTREE_PREP to precede CPUHP_TIMERS_PREPARE?
If so, the swait_event_idle_timeout_exclusive() in rcu_gp_fqs_loop()
in kernel/rcu/tree.c also requires this ordering.  There are probably
other pieces of code needing this.

Plus the reason for running this on a specific CPU is that the workqueue
item is processing that CPU's per-CPU variables, including invoking that
CPU's callbacks.  The item is srcu_invoke_callbacks().

							Thanx, Paul
