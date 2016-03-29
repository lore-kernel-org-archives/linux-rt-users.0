From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH V2 3/3] sched/deadline: Tracepoints for deadline
 scheduler
Date: Tue, 29 Mar 2016 14:10:35 -0400
Message-ID: <20160329141035.2269e08c@gandalf.local.home>
References: <cover.1459182044.git.bristot@redhat.com>
	<14f6caa05f73ceba69eff035ac542cad671552b3.1459182044.git.bristot@redhat.com>
	<20160329151649.GA12845@twins.programming.kicks-ass.net>
	<20160329115700.40acb336@gandalf.local.home>
	<56FABD4E.3080008@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juri Lelli <juri.lelli@arm.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Daniel Bristot de Oliveira <bristot@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0135.hostedemail.com ([216.40.44.135]:44447 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752059AbcC2SKk (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 29 Mar 2016 14:10:40 -0400
In-Reply-To: <56FABD4E.3080008@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 29 Mar 2016 14:37:18 -0300
Daniel Bristot de Oliveira <bristot@redhat.com> wrote:


> The above tracepoints are conditional, if dl_se->dl_yielded, only the
> yield tracepoint will happen. If !dl_se->dl_yielded, only the throttle
> tracepoint will happen.

Yes, I know they are conditional, but that doesn't make up the fact
that there's two tracepoints back to back, which should not happen.

> 
> We can try to join the sched_deadline_(yield|throttle|block) on a single
> tracepoint, but IMHO having them separated is more intuitive for users.

A userspace tool can make it more intuitive for users.

Note, tracepoints are very low overhead when not enabled. But they are
not zero percent overhead. That means, two tracepoints just doubled
that small overhead. Each one adds to the I$.

> 
> > Sure, we'll probably want to figure out a better way to see deadline
> > tasks blocked. Probably can see that from sched switch though, as it
> > would be in the blocked state as it scheduled out.  
> 
> We can guess that in the sched switch, but it currently does not show
> deadline specific information (deadline, runtime, now (in the timer used
> by the scheduler), and they are relevant in the analysis of deadline tasks.

But as I said in another email, it can be extended dynamically.

> 
> > 
> > Hmm, I probably could add tracing infrastructure that would let us
> > extend existing tracepoints. That is, without modifying sched_switch,
> > we could add a new tracepoint that when enabled, would attach itself to
> > the sched_switch tracepoint and record different information. Like a
> > special sched_switch_deadline tracepoint, that would record the existing
> > runtime,deadline and period for deadline tasks. It wont add more
> > tracepoints into the core scheduler, but use the existing one.  
> 
> You can display the joined version of sched deadline
> (yield|throttle|block) tracepoint, but IMHO this will just turn things
> more complex than they need to be, and will possibly add overhead to the
> sched_switch tracepoint, that is more used by non-deadline users than by
> deadline users.

Adding to the sched_switch tracepoint isn't as big of a deal as slowing
non tracing down. All new overhead must be focused into the tracing
enabled case. That is, if we slow down tracing by 100% where we could
have an alternative that slows down non-tracing by .01%, we still
choose the slowdown of tracing.

> 
> Moreover, deadline users will probably want to see only the deadline
> data, and have to use complex enabling/filtering options is really
> really not intuitive for users (that are not kernel developers).

That's what userspace filtering tools are for ;-)


-- Steve
