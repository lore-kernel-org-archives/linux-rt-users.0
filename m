From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: workqueue code needing preemption disabled
Date: Mon, 18 Mar 2013 12:23:19 -0400
Message-ID: <1363623799.25967.172.camel@gandalf.local.home>
References: <1363617383.25967.152.camel@gandalf.local.home>
	 <20130318160652.GA20133@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Clark Williams <clark@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Tejun Heo <tj@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130318160652.GA20133@mtj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 2013-03-18 at 09:06 -0700, Tejun Heo wrote:
> Hello, Steven.
> 
> On Mon, Mar 18, 2013 at 10:36:23AM -0400, Steven Rostedt wrote:
> > kernel BUG at kernel/sched/core.c:1731!
> > invalid opcode: 0000 [#1] PREEMPT SMP 
> > CPU 5 
> > Pid: 16637, comm: kworker/5:0 Not tainted 3.6.11-rt30.25.el6rt.x86_64 #1 HP ProLiant DL580 G7
> ...
> > static void try_to_wake_up_local(struct task_struct *p)
> > {
> >         struct rq *rq = task_rq(p);
> > 
> >         BUG_ON(rq != this_rq());  <---- bug here
> 
> It's the local chain wake-up code used to main concurrency.  ie. when
> a worker bound to a CPU schedules out it kicks another worker to take
> its place (in concurrency level).

Yep, I got that much.

> 
> The function is called from inside __schedule() while holding rq->lock
> and requires that the target task is on the same rq as the one trying
> to wake it up.  When it isn't, the above BUG_ON() triggers.

Yeah, that was rather obvious too ;-)

> 
> On non-RT kernel, this usually happens, when I screw up CPU hotplug
> code - e.g. enabling concurrency management when all workers are not
> rebound to the CPU yet.
> 
> > Now in your code you have the comment:
> > 
> >  * X: During normal operation, modification requires gcwq->lock and
> >  *    should be done only from local cpu.  Either disabling preemption
> >  *    on local cpu or grabbing gcwq->lock is enough for read access.
> >  *    If GCWQ_DISASSOCIATED is set, it's identical to L.
> > 
> > struct worker has flags marked with X.
> > struct worker_pool has flags and idle_list marked with X.
> 
> So, the weird 'X' rule is there to guarantee that wq_worker_sleeping()
> and try_to_wake_up() can peek the data fields necessary to perform
> local wakeup (determining whether and who to wakeup and actuallying
> doing it) while holding rq->lock.
> 
> > spin_locks in -rt do not disable preemption, nor do they disable irqs,
> > but they do disable migration. If there's code that depends on the
> > spin_lock disabling preemption, we need to either change the code to not
> > require that, or explicitly disable preemption in the critical paths.
> > Note, if we explicitly disable preemption, we can not call spin_locks
> > within those locations as in -rt a spin_lock can block and schedule.
> 
> Maybe I'm confused but I can't really see how the above would be a
> problem to workqueue in itself.  Both rq->lock and gcwq->lock are
> irq-safe, so spin_lock() not disabling preemption shouldn't be a
> problem.  Are CPU hotplug operations involved?

No CPU hotplug is involved here. But I will note that gcwq->lock in -rt
is not irq -safe. That is, in rt the spin_lock_irq(&gcwq->lock) really
becomes a special "mutex_lock(&gcwq->lock)". Because, in -rt, interrupts
(except for the timer interrupt) are run as threads, and anything that
isn't marked as raw_spin_lock() turns into a mutex. I don't believe it's
safe to turn the gcwq->lock into a raw_spin_lock either, or at least not
short enough to hold it. Anything that holds a spin_lock() for more than
a microsecond is too much for a raw lock.

-- Steve
