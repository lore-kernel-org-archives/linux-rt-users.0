From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: EXP rcu: Revert expedited GP parallelization cleverness
Date: Thu, 8 Nov 2018 17:58:45 +0100
Message-ID: <20181108165845.bzx6pjtmm3u7yur7@linutronix.de>
References: <20181101233031.GA13002@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181101233031.GA13002@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2018-11-01 16:30:31 [-0700], Paul E. McKenney wrote:
> > (Commit 258ba8e089db23f760139266c232f01bad73f85c from linux-rcu)
> > 
> > This commit reverts a series of commits starting with fcc635436501 ("rcu:
> > Make expedited GPs handle CPU 0 being offline") and its successors, thus
> > queueing each rcu_node structure's expedited grace-period initialization
> > work on the first CPU of that rcu_node structure.
> > 
> > Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > 
> > diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> > index 0b2c2ad69629..a0486414edb4 100644
> > --- a/kernel/rcu/tree_exp.h
> > +++ b/kernel/rcu/tree_exp.h
> > @@ -472,7 +472,6 @@ static void sync_rcu_exp_select_node_cpus(struct work_struct *wp)
> >  static void sync_rcu_exp_select_cpus(struct rcu_state *rsp,
> >  				     smp_call_func_t func)
> >  {
> > -	int cpu;
> >  	struct rcu_node *rnp;
> >  
> >  	trace_rcu_exp_grace_period(rsp->name, rcu_exp_gp_seq_endval(rsp), TPS("reset"));
> > @@ -494,13 +493,7 @@ static void sync_rcu_exp_select_cpus(struct rcu_state *rsp,
> >  			continue;
> >  		}
> >  		INIT_WORK(&rnp->rew.rew_work, sync_rcu_exp_select_node_cpus);
> > -		preempt_disable();
> > -		cpu = cpumask_next(rnp->grplo - 1, cpu_online_mask);
> > -		/* If all offline, queue the work on an unbound CPU. */
> > -		if (unlikely(cpu > rnp->grphi))
> > -			cpu = WORK_CPU_UNBOUND;
> > -		queue_work_on(cpu, rcu_par_gp_wq, &rnp->rew.rew_work);
> > -		preempt_enable();
> > +		queue_work_on(rnp->grplo, rcu_par_gp_wq, &rnp->rew.rew_work);
> >  		rnp->exp_need_flush = true;
> >  	}
> 
> How about instead changing the earlier "if" statement to read as follows?
> 
> 		if (!READ_ONCE(rcu_par_gp_wq) ||
> 		    rcu_scheduler_active != RCU_SCHEDULER_RUNNING ||
> 		    rcu_is_last_leaf_node(rnp) ||
> 		    IS_ENABLED(CONFIG_PREEMPT_RT_FULL)) {
> 			/* No workqueues yet or last leaf, do direct call. */
> 			sync_rcu_exp_select_node_cpus(&rnp->rew.rew_work);
> 			continue;
> 		}
> 
> This just adds the "|| IS_ENABLED(CONFIG_PREEMPT_RT_FULL)" to the "if"
> condition.
> 
> The advantage of this approach is that it leaves the parallelization
> alone for mainline, and avoids the overhead of the workqueues for -rt.

I don't oppose to the workqueue approach. It is just preempt_disable() +
workqueue don't work on -RT. And if I remember correctly, we can't take
CPU hotplug lock for other reasons (which woould make the
preempt_disable() go away). Also the original argument why that patch
went in was not solid so I though removing the extra complexity would be
a good thing.
However using sync_rcu_exp_select_node_cpus() (based von v4.20-rc1)
should work on -RT from what I can see. And performance wise it should
not matter for -RT because the whole synchronize_.*_expedited() is
disabled on -RT anyway. So it should be used only during boot-up.

> 							Thanx, Paul

Sebastian
