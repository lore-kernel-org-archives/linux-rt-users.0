From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH 0/2] preempt: Track unmatched preempt_enable() to
 preempt_disable()
Date: Thu, 16 Jan 2014 13:39:06 -0500
Message-ID: <20140116133906.50bcbc93@gandalf.local.home>
References: <20140116171824.748919700@goodmis.org>
	<20140116174536.GB9655@laptop.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Clark Williams <williams@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140116174536.GB9655@laptop.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 16 Jan 2014 18:45:36 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, Jan 16, 2014 at 12:18:24PM -0500, Steven Rostedt wrote:
> 
> Didn't see anything horrible in there, so fine with me.
> 
> Another thing I recently ran into was:
> 
>   local_irq_disable();
>   preempt_disable();
>   local_irq_enable();
> 
>   local_irq_disable();
>   preempt_enable();
>   local_irq_enable();
> 
> I'm not sure any of our debugging catches that, I meant to extend
> lockdep, but maybe it could also be hooked into something else.

Hmm, what's wrong with the above?

Note, the preemptirqsoff tracer will trace that as not being
preemptible between that first local_irq_disable() to the
local_irq_enable(). In fact, that's basically what the preemptirqsoff
tracer was made for ;-)

-- Steve
