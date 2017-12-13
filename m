From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT] time/hrtimer: disable that mode check
Date: Wed, 13 Dec 2017 11:49:56 -0500
Message-ID: <20171213114956.64ceddf6@gandalf.local.home>
References: <20171213135835.rwtcf7kj45a6x4tt@linutronix.de>
        <20171213141919.ouizpou5erye4fgz@hirez.programming.kicks-ass.net>
        <20171213142257.ok7xdag5p4wp4mfo@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Peter Zijlstra <peterz@infradead.org>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171213142257.ok7xdag5p4wp4mfo@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 13 Dec 2017 15:22:57 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> On 2017-12-13 15:19:19 [+0100], Peter Zijlstra wrote:
> > On Wed, Dec 13, 2017 at 02:58:35PM +0100, Sebastian Andrzej Siewior wrote:  
> > > On -RT we push all timers by default into the soft-mode. The
> > > "start/update" code does not use that SOFT bit so we always see that
> > > warning.  
> > 
> > Not _all_ timers I hope? There's a few the scheduler and perf use that
> > really should stay in hardirq context.  
> That is correct, a few ones remain in the hardirq context.
> 

As Sebastian said, by default they are in SOFT mode. I'm assuming the
ones that are not have some logic to make sure they are not in SOFT
mode.

-- Steve
