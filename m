From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFD/RFC PATCH 5/8] sched: Add proxy execution
Date: Thu, 11 Oct 2018 14:53:25 +0200
Message-ID: <20181011125325.GA9867@hirez.programming.kicks-ass.net>
References: <20181009092434.26221-1-juri.lelli@redhat.com>
 <20181009092434.26221-6-juri.lelli@redhat.com>
 <20181010131048.54afd1b6@luca64>
 <20181011123448.GS9130@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: luca abeni <luca.abeni@santannapisa.it>, mingo@redhat.com,
        rostedt@goodmis.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, claudio@evidence.eu.com,
        tommaso.cucinotta@santannapisa.it, alessio.balsini@gmail.com,
        bristot@redhat.com, will.deacon@arm.com,
        andrea.parri@amarulasolutions.com, dietmar.eggemann@arm.com,
        patrick.bellasi@arm.com, henrik@austad.us,
        linux-rt-users@vger.kernel.org
To: Juri Lelli <juri.lelli@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181011123448.GS9130@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, Oct 11, 2018 at 02:34:48PM +0200, Juri Lelli wrote:
> Hi Luca,
> 
> On 10/10/18 13:10, luca abeni wrote:
> > Hi,
> > 
> > On Tue,  9 Oct 2018 11:24:31 +0200
> > Juri Lelli <juri.lelli@redhat.com> wrote:
> > [...]
> > > +migrate_task:
> > [...]
> > > +	put_prev_task(rq, next);
> > > +	if (rq->curr != rq->idle) {
> > > +		rq->proxy = rq->idle;
> > > +		set_tsk_need_resched(rq->idle);
> > > +		/*
> > > +		 * XXX [juril] don't we still need to migrate @next
> > > to
> > > +		 * @owner's CPU?
> > > +		 */
> > > +		return rq->idle;
> > > +	}
> > 
> > If I understand well, this code ends up migrating the task only if the
> > CPU was previously idle? (scheduling the idle task if the CPU was not
> > previously idle)
> > 
> > Out of curiosity (I admit this is my ignorance), why is this needed?
> > If I understand well, after scheduling the idle task the scheduler will
> > be invoked again (because of the set_tsk_need_resched(rq->idle)) but I
> > do not understand why it is not possible to migrate task "p" immediately
> > (I would just check "rq->curr != p", to avoid migrating the currently
> > scheduled task).
> 
> As the comment suggests, I was also puzzled by this bit.
> 
> I'd be inclined to agree with you, it seems that the only case in which
> we want to "temporarily" schedule the idle task is if the proxy was
> executing (so it just blocked on the mutex and being scheduled out).
> 
> If it wasn't we should be able to let the current "curr" continue
> executing, in this case returning it as next will mean that schedule
> takes the else branch and there isn't an actual context switch.
> 
> > > +	rq->proxy = &fake_task;
> 
> [...]
> 
> We can maybe also rq->proxy = rq->curr and return rq->curr in such a
> case, instead of the below?
> 
> > > +	return NULL; /* Retry task selection on _this_ CPU. */
> 
> Peter, what are we missing? :-)

I think it was the safe and simple choice; note that we're not migrating
just a single @p, but a whole chain of @p. rq->curr must not be any of the
possible @p's. rq->idle, is per definition not one of the @p's.

Does that make sense?
