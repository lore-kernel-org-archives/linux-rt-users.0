From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch-rt v2] rtmutex: Fix lock stealing logic
Date: Fri, 23 Jun 2017 10:14:55 -0400
Message-ID: <20170623101455.2501f004@gandalf.local.home>
References: <20170616105610.rbc6itylcrsla56l@linutronix.de>
        <1497805317.6229.3.camel@gmx.de>
        <1498203434.3988.5.camel@gmx.de>
        <20170623093341.547ce155@gandalf.local.home>
        <1498226839.31539.13.camel@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
To: Mike Galbraith <efault@gmx.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1498226839.31539.13.camel@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 23 Jun 2017 16:07:19 +0200
Mike Galbraith <efault@gmx.de> wrote:

> On Fri, 2017-06-23 at 09:33 -0400, Steven Rostedt wrote:
> >  				  struct task_struct *task,  
> > > @@ -886,20 +901,16 @@ static int __try_to_take_rt_mutex(struct
> > >  	 */
> > >  	if (waiter) {
> > >  		/*
> > > -		 * If waiter is not the highest priority waiter of
> > > -		 * @lock, give up.
> > > +		 * If waiter is not the highest priority waiter of @lock,
> > > +		 * or its peer when lateral steal is allowed, give up.
> > >  		 */
> > > -		if (waiter != rt_mutex_top_waiter(lock)) {
> > > -			/* XXX rt_mutex_waiter_less() ? */
> > > +		if (!rt_mutex_steal(lock, waiter, mode))
> > >  			return 0;
> > > -		}
> > > -
> > >  		/*
> > >  		 * We can acquire the lock. Remove the waiter from the
> > >  		 * lock waiters tree.
> > >  		 */
> > >  		rt_mutex_dequeue(lock, waiter);
> > > -  
> > 
> > I liked that space.  
> 
> I like minus signs in diffstat, that one was a freebee.  Maintainers
> can revive it if they like, or I can post a V3 with it revived as well
> as s/rt_mutex_steal/rt_mutex_claim.
>

It's not bigly to me.

-- Steve
