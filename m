From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH RFC -rt] updated synchronize_all_irqs implementation
Date: Wed, 26 Sep 2007 10:28:33 +0200
Message-ID: <20070926102833.17f7c025@twins>
References: <20070921054656.GA11708@linux.vnet.ibm.com>
	<20070923173432.GA10542@linux.vnet.ibm.com>
	<Pine.LNX.4.58.0709251317080.5676@gandalf.stny.rr.com>
	<20070925193454.GH8432@linux.vnet.ibm.com>
	<Pine.LNX.4.58.0709251601240.14583@gandalf.stny.rr.com>
	<20070926012447.7ffdd45a@lappy>
	<20070926011139.GW8432@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-users@vger.kernel.org, mingo@elte.hu, tglx@linutronix.de,
	dvhltc@us.ibm.com, tytso@us.ibm.com, dmitry.torokhov@gmail.com,
	akpm@linux-foundation.org, nickpiggin@yahoo.com.au
To: paulmck@linux.vnet.ibm.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from viefep18-int.chello.at ([213.46.255.22]:63404 "EHLO
	viefep19-int.chello.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751190AbXIZI2n (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 26 Sep 2007 04:28:43 -0400
In-Reply-To: <20070926011139.GW8432@linux.vnet.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 25 Sep 2007 18:11:39 -0700 "Paul E. McKenney"
<paulmck@linux.vnet.ibm.com> wrote:

> On Wed, Sep 26, 2007 at 01:24:47AM +0200, Peter Zijlstra wrote:
> > On Tue, 25 Sep 2007 16:02:45 -0400 (EDT) Steven Rostedt
> > <rostedt@goodmis.org> wrote:
> > 
> > > > This would of course require that synchronize_all_irqs() be in the
> > > > RCU code rather than the irq code so that it could access the static
> > > > wakeme_after_rcu() definition and the rcu_synchronize structure.
> > > >
> > > > Thoughts?
> > > 
> > > I do like this better. Anyone else care to comment?
> > 
> > I'm still wondering why the IRQ users cannot user proper RCU as it
> > stands:
> 
> Well, that was my initial proposal.  ;-)

handler: 
> >   rcu_read_lock();
> >   foo = rcu_dereference(bar);
> >   if (foo)
> >     foo();
> >   rcu_read_unlock();
>

control routine (!handler)
> > vs
> > 
> >   rcu_assign(foo, NULL);
> >   synchronize_rcu();

> > The implicit rcu_read_lock() as placed in handle_IRQ_event() seems
> > misplaced.
> 
> OK -- where would you put them instead?  I have them covering the
> call to the handler, so what am I missing here?

in do_hardirq() (-rt) that is specific to threaded interrupts.

That said, I'm wondering if we need this whole extra sync_all_irqs()
thing. I'm just not getting why IRQ handlers should be an implicit RCU
safe context.
