From: Darren Hart <dvhltc@us.ibm.com>
Subject: Re: [RFC][PATCH] fix SCHED_FIFO spec violation (backport)
Date: Sat, 05 Jul 2008 08:18:10 -0700
Message-ID: <1215271090.18491.20.camel@Aeon>
References: <1215124898.11333.20.camel@Aeon>
	 <520f0cf10807040608w7e8cea01r39e2489269bc9f73@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-i9Kssh/xe2re/ESrIcUy"
Cc: linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Clark Williams <williams@redhat.com>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dmitry Adamushko <dmitry.adamushko@gmail.com>,
	Gregory Haskins <ghaskins@novell.com>
To: John Kacur <jkacur@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:54011 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751134AbYGEPSX (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 5 Jul 2008 11:18:23 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m65FIFo8025644
	for <linux-rt-users@vger.kernel.org>; Sat, 5 Jul 2008 11:18:15 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id m65FIFVG167850
	for <linux-rt-users@vger.kernel.org>; Sat, 5 Jul 2008 09:18:15 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m65FIEdo029863
	for <linux-rt-users@vger.kernel.org>; Sat, 5 Jul 2008 09:18:15 -0600
In-Reply-To: <520f0cf10807040608w7e8cea01r39e2489269bc9f73@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


--=-i9Kssh/xe2re/ESrIcUy
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2008-07-04 at 15:08 +0200, John Kacur wrote:
> Since we're always being admonished to do code-review, and I needed to
> waste some time, here are a few comments, to what looks largely like a
> nice patch to me.

Hi John, thanks for the review.  Note that this is a backport of Peter'z
git patch, so I'll try to address some of your rationale questions
below, but the short answer is "I tried to match Peter's implementation
as closely as possible."  Regarding the patch applying, it worked for
me... see below.

> 
> On Fri, Jul 4, 2008 at 12:41 AM, Darren Hart <dvhltc@us.ibm.com> wrote:
> > Enqueue deprioritized RT tasks to head of prio array
> >
> > This patch backports Peter Z's enqueue to head of prio array on
> > de-prioritization to 2.6.24.7-rt14 which doesn't have the
> > enqueue_rt_entity and associated changes.
> >
> > I've run several long running real-time java benchmarks and it's
> > holding so far.  Steven, please consider this patch for inclusion
> > in the next 2.6.24.7-rtX release.
> >
> > Peter, I didn't include your Signed-off-by as only about half your
> > original patch applied to 2.6.24.7-r14.  If you're happy with this
> > version, would you also sign off?
> >
> > Signed-off-by: Darren Hart <dvhltc@us.ibm.com>
> >
> >
> > ---
> > Index: linux-2.6.24.7-ibmrt2.6-view/include/linux/sched.h
> > ===================================================================
> > --- linux-2.6.24.7-ibmrt2.6-view.orig/include/linux/sched.h
> > +++ linux-2.6.24.7-ibmrt2.6-view/include/linux/sched.h
> > @@ -897,11 +897,16 @@ struct uts_namespace;
> >  struct rq;
> >  struct sched_domain;
> >
> > +#define ENQUEUE_WAKEUP 0x01
> > +#define ENQUEUE_HEAD   0x02
> > +
> > +#define DEQUEUE_SLEEP  0x01
> > +
> 
> Question: is ENQUEUE_WAKEUP equal to DEQUEUE_SLEEP by design or
> coincidence? 

Coincidence.  The ENQUEUE_* flags are only to be used with the
enqueue_task* methods, while the DEQUEUE_* flags are for deqeue_task*.
Note that the conversion of sleep to the DEQUEUE_SLEEP flag isn't really
necessary as there is only the one flag, but it makes the calls
parallel, which I suspect was Peter's intention (but I speculate here).

> The renaming of wakeup and sleep to flags makes it at
> least superficially seem like they overlap. Since a large part of the
> patch is renaming, it might be easier to understand if the renaming
> was done as a separate patch, but on the other hand, that is probably
> just a PITA. :)

Seems a small enough patch to be all in one to me.  If others object
I'll split it out, but again, I tried to keep the backport as close to
Peter's original patch as possible.

> 
> >  struct sched_class {
> >        const struct sched_class *next;
> >
> > -       void (*enqueue_task) (struct rq *rq, struct task_struct *p, int wakeup);
> > -       void (*dequeue_task) (struct rq *rq, struct task_struct *p, int sleep);
> > +       void (*enqueue_task) (struct rq *rq, struct task_struct *p, int flags);
> > +       void (*dequeue_task) (struct rq *rq, struct task_struct *p, int flags);
> >        void (*yield_task) (struct rq *rq);
> >        int  (*select_task_rq)(struct task_struct *p, int sync);
> >
> > Index: linux-2.6.24.7-ibmrt2.6-view/kernel/sched.c
> > ===================================================================
> > --- linux-2.6.24.7-ibmrt2.6-view.orig/kernel/sched.c
> > +++ linux-2.6.24.7-ibmrt2.6-view/kernel/sched.c
> > @@ -1046,7 +1046,7 @@ static const u32 prio_to_wmult[40] = {
> >  /*  15 */ 119304647, 148102320, 186737708, 238609294, 286331153,
> >  };
> >
> > -static void activate_task(struct rq *rq, struct task_struct *p, int wakeup);
> > +static void activate_task(struct rq *rq, struct task_struct *p, int flags);
> >
> >  /*
> >  * runqueue iterator, to support SMP load-balancing between different
> > @@ -1155,16 +1155,16 @@ static void set_load_weight(struct task_
> >        p->se.load.inv_weight = prio_to_wmult[p->static_prio - MAX_RT_PRIO];
> >  }
> >
> > -static void enqueue_task(struct rq *rq, struct task_struct *p, int wakeup)
> > +static void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
> >  {
> >        sched_info_queued(p);
> > -       p->sched_class->enqueue_task(rq, p, wakeup);
> > +       p->sched_class->enqueue_task(rq, p, flags);
> >        p->se.on_rq = 1;
> >  }
> >
> > -static void dequeue_task(struct rq *rq, struct task_struct *p, int sleep)
> > +static void dequeue_task(struct rq *rq, struct task_struct *p, int flags)
> >  {
> > -       p->sched_class->dequeue_task(rq, p, sleep);
> > +       p->sched_class->dequeue_task(rq, p, flags);
> >        p->se.on_rq = 0;
> >  }
> >
> > @@ -1219,26 +1219,26 @@ static int effective_prio(struct task_st
> >  /*
> >  * activate_task - move a task to the runqueue.
> >  */
> > -static void activate_task(struct rq *rq, struct task_struct *p, int wakeup)
> > +static void activate_task(struct rq *rq, struct task_struct *p, int flags)
> >  {
> >        if (p->state == TASK_UNINTERRUPTIBLE)
> >                rq->nr_uninterruptible--;
> >
> >        ftrace_event_task_activate(p, cpu_of(rq));
> > -       enqueue_task(rq, p, wakeup);
> > +       enqueue_task(rq, p, flags);
> >        inc_nr_running(p, rq);
> >  }
> >
> >  /*
> >  * deactivate_task - remove a task from the runqueue.
> >  */
> > -static void deactivate_task(struct rq *rq, struct task_struct *p, int sleep)
> > +static void deactivate_task(struct rq *rq, struct task_struct *p, int flags)
> >  {
> >        if (p->state == TASK_UNINTERRUPTIBLE)
> >                rq->nr_uninterruptible++;
> >
> >        ftrace_event_task_deactivate(p, cpu_of(rq));
> > -       dequeue_task(rq, p, sleep);
> > +       dequeue_task(rq, p, flags);
> >        dec_nr_running(p, rq);
> >  }
> >
> > @@ -1759,7 +1759,7 @@ out_activate:
> >        else
> >                schedstat_inc(p, se.nr_wakeups_remote);
> >        update_rq_clock(rq);
> > -       activate_task(rq, p, 1);
> > +       activate_task(rq, p, ENQUEUE_WAKEUP);
> >        check_preempt_curr(rq, p);
> >        success = 1;
> >
> > @@ -3968,7 +3968,7 @@ asmlinkage void __sched __schedule(void)
> >                        prev->state = TASK_RUNNING;
> >                } else {
> >                        touch_softlockup_watchdog();
> > -                       deactivate_task(rq, prev, 1);
> > +                       deactivate_task(rq, prev, DEQUEUE_SLEEP);
> >                }
> >                switch_count = &prev->nvcsw;
> >        }
> > @@ -4431,7 +4431,7 @@ EXPORT_SYMBOL(sleep_on_timeout);
> >  void task_setprio(struct task_struct *p, int prio)
> >  {
> >        unsigned long flags;
> > -       int oldprio, prev_resched, on_rq, running;
> > +       int oldprio, prev_resched, on_rq, running, down;
> >        struct rq *rq;
> >        const struct sched_class *prev_class = p->sched_class;
> >
> > @@ -4472,6 +4472,7 @@ void task_setprio(struct task_struct *p,
> >        else
> >                p->sched_class = &fair_sched_class;
> >
> > +       down = (prio > p->prio) ? ENQUEUE_HEAD : 0;
> >        p->prio = prio;
> >
> >  //     trace_special_pid(p->pid, __PRIO(oldprio), PRIO(p));
> > @@ -4480,7 +4481,7 @@ void task_setprio(struct task_struct *p,
> >        if (running)
> >                p->sched_class->set_curr_task(rq);
> >        if (on_rq) {
> > -               enqueue_task(rq, p, 0);
> > +               enqueue_task(rq, p, down);
> >                check_class_changed(rq, p, prev_class, oldprio, running);
> >        }
> >  //     trace_special(prev_resched, _need_resched(), 0);
> > Index: linux-2.6.24.7-ibmrt2.6-view/kernel/sched_fair.c
> > ===================================================================
> > --- linux-2.6.24.7-ibmrt2.6-view.orig/kernel/sched_fair.c
> > +++ linux-2.6.24.7-ibmrt2.6-view/kernel/sched_fair.c
> > @@ -756,10 +756,11 @@ static inline struct sched_entity *paren
> >  * increased. Here we update the fair scheduling stats and
> >  * then put the task into the rbtree:
> >  */
> > -static void enqueue_task_fair(struct rq *rq, struct task_struct *p, int wakeup)
> > +static void enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> >  {
> >        struct cfs_rq *cfs_rq;
> >        struct sched_entity *se = &p->se;
> > +       int wakeup = flags & ENQUEUE_WAKEUP;
> 
> Minor nit: was it necessary to create a new int, why not just flags &=
> ENQUEUE_WAKEUP, plus subsequent renaming where necessary.
> 
> 


Well... I've copied the entire function here for context:

static void enqueue_task_fair(struct rq *rq, struct task_struct *p, int
flags)
{
	struct cfs_rq *cfs_rq;
	struct sched_entity *se = &p->se;
	int wakeup = flags & ENQUEUE_WAKEUP;

	for_each_sched_entity(se) {
		if (se->on_rq)
			break;
		cfs_rq = cfs_rq_of(se);
		enqueue_entity(cfs_rq, se, wakeup);
		wakeup = 1;
	}
}

Note that "wakeup = 1;" for all but the initial entity which uses the
flag that was passed in.  So if this is correct behavior, then the new
integer seems like a reasonable approach to me.  Note that the
dequeue_task_fair has a parallel implementation.

Peter, can you explain why only the first entity is subject to the value
of the passed-in flags in these two functions.  I understand this was
the orginal behavior as well.

> >
> >        for_each_sched_entity(se) {
> >                if (se->on_rq)
> > @@ -775,10 +776,11 @@ static void enqueue_task_fair(struct rq
> >  * decreased. We remove the task from the rbtree and
> >  * update the fair scheduling stats:
> >  */
> > -static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int sleep)
> > +static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> >  {
> >        struct cfs_rq *cfs_rq;
> >        struct sched_entity *se = &p->se;
> > +       int sleep = flags & DEQUEUE_SLEEP;
> >
> >        for_each_sched_entity(se) {
> >                cfs_rq = cfs_rq_of(se);
> > Index: linux-2.6.24.7-ibmrt2.6-view/kernel/sched_idletask.c
> > ===================================================================
> > --- linux-2.6.24.7-ibmrt2.6-view.orig/kernel/sched_idletask.c
> > +++ linux-2.6.24.7-ibmrt2.6-view/kernel/sched_idletask.c
> > @@ -31,7 +31,7 @@ static struct task_struct *pick_next_tas
> >  * message if some code attempts to do it:
> >  */
> >  static void
> > -dequeue_task_idle(struct rq *rq, struct task_struct *p, int sleep)
> > +dequeue_task_idle(struct rq *rq, struct task_struct *p, int flags)
> >  {
> >        spin_unlock_irq(&rq->lock);
> >        printk(KERN_ERR "bad: scheduling from the idle thread!\n");
> > Index: linux-2.6.24.7-ibmrt2.6-view/kernel/sched_rt.c
> > ===================================================================
> > --- linux-2.6.24.7-ibmrt2.6-view.orig/kernel/sched_rt.c
> > +++ linux-2.6.24.7-ibmrt2.6-view/kernel/sched_rt.c
> > @@ -181,11 +181,16 @@ unsigned long rt_nr_uninterruptible_cpu(
> >        return cpu_rq(cpu)->rt.rt_nr_uninterruptible;
> >  }
> >
> > -static void enqueue_task_rt(struct rq *rq, struct task_struct *p, int wakeup)
> > +static void enqueue_task_rt(struct rq *rq, struct task_struct *p, int flags)
> >  {
> >        struct rt_prio_array *array = &rq->rt.active;
> >
> > -       list_add_tail(&p->run_list, array->queue + p->prio);
> > +
> > +       if (unlikely(flags & ENQUEUE_HEAD))
> > +               list_add(&p->run_list, array->queue + p->prio);
> > +       else
> > +               list_add_tail(&p->run_list, array->queue + p->prio);
> > +
> >        __set_bit(p->prio, array->bitmap);
> >        inc_rt_tasks(p, rq);
> >
> > @@ -196,7 +201,7 @@ static void enqueue_task_rt(struct rq *r
> >  /*
> >  * Adding/removing a task to/from a priority array:
> >  */
> > -static void dequeue_task_rt(struct rq *rq, struct task_struct *p, int sleep)
> > +static void dequeue_task_rt(struct rq *rq, struct task_struct *p, int flags)
> >  {
> >        struct rt_prio_array *array = &rq->rt.active;
> >
> > @@ -306,7 +311,7 @@ static void put_prev_task_rt(struct rq *
> >  #define RT_MAX_TRIES 3
> >
> >  static int double_lock_balance(struct rq *this_rq, struct rq *busiest);
> > -static void deactivate_task(struct rq *rq, struct task_struct *p, int sleep);
> > +static void deactivate_task(struct rq *rq, struct task_struct *p, int flags);
> >
> >  static int pick_rt_task(struct rq *rq, struct task_struct *p, int cpu)
> >  {
> >
> >
> 
> Lastly, this patch didn't apply cleanly for me! It is very possible
> that I'm just doing something stupid, but here is what happened when I
> tried.
> tar xjf ../kernel/linux-2.6.24.tar.bz2
> cd linux-2.6.24
> bunzip2 -c ../../kernel/patch-2.6.24.7.bz2 | patch -p1
> bunzip2 -c ../patch-2.6.24.7-rt14.bz2 | patch -p1
> 
> patch -p1 < ../dvhart.patch


Hrm.. well, I suspect a problem with saving off my patch from the list.
I saved it from the list, removed the email headers and footer and then
used ketchup and quilt to apply it:

$ ketchup -d 2.6.24.7-rt14 -G 2.6.24.7-rt14
$ cd 2.6.24.7-rt14
$ mkdir patches
$ quilt import ~/Desktop/backport.patch
$ quilt push
Applying patch backport.patch
patching file include/linux/sched.h
patching file kernel/sched.c
patching file kernel/sched_fair.c
Hunk #1 succeeded at 760 (offset 4 lines).
Hunk #2 succeeded at 780 (offset 4 lines).
patching file kernel/sched_idletask.c
patching file kernel/sched_rt.c

Now at patch backport.patch

Give it another shot, and let me know if you still run into problems.
I've attached a refreshed patch to account for the "offset 4" messages
above.

Thanks,

Darren

> patching file include/linux/sched.h
> Hunk #1 FAILED at 897.
> 1 out of 1 hunk FAILED -- saving rejects to file include/linux/sched.h.rej
> patching file kernel/sched.c
> Hunk #1 succeeded at 1046 with fuzz 1.
> Hunk #2 FAILED at 1155.
> Hunk #3 FAILED at 1219.
> Hunk #4 FAILED at 1759.
> Hunk #5 FAILED at 3968.
> Hunk #6 FAILED at 4431.
> Hunk #7 FAILED at 4472.
> Hunk #8 FAILED at 4481.
> 7 out of 8 hunks FAILED -- saving rejects to file kernel/sched.c.rej
> patching file kernel/sched_fair.c
> Hunk #1 FAILED at 756.
> Hunk #2 FAILED at 776.
> 2 out of 2 hunks FAILED -- saving rejects to file kernel/sched_fair.c.rej
> patching file kernel/sched_idletask.c
> Hunk #1 succeeded at 31 with fuzz 2.
> patching file kernel/sched_rt.c
> Hunk #1 FAILED at 181.
> Hunk #2 FAILED at 201.
> 2 out of 3 hunks FAILED -- saving rejects to file kernel/sched_rt.c.rej
> 
> Thanks
> John
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
Darren Hart
Real-Time Linux Team Lead
IBM Linux Technology Center

--=-i9Kssh/xe2re/ESrIcUy
Content-Disposition: attachment; filename=backport.patch
Content-Type: text/x-patch; name=backport.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit

Enqueue deprioritized RT tasks to head of prio array

This patch backports Peter Z's enqueue to head of prio array on 
de-prioritization to 2.6.24.7-rt14 which doesn't have the 
enqueue_rt_entity and associated changes.

I've run several long running real-time java benchmarks and it's
holding so far.  Steven, please consider this patch for inclusion
in the next 2.6.24.7-rtX release.

Peter, I didn't include your Signed-off-by as only about half your
original patch applied to 2.6.24.7-r14.  If you're happy with this
version, would you also sign off?

Signed-off-by: Darren Hart <dvhltc@us.ibm.com>


---
Index: 2.6.24.7-rt14/include/linux/sched.h
===================================================================
--- 2.6.24.7-rt14.orig/include/linux/sched.h	2008-07-05 07:52:45.000000000 -0700
+++ 2.6.24.7-rt14/include/linux/sched.h	2008-07-05 07:54:54.000000000 -0700
@@ -897,11 +897,16 @@
 struct rq;
 struct sched_domain;
 
+#define ENQUEUE_WAKEUP	0x01
+#define ENQUEUE_HEAD	0x02
+
+#define DEQUEUE_SLEEP	0x01
+
 struct sched_class {
 	const struct sched_class *next;
 
-	void (*enqueue_task) (struct rq *rq, struct task_struct *p, int wakeup);
-	void (*dequeue_task) (struct rq *rq, struct task_struct *p, int sleep);
+	void (*enqueue_task) (struct rq *rq, struct task_struct *p, int flags);
+	void (*dequeue_task) (struct rq *rq, struct task_struct *p, int flags);
 	void (*yield_task) (struct rq *rq);
 	int  (*select_task_rq)(struct task_struct *p, int sync);
 
Index: 2.6.24.7-rt14/kernel/sched.c
===================================================================
--- 2.6.24.7-rt14.orig/kernel/sched.c	2008-07-05 07:52:45.000000000 -0700
+++ 2.6.24.7-rt14/kernel/sched.c	2008-07-05 07:54:54.000000000 -0700
@@ -1046,7 +1046,7 @@
  /*  15 */ 119304647, 148102320, 186737708, 238609294, 286331153,
 };
 
-static void activate_task(struct rq *rq, struct task_struct *p, int wakeup);
+static void activate_task(struct rq *rq, struct task_struct *p, int flags);
 
 /*
  * runqueue iterator, to support SMP load-balancing between different
@@ -1155,16 +1155,16 @@
 	p->se.load.inv_weight = prio_to_wmult[p->static_prio - MAX_RT_PRIO];
 }
 
-static void enqueue_task(struct rq *rq, struct task_struct *p, int wakeup)
+static void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
 {
 	sched_info_queued(p);
-	p->sched_class->enqueue_task(rq, p, wakeup);
+	p->sched_class->enqueue_task(rq, p, flags);
 	p->se.on_rq = 1;
 }
 
-static void dequeue_task(struct rq *rq, struct task_struct *p, int sleep)
+static void dequeue_task(struct rq *rq, struct task_struct *p, int flags)
 {
-	p->sched_class->dequeue_task(rq, p, sleep);
+	p->sched_class->dequeue_task(rq, p, flags);
 	p->se.on_rq = 0;
 }
 
@@ -1219,26 +1219,26 @@
 /*
  * activate_task - move a task to the runqueue.
  */
-static void activate_task(struct rq *rq, struct task_struct *p, int wakeup)
+static void activate_task(struct rq *rq, struct task_struct *p, int flags)
 {
 	if (p->state == TASK_UNINTERRUPTIBLE)
 		rq->nr_uninterruptible--;
 
 	ftrace_event_task_activate(p, cpu_of(rq));
-	enqueue_task(rq, p, wakeup);
+	enqueue_task(rq, p, flags);
 	inc_nr_running(p, rq);
 }
 
 /*
  * deactivate_task - remove a task from the runqueue.
  */
-static void deactivate_task(struct rq *rq, struct task_struct *p, int sleep)
+static void deactivate_task(struct rq *rq, struct task_struct *p, int flags)
 {
 	if (p->state == TASK_UNINTERRUPTIBLE)
 		rq->nr_uninterruptible++;
 
 	ftrace_event_task_deactivate(p, cpu_of(rq));
-	dequeue_task(rq, p, sleep);
+	dequeue_task(rq, p, flags);
 	dec_nr_running(p, rq);
 }
 
@@ -1759,7 +1759,7 @@
 	else
 		schedstat_inc(p, se.nr_wakeups_remote);
 	update_rq_clock(rq);
-	activate_task(rq, p, 1);
+	activate_task(rq, p, ENQUEUE_WAKEUP);
 	check_preempt_curr(rq, p);
 	success = 1;
 
@@ -3968,7 +3968,7 @@
 			prev->state = TASK_RUNNING;
 		} else {
 			touch_softlockup_watchdog();
-			deactivate_task(rq, prev, 1);
+			deactivate_task(rq, prev, DEQUEUE_SLEEP);
 		}
 		switch_count = &prev->nvcsw;
 	}
@@ -4431,7 +4431,7 @@
 void task_setprio(struct task_struct *p, int prio)
 {
 	unsigned long flags;
-	int oldprio, prev_resched, on_rq, running;
+	int oldprio, prev_resched, on_rq, running, down;
 	struct rq *rq;
 	const struct sched_class *prev_class = p->sched_class;
 
@@ -4472,6 +4472,7 @@
 	else
 		p->sched_class = &fair_sched_class;
 
+ 	down = (prio > p->prio) ? ENQUEUE_HEAD : 0;
 	p->prio = prio;
 
 //	trace_special_pid(p->pid, __PRIO(oldprio), PRIO(p));
@@ -4480,7 +4481,7 @@
 	if (running)
 		p->sched_class->set_curr_task(rq);
 	if (on_rq) {
-		enqueue_task(rq, p, 0);
+ 		enqueue_task(rq, p, down);
 		check_class_changed(rq, p, prev_class, oldprio, running);
 	}
 //	trace_special(prev_resched, _need_resched(), 0);
Index: 2.6.24.7-rt14/kernel/sched_fair.c
===================================================================
--- 2.6.24.7-rt14.orig/kernel/sched_fair.c	2008-07-05 07:52:45.000000000 -0700
+++ 2.6.24.7-rt14/kernel/sched_fair.c	2008-07-05 07:54:54.000000000 -0700
@@ -760,10 +760,11 @@
  * increased. Here we update the fair scheduling stats and
  * then put the task into the rbtree:
  */
-static void enqueue_task_fair(struct rq *rq, struct task_struct *p, int wakeup)
+static void enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 {
 	struct cfs_rq *cfs_rq;
 	struct sched_entity *se = &p->se;
+	int wakeup = flags & ENQUEUE_WAKEUP;
 
 	for_each_sched_entity(se) {
 		if (se->on_rq)
@@ -779,10 +780,11 @@
  * decreased. We remove the task from the rbtree and
  * update the fair scheduling stats:
  */
-static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int sleep)
+static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 {
 	struct cfs_rq *cfs_rq;
 	struct sched_entity *se = &p->se;
+	int sleep = flags & DEQUEUE_SLEEP;
 
 	for_each_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
Index: 2.6.24.7-rt14/kernel/sched_idletask.c
===================================================================
--- 2.6.24.7-rt14.orig/kernel/sched_idletask.c	2008-07-05 07:52:45.000000000 -0700
+++ 2.6.24.7-rt14/kernel/sched_idletask.c	2008-07-05 07:54:54.000000000 -0700
@@ -31,7 +31,7 @@
  * message if some code attempts to do it:
  */
 static void
-dequeue_task_idle(struct rq *rq, struct task_struct *p, int sleep)
+dequeue_task_idle(struct rq *rq, struct task_struct *p, int flags)
 {
 	spin_unlock_irq(&rq->lock);
 	printk(KERN_ERR "bad: scheduling from the idle thread!\n");
Index: 2.6.24.7-rt14/kernel/sched_rt.c
===================================================================
--- 2.6.24.7-rt14.orig/kernel/sched_rt.c	2008-07-05 07:52:45.000000000 -0700
+++ 2.6.24.7-rt14/kernel/sched_rt.c	2008-07-05 07:54:54.000000000 -0700
@@ -181,11 +181,16 @@
 	return cpu_rq(cpu)->rt.rt_nr_uninterruptible;
 }
 
-static void enqueue_task_rt(struct rq *rq, struct task_struct *p, int wakeup)
+static void enqueue_task_rt(struct rq *rq, struct task_struct *p, int flags)
 {
 	struct rt_prio_array *array = &rq->rt.active;
 
-	list_add_tail(&p->run_list, array->queue + p->prio);
+
+ 	if (unlikely(flags & ENQUEUE_HEAD))
+		list_add(&p->run_list, array->queue + p->prio);
+ 	else
+		list_add_tail(&p->run_list, array->queue + p->prio);
+
 	__set_bit(p->prio, array->bitmap);
 	inc_rt_tasks(p, rq);
 
@@ -196,7 +201,7 @@
 /*
  * Adding/removing a task to/from a priority array:
  */
-static void dequeue_task_rt(struct rq *rq, struct task_struct *p, int sleep)
+static void dequeue_task_rt(struct rq *rq, struct task_struct *p, int flags)
 {
 	struct rt_prio_array *array = &rq->rt.active;
 
@@ -306,7 +311,7 @@
 #define RT_MAX_TRIES 3
 
 static int double_lock_balance(struct rq *this_rq, struct rq *busiest);
-static void deactivate_task(struct rq *rq, struct task_struct *p, int sleep);
+static void deactivate_task(struct rq *rq, struct task_struct *p, int flags);
 
 static int pick_rt_task(struct rq *rq, struct task_struct *p, int cpu)
 {

--=-i9Kssh/xe2re/ESrIcUy--

