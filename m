From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH v2] sched/rt: Use IPI to trigger RT task push
 migration instead of pulling
Date: Thu, 26 Feb 2015 07:43:01 -0500
Message-ID: <20150226074301.0db88af3@grimm.local.home>
References: <20150224133946.3948c4b7@gandalf.local.home>
	<20150225103535.GJ5029@twins.programming.kicks-ass.net>
	<20150225105116.7fa03cc9@gandalf.local.home>
	<20150225171110.GO21418@twins.programming.kicks-ass.net>
	<20150225125015.6c5110ca@gandalf.local.home>
	<20150226074559.GP21418@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <williams@redhat.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Mike Galbraith <umgwanakikbuti@gmail.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	=?UTF-8?B?SsO2cm4=?= Engel <joern@purestorage.com>,
	Oleg Nesterov <oleg@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150226074559.GP21418@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 26 Feb 2015 08:45:59 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Feb 25, 2015 at 12:50:15PM -0500, Steven Rostedt wrote:
> > It can't be used for state?
> > 
> > If one CPU writes "zero", and the other CPU wants to decide if the
> > system is in the state to do something, isn't a rmb() fine to use?
> > 
> > 
> > CPU 1:
> > 
> > 	x = 0;
> > 	/* Tell other CPUs they can now do something */
> > 	smp_wmb();
> > 
> > CPU 2:
> > 	/* Make sure we see current state of x */
> > 	smp_rmb();
> > 	if (x == 0)
> > 		do_something();
> > 
> > The above situation is not acceptable?
> 
> Acceptable is just not the word. It plain doesn't work that way.

Thinking about this more, is it because a wmb just forces the CPU to
write everything before this before it writes anything after it. That
is, the writes themselves can happen at a much later time. Does a plain
mb() work the same way if there are no reads required?

> 
> > Otherwise, we fail to be able to do_something() when it is perfectly
> > fine to do so.
> 
> Can't be helped.

What about using atomic_t?

Note, my latest code doesn't have any of this, but I just want to
understand the semantics of these operations a bit better.

-- Steve
