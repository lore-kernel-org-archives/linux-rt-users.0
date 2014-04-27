From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH] rtmutex: Do not prio boost when timeout is used
Date: Sun, 27 Apr 2014 20:20:26 +0200 (CEST)
Message-ID: <alpine.DEB.2.02.1404271947260.6261@ionos.tec.linutronix.de>
References: <20140425162848.0e1deed8@gandalf.local.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140425162848.0e1deed8@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 25 Apr 2014, Steven Rostedt wrote:

> I've been discussing an issue on IRC with deadlock checking and found
> something wrong with it. Mainly, if any of the locks have a timeout,
> then even if the chain loops, there is no real deadlock. If one of the
> locks in the chain times out, then things will move forward again.
> 
> Now it may not be nice to have locks that do this, but we can break
> applications that use futex priority boosting and may use timeouts to
> break deadlocks.

And we rightfully break them. Using timeouts to work around potential
deadlocks is broken by definition.

We did forbid that forever, so no application developer can claim that
he had been using that before with PI futexes. It simply never worked.

If that application was using non PI futexes and worked around the
deadlock with timeouts and now decided to switch that broken code to
use PI, it's none of our problems and we are not going to change a
single line of code to support that brainfart.

> As priority boosting is made to prevent unbounded latencies, and a
> timeout grabbing of a lock is a bounded latency, I'm suggesting that we
> do not bother boosting the owner or even treating the task as being
> blocked.

That's complete and utter bullsh*it.

T1 holds A and tries to grab B

T2 holds B and tries to grab A with a timeout T. 

So T1 prevents T2 for time T to grab the lock, i.e. a (temporary)
deadlock. Depending on the requirements of T1, T might be well outside
the bounds which are critical for T1. That's still bounded by some
definition, but violates the bounds of T1.

Even the most basic "locking for dummies" cookbook will tell you that
if you need to take locks in reverse order the only sane thing is to
use trylock.

Aside of that you would penalize legitimate and sane users of timeouts
which suddenly would run into priority inversions for no good reason.

We really have better things to do, than changing the rules just to
please some random (probably commercial) application which has been
programmed along the coding rules from hell.

Thanks,

	tglx
