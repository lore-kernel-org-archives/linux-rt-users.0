From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [PATCH 3/4] sched/deadline: Tracepoints for deadline scheduler
Date: Tue, 23 Feb 2016 10:40:13 +0000
Message-ID: <20160223104013.GI27380@e106622-lin>
References: <cover.1456157869.git.bristot@redhat.com>
 <f3b54958f216d36be59363815a3d75a0636cda8b.1456157869.git.bristot@redhat.com>
 <20160222173259.GM6357@twins.programming.kicks-ass.net>
 <20160222124854.3816fec4@gandalf.local.home>
 <20160222213017.GN6357@twins.programming.kicks-ass.net>
 <20160222173043.24873ae8@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Zijlstra <peterz@infradead.org>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juri Lelli <juri.lelli@gmail.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160222173043.24873ae8@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi,

On 22/02/16 17:30, Steven Rostedt wrote:
> On Mon, 22 Feb 2016 22:30:17 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Mon, Feb 22, 2016 at 12:48:54PM -0500, Steven Rostedt wrote:
> > 

[...]

> > 
> > > But let me ask, what would you recommend to finding out if the kernel
> > > has really given your tasks the recommended runtime within a given
> > > period? We can't expect users of SCHED_DEADLINE to be modifying the
> > > kernel themselves.  
> > 
> > So why are these deadline specific tracepoint? Why not extend the ones
> > we already have?
> 
> I'm not sure how to do that and be able to report when a period has
> elapsed, and when the next period is coming.
> 
> > 
> > Also, will these tracepoints still work if we implement SCHED_DEADLINE
> > using Least-Laxity-First or Pfair or some other exotic algorithm? Or
> > will be forever be bound to EDF just because tracepoint ABI shite?
> 
> Can we come up with generic numbers? I mean, the user that asks for
> their task to have a specific runtime within a specific
> period/deadline, these seem to be generic already. I'll have to read up
> on those that you mention, but do that not have a "replenish" for when
> the period starts again? And then a yield, showing the task has given
> up its remaining time, or a block, where a task is scheduled out
> because it blocked on a lock?
> 

AFAICT throttle, yield and block seem fairly generic. How we make the
definition generic w.r.t. the arguments we want to print is a different
matter, though. :-/

I should refresh my memory about the above mentioned algorithms, and
"replenish" might be particular to the current implementation. However,
shouldn't any algo that has a "throttle" event also have a corresponding
"un-throttle (replenish)" event? I guess being able to throttle
misbehaving tasks is a property that we will always desire.

> > 
> > Worse, the proposed tracepoints are atrocious, look at crap like this:
> > 
> > > +		if (trace_sched_deadline_yield_enabled()) {
> > > +			u64 delta_exec = rq_clock_task(rq) - p->se.exec_start;
> > > +			/* Subtract the last run till now */
> > > +			if (likely((s64)delta_exec > 0))
> > > +				p->dl.runtime -= delta_exec;
> > > +			trace_sched_deadline_yield(&p->dl);
> > > +		}  
> > 
> > tracepoints should _NEVER_ change state, ever.
> 
> Heh, it's not really changing state. The code directly after this is:
> 
> 	p->dl.runtime = 0;
> 
> Without updating dl.runtime, you the tracepoint would report inaccurate
> remaining time. Without that, you would get reports of yielding with
> full runtimes, making it look like you never ran at all.
> 

Right, I guess that might be useful to understand if you over-
dimensioned the reservation. Can't we make this a macro or do the
computation local to the tracepoint itself so that code looks nicer?

[...]

> > 
> > So tell me why these specific tracepoints and why the existing ones
> > could not be extended to include this information. For example, why a
> > trace_sched_dealine_yield, and not a generic trace_sched_yield() that
> > works for all classes.
> 
> But what about reporting actual runtime, and when the next period will
> come. That only matters for deadline.
> 

As said above, the event looks generic enough to me. Not sure how to
make printed arguments generic, though.

> > 
> > Tell me that the information presented does not pin the implementation.
> > 
> > And clean up the crap.
> > 
> > Then I might maybe consider this.
> > 
> > But do not present me with a bunch of random arse, hacked together
> > tracepoints and tell me they might be useful, maybe.
> 
> 
> They ARE useful. These are the tracepoints I'm currently using to
> debug the deadline scheduler with. They have been indispensable for my
> current work.
> 

I also think they are very useful. I always had some sort of tracepoints
that I continue forward porting during the development of
SCHED_DEADLINE, and I couldn't really understand what was going on
without those. There is value if we can agree on the mainline
incarnation of such tracepoints now, IMHO.

Best,

- Juri
