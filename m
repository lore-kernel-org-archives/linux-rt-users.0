From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC -rt] updated synchronize_all_irqs implementation
Date: Wed, 26 Sep 2007 17:07:33 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0709261701460.6405@gandalf.stny.rr.com>
References: <20070925193454.GH8432@linux.vnet.ibm.com>
 <Pine.LNX.4.58.0709251601240.14583@gandalf.stny.rr.com>  <20070926012447.7ffdd45a@lappy>
 <20070926011139.GW8432@linux.vnet.ibm.com>  <20070926102833.17f7c025@twins>
 <20070926130326.GC19496@linux.vnet.ibm.com>
 <d120d5000709260616s5e3548d8j7b24f2123bf2d02f@mail.gmail.com>
 <20070926155656.GA9101@linux.vnet.ibm.com>
 <d120d5000709261019v3c514fc7y49f5f0fe2c43a8a6@mail.gmail.com>
 <Pine.LNX.4.58.0709261341170.18417@gandalf.stny.rr.com>
 <20070926195513.GA10544@linux.vnet.ibm.com> <1190840086.18147.38.camel@lappy>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: paulmck@linux.vnet.ibm.com,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-rt-users@vger.kernel.org, mingo@elte.hu, tglx@linutronix.de,
	dvhltc@us.ibm.com, tytso@us.ibm.com, akpm@linux-foundation.org,
	nickpiggin@yahoo.com.au
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:56974 "EHLO
	ms-smtp-03.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762808AbXIZVJX (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 26 Sep 2007 17:09:23 -0400
In-Reply-To: <1190840086.18147.38.camel@lappy>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


--
On Wed, 26 Sep 2007, Peter Zijlstra wrote:
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
>
> I'd go as far as to depricate synchronize_sched() and replace all its
> users with proper RCU.
>
> The more I think of it, the more I dislike this synchronize_all_irqs()
> and the 'magic' property of irq handlers.


Thinking a little more about this, I fully agree with Peter.

What code needs to know that all spin_locks have released, or you want to
know all irq handlers are done?

Seems that this is a broad data to ask for and will be a bitch to clean up
when we find out that this is not scalable. This all sounds like
reinventing the BKL.

If you simply want a RCU type of scheme, then simply use RCU.  I second
deprecating "synchronize_sched". Everything that does RCU type locking
(that is waiting for some kind of grace period to finish) should simply
use RCU and not a "wait for all processes to voluntarily schedule" or
"wait for all interrupt handlers to finish".

-- Steve
