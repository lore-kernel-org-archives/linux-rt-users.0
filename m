From: Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH 3/4] sched/deadline: Tracepoints for deadline scheduler
Date: Tue, 23 Feb 2016 13:19:18 -0300
Message-ID: <56CC8686.5090404@redhat.com>
References: <cover.1456157869.git.bristot@redhat.com>
 <f3b54958f216d36be59363815a3d75a0636cda8b.1456157869.git.bristot@redhat.com>
 <20160222173259.GM6357@twins.programming.kicks-ass.net>
 <20160222124854.3816fec4@gandalf.local.home>
 <20160222213017.GN6357@twins.programming.kicks-ass.net>
 <20160222173043.24873ae8@gandalf.local.home>
 <20160223104408.GO6357@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juri Lelli <juri.lelli@gmail.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160223104408.GO6357@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org



On 02/23/2016 07:44 AM, Peter Zijlstra wrote:
>>> Worse, the proposed tracepoints are atrocious, look at crap like this:
>>> > > 
>>>> > > > +		if (trace_sched_deadline_yield_enabled()) {
>>>> > > > +			u64 delta_exec = rq_clock_task(rq) - p->se.exec_start;
>>>> > > > +			/* Subtract the last run till now */
>>>> > > > +			if (likely((s64)delta_exec > 0))
>>>> > > > +				p->dl.runtime -= delta_exec;
>>>> > > > +			trace_sched_deadline_yield(&p->dl);
>>>> > > > +		}  
>>> > > 
>>> > > tracepoints should _NEVER_ change state, ever.
>> > 
>> > Heh, it's not really changing state. The code directly after this is:
>> > 
>> > 	p->dl.runtime = 0;
> Yes, it more or less 'works', but its still atrocious shite. Its the
> worst kind of anti pattern possible.
> 
> Suppose someone comes and removes that line, and ignores the tracepoint
> stuff, because, hell its a tracepoint, those don't modify stuff.
> 
> Its just really, utterly bad practice.

It is possible to clean up this by removing the "p->dl.runtime = 0;"
from yield_task_dl(), to carry the dl_runtime until update_curr_dl().
We end up not proposing this change because we thought it could be
too much intrusive. But seems that it was the correct approach.

Btw, your patch for "Always calculate end of period on sched_yield()"
already do the necessary clean up, so in the possible next version of
these tracepoint the hack will disappear. 

>>> > > So tell me why these specific tracepoints and why the existing ones
>>> > > could not be extended to include this information. For example, why a
>>> > > trace_sched_dealine_yield, and not a generic trace_sched_yield() that
>>> > > works for all classes.
>> > 
>> > But what about reporting actual runtime, and when the next period will
>> > come. That only matters for deadline.
> How is that an answer to the question? Are you implying a generic
> trace_sched_yield() call could not do this?

I agree that a trace_sched_yield() could partially do this. But each
scheduler would have its own specific data to be printed, and it is hard
to define how many and the type of these data.

>>> > > But do not present me with a bunch of random arse, hacked together
>>> > > tracepoints and tell me they might be useful, maybe.
>> > 
>> > 
>> > They ARE useful. These are the tracepoints I'm currently using to
>> > debug the deadline scheduler with. They have been indispensable for my
>> > current work.
> They are, most obviously, a hacked together debug session for sure. This
> is _NOT_ what you commit.
> 
> Now ideally we'd do something like the below, but because trainwreck, we
> cannot actually do this I think :-(

I do liked this patch, but I agree that bad things can happen on
applications that already use sched:sched_switch :-(.
 
> I really dislike tracepoints, and I'm >.< close to proposing a patch
> removing them all from the scheduler.

Scheduler tracepoints become such a standard not only for debugging the
kernel, but also for understanding performance issues and finding
optimizations for user-space tasks, e.g. finding the best way to spread
task among processors on a large NUMA box. Many people would cry
if sched tracepoints disappears :'-(.

> @@ -132,33 +177,63 @@ TRACE_EVENT(sched_switch,
>  	TP_STRUCT__entry(
>  		__array(	char,	prev_comm,	TASK_COMM_LEN	)
>  		__field(	pid_t,	prev_pid			)
> -		__field(	int,	prev_prio			)
> +		__field(	int,	prev_policy			)
> +		__field(	s64,	prev_f1				)
> +		__field(	u64,	prev_f2				)
> +		__field(	u64,	prev_f3				)

This helps me to explain why did I chose to create deadline specific
tracepoints.

It is not possible to define in advance a common set of parameters to be
traced/printed for all future (exotic) scheduler, because each scheduler
will use its own set of parameters. Hence, the number and type of the
parameter can vary. How many fields do we need? and which are the types
of these fields? What if a scheduler needs two s64 fields and no u64?

Moreover, it is not possible to define the changes that will be needed
on classical schedulers algorithms for them to fit on Linux's
abstractions and restrictions. Therefore, it is not safe to mention
that LLF would (theoretically) use the same set of parameters of a EDF
scheduler, because the theoretical LLF would need to be modified
to fit on Linux. For example, there is no throttling concept on the
classical deadline scheduler. So, the proposed tracepoints are only valid
for Linux's sched deadline scheduler (deadline scheduler + CBS).

That is why I believe that it would be a better approach to have
scheduler specific tracepoints for the sched_*_entity particularities
and sched_* specific points interest.

Finally, I was based in the same approach used on the fair scheduler's
sched:sched_stat* tracepoints: they report sched_entity data on fair.c,
and my patches report sched_deadline_entity data on deadline.c.
