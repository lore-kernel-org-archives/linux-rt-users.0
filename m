From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC -rt] updated synchronize_all_irqs implementation
Date: Wed, 26 Sep 2007 12:55:13 -0700
Message-ID: <20070926195513.GA10544@linux.vnet.ibm.com>
References: <20070925193454.GH8432@linux.vnet.ibm.com> <Pine.LNX.4.58.0709251601240.14583@gandalf.stny.rr.com> <20070926012447.7ffdd45a@lappy> <20070926011139.GW8432@linux.vnet.ibm.com> <20070926102833.17f7c025@twins> <20070926130326.GC19496@linux.vnet.ibm.com> <d120d5000709260616s5e3548d8j7b24f2123bf2d02f@mail.gmail.com> <20070926155656.GA9101@linux.vnet.ibm.com> <d120d5000709261019v3c514fc7y49f5f0fe2c43a8a6@mail.gmail.com> <Pine.LNX.4.58.0709261341170.18417@gandalf.stny.rr.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	linux-rt-users@vger.kernel.org, mingo@elte.hu, tglx@linutronix.de,
	dvhltc@us.ibm.com, tytso@us.ibm.com, akpm@linux-foundation.org,
	nickpiggin@yahoo.com.au
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e6.ny.us.ibm.com ([32.97.182.146]:45343 "EHLO e6.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751821AbXIZTzR (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 26 Sep 2007 15:55:17 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l8QJuidS007104
	for <linux-rt-users@vger.kernel.org>; Wed, 26 Sep 2007 15:56:44 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id l8QJtFQW683252
	for <linux-rt-users@vger.kernel.org>; Wed, 26 Sep 2007 15:55:15 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l8QJtDXm032425
	for <linux-rt-users@vger.kernel.org>; Wed, 26 Sep 2007 15:55:14 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0709261341170.18417@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, Sep 26, 2007 at 01:44:22PM -0400, Steven Rostedt wrote:
> --
> On Wed, 26 Sep 2007, Dmitry Torokhov wrote:
> > > The synchronize_all_irqs() will not return until:
> > >
> > > 1.      All pre-existing hardirqs have completed.
> > >
> > > 2.      All pre-existing threaded irqs have completed.
> > >
> > > 3.      All preempt_disable() regions of code have completed.
> > >
> > > 4.      All irq-disable regions of code have completed.
> > >
> > > It will not necessarily wait for all softirqs to complete, but
> > > then again, synchronize_sched() in non-rt might not wait for all
> > > softirqs either, for example, if ksoftirqd is handling softirqs.
> > >
> > > Does that do what you need, or am I missing a case that needs
> > > to be covered?
> >
> > As long as the list includes code guarded by
> > spin_lock_irqsave()/spin_unlock_irqrestore() I am happy. Does this
> > count as an irq-disable region? Peter said earlier that in -rt such
> > code still runs with IRQs enabled...
> 
> No it does not guarantee that in -rt.  Peter is correct that in the -rt
> patch, spin_lock_irqsave and restore do not touch actual interrupts (when
> PREEMPT_RT is configured).  And the above protections that Paul has shown
> also does not guarantee that all spin-locks will be released.
> 
> spin_locks in -rt become mutexes, and if some low priority process grabs
> some spin_lock somewhere that no other process cares about, and then this
> process gets preempted by a bunch of RT hogs, that lock could be held for
> an awfully long time.
> 
> Paul, has there been any work to guarantee such a thing?

Well, we could make spin_lock_irqsave() invoke rcu_read_lock() and
spin_lock_irqrestore() invoke rcu_read_unlock(), with similar adjustments
to the other primitives in this group.  Then RCU priority boosting would
kick in if configured.

Of course, someone who is not quite so closely linked to RCU might be
able to come up with some other solution.  ;-)

						Thanx, Paul
