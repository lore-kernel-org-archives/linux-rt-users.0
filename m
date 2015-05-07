From: Xander Huff <xander.huff-acOepvfBmUk@public.gmane.org>
Subject: [PATCH] iio: adc: xilinx-xadc: Convert to raw spinlock
Date: Thu, 7 May 2015 10:38:10 -0500
Message-ID: <1431013090-18996-1-git-send-email-xander.huff@ni.com>
Cc: michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org,
	linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-rt-users-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben.shelton-acOepvfBmUk@public.gmane.org,
	joe.hershberger-acOepvfBmUk@public.gmane.org, joshc-acOepvfBmUk@public.gmane.org,
	Xander Huff <xander.huff-acOepvfBmUk@public.gmane.org>
To: jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org,
	pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-rt-users.vger.kernel.org

The driver currently registers a pair of irq handlers using
request_threaded_irq(), however the synchronization mechanism
between the hardirq and the threadedirq handler is a regular spinlock.

Unfortunately, this breaks PREEMPT_RT builds, where a spinlock can
sleep, and is thus not able to be acquired from a hardirq handler.
Because the set of operations performed under the spinlock is already
minimal and bounded, it is a suitable candidate for being a raw_spinlock.

This patch should not impact behavior on !PREEMPT_RT builds.

Signed-off-by: Xander Huff <xander.huff-acOepvfBmUk@public.gmane.org>
Reviewed-by: Joe Hershberger <joe.hershberger-acOepvfBmUk@public.gmane.org>
Reviewed-by: Ben Shelton <ben.shelton-acOepvfBmUk@public.gmane.org>
Reviewed-by: Josh Cartwright <joshc-acOepvfBmUk@public.gmane.org>
---
 drivers/iio/adc/xilinx-xadc-core.c | 34 +++++++++++++++++-----------------
 drivers/iio/adc/xilinx-xadc.h      |  2 +-
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index a221f73..4bdf03b 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -163,7 +163,7 @@ static int xadc_zynq_write_adc_reg(struct xadc *xadc, unsigned int reg,
 	uint32_t tmp;
 	int ret;
 
-	spin_lock_irq(&xadc->lock);
+	raw_spin_lock_irq(&xadc->lock);
 	xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_DFIFO_GTH,
 			XADC_ZYNQ_INT_DFIFO_GTH);
 
@@ -177,7 +177,7 @@ static int xadc_zynq_write_adc_reg(struct xadc *xadc, unsigned int reg,
 	xadc_write_reg(xadc, XADC_ZYNQ_REG_CFG, tmp);
 
 	xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_DFIFO_GTH, 0);
-	spin_unlock_irq(&xadc->lock);
+	raw_spin_unlock_irq(&xadc->lock);
 
 	ret = wait_for_completion_interruptible_timeout(&xadc->completion, HZ);
 	if (ret == 0)
@@ -200,7 +200,7 @@ static int xadc_zynq_read_adc_reg(struct xadc *xadc, unsigned int reg,
 	cmd[0] = XADC_ZYNQ_CMD(XADC_ZYNQ_CMD_READ, reg, 0);
 	cmd[1] = XADC_ZYNQ_CMD(XADC_ZYNQ_CMD_NOP, 0, 0);
 
-	spin_lock_irq(&xadc->lock);
+	raw_spin_lock_irq(&xadc->lock);
 	xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_DFIFO_GTH,
 			XADC_ZYNQ_INT_DFIFO_GTH);
 	xadc_zynq_drain_fifo(xadc);
@@ -213,7 +213,7 @@ static int xadc_zynq_read_adc_reg(struct xadc *xadc, unsigned int reg,
 	xadc_write_reg(xadc, XADC_ZYNQ_REG_CFG, tmp);
 
 	xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_DFIFO_GTH, 0);
-	spin_unlock_irq(&xadc->lock);
+	raw_spin_unlock_irq(&xadc->lock);
 	ret = wait_for_completion_interruptible_timeout(&xadc->completion, HZ);
 	if (ret == 0)
 		ret = -EIO;
@@ -252,7 +252,7 @@ static void xadc_zynq_unmask_worker(struct work_struct *work)
 
 	misc_sts &= XADC_ZYNQ_INT_ALARM_MASK;
 
-	spin_lock_irq(&xadc->lock);
+	raw_spin_lock_irq(&xadc->lock);
 
 	/* Clear those bits which are not active anymore */
 	unmask = (xadc->zynq_masked_alarm ^ misc_sts) & xadc->zynq_masked_alarm;
@@ -266,7 +266,7 @@ static void xadc_zynq_unmask_worker(struct work_struct *work)
 
 	xadc_zynq_update_intmsk(xadc, 0, 0);
 
-	spin_unlock_irq(&xadc->lock);
+	raw_spin_unlock_irq(&xadc->lock);
 
 	/* if still pending some alarm re-trigger the timer */
 	if (xadc->zynq_masked_alarm) {
@@ -281,10 +281,10 @@ static irqreturn_t xadc_zynq_threaded_interrupt_handler(int irq, void *devid)
 	struct xadc *xadc = iio_priv(indio_dev);
 	unsigned int alarm;
 
-	spin_lock_irq(&xadc->lock);
+	raw_spin_lock_irq(&xadc->lock);
 	alarm = xadc->zynq_alarm;
 	xadc->zynq_alarm = 0;
-	spin_unlock_irq(&xadc->lock);
+	raw_spin_unlock_irq(&xadc->lock);
 
 	xadc_handle_events(indio_dev, xadc_zynq_transform_alarm(alarm));
 
@@ -309,7 +309,7 @@ static irqreturn_t xadc_zynq_interrupt_handler(int irq, void *devid)
 	if (!status)
 		return IRQ_NONE;
 
-	spin_lock(&xadc->lock);
+	raw_spin_lock(&xadc->lock);
 
 	xadc_write_reg(xadc, XADC_ZYNQ_REG_INTSTS, status);
 
@@ -330,7 +330,7 @@ static irqreturn_t xadc_zynq_interrupt_handler(int irq, void *devid)
 		xadc_zynq_update_intmsk(xadc, 0, 0);
 		ret = IRQ_WAKE_THREAD;
 	}
-	spin_unlock(&xadc->lock);
+	raw_spin_unlock(&xadc->lock);
 
 	return ret;
 }
@@ -419,7 +419,7 @@ static void xadc_zynq_update_alarm(struct xadc *xadc, unsigned int alarm)
 	/* Move OT to bit 7 */
 	alarm = ((alarm & 0x08) << 4) | ((alarm & 0xf0) >> 1) | (alarm & 0x07);
 
-	spin_lock_irqsave(&xadc->lock, flags);
+	raw_spin_lock_irqsave(&xadc->lock, flags);
 
 	/* Clear previous interrupts if any. */
 	xadc_read_reg(xadc, XADC_ZYNQ_REG_INTSTS, &status);
@@ -428,7 +428,7 @@ static void xadc_zynq_update_alarm(struct xadc *xadc, unsigned int alarm)
 	xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_ALARM_MASK,
 		~alarm & XADC_ZYNQ_INT_ALARM_MASK);
 
-	spin_unlock_irqrestore(&xadc->lock, flags);
+	raw_spin_unlock_irqrestore(&xadc->lock, flags);
 }
 
 static const struct xadc_ops xadc_zynq_ops = {
@@ -520,12 +520,12 @@ static void xadc_axi_update_alarm(struct xadc *xadc, unsigned int alarm)
 	alarm = ((alarm & 0x07) << 1) | ((alarm & 0x08) >> 3) |
 			((alarm & 0xf0) << 6);
 
-	spin_lock_irqsave(&xadc->lock, flags);
+	raw_spin_lock_irqsave(&xadc->lock, flags);
 	xadc_read_reg(xadc, XADC_AXI_REG_IPIER, &val);
 	val &= ~XADC_AXI_INT_ALARM_MASK;
 	val |= alarm;
 	xadc_write_reg(xadc, XADC_AXI_REG_IPIER, val);
-	spin_unlock_irqrestore(&xadc->lock, flags);
+	raw_spin_unlock_irqrestore(&xadc->lock, flags);
 }
 
 static unsigned long xadc_axi_get_dclk(struct xadc *xadc)
@@ -674,7 +674,7 @@ static int xadc_trigger_set_state(struct iio_trigger *trigger, bool state)
 		xadc->trigger = NULL;
 	}
 
-	spin_lock_irqsave(&xadc->lock, flags);
+	raw_spin_lock_irqsave(&xadc->lock, flags);
 	xadc_read_reg(xadc, XADC_AXI_REG_IPIER, &val);
 	xadc_write_reg(xadc, XADC_AXI_REG_IPISR, val & XADC_AXI_INT_EOS);
 	if (state)
@@ -682,7 +682,7 @@ static int xadc_trigger_set_state(struct iio_trigger *trigger, bool state)
 	else
 		val &= ~XADC_AXI_INT_EOS;
 	xadc_write_reg(xadc, XADC_AXI_REG_IPIER, val);
-	spin_unlock_irqrestore(&xadc->lock, flags);
+	raw_spin_unlock_irqrestore(&xadc->lock, flags);
 
 err_out:
 	mutex_unlock(&xadc->mutex);
@@ -1175,7 +1175,7 @@ static int xadc_probe(struct platform_device *pdev)
 	xadc->ops = id->data;
 	init_completion(&xadc->completion);
 	mutex_init(&xadc->mutex);
-	spin_lock_init(&xadc->lock);
+	raw_spin_lock_init(&xadc->lock);
 	INIT_DELAYED_WORK(&xadc->zynq_unmask_work, xadc_zynq_unmask_worker);
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
diff --git a/drivers/iio/adc/xilinx-xadc.h b/drivers/iio/adc/xilinx-xadc.h
index c7487e8..d945e25 100644
--- a/drivers/iio/adc/xilinx-xadc.h
+++ b/drivers/iio/adc/xilinx-xadc.h
@@ -66,7 +66,7 @@ struct xadc {
 	struct delayed_work zynq_unmask_work;
 
 	struct mutex mutex;
-	spinlock_t lock;
+	raw_spinlock_t lock;
 
 	struct completion completion;
 };
-- 
1.9.1
