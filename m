From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH] rcu: Eliminate softirq processing from rcutree
Date: Mon, 27 Jan 2014 08:54:05 -0800
Message-ID: <20140127165405.GK9012@linux.vnet.ibm.com>
References: <1387773533.5369.16.camel@marge.simpson.net>
 <20131224193636.GD19211@linux.vnet.ibm.com>
 <1387940854.5373.8.camel@marge.simpson.net>
 <20131225075544.GE19211@linux.vnet.ibm.com>
 <1387993057.5346.17.camel@marge.simpson.net>
 <20140117171441.GG5785@linutronix.de>
 <1390015514.5444.46.camel@marge.simpson.net>
 <20140124195014.GB29981@linutronix.de>
 <1390626760.3625.17.camel@marge.simpson.net>
 <1390799444.5425.61.camel@marge.simpson.net>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
To: Mike Galbraith <bitbucket@online.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1390799444.5425.61.camel@marge.simpson.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, Jan 27, 2014 at 06:10:44AM +0100, Mike Galbraith wrote:
> On Sat, 2014-01-25 at 06:12 +0100, Mike Galbraith wrote: 
> > On Fri, 2014-01-24 at 20:50 +0100, Sebastian Andrzej Siewior wrote: 
> > > * Mike Galbraith | 2014-01-18 04:25:14 [+0100]:
> > > 
> > > >> ># timers-do-not-raise-softirq-unconditionally.patch
> > > >> ># rtmutex-use-a-trylock-for-waiter-lock-in-trylock.patch
> > > >> >
> > > >> >..those two out does seem to have stabilized the thing.
> > > >> 
> > > >> timers-do-not-raise-softirq-unconditionally.patch is on its way out.
> > > >> 
> > > >> rtmutex-use-a-trylock-for-waiter-lock-in-trylock.patch confues me.
> > > >> Didn't you report once that your box deadlocks without this patch? Now
> > > >> your 64way box on the other hand does not work with it?
> > > >
> > > >If 'do not raise' is applied, 'use a trylock' won't save you.  If 'do
> > > is this just an observation or you do know why it won't save me?
> > 
> > It's an observation from beyond the grave from the 64 core box that it
> > repeatedly did NOT save :)  Autopsy photos below.
> > 
> > I've built 3.12.8-rt9 with Stevens v2 "timer: Raise softirq if there's
> > irq_work" to see if it'll survive.
> 
> And it did, configured both as nohz_tick, and nohz_full_all.  The irqs
> are enabled warning in can_stop_full_tick() fired for nohz_full_all, but
> that's it.
> 
> For grins, I also applied Paul's v3 timer latency series while testing
> nohz_full_all config.   The box was heavily loaded the vast majority of
> the time, but it didn't explode or do anything obviously evil.

Cool!  May I add your Tested-by?

							Thanx, Paul
