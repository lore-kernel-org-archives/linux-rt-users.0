From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH V2 3/3] sched/deadline: Tracepoints for deadline
 scheduler
Date: Tue, 29 Mar 2016 11:57:00 -0400
Message-ID: <20160329115700.40acb336@gandalf.local.home>
References: <cover.1459182044.git.bristot@redhat.com>
	<14f6caa05f73ceba69eff035ac542cad671552b3.1459182044.git.bristot@redhat.com>
	<20160329151649.GA12845@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juri Lelli <juri.lelli@arm.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160329151649.GA12845@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 29 Mar 2016 17:16:49 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Mar 28, 2016 at 01:50:51PM -0300, Daniel Bristot de Oliveira wrote:
> > @@ -733,7 +738,9 @@ static void update_curr_dl(struct rq *rq)
> >  
> >  throttle:
> >  	if (dl_runtime_exceeded(dl_se) || dl_se->dl_yielded) {
> > +		trace_sched_deadline_yield(&rq->curr->dl);
> >  		dl_se->dl_throttled = 1;
> > +		trace_sched_deadline_throttle(dl_se);  
> 
> This is just really very sad.

I agree. This should be a single tracepoint here. Especially since it
seems that dl_se == &rq->curr->dl :-)

But perhaps we should add that generic sys_yield() tracepoint, to be
able to see that the task was throttled because of a yield call.

We still want to see a task yield, and then throttle because of it. The
deadline/runtime should reflect the information correctly.


> 
> >  		__dequeue_task_dl(rq, curr, 0);
> >  		if (unlikely(dl_se->dl_boosted || !start_dl_timer(curr)))
> >  			enqueue_task_dl(rq, curr, ENQUEUE_REPLENISH);
> > @@ -910,6 +917,7 @@ enqueue_dl_entity(struct sched_dl_entity *dl_se,
> >  static void dequeue_dl_entity(struct sched_dl_entity *dl_se)
> >  {
> >  	__dequeue_dl_entity(dl_se);
> > +	trace_sched_deadline_block(dl_se);
> >  }  
> 
> And that's just not going to happen.

Sure, we'll probably want to figure out a better way to see deadline
tasks blocked. Probably can see that from sched switch though, as it
would be in the blocked state as it scheduled out.

Hmm, I probably could add tracing infrastructure that would let us
extend existing tracepoints. That is, without modifying sched_switch,
we could add a new tracepoint that when enabled, would attach itself to
the sched_switch tracepoint and record different information. Like a
special sched_switch_deadline tracepoint, that would record the existing
runtime,deadline and period for deadline tasks. It wont add more
tracepoints into the core scheduler, but use the existing one.

Maybe something to play with while I'm on the flight to San Diego or
Portland.

-- Steve
