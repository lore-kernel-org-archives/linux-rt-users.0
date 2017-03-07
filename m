From: Julia Cartwright <julia@ni.com>
Subject: [PATCH RT 3/9] pinctrl: qcom: Use raw spinlock variants
Date: Tue, 7 Mar 2017 16:32:53 -0600
Message-ID: <160952390cfdf2c43f0fa3c188207934fbc6789e.1488919535.git.julia@ni.com>
References: <cover.1488919535.git.julia@ni.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        <stable-rt@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
To: <linux-kernel@vger.kernel.org>, <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:50687 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1756343AbdCGXtx (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 7 Mar 2017 18:49:53 -0500
In-Reply-To: <cover.1488919535.git.julia@ni.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

4.1.38-rt46-rc1 stable review patch.
If you have any objection to the inclusion of this patch, let me know.

--- 8< --- 8< --- 8< ---
From: Julia Cartwright <julia@ni.com>

The MSM pinctrl driver currently implements an irq_chip for handling
GPIO interrupts; due to how irq_chip handling is done, it's necessary
for the irq_chip methods to be invoked from hardirq context, even on a
a real-time kernel.  Because the spinlock_t type becomes a "sleeping"
spinlock w/ RT kernels, it is not suitable to be used with irq_chips.

A quick audit of the operations under the lock reveal that they do only
minimal, bounded work, and are therefore safe to do under a raw
spinlock.

On real-time kernels, this fixes an OOPs which looks like the following,
as reported by Brian Wrenn:

    kernel BUG at kernel/locking/rtmutex.c:1014!
    Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
    Modules linked in: spidev_irq(O) smsc75xx wcn36xx [last unloaded: spidev]
    CPU: 0 PID: 1163 Comm: irq/144-mmc0 Tainted: G        W  O    4.4.9-linaro-lt-qcom #1
    PC is at rt_spin_lock_slowlock+0x80/0x2d8
    LR is at rt_spin_lock_slowlock+0x68/0x2d8
    [..]
  Call trace:
    rt_spin_lock_slowlock
    rt_spin_lock
    msm_gpio_irq_ack
    handle_edge_irq
    generic_handle_irq
    msm_gpio_irq_handler
    generic_handle_irq
    __handle_domain_irq
    gic_handle_irq

Cc: stable-rt@vger.kernel.org
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Reported-by: Brian Wrenn <dcbrianw@gmail.com>
Tested-by: Brian Wrenn <dcbrianw@gmail.com>
Signed-off-by: Julia Cartwright <julia@ni.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
(cherry picked from commit 6373506a3819b12907c8c4e530b2032fe37b08b3)
Signed-off-by: Julia Cartwright <julia@ni.com>
---
 drivers/pinctrl/qcom/pinctrl-msm.c | 48 +++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index f3d800f796c2..9c91fe998ad8 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -59,7 +59,7 @@ struct msm_pinctrl {
 	struct notifier_block restart_nb;
 	int irq;
 
-	spinlock_t lock;
+	raw_spinlock_t lock;
 
 	DECLARE_BITMAP(dual_edge_irqs, MAX_NR_GPIO);
 	DECLARE_BITMAP(enabled_irqs, MAX_NR_GPIO);
@@ -155,14 +155,14 @@ static int msm_pinmux_set_mux(struct pinctrl_dev *pctldev,
 	if (WARN_ON(i == g->nfuncs))
 		return -EINVAL;
 
-	spin_lock_irqsave(&pctrl->lock, flags);
+	raw_spin_lock_irqsave(&pctrl->lock, flags);
 
 	val = readl(pctrl->regs + g->ctl_reg);
 	val &= ~(0x7 << g->mux_bit);
 	val |= i << g->mux_bit;
 	writel(val, pctrl->regs + g->ctl_reg);
 
-	spin_unlock_irqrestore(&pctrl->lock, flags);
+	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 
 	return 0;
 }
@@ -325,14 +325,14 @@ static int msm_config_group_set(struct pinctrl_dev *pctldev,
 			break;
 		case PIN_CONFIG_OUTPUT:
 			/* set output value */
-			spin_lock_irqsave(&pctrl->lock, flags);
+			raw_spin_lock_irqsave(&pctrl->lock, flags);
 			val = readl(pctrl->regs + g->io_reg);
 			if (arg)
 				val |= BIT(g->out_bit);
 			else
 				val &= ~BIT(g->out_bit);
 			writel(val, pctrl->regs + g->io_reg);
-			spin_unlock_irqrestore(&pctrl->lock, flags);
+			raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 
 			/* enable output */
 			arg = 1;
@@ -353,12 +353,12 @@ static int msm_config_group_set(struct pinctrl_dev *pctldev,
 			return -EINVAL;
 		}
 
-		spin_lock_irqsave(&pctrl->lock, flags);
+		raw_spin_lock_irqsave(&pctrl->lock, flags);
 		val = readl(pctrl->regs + g->ctl_reg);
 		val &= ~(mask << bit);
 		val |= arg << bit;
 		writel(val, pctrl->regs + g->ctl_reg);
-		spin_unlock_irqrestore(&pctrl->lock, flags);
+		raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 	}
 
 	return 0;
@@ -386,13 +386,13 @@ static int msm_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
 
 	g = &pctrl->soc->groups[offset];
 
-	spin_lock_irqsave(&pctrl->lock, flags);
+	raw_spin_lock_irqsave(&pctrl->lock, flags);
 
 	val = readl(pctrl->regs + g->ctl_reg);
 	val &= ~BIT(g->oe_bit);
 	writel(val, pctrl->regs + g->ctl_reg);
 
-	spin_unlock_irqrestore(&pctrl->lock, flags);
+	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 
 	return 0;
 }
@@ -406,7 +406,7 @@ static int msm_gpio_direction_output(struct gpio_chip *chip, unsigned offset, in
 
 	g = &pctrl->soc->groups[offset];
 
-	spin_lock_irqsave(&pctrl->lock, flags);
+	raw_spin_lock_irqsave(&pctrl->lock, flags);
 
 	val = readl(pctrl->regs + g->io_reg);
 	if (value)
@@ -419,7 +419,7 @@ static int msm_gpio_direction_output(struct gpio_chip *chip, unsigned offset, in
 	val |= BIT(g->oe_bit);
 	writel(val, pctrl->regs + g->ctl_reg);
 
-	spin_unlock_irqrestore(&pctrl->lock, flags);
+	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 
 	return 0;
 }
@@ -445,7 +445,7 @@ static void msm_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 
 	g = &pctrl->soc->groups[offset];
 
-	spin_lock_irqsave(&pctrl->lock, flags);
+	raw_spin_lock_irqsave(&pctrl->lock, flags);
 
 	val = readl(pctrl->regs + g->io_reg);
 	if (value)
@@ -454,7 +454,7 @@ static void msm_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 		val &= ~BIT(g->out_bit);
 	writel(val, pctrl->regs + g->io_reg);
 
-	spin_unlock_irqrestore(&pctrl->lock, flags);
+	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 }
 
 static int msm_gpio_request(struct gpio_chip *chip, unsigned offset)
@@ -585,7 +585,7 @@ static void msm_gpio_irq_mask(struct irq_data *d)
 
 	g = &pctrl->soc->groups[d->hwirq];
 
-	spin_lock_irqsave(&pctrl->lock, flags);
+	raw_spin_lock_irqsave(&pctrl->lock, flags);
 
 	val = readl(pctrl->regs + g->intr_cfg_reg);
 	val &= ~BIT(g->intr_enable_bit);
@@ -593,7 +593,7 @@ static void msm_gpio_irq_mask(struct irq_data *d)
 
 	clear_bit(d->hwirq, pctrl->enabled_irqs);
 
-	spin_unlock_irqrestore(&pctrl->lock, flags);
+	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 }
 
 static void msm_gpio_irq_unmask(struct irq_data *d)
@@ -606,7 +606,7 @@ static void msm_gpio_irq_unmask(struct irq_data *d)
 
 	g = &pctrl->soc->groups[d->hwirq];
 
-	spin_lock_irqsave(&pctrl->lock, flags);
+	raw_spin_lock_irqsave(&pctrl->lock, flags);
 
 	val = readl(pctrl->regs + g->intr_status_reg);
 	val &= ~BIT(g->intr_status_bit);
@@ -618,7 +618,7 @@ static void msm_gpio_irq_unmask(struct irq_data *d)
 
 	set_bit(d->hwirq, pctrl->enabled_irqs);
 
-	spin_unlock_irqrestore(&pctrl->lock, flags);
+	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 }
 
 static void msm_gpio_irq_ack(struct irq_data *d)
@@ -631,7 +631,7 @@ static void msm_gpio_irq_ack(struct irq_data *d)
 
 	g = &pctrl->soc->groups[d->hwirq];
 
-	spin_lock_irqsave(&pctrl->lock, flags);
+	raw_spin_lock_irqsave(&pctrl->lock, flags);
 
 	val = readl(pctrl->regs + g->intr_status_reg);
 	if (g->intr_ack_high)
@@ -643,7 +643,7 @@ static void msm_gpio_irq_ack(struct irq_data *d)
 	if (test_bit(d->hwirq, pctrl->dual_edge_irqs))
 		msm_gpio_update_dual_edge_pos(pctrl, g, d);
 
-	spin_unlock_irqrestore(&pctrl->lock, flags);
+	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 }
 
 static int msm_gpio_irq_set_type(struct irq_data *d, unsigned int type)
@@ -656,7 +656,7 @@ static int msm_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 
 	g = &pctrl->soc->groups[d->hwirq];
 
-	spin_lock_irqsave(&pctrl->lock, flags);
+	raw_spin_lock_irqsave(&pctrl->lock, flags);
 
 	/*
 	 * For hw without possibility of detecting both edges
@@ -730,7 +730,7 @@ static int msm_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 	if (test_bit(d->hwirq, pctrl->dual_edge_irqs))
 		msm_gpio_update_dual_edge_pos(pctrl, g, d);
 
-	spin_unlock_irqrestore(&pctrl->lock, flags);
+	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 
 	if (type & (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_LEVEL_HIGH))
 		__irq_set_handler_locked(d->irq, handle_level_irq);
@@ -746,11 +746,11 @@ static int msm_gpio_irq_set_wake(struct irq_data *d, unsigned int on)
 	struct msm_pinctrl *pctrl = to_msm_pinctrl(gc);
 	unsigned long flags;
 
-	spin_lock_irqsave(&pctrl->lock, flags);
+	raw_spin_lock_irqsave(&pctrl->lock, flags);
 
 	irq_set_irq_wake(pctrl->irq, on);
 
-	spin_unlock_irqrestore(&pctrl->lock, flags);
+	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 
 	return 0;
 }
@@ -887,7 +887,7 @@ int msm_pinctrl_probe(struct platform_device *pdev,
 	pctrl->soc = soc_data;
 	pctrl->chip = msm_gpio_template;
 
-	spin_lock_init(&pctrl->lock);
+	raw_spin_lock_init(&pctrl->lock);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	pctrl->regs = devm_ioremap_resource(&pdev->dev, res);
-- 
2.11.1

