From: Kevin Hilman <khilman@mvista.com>
Subject: [PATCH] ARM: OMAP: use edge/level handlers from generic IRQ framework
Date: Tue,  4 Dec 2007 22:00:37 -0800
Message-ID: <1196834437-19223-5-git-send-email-khilman@mvista.com>
References: <1196834437-19223-1-git-send-email-khilman@mvista.com>
 <1196834437-19223-2-git-send-email-khilman@mvista.com>
 <1196834437-19223-3-git-send-email-khilman@mvista.com>
 <1196834437-19223-4-git-send-email-khilman@mvista.com>
Cc: David Brownell <david-b@pacbell.net>,
	Russell King <linux@arm.linux.org.uk>,
	Remy Bohmer <linux@bohmer.net>, linux-rt-users@vger.kernel.org,
	Kevin Hilman <khilman@mvista.com>
To: linux-omap@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from deeprooted.net ([216.254.16.51]:60179 "EHLO paris.hilman.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751479AbXLEGKV (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 5 Dec 2007 01:10:21 -0500
In-Reply-To: <1196834437-19223-4-git-send-email-khilman@mvista.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Currently, the GPIO interrupt handling is duplicating some of the work
done by the generic IRQ handlers (handle_edge_irq, handle_level_irq)
such as detecting nesting, handling re-triggers etc.  Remove this
duplication and use generic hooks based on IRQ type.

Using generic IRQ handlers ensures correct behavior when using
threaded interrupts introduced by the -rt patch.

Signed-off-by: Kevin Hilman <khilman@mvista.com>
---
 arch/arm/plat-omap/gpio.c |   40 +++++++---------------------------------
 1 files changed, 7 insertions(+), 33 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 09fcd30..c55ad11 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -524,8 +524,6 @@ static inline void set_24xx_gpio_triggering(struct gpio_bank *bank, int gpio, in
 	bank->level_mask = 
 		__raw_readl(bank->base + OMAP24XX_GPIO_LEVELDETECT0) |
 		__raw_readl(bank->base + OMAP24XX_GPIO_LEVELDETECT1);
-	/* FIXME: Possibly do 'set_irq_handler(j, handle_level_irq)' if only level
-	 * triggering requested. */
 }
 
 void
@@ -672,6 +670,12 @@ static int gpio_irq_type(unsigned irq, unsigned type)
 		irq_desc[irq].status |= type;
 	}
 	spin_unlock(&bank->lock);
+
+	if (type & (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_LEVEL_HIGH))
+		__set_irq_handler_unlocked(irq, handle_level_irq);
+	else if (type & (IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_EDGE_RISING))
+		__set_irq_handler_unlocked(irq, handle_edge_irq);
+			
 	return retval;
 }
 
@@ -1063,42 +1067,12 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 		gpio_irq = bank->virtual_irq_start;
 		for (; isr != 0; isr >>= 1, gpio_irq++) {
 			struct irq_desc *d;
-			int irq_mask;
+
 			if (!(isr & 1))
 				continue;
 			d = irq_desc + gpio_irq;
-			/* Don't run the handler if it's already running
-			 * or was disabled lazely.
-			 */
-			if (unlikely((d->depth ||
-				      (d->status & IRQ_INPROGRESS)))) {
-				irq_mask = 1 <<
-					(gpio_irq - bank->virtual_irq_start);
-				/* The unmasking will be done by
-				 * enable_irq in case it is disabled or
-				 * after returning from the handler if
-				 * it's already running.
-				 */
-				_enable_gpio_irqbank(bank, irq_mask, 0);
-				if (!d->depth) {
-					/* Level triggered interrupts
-					 * won't ever be reentered
-					 */
-					BUG_ON(level_mask & irq_mask);
-					d->status |= IRQ_PENDING;
-				}
-				continue;
-			}
 
 			desc_handle_irq(gpio_irq, d);
-
-			if (unlikely((d->status & IRQ_PENDING) && !d->depth)) {
-				irq_mask = 1 <<
-					(gpio_irq - bank->virtual_irq_start);
-				d->status &= ~IRQ_PENDING;
-				_enable_gpio_irqbank(bank, irq_mask, 1);
-				retrigger |= irq_mask;
-			}
 		}
 	}
 	/* if bank has any level sensitive GPIO pin interrupt
-- 
1.5.3.5
