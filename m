From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH RT] futex/rtmutex: Cure RT double blocking issue
Date: Thu, 11 May 2017 09:31:53 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1705110931240.1758@nanos>
References: <alpine.DEB.2.20.1705091707180.1798@nanos> <CANRm+Cx9msxF2jVsW6ZSXp5+u+L8yKq_KjcwBm5Bm=HLsvCK8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: LKML <linux-kernel@vger.kernel.org>,
        Sebastian Sewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Engleder Gerhard <eg@keba.com>
To: Wanpeng Li <kernellwp@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CANRm+Cx9msxF2jVsW6ZSXp5+u+L8yKq_KjcwBm5Bm=HLsvCK8w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 11 May 2017, Wanpeng Li wrote:
> 2017-05-09 23:11 GMT+08:00 Thomas Gleixner <tglx@linutronix.de>:
> > RT has a problem when the wait on a futex/rtmutex got interrupted by a
> > timeout or a signal. task->pi_blocked_on is still set when returning from
> > rt_mutex_wait_proxy_lock(). The task must acquire the hash bucket lock
> > after this.
> >
> > If the hash bucket lock is contended then the
> > BUG_ON(rt_mutex_real_waiter(task->pi_blocked_on)) in
> > task_blocks_on_rt_mutex() will trigger.
> >
> > This can be avoided by clearing task->pi_blocked_on in the return path of
> > rt_mutex_wait_proxy_lock() which removes the task from the boosting chain
> > of the rtmutex. That's correct because the task is not longer blocked on
> > it.
> >
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > Reported-by: Engleder Gerhard <eg@keba.com>
> > ---
> >  kernel/locking/rtmutex.c |   17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >
> > --- a/kernel/locking/rtmutex.c
> > +++ b/kernel/locking/rtmutex.c
> > @@ -2380,6 +2380,7 @@ int rt_mutex_wait_proxy_lock(struct rt_m
> >                                struct hrtimer_sleeper *to,
> >                                struct rt_mutex_waiter *waiter)
> >  {
> > +       struct task_struct *tsk = current;
> >         int ret;
> >
> >         raw_spin_lock_irq(&lock->wait_lock);
> > @@ -2389,6 +2390,22 @@ int rt_mutex_wait_proxy_lock(struct rt_m
> >         /* sleep on the mutex */
> >         ret = __rt_mutex_slowlock(lock, TASK_INTERRUPTIBLE, to, waiter, NULL);
> 
> Why not check the ret value to avoid lock/unlock tsk->pi_lock when
> acquires the rt_mutex successfully?

Make sense.

Thanks,

	tglx
