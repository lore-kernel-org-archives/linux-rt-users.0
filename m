From: Mike Galbraith <efault@gmx.de>
Subject: Re: [patch-rt v2] rtmutex: Fix lock stealing logic
Date: Fri, 23 Jun 2017 16:07:19 +0200
Message-ID: <1498226839.31539.13.camel@gmx.de>
References: <20170616105610.rbc6itylcrsla56l@linutronix.de>
         <1497805317.6229.3.camel@gmx.de> <1498203434.3988.5.camel@gmx.de>
         <20170623093341.547ce155@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.22]:60194 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754035AbdFWOHc (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 23 Jun 2017 10:07:32 -0400
In-Reply-To: <20170623093341.547ce155@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2017-06-23 at 09:33 -0400, Steven Rostedt wrote:
>  				  struct task_struct *task,
> > @@ -886,20 +901,16 @@ static int __try_to_take_rt_mutex(struct
> >  	 */
> >  	if (waiter) {
> >  		/*
> > -		 * If waiter is not the highest priority waiter of
> > -		 * @lock, give up.
> > +		 * If waiter is not the highest priority waiter of @lock,
> > +		 * or its peer when lateral steal is allowed, give up.
> >  		 */
> > -		if (waiter != rt_mutex_top_waiter(lock)) {
> > -			/* XXX rt_mutex_waiter_less() ? */
> > +		if (!rt_mutex_steal(lock, waiter, mode))
> >  			return 0;
> > -		}
> > -
> >  		/*
> >  		 * We can acquire the lock. Remove the waiter from the
> >  		 * lock waiters tree.
> >  		 */
> >  		rt_mutex_dequeue(lock, waiter);
> > -
> 
> I liked that space.

I like minus signs in diffstat, that one was a freebee.  Maintainers
can revive it if they like, or I can post a V3 with it revived as well
as s/rt_mutex_steal/rt_mutex_claim.

	-Mike
