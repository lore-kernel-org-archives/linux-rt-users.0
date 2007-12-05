From: Kevin Hilman <khilman@mvista.com>
Subject: [PATCH] ARM: OMAP: Fix GPIO IRQ unmask
Date: Tue,  4 Dec 2007 22:00:34 -0800
Message-ID: <1196834437-19223-2-git-send-email-khilman@mvista.com>
References: <1196834437-19223-1-git-send-email-khilman@mvista.com>
Cc: David Brownell <david-b@pacbell.net>,
	Russell King <linux@arm.linux.org.uk>,
	Remy Bohmer <linux@bohmer.net>, linux-rt-users@vger.kernel.org,
	Kevin Hilman <khilman@mvista.com>
To: linux-omap@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from deeprooted.net ([216.254.16.51]:60182 "EHLO paris.hilman.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751464AbXLEGKU (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 5 Dec 2007 01:10:20 -0500
In-Reply-To: <1196834437-19223-1-git-send-email-khilman@mvista.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

GPIO IRQ unmask doesn't actually do anything useful.  The problem is
hidden by a separate explicit mass unmask at the end of the chained
bank handler.

Signed-off-by: Kevin Hilman <khilman@mvista.com>
---
 arch/arm/plat-omap/gpio.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 1640a37..f5a1ee5 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -1145,10 +1145,9 @@ static void gpio_mask_irq(unsigned int irq)
 static void gpio_unmask_irq(unsigned int irq)
 {
 	unsigned int gpio = irq - IH_GPIO_BASE;
-	unsigned int gpio_idx = get_gpio_index(gpio);
 	struct gpio_bank *bank = get_irq_chip_data(irq);
 
-	_set_gpio_irqenable(bank, gpio_idx, 1);
+	_set_gpio_irqenable(bank, gpio, 1);
 }
 
 static struct irq_chip gpio_irq_chip = {
-- 
1.5.3.5
