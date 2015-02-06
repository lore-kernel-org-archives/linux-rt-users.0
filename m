From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC][PATCH] sched/rt: Use IPI to trigger RT task push migration
 instead of pulling
Date: Fri, 6 Feb 2015 13:40:51 +0100
Message-ID: <20150206124051.GN21418@twins.programming.kicks-ass.net>
References: <20150204143906.742287b4@gandalf.local.home>
 <20150205145833.GJ5029@twins.programming.kicks-ass.net>
 <20150205110420.398fb3c8@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: LKML <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <williams@redhat.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Mike Galbraith <umgwanakikbuti@gmail.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:33637 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757018AbbBFMk5 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 6 Feb 2015 07:40:57 -0500
Content-Disposition: inline
In-Reply-To: <20150205110420.398fb3c8@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Feb 05, 2015 at 11:04:20AM -0500, Steven Rostedt wrote:
> > This should be in the irq_enter()/exit() part, but better still, move
> > this into an smp_call_fuction_single_async() or queue_irq_work_on(), no
> > reason to make the scheduler IPI do yet more work.
> 
> OK, the smp_call_function_single_async() may be better. Question is, do
> they too grab spinlocks to send? 

One is in kernel/smp.c the other in kernel/irq_work.c, have a look ;-)

But no, they use llist stuff.

> > > +	push_rt_tasks(rq);
> > 
> > So this, on first sight, looks like an unbounded while loop; better
> > present some runtime bound analysis on it.
> > 
> > At present I find a worst case O(inf * nr_tries * nr_prios * nr_cpus),
> > which while on average might run faster, is actually quite horrible.
> 
> Again, the algorithm stops when no task is pushed, so it's not inf.

The inf. came from the retry loop in push_rt_task(), could we not get
stuck there if things keep on shifting back and forth? Sure, that would
probably require inf. (bad) luck as well, but on a quick reading I see
no guaranteed bound.

If there is one, please put a comment in. Moron in a hurry (me) is
failing to see the obvious ;-)

> I could add a flag to not do the retry in this case. And, yeah, the
> nr_prios could happen if the waiting task is of high priority (but that
> task would need to be of lower priority than all the other CPUs that are
> asking for the pull, otherwise it would have pushed to those CPUs in
> the first place).

The O(nr_prio * nr_cpus) is from cpupri_find() and is part of the cpupri
design, nothing you can really do about it. You need to iterate the
priorities and scan for a bit, and the bit scan is nr_cpus because
that's how long the cpumasks are.

Sure you won't actually hit the very worst case every time, but here
even the avg execution time is that same O expression, just maybe with a
constant 1/4 factor in, which we ignore because well, that's what big-Os
do ;-)

Now, luckily O(nr_prio * nr_cpus) is bounded (and constant), so that's
good ;-)

> > RT isn't won on avg or median execution times :-)
> 
> Totally agree. And I'm willing to write up more analysis, because the
> worse case scenario, would require a lot of things to happen that would
> take a lot of work to do so, and not something that would randomly
> happen.
> 
> Even the retry only happens if it could not find a CPU that had a lower
> priority than the task it was looking for, and the task either somehow
> migrated, or a higher priority task some how got queued instead when
> the lock was released.

As per the above, yes please. Also if we can somehow bound that retry
loop that'd be awesome. Sure it might be unlikely to trigger this side
of the universe's heat death, but... unlikely things do happen.

> And this retry case is in today's code, and any problem we have with
> it, should be solved today as well.

Right; this is an argument you _should_ have made :-)

> Now I guess you could argue that if you have > nr_cpus tasks on your
> queue, and when you push one task off, and it runs on the other CPU and
> finishes, which would mean you could push the next RT task off. If that
> task finishes before we get to the next task, it could be nr_tasks
> algorithm. But that's more than unlikely that a task could schedule on
> another CPU and finish, and schedule out, before we do the next task on
> the loop.

The devils advocate needs to bring up virt crazies, vcpu stalls make
such races entirely possible :/ They're much _much_ better than the
P4-SMT stuff for finding quaint crap like this.

> This isn't just avg or median times. When the current code is
> constantly hitting 1ms latencies in the scheduler, and this patch nukes
> it down to 50us max latencies, I think we should seriously think about
> it. Because today, the code is not acceptable.

Well, the thing is, with or without this patch, the worst case is still
the very same. The likelihood of actually triggering it goes down
dramatically [*], but any spin_lock() has that O(nr_cpus) worst case, and
that spinlock op isn't going away.

Now, lowering avg/median cases is good, but don't kid yourself that the
worst case is going to be better.

People running -RT on big boxes had better be aware of this.

[*] if we solve that reverse problem from the other email, otherwise we
just shifted it.

> I'm willing to massage this patch and do a full analysis on it. I just
> don't want this discussion to end like it did last time.

Sure; but I think we need to be honest here too. This patch is about
lowering avg case latencies, not absolute worst case.

Now, the argument that we currently already run this code with IRQs
disabled, so running it from an IPI is not strictly worse than what we
already do is a good one and should be highlighted.

I suspect tglx wanted to hear such argument, but I did not go back and
look at the history.
