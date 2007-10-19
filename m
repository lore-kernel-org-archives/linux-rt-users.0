From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch 2/8] track highest prio queued on runqueue
Date: Fri, 19 Oct 2007 15:57:45 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0710191553480.4602@gandalf.stny.rr.com>
References: <20071019184254.456160632@goodmis.org>  <20071019184336.349767581@goodmis.org>
 <1192823151.9564.30.camel@ghaskins-t60p.haskins.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Gregory Haskins <ghaskins@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:56541 "EHLO
	ms-smtp-02.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936776AbXJST6Y (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 19 Oct 2007 15:58:24 -0400
In-Reply-To: <1192823151.9564.30.camel@ghaskins-t60p.haskins.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


--
On Fri, 19 Oct 2007, Gregory Haskins wrote:

> >
> >  	struct task_struct *migration_thread;
> >  	struct list_head migration_queue;
> > @@ -972,6 +974,8 @@ static void activate_task(struct rq *rq,
> >
> >  	enqueue_task(rq, p, wakeup);
> >  	inc_nr_running(p, rq);
> > +
> > +	rq_prio_add_task(rq, p);
> >  }
>
> We are better off doing this in enqueue_task() or PI boosting will fail
> to alter the prio of the RQ.

I thought about that too, but thought it was also too -rt base. But I
think I'll move it regardless.

>
> >
> >  /*
> > @@ -984,6 +988,8 @@ static void deactivate_task(struct rq *r
> >
> >  	dequeue_task(rq, p, sleep);
> >  	dec_nr_running(p, rq);
> > +
> > +	rq_prio_remove_task(rq, p);
>
> Ditto for dequeue_task()

Will move.

>
> >  }
> >
> >  /**
> > @@ -6619,6 +6625,7 @@ void __init sched_init(void)
> >  		rq->cpu = i;
> >  		rq->migration_thread = NULL;
> >  		INIT_LIST_HEAD(&rq->migration_queue);
> > +		rq->highest_prio = MAX_RT_PRIO;
> >  #endif
> >  		atomic_set(&rq->nr_iowait, 0);
> >
> > Index: linux-test.git/kernel/sched_rt.c
> > ===================================================================
> > --- linux-test.git.orig/kernel/sched_rt.c	2007-10-19 12:33:09.000000000 -0400
> > +++ linux-test.git/kernel/sched_rt.c	2007-10-19 12:33:23.000000000 -0400
> > @@ -110,6 +110,31 @@ static struct task_struct *pick_next_tas
> >  	return next;
> >  }
> >
> > +#ifdef CONFIG_SMP
> > +static inline void rq_prio_add_task(struct rq *rq, struct task_struct *p)
> > +{
> > +	if (unlikely(rt_task(p)) && p->prio < rq->highest_prio)
> > +		rq->highest_prio = p->prio;
> > +}
> > +
> > +static inline void rq_prio_remove_task(struct rq *rq, struct task_struct *p)
> > +{
> > +	struct rt_prio_array *array;
> > +
> > +	if (unlikely(rt_task(p))) {
> > +		if (rq->rt_nr_running) {
> > +			if (p->prio >= rq->highest_prio) {
>
> <= ?
>
> We only need to recalc if the task being removed was the highest prio
> (or higher, if that were possible but it shouldnt be).

That's what I meant to do. (/me had another confusion between > and < for
the lower the prio the higher the priority!!!!).

>
> I think this logic will technically work as-is because every task is

That wasn't planned. I wanted to only recalc if the priority was >= the
the rq priority, which would have been. p->prio <= rq->highest_prio.
Yes, I thought to myself (that should never be higher!) but I was
paranoid. So the test is not what I meant.

> always >= highest in a properly accounted system, so you will just
> simply recalc for every remove.  But I do like the optimization that you
> were trying to add.
>
> So for the paranoid:
>
> 				BUG_ON(p->prio < rq->highest_prio);
> 				if (p->prio == rq->highest_prio) {
> 					/* recalc */
> 				}

I'll add that with a switch to WARN_ON.

-- Steve
