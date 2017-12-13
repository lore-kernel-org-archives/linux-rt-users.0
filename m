From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RT] time/hrtimer: disable that mode check
Date: Wed, 13 Dec 2017 15:19:19 +0100
Message-ID: <20171213141919.ouizpou5erye4fgz@hirez.programming.kicks-ass.net>
References: <20171213135835.rwtcf7kj45a6x4tt@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171213135835.rwtcf7kj45a6x4tt@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, Dec 13, 2017 at 02:58:35PM +0100, Sebastian Andrzej Siewior wrote:
> On -RT we push all timers by default into the soft-mode. The
> "start/update" code does not use that SOFT bit so we always see that
> warning.

Not _all_ timers I hope? There's a few the scheduler and perf use that
really should stay in hardirq context.
