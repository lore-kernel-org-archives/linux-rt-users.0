From: Julia Cartwright <julia@ni.com>
Subject: [PATCH v2 5/9] mfd: t7l66xb: make use of raw_spinlock variants
Date: Tue, 21 Mar 2017 17:43:05 -0500
Message-ID: <1017371a656047dabe20e82a57a592b3925b5dd7.1490135047.git.julia@ni.com>
References: <cover.1490135047.git.julia@ni.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-kernel@vger.kernel.org>, <linux-rt-users@vger.kernel.org>
To: Lee Jones <lee.jones@linaro.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:58129 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1757572AbdCUXcB (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 21 Mar 2017 19:32:01 -0400
In-Reply-To: <cover.1490135047.git.julia@ni.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

The t7l66xb mfd driver currently implements an irq_chip for handling
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

 drivers/mfd/t7l66xb.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/mfd/t7l66xb.c b/drivers/mfd/t7l66xb.c
index 94bd89cb1f06..22c811396edc 100644
--- a/drivers/mfd/t7l66xb.c
+++ b/drivers/mfd/t7l66xb.c
@@ -69,7 +69,7 @@ static const struct resource t7l66xb_mmc_resources[] = {
 struct t7l66xb {
 	void __iomem		*scr;
 	/* Lock to protect registers requiring read/modify/write ops. */
-	spinlock_t		lock;
+	raw_spinlock_t		lock;
 
 	struct resource		rscr;
 	struct clk		*clk48m;
@@ -89,13 +89,13 @@ static int t7l66xb_mmc_enable(struct platform_device *mmc)
 
 	clk_prepare_enable(t7l66xb->clk32k);
 
-	spin_lock_irqsave(&t7l66xb->lock, flags);
+	raw_spin_lock_irqsave(&t7l66xb->lock, flags);
 
 	dev_ctl = tmio_ioread8(t7l66xb->scr + SCR_DEV_CTL);
 	dev_ctl |= SCR_DEV_CTL_MMC;
 	tmio_iowrite8(dev_ctl, t7l66xb->scr + SCR_DEV_CTL);
 
-	spin_unlock_irqrestore(&t7l66xb->lock, flags);
+	raw_spin_unlock_irqrestore(&t7l66xb->lock, flags);
 
 	tmio_core_mmc_enable(t7l66xb->scr + 0x200, 0,
 		t7l66xb_mmc_resources[0].start & 0xfffe);
@@ -110,13 +110,13 @@ static int t7l66xb_mmc_disable(struct platform_device *mmc)
 	unsigned long flags;
 	u8 dev_ctl;
 
-	spin_lock_irqsave(&t7l66xb->lock, flags);
+	raw_spin_lock_irqsave(&t7l66xb->lock, flags);
 
 	dev_ctl = tmio_ioread8(t7l66xb->scr + SCR_DEV_CTL);
 	dev_ctl &= ~SCR_DEV_CTL_MMC;
 	tmio_iowrite8(dev_ctl, t7l66xb->scr + SCR_DEV_CTL);
 
-	spin_unlock_irqrestore(&t7l66xb->lock, flags);
+	raw_spin_unlock_irqrestore(&t7l66xb->lock, flags);
 
 	clk_disable_unprepare(t7l66xb->clk32k);
 
@@ -206,11 +206,11 @@ static void t7l66xb_irq_mask(struct irq_data *data)
 	unsigned long			flags;
 	u8 imr;
 
-	spin_lock_irqsave(&t7l66xb->lock, flags);
+	raw_spin_lock_irqsave(&t7l66xb->lock, flags);
 	imr = tmio_ioread8(t7l66xb->scr + SCR_IMR);
 	imr |= 1 << (data->irq - t7l66xb->irq_base);
 	tmio_iowrite8(imr, t7l66xb->scr + SCR_IMR);
-	spin_unlock_irqrestore(&t7l66xb->lock, flags);
+	raw_spin_unlock_irqrestore(&t7l66xb->lock, flags);
 }
 
 static void t7l66xb_irq_unmask(struct irq_data *data)
@@ -219,11 +219,11 @@ static void t7l66xb_irq_unmask(struct irq_data *data)
 	unsigned long flags;
 	u8 imr;
 
-	spin_lock_irqsave(&t7l66xb->lock, flags);
+	raw_spin_lock_irqsave(&t7l66xb->lock, flags);
 	imr = tmio_ioread8(t7l66xb->scr + SCR_IMR);
 	imr &= ~(1 << (data->irq - t7l66xb->irq_base));
 	tmio_iowrite8(imr, t7l66xb->scr + SCR_IMR);
-	spin_unlock_irqrestore(&t7l66xb->lock, flags);
+	raw_spin_unlock_irqrestore(&t7l66xb->lock, flags);
 }
 
 static struct irq_chip t7l66xb_chip = {
@@ -321,7 +321,7 @@ static int t7l66xb_probe(struct platform_device *dev)
 	if (!t7l66xb)
 		return -ENOMEM;
 
-	spin_lock_init(&t7l66xb->lock);
+	raw_spin_lock_init(&t7l66xb->lock);
 
 	platform_set_drvdata(dev, t7l66xb);
 
-- 
2.12.0

