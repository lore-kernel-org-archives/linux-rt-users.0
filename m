From: Sebastien Dugue <sebastien.dugue@bull.net>
Subject: [PATCH][RT]: handle_IRQ_event() - fix thinko
Date: Tue, 23 Sep 2008 10:10:52 +0200
Message-ID: <20080923101052.16574a0f@bull.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jean Pierre Dion <jean-pierre.dion@bull.net>,
	Gilles Carry <Gilles.Carry@ext.bull.net>
To: Linux-rt <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:49675 "EHLO
	ecfrec.frec.bull.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751103AbYIWILG (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 23 Sep 2008 04:11:06 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


  handle_IRQ_event() reenables interrupts for threaded IRQ handlers,
provided said handler does not need to run with IRQF_DISABLED.

  Therefore, unless I'm missing something, in the following:

if (!hardirq_count() || !(action->flags & IRQF_DISABLED))
	local_irq_enable();

  the logical OR should be a logical AND:

if (!hardirq_count() && !(action->flags & IRQF_DISABLED))
	local_irq_enable();

  Or maybe I've not yet reached my daily cafeine dose. (Damned addiction)

Signed-off-by: Sebastien Dugue <sebastien.dugue@bull.net>
---
 kernel/irq/handle.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/kernel/irq/handle.c b/kernel/irq/handle.c
index 9ea9f73..f1579b9 100644
--- a/kernel/irq/handle.c
+++ b/kernel/irq/handle.c
@@ -144,7 +144,7 @@ irqreturn_t handle_IRQ_event(unsigned int irq, struct irqaction *action)
 	 * Unconditionally enable interrupts for threaded
 	 * IRQ handlers:
 	 */
-	if (!hardirq_count() || !(action->flags & IRQF_DISABLED))
+	if (!hardirq_count() && !(action->flags & IRQF_DISABLED))
 		local_irq_enable();
 
 	do {
-- 
1.6.0.1.308.gede4c

