From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH v2] sched/rt: Use IPI to trigger RT task push
 migration instead of pulling
Date: Thu, 26 Feb 2015 09:00:55 -0500
Message-ID: <20150226090055.2ed313e9@gandalf.local.home>
References: <20150224133946.3948c4b7@gandalf.local.home>
	<20150225103535.GJ5029@twins.programming.kicks-ass.net>
	<20150225105116.7fa03cc9@gandalf.local.home>
	<20150225171110.GO21418@twins.programming.kicks-ass.net>
	<20150225125015.6c5110ca@gandalf.local.home>
	<20150226074559.GP21418@twins.programming.kicks-ass.net>
	<20150226074301.0db88af3@grimm.local.home>
	<20150226134754.GS21418@twins.programming.kicks-ass.net>
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
In-Reply-To: <20150226134754.GS21418@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 26 Feb 2015 14:47:54 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> > Thinking about this more, is it because a wmb just forces the CPU to
> > write everything before this before it writes anything after it. That
> > is, the writes themselves can happen at a much later time. Does a plain
> > mb() work the same way if there are no reads required?
> 
> No, neither smp_wmb nor smp_mb are required to flush the store buffers.

Heh, that's what I said :-)  "That is, the writes themselves can happen
at a much later time."

> 
> The only thing barriers do is guarantee order, this can be done by
> flushing store buffers but it can also be done by making sure store
> buffers flush writes in the 'right' order.
> 
> Nor does an rmb help anything with ordering against a possible store
> buffer flush. Again rmb only guarantees two loads are issued in that
> particular order, it doesn't disallow the CPU speculating the load at
> all.

Yep understood.

> > What about using atomic_t?
> > 
> > Note, my latest code doesn't have any of this, but I just want to
> > understand the semantics of these operations a bit better.
> 
> Nope, atomic_t doesn't help here either. Atomics only make sure the RmW
> cycle is atomic.

Crummy. ;-)

> 
> Note that even if wmb or mb did flush the store buffer, you would still
> have a race here.

Oh, it wasn't that I meant to remove the race. I was just trying to
make that race smaller.

But this is all academic now, as my last version doesn't do any of this.

-- Steve
