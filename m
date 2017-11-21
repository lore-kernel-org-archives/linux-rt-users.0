From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH PREEMPT RT] rt-mutex: fix deadlock in device mapper
Date: Tue, 21 Nov 2017 09:37:37 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1711210931460.1782@nanos>
References: <alpine.LRH.2.02.1711131245580.23280@file01.intranet.prod.int.rdu2.redhat.com>  <20171117145744.t366d2ztxj2qqnco@linutronix.de>  <1511030230.12841.42.camel@gmx.de>  <alpine.LRH.2.02.1711201607230.24006@file01.intranet.prod.int.rdu2.redhat.com>
 <1511234430.7672.26.camel@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-410801101-1511253458=:1782"
Cc: Mikulas Patocka <mpatocka@redhat.com>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users@vger.kernel.org
To: Mike Galbraith <efault@gmx.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1511234430.7672.26.camel@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-410801101-1511253458=:1782
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Tue, 21 Nov 2017, Mike Galbraith wrote:
> On Mon, 2017-11-20 at 16:33 -0500, Mikulas Patocka wrote:
> > 
> > Is there some specific scenario where you need to call 
> > blk_schedule_flush_plug from rt_spin_lock_fastlock?
> 
> Excellent question.  What's the difference between not getting IO
> started because you meet a mutex with an rt_mutex under the hood, and
> not getting IO started because you meet a spinlock with an rt_mutex
> under the hood?  If just doing the mutex side puts this thing back to
> sleep, I'm happy.

Think about it from the mainline POV.

The spinlock cannot ever go to schedule and therefore cannot create a
situation which requires an unplug. The RT substitution of the spinlock
with a rtmutex based sleeping spinlock should not change that at all.

A regular mutex/rwsem etc. can and will unplug when the lock is contended
and the caller blocks. The RT conversion of these locks to rtmutex based
variants creates the problem: Unplug cannot be called when the task has
pi_blocked_on set because the unplug path might content on yet another
lock. So unplugging in the slow path before setting pi_blocked_on is the
right thing to do.

Thanks,

	tglx
--8323329-410801101-1511253458=:1782--
