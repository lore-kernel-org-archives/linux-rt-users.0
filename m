From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 1/2] rtmutex Real-Time Linux: Fixing kernel BUG at
 kernel/locking/rtmutex.c:997!
Date: Tue, 7 Apr 2015 23:38:48 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1504072313540.3845@nanos>
References: <1424395866-81589-1-git-send-email-tmac@hp.com>  <1428369962-74723-1-git-send-email-tmac@hp.com>  <1428369962-74723-2-git-send-email-tmac@hp.com>  <alpine.DEB.2.11.1504071255410.3845@nanos>  <1428407236.3152.81.camel@gmail.com>
 <20150407120403.GN21418@twins.programming.kicks-ass.net>  <CAGQ1y=4YNpyztGyPb=rgnBduJfykB8tbG1FQWGEKQWVNeu+nNw@mail.gmail.com>  <alpine.DEB.2.11.1504072102510.3845@nanos> <1428436643.2556.66.camel@j-VirtualBox>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Peter Zijlstra <peterz@infradead.org>,
	Mike Galbraith <umgwanakikbuti@gmail.com>,
	Thavatchai Makphaibulchoke <tmac@hp.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Jason Low <jason.low2@hp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428436643.2556.66.camel@j-VirtualBox>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 7 Apr 2015, Jason Low wrote:
> On Tue, 2015-04-07 at 21:17 +0200, Thomas Gleixner wrote:
> > On Tue, 7 Apr 2015, Jason Low wrote:
> > > The lock shouldn't be used in get_next_timer_interrupt() either right?
> > > 
> > > unsigned long get_next_timer_interrupt(unsigned long now)
> > > {
> > > ...
> > > 
> > > #ifdef CONFIG_PREEMPT_RT_FULL
> > >         /*
> > >          * On PREEMPT_RT we cannot sleep here. If the trylock does not
> > >          * succeed then we return the worst-case 'expires in 1 tick'
> > >          * value.  We use the rt functions here directly to avoid a
> > >          * migrate_disable() call.
> > >          */
> > >         if (!spin_do_trylock(&base->lock))
> > >                 return  now + 1;
> > > #else
> > 
> > And how do you protect the walk of the timer wheel against a
> > concurrent insertion/removal?
> 
> So I just wanted to mention that the issue also applies to
> get_next_timer_interrupt(), in addition to run_local_timers(), but if we
> really want to remove the lock there, can we always return "now + 1" for
> PREEMPT_RT_FULL?
 
There is a simpler solution for this: Disable NOHZ for RT. Because
that's what 'always return "now + 1"' does at runtime just with more
overhead.

We need a smarter solution for RT to avoid the lock completely.

Thanks,

	tglx
