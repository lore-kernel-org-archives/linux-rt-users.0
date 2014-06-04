From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/1] rtmutex: Handle when top lock owner changes
Date: Wed, 4 Jun 2014 22:41:52 +0200 (CEST)
Message-ID: <alpine.DEB.2.10.1406042217140.18296@nanos>
References: <1400855410-14773-1-git-send-email-brad.mouring@ni.com> <1400855410-14773-2-git-send-email-brad.mouring@ni.com> <20140603210609.62de6451@gandalf.local.home> <alpine.DEB.2.10.1406041623170.3319@nanos> <20140604114411.0fe51c1d@gandalf.local.home>
 <alpine.DEB.2.10.1406041951210.3319@nanos> <20140604192541.GA9496@linuxgetsreal> <alpine.DEB.2.10.1406042147080.18296@nanos> <20140604200750.GA10343@linuxgetsreal>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Clark Williams <williams@redhat.com>
To: Brad Mouring <bmouring@ni.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140604200750.GA10343@linuxgetsreal>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 4 Jun 2014, Brad Mouring wrote:
> On Wed, Jun 04, 2014 at 09:53:16PM +0200, Thomas Gleixner wrote:
> > Your change wreckages the rt_mutex_owner(lock) == top_task test
> > simply because in that case:
> > 
> >    (rt_mutex_owner(lock) && rt_mutex_owner(lock) != task)
> > 
> > evaluates to true.
> 
> Ah. Yeah. I haven't tested this but it seems sane to me.
> 
> > 
> > So we want this:
> > 
> > Index: tip/kernel/locking/rtmutex.c
> > ===================================================================
> > --- tip.orig/kernel/locking/rtmutex.c
> > +++ tip/kernel/locking/rtmutex.c
> > @@ -375,6 +375,26 @@ static int rt_mutex_adjust_prio_chain(st
> >  	 * walk, we detected a deadlock.
> >  	 */
> >  	if (lock == orig_lock || rt_mutex_owner(lock) == top_task) {
> > +		/*
> > +		 * If the prio chain has changed out from under us, set the task
> > +		 * to the current owner of the lock in the current waiter and
> > +		 * continue walking the prio chain
> > +		 */
> > +		if (rt_mutex_owner(lock) && rt_mutex_owner(lock) != task &&
> > +		    rt_mutex_owner(lock) != top_task) {
> > +			/* Release the old owner */

That's not the old owner. It's the task which was blocked in the lock
chain before we dropped the locks and got preemptible. So we come here
just in the case that the task is now blocked on orig_lock.

We really want to be more than careful about the comments here. The
damned thing is complex enough already, so confusing comments are
actually worse than no comments.

Care to resend?

Thanks,

	tglx
