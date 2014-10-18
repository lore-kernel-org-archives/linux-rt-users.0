From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 3/7] wait.[ch]: Introduce the simple waitqueue (swait)
 implementation
Date: Sat, 18 Oct 2014 19:05:19 -0400
Message-ID: <1413673519.30326.11.camel@pippen.local.home>
References: <1413591782-23453-1-git-send-email-paul.gortmaker@windriver.com>
	 <1413591782-23453-4-git-send-email-paul.gortmaker@windriver.com>
	 <20141018213417.GE23531@worktop.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141018213417.GE23531@worktop.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sat, 2014-10-18 at 23:34 +0200, Peter Zijlstra wrote:

> Same comment as before, that is an unbounded loop in a non preemptible
> section and therefore violates RT design principles.
> 
> We actually did talk about ways of fixing that.

Right, and we should slap Paul for not showing up for it ;-)

The decision that we came up with was to splice the current list onto a
local list variable. And then we could go into a loop releasing the lock
and grabbing it again. Each time pop a waiter off the list and doing the
work of only one task at a time. This prevents doing large amounts of
wake ups under a spinlock. The splice is required to only wake up those
that are on the list when the wake up is called. This prevents waking up
a task twice because it woke up, removed itself, and then added itself
again. We must keep the semantics that a wake up only wakes up a task
once.

> 
> Also, I'm not entirely sure we want to do the cwait thing, it looks
> painful.

Yeah, I have to think about that some more too. I'm currently sitting in
the airport waiting for my final leg of my flight. After 18 hours of
travel, it is probably not too wise to review this work in my current
state ;-)

-- Steve
