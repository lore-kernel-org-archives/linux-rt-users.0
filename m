From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 03/10] pinctrl: qcom: Use raw spinlock variants
Date: Tue, 07 Mar 2017 16:20:44 -0500
Message-ID: <20170307212313.628182056@goodmis.org>
References: <20170307212041.431615000@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>, stable-rt@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Brian Wrenn <dcbrianw@gmail.com>
To: linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0003-pinctrl-qcom-Use-raw-spinlock-variants.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

4.4.50-rt63-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 drivers/pinctrl/qcom/pinctrl-msm.c | 48 +++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index 146264a41ec8..81fd38894eaf 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -60,7 +60,7 @@ struct msm_pinctrl {
 	struct notifier_block restart_nb;
 	int irq;
 
-	spinlock_t lock;
+	raw_spinlock_t lock;
 
 	DECLARE_BITMAP(dual_edge_irqs, MAX_NR_GPIO);
 	DECLARE_BITMAP(enabled_irqs, MAX_NR_GPIO);
@@ -156,14 +156,14 @@ static int msm_pinmux_set_mux(struct pinctrl_dev *pctldev,
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
@@ -326,14 +326,14 @@ static int msm_config_group_set(struct pinctrl_dev *pctldev,
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
@@ -354,12 +354,12 @@ static int msm_config_group_set(struct pinctrl_dev *pctldev,
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
@@ -387,13 +387,13 @@ static int msm_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
 
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
@@ -407,7 +407,7 @@ static int msm_gpio_direction_output(struct gpio_chip *chip, unsigned offset, in
 
 	g = &pctrl->soc->groups[offset];
 
-	spin_lock_irqsave(&pctrl->lock, flags);
+	raw_spin_lock_irqsave(&pctrl->lock, flags);
 
 	val = readl(pctrl->regs + g->io_reg);
 	if (value)
@@ -420,7 +420,7 @@ static int msm_gpio_direction_output(struct gpio_chip *chip, unsigned offset, in
 	val |= BIT(g->oe_bit);
 	writel(val, pctrl->regs + g->ctl_reg);
 
-	spin_unlock_irqrestore(&pctrl->lock, flags);
+	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 
 	return 0;
 }
@@ -446,7 +446,7 @@ static void msm_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 
 	g = &pctrl->soc->groups[offset];
 
-	spin_lock_irqsave(&pctrl->lock, flags);
+	raw_spin_lock_irqsave(&pctrl->lock, flags);
 
 	val = readl(pctrl->regs + g->io_reg);
 	if (value)
@@ -455,7 +455,7 @@ static void msm_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 		val &= ~BIT(g->out_bit);
 	writel(val, pctrl->regs + g->io_reg);
 
-	spin_unlock_irqrestore(&pctrl->lock, flags);
+	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 }
 
 #ifdef CONFIG_DEBUG_FS
@@ -574,7 +574,7 @@ static void msm_gpio_irq_mask(struct irq_data *d)
 
 	g = &pctrl->soc->groups[d->hwirq];
 
-	spin_lock_irqsave(&pctrl->lock, flags);
+	raw_spin_lock_irqsave(&pctrl->lock, flags);
 
 	val = readl(pctrl->regs + g->intr_cfg_reg);
 	val &= ~BIT(g->intr_enable_bit);
@@ -582,7 +582,7 @@ static void msm_gpio_irq_mask(struct irq_data *d)
 
 	clear_bit(d->hwirq, pctrl->enabled_irqs);
 
-	spin_unlock_irqrestore(&pctrl->lock, flags);
+	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 }
 
 static void msm_gpio_irq_unmask(struct irq_data *d)
@@ -595,7 +595,7 @@ static void msm_gpio_irq_unmask(struct irq_data *d)
 
 	g = &pctrl->soc->groups[d->hwirq];
 
-	spin_lock_irqsave(&pctrl->lock, flags);
+	raw_spin_lock_irqsave(&pctrl->lock, flags);
 
 	val = readl(pctrl->regs + g->intr_status_reg);
 	val &= ~BIT(g->intr_status_bit);
@@ -607,7 +607,7 @@ static void msm_gpio_irq_unmask(struct irq_data *d)
 
 	set_bit(d->hwirq, pctrl->enabled_irqs);
 
-	spin_unlock_irqrestore(&pctrl->lock, flags);
+	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 }
 
 static void msm_gpio_irq_ack(struct irq_data *d)
@@ -620,7 +620,7 @@ static void msm_gpio_irq_ack(struct irq_data *d)
 
 	g = &pctrl->soc->groups[d->hwirq];
 
-	spin_lock_irqsave(&pctrl->lock, flags);
+	raw_spin_lock_irqsave(&pctrl->lock, flags);
 
 	val = readl(pctrl->regs + g->intr_status_reg);
 	if (g->intr_ack_high)
@@ -632,7 +632,7 @@ static void msm_gpio_irq_ack(struct irq_data *d)
 	if (test_bit(d->hwirq, pctrl->dual_edge_irqs))
 		msm_gpio_update_dual_edge_pos(pctrl, g, d);
 
-	spin_unlock_irqrestore(&pctrl->lock, flags);
+	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 }
 
 static int msm_gpio_irq_set_type(struct irq_data *d, unsigned int type)
@@ -645,7 +645,7 @@ static int msm_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 
 	g = &pctrl->soc->groups[d->hwirq];
 
-	spin_lock_irqsave(&pctrl->lock, flags);
+	raw_spin_lock_irqsave(&pctrl->lock, flags);
 
 	/*
 	 * For hw without possibility of detecting both edges
@@ -719,7 +719,7 @@ static int msm_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 	if (test_bit(d->hwirq, pctrl->dual_edge_irqs))
 		msm_gpio_update_dual_edge_pos(pctrl, g, d);
 
-	spin_unlock_irqrestore(&pctrl->lock, flags);
+	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 
 	if (type & (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_LEVEL_HIGH))
 		irq_set_handler_locked(d, handle_level_irq);
@@ -735,11 +735,11 @@ static int msm_gpio_irq_set_wake(struct irq_data *d, unsigned int on)
 	struct msm_pinctrl *pctrl = to_msm_pinctrl(gc);
 	unsigned long flags;
 
-	spin_lock_irqsave(&pctrl->lock, flags);
+	raw_spin_lock_irqsave(&pctrl->lock, flags);
 
 	irq_set_irq_wake(pctrl->irq, on);
 
-	spin_unlock_irqrestore(&pctrl->lock, flags);
+	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 
 	return 0;
 }
@@ -885,7 +885,7 @@ int msm_pinctrl_probe(struct platform_device *pdev,
 	pctrl->soc = soc_data;
 	pctrl->chip = msm_gpio_template;
 
-	spin_lock_init(&pctrl->lock);
+	raw_spin_lock_init(&pctrl->lock);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	pctrl->regs = devm_ioremap_resource(&pdev->dev, res);
-- 
2.10.2
