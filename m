From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC][PATCH] sched/rt: Use IPI to trigger RT task push migration
 instead of pulling
Date: Fri, 6 Feb 2015 14:23:41 +0100
Message-ID: <20150206132341.GO21418@twins.programming.kicks-ass.net>
References: <20150204143906.742287b4@gandalf.local.home>
 <20150205152144.GM21418@twins.programming.kicks-ass.net>
 <20150205115501.1da27f32@gandalf.local.home>
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
Received: from casper.infradead.org ([85.118.1.10]:33823 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752667AbbBFNXq (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 6 Feb 2015 08:23:46 -0500
Content-Disposition: inline
In-Reply-To: <20150205115501.1da27f32@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Feb 05, 2015 at 11:55:01AM -0500, Steven Rostedt wrote:
> On Thu, 5 Feb 2015 16:21:44 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > So can't we flip the problem around; 99 overloaded cpus and 1 going
> > 'low', then we IPI the 99, and they're all going to try and push their
> > tasks on the one (now) sad cpu?
> > 
> 
> Ug, you're right :-/
> 
> 
> OK, then we could do this, because if there's 10 CPUS with overloaded
> RT tasks (more than one queued), and 20 CPUs drop prios, if they all
> send to one CPU to do a pull, it will miss pulling from the other CPUs.
> 
> 
> But we do not want to send to all CPUS with overloaded RT queues,
> because, as you say, they could all try to push to the same queue and
> we hit the same problem this patch is trying to solve (lots of CPUs
> grabbing the same rq lock).
> 
> Thus, we could proxy it.
> 
> Send an IPI to just one CPU. When that CPU receives it, it pushes off
> only one task (as only one CPU told it it lowered its CPU).
> 
> If it receives the IPI and there's no tasks to push, it means that a
> there was another CPU that lowered its priority and asked this CPU to
> push a task to it. But another CPU got there first. Then this CPU could
> check to see if there's another rq out there with overloaded CPUs and
> send the IPI to that one. This way, only one CPU is pushing its tasks
> off at a time, and we only push if it is likely to succeed.
> 
> Pass the IPI around!

The IPI needs some state; it needs to also check that the condition that
triggered its existence on its dst cpu is still true. If somehow its dst
gained work (say a wakeup) we should stop.

Equally, if the dst cpu drops in prio again and there's already one IPI
out and about looking for work for it, we should not start another.

To further avoid collisions; eg. two CPUs dropping and ending up sending
an IPI to the same overloaded CPU; one could consider randomized
algorithms for selecting a (next) src cpu.

A trivial option might be to start the rto_mask iteration at the current
cpu number and wrap around until you hit self again.

A more advanced version might use an LFSR to iterate the mask, where we
give each cpu a different seed (say its cpuid) -- be careful to
artificially insert 0 when we loop.

But again; this will only affect the avg case, people should realize
that that 1ms latency is still entirely possible. Nothing changes that.
