From: "Dmitry Adamushko" <dmitry.adamushko@gmail.com>
Subject: Re: [patch 2/8] track highest prio queued on runqueue
Date: Sat, 20 Oct 2007 20:14:29 +0200
Message-ID: <b647ffbd0710201114g7fb37652r1e28dddbc7e879f4@mail.gmail.com>
References: <20071019184254.456160632@goodmis.org>
	 <20071019184336.349767581@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Andrew Morton" <akpm@linux-foundation.org>,
	"Ingo Molnar" <mingo@elte.hu>,
	"Thomas Gleixner" <tglx@linutronix.de>,
	"Gregory Haskins" <ghaskins@novell.com>,
	"Peter Zijlstra" <a.p.zijlstra@chello.nl>
To: "Steven Rostedt" <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:38204 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764136AbXJTSOa (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 20 Oct 2007 14:14:30 -0400
Received: by wa-out-1112.google.com with SMTP id v27so724701wah
        for <linux-rt-users@vger.kernel.org>; Sat, 20 Oct 2007 11:14:29 -0700 (PDT)
In-Reply-To: <20071019184336.349767581@goodmis.org>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 19/10/2007, Steven Rostedt <rostedt@goodmis.org> wrote:
> [ ... ]
>
===================================================================
> --- linux-test.git.orig/kernel/sched.c  2007-10-19 12:33:09.000000000 -0400
> +++ linux-test.git/kernel/sched.c       2007-10-19 12:34:32.000000000 -0400
> @@ -324,6 +324,8 @@ struct rq {
>         int push_cpu;
>         /* cpu of this runqueue: */
>         int cpu;
> +       /* highest queued rt task prio */
> +       int highest_prio;

again, could it be moved to 'struct rt_rq' ?
(so we want to cache it as we don't want to trash more per-cpu bytes
calling smth like
if (!rt_nr_running) sched_find_first_bit() from other CPUs)


> @@ -972,6 +974,8 @@ static void activate_task(struct rq *rq,
>
>         enqueue_task(rq, p, wakeup);
>         inc_nr_running(p, rq);
> +
> +       rq_prio_add_task(rq, p);
>  }
>
>  /*
> @@ -984,6 +988,8 @@ static void deactivate_task(struct rq *r
>
>         dequeue_task(rq, p, sleep);
>         dec_nr_running(p, rq);
> +
> +       rq_prio_remove_task(rq, p);
>  }

{enqueue,dequeue}_task_rt() would be more appropriate places.


> +static inline void rq_prio_add_task(struct rq *rq, struct task_struct *p)
> +{
> +       if (unlikely(rt_task(p)) && p->prio < rq->highest_prio)
> +               rq->highest_prio = p->prio;
> +}
> +
> +static inline void rq_prio_remove_task(struct rq *rq, struct task_struct *p)
> +{
> +       struct rt_prio_array *array;
> +
> +       if (unlikely(rt_task(p))) {
> +               if (rq->rt_nr_running) {
> +                       if (p->prio >= rq->highest_prio) {
> +                               /* recalculate */
> +                               array = &rq->rt.active;
> +                               rq->highest_prio =
> +                                       sched_find_first_bit(array->bitmap);
> +                       } /* otherwise leave rq->highest prio alone */
> +               } else
> +                       rq->highest_prio = MAX_RT_PRIO;
> +       }
> +}
> +#endif /* CONFIG_SMP */
> +

(just a few thoughts)

we call sched_find_first_bit() in pick_next_task_rt() in the case when
rt_nr_running != 0.

So if we can tolerate the 'latency' of updating the 'highest_prio' ==
the interval of time between deactivate_task() and pick_next_task() in
schedule() then rq_prio_remove_task() would just need to do a single
thing:

/* No more RT tasks: */
if (!rt_nr_running)
        highest_prio = MAX_RT_PRIO;

and then,

static struct task_struct *pick_next_task_rt(struct rq *rq)
{
        struct rt_prio_array *array = &rq->rt.active;
        struct task_struct *next;
        struct list_head *queue;
        int idx;

-        idx = sched_find_first_bit(array->bitmap);
+       rq->highest_prio = idx = sched_find_first_bit(array->bitmap);

[ ... ]

additionally, if we can tolerate the 'latency' (of updating
highest_prio) == the worst case scheduling latency, then
rq_prio_add_task() is not necessary at all.


-- 
Best regards,
Dmitry Adamushko
