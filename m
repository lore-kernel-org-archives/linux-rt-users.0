From: Julia Cartwright <julia@ni.com>
Subject: [PATCH v2 4/9] mfd: asic3: make use of raw_spinlock variants
Date: Tue, 21 Mar 2017 17:43:04 -0500
Message-ID: <e5dad38e679546595326a0b11c6cd59c51c252f0.1490135047.git.julia@ni.com>
References: <cover.1490135047.git.julia@ni.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-kernel@vger.kernel.org>, <linux-rt-users@vger.kernel.org>
To: Lee Jones <lee.jones@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1490135047.git.julia@ni.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

The asic3 mfd driver currently implements an irq_chip for handling
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

 drivers/mfd/asic3.c | 56 ++++++++++++++++++++++++++---------------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/mfd/asic3.c b/drivers/mfd/asic3.c
index 0413c8159551..cf2e25ab2940 100644
--- a/drivers/mfd/asic3.c
+++ b/drivers/mfd/asic3.c
@@ -78,7 +78,7 @@ struct asic3 {
 	unsigned int bus_shift;
 	unsigned int irq_nr;
 	unsigned int irq_base;
-	spinlock_t lock;
+	raw_spinlock_t lock;
 	u16 irq_bothedge[4];
 	struct gpio_chip gpio;
 	struct device *dev;
@@ -108,14 +108,14 @@ static void asic3_set_register(struct asic3 *asic, u32 reg, u32 bits, bool set)
 	unsigned long flags;
 	u32 val;
 
-	spin_lock_irqsave(&asic->lock, flags);
+	raw_spin_lock_irqsave(&asic->lock, flags);
 	val = asic3_read_register(asic, reg);
 	if (set)
 		val |= bits;
 	else
 		val &= ~bits;
 	asic3_write_register(asic, reg, val);
-	spin_unlock_irqrestore(&asic->lock, flags);
+	raw_spin_unlock_irqrestore(&asic->lock, flags);
 }
 
 /* IRQs */
@@ -129,13 +129,13 @@ static void asic3_irq_flip_edge(struct asic3 *asic,
 	u16 edge;
 	unsigned long flags;
 
-	spin_lock_irqsave(&asic->lock, flags);
+	raw_spin_lock_irqsave(&asic->lock, flags);
 	edge = asic3_read_register(asic,
 				   base + ASIC3_GPIO_EDGE_TRIGGER);
 	edge ^= bit;
 	asic3_write_register(asic,
 			     base + ASIC3_GPIO_EDGE_TRIGGER, edge);
-	spin_unlock_irqrestore(&asic->lock, flags);
+	raw_spin_unlock_irqrestore(&asic->lock, flags);
 }
 
 static void asic3_irq_demux(struct irq_desc *desc)
@@ -151,10 +151,10 @@ static void asic3_irq_demux(struct irq_desc *desc)
 		u32 status;
 		int bank;
 
-		spin_lock_irqsave(&asic->lock, flags);
+		raw_spin_lock_irqsave(&asic->lock, flags);
 		status = asic3_read_register(asic,
 					     ASIC3_OFFSET(INTR, P_INT_STAT));
-		spin_unlock_irqrestore(&asic->lock, flags);
+		raw_spin_unlock_irqrestore(&asic->lock, flags);
 
 		/* Check all ten register bits */
 		if ((status & 0x3ff) == 0)
@@ -167,7 +167,7 @@ static void asic3_irq_demux(struct irq_desc *desc)
 
 				base = ASIC3_GPIO_A_BASE
 				       + bank * ASIC3_GPIO_BASE_INCR;
-				spin_lock_irqsave(&asic->lock, flags);
+				raw_spin_lock_irqsave(&asic->lock, flags);
 				istat = asic3_read_register(asic,
 							    base +
 							    ASIC3_GPIO_INT_STATUS);
@@ -175,7 +175,7 @@ static void asic3_irq_demux(struct irq_desc *desc)
 				asic3_write_register(asic,
 						     base +
 						     ASIC3_GPIO_INT_STATUS, 0);
-				spin_unlock_irqrestore(&asic->lock, flags);
+				raw_spin_unlock_irqrestore(&asic->lock, flags);
 
 				for (i = 0; i < ASIC3_GPIOS_PER_BANK; i++) {
 					int bit = (1 << i);
@@ -230,11 +230,11 @@ static void asic3_mask_gpio_irq(struct irq_data *data)
 	bank = asic3_irq_to_bank(asic, data->irq);
 	index = asic3_irq_to_index(asic, data->irq);
 
-	spin_lock_irqsave(&asic->lock, flags);
+	raw_spin_lock_irqsave(&asic->lock, flags);
 	val = asic3_read_register(asic, bank + ASIC3_GPIO_MASK);
 	val |= 1 << index;
 	asic3_write_register(asic, bank + ASIC3_GPIO_MASK, val);
-	spin_unlock_irqrestore(&asic->lock, flags);
+	raw_spin_unlock_irqrestore(&asic->lock, flags);
 }
 
 static void asic3_mask_irq(struct irq_data *data)
@@ -243,7 +243,7 @@ static void asic3_mask_irq(struct irq_data *data)
 	int regval;
 	unsigned long flags;
 
-	spin_lock_irqsave(&asic->lock, flags);
+	raw_spin_lock_irqsave(&asic->lock, flags);
 	regval = asic3_read_register(asic,
 				     ASIC3_INTR_BASE +
 				     ASIC3_INTR_INT_MASK);
@@ -255,7 +255,7 @@ static void asic3_mask_irq(struct irq_data *data)
 			     ASIC3_INTR_BASE +
 			     ASIC3_INTR_INT_MASK,
 			     regval);
-	spin_unlock_irqrestore(&asic->lock, flags);
+	raw_spin_unlock_irqrestore(&asic->lock, flags);
 }
 
 static void asic3_unmask_gpio_irq(struct irq_data *data)
@@ -267,11 +267,11 @@ static void asic3_unmask_gpio_irq(struct irq_data *data)
 	bank = asic3_irq_to_bank(asic, data->irq);
 	index = asic3_irq_to_index(asic, data->irq);
 
-	spin_lock_irqsave(&asic->lock, flags);
+	raw_spin_lock_irqsave(&asic->lock, flags);
 	val = asic3_read_register(asic, bank + ASIC3_GPIO_MASK);
 	val &= ~(1 << index);
 	asic3_write_register(asic, bank + ASIC3_GPIO_MASK, val);
-	spin_unlock_irqrestore(&asic->lock, flags);
+	raw_spin_unlock_irqrestore(&asic->lock, flags);
 }
 
 static void asic3_unmask_irq(struct irq_data *data)
@@ -280,7 +280,7 @@ static void asic3_unmask_irq(struct irq_data *data)
 	int regval;
 	unsigned long flags;
 
-	spin_lock_irqsave(&asic->lock, flags);
+	raw_spin_lock_irqsave(&asic->lock, flags);
 	regval = asic3_read_register(asic,
 				     ASIC3_INTR_BASE +
 				     ASIC3_INTR_INT_MASK);
@@ -292,7 +292,7 @@ static void asic3_unmask_irq(struct irq_data *data)
 			     ASIC3_INTR_BASE +
 			     ASIC3_INTR_INT_MASK,
 			     regval);
-	spin_unlock_irqrestore(&asic->lock, flags);
+	raw_spin_unlock_irqrestore(&asic->lock, flags);
 }
 
 static int asic3_gpio_irq_type(struct irq_data *data, unsigned int type)
@@ -306,7 +306,7 @@ static int asic3_gpio_irq_type(struct irq_data *data, unsigned int type)
 	index = asic3_irq_to_index(asic, data->irq);
 	bit = 1<<index;
 
-	spin_lock_irqsave(&asic->lock, flags);
+	raw_spin_lock_irqsave(&asic->lock, flags);
 	level = asic3_read_register(asic,
 				    bank + ASIC3_GPIO_LEVEL_TRIGGER);
 	edge = asic3_read_register(asic,
@@ -348,7 +348,7 @@ static int asic3_gpio_irq_type(struct irq_data *data, unsigned int type)
 			     edge);
 	asic3_write_register(asic, bank + ASIC3_GPIO_TRIGGER_TYPE,
 			     trigger);
-	spin_unlock_irqrestore(&asic->lock, flags);
+	raw_spin_unlock_irqrestore(&asic->lock, flags);
 	return 0;
 }
 
@@ -455,7 +455,7 @@ static int asic3_gpio_direction(struct gpio_chip *chip,
 		return -EINVAL;
 	}
 
-	spin_lock_irqsave(&asic->lock, flags);
+	raw_spin_lock_irqsave(&asic->lock, flags);
 
 	out_reg = asic3_read_register(asic, gpio_base + ASIC3_GPIO_DIRECTION);
 
@@ -467,7 +467,7 @@ static int asic3_gpio_direction(struct gpio_chip *chip,
 
 	asic3_write_register(asic, gpio_base + ASIC3_GPIO_DIRECTION, out_reg);
 
-	spin_unlock_irqrestore(&asic->lock, flags);
+	raw_spin_unlock_irqrestore(&asic->lock, flags);
 
 	return 0;
 
@@ -524,7 +524,7 @@ static void asic3_gpio_set(struct gpio_chip *chip,
 
 	mask = ASIC3_GPIO_TO_MASK(offset);
 
-	spin_lock_irqsave(&asic->lock, flags);
+	raw_spin_lock_irqsave(&asic->lock, flags);
 
 	out_reg = asic3_read_register(asic, gpio_base + ASIC3_GPIO_OUT);
 
@@ -535,7 +535,7 @@ static void asic3_gpio_set(struct gpio_chip *chip,
 
 	asic3_write_register(asic, gpio_base + ASIC3_GPIO_OUT, out_reg);
 
-	spin_unlock_irqrestore(&asic->lock, flags);
+	raw_spin_unlock_irqrestore(&asic->lock, flags);
 }
 
 static int asic3_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
@@ -611,13 +611,13 @@ static void asic3_clk_enable(struct asic3 *asic, struct asic3_clk *clk)
 	unsigned long flags;
 	u32 cdex;
 
-	spin_lock_irqsave(&asic->lock, flags);
+	raw_spin_lock_irqsave(&asic->lock, flags);
 	if (clk->enabled++ == 0) {
 		cdex = asic3_read_register(asic, ASIC3_OFFSET(CLOCK, CDEX));
 		cdex |= clk->cdex;
 		asic3_write_register(asic, ASIC3_OFFSET(CLOCK, CDEX), cdex);
 	}
-	spin_unlock_irqrestore(&asic->lock, flags);
+	raw_spin_unlock_irqrestore(&asic->lock, flags);
 }
 
 static void asic3_clk_disable(struct asic3 *asic, struct asic3_clk *clk)
@@ -627,13 +627,13 @@ static void asic3_clk_disable(struct asic3 *asic, struct asic3_clk *clk)
 
 	WARN_ON(clk->enabled == 0);
 
-	spin_lock_irqsave(&asic->lock, flags);
+	raw_spin_lock_irqsave(&asic->lock, flags);
 	if (--clk->enabled == 0) {
 		cdex = asic3_read_register(asic, ASIC3_OFFSET(CLOCK, CDEX));
 		cdex &= ~clk->cdex;
 		asic3_write_register(asic, ASIC3_OFFSET(CLOCK, CDEX), cdex);
 	}
-	spin_unlock_irqrestore(&asic->lock, flags);
+	raw_spin_unlock_irqrestore(&asic->lock, flags);
 }
 
 /* MFD cells (SPI, PWM, LED, DS1WM, MMC) */
@@ -963,7 +963,7 @@ static int __init asic3_probe(struct platform_device *pdev)
 	if (!asic)
 		return -ENOMEM;
 
-	spin_lock_init(&asic->lock);
+	raw_spin_lock_init(&asic->lock);
 	platform_set_drvdata(pdev, asic);
 	asic->dev = &pdev->dev;
 
-- 
2.12.0
