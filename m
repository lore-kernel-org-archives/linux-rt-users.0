From: Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH V2 3/3] sched/deadline: Tracepoints for deadline scheduler
Date: Tue, 29 Mar 2016 14:37:18 -0300
Message-ID: <56FABD4E.3080008@redhat.com>
References: <cover.1459182044.git.bristot@redhat.com>
 <14f6caa05f73ceba69eff035ac542cad671552b3.1459182044.git.bristot@redhat.com>
 <20160329151649.GA12845@twins.programming.kicks-ass.net>
 <20160329115700.40acb336@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juri Lelli <juri.lelli@arm.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160329115700.40acb336@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org



On 03/29/2016 12:57 PM, Steven Rostedt wrote:
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
>> > On Mon, Mar 28, 2016 at 01:50:51PM -0300, Daniel Bristot de Oliveira wrote:
>>> > > @@ -733,7 +738,9 @@ static void update_curr_dl(struct rq *rq)
>>> > >  
>>> > >  throttle:
>>> > >  	if (dl_runtime_exceeded(dl_se) || dl_se->dl_yielded) {
>>> > > +		trace_sched_deadline_yield(&rq->curr->dl);
>>> > >  		dl_se->dl_throttled = 1;
>>> > > +		trace_sched_deadline_throttle(dl_se);  
>> > 
>> > This is just really very sad.
> I agree. This should be a single tracepoint here. Especially since it
> seems that dl_se == &rq->curr->dl :-)
> 
> But perhaps we should add that generic sys_yield() tracepoint, to be
> able to see that the task was throttled because of a yield call.
> 
> We still want to see a task yield, and then throttle because of it. The
> deadline/runtime should reflect the information correctly.

The above tracepoints are conditional, if dl_se->dl_yielded, only the
yield tracepoint will happen. If !dl_se->dl_yielded, only the throttle
tracepoint will happen.

We can try to join the sched_deadline_(yield|throttle|block) on a single
tracepoint, but IMHO having them separated is more intuitive for users.

> Sure, we'll probably want to figure out a better way to see deadline
> tasks blocked. Probably can see that from sched switch though, as it
> would be in the blocked state as it scheduled out.

We can guess that in the sched switch, but it currently does not show
deadline specific information (deadline, runtime, now (in the timer used
by the scheduler), and they are relevant in the analysis of deadline tasks.

> 
> Hmm, I probably could add tracing infrastructure that would let us
> extend existing tracepoints. That is, without modifying sched_switch,
> we could add a new tracepoint that when enabled, would attach itself to
> the sched_switch tracepoint and record different information. Like a
> special sched_switch_deadline tracepoint, that would record the existing
> runtime,deadline and period for deadline tasks. It wont add more
> tracepoints into the core scheduler, but use the existing one.

You can display the joined version of sched deadline
(yield|throttle|block) tracepoint, but IMHO this will just turn things
more complex than they need to be, and will possibly add overhead to the
sched_switch tracepoint, that is more used by non-deadline users than by
deadline users.

Moreover, deadline users will probably want to see only the deadline
data, and have to use complex enabling/filtering options is really
really not intuitive for users (that are not kernel developers).
