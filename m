From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 1/8] genirq: Unmask oneshot irqs when thread was not woken
Date: Wed, 08 Feb 2012 20:59:27 -0500
Message-ID: <20120209020159.095037912@goodmis.org>
References: <20120209015926.851312665@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>, stable-rt@vger.kernel.org,
	Lothar Wassmann <lw@karo-electronics.de>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:49691 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756928Ab2BICCB (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 8 Feb 2012 21:02:01 -0500
Content-Disposition: inline; filename=0001-genirq-Unmask-oneshot-irqs-when-thread-was-not-woken.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Thomas Gleixner <tglx@linutronix.de>

When the primary handler of an interrupt which is marked IRQ_ONESHOT
does not wake the thread (e.g. due to a spurious interrupt) then
nothing ever unmasks the interrupt line again. Handle it gracefully.

Cc: stable-rt@vger.kernel.org
Reported-by: Lothar Wassmann <lw@karo-electronics.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/irq/chip.c |   25 +++++++++++++++++++++++--
 1 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index dc5114b..3322a34 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -312,6 +312,24 @@ out_unlock:
 }
 EXPORT_SYMBOL_GPL(handle_simple_irq);
 
+/*
+ * Called unconditionally from handle_level_irq() and only for oneshot
+ * interrupts from handle_fasteoi_irq()
+ */
+static void cond_unmask_irq(struct irq_desc *desc)
+{
+	/*
+	 * We need to unmask in the following cases:
+	 * - Standard level irq (IRQF_ONESHOT is not set)
+	 * - Oneshot irq which did not wake the thread (caused by a
+	 *   spurious interrupt or a primary handler handling it
+	 *   completely).
+	 */
+	if (!irqd_irq_disabled(&desc->irq_data) &&
+	    irqd_irq_masked(&desc->irq_data) && !desc->threads_oneshot)
+		unmask_irq(desc);
+}
+
 /**
  *	handle_level_irq - Level type irq handler
  *	@irq:	the interrupt number
@@ -344,8 +362,8 @@ handle_level_irq(unsigned int irq, struct irq_desc *desc)
 
 	handle_irq_event(desc);
 
-	if (!irqd_irq_disabled(&desc->irq_data) && !(desc->istate & IRQS_ONESHOT))
-		unmask_irq(desc);
+	cond_unmask_irq(desc);
+
 out_unlock:
 	raw_spin_unlock(&desc->lock);
 }
@@ -399,6 +417,9 @@ handle_fasteoi_irq(unsigned int irq, struct irq_desc *desc)
 	preflow_handler(desc);
 	handle_irq_event(desc);
 
+	if (desc->istate & IRQS_ONESHOT)
+		cond_unmask_irq(desc);
+
 out_eoi:
 	desc->irq_data.chip->irq_eoi(&desc->irq_data);
 out_unlock:
-- 
1.7.8.3


