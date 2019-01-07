Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail.kernel.org ([198.145.29.99]:41472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725550AbfAGHBl (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 7 Jan 2019 02:01:41 -0500
Date: Mon, 7 Jan 2019 12:30:03 +0530
From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH 1/5] dmaengine: bcm2835: Fix interrupt race on RT
Message-ID: <20190107070003.GZ13372@vkoul-mobl.Dlink>
References: <cover.1545462045.git.lukas@wunner.de>
 <72be86ba05f9dde6cebeb4763da831f0d2f642d0.1545462045.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72be86ba05f9dde6cebeb4763da831f0d2f642d0.1545462045.git.lukas@wunner.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>, Frank Pavlic <f.pavlic@kunbus.de>, Martin Sperl <kernel@martin.sperl.org>, Florian Meier <florian.meier@koalo.de>, dmaengine@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, Tiejun Chen <tiejun.china@gmail.com>, linux-rt-users@vger.kernel.org

Hi Lukas,

On 22-12-18, 08:28, Lukas Wunner wrote:
> If IRQ handlers are threaded (either because CONFIG_PREEMPT_RT_BASE is
> enabled or "threadirqs" was passed on the command line) and if system
> load is sufficiently high that wakeup latency of IRQ threads degrades,
> SPI DMA transactions on the BCM2835 occasionally break like this:
> 
> ks8851 spi0.0: SPI transfer timed out
> bcm2835-dma 3f007000.dma: DMA transfer could not be terminated
> ks8851 spi0.0 eth2: ks8851_rdfifo: spi_sync() failed
> 
> The root cause is an assumption made by the DMA driver which is
> documented in a code comment in bcm2835_dma_terminate_all():
> 
> /*
>  * Stop DMA activity: we assume the callback will not be called
>  * after bcm_dma_abort() returns (even if it does, it will see
>  * c->desc is NULL and exit.)
>  */
> 
> That assumption falls apart if the IRQ handler bcm2835_dma_callback() is
> threaded:  A client may terminate a descriptor and issue a new one
> before the IRQ handler had a chance to run.  In fact the IRQ handler may

                                             ^^^
> miss an *arbitrary* number of descriptors.  The result is the following
                                          ^^^^^
this has double spaces in few places pls fix

> race condition:
> 
> 1. A descriptor finishes, its interrupt is deferred to the IRQ thread.
> 2. A client calls dma_terminate_async() which sets channel->desc = NULL.
> 3. The client issues a new descriptor.  Because channel->desc is NULL,
>    bcm2835_dma_issue_pending() immediately starts the descriptor.
> 4. Finally the IRQ thread runs and writes BCM2835_DMA_INT to the CS
>    register to acknowledge the interrupt.  This clears the ACTIVE flag,
>    so the newly issued descriptor is paused in the middle of the
>    transaction.  Because channel->desc is not NULL, the IRQ thread
>    finalizes the descriptor and tries to start the next one.
> 
> I see two possible solutions:  The first is to call synchronize_irq()
> in bcm2835_dma_issue_pending() to wait until the IRQ thread has
> finished before issuing a new descriptor.  The downside of this approach
> is unnecessary latency if clients desire rapidly terminating and
> re-issuing descriptors and don't have any use for an IRQ callback.
> (The SPI TX DMA channel is a case in point.)
> 
> A better alternative is to make the IRQ thread recognize that it has
> missed descriptors and avoid finalizing the newly issued descriptor.
> Therefore, only finalize a descriptor if the END flag is set in the CS
> register.  Clear the flag when starting a new descriptor.  Perform both
> operations under the vchan lock.  That way, there is practically no
> impact on latency and throughput if the client doesn't care for the
> interrupt:  Only minimal additional overhead is introduced as one
> further MMIO read is necessary per interrupt.
> 
> That MMIO read is needed to write the same value to the CS register that
> it currently has, thereby preserving the ACTIVE flag while clearing the
> INT and END flags.  Note that the transaction may finish between reading
> and writing the CS register, and in that case the write changes the
> ACTIVE flag from 0 to 1.  But that's harmless, the chip will notice that
> NEXTCONBK is 0 and self-clear the ACTIVE flag again.
> 
> Fixes: 96286b576690 ("dmaengine: Add support for BCM2835")
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org # v3.14+
> Cc: Frank Pavlic <f.pavlic@kunbus.de>
> Cc: Martin Sperl <kernel@martin.sperl.org>
> Cc: Florian Meier <florian.meier@koalo.de>
> ---
>  drivers/dma/bcm2835-dma.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
> index 1a44c8086d77..e94f41c56975 100644
> --- a/drivers/dma/bcm2835-dma.c
> +++ b/drivers/dma/bcm2835-dma.c
> @@ -456,7 +456,8 @@ static void bcm2835_dma_start_desc(struct bcm2835_chan *c)
>  	c->desc = d = to_bcm2835_dma_desc(&vd->tx);
>  
>  	writel(d->cb_list[0].paddr, c->chan_base + BCM2835_DMA_ADDR);
> -	writel(BCM2835_DMA_ACTIVE, c->chan_base + BCM2835_DMA_CS);
> +	writel(BCM2835_DMA_ACTIVE | BCM2835_DMA_END,
> +	       c->chan_base + BCM2835_DMA_CS);

can you explain this change please? so every descriptor is written with
BCM2835_DMA_END?


>  }
>  
>  static irqreturn_t bcm2835_dma_callback(int irq, void *data)
> @@ -464,6 +465,7 @@ static irqreturn_t bcm2835_dma_callback(int irq, void *data)
>  	struct bcm2835_chan *c = data;
>  	struct bcm2835_desc *d;
>  	unsigned long flags;
> +	u32 cs;
>  
>  	/* check the shared interrupt */
>  	if (c->irq_flags & IRQF_SHARED) {
> @@ -477,11 +479,17 @@ static irqreturn_t bcm2835_dma_callback(int irq, void *data)
>  	spin_lock_irqsave(&c->vc.lock, flags);
>  
>  	/* Acknowledge interrupt */
> -	writel(BCM2835_DMA_INT, c->chan_base + BCM2835_DMA_CS);
> +	cs = readl(c->chan_base + BCM2835_DMA_CS);
> +	writel(cs, c->chan_base + BCM2835_DMA_CS);

So idea is to ack the interrupts asserted while this is running, right?


>  
>  	d = c->desc;
>  
> -	if (d) {
> +	/*
> +	 * If this IRQ handler is threaded, clients may terminate descriptors
> +	 * and issue new ones before the IRQ handler runs.  Avoid finalizing
                                                        ^^^^
this as well..


> +	 * such a newly issued descriptor by checking the END flag.
> +	 */
> +	if (d && cs & BCM2835_DMA_END) {
>  		if (d->cyclic) {
>  			/* call the cyclic callback */
>  			vchan_cyclic_callback(&d->vd);
> @@ -789,11 +797,7 @@ static int bcm2835_dma_terminate_all(struct dma_chan *chan)
>  	list_del_init(&c->node);
>  	spin_unlock(&d->lock);
>  
> -	/*
> -	 * Stop DMA activity: we assume the callback will not be called
> -	 * after bcm_dma_abort() returns (even if it does, it will see
> -	 * c->desc is NULL and exit.)
> -	 */
> +	/* stop DMA activity */
>  	if (c->desc) {
>  		vchan_terminate_vdesc(&c->desc->vd);
>  		c->desc = NULL;
> -- 
> 2.19.2

-- 
~Vinod
