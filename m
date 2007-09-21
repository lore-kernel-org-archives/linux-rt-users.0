From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH RFC -rt] synchronize_all_irqs implementation
Date: Thu, 20 Sep 2007 22:46:56 -0700
Message-ID: <20070921054656.GA11708@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: mingo@elte.hu, tglx@linutronix.de, dvhltc@us.ibm.com,
	tytso@us.ibm.com, a.p.zijlstra@chello.nl,
	dmitry.torokhov@gmail.com, akpm@linux-foundation.org,
	nickpiggin@yahoo.com.au
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e2.ny.us.ibm.com ([32.97.182.142]:44578 "EHLO e2.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750837AbXIUFq7 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 21 Sep 2007 01:46:59 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l8L5kw6H027955
	for <linux-rt-users@vger.kernel.org>; Fri, 21 Sep 2007 01:46:58 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id l8L5kwu9692834
	for <linux-rt-users@vger.kernel.org>; Fri, 21 Sep 2007 01:46:58 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l8L5kvMw021986
	for <linux-rt-users@vger.kernel.org>; Fri, 21 Sep 2007 01:46:58 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello!

This patch adds a sychronize_all_irqs(), which waits for all outstanding
interrupt handlers, both threaded and IRQF_NODELAY, to complete.  This
functionality is provided in non-rt kernels by synchronize_sched(), but
this approach fails in face of the threaded interrupt handlers present
in -rt.  The trick sychronize_all_irqs() uses is to recognize that it
has no way of waiting for pending interrupts that have not yet made it
to the CPU, and that the existing synchronize_irq() will in fact fail
to wait for delivered interrupts that have not yet managed to set the
IRQ_INPROGRESS status flag.

This patch takes this thought one step farther, and guarantees only to
wait for interrupts that have already started executing in their handler.

One particular concern among many: should the rcu_read_lock() and
rcu_read_unlock() be pushed down closer to the interrupt handlers?
The do-while loop in thread_edge_irq() is a case in point.  Can this
do-while execute indefinitely in real systems?

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

 include/linux/hardirq.h |    4 +++-
 kernel/irq/manage.c     |   27 +++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 1 deletion(-)

diff -urpNa -X dontdiff linux-2.6.23-rc4-rt1/include/linux/hardirq.h linux-2.6.23-rc4-rt1-sairq/include/linux/hardirq.h
--- linux-2.6.23-rc4-rt1/include/linux/hardirq.h	2007-09-20 17:34:52.000000000 -0700
+++ linux-2.6.23-rc4-rt1-sairq/include/linux/hardirq.h	2007-09-20 18:35:53.000000000 -0700
@@ -105,8 +105,10 @@
 
 #ifdef CONFIG_SMP
 extern void synchronize_irq(unsigned int irq);
+extern void synchronize_all_irqs(void);
 #else
-# define synchronize_irq(irq)	barrier()
+# define synchronize_irq(irq)		barrier()
+# define synchronize_all_irqs(irq)	barrier()
 #endif
 
 struct task_struct;
diff -urpNa -X dontdiff linux-2.6.23-rc4-rt1/kernel/irq/manage.c linux-2.6.23-rc4-rt1-sairq/kernel/irq/manage.c
--- linux-2.6.23-rc4-rt1/kernel/irq/manage.c	2007-09-20 17:34:51.000000000 -0700
+++ linux-2.6.23-rc4-rt1-sairq/kernel/irq/manage.c	2007-09-20 21:51:53.000000000 -0700
@@ -45,6 +45,30 @@ void synchronize_irq(unsigned int irq)
 EXPORT_SYMBOL(synchronize_irq);
 
 /**
+ *	synchronize_all_irqs - wait for all pending IRQ handlers (on other CPUs)
+ *
+ *	This function waits for any pending IRQ handlers for this interrupt
+ *	to complete before returning. If you use this function while
+ *	holding a resource the IRQ handler may need you will deadlock.
+ *	If you use this function from an IRQ handler, you will immediately
+ *	self-deadlock.
+ *
+ *	Note that this function waits for -handlers-, not for pending
+ *	interrupts, and most especially not for pending interrupts that
+ *	have not yet been delivered to the CPU.  So if an interrupt
+ *	handler was just about to start executing when this function was
+ *	called, and if there are no other interrupt handlers executing,
+ *	this function is within its rights to return immediately.
+ */
+void synchronize_all_irqs(void)
+{
+	if (hardirq_preemption)
+		synchronize_rcu();	/* wait for threaded irq handlers. */
+	synchronize_sched();		/* wait for hardware irq handlers. */
+}
+EXPORT_SYMBOL_GPL(synchronize_all_irqs);
+
+/**
  *	irq_can_set_affinity - Check if the affinity of a given irq can be set
  *	@irq:		Interrupt to check
  *
@@ -750,6 +774,7 @@ static void do_hardirq(struct irq_desc *
 	if (!(desc->status & IRQ_INPROGRESS))
 		goto out;
 
+	rcu_read_lock();
 	if (desc->handle_irq == handle_simple_irq)
 		thread_simple_irq(desc);
 	else if (desc->handle_irq == handle_level_irq)
@@ -760,6 +785,7 @@ static void do_hardirq(struct irq_desc *
 		thread_edge_irq(desc);
 	else
 		thread_do_irq(desc);
+	rcu_read_unlock();
  out:
 	spin_unlock_irqrestore(&desc->lock, flags);
 
@@ -886,3 +912,4 @@ void __init early_init_hardirqs(void)
 	for (i = 0; i < NR_IRQS; i++)
 		init_waitqueue_head(&irq_desc[i].wait_for_handler);
 }
+
