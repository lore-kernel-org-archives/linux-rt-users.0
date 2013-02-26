From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: rt: rtmutex experiment doubled tbench throughput
Date: Tue, 26 Feb 2013 16:25:01 -0500
Message-ID: <1361913901.11373.59.camel@gandalf.local.home>
References: <1361551010.32441.50.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Mike Galbraith <bitbucket@online.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:30260 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754075Ab3BZVZD (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 26 Feb 2013 16:25:03 -0500
In-Reply-To: <1361551010.32441.50.camel@marge.simpson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2013-02-22 at 17:36 +0100, Mike Galbraith wrote:

> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -2083,6 +2083,9 @@ extern unsigned int sysctl_sched_latency
>  extern unsigned int sysctl_sched_min_granularity;
>  extern unsigned int sysctl_sched_wakeup_granularity;
>  extern unsigned int sysctl_sched_child_runs_first;
> +#ifdef CONFIG_PREEMPT_RT_FULL
> +extern unsigned int sysctl_sched_rt_spin_yield;
> +#endif
>  
>  enum sched_tunable_scaling {
>  	SCHED_TUNABLESCALING_NONE,
> @@ -2146,12 +2149,12 @@ extern unsigned int sysctl_sched_cfs_ban
>  #endif
>  
>  #ifdef CONFIG_RT_MUTEXES
> -extern void task_setprio(struct task_struct *p, int prio);
> +extern void task_setprio(struct task_struct *p, int prio, int yield);

BTW, what kernel did you apply this too, as there's no task_setprio()
anymore in 3.0-rt, 3.2-rt, 3.4-rt or 3.6-rt?

-- Steve


>  extern int rt_mutex_getprio(struct task_struct *p);
>  extern int rt_mutex_check_prio(struct task_struct *task, int newprio);
>  static inline void rt_mutex_setprio(struct task_struct *p, int prio)
>  {
> -	task_setprio(p, prio);
> +	task_setprio(p, prio, 0);
>  }
>  extern void rt_mutex_adjust_pi(struct task_struct *p);
>  static inline bool tsk_is_pi_blocked(struct task_struct *tsk)


