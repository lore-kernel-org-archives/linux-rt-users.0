From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH RT] rcu,rt: Allow rcu_read_lock_sched() to schedule
Date: Wed, 26 Jun 2013 11:03:20 -0400
Message-ID: <1372259000.18733.258.camel@gandalf.local.home>
References: <1372254133.18733.252.camel@gandalf.local.home>
	 <20130626144045.GO3828@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <clark@redhat.com>
To: paulmck@linux.vnet.ibm.com
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130626144045.GO3828@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 2013-06-26 at 07:40 -0700, Paul E. McKenney wrote:
> On Wed, Jun 26, 2013 at 09:42:13AM -0400, Steven Rostedt wrote:
> > Looking at the 3.10 workqueue code, there's new code that adds
> > local_irq_disable() around places that call spin locks which will turn
> > into rt_mutexes for -rt. Reading the change log to why those
> > local_irq_*() calls were added, it seems to just be to synchronize with
> > synchronize_sched(). Talking with Tejun Heo, he may let me change those
> > to rcu_read_lock_sched() as that is a more appropriate API for the
> > purpose.
> > 
> > But that does not solve the -rt issue because even in -rt,
> > rcu_read_lock_sched() disables preemption, which brings us to the
> > purpose of this patch, to allow rcu_read_lock_sched() to preempt in -rt.
> > 
> > To allow rcu_read_lock_sched() sections to preempt in -rt, instead of
> > disabling preemption, it will grab a local_lock(). Then the
> > synchronize_sched() will grab all CPUs local_locks() and release them.
> > After that, it still does the normal synchronize_sched() as there may be
> > places that still disable preemption or irqs that it needs to
> > synchronize with. By grabbing all the locks and releasing them, it will
> > properly synchronize with those that use the locks instead of disabling
> > preemption or interrupts.
> 
> I tried this approach in early 2005, and testing did not go well:
> 
> https://lkml.org/lkml/2005/3/17/199
> 
> For one thing, a lock acquired both within and surrounding an
> RCU-sched read-side critical section would result in deadlock.
> 
> Or have things changed so that this now somehow works?

Well, so far lockdep hasn't splatted on this. But that's not saying much
because I'm currently fighting the lockdep splats from other workqueue
related stuff.

Seems that Tejun really doesn't like us RT folks ;-)

-- Steve
