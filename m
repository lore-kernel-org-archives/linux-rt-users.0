From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [ANNOUNCE] 4.4-rc6-rt1
Date: Thu, 14 Jan 2016 15:57:02 +0100
Message-ID: <1452783422.3611.8.camel@gmail.com>
References: <20151223225755.GA21121@linutronix.de>
	 <20151231102441.581ce1e1@sluggy.hsv.redhat.com>
	 <1451632781.9800.22.camel@gmail.com> <20160113175845.GK29964@linutronix.de>
	 <20160114141744.GB17776@linutronix.de>
	 <1452781751.3460.102.camel@gmail.com>
	 <alpine.DEB.2.11.1601141528550.3575@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <williams@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.11.1601141528550.3575@nanos>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 2016-01-14 at 15:30 +0100, Thomas Gleixner wrote:
> On Thu, 14 Jan 2016, Mike Galbraith wrote:
> 
> > On Thu, 2016-01-14 at 15:17 +0100, Sebastian Andrzej Siewior wrote:
> > > * Sebastian Andrzej Siewior | 2016-01-13 18:58:45 [+0100]:
> > > 
> > > > This is due to NO_HZ as far as I can tell. My AMD A10 in idle
> mode
> > > > has
> > > > 0.7% utilisation of ksoftirqd/ with CONFIG_HZ_PERIODIC and with
> > > > CONFIG_NO_HZ_FULL it shows about 25% on all CPU threads.
> > > 
> > > This should fixed it:
> > > 
> > > --- a/kernel/time/timer.c
> > > +++ b/kernel/time/timer.c
> > > @@ -1453,7 +1453,7 @@ u64 get_next_timer_interrupt(unsigned long
> > > basej, u64 basem)
> > >      * the base lock to check when the next timer is pending and
> > > so
> > >      * we assume the next jiffy.
> > >      */
> > > -   return basej;
> > > +   return basem + TICK_NSEC;
> > >  #endif
> > >     spin_lock(&base->lock);
> > >     if (base->active_timers) {
> > 
> > That's what I had done to stop the screaming interrupt, but box
> still
> > behaved very badly.
> 
> If you turn off CONFIG_NO_HZ_FULL and switch to NO_HZ_IDLE is it
> still bad?

I didn't have CONFIG_NO_HZ_FULL enabled, it was CONFIG_NO_HZ_IDLE.

	-Mike
