From: Mike Galbraith <bitbucket@online.de>
Subject: Re: [PATCH] rcu: Eliminate softirq processing from rcutree
Date: Sat, 18 Jan 2014 04:25:14 +0100
Message-ID: <1390015514.5444.46.camel@marge.simpson.net>
References: <20131221193900.GA8427@linutronix.de>
	 <1387681647.5412.25.camel@marge.simpson.net>
	 <1387702631.5412.101.camel@marge.simpson.net>
	 <1387773533.5369.16.camel@marge.simpson.net>
	 <20131224193636.GD19211@linux.vnet.ibm.com>
	 <1387940854.5373.8.camel@marge.simpson.net>
	 <20131225075544.GE19211@linux.vnet.ibm.com>
	 <1387993057.5346.17.camel@marge.simpson.net>
	 <20140117171441.GG5785@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: paulmck@linux.vnet.ibm.com, linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140117171441.GG5785@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 2014-01-17 at 18:14 +0100, Sebastian Andrzej Siewior wrote: 
> * Mike Galbraith | 2013-12-25 18:37:37 [+0100]:
> 
> >On Tue, 2013-12-24 at 23:55 -0800, Paul E. McKenney wrote: 
> >> On Wed, Dec 25, 2013 at 04:07:34AM +0100, Mike Galbraith wrote:
> >
> >Having sufficiently recovered from turkey overdose to be able to slither
> >upstairs (bump bump bump) to check on the box, commenting..
> >
> ># timers-do-not-raise-softirq-unconditionally.patch
> ># rtmutex-use-a-trylock-for-waiter-lock-in-trylock.patch
> >
> >..those two out does seem to have stabilized the thing.
> 
> timers-do-not-raise-softirq-unconditionally.patch is on its way out.
> 
> rtmutex-use-a-trylock-for-waiter-lock-in-trylock.patch confues me.
> Didn't you report once that your box deadlocks without this patch? Now
> your 64way box on the other hand does not work with it?

If 'do not raise' is applied, 'use a trylock' won't save you.  If 'do
not raise' is not applied, _and_ you wisely do not try to turn on very
expensive nohz_full, things work fine without 'use a trylock'.

-Mike
