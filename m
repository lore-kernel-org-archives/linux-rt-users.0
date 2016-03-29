From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH V2 3/3] sched/deadline: Tracepoints for deadline
 scheduler
Date: Tue, 29 Mar 2016 16:29:07 -0400
Message-ID: <20160329162907.418cb972@gandalf.local.home>
References: <cover.1459182044.git.bristot@redhat.com>
	<14f6caa05f73ceba69eff035ac542cad671552b3.1459182044.git.bristot@redhat.com>
	<20160329151649.GA12845@twins.programming.kicks-ass.net>
	<20160329115700.40acb336@gandalf.local.home>
	<20160329160401.GB3430@twins.programming.kicks-ass.net>
	<20160329131056.5b01780b@gandalf.local.home>
	<20160329201145.GC3430@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juri Lelli <juri.lelli@arm.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160329201145.GC3430@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 29 Mar 2016 22:11:45 +0200
Peter Zijlstra <peterz@infradead.org> wrote:


> > Yes, we don't want to get rid of the old one. But it shouldn't break
> > anything if we extend it. I'm thinking of extending it with a dynamic
> > array to store the deadline task values (runtime, period). And for non
> > deadline tasks, the array would be empty (size zero). I think that
> > could be doable and maintain backward compatibility.  
> 
> Why the complexity? Why not just tack those 32 bytes on and get on with
> life?

32 bytes that are zero and meaningless for 99.999% of scheduling?

The scheduling tracepoint is probably the most common tracepoint used,
and one of the frequent ones. 32bytes of wasted space per event can
cause a lot of tracing to be missed.

-- Steve
