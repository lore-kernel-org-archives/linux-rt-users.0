From: Kevin Hilman <khilman@mvista.com>
Subject: [PATCH] ARM: OMAP: Clear level-triggered GPIO interrupts in unmask hook
Date: Tue,  4 Dec 2007 22:00:35 -0800
Message-ID: <1196834437-19223-3-git-send-email-khilman@mvista.com>
References: <1196834437-19223-1-git-send-email-khilman@mvista.com>
 <1196834437-19223-2-git-send-email-khilman@mvista.com>
Cc: David Brownell <david-b@pacbell.net>,
	Russell King <linux@arm.linux.org.uk>,
	Remy Bohmer <linux@bohmer.net>, linux-rt-users@vger.kernel.org,
	Kevin Hilman <khilman@mvista.com>
To: linux-omap@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from deeprooted.net ([216.254.16.51]:60181 "EHLO paris.hilman.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751472AbXLEGKV (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 5 Dec 2007 01:10:21 -0500
In-Reply-To: <1196834437-19223-2-git-send-email-khilman@mvista.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

The clearing was moved to the unmask hook because it is known to run
after the interrupt handler has actually run.  Before this patch, if
interrupts were threaded, the clearing/unmasking of level triggered
interrupts could be done before the threaded handler actually ran.

Signed-off-by: Kevin Hilman <khilman@mvista.com>
---
 arch/arm/plat-omap/gpio.c |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index f5a1ee5..09fcd30 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -150,6 +150,7 @@ struct gpio_bank {
 	u32 saved_fallingdetect;
 	u32 saved_risingdetect;
 #endif
+	u32 level_mask;
 	spinlock_t lock;
 };
 
@@ -519,6 +520,10 @@ static inline void set_24xx_gpio_triggering(struct gpio_bank *bank, int gpio, in
 		else
 			bank->enabled_non_wakeup_gpios &= ~gpio_bit;
 	}
+
+	bank->level_mask = 
+		__raw_readl(bank->base + OMAP24XX_GPIO_LEVELDETECT0) |
+		__raw_readl(bank->base + OMAP24XX_GPIO_LEVELDETECT1);
 	/* FIXME: Possibly do 'set_irq_handler(j, handle_level_irq)' if only level
 	 * triggering requested. */
 }
@@ -1033,12 +1038,7 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 			isr &= 0x0000ffff;
 
 		if (cpu_class_is_omap2()) {
-			level_mask =
-				__raw_readl(bank->base +
-					OMAP24XX_GPIO_LEVELDETECT0) |
-				__raw_readl(bank->base +
-					OMAP24XX_GPIO_LEVELDETECT1);
-			level_mask &= enabled;
+			level_mask = bank->level_mask & enabled;
 		}
 
 		/* clear edge sensitive interrupts before handler(s) are
@@ -1100,14 +1100,6 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 				retrigger |= irq_mask;
 			}
 		}
-
-		if (cpu_class_is_omap2()) {
-			/* clear level sensitive interrupts after handler(s) */
-			_enable_gpio_irqbank(bank, isr_saved & level_mask, 0);
-			_clear_gpio_irqbank(bank, isr_saved & level_mask);
-			_enable_gpio_irqbank(bank, isr_saved & level_mask, 1);
-		}
-
 	}
 	/* if bank has any level sensitive GPIO pin interrupt
 	configured, we must unmask the bank interrupt only after
@@ -1146,7 +1138,15 @@ static void gpio_unmask_irq(unsigned int irq)
 {
 	unsigned int gpio = irq - IH_GPIO_BASE;
 	struct gpio_bank *bank = get_irq_chip_data(irq);
+	unsigned int irq_mask = 1 << get_gpio_index(gpio);
 
+	/* For level-triggered GPIOs, the clearing must be done after
+	 * the HW source is cleared, thus after the handler has run */
+	if (bank->level_mask & irq_mask) {
+		_set_gpio_irqenable(bank, gpio, 0);
+		_clear_gpio_irqstatus(bank, gpio);
+	}
+		
 	_set_gpio_irqenable(bank, gpio, 1);
 }
 
-- 
1.5.3.5
