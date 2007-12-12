From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH] handle IRQ_PENDING for simple irq handler
Date: Wed, 12 Dec 2007 14:50:02 -0500 (EST)
Message-ID: <Pine.LNX.4.58.0712121446550.21926@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:39208 "EHLO
	ms-smtp-02.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761013AbXLLTue (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 12 Dec 2007 14:50:34 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


With the IO-APIC pcix hack (level=>edge masking), we can receive
interrupts while masked. But these interrupts might be missed.

Also, normal "simple" interrupts might be missed too on leaving of
thread handler.

Signed-off-by: Steven Rostedt <srostedt@redhat.com>

Index: linux-2.6.21-rt-hack/kernel/irq/manage.c
===================================================================
--- linux-2.6.21-rt-hack.orig/kernel/irq/manage.c
+++ linux-2.6.21-rt-hack/kernel/irq/manage.c
@@ -628,14 +628,17 @@ static void thread_simple_irq(irq_desc_t
 	unsigned int irq = desc - irq_desc;
 	irqreturn_t action_ret;

-	if (action && !desc->depth) {
+	do {
+		if (!action || desc->depth)
+			break;
+		desc->status &= ~IRQ_PENDING;
 		spin_unlock(&desc->lock);
 		action_ret = handle_IRQ_event(irq, action);
 		cond_resched_hardirq_context();
 		spin_lock_irq(&desc->lock);
 		if (!noirqdebug)
 			note_interrupt(irq, desc, action_ret);
-	}
+	} while (desc->status & IRQ_PENDING);
 	desc->status &= ~IRQ_INPROGRESS;
 }
