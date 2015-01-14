From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 3/7] wait.[ch]: Introduce the simple waitqueue (swait)
 implementation
Date: Wed, 14 Jan 2015 15:31:02 +0100
Message-ID: <20150114143102.GE22386@worktop.programming.kicks-ass.net>
References: <1413591782-23453-1-git-send-email-paul.gortmaker@windriver.com>
 <1413591782-23453-4-git-send-email-paul.gortmaker@windriver.com>
 <20150114103834.GN23965@worktop.programming.kicks-ass.net>
 <20150114091849.501a0a72@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150114091849.501a0a72@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, Jan 14, 2015 at 09:18:49AM -0500, Steven Rostedt wrote:
> > +/*
> > + * Does not allow usage from IRQ disabled, since we must be able to
> > + * release IRQs to guarantee bounded hold time.
> 
> Actually we (-rt people) don't care if it's done with irq disabled, as
> long is it was disabled via spin_lock_irq*() and not
> raw_spin_lock_irq() or local_irq_save/disable().
> 
> Because in that case, in -rt, irqs would not be disabled. We could add a
> check in -rt that makes sure that's the case. I would think this is OK
> to call from an interrupt handler as long as it is a thread in -rt.
> 
> But, we can keep this restriction for now and change it if we find that
> the restriction is preventing us from using it someplace where its
> needed for -rt.

One of the reasons for the swait thing is to be able to use
raw_spinlock_t, and iirc raw_spin_lock_irq() will still disable IRQs
even on RT.

> > + */
> > +void __swake_up_all(struct swait_queue_head *q, unsigned int state)
> > +{
> > +	struct swait_queue *curr, *next;
> > +	LIST_HEAD(tmp);
> > +
> > +	__swait_wakeup_debug(q, state);
> > +
> > +	if (!swait_active(q))
> > +		return;
> > +
> > +	raw_spin_lock_irq(&q->lock);
> > +	list_splice_init(&q->task_list, &tmp);
> > +	while (!list_empty(&tmp)) {
> > +		curr = list_first_entry(&tmp, typeof(curr), task_list);
> > +
> > +		wake_up_state(curr->task, state);
> > +		list_del_init(&curr->task_list);
> 
> What happens if curr->task does not match state? We just removed it
> from the list and never woke it up, didn't we?

Then you've messed up. One should not mix and match states with swait
queues, there's some debug code that tries to make sure you don't do
this.
