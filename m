From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH RFC -rt] updated synchronize_all_irqs implementation
Date: Wed, 26 Sep 2007 01:24:47 +0200
Message-ID: <20070926012447.7ffdd45a@lappy>
References: <20070921054656.GA11708@linux.vnet.ibm.com>
	<20070923173432.GA10542@linux.vnet.ibm.com>
	<Pine.LNX.4.58.0709251317080.5676@gandalf.stny.rr.com>
	<20070925193454.GH8432@linux.vnet.ibm.com>
	<Pine.LNX.4.58.0709251601240.14583@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	linux-rt-users@vger.kernel.org, mingo@elte.hu, tglx@linutronix.de,
	dvhltc@us.ibm.com, tytso@us.ibm.com, dmitry.torokhov@gmail.com,
	akpm@linux-foundation.org, nickpiggin@yahoo.com.au
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from canuck.infradead.org ([209.217.80.40]:33427 "EHLO
	canuck.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751566AbXIYXaf (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 25 Sep 2007 19:30:35 -0400
In-Reply-To: <Pine.LNX.4.58.0709251601240.14583@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 25 Sep 2007 16:02:45 -0400 (EDT) Steven Rostedt
<rostedt@goodmis.org> wrote:


> > This would of course require that synchronize_all_irqs() be in the
> > RCU code rather than the irq code so that it could access the static
> > wakeme_after_rcu() definition and the rcu_synchronize structure.
> >
> > Thoughts?
> >
> 
> I do like this better. Anyone else care to comment?
> 

I'm still wondering why the IRQ users cannot user proper RCU as it
stands:

  rcu_read_lock();
  foo = rcu_dereference(bar);
  if (foo)
    foo();
  rcu_read_unlock();

vs

  rcu_assign(foo, NULL);
  synchronize_rcu();

and the like.

The implicit rcu_read_lock() as placed in handle_IRQ_event() seems
misplaced.
