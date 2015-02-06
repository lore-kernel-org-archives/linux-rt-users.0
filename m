From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [RFC][PATCH] sched/rt: Use IPI to trigger RT task push
 migration instead of pulling
Date: Fri, 06 Feb 2015 16:58:08 +0100
Message-ID: <1423238288.3377.83.camel@gmail.com>
References: <20150204143906.742287b4@gandalf.local.home>
	 <20150205145833.GJ5029@twins.programming.kicks-ass.net>
	 <20150205110420.398fb3c8@gandalf.local.home>
	 <20150206124051.GN21418@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <williams@redhat.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150206124051.GN21418@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 2015-02-06 at 13:40 +0100, Peter Zijlstra wrote:
> On Thu, Feb 05, 2015 at 11:04:20AM -0500, Steven Rostedt wrote:

> Well, the thing is, with or without this patch, the worst case is still
> the very same. The likelihood of actually triggering it goes down
> dramatically [*], but any spin_lock() has that O(nr_cpus) worst case, and
> that spinlock op isn't going away.
> 
> Now, lowering avg/median cases is good, but don't kid yourself that the
> worst case is going to be better.
> 
> People running -RT on big boxes had better be aware of this.

The folks I know of running -RT on big boxen isolate cores and nail
absolutely everything to the floor.  The only way to survive in a big
box is to chop the thing into tiny pieces.  A plasma cutter would be
even better.. 'course you could just _buy smaller boxen_ and connect
what you want connected, take the lazy path to big box solution ;-)
  
	-Mike
