From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: cgroup trace events acquire sleeping locks
Date: Tue, 10 Jul 2018 09:32:45 -0400
Message-ID: <20180710093245.4e326156@gandalf.local.home>
References: <20180703140750.1dab75ef@tagon>
        <20180706174745.hwvnwojzfbmp7ma5@linutronix.de>
        <20180708203600.2edf24e2@tagon>
        <20180709163805.ai4ljzaj3i73ypx4@linutronix.de>
        <20180709150154.66843cba@gandalf.local.home>
        <20180709202214.h2t5t3ndx6xqtrtg@linutronix.de>
        <20180709163010.257a08a0@gandalf.local.home>
        <20180710092635.GD2476@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        tglx@linutronix.de, Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180710092635.GD2476@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 10 Jul 2018 11:26:35 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> > Hmm, good question. I could possibly make all the tracepoint code into
> > its own section. And then look to see if any spin locks exist in them.
> > That wouldn't be too trivial to implement though.  
> 
> pick a bit from the preempt_count (say right above NMI_MASK) and set it
> inside a trace-event and add in_trace().
> 
> Then make lockdep explode when in_trace().
> 
> Or something along those lines.

Sure. We have current->trace for special tracing flags. That could
easily be used.

-- Steve
