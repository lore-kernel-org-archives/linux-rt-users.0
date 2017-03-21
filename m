From: Julia Cartwright <julia@ni.com>
Subject: [PATCH v2 6/9] mfd: tc6393xb: make use of raw_spinlock variants
Date: Tue, 21 Mar 2017 17:43:06 -0500
Message-ID: <12d518840dde957b61348a17dd07f92f7cf5b73d.1490135047.git.julia@ni.com>
References: <cover.1490135047.git.julia@ni.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-kernel@vger.kernel.org>, <linux-rt-users@vger.kernel.org>
To: Lee Jones <lee.jones@linaro.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:52490 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1756845AbdCUWyo (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 21 Mar 2017 18:54:44 -0400
In-Reply-To: <cover.1490135047.git.julia@ni.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

The tc6393xb mfd driver currently implements an irq_chip for handling
interrupts; due to how irq_chip handling is done, it's necessary for the
irq_chip methods to be invoked from hardirq context, even on a a
real-time kernel.  Because the spinlock_t type becomes a "sleeping"
spinlock w/ RT kernels, it is not suitable to be used with irq_chips.

A quick audit of the operations under the lock reveal that they do only
minimal, bounded work, and are therefore safe to do under a raw spinlock.

Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Julia Cartwright <julia@ni.com>
---
v1 -> v2:
  - No functional change.  Added Lee's ack.

 drivers/mfd/tc6393xb.c | 52 +++++++++++++++++++++++++-------------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/mfd/tc6393xb.c b/drivers/mfd/tc6393xb.c
index d42d322ac7ca..d16e71bd9482 100644
--- a/drivers/mfd/tc6393xb.c
+++ b/drivers/mfd/tc6393xb.c
@@ -95,7 +95,7 @@ struct tc6393xb {
 
 	struct clk		*clk; /* 3,6 Mhz */
 
-	spinlock_t		lock; /* protects RMW cycles */
+	raw_spinlock_t		lock; /* protects RMW cycles */
 
 	struct {
 		u8		fer;
@@ -126,13 +126,13 @@ static int tc6393xb_nand_enable(struct platform_device *nand)
 	struct tc6393xb *tc6393xb = platform_get_drvdata(dev);
 	unsigned long flags;
 
-	spin_lock_irqsave(&tc6393xb->lock, flags);
+	raw_spin_lock_irqsave(&tc6393xb->lock, flags);
 
 	/* SMD buffer on */
 	dev_dbg(&dev->dev, "SMD buffer on\n");
 	tmio_iowrite8(0xff, tc6393xb->scr + SCR_GPI_BCR(1));
 
-	spin_unlock_irqrestore(&tc6393xb->lock, flags);
+	raw_spin_unlock_irqrestore(&tc6393xb->lock, flags);
 
 	return 0;
 }
@@ -226,7 +226,7 @@ static int tc6393xb_ohci_enable(struct platform_device *dev)
 	u16 ccr;
 	u8 fer;
 
-	spin_lock_irqsave(&tc6393xb->lock, flags);
+	raw_spin_lock_irqsave(&tc6393xb->lock, flags);
 
 	ccr = tmio_ioread16(tc6393xb->scr + SCR_CCR);
 	ccr |= SCR_CCR_USBCK;
@@ -236,7 +236,7 @@ static int tc6393xb_ohci_enable(struct platform_device *dev)
 	fer |= SCR_FER_USBEN;
 	tmio_iowrite8(fer, tc6393xb->scr + SCR_FER);
 
-	spin_unlock_irqrestore(&tc6393xb->lock, flags);
+	raw_spin_unlock_irqrestore(&tc6393xb->lock, flags);
 
 	return 0;
 }
@@ -248,7 +248,7 @@ static int tc6393xb_ohci_disable(struct platform_device *dev)
 	u16 ccr;
 	u8 fer;
 
-	spin_lock_irqsave(&tc6393xb->lock, flags);
+	raw_spin_lock_irqsave(&tc6393xb->lock, flags);
 
 	fer = tmio_ioread8(tc6393xb->scr + SCR_FER);
 	fer &= ~SCR_FER_USBEN;
@@ -258,7 +258,7 @@ static int tc6393xb_ohci_disable(struct platform_device *dev)
 	ccr &= ~SCR_CCR_USBCK;
 	tmio_iowrite16(ccr, tc6393xb->scr + SCR_CCR);
 
-	spin_unlock_irqrestore(&tc6393xb->lock, flags);
+	raw_spin_unlock_irqrestore(&tc6393xb->lock, flags);
 
 	return 0;
 }
@@ -280,14 +280,14 @@ static int tc6393xb_fb_enable(struct platform_device *dev)
 	unsigned long flags;
 	u16 ccr;
 
-	spin_lock_irqsave(&tc6393xb->lock, flags);
+	raw_spin_lock_irqsave(&tc6393xb->lock, flags);
 
 	ccr = tmio_ioread16(tc6393xb->scr + SCR_CCR);
 	ccr &= ~SCR_CCR_MCLK_MASK;
 	ccr |= SCR_CCR_MCLK_48;
 	tmio_iowrite16(ccr, tc6393xb->scr + SCR_CCR);
 
-	spin_unlock_irqrestore(&tc6393xb->lock, flags);
+	raw_spin_unlock_irqrestore(&tc6393xb->lock, flags);
 
 	return 0;
 }
@@ -298,14 +298,14 @@ static int tc6393xb_fb_disable(struct platform_device *dev)
 	unsigned long flags;
 	u16 ccr;
 
-	spin_lock_irqsave(&tc6393xb->lock, flags);
+	raw_spin_lock_irqsave(&tc6393xb->lock, flags);
 
 	ccr = tmio_ioread16(tc6393xb->scr + SCR_CCR);
 	ccr &= ~SCR_CCR_MCLK_MASK;
 	ccr |= SCR_CCR_MCLK_OFF;
 	tmio_iowrite16(ccr, tc6393xb->scr + SCR_CCR);
 
-	spin_unlock_irqrestore(&tc6393xb->lock, flags);
+	raw_spin_unlock_irqrestore(&tc6393xb->lock, flags);
 
 	return 0;
 }
@@ -317,7 +317,7 @@ int tc6393xb_lcd_set_power(struct platform_device *fb, bool on)
 	u8 fer;
 	unsigned long flags;
 
-	spin_lock_irqsave(&tc6393xb->lock, flags);
+	raw_spin_lock_irqsave(&tc6393xb->lock, flags);
 
 	fer = ioread8(tc6393xb->scr + SCR_FER);
 	if (on)
@@ -326,7 +326,7 @@ int tc6393xb_lcd_set_power(struct platform_device *fb, bool on)
 		fer &= ~SCR_FER_SLCDEN;
 	iowrite8(fer, tc6393xb->scr + SCR_FER);
 
-	spin_unlock_irqrestore(&tc6393xb->lock, flags);
+	raw_spin_unlock_irqrestore(&tc6393xb->lock, flags);
 
 	return 0;
 }
@@ -338,12 +338,12 @@ int tc6393xb_lcd_mode(struct platform_device *fb,
 	struct tc6393xb *tc6393xb = platform_get_drvdata(dev);
 	unsigned long flags;
 
-	spin_lock_irqsave(&tc6393xb->lock, flags);
+	raw_spin_lock_irqsave(&tc6393xb->lock, flags);
 
 	iowrite16(mode->pixclock, tc6393xb->scr + SCR_PLL1CR + 0);
 	iowrite16(mode->pixclock >> 16, tc6393xb->scr + SCR_PLL1CR + 2);
 
-	spin_unlock_irqrestore(&tc6393xb->lock, flags);
+	raw_spin_unlock_irqrestore(&tc6393xb->lock, flags);
 
 	return 0;
 }
@@ -462,11 +462,11 @@ static void tc6393xb_gpio_set(struct gpio_chip *chip,
 	struct tc6393xb *tc6393xb = gpiochip_get_data(chip);
 	unsigned long flags;
 
-	spin_lock_irqsave(&tc6393xb->lock, flags);
+	raw_spin_lock_irqsave(&tc6393xb->lock, flags);
 
 	__tc6393xb_gpio_set(chip, offset, value);
 
-	spin_unlock_irqrestore(&tc6393xb->lock, flags);
+	raw_spin_unlock_irqrestore(&tc6393xb->lock, flags);
 }
 
 static int tc6393xb_gpio_direction_input(struct gpio_chip *chip,
@@ -476,13 +476,13 @@ static int tc6393xb_gpio_direction_input(struct gpio_chip *chip,
 	unsigned long flags;
 	u8 doecr;
 
-	spin_lock_irqsave(&tc6393xb->lock, flags);
+	raw_spin_lock_irqsave(&tc6393xb->lock, flags);
 
 	doecr = tmio_ioread8(tc6393xb->scr + SCR_GPO_DOECR(offset / 8));
 	doecr &= ~TC_GPIO_BIT(offset);
 	tmio_iowrite8(doecr, tc6393xb->scr + SCR_GPO_DOECR(offset / 8));
 
-	spin_unlock_irqrestore(&tc6393xb->lock, flags);
+	raw_spin_unlock_irqrestore(&tc6393xb->lock, flags);
 
 	return 0;
 }
@@ -494,7 +494,7 @@ static int tc6393xb_gpio_direction_output(struct gpio_chip *chip,
 	unsigned long flags;
 	u8 doecr;
 
-	spin_lock_irqsave(&tc6393xb->lock, flags);
+	raw_spin_lock_irqsave(&tc6393xb->lock, flags);
 
 	__tc6393xb_gpio_set(chip, offset, value);
 
@@ -502,7 +502,7 @@ static int tc6393xb_gpio_direction_output(struct gpio_chip *chip,
 	doecr |= TC_GPIO_BIT(offset);
 	tmio_iowrite8(doecr, tc6393xb->scr + SCR_GPO_DOECR(offset / 8));
 
-	spin_unlock_irqrestore(&tc6393xb->lock, flags);
+	raw_spin_unlock_irqrestore(&tc6393xb->lock, flags);
 
 	return 0;
 }
@@ -548,11 +548,11 @@ static void tc6393xb_irq_mask(struct irq_data *data)
 	unsigned long flags;
 	u8 imr;
 
-	spin_lock_irqsave(&tc6393xb->lock, flags);
+	raw_spin_lock_irqsave(&tc6393xb->lock, flags);
 	imr = tmio_ioread8(tc6393xb->scr + SCR_IMR);
 	imr |= 1 << (data->irq - tc6393xb->irq_base);
 	tmio_iowrite8(imr, tc6393xb->scr + SCR_IMR);
-	spin_unlock_irqrestore(&tc6393xb->lock, flags);
+	raw_spin_unlock_irqrestore(&tc6393xb->lock, flags);
 }
 
 static void tc6393xb_irq_unmask(struct irq_data *data)
@@ -561,11 +561,11 @@ static void tc6393xb_irq_unmask(struct irq_data *data)
 	unsigned long flags;
 	u8 imr;
 
-	spin_lock_irqsave(&tc6393xb->lock, flags);
+	raw_spin_lock_irqsave(&tc6393xb->lock, flags);
 	imr = tmio_ioread8(tc6393xb->scr + SCR_IMR);
 	imr &= ~(1 << (data->irq - tc6393xb->irq_base));
 	tmio_iowrite8(imr, tc6393xb->scr + SCR_IMR);
-	spin_unlock_irqrestore(&tc6393xb->lock, flags);
+	raw_spin_unlock_irqrestore(&tc6393xb->lock, flags);
 }
 
 static struct irq_chip tc6393xb_chip = {
@@ -628,7 +628,7 @@ static int tc6393xb_probe(struct platform_device *dev)
 		goto err_kzalloc;
 	}
 
-	spin_lock_init(&tc6393xb->lock);
+	raw_spin_lock_init(&tc6393xb->lock);
 
 	platform_set_drvdata(dev, tc6393xb);
 
-- 
2.12.0

