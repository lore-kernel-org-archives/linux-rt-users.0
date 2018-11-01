From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: rcu: Merge RCU-bh into RCU-preempt
Date: Thu, 1 Nov 2018 16:18:04 -0700
Message-ID: <20181101231804.GA11280@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: tglx@linutronix.de, bigeasy@linutronix.de
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

> The Linux kernel has long RCU-bh read-side critical sections that
> intolerably increase scheduling latency under mainline's RCU-bh rules,
> which include RCU-bh read-side critical sections being non-preemptible.
> This patch therefore arranges for RCU-bh to be implemented in terms of
> RCU-preempt for CONFIG_PREEMPT_RT_FULL=y.
> 
> This has the downside of defeating the purpose of RCU-bh, namely,
> handling the case where the system is subjected to a network-based
> denial-of-service attack that keeps at least one CPU doing full-time
> softirq processing.  This issue will be fixed by a later commit.
> 
> The current commit will need some work to make it appropriate for
> mainline use, for example, it needs to be extended to cover Tiny RCU.

The need for this goes away as of the current merge window because
RCU-bh has gone away.  (Aside from still being able to do things
like rcu_read_lock_bh() as a documentation device.)

							Thanx, Paul

> [ paulmck: Added a useful changelog ]
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Link: http://lkml.kernel.org/r/20111005185938.GA20403@linux.vnet.ibm.com
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> 
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index 63cd0a1a99a0..60a9b5feefe2 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -56,7 +56,11 @@ void call_rcu(struct rcu_head *head, rcu_callback_t func);
>  #define	call_rcu	call_rcu_sched
>  #endif /* #else #ifdef CONFIG_PREEMPT_RCU */
>  
> +#ifdef CONFIG_PREEMPT_RT_FULL
> +#define call_rcu_bh	call_rcu
> +#else
>  void call_rcu_bh(struct rcu_head *head, rcu_callback_t func);
> +#endif
>  void call_rcu_sched(struct rcu_head *head, rcu_callback_t func);
>  void synchronize_sched(void);
>  void rcu_barrier_tasks(void);
> @@ -263,7 +267,14 @@ extern struct lockdep_map rcu_sched_lock_map;
>  extern struct lockdep_map rcu_callback_map;
>  int debug_lockdep_rcu_enabled(void);
>  int rcu_read_lock_held(void);
> +#ifdef CONFIG_PREEMPT_RT_FULL
> +static inline int rcu_read_lock_bh_held(void)
> +{
> +	return rcu_read_lock_held();
> +}
> +#else
>  int rcu_read_lock_bh_held(void);
> +#endif
>  int rcu_read_lock_sched_held(void);
>  
>  #else /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
> @@ -663,10 +674,14 @@ static inline void rcu_read_unlock(void)
>  static inline void rcu_read_lock_bh(void)
>  {
>  	local_bh_disable();
> +#ifdef CONFIG_PREEMPT_RT_FULL
> +	rcu_read_lock();
> +#else
>  	__acquire(RCU_BH);
>  	rcu_lock_acquire(&rcu_bh_lock_map);
>  	RCU_LOCKDEP_WARN(!rcu_is_watching(),
>  			 "rcu_read_lock_bh() used illegally while idle");
> +#endif
>  }
>  
>  /*
> @@ -676,10 +691,14 @@ static inline void rcu_read_lock_bh(void)
>   */
>  static inline void rcu_read_unlock_bh(void)
>  {
> +#ifdef CONFIG_PREEMPT_RT_FULL
> +	rcu_read_unlock();
> +#else
>  	RCU_LOCKDEP_WARN(!rcu_is_watching(),
>  			 "rcu_read_unlock_bh() used illegally while idle");
>  	rcu_lock_release(&rcu_bh_lock_map);
>  	__release(RCU_BH);
> +#endif
>  	local_bh_enable();
>  }
>  
> diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
> index 914655848ef6..462ce061bac7 100644
> --- a/include/linux/rcutree.h
> +++ b/include/linux/rcutree.h
> @@ -44,7 +44,11 @@ static inline void rcu_virt_note_context_switch(int cpu)
>  	rcu_note_context_switch(false);
>  }
>  
> +#ifdef CONFIG_PREEMPT_RT_FULL
> +# define synchronize_rcu_bh	synchronize_rcu
> +#else
>  void synchronize_rcu_bh(void);
> +#endif
>  void synchronize_sched_expedited(void);
>  void synchronize_rcu_expedited(void);
>  
> @@ -72,7 +76,11 @@ static inline void synchronize_rcu_bh_expedited(void)
>  }
>  
>  void rcu_barrier(void);
> +#ifdef CONFIG_PREEMPT_RT_FULL
> +# define rcu_barrier_bh		rcu_barrier
> +#else
>  void rcu_barrier_bh(void);
> +#endif
>  void rcu_barrier_sched(void);
>  bool rcu_eqs_special_set(int cpu);
>  unsigned long get_state_synchronize_rcu(void);
> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> index 4d04683c31b2..808cce9a5d43 100644
> --- a/kernel/rcu/rcu.h
> +++ b/kernel/rcu/rcu.h
> @@ -528,7 +528,6 @@ static inline void show_rcu_gp_kthreads(void) { }
>  static inline int rcu_get_gp_kthreads_prio(void) { return 0; }
>  #else /* #ifdef CONFIG_TINY_RCU */
>  unsigned long rcu_get_gp_seq(void);
> -unsigned long rcu_bh_get_gp_seq(void);
>  unsigned long rcu_sched_get_gp_seq(void);
>  unsigned long rcu_exp_batches_completed(void);
>  unsigned long rcu_exp_batches_completed_sched(void);
> @@ -536,10 +535,18 @@ unsigned long srcu_batches_completed(struct srcu_struct *sp);
>  void show_rcu_gp_kthreads(void);
>  int rcu_get_gp_kthreads_prio(void);
>  void rcu_force_quiescent_state(void);
> -void rcu_bh_force_quiescent_state(void);
>  void rcu_sched_force_quiescent_state(void);
>  extern struct workqueue_struct *rcu_gp_wq;
>  extern struct workqueue_struct *rcu_par_gp_wq;
> +
> +#ifdef CONFIG_PREEMPT_RT_FULL
> +#define rcu_bh_get_gp_seq		rcu_get_gp_seq
> +#define rcu_bh_force_quiescent_state	rcu_force_quiescent_state
> +#else
> +unsigned long rcu_bh_get_gp_seq(void);
> +void rcu_bh_force_quiescent_state(void);
> +#endif
> +
>  #endif /* #else #ifdef CONFIG_TINY_RCU */
>  
>  #ifdef CONFIG_RCU_NOCB_CPU
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index c596c6f1e457..7d2a615601e7 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -434,6 +434,7 @@ static struct rcu_torture_ops rcu_ops = {
>  	.name		= "rcu"
>  };
>  
> +#ifndef CONFIG_PREEMPT_RT_FULL
>  /*
>   * Definitions for rcu_bh torture testing.
>   */
> @@ -475,6 +476,12 @@ static struct rcu_torture_ops rcu_bh_ops = {
>  	.name		= "rcu_bh"
>  };
>  
> +#else
> +static struct rcu_torture_ops rcu_bh_ops = {
> +	.ttype		= INVALID_RCU_FLAVOR,
> +};
> +#endif
> +
>  /*
>   * Don't even think about trying any of these in real life!!!
>   * The names includes "busted", and they really means it!
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 0b760c1369f7..197088cdb56e 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -244,6 +244,7 @@ void rcu_sched_qs(void)
>  			   this_cpu_ptr(&rcu_sched_data), true);
>  }
>  
> +#ifndef CONFIG_PREEMPT_RT_FULL
>  void rcu_bh_qs(void)
>  {
>  	RCU_LOCKDEP_WARN(preemptible(), "rcu_bh_qs() invoked with preemption enabled!!!");
> @@ -254,6 +255,7 @@ void rcu_bh_qs(void)
>  		__this_cpu_write(rcu_bh_data.cpu_no_qs.b.norm, false);
>  	}
>  }
> +#endif
>  
>  /*
>   * Steal a bit from the bottom of ->dynticks for idle entry/exit
> @@ -568,6 +570,7 @@ unsigned long rcu_sched_get_gp_seq(void)
>  }
>  EXPORT_SYMBOL_GPL(rcu_sched_get_gp_seq);
>  
> +#ifndef CONFIG_PREEMPT_RT_FULL
>  /*
>   * Return the number of RCU-bh GPs completed thus far for debug & stats.
>   */
> @@ -576,6 +579,7 @@ unsigned long rcu_bh_get_gp_seq(void)
>  	return READ_ONCE(rcu_bh_state.gp_seq);
>  }
>  EXPORT_SYMBOL_GPL(rcu_bh_get_gp_seq);
> +#endif
>  
>  /*
>   * Return the number of RCU expedited batches completed thus far for
> @@ -599,6 +603,7 @@ unsigned long rcu_exp_batches_completed_sched(void)
>  }
>  EXPORT_SYMBOL_GPL(rcu_exp_batches_completed_sched);
>  
> +#ifndef CONFIG_PREEMPT_RT_FULL
>  /*
>   * Force a quiescent state.
>   */
> @@ -617,6 +622,13 @@ void rcu_bh_force_quiescent_state(void)
>  }
>  EXPORT_SYMBOL_GPL(rcu_bh_force_quiescent_state);
>  
> +#else
> +void rcu_force_quiescent_state(void)
> +{
> +}
> +EXPORT_SYMBOL_GPL(rcu_force_quiescent_state);
> +#endif
> +
>  /*
>   * Force a quiescent state for RCU-sched.
>   */
> @@ -674,9 +686,11 @@ void rcutorture_get_gp_data(enum rcutorture_type test_type, int *flags,
>  	case RCU_FLAVOR:
>  		rsp = rcu_state_p;
>  		break;
> +#ifndef CONFIG_PREEMPT_RT_FULL
>  	case RCU_BH_FLAVOR:
>  		rsp = &rcu_bh_state;
>  		break;
> +#endif
>  	case RCU_SCHED_FLAVOR:
>  		rsp = &rcu_sched_state;
>  		break;
> @@ -3040,6 +3054,7 @@ void call_rcu_sched(struct rcu_head *head, rcu_callback_t func)
>  }
>  EXPORT_SYMBOL_GPL(call_rcu_sched);
>  
> +#ifndef CONFIG_PREEMPT_RT_FULL
>  /**
>   * call_rcu_bh() - Queue an RCU for invocation after a quicker grace period.
>   * @head: structure to be used for queueing the RCU updates.
> @@ -3067,6 +3082,7 @@ void call_rcu_bh(struct rcu_head *head, rcu_callback_t func)
>  	__call_rcu(head, func, &rcu_bh_state, -1, 0);
>  }
>  EXPORT_SYMBOL_GPL(call_rcu_bh);
> +#endif
>  
>  /*
>   * Queue an RCU callback for lazy invocation after a grace period.
> @@ -3152,6 +3168,7 @@ void synchronize_sched(void)
>  }
>  EXPORT_SYMBOL_GPL(synchronize_sched);
>  
> +#ifndef CONFIG_PREEMPT_RT_FULL
>  /**
>   * synchronize_rcu_bh - wait until an rcu_bh grace period has elapsed.
>   *
> @@ -3178,6 +3195,7 @@ void synchronize_rcu_bh(void)
>  		wait_rcu_gp(call_rcu_bh);
>  }
>  EXPORT_SYMBOL_GPL(synchronize_rcu_bh);
> +#endif
>  
>  /**
>   * get_state_synchronize_rcu - Snapshot current RCU state
> @@ -3485,6 +3503,7 @@ static void _rcu_barrier(struct rcu_state *rsp)
>  	mutex_unlock(&rsp->barrier_mutex);
>  }
>  
> +#ifndef CONFIG_PREEMPT_RT_FULL
>  /**
>   * rcu_barrier_bh - Wait until all in-flight call_rcu_bh() callbacks complete.
>   */
> @@ -3493,6 +3512,7 @@ void rcu_barrier_bh(void)
>  	_rcu_barrier(&rcu_bh_state);
>  }
>  EXPORT_SYMBOL_GPL(rcu_barrier_bh);
> +#endif
>  
>  /**
>   * rcu_barrier_sched - Wait for in-flight call_rcu_sched() callbacks.
> @@ -4140,7 +4160,9 @@ void __init rcu_init(void)
>  
>  	rcu_bootup_announce();
>  	rcu_init_geometry();
> +#ifndef CONFIG_PREEMPT_RT_FULL
>  	rcu_init_one(&rcu_bh_state);
> +#endif
>  	rcu_init_one(&rcu_sched_state);
>  	if (dump_tree)
>  		rcu_dump_rcu_node_tree(&rcu_sched_state);
> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> index 4e74df768c57..fbbff7c21148 100644
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -413,7 +413,9 @@ extern struct list_head rcu_struct_flavors;
>   */
>  extern struct rcu_state rcu_sched_state;
>  
> +#ifndef CONFIG_PREEMPT_RT_FULL
>  extern struct rcu_state rcu_bh_state;
> +#endif
>  
>  #ifdef CONFIG_PREEMPT_RCU
>  extern struct rcu_state rcu_preempt_state;
> diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
> index 39cb23d22109..f56c0fbdf22e 100644
> --- a/kernel/rcu/update.c
> +++ b/kernel/rcu/update.c
> @@ -286,6 +286,7 @@ int rcu_read_lock_held(void)
>  }
>  EXPORT_SYMBOL_GPL(rcu_read_lock_held);
>  
> +#ifndef CONFIG_PREEMPT_RT_FULL
>  /**
>   * rcu_read_lock_bh_held() - might we be in RCU-bh read-side critical section?
>   *
> @@ -312,6 +313,7 @@ int rcu_read_lock_bh_held(void)
>  	return in_softirq() || irqs_disabled();
>  }
>  EXPORT_SYMBOL_GPL(rcu_read_lock_bh_held);
> +#endif
>  
>  #endif /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
>  
