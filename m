Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mailout2.hostsharing.net ([83.223.90.233]:48259 "EHLO
        mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbfAWIiE (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 23 Jan 2019 03:38:04 -0500
Message-Id: <44bdefbfca55d3a848efa9d11cb43ca0d5c208ce.1548230893.git.lukas@wunner.de>
In-Reply-To: <cover.1548230893.git.lukas@wunner.de>
References: <cover.1548230893.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Wed, 23 Jan 2019 09:26:00 +0100
Subject: [PATCH v2 1/6] dmaengine: bcm2835: Fix interrupt race on RT
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Vinod Koul <vkoul@kernel.org>, Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>
Cc: Frank Pavlic <f.pavlic@kunbus.de>, Martin Sperl <kernel@martin.sperl.org>, Florian Meier <florian.meier@koalo.de>, Clive Messer <clive.m.messer@gmail.com>, Matthias Reichl <hias@horus.com>, dmaengine@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, Tiejun Chen <tiejun.china@gmail.com>, linux-rt-users@vger.kernel.org

If IRQ handlers are threaded (either because CONFIG_PREEMPT_RT_BASE is
enabled or "threadirqs" was passed on the command line) and if system
load is sufficiently high that wakeup latency of IRQ threads degrades,
SPI DMA transactions on the BCM2835 occasionally break like this:

ks8851 spi0.0: SPI transfer timed out
bcm2835-dma 3f007000.dma: DMA transfer could not be terminated
ks8851 spi0.0 eth2: ks8851_rdfifo: spi_sync() failed

The root cause is an assumption made by the DMA driver which is
documented in a code comment in bcm2835_dma_terminate_all():

/*
 * Stop DMA activity: we assume the callback will not be called
 * after bcm_dma_abort() returns (even if it does, it will see
 * c->desc is NULL and exit.)
 */

That assumption falls apart if the IRQ handler bcm2835_dma_callback() is
threaded: A client may terminate a descriptor and issue a new one
before the IRQ handler had a chance to run. In fact the IRQ handler may
miss an *arbitrary* number of descriptors. The result is the following
race condition:

1. A descriptor finishes, its interrupt is deferred to the IRQ thread.
2. A client calls dma_terminate_async() which sets channel->desc = NULL.
3. The client issues a new descriptor. Because channel->desc is NULL,
   bcm2835_dma_issue_pending() immediately starts the descriptor.
4. Finally the IRQ thread runs and writes BCM2835_DMA_INT to the CS
   register to acknowledge the interrupt. This clears the ACTIVE flag,
   so the newly issued descriptor is paused in the middle of the
   transaction. Because channel->desc is not NULL, the IRQ thread
   finalizes the descriptor and tries to start the next one.

I see two possible solutions: The first is to call synchronize_irq()
in bcm2835_dma_issue_pending() to wait until the IRQ thread has
finished before issuing a new descriptor. The downside of this approach
is unnecessary latency if clients desire rapidly terminating and
re-issuing descriptors and don't have any use for an IRQ callback.
(The SPI TX DMA channel is a case in point.)

A better alternative is to make the IRQ thread recognize that it has
missed descriptors and avoid finalizing the newly issued descriptor.
So first of all, set the ACTIVE flag when acknowledging the interrupt.
This keeps a newly issued descriptor running.

If the descriptor was finished, the channel remains idle despite the
ACTIVE flag being set. However the ACTIVE flag can then no longer be
used to check whether the channel is idle, so instead check whether
the register containing the current control block address is zero
and finalize the current descriptor only if so.

That way, there is no impact on latency and throughput if the client
doesn't care for the interrupt: Only minimal additional overhead is
introduced for non-cyclic descriptors as one further MMIO read is
necessary per interrupt to check for idleness of the channel. Cyclic
descriptors are sped up slightly by removing one MMIO write per
interrupt.

Fixes: 96286b576690 ("dmaengine: Add support for BCM2835")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v3.14+
Cc: Frank Pavlic <f.pavlic@kunbus.de>
Cc: Martin Sperl <kernel@martin.sperl.org>
Cc: Florian Meier <florian.meier@koalo.de>
Cc: Clive Messer <clive.m.messer@gmail.com>
Cc: Matthias Reichl <hias@horus.com>
---
 drivers/dma/bcm2835-dma.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index 7beec403c2c9..7c1b9ef2f71f 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -411,7 +411,12 @@ static int bcm2835_dma_abort(void __iomem *chan_base)
 	long int timeout = 10000;
 
 	cs = readl(chan_base + BCM2835_DMA_CS);
-	if (!(cs & BCM2835_DMA_ACTIVE))
+
+	/*
+	 * A zero control block address means the channel is idle.
+	 * (The ACTIVE flag in the CS register is not a reliable indicator.)
+	 */
+	if (!readl(chan_base + BCM2835_DMA_ADDR))
 		return 0;
 
 	/* Write 0 to the active bit - Pause the DMA */
@@ -475,8 +480,15 @@ static irqreturn_t bcm2835_dma_callback(int irq, void *data)
 
 	spin_lock_irqsave(&c->vc.lock, flags);
 
-	/* Acknowledge interrupt */
-	writel(BCM2835_DMA_INT, c->chan_base + BCM2835_DMA_CS);
+	/*
+	 * Clear the INT flag to receive further interrupts. Keep the channel
+	 * active in case the descriptor is cyclic or in case the client has
+	 * already terminated the descriptor and issued a new one. (May happen
+	 * if this IRQ handler is threaded.) If the channel is finished, it
+	 * will remain idle despite the ACTIVE flag being set.
+	 */
+	writel(BCM2835_DMA_INT | BCM2835_DMA_ACTIVE,
+	       c->chan_base + BCM2835_DMA_CS);
 
 	d = c->desc;
 
@@ -484,11 +496,7 @@ static irqreturn_t bcm2835_dma_callback(int irq, void *data)
 		if (d->cyclic) {
 			/* call the cyclic callback */
 			vchan_cyclic_callback(&d->vd);
-
-			/* Keep the DMA engine running */
-			writel(BCM2835_DMA_ACTIVE,
-			       c->chan_base + BCM2835_DMA_CS);
-		} else {
+		} else if (!readl(c->chan_base + BCM2835_DMA_ADDR)) {
 			vchan_cookie_complete(&c->desc->vd);
 			bcm2835_dma_start_desc(c);
 		}
@@ -788,11 +796,7 @@ static int bcm2835_dma_terminate_all(struct dma_chan *chan)
 	list_del_init(&c->node);
 	spin_unlock(&d->lock);
 
-	/*
-	 * Stop DMA activity: we assume the callback will not be called
-	 * after bcm_dma_abort() returns (even if it does, it will see
-	 * c->desc is NULL and exit.)
-	 */
+	/* stop DMA activity */
 	if (c->desc) {
 		vchan_terminate_vdesc(&c->desc->vd);
 		c->desc = NULL;
@@ -800,8 +804,7 @@ static int bcm2835_dma_terminate_all(struct dma_chan *chan)
 
 		/* Wait for stopping */
 		while (--timeout) {
-			if (!(readl(c->chan_base + BCM2835_DMA_CS) &
-						BCM2835_DMA_ACTIVE))
+			if (!readl(c->chan_base + BCM2835_DMA_ADDR))
 				break;
 
 			cpu_relax();
-- 
2.20.1
