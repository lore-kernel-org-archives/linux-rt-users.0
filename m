From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH] irqchip: keystone: Fix "scheduling while atomic" on rt
Date: Thu, 8 Dec 2016 17:33:10 -0600
Message-ID: <20161208233310.10329-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-rt-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sam Nelson <sam.nelson@ti.com>, <bigeasy@linutronix.de>,
        "Strashko, Grygorii" <grygorii.strashko@ti.com>
To: Santosh Shilimkar <ssantosh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Jason Cooper <jason@lakedaemon.net>, Suman Anna <s-anna@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: "Strashko, Grygorii" <grygorii.strashko@ti.com>

The below call chain generates "scheduling while atomic" backtrace and
causes system crash when Keystone 2 IRQ chip driver is used with RT-kernel:

gic_handle_irq()
 |-__handle_domain_irq()
  |-generic_handle_irq()
   |-keystone_irq_handler()
    |-regmap_read()
     |-regmap_lock_spinlock()
      |-rt_spin_lock()

The reason is that Keystone driver dispatches IRQ using chained IRQ handler
and accesses I/O memory through syscon->regmap(mmio) which is implemented
as fast_io regmap and uses regular spinlocks for synchronization, but
spinlocks transformed to rt_mutexes on RT.

Hence, convert Keystone 2 IRQ driver to use generic irq handler instead of
chained IRQ handler. This way it will be compatible with RT kernel where it
will be forced thread IRQ handler while in non-RT kernel it still will be
executed in HW IRQ context.

Cc: Suman Anna <s-anna@ti.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
Hi,

In general, there is an option to convert this driver to use nested threaded
irq handlers (this should not affect our current user of these irqs from
performance point of view), but that will affect on our current remoteproc and
UIO based drivers (including uio core) which do not expect to use threaded
irq and use request_irq(). These drivers and UIO core might require to be
updated to use threaded irqs and (or) request_any_context_irq().

Suman, what do you think?

 drivers/irqchip/irq-keystone.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/irqchip/irq-keystone.c b/drivers/irqchip/irq-keystone.c
index 54a5e87..efbcf84 100644
--- a/drivers/irqchip/irq-keystone.c
+++ b/drivers/irqchip/irq-keystone.c
@@ -19,9 +19,9 @@
 #include <linux/bitops.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/interrupt.h>
 #include <linux/irqdomain.h>
 #include <linux/irqchip.h>
-#include <linux/irqchip/chained_irq.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/mfd/syscon.h>
@@ -39,6 +39,7 @@ struct keystone_irq_device {
 	struct irq_domain	*irqd;
 	struct regmap		*devctrl_regs;
 	u32			devctrl_offset;
+	raw_spinlock_t		wa_lock;
 };
 
 static inline u32 keystone_irq_readl(struct keystone_irq_device *kirq)
@@ -83,17 +84,15 @@ static void keystone_irq_ack(struct irq_data *d)
 	/* nothing to do here */
 }
 
-static void keystone_irq_handler(struct irq_desc *desc)
+static irqreturn_t keystone_irq_handler(int irq, void *keystone_irq)
 {
-	unsigned int irq = irq_desc_get_irq(desc);
-	struct keystone_irq_device *kirq = irq_desc_get_handler_data(desc);
+	struct keystone_irq_device *kirq = keystone_irq;
+	unsigned long wa_lock_flags;
 	unsigned long pending;
 	int src, virq;
 
 	dev_dbg(kirq->dev, "start irq %d\n", irq);
 
-	chained_irq_enter(irq_desc_get_chip(desc), desc);
-
 	pending = keystone_irq_readl(kirq);
 	keystone_irq_writel(kirq, pending);
 
@@ -111,13 +110,15 @@ static void keystone_irq_handler(struct irq_desc *desc)
 			if (!virq)
 				dev_warn(kirq->dev, "spurious irq detected hwirq %d, virq %d\n",
 					 src, virq);
+			raw_spin_lock_irqsave(&kirq->wa_lock, wa_lock_flags);
 			generic_handle_irq(virq);
+			raw_spin_unlock_irqrestore(&kirq->wa_lock,
+						   wa_lock_flags);
 		}
 	}
 
-	chained_irq_exit(irq_desc_get_chip(desc), desc);
-
 	dev_dbg(kirq->dev, "end irq %d\n", irq);
+	return IRQ_HANDLED;
 }
 
 static int keystone_irq_map(struct irq_domain *h, unsigned int virq,
@@ -182,9 +183,16 @@ static int keystone_irq_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	raw_spin_lock_init(&kirq->wa_lock);
+
 	platform_set_drvdata(pdev, kirq);
 
-	irq_set_chained_handler_and_data(kirq->irq, keystone_irq_handler, kirq);
+	ret = request_irq(kirq->irq, keystone_irq_handler,
+			  0, dev_name(dev), kirq);
+	if (ret) {
+		irq_domain_remove(kirq->irqd);
+		return ret;
+	}
 
 	/* clear all source bits */
 	keystone_irq_writel(kirq, ~0x0);
@@ -199,6 +207,8 @@ static int keystone_irq_remove(struct platform_device *pdev)
 	struct keystone_irq_device *kirq = platform_get_drvdata(pdev);
 	int hwirq;
 
+	free_irq(kirq->irq, kirq);
+
 	for (hwirq = 0; hwirq < KEYSTONE_N_IRQ; hwirq++)
 		irq_dispose_mapping(irq_find_mapping(kirq->irqd, hwirq));
 
-- 
2.10.1
