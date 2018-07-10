From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: cgroup trace events acquire sleeping locks
Date: Tue, 10 Jul 2018 11:26:35 +0200
Message-ID: <20180710092635.GD2476@hirez.programming.kicks-ass.net>
References: <20180703140750.1dab75ef@tagon>
 <20180706174745.hwvnwojzfbmp7ma5@linutronix.de>
 <20180708203600.2edf24e2@tagon>
 <20180709163805.ai4ljzaj3i73ypx4@linutronix.de>
 <20180709150154.66843cba@gandalf.local.home>
 <20180709202214.h2t5t3ndx6xqtrtg@linutronix.de>
 <20180709163010.257a08a0@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        tglx@linutronix.de, Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180709163010.257a08a0@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, Jul 09, 2018 at 04:30:10PM -0400, Steven Rostedt wrote:
> On Mon, 9 Jul 2018 22:22:15 +0200
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
> > On 2018-07-09 15:01:54 [-0400], Steven Rostedt wrote:
> > > > which is the trace_cgroup_rmdir() trace event in cgroup_rmdir(). The
> > > > trace event invokes cgroup_path() which acquires a spin_lock_t and this
> > > > is invoked within a preempt_disable()ed section.   
> > > 
> > > Correct. And I wish no trace event took spin locks.  
> > 
> > is there an easy way to detect this? I mean instead hitting the trace
> > event with debug enabled and doing a review of each of them.
> 
> Hmm, good question. I could possibly make all the tracepoint code into
> its own section. And then look to see if any spin locks exist in them.
> That wouldn't be too trivial to implement though.

pick a bit from the preempt_count (say right above NMI_MASK) and set it
inside a trace-event and add in_trace().

Then make lockdep explode when in_trace().

Or something along those lines.
