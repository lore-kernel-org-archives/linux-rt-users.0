From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH 0/2] preempt: Track unmatched preempt_enable() to
 preempt_disable()
Date: Thu, 16 Jan 2014 14:00:01 -0500
Message-ID: <20140116140001.58758cfd@gandalf.local.home>
References: <20140116171824.748919700@goodmis.org>
	<20140116174536.GB9655@laptop.programming.kicks-ass.net>
	<20140116133906.50bcbc93@gandalf.local.home>
	<20140116184251.GA11314@laptop.programming.kicks-ass.net>
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
In-Reply-To: <20140116184251.GA11314@laptop.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 16 Jan 2014 19:42:51 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> Suppose a reschedule interrupt happens in the middle; we set
> NEED_RESCHED but won't act because preempt is disabled.
> 
> When we hit preempt_enable() we'll call into preempt_schedule() but fail
> because preemptible() finds irqs_disabled().
> 
> And in the end we do not schedule, but have NEED_RESCHED set.
> 
> FAIL.

Ah! Interesting. Actually, you don't even need the first part. That
happens simply with:

	preempt_disable();

	<interrupt - set need_resched>

	local_irq_save();
	preempt_enable();
	local_irq_restore();

I think we can get lockdep to trigger on that. I have ideas to make
preempt tracer do that, which shouldn't be too hard to convert to
lockdep.

It looks that all we need to do is check for anytime we have interrupts
becoming disabled with preemption disabled, and then enable preemption
without first enabling interrupts. This should be able to be driven by
state of the task or CPU even.

I can see if I can whip up a patch to do that.

-- Steve
