From: Kevin Hilman <khilman@mvista.com>
Subject: Generic IRQs: proper edge/level via irq_chip->set_type hook
Date: Tue, 04 Dec 2007 15:18:59 -0800
Message-ID: <87eje259r0.fsf@vence.hilman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-omap@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
	"Remy Bohmer" <linux@bohmer.net>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:61781 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751108AbXLDXSb (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 4 Dec 2007 18:18:31 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I'm trying to cleanup/remove the use of handle_simple_irq in the OMAP
GPIO IRQ handling.

Currently, the OMAP GPIO demux handler uses handle_simple_irq for all
the GPIOs whether they are edge or level.  The result is duplicated
logic with handle_[edge|level]_irq as well as things not working
correctly for threaded interrupts with the -rt patch.

Currently, upon init, the handlers for all GPIO IRQs are initialized
to handle_simple_irq.  This is fine, since before the interrupts are
registered via request_irq or setup_irq, we don't know if they are
edge or level.

When request_irq or setup_irq are called, the type of interrupt (edge
or level) is known and the 'set_type' hook of the irq_chip is called
to set the triggering accordingly.  It seems to me this is also the
appropriate place to change the handler from handle_simple_irq to
handle_[edge|level]_irq via a call to set_irq_handler().

The problem is that when the 'set_type' hook is called the
irq_desc->lock is held by setup_irq(), so a call to set_irq_handler()
dies with a recursive lock.

The hack below allows me to get the above idea working, but I'm
looking for better suggestions on how to rework the locking here so
that the handler might be changed from within the irq_chip's set_type
handler.

Any ideas?

Kevin


--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -369,10 +369,12 @@ int setup_irq(unsigned int irq, struct irqaction *new)
 
 		/* Setup the type (level, edge polarity) if configured: */
 		if (new->flags & IRQF_TRIGGER_MASK) {
-			if (desc->chip && desc->chip->set_type)
+			if (desc->chip && desc->chip->set_type) {
+				spin_unlock(&desc->lock);
 				desc->chip->set_type(irq,
 						new->flags & IRQF_TRIGGER_MASK);
-			else
+				spin_lock(&desc->lock);
+			} else
 				/*
 				 * IRQF_TRIGGER_* but the PIC does not support
 				 * multiple flow-types?
