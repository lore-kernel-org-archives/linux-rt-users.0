From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC -rt] updated synchronize_all_irqs implementation
Date: Wed, 26 Sep 2007 10:43:41 -0700
Message-ID: <20070926174341.GF9101@linux.vnet.ibm.com>
References: <Pine.LNX.4.58.0709251317080.5676@gandalf.stny.rr.com> <20070925193454.GH8432@linux.vnet.ibm.com> <Pine.LNX.4.58.0709251601240.14583@gandalf.stny.rr.com> <20070926012447.7ffdd45a@lappy> <20070926011139.GW8432@linux.vnet.ibm.com> <20070926102833.17f7c025@twins> <20070926130326.GC19496@linux.vnet.ibm.com> <d120d5000709260616s5e3548d8j7b24f2123bf2d02f@mail.gmail.com> <20070926155656.GA9101@linux.vnet.ibm.com> <d120d5000709261019v3c514fc7y49f5f0fe2c43a8a6@mail.gmail.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-users@vger.kernel.org, mingo@elte.hu, tglx@linutronix.de,
	dvhltc@us.ibm.com, tytso@us.ibm.com, akpm@linux-foundation.org,
	nickpiggin@yahoo.com.au
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e1.ny.us.ibm.com ([32.97.182.141]:52035 "EHLO e1.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754149AbXIZRnr (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 26 Sep 2007 13:43:47 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l8QHhi76001497
	for <linux-rt-users@vger.kernel.org>; Wed, 26 Sep 2007 13:43:44 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id l8QHhil8693142
	for <linux-rt-users@vger.kernel.org>; Wed, 26 Sep 2007 13:43:44 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l8QHhgNM024273
	for <linux-rt-users@vger.kernel.org>; Wed, 26 Sep 2007 13:43:44 -0400
Content-Disposition: inline
In-Reply-To: <d120d5000709261019v3c514fc7y49f5f0fe2c43a8a6@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, Sep 26, 2007 at 01:19:05PM -0400, Dmitry Torokhov wrote:
> On 9/26/07, Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:
> > On Wed, Sep 26, 2007 at 09:16:55AM -0400, Dmitry Torokhov wrote:
> >
> > > No, I don't think synchronize_irq() will work for me. While in i8042 I
> > > know there are 2 possible IRQs (so I'd need 2 calls to
> > > synchronize_irq()) other drivers may not know what IRQ triggered their
> > > handler (or whether it was an IRQ at all).
> > >
> > > Actually, I need clarifucation on what you mean by "interrupt
> > > handlers" in sync_all_irqs(). Right now (if I understand it correctly)
> > > synchronize_sched() in mainline will wait for completion of all
> > > IRQ-like contexts. By IRQ-like context I mean code guardede by
> > > spinlock + IRQ off. Serio (input) drivers have their "interrupt"
> > > routines run in that IRQ-like context. They may be invoked as a result
> > > of real IRQ being raised but they also be invoked as a result of
> > > userspace action of some sort. It all depends on implementation of
> > > underlying serio port. So if sync_all_irqs() only waits for real IRQ
> > > handlers to complete it is not sufficient in my case...
> >
> > The synchronize_all_irqs() will not return until:
> >
> > 1.      All pre-existing hardirqs have completed.
> >
> > 2.      All pre-existing threaded irqs have completed.
> >
> > 3.      All preempt_disable() regions of code have completed.
> >
> > 4.      All irq-disable regions of code have completed.
> >
> > It will not necessarily wait for all softirqs to complete, but
> > then again, synchronize_sched() in non-rt might not wait for all
> > softirqs either, for example, if ksoftirqd is handling softirqs.
> >
> > Does that do what you need, or am I missing a case that needs
> > to be covered?
> 
> As long as the list includes code guarded by
> spin_lock_irqsave()/spin_unlock_irqrestore() I am happy. Does this
> count as an irq-disable region? Peter said earlier that in -rt such
> code still runs with IRQs enabled...

If I remember correctly, it depends on whether the underlying spinlock
is spinlock_t or raw_spinlock_t.

However, doesn't spin_lock_irqsave() disable preemption in both cases
(either explicitly for the spinlock_t case or implicitly via irq
disable in the raw_spinlock_t case)?  If so, synchronize_all_irqs()
should do what you want in both cases.

						Thanx, Paul
