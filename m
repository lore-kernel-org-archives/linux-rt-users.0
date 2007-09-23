From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: Question on -rt synchronize_irq()
Date: Sun, 23 Sep 2007 10:46:30 -0700
Message-ID: <20070923174630.GA6376@linux.vnet.ibm.com>
References: <20070921011222.GA12394@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: mingo@elte.hu, tglx@linutronix.de, dvhltc@us.ibm.com,
	tytso@us.ibm.com
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e6.ny.us.ibm.com ([32.97.182.146]:49796 "EHLO e6.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753619AbXIWRqi (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 23 Sep 2007 13:46:38 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l8NHm27f005874
	for <linux-rt-users@vger.kernel.org>; Sun, 23 Sep 2007 13:48:02 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id l8NHkXDg545636
	for <linux-rt-users@vger.kernel.org>; Sun, 23 Sep 2007 13:46:33 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l8NHkXNI031012
	for <linux-rt-users@vger.kernel.org>; Sun, 23 Sep 2007 13:46:33 -0400
Content-Disposition: inline
In-Reply-To: <20070921011222.GA12394@linux.vnet.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, Sep 20, 2007 at 06:12:22PM -0700, Paul E. McKenney wrote:
> Hello!
> 
> Color me blind, but I don't see how the following race is avoided:
> 
> CPU 0:	A hardware interrupt is received for a threaded irq, which
> 	eventually results in do_hardirq() being invoked and the
> 	descriptor lock being acquired.  Because the IRQ_INPROGRESS
> 	status bit is set, execution continues.  Once the handler
> 	returns, having already cleared the IRQ_INPROGRESS status bit,
> 	the descriptor lock is released.
> 
> CPU 1:	A second hardware interrupt is received for the same threaded
> 	irq, which also wends its way to do_hardirq() with the
> 	IRQ_INPROGRESS status bit set.  It enters the handler (having
> 	released the descriptor lock) and accesses some data structure
> 	that CPU 2 now wants to get rid of.
> 
> CPU 2:	A synchronize_irq() is executed, again for this same irq.
> 	Because the descriptor status does not have the IRQ_NODELAY
> 	bit set, and because the IRQ_INPROGRESS status bit is set,
> 	this task blocks.
> 
> CPU 0:	Execution continues near the end of do_hardirq(), which notices
> 	that the descriptor wait_for_handler queue is non-empty,
> 	and therefore wakes up CPU 2's task.
> 
> CPU 2:	The task starts running, and proceeds to clean up the data
> 	structures that CPU 1 is still using.

And the above was where I was in fact missing something.  When CPU 2
awakens, it will see that desc->status has the IRQ_INPROGRESS bit set,
and will therefore go back to sleep.  It will be awakened again when the
second interrupt finishes.

Please accept my apologies for the false alarm!!!

So the only shortcoming I am aware of for synchronize_irq() in -rt is
that if there are two concurrent synchronize_irq() calls for the same
IRQ that happen during the last interrupt ever for this IRQ, then the
second of the two will sleep forever.  A similar effect could cause
a precisely timed sequence of interrupts to indefinitely delay a given
synchronize_irq().  I think, anyway.  (If this is the case, then adding
a generation number to the irq_desc structure would be one possible
way of fixing this.)

							Thanx, Paul

> CPU 1:	This second handler is suddenly and fatally disappointed by
> 	the disappearance of its data structures.
> 
> 
> So what am I missing here?
> 
> 							Thanx, Paul
