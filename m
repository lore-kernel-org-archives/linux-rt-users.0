From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Question on -rt synchronize_irq()
Date: Thu, 20 Sep 2007 18:12:22 -0700
Message-ID: <20070921011222.GA12394@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: mingo@elte.hu, tglx@linutronix.de, dvhltc@us.ibm.com,
	tytso@us.ibm.com
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e6.ny.us.ibm.com ([32.97.182.146]:46653 "EHLO e6.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750699AbXIUBMZ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 20 Sep 2007 21:12:25 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l8L1Dqff007818
	for <linux-rt-users@vger.kernel.org>; Thu, 20 Sep 2007 21:13:52 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id l8L1COJ6567000
	for <linux-rt-users@vger.kernel.org>; Thu, 20 Sep 2007 21:12:24 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l8L1CNgY018631
	for <linux-rt-users@vger.kernel.org>; Thu, 20 Sep 2007 21:12:24 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello!

Color me blind, but I don't see how the following race is avoided:

CPU 0:	A hardware interrupt is received for a threaded irq, which
	eventually results in do_hardirq() being invoked and the
	descriptor lock being acquired.  Because the IRQ_INPROGRESS
	status bit is set, execution continues.  Once the handler
	returns, having already cleared the IRQ_INPROGRESS status bit,
	the descriptor lock is released.

CPU 1:	A second hardware interrupt is received for the same threaded
	irq, which also wends its way to do_hardirq() with the
	IRQ_INPROGRESS status bit set.  It enters the handler (having
	released the descriptor lock) and accesses some data structure
	that CPU 2 now wants to get rid of.

CPU 2:	A synchronize_irq() is executed, again for this same irq.
	Because the descriptor status does not have the IRQ_NODELAY
	bit set, and because the IRQ_INPROGRESS status bit is set,
	this task blocks.

CPU 0:	Execution continues near the end of do_hardirq(), which notices
	that the descriptor wait_for_handler queue is non-empty,
	and therefore wakes up CPU 2's task.

CPU 2:	The task starts running, and proceeds to clean up the data
	structures that CPU 1 is still using.

CPU 1:	This second handler is suddenly and fatally disappointed by
	the disappearance of its data structures.


So what am I missing here?

							Thanx, Paul
