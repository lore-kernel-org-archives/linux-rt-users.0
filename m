From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch 1/8] Add rt_nr_running accounting
Date: Sat, 20 Oct 2007 22:13:19 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0710202211510.21872@gandalf.stny.rr.com>
References: <20071019184254.456160632@goodmis.org>  <20071019184336.195447315@goodmis.org>
 <b647ffbd0710200945p2bb87d7fk1110bdcf56f6218d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Gregory Haskins <ghaskins@novell.com>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Dmitry Adamushko <dmitry.adamushko@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:55704 "EHLO
	ms-smtp-01.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750764AbXJUCN7 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 20 Oct 2007 22:13:59 -0400
In-Reply-To: <b647ffbd0710200945p2bb87d7fk1110bdcf56f6218d@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


Hi Dmitry,

--
On Sat, 20 Oct 2007, Dmitry Adamushko wrote:

> On 19/10/2007, Steven Rostedt <rostedt@goodmis.org> wrote:
> > [ ... ]
> > Index: linux-test.git/kernel/sched.c
> > ===================================================================
> > --- linux-test.git.orig/kernel/sched.c  2007-10-19 12:32:39.000000000 -0400
> > +++ linux-test.git/kernel/sched.c       2007-10-19 12:33:09.000000000 -0400
> > @@ -300,6 +300,8 @@ struct rq {
> >          */
> >         unsigned long nr_uninterruptible;
> >
> > +       unsigned long rt_nr_running;
>
> could it be a part of the 'struct rt_rq' instead?

Maybe. I didn't really look too hard to where to put it. Currently, in the
-rt patch, it is located in struct rq, so I just did the same. I may be
able to move it.

>
> >
> > +static inline void inc_rt_tasks(struct task_struct *p, struct rq *rq)
> > +{
> > +       if (rt_task(p))
> > +               rq->rt_nr_running++;
> > +}
> > +
> > +static inline void dec_rt_tasks(struct task_struct *p, struct rq *rq)
> > +{
> > +       if (rt_task(p)) {
> > +               WARN_ON(!rq->rt_nr_running);
> > +               rq->rt_nr_running--;
> > +       }
> > +}
> > +
> >  static void enqueue_task_rt(struct rq *rq, struct task_struct *p, int wakeup)
> >  {
> >         struct rt_prio_array *array = &rq->rt.active;
> >
> >         list_add_tail(&p->run_list, array->queue + p->prio);
> >         __set_bit(p->prio, array->bitmap);
> > +
> > +       inc_rt_tasks(p, rq);
>
> why do you need the rt_task(p) check in {inc,dec}_rt_tasks() ?

Me being paranoid ;-)

>
> {enqueue,dequeue}_task_rt() seem to be the only callers and they will
> crash (or corrupt memory) anyway in the case of ! rt_task(p) (sure,
> this case would mean something is broken somewhere wrt sched_class
> handling).

Exactly, I was just being safe. We could add a WARN_ON(!rt_task) there.

-- Steve
