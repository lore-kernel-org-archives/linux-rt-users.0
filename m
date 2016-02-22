From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 3/4] sched/deadline: Tracepoints for deadline scheduler
Date: Mon, 22 Feb 2016 22:30:17 +0100
Message-ID: <20160222213017.GN6357@twins.programming.kicks-ass.net>
References: <cover.1456157869.git.bristot@redhat.com>
 <f3b54958f216d36be59363815a3d75a0636cda8b.1456157869.git.bristot@redhat.com>
 <20160222173259.GM6357@twins.programming.kicks-ass.net>
 <20160222124854.3816fec4@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juri Lelli <juri.lelli@gmail.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160222124854.3816fec4@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, Feb 22, 2016 at 12:48:54PM -0500, Steven Rostedt wrote:

> > As it stands, the existing tracepoint have already been an ABI
> > trainwreck, why would I want to add more?
> 
> Yes, this may become a type of ABI, but even the sched switch
> tracepoints haven't been that bad. Has it really prevented us from
> changing anything?

The whole wakeup thing where we _still_ have a dummy argument, and have
been lying about the value for a long time really stinks.

> But let me ask, what would you recommend to finding out if the kernel
> has really given your tasks the recommended runtime within a given
> period? We can't expect users of SCHED_DEADLINE to be modifying the
> kernel themselves.

So why are these deadline specific tracepoint? Why not extend the ones
we already have?

Also, will these tracepoints still work if we implement SCHED_DEADLINE
using Least-Laxity-First or Pfair or some other exotic algorithm? Or
will be forever be bound to EDF just because tracepoint ABI shite?

Worse, the proposed tracepoints are atrocious, look at crap like this:

> +		if (trace_sched_deadline_yield_enabled()) {
> +			u64 delta_exec = rq_clock_task(rq) - p->se.exec_start;
> +			/* Subtract the last run till now */
> +			if (likely((s64)delta_exec > 0))
> +				p->dl.runtime -= delta_exec;
> +			trace_sched_deadline_yield(&p->dl);
> +		}

tracepoints should _NEVER_ change state, ever.

And there's the whole COND tracepoint muck, which also doesn't win any
prices.

So tell me why these specific tracepoints and why the existing ones
could not be extended to include this information. For example, why a
trace_sched_dealine_yield, and not a generic trace_sched_yield() that
works for all classes.

Tell me that the information presented does not pin the implementation.

And clean up the crap.

Then I might maybe consider this.

But do not present me with a bunch of random arse, hacked together
tracepoints and tell me they might be useful, maybe.
