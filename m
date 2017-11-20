From: Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: [PATCH PREEMPT RT] rt-mutex: fix deadlock in device mapper
Date: Mon, 20 Nov 2017 17:11:06 -0500 (EST)
Message-ID: <alpine.LRH.2.02.1711201706190.24006@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1711131245580.23280@file01.intranet.prod.int.rdu2.redhat.com> <20171117145744.t366d2ztxj2qqnco@linutronix.de> <1511030230.12841.42.camel@gmx.de> <20171120105310.zsd6kotreig6nvik@linutronix.de>
 <alpine.LRH.2.02.1711201621260.24006@file01.intranet.prod.int.rdu2.redhat.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="185206533-587370929-1511215866=:24006"
Cc: Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
To: Sebastian Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LRH.2.02.1711201621260.24006@file01.intranet.prod.int.rdu2.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--185206533-587370929-1511215866=:24006
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT



On Mon, 20 Nov 2017, Mikulas Patocka wrote:

> 
> 
> On Mon, 20 Nov 2017, Sebastian Siewior wrote:
> 
> > On 2017-11-18 19:37:10 [+0100], Mike Galbraith wrote:
> > > Below is my 2012 3.0-rt version of that for reference; at that time we
> > > were using slab, and slab_lock referenced below was a local_lock.  The
> > > comment came from crash analysis of a deadlock I met before adding the
> > > (yeah, hacky) __migrate_disabled() blocker.  At the time, that was not
> > > an optional hack, you WOULD deadlock if you ground disks to fine powder
> > > the way SUSE QA did.  Pulling the plug before blocking cured the
> > > xfs/ext[34] IO deadlocks they griped about, but I had to add that hack
> > > to not trade their nasty IO deadlocks for the more mundane variety.  So
> > > my question is: are we sure that in the here and now flush won't want
> > > any lock we may be holding?  In days of yore, it most definitely would
> > > turn your box into a doorstop if you tried hard enough.
> > 
> > I have a deadlock in ftest01/LTP which is cured by that.
> > The root-problem (as I understand it) is that !RT does
> >   schedule() -> sched_submit_work() -> blk_schedule_flush_plug()
> > 
> > on a lock contention (that is that bit_spinlock or rwsem in jbd2/ext4
> > for instance). On RT this does not happen because of tsk_is_pi_blocked()
> > check in sched_submit_work(). That check is needed because an additional
> > (rtmutex) lock can not be acquired at this point.
> 
> bit_spin_lock on non-RT kernel doesn't call blk_schedule_flush_plug(). So, 
> if not calling it causes deadlock, it should be fixed in non-RT kernel as 
> well.
> 
> It is highly questionable - how could bit_spin_lock depend on 
> blk_schedule_flush_plug() at all? bit_spin_lock spins in a loop until the 
> specified bit is clear. blk_schedule_flush_plug() submits disk requests to 
> the disk driver.
> 
> If some part of kernel spins until disk requests are completed, it is 
> already seriously misdesigned. Spinning until disk requests complete 
> wouldn't work on uniprocessor non-preemptive kernel at all.
> 
> So, I suspect that the cause of the deadlock is something completely 
> different.
> 
> Mikulas

BTW. if you have some deadlock on jbd_lock_bh_state or 
jbd_lock_bh_journal_head or bh_uptodate_lock_irqsave (these functions use 
bit_spin_lock on non-RT kernel) - then, there must be some other task that 
holds this lock, so identify such task and send the stacktrace for 
analysis.

It may be a generic bug in jbd2 code (that is just triggered because the 
RT patch changes timings) or it may be jbd2 code incorrectly patched by 
the RT patch.

Spinlocks have nothing to do with blk_schedule_flush_plug().

Mikulas
--185206533-587370929-1511215866=:24006--
