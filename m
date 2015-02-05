From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC][PATCH] sched/rt: Use IPI to trigger RT task push migration
 instead of pulling
Date: Thu, 5 Feb 2015 16:21:44 +0100
Message-ID: <20150205152144.GM21418@twins.programming.kicks-ass.net>
References: <20150204143906.742287b4@gandalf.local.home>
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
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150204143906.742287b4@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, Feb 04, 2015 at 02:39:06PM -0500, Steven Rostedt wrote:
> The problem is that if you have 100 CPUs having an RT task schedule out
> (just like cyclictest -d0 -t -i100 does a lot), and if there's one rq
> that has more than one RT task scheduled on it (overloaded), each
> of those 100 CPUs are going to try to get that second RT task on that
> lonely rq, and each of those 100 CPUs are going to take that lonely
> rq's lock! Then what happens if the task running on that rq wants to
> schedule? Well, it needs to wait behind 100 CPUs contending for its rq
> lock, and we see a HUGE latency (1ms or more).
> 
> What does this patch do instead? Instead of trying to fight for the rq,
> if it sees that there's an overloaded rq, it simply sends an IPI to
> that CPU to have it push the overloaded RT task off to another CPU.

So can't we flip the problem around; 99 overloaded cpus and 1 going
'low', then we IPI the 99, and they're all going to try and push their
tasks on the one (now) sad cpu?
