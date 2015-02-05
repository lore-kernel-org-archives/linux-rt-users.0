From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH] sched/rt: Use IPI to trigger RT task push
 migration instead of pulling
Date: Thu, 5 Feb 2015 11:55:01 -0500
Message-ID: <20150205115501.1da27f32@gandalf.local.home>
References: <20150204143906.742287b4@gandalf.local.home>
	<20150205152144.GM21418@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <williams@redhat.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Mike Galbraith <umgwanakikbuti@gmail.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150205152144.GM21418@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 5 Feb 2015 16:21:44 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> So can't we flip the problem around; 99 overloaded cpus and 1 going
> 'low', then we IPI the 99, and they're all going to try and push their
> tasks on the one (now) sad cpu?
> 

Ug, you're right :-/


OK, then we could do this, because if there's 10 CPUS with overloaded
RT tasks (more than one queued), and 20 CPUs drop prios, if they all
send to one CPU to do a pull, it will miss pulling from the other CPUs.


But we do not want to send to all CPUS with overloaded RT queues,
because, as you say, they could all try to push to the same queue and
we hit the same problem this patch is trying to solve (lots of CPUs
grabbing the same rq lock).

Thus, we could proxy it.

Send an IPI to just one CPU. When that CPU receives it, it pushes off
only one task (as only one CPU told it it lowered its CPU).

If it receives the IPI and there's no tasks to push, it means that a
there was another CPU that lowered its priority and asked this CPU to
push a task to it. But another CPU got there first. Then this CPU could
check to see if there's another rq out there with overloaded CPUs and
send the IPI to that one. This way, only one CPU is pushing its tasks
off at a time, and we only push if it is likely to succeed.

Pass the IPI around!

Something to work on.

-- Steve
