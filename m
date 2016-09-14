From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] fs/dcache: resched/chill only if we make no progress
Date: Wed, 14 Sep 2016 19:14:16 +0200
Message-ID: <20160914171416.c2k7l2flu4ufdks2@linutronix.de>
References: <20160908182503.bh77mwwhjhiaqf4y@linutronix.de>
 <alpine.DEB.2.20.1609100811410.9305@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1609100811410.9305@nanos>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2016-09-10 08:17:13 [+0200], Thomas Gleixner wrote:
> On Thu, 8 Sep 2016, Sebastian Andrzej Siewior wrote:
> > +		if (parent == dentry) {
> > +			/* the task with the highest priority won't schedule */
> > +			r = cond_resched();
> > +			if (!r && (rt_task(current) || dl_task(current)))
> 
> That's wrong because a non RT task will just spin until its time slice is
> up. Wasted cycles for nothing.
> 
> Ideally we make spinning conditional on 
> 
>     !on_cpu(dentry->lock->owner)
> 
> That would avoid going to sleep if the owner runs on another cpu. We have
> no mechanism for that, but I think it'd be worth to think about one.

something like

|#ifdef CONFIG_SMP
|                             task_running(task_rq(lock_owner), lock_owner))
|#else
|                             1)
|#endif
|                                 cpu_chill();

the lock_owner is tricky because we have two locks: inode->i_lock and
parent->d_lock. So we would have to do the same lookup, like
dentry_kill() is doing, and check both in worth case.

Sebastian
