Return-Path: <SRS0=qyXN=W7=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E40C3A59E
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Sep 2019 04:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E80B22CEA
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Sep 2019 04:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="DvOZ6DrX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725829AbfIDEAl (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 4 Sep 2019 00:00:41 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36485 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbfIDEAl (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 4 Sep 2019 00:00:41 -0400
Received: by mail-pg1-f193.google.com with SMTP id l21so10456078pgm.3
        for <linux-rt-users@vger.kernel.org>; Tue, 03 Sep 2019 21:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6rvr4dn5QwAw4fnMn4YJzPC1OcfnAFGcRF8zv0bU+98=;
        b=DvOZ6DrXbBAluWLb8VUiW6wJr0c1TwwMWe4azaqPu9kn0m9IasSnsFOls0mjhnHj2E
         EvrsHf9lUZyQi8jdZmEIf7Wy04OISpMZ4fc5Y7HfctoRkNLSyUdoUcsAE3wTU9QZMky8
         8dFGjQ5z46n1HYL4TErtqMyAdOtJ8bLIBUxZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6rvr4dn5QwAw4fnMn4YJzPC1OcfnAFGcRF8zv0bU+98=;
        b=AOiSp+AIK0Ko0BQb11FWpYRdzlvdrXCStwKBy4vDqXdTXXEcl3iZaAxtCuBGdQpseH
         Smo2VVOos9B8bdXS8KoWIXiGSklXD+MGF3IOlFY7eb86CperbIQ0x3DxbSTExJct/4KW
         t5MyPBQB4r3kLtaWT4fo1JZNZAM5jOeS6YuG6aWux//Q/9Pw3an2QSUvDzk+XU7GDzXY
         ve+uErSvMzR90ZZ20MYosF5mAiX2oO6V5M7WCpzM1ktg4QYUk0lssxHeiLoVkfGczWUt
         GZjcgSnCm4ee4FVtad9LBVuit2hs2beCbmyYERi0zMzgzIdHao/RZvTf+5zc/lrcFrT9
         KefA==
X-Gm-Message-State: APjAAAVT+0/5IzN2sjB3IxuK/h5VOxx8lo511Tox2/WDJ1AwDSCaW5D3
        sjLTDIYcSCXWcxhCpkt/l97gnw==
X-Google-Smtp-Source: APXvYqx85xtL4/neMvJg4VFmLjSqz0LLRB1Pjqx3oKpBWqm8ujiqQ1G7mN2v1Av5NQJS2dAEy363wg==
X-Received: by 2002:a62:e403:: with SMTP id r3mr18268158pfh.251.1567569640485;
        Tue, 03 Sep 2019 21:00:40 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id o35sm16784520pgm.29.2019.09.03.21.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 21:00:40 -0700 (PDT)
Date:   Wed, 4 Sep 2019 00:00:39 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Viktor Rosendahl <viktor.rosendahl@gmail.com>, paulmck@kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v5 1/4] ftrace: Implement fs notification for
 tracing_max_latency
Message-ID: <20190904040039.GB150430@google.com>
References: <20190903132602.3440-1-viktor.rosendahl@gmail.com>
 <20190903132602.3440-2-viktor.rosendahl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903132602.3440-2-viktor.rosendahl@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

[ Resending since I messed up my last email's headers! ]

On Tue, Sep 03, 2019 at 03:25:59PM +0200, Viktor Rosendahl wrote:
> This patch implements the feature that the tracing_max_latency file,
> e.g. /sys/kernel/debug/tracing/tracing_max_latency will receive
> notifications through the fsnotify framework when a new latency is
> available.
> 
> One particularly interesting use of this facility is when enabling
> threshold tracing, through /sys/kernel/debug/tracing/tracing_thresh,
> together with the preempt/irqsoff tracers. This makes it possible to
> implement a user space program that can, with equal probability,
> obtain traces of latencies that occur immediately after each other in
> spite of the fact that the preempt/irqsoff tracers operate in overwrite
> mode.

Adding Paul since RCU faces similar situations, i.e. raising softirq risks
scheduler deadlock in rcu_read_unlock_special() -- but RCU's solution is to
avoid raising the softirq and instead use irq_work.

I was wondering, if we can rename __raise_softirq_irqoff() to
raise_softirq_irqoff_no_wake() and call that from places where there is risk
of scheduler related deadlocks. Then I think this can be used from Viktor's
code.  Let us discuss - what would happen if the softirq is raised, but
ksoftirqd is not awakened for this latency notification path? Is this really
an issue considering the softirq will execute during the next interrupt exit?

thanks,

 - Joel


> This facility works with the hwlat, preempt/irqsoff, and wakeup
> tracers.
> 
> This patch also adds some unfortunate calls from __schedule() and
> do_idle(). Those calls to the latency_fsnotify_disable/enable() are
> needed because we cannot wake up the workqueue from these critical
> sections without risking a deadlock. Similar problems would also arise
> if we try to schedule a tasklet, raise a softirq, or wake up a kernel
> thread. If a notification event would happen in the forbidden sections,
> we schedule the fsnotify work as soon as we have exited them.
> 
> There was a suggestion to remove this latency_fsnotify_enable/disable()
> gunk, or at least to combine it with the start_critical_timings() and
> stop_critical_timings(). I have however not been able to come up with
> a way to do it.
> 
> It seems like it would be possible to simply replace the calls to
> latency_fsnotify_enable/disable() with calls to
> start/stop_critical_timings(). However, the main problem is that it
> would not work for the wakup tracer. The wakeup tracer needs a
> facility that postpones the notifications, not one that prevents the
> measurements because all its measurements takes place in the middle
> of __schedule(). On the other hand, in some places, like in idle and
> the console we need start stop functions that prevents the
> measurements from being make.
> 
> Signed-off-by: Viktor Rosendahl <viktor.rosendahl@gmail.com>
> ---
>  include/linux/ftrace.h            |  31 +++++++++
>  kernel/sched/core.c               |   3 +
>  kernel/sched/idle.c               |   3 +
>  kernel/sched/sched.h              |   1 +
>  kernel/trace/trace.c              | 112 +++++++++++++++++++++++++++++-
>  kernel/trace/trace.h              |  22 ++++++
>  kernel/trace/trace_hwlat.c        |   4 +-
>  kernel/trace/trace_irqsoff.c      |   4 ++
>  kernel/trace/trace_sched_wakeup.c |   4 ++
>  9 files changed, 181 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index 8a8cb3c401b2..b4d9700ef917 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -907,4 +907,35 @@ unsigned long arch_syscall_addr(int nr);
>  
>  #endif /* CONFIG_FTRACE_SYSCALLS */
>  
> +#if (defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)) && \
> +	defined(CONFIG_FSNOTIFY)
> +
> +DECLARE_PER_CPU(int, latency_notify_disable);
> +DECLARE_STATIC_KEY_FALSE(latency_notify_key);
> +
> +void latency_fsnotify_process(void);
> +
> +/*
> + * Disable/enable fsnotify while in scheduler and idle code. Trying to wake
> + * anything up from there, such as calling queue_work() is prone to deadlock.
> + */
> +static inline void latency_fsnotify_disable(void)
> +{
> +	this_cpu_inc(latency_notify_disable);
> +}
> +
> +static inline void latency_fsnotify_enable(void)
> +{
> +	this_cpu_dec(latency_notify_disable);
> +	if (static_branch_unlikely(&latency_notify_key))
> +		latency_fsnotify_process();
> +}
> +
> +#else
> +
> +#define latency_fsnotify_disable() do { } while (0)
> +#define latency_fsnotify_enable()  do { } while (0)
> +
> +#endif
> +
>  #endif /* _LINUX_FTRACE_H */
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 010d578118d6..e3c1dc801073 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3198,6 +3198,7 @@ asmlinkage __visible void schedule_tail(struct task_struct *prev)
>  	 */
>  
>  	rq = finish_task_switch(prev);
> +	latency_fsnotify_enable();
>  	balance_callback(rq);
>  	preempt_enable();
>  
> @@ -3820,6 +3821,7 @@ static void __sched notrace __schedule(bool preempt)
>  
>  	local_irq_disable();
>  	rcu_note_context_switch(preempt);
> +	latency_fsnotify_disable();
>  
>  	/*
>  	 * Make sure that signal_pending_state()->signal_pending() below
> @@ -3883,6 +3885,7 @@ static void __sched notrace __schedule(bool preempt)
>  		rq_unlock_irq(rq, &rf);
>  	}
>  
> +	latency_fsnotify_enable();
>  	balance_callback(rq);
>  }
>  
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index 80940939b733..5fc87d99a407 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -236,6 +236,7 @@ static void do_idle(void)
>  
>  	__current_set_polling();
>  	tick_nohz_idle_enter();
> +	latency_fsnotify_disable();
>  
>  	while (!need_resched()) {
>  		check_pgt_cache();
> @@ -265,6 +266,8 @@ static void do_idle(void)
>  		arch_cpu_idle_exit();
>  	}
>  
> +	latency_fsnotify_enable();
> +
>  	/*
>  	 * Since we fell out of the loop above, we know TIF_NEED_RESCHED must
>  	 * be set, propagate it into PREEMPT_NEED_RESCHED.
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 802b1f3405f2..467d6ad03f16 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -46,6 +46,7 @@
>  #include <linux/debugfs.h>
>  #include <linux/delayacct.h>
>  #include <linux/energy_model.h>
> +#include <linux/ftrace.h>
>  #include <linux/init_task.h>
>  #include <linux/kprobes.h>
>  #include <linux/kthread.h>
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 563e80f9006a..a622263a69e4 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -44,6 +44,10 @@
>  #include <linux/trace.h>
>  #include <linux/sched/clock.h>
>  #include <linux/sched/rt.h>
> +#include <linux/fsnotify.h>
> +#include <linux/workqueue.h>
> +#include <trace/events/power.h>
> +#include <trace/events/sched.h>
>  
>  #include "trace.h"
>  #include "trace_output.h"
> @@ -1480,6 +1484,110 @@ static ssize_t trace_seq_to_buffer(struct trace_seq *s, void *buf, size_t cnt)
>  
>  unsigned long __read_mostly	tracing_thresh;
>  
> +#if (defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)) && \
> +	defined(CONFIG_FSNOTIFY)
> +
> +static const struct file_operations tracing_max_lat_fops;
> +static struct workqueue_struct *fsnotify_wq;
> +static DEFINE_PER_CPU(struct llist_head, notify_list);
> +
> +DEFINE_PER_CPU(int, latency_notify_disable);
> +DEFINE_STATIC_KEY_FALSE(latency_notify_key);
> +
> +static void latency_fsnotify_workfn(struct work_struct *work)
> +{
> +	struct trace_array *tr = container_of(work, struct trace_array,
> +					      fsnotify_work);
> +	fsnotify(tr->d_max_latency->d_inode, FS_MODIFY,
> +		 tr->d_max_latency->d_inode, FSNOTIFY_EVENT_INODE, NULL, 0);
> +}
> +
> +static void trace_create_maxlat_file(struct trace_array *tr,
> +				     struct dentry *d_tracer)
> +{
> +	INIT_WORK(&tr->fsnotify_work, latency_fsnotify_workfn);
> +	atomic_set(&tr->notify_pending, 0);
> +	tr->d_max_latency = trace_create_file("tracing_max_latency", 0644,
> +					      d_tracer, &tr->max_latency,
> +					      &tracing_max_lat_fops);
> +}
> +
> +void latency_fsnotify_stop(void)
> +{
> +	/* Make sure all CPUs see caller's previous actions to stop tracer */
> +	smp_wmb();
> +	static_branch_disable(&latency_notify_key);
> +	latency_fsnotify_process();
> +}
> +
> +void latency_fsnotify_start(void)
> +{
> +	static_branch_enable(&latency_notify_key);
> +	/* Make sure all CPUs see key value before caller continue */
> +	smp_wmb();
> +}
> +
> +void latency_fsnotify_process(void)
> +{
> +	struct trace_array *tr;
> +	struct llist_head *list;
> +	struct llist_node *node;
> +
> +	if (this_cpu_read(latency_notify_disable))
> +		return;
> +
> +	list = this_cpu_ptr(&notify_list);
> +	for (node = llist_del_first(list); node != NULL;
> +	     node = llist_del_first(list)) {
> +		tr = llist_entry(node, struct trace_array, notify_ll);
> +		atomic_set(&tr->notify_pending, 0);
> +		queue_work(fsnotify_wq, &tr->fsnotify_work);
> +	}
> +}
> +
> +__init static int latency_fsnotify_init(void)
> +{
> +	fsnotify_wq = alloc_workqueue("tr_max_lat_wq",
> +				      WQ_UNBOUND | WQ_HIGHPRI, 0);
> +	if (!fsnotify_wq) {
> +		pr_err("Unable to allocate tr_max_lat_wq\n");
> +		return -ENOMEM;
> +	}
> +	return 0;
> +}
> +
> +late_initcall_sync(latency_fsnotify_init);
> +
> +void latency_fsnotify(struct trace_array *tr)
> +{
> +	if (!fsnotify_wq)
> +		return;
> +
> +	if (!this_cpu_read(latency_notify_disable))
> +		queue_work(fsnotify_wq, &tr->fsnotify_work);
> +	else {
> +		/*
> +		 * notify_pending prevents us from adding the same entry to
> +		 * more than one notify_list. It will get queued in
> +		 * latency_enable_fsnotify()
> +		 */
> +		if (!atomic_xchg(&tr->notify_pending, 1))
> +			llist_add(&tr->notify_ll, this_cpu_ptr(&notify_list));
> +	}
> +}
> +
> +/*
> + * (defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)) && \
> + *  defined(CONFIG_FSNOTIFY)
> + */
> +#else
> +
> +#define trace_create_maxlat_file(tr, d_tracer)				\
> +	trace_create_file("tracing_max_latency", 0644, d_tracer,	\
> +			  &tr->max_latency, &tracing_max_lat_fops)
> +
> +#endif
> +
>  #ifdef CONFIG_TRACER_MAX_TRACE
>  /*
>   * Copy the new maximum trace into the separate maximum-trace
> @@ -1518,6 +1626,7 @@ __update_max_tr(struct trace_array *tr, struct task_struct *tsk, int cpu)
>  
>  	/* record this tasks comm */
>  	tracing_record_cmdline(tsk);
> +	latency_fsnotify(tr);
>  }
>  
>  /**
> @@ -8550,8 +8659,7 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
>  	create_trace_options_dir(tr);
>  
>  #if defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)
> -	trace_create_file("tracing_max_latency", 0644, d_tracer,
> -			&tr->max_latency, &tracing_max_lat_fops);
> +	trace_create_maxlat_file(tr, d_tracer);
>  #endif
>  
>  	if (ftrace_create_function_files(tr, d_tracer))
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index 005f08629b8b..d9f83b2aaa71 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -16,6 +16,7 @@
>  #include <linux/trace_events.h>
>  #include <linux/compiler.h>
>  #include <linux/glob.h>
> +#include <linux/workqueue.h>
>  
>  #ifdef CONFIG_FTRACE_SYSCALLS
>  #include <asm/unistd.h>		/* For NR_SYSCALLS	     */
> @@ -264,6 +265,12 @@ struct trace_array {
>  #endif
>  #if defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)
>  	unsigned long		max_latency;
> +#ifdef CONFIG_FSNOTIFY
> +	struct dentry		*d_max_latency;
> +	struct work_struct	fsnotify_work;
> +	atomic_t		notify_pending;
> +	struct llist_node	notify_ll;
> +#endif
>  #endif
>  	struct trace_pid_list	__rcu *filtered_pids;
>  	/*
> @@ -785,6 +792,21 @@ void update_max_tr_single(struct trace_array *tr,
>  			  struct task_struct *tsk, int cpu);
>  #endif /* CONFIG_TRACER_MAX_TRACE */
>  
> +#if (defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)) && \
> +	defined(CONFIG_FSNOTIFY)
> +
> +void latency_fsnotify(struct trace_array *tr);
> +void latency_fsnotify_start(void);
> +void latency_fsnotify_stop(void);
> +
> +#else
> +
> +#define latency_fsnotify(tr)     do { } while (0)
> +#define latency_fsnotify_start() do { } while (0)
> +#define latency_fsnotify_stop()  do { } while (0)
> +
> +#endif
> +
>  #ifdef CONFIG_STACKTRACE
>  void __trace_stack(struct trace_array *tr, unsigned long flags, int skip,
>  		   int pc);
> diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
> index fa95139445b2..9c379261ee89 100644
> --- a/kernel/trace/trace_hwlat.c
> +++ b/kernel/trace/trace_hwlat.c
> @@ -254,8 +254,10 @@ static int get_sample(void)
>  		trace_hwlat_sample(&s);
>  
>  		/* Keep a running maximum ever recorded hardware latency */
> -		if (sample > tr->max_latency)
> +		if (sample > tr->max_latency) {
>  			tr->max_latency = sample;
> +			latency_fsnotify(tr);
> +		}
>  	}
>  
>  out:
> diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
> index a745b0cee5d3..29403a83a5f0 100644
> --- a/kernel/trace/trace_irqsoff.c
> +++ b/kernel/trace/trace_irqsoff.c
> @@ -557,6 +557,7 @@ static int __irqsoff_tracer_init(struct trace_array *tr)
>  	if (irqsoff_busy)
>  		return -EBUSY;
>  
> +	latency_fsnotify_start();
>  	save_flags = tr->trace_flags;
>  
>  	/* non overwrite screws up the latency tracers */
> @@ -591,16 +592,19 @@ static void __irqsoff_tracer_reset(struct trace_array *tr)
>  	ftrace_reset_array_ops(tr);
>  
>  	irqsoff_busy = false;
> +	latency_fsnotify_stop();
>  }
>  
>  static void irqsoff_tracer_start(struct trace_array *tr)
>  {
> +	latency_fsnotify_start();
>  	tracer_enabled = 1;
>  }
>  
>  static void irqsoff_tracer_stop(struct trace_array *tr)
>  {
>  	tracer_enabled = 0;
> +	latency_fsnotify_stop();
>  }
>  
>  #ifdef CONFIG_IRQSOFF_TRACER
> diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
> index 743b2b520d34..3dc90d9f605b 100644
> --- a/kernel/trace/trace_sched_wakeup.c
> +++ b/kernel/trace/trace_sched_wakeup.c
> @@ -669,6 +669,7 @@ static bool wakeup_busy;
>  
>  static int __wakeup_tracer_init(struct trace_array *tr)
>  {
> +	latency_fsnotify_start();
>  	save_flags = tr->trace_flags;
>  
>  	/* non overwrite screws up the latency tracers */
> @@ -727,10 +728,12 @@ static void wakeup_tracer_reset(struct trace_array *tr)
>  	set_tracer_flag(tr, TRACE_ITER_OVERWRITE, overwrite_flag);
>  	ftrace_reset_array_ops(tr);
>  	wakeup_busy = false;
> +	latency_fsnotify_stop();
>  }
>  
>  static void wakeup_tracer_start(struct trace_array *tr)
>  {
> +	latency_fsnotify_start();
>  	wakeup_reset(tr);
>  	tracer_enabled = 1;
>  }
> @@ -738,6 +741,7 @@ static void wakeup_tracer_start(struct trace_array *tr)
>  static void wakeup_tracer_stop(struct trace_array *tr)
>  {
>  	tracer_enabled = 0;
> +	latency_fsnotify_stop();
>  }
>  
>  static struct tracer wakeup_tracer __read_mostly =
> -- 
> 2.17.1
> 
