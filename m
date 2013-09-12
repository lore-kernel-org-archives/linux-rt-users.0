From: Mike Galbraith <bitbucket@online.de>
Subject: Re: [PATCH RT]  rt,ipc,sem: fix -rt livelock
Date: Thu, 12 Sep 2013 09:40:28 +0200
Message-ID: <1378971628.10696.88.camel@marge.simpson.net>
References: <20130819213324.405942342@goodmis.org>
	 <1377842245.5422.7.camel@marge.simpson.net>
	 <1377873580.5422.25.camel@marge.simpson.net>
	 <1377926850.6234.22.camel@marge.simpson.net>
	 <1378451338.5434.91.camel@marge.simpson.net>
	 <1378794614.6046.37.camel@marge.simpson.net>
	 <52307814.4020104@colorfullife.com>
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
Received: from moutng.kundenserver.de ([212.227.126.187]:61270 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751201Ab3ILHkj (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 12 Sep 2013 03:40:39 -0400
In-Reply-To: <52307814.4020104@colorfullife.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 2013-09-11 at 16:03 +0200, Manfred Spraul wrote: 
> Hi Mike,
> 
> On 09/10/2013 08:30 AM, Mike Galbraith wrote:
> >
> > You can kill this particular (osim induced) livelock by using Manfred's
> > completion wakeup scheme.  It may not make it all better, but it does
> > eliminate this trigger, despite that not being what the patch is about.
> 
> [snip]
> 
> > +#elif defined(SYSVSEM_CUSTOM)
> > +	struct queue_done {
> > +		atomic_t done;
> > +	};
> > +
> > +	static void queuewakeup_prepare(void)
> > +	{
> > +		preempt_disable();
> > +	}
> > +
> > +	static void queuewakeup_completed(void)
> > +	{
> > +		preempt_enable();
> > +	}
> > +
> > +	static void queuewakeup_handsoff(struct queue_done *qd)
> > +	{
> > +		BUG_ON(atomic_read(&qd->done) != 2);
> > +		smp_mb();
> > +		atomic_set(&qd->done, 1);
> > +	}
> > +
> > +	static void queuewakeup_init(struct queue_done *qd)
> > +	{
> > +		atomic_set(&qd->done, 2);
> > +	}
> > +
> > +	static void queuewakeup_wait(struct queue_done *qd)
> > +	{
> > +		while (atomic_read(&qd->done) != 1)
> > +			cpu_relax();
> > +
> > +		smp_mb();
> > +	}
> Two remarks:
> - The reason why a standard waitqueue is not used should be mentioned in 
> the commit comment:
> 
> A standard wait queue that waits with a timeout (or with 
> TASK_INTERRUPTIBLE) doesn't allow the caller of add_wait_queue to figure 
> out if the thread was woken up to due expiry of the timer or due to an 
> explicit wake_up() call.
> a) The ipc code must know that in order to decide if the task must 
> return with -EAGAIN/-EINTR or with 0. Therefore ipc/sem.c, ipc/msg.c and 
> ipc/mqueue.c use custom queues.
> b) These custom queues have a lockless fast-path for a successful 
> operation - and this fast path must handle the various races that may 
> happen the timer expires in parallel with a wake_up() call.

If maintainers are interested, I can add that and clean up hammer marks
so it can be applied in lieu of the existing rt wakeup patch instead of
being crammed in on top of it, or they can trivially do that themselves,
both options presuming your (implied) approval.

> - the ipc/msg.c and ipc/mqueue.c should be converted as well (just 
> search for cpu_relax()).

Thanks, I'll save this.

ATM, I'm more mystified by 3.10.10-rt wild variance, independent of
hacked up/virgin/PREEMPT/NOPREEMPT whatever whereas 3.0-rt with the same
semaphore changes wedged in scaled perfectly/stably to 64 cores
regardless of same variables on same box.  That shouldn't have happened,
so I'm going to try out mainline, see what box does with that.

-Mike

