From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: BUG: spinlock trylock failure on UP, i.MX28 3.12.15-rt25
Date: Wed, 23 Apr 2014 08:15:25 -0400
Message-ID: <20140423081525.0e9b863f@gandalf.local.home>
References: <534C3606.7010206@meduna.org>
	<534C731F.1050406@meduna.org>
	<534DADF1.6060608@meduna.org>
	<20140422115439.GA20669@linutronix.de>
	<20140422094657.5b6ca1e2@gandalf.local.home>
	<53569E05.8010600@linutronix.de>
	<20140422134802.73fc1fa4@gandalf.local.home>
	<20140422141650.7f43d5ba@gandalf.local.home>
	<53576859.8060706@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Stanislav Meduna <stano@meduna.org>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.226]:34711 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752284AbaDWMPb (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 23 Apr 2014 08:15:31 -0400
In-Reply-To: <53576859.8060706@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 23 Apr 2014 09:14:33 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> On 04/22/2014 08:16 PM, Steven Rostedt wrote:
> > --- a/kernel/timer.c
> > +++ b/kernel/timer.c
> > @@ -1447,6 +1447,12 @@ static void run_timer_softirq(struct softirq_action *h)
> >  		__run_timers(base);
> >  }
> >  
> > +#ifdef CONFIG_SMP
> > +#define timer_should_raise_softirq(lock)	!spin_do_trylock(lock)
> > +#else
> > +#define timer_should_raise_softirq(lock)	1
> > +#endif
> > +
> 
> No. The lock may be taken but it also may be available no matter if UP
> or not. With this patch applied the lockdep splat will go away but the
> FULL_NO_HZ people will come back because the timer softirq is scheduled
> even if no timer has expired.

Although, as Peter said FULL_NO_HZ is pretty pointless on UP, but I've
been thinking this from a non PREEMPT_RT viewpoint. In non PREEMPT_RT,
spin_locks() are nops, where this is an issue, but in PREEMPT_RT, they
are mutexes, BUT!

The rt_mutex use wait_lock to protect its internal state, which is a raw
spinlock, and in UP it's a nop. That means there's nothing preventing
an interrupt here from corrupting the rtmutex's internal state. I see
this is still an issue, and the warning is still valid.

-- Steve
