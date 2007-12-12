From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT] add pending in fasteoi for IOAPIC hack
Date: Wed, 12 Dec 2007 15:41:00 -0500 (EST)
Message-ID: <Pine.LNX.4.58.0712121539400.22581@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:64676 "EHLO
	ms-smtp-04.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751597AbXLLUl0 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 12 Dec 2007 15:41:26 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


The IOAPIC hack that does a level=>edge to mask does not disable
interrupts. So we can receive interrupts when masked, and this means
that we can miss interrupts that arrive when the thread is handling
them.

This patch adds the "IRQ_PENDING" logic of the edge irqs to be
able to catch interrupts coming in when supposably "masked".

Signed-off-by: Steven Rostedt <srostedt@redhat.com>

Index: linux-2.6.21-rt-hack/kernel/irq/chip.c
===================================================================
--- linux-2.6.21-rt-hack.orig/kernel/irq/chip.c
+++ linux-2.6.21-rt-hack/kernel/irq/chip.c
@@ -398,8 +398,10 @@ handle_fasteoi_irq(unsigned int irq, str

 	spin_lock(&desc->lock);

-	if (unlikely(desc->status & IRQ_INPROGRESS))
+	if (unlikely(desc->status & IRQ_INPROGRESS)) {
+		desc->status |= IRQ_PENDING;
 		goto out;
+	}

 	desc->status &= ~(IRQ_REPLAY | IRQ_WAITING);
 	kstat_cpu(cpu).irqs[irq]++;
