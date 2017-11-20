From: Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: [PATCH PREEMPT RT] rt-mutex: fix deadlock in device mapper
Date: Mon, 20 Nov 2017 16:31:03 -0500 (EST)
Message-ID: <alpine.LRH.2.02.1711201621260.24006@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1711131245580.23280@file01.intranet.prod.int.rdu2.redhat.com> <20171117145744.t366d2ztxj2qqnco@linutronix.de> <1511030230.12841.42.camel@gmx.de> <20171120105310.zsd6kotreig6nvik@linutronix.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="185206533-979564102-1511213286=:24006"
Cc: Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
To: Sebastian Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52960 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752890AbdKTVbE (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 20 Nov 2017 16:31:04 -0500
In-Reply-To: <20171120105310.zsd6kotreig6nvik@linutronix.de>
Content-ID: <alpine.LRH.2.02.1711201628120.24006@file01.intranet.prod.int.rdu2.redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--185206533-979564102-1511213286=:24006
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.LRH.2.02.1711201628121.24006@file01.intranet.prod.int.rdu2.redhat.com>



On Mon, 20 Nov 2017, Sebastian Siewior wrote:

> On 2017-11-18 19:37:10 [+0100], Mike Galbraith wrote:
> > Below is my 2012 3.0-rt version of that for reference; at that time we
> > were using slab, and slab_lock referenced below was a local_lock.  The
> > comment came from crash analysis of a deadlock I met before adding the
> > (yeah, hacky) __migrate_disabled() blocker.  At the time, that was not
> > an optional hack, you WOULD deadlock if you ground disks to fine powder
> > the way SUSE QA did.  Pulling the plug before blocking cured the
> > xfs/ext[34] IO deadlocks they griped about, but I had to add that hack
> > to not trade their nasty IO deadlocks for the more mundane variety.  So
> > my question is: are we sure that in the here and now flush won't want
> > any lock we may be holding?  In days of yore, it most definitely would
> > turn your box into a doorstop if you tried hard enough.
> 
> I have a deadlock in ftest01/LTP which is cured by that.
> The root-problem (as I understand it) is that !RT does
>   schedule() -> sched_submit_work() -> blk_schedule_flush_plug()
> 
> on a lock contention (that is that bit_spinlock or rwsem in jbd2/ext4
> for instance). On RT this does not happen because of tsk_is_pi_blocked()
> check in sched_submit_work(). That check is needed because an additional
> (rtmutex) lock can not be acquired at this point.

bit_spin_lock on non-RT kernel doesn't call blk_schedule_flush_plug(). So, 
if not calling it causes deadlock, it should be fixed in non-RT kernel as 
well.

It is highly questionable - how could bit_spin_lock depend on 
blk_schedule_flush_plug() at all? bit_spin_lock spins in a loop until the 
specified bit is clear. blk_schedule_flush_plug() submits disk requests to 
the disk driver.

If some part of kernel spins until disk requests are completed, it is 
already seriously misdesigned. Spinning until disk requests complete 
wouldn't work on uniprocessor non-preemptive kernel at all.

So, I suspect that the cause of the deadlock is something completely 
different.

Mikulas

> With this change we get closer to what !RT does. In regard to that
> migrate_disable() we could check if it is possible to do that after we
> acquired the lock (which is something we tried before but failed due to
> CPU-hotplug requirement, maybe something changed now) or flush the plug
> before disabling migration if it is really a problem.
> 
> To your question whether or not delaying IO can cause any deadlocks is
> something that I can't answer and this something that would affect !RT,
> too. I tried to add lockdep to bit-spinlocks but this does not work
> because one context acquires the lock and another does the unlock. It
> has been explained to me that no deadlocks should happen as long as
> the IO is flushed before we block/wait on a lock.
> 
> > Subject: rt: pull your plug before blocking
> > Date: Wed Jul 18 14:43:15 CEST 2012
> > From: Mike Galbraith <efault@gmx.de>
> > 
> > Queued IO can lead to IO deadlock should a task require wakeup from a task
> > which is blocked on that queued IO.
> > 
> > ext3: dbench1 queues a buffer, blocks on journal mutex, it's plug is not
> > pulled.  dbench2 mutex owner is waiting for kjournald, who is waiting for
> > the buffer queued by dbench1.  Game over.
> > 
> > Signed-off-by: Mike Galbraith <efault@gmx.de>
> > ---
> >  kernel/locking/rtmutex.c |   18 ++++++++++++++++--
> >  1 file changed, 16 insertions(+), 2 deletions(-)
> > 
> > --- a/kernel/locking/rtmutex.c
> > +++ b/kernel/locking/rtmutex.c
> > @@ -22,6 +22,7 @@
> >  #include <linux/sched/deadline.h>
> >  #include <linux/timer.h>
> >  #include <linux/ww_mutex.h>
> > +#include <linux/blkdev.h>
> >  
> >  #include "rtmutex_common.h"
> >  
> > @@ -930,8 +931,18 @@ static inline void rt_spin_lock_fastlock
> >  
> >  	if (likely(rt_mutex_cmpxchg_acquire(lock, NULL, current)))
> >  		rt_mutex_deadlock_account_lock(lock, current);
> > -	else
> > +	else {
> > +		/*
> > +		 * We can't pull the plug if we're already holding a lock
> > +		 * else we can deadlock.  eg, if we're holding slab_lock,
> > +		 * ksoftirqd can block while processing BLOCK_SOFTIRQ after
> > +		 * having acquired q->queue_lock.  If _we_ then block on
> > +		 * that q->queue_lock while flushing our plug, deadlock.
> > +		 */
> > +		if (__migrate_disabled(current) < 2 && blk_needs_flush_plug(current))
> > +			blk_schedule_flush_plug(current);
> >  		slowfn(lock);
> > +	}
> >  }
> >  
> >  static inline void rt_spin_lock_fastunlock(struct rt_mutex *lock,
> > @@ -1892,9 +1903,12 @@ rt_mutex_fastlock(struct rt_mutex *lock,
> >  	if (likely(rt_mutex_cmpxchg_acquire(lock, NULL, current))) {
> >  		rt_mutex_deadlock_account_lock(lock, current);
> >  		return 0;
> > -	} else
> > +	} else {
> > +		if (blk_needs_flush_plug(current))
> > +			blk_schedule_flush_plug(current);
> >  		return slowfn(lock, state, NULL, RT_MUTEX_MIN_CHAINWALK,
> >  			      ww_ctx);
> > +	}
> >  }
> >  
> >  static inline int
> 
> Sebastian
> 
--185206533-979564102-1511213286=:24006--
