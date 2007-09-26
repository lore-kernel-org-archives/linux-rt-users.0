From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC -rt] updated synchronize_all_irqs implementation
Date: Tue, 25 Sep 2007 18:11:39 -0700
Message-ID: <20070926011139.GW8432@linux.vnet.ibm.com>
References: <20070921054656.GA11708@linux.vnet.ibm.com> <20070923173432.GA10542@linux.vnet.ibm.com> <Pine.LNX.4.58.0709251317080.5676@gandalf.stny.rr.com> <20070925193454.GH8432@linux.vnet.ibm.com> <Pine.LNX.4.58.0709251601240.14583@gandalf.stny.rr.com> <20070926012447.7ffdd45a@lappy>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-users@vger.kernel.org, mingo@elte.hu, tglx@linutronix.de,
	dvhltc@us.ibm.com, tytso@us.ibm.com, dmitry.torokhov@gmail.com,
	akpm@linux-foundation.org, nickpiggin@yahoo.com.au
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e5.ny.us.ibm.com ([32.97.182.145]:34023 "EHLO e5.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751950AbXIZBLm (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 25 Sep 2007 21:11:42 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l8Q1BfRh026638
	for <linux-rt-users@vger.kernel.org>; Tue, 25 Sep 2007 21:11:41 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id l8Q1BfWF502928
	for <linux-rt-users@vger.kernel.org>; Tue, 25 Sep 2007 21:11:41 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l8Q1BeFT010252
	for <linux-rt-users@vger.kernel.org>; Tue, 25 Sep 2007 21:11:41 -0400
Content-Disposition: inline
In-Reply-To: <20070926012447.7ffdd45a@lappy>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, Sep 26, 2007 at 01:24:47AM +0200, Peter Zijlstra wrote:
> On Tue, 25 Sep 2007 16:02:45 -0400 (EDT) Steven Rostedt
> <rostedt@goodmis.org> wrote:
> 
> > > This would of course require that synchronize_all_irqs() be in the
> > > RCU code rather than the irq code so that it could access the static
> > > wakeme_after_rcu() definition and the rcu_synchronize structure.
> > >
> > > Thoughts?
> > 
> > I do like this better. Anyone else care to comment?
> 
> I'm still wondering why the IRQ users cannot user proper RCU as it
> stands:

Well, that was my initial proposal.  ;-)

>   rcu_read_lock();
>   foo = rcu_dereference(bar);
>   if (foo)
>     foo();
>   rcu_read_unlock();
> 
> vs
> 
>   rcu_assign(foo, NULL);
>   synchronize_rcu();

For this last, it would be necessary to use SRCU -- also, not sure
we would want the IRQ handler to block this way.  Or am I missing 
something?

> and the like.
> 
> The implicit rcu_read_lock() as placed in handle_IRQ_event() seems
> misplaced.

OK -- where would you put them instead?  I have them covering the
call to the handler, so what am I missing here?

							Thanx, Paul
