From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 3/4] sched/deadline: Tracepoints for deadline scheduler
Date: Tue, 23 Feb 2016 15:27:53 +0100
Message-ID: <20160223142753.GR6375@twins.programming.kicks-ass.net>
References: <cover.1456157869.git.bristot@redhat.com>
 <f3b54958f216d36be59363815a3d75a0636cda8b.1456157869.git.bristot@redhat.com>
 <20160222173259.GM6357@twins.programming.kicks-ass.net>
 <20160222124854.3816fec4@gandalf.local.home>
 <20160222213017.GN6357@twins.programming.kicks-ass.net>
 <20160222173043.24873ae8@gandalf.local.home>
 <20160223104408.GO6357@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juri Lelli <juri.lelli@gmail.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160223104408.GO6357@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, Feb 23, 2016 at 11:44:08AM +0100, Peter Zijlstra wrote:
>  include/trace/events/sched.h | 97 +++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 86 insertions(+), 11 deletions(-)
> 
> diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> index 9b90c57517a9..b902eb71830b 100644
> --- a/include/trace/events/sched.h
> +++ b/include/trace/events/sched.h
> @@ -103,9 +103,15 @@ DEFINE_EVENT(sched_wakeup_template, sched_wakeup_new,
>  	     TP_PROTO(struct task_struct *p),
>  	     TP_ARGS(p));
>  
> +#define TASK_STATE_PREEMPT	(TASK_STATE_MAX << 0)
> +#define TASK_STATE_THROTTLED	(TASK_STATE_MAX << 1)
> +#define TASK_STATE_YIELDED	(TASK_STATE_MAX << 2)
> +
>  #ifdef CREATE_TRACE_POINTS
>  static inline long __trace_sched_switch_state(bool preempt, struct task_struct *p)
>  {
> +	long state = p->state;
> +
>  #ifdef CONFIG_SCHED_DEBUG
>  	BUG_ON(p != current);
>  #endif /* CONFIG_SCHED_DEBUG */
> @@ -114,10 +120,49 @@ static inline long __trace_sched_switch_state(bool preempt, struct task_struct *
>  	 * Preemption ignores task state, therefore preempted tasks are always
>  	 * RUNNING (we will not have dequeued if state != RUNNING).
>  	 */
> -	return preempt ? TASK_RUNNING | TASK_STATE_MAX : p->state;
> +	if (preempt) {
> +		state = TASK_RUNNING | TASK_STATE_MAX;
> +	} else if (dl_task(p)) {
> +		if (p->dl.dl_throttled)
> +			state |= TASK_STATE_THROTTLED;
> +		else if (p->dl.dl_yielded)
> +			state |= TASK_STATE_YIELDED;

These might want to be inverted, that is, yielded will have throttled
set, so yield should take precedence.

> +	}
> +
> +	return state;
>  }
>  #endif /* CREATE_TRACE_POINTS */
>  
> +#define __trace_sched_switch_fields(name)	do {			\
> +	__entry->name##_policy = name->policy;				\
> +	switch (name->policy) {						\

Sadly we cannot use policy, for that isn't updated on PI. The best we
can do is dl_task(), rt_task() else ...

> +	case SCHED_IDLE:						\

This doesn't have nice, so should go with default;

> +	case SCHED_BATCH:						\
> +	case SCHED_NORMAL:						\
> +		__entry->name##_f1 = PRIO_TO_NICE(name->static_prio);	\
> +		__entry->name##_f2 = 0;					\
> +		__entry->name##_f3 = 0;					\
> +		break;							\
> +	case SCHED_RR:							\
> +	case SCHED_FIFO:						\
> +		__entry->name##_f1 = USER_PRIO(name->normal_prio);	\
> +		__entry->name##_f2 = 0;					\
> +		__entry->name##_f3 = 0;					\
> +		break;							\
> +	case SCHED_DEADLINE:						\
> +		__entry->name##_f1 = name->dl.runtime;			\
> +		__entry->name##_f2 = name->dl.deadline;			\
> +		__entry->name##_f3 = name->dl.dl_period;		\
> +		break;							\
> +	default:							\
> +		__entry->name##_f1 = 0;					\
> +		__entry->name##_f2 = 0;					\
> +		__entry->name##_f3 = 0;					\
> +		break;							\
> +	}								\
> +} while (0)
