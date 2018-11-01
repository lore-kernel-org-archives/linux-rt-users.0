From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: srcu: use cpu_online() instead custom check
Date: Thu, 1 Nov 2018 16:12:28 -0700
Message-ID: <20181101231228.GA9118@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: bigeasy@linutronix.de
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

> The current check via srcu_online is slightly racy because after looking
> at srcu_online there could be an interrupt that interrupted us long
> enough until the CPU we checked against went offline.

I don't see how this can happen, even in -rt.  The call to
srcu_offline_cpu() happens very early in the CPU removal process,
which means that the synchronize_rcu_mult(call_rcu, call_rcu_sched)
in sched_cpu_deactivate() would wait for the interrupt to complete.
And for the enclosing preempt_disable region to complete.

Or is getting rid of that preempt_disable region the real reason for
this change?

> An alternative would be to hold the hotplug rwsem (so the CPUs don't
> change their state) and then check based on cpu_online() if we queue it
> on a specific CPU or not. queue_work_on() itself can handle if something
> is enqueued on an offline CPU but a timer which is enqueued on an offline
> CPU won't fire until the CPU is back online.
> 
> I am not sure if the removal in rcu_init() is okay or not. I assume that
> SRCU won't enqueue a work item before SRCU is up and ready.

That was the case before the current merge window, but use of call_srcu()
by tracing means that SRCU needs to be able to deal with call_srcu()
long before any initialization has happened.  The actual callbacks
won't be invoked until much later, after the scheduler and workqueues
are completely up and running, but call_srcu() can be invoked very early.

But I am not seeing any removal in rcu_init() in this patch, so I might
be missing something.

							Thanx, Paul

> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 6c9866a854b1..3428a40a813e 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -38,6 +38,7 @@
>  #include <linux/delay.h>
>  #include <linux/module.h>
>  #include <linux/srcu.h>
> +#include <linux/cpu.h>
>  
>  #include "rcu.h"
>  #include "rcu_segcblist.h"
> @@ -458,21 +459,6 @@ static void srcu_gp_start(struct srcu_struct *sp)
>  	WARN_ON_ONCE(state != SRCU_STATE_SCAN1);
>  }
>  
> -/*
> - * Track online CPUs to guide callback workqueue placement.
> - */
> -DEFINE_PER_CPU(bool, srcu_online);
> -
> -void srcu_online_cpu(unsigned int cpu)
> -{
> -	WRITE_ONCE(per_cpu(srcu_online, cpu), true);
> -}
> -
> -void srcu_offline_cpu(unsigned int cpu)
> -{
> -	WRITE_ONCE(per_cpu(srcu_online, cpu), false);
> -}
> -
>  /*
>   * Place the workqueue handler on the specified CPU if online, otherwise
>   * just run it whereever.  This is useful for placing workqueue handlers
> @@ -484,12 +470,12 @@ static bool srcu_queue_delayed_work_on(int cpu, struct workqueue_struct *wq,
>  {
>  	bool ret;
>  
> -	preempt_disable();
> -	if (READ_ONCE(per_cpu(srcu_online, cpu)))
> +	cpus_read_lock();
> +	if (cpu_online(cpu))
>  		ret = queue_delayed_work_on(cpu, wq, dwork, delay);
>  	else
>  		ret = queue_delayed_work(wq, dwork, delay);
> -	preempt_enable();
> +	cpus_read_unlock();
>  	return ret;
>  }
>  
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 6868ef417e9f..e2e68250009b 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3767,8 +3767,6 @@ int rcutree_online_cpu(unsigned int cpu)
>  		rnp->ffmask |= rdp->grpmask;
>  		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>  	}
> -	if (IS_ENABLED(CONFIG_TREE_SRCU))
> -		srcu_online_cpu(cpu);
>  	if (rcu_scheduler_active == RCU_SCHEDULER_INACTIVE)
>  		return 0; /* Too early in boot for scheduler work. */
>  	sync_sched_exp_online_cleanup(cpu);
> @@ -3796,8 +3794,6 @@ int rcutree_offline_cpu(unsigned int cpu)
>  	}
>  
>  	rcutree_affinity_setting(cpu, cpu);
> -	if (IS_ENABLED(CONFIG_TREE_SRCU))
> -		srcu_offline_cpu(cpu);
>  	return 0;
>  }
>  
