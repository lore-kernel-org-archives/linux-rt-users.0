From: "John Kacur" <jkacur@gmail.com>
Subject: Re: [RFC][PATCH] fix SCHED_FIFO spec violation (backport)
Date: Tue, 15 Jul 2008 11:19:31 +0200
Message-ID: <520f0cf10807150219y2cafd0cbqed1550f5bc8ad4cf@mail.gmail.com>
References: <1215124898.11333.20.camel@Aeon>
	 <520f0cf10807040608w7e8cea01r39e2489269bc9f73@mail.gmail.com>
	 <1215271090.18491.20.camel@Aeon> <1216108996.12595.133.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Darren Hart" <dvhltc@us.ibm.com>, linux-rt-users@vger.kernel.org,
	"Steven Rostedt" <rostedt@goodmis.org>,
	"Clark Williams" <williams@redhat.com>,
	"Ingo Molnar" <mingo@elte.hu>,
	"Thomas Gleixner" <tglx@linutronix.de>,
	"Dmitry Adamushko" <dmitry.adamushko@gmail.com>,
	"Gregory Haskins" <ghaskins@novell.com>
To: "Peter Zijlstra" <a.p.zijlstra@chello.nl>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.225]:26591 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753509AbYGOJTc (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 15 Jul 2008 05:19:32 -0400
Received: by rv-out-0506.google.com with SMTP id k40so5898656rvb.1
        for <linux-rt-users@vger.kernel.org>; Tue, 15 Jul 2008 02:19:31 -0700 (PDT)
In-Reply-To: <1216108996.12595.133.camel@twins>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Jul 15, 2008 at 10:03 AM, Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
> On Sat, 2008-07-05 at 08:18 -0700, Darren Hart wrote:
>> On Fri, 2008-07-04 at 15:08 +0200, John Kacur wrote:
>
>> > On Fri, Jul 4, 2008 at 12:41 AM, Darren Hart <dvhltc@us.ibm.com> wrote:
>> > > Enqueue deprioritized RT tasks to head of prio array
>> > >
>> > > This patch backports Peter Z's enqueue to head of prio array on
>> > > de-prioritization to 2.6.24.7-rt14 which doesn't have the
>> > > enqueue_rt_entity and associated changes.
>> > >
>> > > I've run several long running real-time java benchmarks and it's
>> > > holding so far.  Steven, please consider this patch for inclusion
>> > > in the next 2.6.24.7-rtX release.
>> > >
>> > > Peter, I didn't include your Signed-off-by as only about half your
>> > > original patch applied to 2.6.24.7-r14.  If you're happy with this
>> > > version, would you also sign off?
>> > >
>> > > Signed-off-by: Darren Hart <dvhltc@us.ibm.com>
>> > >
>> > >
>> > > ---
>> > > Index: linux-2.6.24.7-ibmrt2.6-view/include/linux/sched.h
>> > > ===================================================================
>> > > --- linux-2.6.24.7-ibmrt2.6-view.orig/include/linux/sched.h
>> > > +++ linux-2.6.24.7-ibmrt2.6-view/include/linux/sched.h
>> > > @@ -897,11 +897,16 @@ struct uts_namespace;
>> > >  struct rq;
>> > >  struct sched_domain;
>> > >
>> > > +#define ENQUEUE_WAKEUP 0x01
>> > > +#define ENQUEUE_HEAD   0x02
>> > > +
>> > > +#define DEQUEUE_SLEEP  0x01
>> > > +
>> >
>> > Question: is ENQUEUE_WAKEUP equal to DEQUEUE_SLEEP by design or
>> > coincidence?
>>
>> Coincidence.  The ENQUEUE_* flags are only to be used with the
>> enqueue_task* methods, while the DEQUEUE_* flags are for deqeue_task*.
>> Note that the conversion of sleep to the DEQUEUE_SLEEP flag isn't really
>> necessary as there is only the one flag, but it makes the calls
>> parallel, which I suspect was Peter's intention (but I speculate here).
>
> Indeed.
>
>> > The renaming of wakeup and sleep to flags makes it at
>> > least superficially seem like they overlap. Since a large part of the
>> > patch is renaming, it might be easier to understand if the renaming
>> > was done as a separate patch, but on the other hand, that is probably
>> > just a PITA. :)
>>
>> Seems a small enough patch to be all in one to me.  If others object
>> I'll split it out, but again, I tried to keep the backport as close to
>> Peter's original patch as possible.
>
> I just hacked together what was needed to post out an RFC, never made it
> a 'pretty' series ;-)
>
> One could go the extra length and make it multiple patches, but its not
> too big, so I'm not sure we should worry about that.
>
>> >
>> > >  struct sched_class {
>> > >        const struct sched_class *next;
>> > >
>> > > -       void (*enqueue_task) (struct rq *rq, struct task_struct *p, int wakeup);
>> > > -       void (*dequeue_task) (struct rq *rq, struct task_struct *p, int sleep);
>> > > +       void (*enqueue_task) (struct rq *rq, struct task_struct *p, int flags);
>> > > +       void (*dequeue_task) (struct rq *rq, struct task_struct *p, int flags);
>> > >        void (*yield_task) (struct rq *rq);
>> > >        int  (*select_task_rq)(struct task_struct *p, int sync);
>> > >
>
>> > > Index: linux-2.6.24.7-ibmrt2.6-view/kernel/sched_fair.c
>> > > ===================================================================
>> > > --- linux-2.6.24.7-ibmrt2.6-view.orig/kernel/sched_fair.c
>> > > +++ linux-2.6.24.7-ibmrt2.6-view/kernel/sched_fair.c
>> > > @@ -756,10 +756,11 @@ static inline struct sched_entity *paren
>> > >  * increased. Here we update the fair scheduling stats and
>> > >  * then put the task into the rbtree:
>> > >  */
>> > > -static void enqueue_task_fair(struct rq *rq, struct task_struct *p, int wakeup)
>> > > +static void enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>> > >  {
>> > >        struct cfs_rq *cfs_rq;
>> > >        struct sched_entity *se = &p->se;
>> > > +       int wakeup = flags & ENQUEUE_WAKEUP;
>> >
>> > Minor nit: was it necessary to create a new int, why not just flags &=
>> > ENQUEUE_WAKEUP, plus subsequent renaming where necessary.
>
> As Darren already said, the rename of wakeup/sleep to flags is needed
> because of the multiple value thing and consistency.
>
>> Well... I've copied the entire function here for context:
>>
>> static void enqueue_task_fair(struct rq *rq, struct task_struct *p, int
>> flags)
>> {
>>       struct cfs_rq *cfs_rq;
>>       struct sched_entity *se = &p->se;
>>       int wakeup = flags & ENQUEUE_WAKEUP;
>>
>>       for_each_sched_entity(se) {
>>               if (se->on_rq)
>>                       break;
>>               cfs_rq = cfs_rq_of(se);
>>               enqueue_entity(cfs_rq, se, wakeup);
>>               wakeup = 1;
>>       }
>> }
>>
>> Note that "wakeup = 1;" for all but the initial entity which uses the
>> flag that was passed in.  So if this is correct behavior, then the new
>> integer seems like a reasonable approach to me.  Note that the
>> dequeue_task_fair has a parallel implementation.
>>
>> Peter, can you explain why only the first entity is subject to the value
>> of the passed-in flags in these two functions.  I understand this was
>> the orginal behavior as well.
>
> group scheduling :-)
>
> So, if you haven't ran away by now I'll continue explaining.
>
> The current group scheduler is a hierarchy of schedulers, what
> enqueue_task_fair() does is enqueue the task 'somewhere' in that
> hierarchy. And then walk up the hierarchy checking to see if each parent
> is already enqueued (the if (se->on_rq) bit). If so, it can stop since
> all further parents will then too be already enqueued. However, if the
> parent is not already enqueued if must enqueue him too.
>
> So what we do is dequeue sleep a scheduler from its parent scheduler
> when there are no more tasks to run, and enqueue wakeup when a new
> 'task' arrives. Note that a 'task' can be a so called super-task which
> is essentially another scheduler.
>
>

Hey Peter, thanks for the excellent explanations. I think Darren is
waiting for a Signed-off-by: you, since it is a backport of your work.
I was just reviewing it for fun. Darren if you want to add a
Reviewed-by: John Kacur <jkacur at gmail dot com>
to the patch, pls feel free too, but it is not necessary.
