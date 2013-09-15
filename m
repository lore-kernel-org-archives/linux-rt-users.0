From: Mike Galbraith <bitbucket@online.de>
Subject: Re: [patch 1/3] ipc/sem: fix -rt livelock
Date: Sun, 15 Sep 2013 05:41:41 +0200
Message-ID: <1379216501.5545.72.camel@marge.simpson.net>
References: <1379051751.5455.112.camel@marge.simpson.net>
	 <1379052760.5455.127.camel@marge.simpson.net>
	 <52345582.7020000@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Manfred Spraul <manfred@colorfullife.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:54075 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756901Ab3IODlz (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 14 Sep 2013 23:41:55 -0400
In-Reply-To: <52345582.7020000@colorfullife.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, 2013-09-14 at 14:24 +0200, Manfred Spraul wrote: 
> Hi Mike,

Hi,

> > Index: linux-2.6/ipc/sem.c
> > ===================================================================
> > --- linux-2.6.orig/ipc/sem.c
> > +++ linux-2.6/ipc/sem.c
> > @@ -247,11 +256,22 @@ static inline int sem_lock(struct sem_ar
> >   		 */
> >    lock_array:
> >   		spin_lock(&sma->sem_perm.lock);
> > + wait_array:
> >   		for (i = 0; i < sma->sem_nsems; i++) {
> > -			struct sem *sem = sma->sem_base + i;
> > +			sem = sma->sem_base + i;
> > +#ifdef CONFIG_PREEMPT_RT_BASE
> > +			if (spin_is_locked(&sem->lock))
> > +#endif
> >   			spin_unlock_wait(&sem->lock);
> >   		}
> >   
> I don't like this part of the change:

None of it is pretty, but the livelock is even less pretty ;-)

> It reads like a micro-optimization for spin_unlock_wait() within the 
> ipc/sem.c code.

It's exactly that, hope to hammer fewer locks.

> If spin_unlock_wait() for CONFIG_PREEMPT_RT_BASE is broken, then the 
> implementation of spin_unlock_wait() should be fixed.

But it's not broken, taking the lock lets PI see/fix inversion.

Preemptible locks are (necessary) evil incarnate.

-Mike

