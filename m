From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC -rt] updated synchronize_all_irqs implementation
Date: Wed, 26 Sep 2007 14:22:45 -0700
Message-ID: <20070926212245.GB10544@linux.vnet.ibm.com>
References: <20070926012447.7ffdd45a@lappy> <20070926011139.GW8432@linux.vnet.ibm.com> <20070926102833.17f7c025@twins> <20070926130326.GC19496@linux.vnet.ibm.com> <d120d5000709260616s5e3548d8j7b24f2123bf2d02f@mail.gmail.com> <20070926155656.GA9101@linux.vnet.ibm.com> <d120d5000709261019v3c514fc7y49f5f0fe2c43a8a6@mail.gmail.com> <Pine.LNX.4.58.0709261341170.18417@gandalf.stny.rr.com> <20070926195513.GA10544@linux.vnet.ibm.com> <1190840086.18147.38.camel@lappy>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-rt-users@vger.kernel.org, mingo@elte.hu, tglx@linutronix.de,
	dvhltc@us.ibm.com, tytso@us.ibm.com, akpm@linux-foundation.org,
	nickpiggin@yahoo.com.au
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e3.ny.us.ibm.com ([32.97.182.143]:60643 "EHLO e3.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751106AbXIZVWw (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 26 Sep 2007 17:22:52 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l8QLMo63032445
	for <linux-rt-users@vger.kernel.org>; Wed, 26 Sep 2007 17:22:50 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id l8QLMlWA653876
	for <linux-rt-users@vger.kernel.org>; Wed, 26 Sep 2007 17:22:50 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l8QLMjQ2013777
	for <linux-rt-users@vger.kernel.org>; Wed, 26 Sep 2007 17:22:47 -0400
Content-Disposition: inline
In-Reply-To: <1190840086.18147.38.camel@lappy>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, Sep 26, 2007 at 10:54:46PM +0200, Peter Zijlstra wrote:
> 
> On Wed, 2007-09-26 at 12:55 -0700, Paul E. McKenney wrote:
> 
> > Well, we could make spin_lock_irqsave() invoke rcu_read_lock() and
> > spin_lock_irqrestore() invoke rcu_read_unlock(), with similar adjustments
> > to the other primitives in this group.  Then RCU priority boosting would
> > kick in if configured.
> 
> Might be me, but 'hiding' the RCU scope like that makes my skin crawl.
> What is wrong with using rcu_read_lock() explicitly where you depend on
> it? It even makes the code cleaner in that it documents the usage.
> 
> These blanket locks like lock_kernel(), preempt_disable(),
> local_irq_disable() etc. are very hard to get rid of because they don't
> document what is protected.
> 
> Please lets not add to this mess and keep all this explicit.
> 
> Yes, -rt changes the preemption model, and that has concequences. But
> IMHO the resulting code is cleaner in most cases.

I am not going to argue with you on this one!!!

But it is not me that needs convincing.

> I'd go as far as to depricate synchronize_sched() and replace all its
> users with proper RCU.

But this might be going too far, though you might well be able to
convince me.  Reducing RCU API proliferation would be a good thing
in general...

> The more I think of it, the more I dislike this synchronize_all_irqs()
> and the 'magic' property of irq handlers.

So I produced a 'magic' patch?  Cool!!!  ;-)

Seriously, I agree that using explicit rcu_read_lock() where needed would
be much better from a readability and robustness viewpoint.  However,
if the goal is to support the existing code unmodified, then this patch
is one solution.  I would be just as happy to see it become unnecessary
as to see it go in, as long as the problem is solved one way or another.

							Thanx, Paul
