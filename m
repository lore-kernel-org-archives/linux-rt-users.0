From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC][PATCH] mm: ifdef out VM_BUG_ON check on PREEMPT_RT_FULL
Date: Thu, 9 Jul 2015 17:07:42 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1507091616400.5134@nanos>
References: <20150529104815.2d2e880c@sluggy> <20150529142614.37792b9ff867626dcf5e0f08@linux-foundation.org> <20150601131452.3e04f10a@sluggy> <20150601190047.GA5879@cmpxchg.org> <20150611114042.GC16115@linutronix.de> <20150619180002.GB11492@cmpxchg.org>
 <20150708154432.GA31345@linutronix.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Weiner <hannes@cmpxchg.org>, Clark Williams <williams@redhat.com>,
    Andrew Morton <akpm@linux-foundation.org>,
    Thomas Gleixner <tglx@glx-um.de>, linux-mm@kvack.org,
    RT <linux-rt-users@vger.kernel.org>,
    Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
    Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>,
    Peter Zijlstra <peterz@infradead.org>,
    "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20150708154432.GA31345@linutronix.de>
Sender: owner-linux-mm@kvack.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 8 Jul 2015, Sebastian Andrzej Siewior wrote:
> * Johannes Weiner | 2015-06-19 14:00:02 [-0400]:
> 
> >> This depends on the point of view. You expect interrupts to be disabled
> >> while taking a lock. This is not how the function is defined.
> >> The function ensures that the lock can be taken from process context while
> >> it may also be taken by another caller from interrupt context. The fact
> >> that it disables interrupts on vanilla to achieve its goal is an
> >> implementation detail. Same goes for spin_lock_bh() btw. Based on this
> >> semantic it works on vanilla and -RT. It does not disable interrupts on
> >> -RT because there is no need for it: the interrupt handler runs in thread
> >> context. The function delivers what it is expected to deliver from API
> >> point of view: "take the lock from process context which can also be
> >> taken in interrupt context".
> >
> >Uhm, that's really distorting reality to fit your requirements.  This
> >helper has been defined to mean local_irq_disable() + spin_lock() for
> >ages, it's been documented in books on Linux programming.  And people
> >expect it to prevent interrupt handlers from executing, which it does.
> 
> After all it documents the current implementation and the semantic
> requirement.

Actually its worse. Most books describe the implementation and pretend
that the implementation defines the semantics, which is the
fundamentally wrong approach.

The sad news is, that a lot of kernel developers tend to believe that
as well.

The result is, that local_irq_disable / preempt_disable have become
per CPU BKLs. And they have the same problem as the BKL:

    The protection scope of these constructs is global and completely
    non-obvious.

So its really hard to figure out what is protected against what. Like
the old BKL its an all or nothing approach. And we all know, or should
know, how well that worked.

This all or nothing protection is a real show stopper for RT, so we
try to identify what needs protection against what and then we
annotate those sections with proper scope markers, which turn into RT
friendly constructs at compile time.

The name of the marker in question (event_lock) might not be the best
choice, but that does not invalidate the general usefulness of fine
granular protection scope markers. We certainly need to revisit the
names which we slapped on the particular bits and pieces, and discuss
with the subsystem experts the correctness of the scope markers, but
that's a completely different story.

> > Seriously, just fix irqs_disabled() to mean "interrupt
> > handlers can't run", which is the expectation in pretty much all
> > callsites that currently use it, except for maybe irq code itself.

And that solves the RT problem in which way? NOT AT ALL. It just
preserves the BKL nature of irq_disable. Great solution, NOT.

Why?

Because it just preserves the status quo of mainline and exposes
everything to the same latency behaviour which mainline has. So we add
lots of mechanisms to avoid that behaviour just to bring it back by
switching the irq disabled BKL on again, which means we are back to
square one.

Thanks,

	tglx

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
