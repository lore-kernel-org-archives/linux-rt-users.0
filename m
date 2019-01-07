Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from bmailout2.hostsharing.net ([83.223.90.240]:46771 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbfAGIcP (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 7 Jan 2019 03:32:15 -0500
Date: Mon, 7 Jan 2019 09:32:12 +0100
From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH 1/5] dmaengine: bcm2835: Fix interrupt race on RT
Message-ID: <20190107083212.ca2usaysp4xyrjhc@wunner.de>
References: <cover.1545462045.git.lukas@wunner.de>
 <72be86ba05f9dde6cebeb4763da831f0d2f642d0.1545462045.git.lukas@wunner.de>
 <20190107070003.GZ13372@vkoul-mobl.Dlink>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190107070003.GZ13372@vkoul-mobl.Dlink>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>, Frank Pavlic <f.pavlic@kunbus.de>, Martin Sperl <kernel@martin.sperl.org>, Florian Meier <florian.meier@koalo.de>, dmaengine@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, Tiejun Chen <tiejun.china@gmail.com>, linux-rt-users@vger.kernel.org

On Mon, Jan 07, 2019 at 12:30:03PM +0530, Vinod Koul wrote:
> On 22-12-18, 08:28, Lukas Wunner wrote:
> > before the IRQ handler had a chance to run.  In fact the IRQ handler may
>                                              ^^^
> > miss an *arbitrary* number of descriptors.  The result is the following
>                                           ^^^^^
> this has double spaces in few places pls fix

That was intentional.  Bjorn Helgaas has established double spaces to
separate sentences in the PCI subsystem, both in commit messages and
code comments.  The rationale he has given:

   "Only habit because my eighth-grade typing teacher in 1979 did it that
    way, and (I think) vim does it that way by default."
    https://patchwork.kernel.org/patch/8941601/

Rafael Wysocki, myself and others have adopted this style.  However
I'll gladly omit the double spaces if that's the preferred style in
the DMA subsystem.


> > @@ -456,7 +456,8 @@ static void bcm2835_dma_start_desc(struct bcm2835_chan *c)
> >  	c->desc = d = to_bcm2835_dma_desc(&vd->tx);
> >  
> >  	writel(d->cb_list[0].paddr, c->chan_base + BCM2835_DMA_ADDR);
> > -	writel(BCM2835_DMA_ACTIVE, c->chan_base + BCM2835_DMA_CS);
> > +	writel(BCM2835_DMA_ACTIVE | BCM2835_DMA_END,
> > +	       c->chan_base + BCM2835_DMA_CS);
> 
> can you explain this change please? so every descriptor is written with
> BCM2835_DMA_END?

The BCM2835_DMA_END flag is of type W1C (write 1 to clear).  The above
change ensures that the END flag is cleared when a new descriptor is
started.  Once the DMA engine has finished that descriptor, it will
automatically set the flag again.

This allows the IRQ handler to recognize that it has missed descriptors
and that a new descriptor is currently processed by the DMA engine.
The IRQ handler will then refrain from finalizing that in-flight
descriptor.

I did explain this change in the commit message:

   "Therefore, only finalize a descriptor if the END flag is set in the CS
    register.  Clear the flag when starting a new descriptor.  Perform both
    operations under the vchan lock."


> > @@ -477,11 +479,17 @@ static irqreturn_t bcm2835_dma_callback(int irq, void *data)
> >  	spin_lock_irqsave(&c->vc.lock, flags);
> >  
> >  	/* Acknowledge interrupt */
> > -	writel(BCM2835_DMA_INT, c->chan_base + BCM2835_DMA_CS);
> > +	cs = readl(c->chan_base + BCM2835_DMA_CS);
> > +	writel(cs, c->chan_base + BCM2835_DMA_CS);
> 
> So idea is to ack the interrupts asserted while this is running, right?

The BCM2835_DMA_INT flag is likewise of type W1C.  By writing the
same value to the CS register that it currently has, the interrupt
is acknowledged (INT flag is cleared) but the ACTIVE flag is preserved.

That way, if a new descriptor is currently processed by the DMA engine,
that descriptor is left running.

(The BCM2835_DMA_END is also cleared, but that's not important.)

The above change is likewise explained in the commit message:

   "Only minimal additional overhead is introduced as one
    further MMIO read is necessary per interrupt.

    That MMIO read is needed to write the same value to the CS register that
    it currently has, thereby preserving the ACTIVE flag while clearing the
    INT and END flags."

Thanks,

Lukas
