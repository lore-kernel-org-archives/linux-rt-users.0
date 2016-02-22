From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 3/4] sched/deadline: Tracepoints for deadline scheduler
Date: Mon, 22 Feb 2016 17:30:43 -0500
Message-ID: <20160222173043.24873ae8@gandalf.local.home>
References: <cover.1456157869.git.bristot@redhat.com>
	<f3b54958f216d36be59363815a3d75a0636cda8b.1456157869.git.bristot@redhat.com>
	<20160222173259.GM6357@twins.programming.kicks-ass.net>
	<20160222124854.3816fec4@gandalf.local.home>
	<20160222213017.GN6357@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juri Lelli <juri.lelli@gmail.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0018.hostedemail.com ([216.40.44.18]:57655 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932215AbcBVWar (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 22 Feb 2016 17:30:47 -0500
In-Reply-To: <20160222213017.GN6357@twins.programming.kicks-ass.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 22 Feb 2016 22:30:17 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Feb 22, 2016 at 12:48:54PM -0500, Steven Rostedt wrote:
> 
> > > As it stands, the existing tracepoint have already been an ABI
> > > trainwreck, why would I want to add more?  
> > 
> > Yes, this may become a type of ABI, but even the sched switch
> > tracepoints haven't been that bad. Has it really prevented us from
> > changing anything?  
> 
> The whole wakeup thing where we _still_ have a dummy argument, and have
> been lying about the value for a long time really stinks.

Having a dummy argument is not that bad. Yes, it's inconvenient, and
I'm not sure who even uses it (can we delete it without breaking
anything?) But it doesn't prevent us from going forward with
development.

> 
> > But let me ask, what would you recommend to finding out if the kernel
> > has really given your tasks the recommended runtime within a given
> > period? We can't expect users of SCHED_DEADLINE to be modifying the
> > kernel themselves.  
> 
> So why are these deadline specific tracepoint? Why not extend the ones
> we already have?

I'm not sure how to do that and be able to report when a period has
elapsed, and when the next period is coming.

> 
> Also, will these tracepoints still work if we implement SCHED_DEADLINE
> using Least-Laxity-First or Pfair or some other exotic algorithm? Or
> will be forever be bound to EDF just because tracepoint ABI shite?

Can we come up with generic numbers? I mean, the user that asks for
their task to have a specific runtime within a specific
period/deadline, these seem to be generic already. I'll have to read up
on those that you mention, but do that not have a "replenish" for when
the period starts again? And then a yield, showing the task has given
up its remaining time, or a block, where a task is scheduled out
because it blocked on a lock?

> 
> Worse, the proposed tracepoints are atrocious, look at crap like this:
> 
> > +		if (trace_sched_deadline_yield_enabled()) {
> > +			u64 delta_exec = rq_clock_task(rq) - p->se.exec_start;
> > +			/* Subtract the last run till now */
> > +			if (likely((s64)delta_exec > 0))
> > +				p->dl.runtime -= delta_exec;
> > +			trace_sched_deadline_yield(&p->dl);
> > +		}  
> 
> tracepoints should _NEVER_ change state, ever.

Heh, it's not really changing state. The code directly after this is:

	p->dl.runtime = 0;

Without updating dl.runtime, you the tracepoint would report inaccurate
remaining time. Without that, you would get reports of yielding with
full runtimes, making it look like you never ran at all.


> 
> And there's the whole COND tracepoint muck, which also doesn't win any
> prices.

It keeps us from adding flags that may end up going away and us
maintaining a dummy field forever ;-)

> 
> So tell me why these specific tracepoints and why the existing ones
> could not be extended to include this information. For example, why a
> trace_sched_dealine_yield, and not a generic trace_sched_yield() that
> works for all classes.

But what about reporting actual runtime, and when the next period will
come. That only matters for deadline.

> 
> Tell me that the information presented does not pin the implementation.
> 
> And clean up the crap.
> 
> Then I might maybe consider this.
> 
> But do not present me with a bunch of random arse, hacked together
> tracepoints and tell me they might be useful, maybe.


They ARE useful. These are the tracepoints I'm currently using to
debug the deadline scheduler with. They have been indispensable for my
current work.

-- Steve
