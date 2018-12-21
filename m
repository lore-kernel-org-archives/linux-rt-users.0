From: Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH RT 7/9] pinctrl: bcm2835: Use raw spinlock for RT compatibility
Date: Fri, 21 Dec 2018 09:21:19 -0600
Message-ID: <1b44e8b14448276fcc768b7da4937de95973e94c.1545347029.git.tom.zanussi@linux.intel.com>
References: <cover.1545347029.git.tom.zanussi@linux.intel.com>
Cc: rostedt@goodmis.org, tglx@linutronix.de, C.Emde@osadl.org,
        jkacur@redhat.com, bigeasy@linutronix.de,
        daniel.wagner@siemens.com, julia@ni.com
To: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1545347029.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1545347029.git.tom.zanussi@linux.intel.com>
References: <cover.1545347029.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

v3.18.129-rt111 rt-stable review patch.  If anyone has any objections,
please let me know.

------------------
From: Lukas Wunner <lukas@wunner.de>

[Upstream rt-devel commit 55016fa934eb0d4e037beef2b2f503012dfebeac]

[Upstream commit 71dfaa749f2f7c1722ebf6716d3f797a04528cba]

The BCM2835 pinctrl driver acquires a spinlock in its ->irq_enable,
->irq_disable and ->irq_set_type callbacks.  Spinlocks become sleeping
locks with CONFIG_PREEMPT_RT_FULL=y, therefore invocation of one of the
callbacks in atomic context may cause a hard lockup if at least two GPIO
pins in the same bank are used as interrupts.  The issue doesn't occur
with just a single interrupt pin per bank because the lock is never
contended.  I'm experiencing such lockups with GPIO 8 and 28 used as
level-triggered interrupts, i.e. with ->irq_disable being invoked on
reception of every IRQ.

The critical section protected by the spinlock is very small (one bitop
and one RMW of an MMIO register), hence converting to a raw spinlock
seems a better trade-off than converting the driver to threaded IRQ
handling (which would increase latency to handle an interrupt).

Cc: Mathias Duckeck <m.duckeck@kunbus.de>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Acked-by: Julia Cartwright <julia@ni.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>

 Conflicts:
	drivers/pinctrl/bcm/pinctrl-bcm2835.c
---
 drivers/pinctrl/pinctrl-bcm2835.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-bcm2835.c b/drivers/pinctrl/pinctrl-bcm2835.c
index eabba02f71f9..9a975a12b8e3 100644
--- a/drivers/pinctrl/pinctrl-bcm2835.c
+++ b/drivers/pinctrl/pinctrl-bcm2835.c
@@ -106,7 +106,7 @@ struct bcm2835_pinctrl {
 	struct pinctrl_gpio_range gpio_range;
 
 	struct bcm2835_gpio_irqdata irq_data[BCM2835_NUM_BANKS];
-	spinlock_t irq_lock[BCM2835_NUM_BANKS];
+	raw_spinlock_t irq_lock[BCM2835_NUM_BANKS];
 };
 
 static struct lock_class_key gpio_lock_class;
@@ -465,10 +465,10 @@ static void bcm2835_gpio_irq_enable(struct irq_data *data)
 	unsigned bank = GPIO_REG_OFFSET(gpio);
 	unsigned long flags;
 
-	spin_lock_irqsave(&pc->irq_lock[bank], flags);
+	raw_spin_lock_irqsave(&pc->irq_lock[bank], flags);
 	set_bit(offset, &pc->enabled_irq_map[bank]);
 	bcm2835_gpio_irq_config(pc, gpio, true);
-	spin_unlock_irqrestore(&pc->irq_lock[bank], flags);
+	raw_spin_unlock_irqrestore(&pc->irq_lock[bank], flags);
 }
 
 static void bcm2835_gpio_irq_disable(struct irq_data *data)
@@ -479,10 +479,10 @@ static void bcm2835_gpio_irq_disable(struct irq_data *data)
 	unsigned bank = GPIO_REG_OFFSET(gpio);
 	unsigned long flags;
 
-	spin_lock_irqsave(&pc->irq_lock[bank], flags);
+	raw_spin_lock_irqsave(&pc->irq_lock[bank], flags);
 	bcm2835_gpio_irq_config(pc, gpio, false);
 	clear_bit(offset, &pc->enabled_irq_map[bank]);
-	spin_unlock_irqrestore(&pc->irq_lock[bank], flags);
+	raw_spin_unlock_irqrestore(&pc->irq_lock[bank], flags);
 }
 
 static int __bcm2835_gpio_irq_set_type_disabled(struct bcm2835_pinctrl *pc,
@@ -584,14 +584,14 @@ static int bcm2835_gpio_irq_set_type(struct irq_data *data, unsigned int type)
 	unsigned long flags;
 	int ret;
 
-	spin_lock_irqsave(&pc->irq_lock[bank], flags);
+	raw_spin_lock_irqsave(&pc->irq_lock[bank], flags);
 
 	if (test_bit(offset, &pc->enabled_irq_map[bank]))
 		ret = __bcm2835_gpio_irq_set_type_enabled(pc, gpio, type);
 	else
 		ret = __bcm2835_gpio_irq_set_type_disabled(pc, gpio, type);
 
-	spin_unlock_irqrestore(&pc->irq_lock[bank], flags);
+	raw_spin_unlock_irqrestore(&pc->irq_lock[bank], flags);
 
 	return ret;
 }
@@ -1004,7 +1004,7 @@ static int bcm2835_pinctrl_probe(struct platform_device *pdev)
 		pc->irq[i] = irq_of_parse_and_map(np, i);
 		pc->irq_data[i].pc = pc;
 		pc->irq_data[i].bank = i;
-		spin_lock_init(&pc->irq_lock[i]);
+		raw_spin_lock_init(&pc->irq_lock[i]);
 
 		len = strlen(dev_name(pc->dev)) + 16;
 		name = devm_kzalloc(pc->dev, len, GFP_KERNEL);
-- 
2.14.1
