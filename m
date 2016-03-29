From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH V2 3/3] sched/deadline: Tracepoints for deadline scheduler
Date: Tue, 29 Mar 2016 22:46:46 +0200
Message-ID: <20160329204646.GO3408@twins.programming.kicks-ass.net>
References: <cover.1459182044.git.bristot@redhat.com>
 <14f6caa05f73ceba69eff035ac542cad671552b3.1459182044.git.bristot@redhat.com>
 <20160329151649.GA12845@twins.programming.kicks-ass.net>
 <20160329115700.40acb336@gandalf.local.home>
 <20160329160401.GB3430@twins.programming.kicks-ass.net>
 <20160329131056.5b01780b@gandalf.local.home>
 <20160329201145.GC3430@twins.programming.kicks-ass.net>
 <20160329162907.418cb972@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juri Lelli <juri.lelli@arm.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160329162907.418cb972@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, Mar 29, 2016 at 04:29:07PM -0400, Steven Rostedt wrote:
> On Tue, 29 Mar 2016 22:11:45 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> 
> > > Yes, we don't want to get rid of the old one. But it shouldn't break
> > > anything if we extend it. I'm thinking of extending it with a dynamic
> > > array to store the deadline task values (runtime, period). And for non
> > > deadline tasks, the array would be empty (size zero). I think that
> > > could be doable and maintain backward compatibility.  
> > 
> > Why the complexity? Why not just tack those 32 bytes on and get on with
> > life?
> 
> 32 bytes that are zero and meaningless for 99.999% of scheduling?
> 
> The scheduling tracepoint is probably the most common tracepoint used,
> and one of the frequent ones. 32bytes of wasted space per event can
> cause a lot of tracing to be missed.

Typically you don't schedule _that_ often. Sure if you run pipe-bench
and hit ~.5e6 ctx/s its ~15M/s extra. But building a kernel gets me
~.5e3 ctx/s (per cpu), at which rate its 15K/s extra.

But sure, if you want to make it fancy have at.
