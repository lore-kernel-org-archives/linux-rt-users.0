Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from bmailout2.hostsharing.net ([83.223.90.240]:44149 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbfAQI07 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 17 Jan 2019 03:26:59 -0500
Date: Thu, 17 Jan 2019 09:26:56 +0100
From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH 1/5] dmaengine: bcm2835: Fix interrupt race on RT
Message-ID: <20190117082656.isv3ld2jg3jyzogf@wunner.de>
References: <cover.1545462045.git.lukas@wunner.de>
 <72be86ba05f9dde6cebeb4763da831f0d2f642d0.1545462045.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72be86ba05f9dde6cebeb4763da831f0d2f642d0.1545462045.git.lukas@wunner.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Vinod Koul <vkoul@kernel.org>, Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>
Cc: Frank Pavlic <f.pavlic@kunbus.de>, Martin Sperl <kernel@martin.sperl.org>, Florian Meier <florian.meier@koalo.de>, dmaengine@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, Tiejun Chen <tiejun.china@gmail.com>, linux-rt-users@vger.kernel.org

On Sat, Dec 22, 2018 at 08:28:45AM +0100, Lukas Wunner wrote:
> That MMIO read is needed to write the same value to the CS register that
> it currently has, thereby preserving the ACTIVE flag while clearing the
> INT and END flags.  Note that the transaction may finish between reading
> and writing the CS register, and in that case the write changes the
> ACTIVE flag from 0 to 1.  But that's harmless, the chip will notice that
> NEXTCONBK is 0 and self-clear the ACTIVE flag again.

Further experimentation has shown that the chip does not self-clear the
ACTIVE flag if it is set on an idle channel, contrary to what I have
written above. Consequently that flag cannot be used to determine idleness
of a channel reliably. A workaround is to check whether the register
containing the current control block's address is zero. I have amended
the patch accordingly and it is currently undergoing stresstesting until
Monday.  So I should be able to post an updated version of the series
next week.

I have also updated the patch to fix the following remaining race:

> @@ -477,11 +479,17 @@ static irqreturn_t bcm2835_dma_callback(int irq, void *data)
>  	spin_lock_irqsave(&c->vc.lock, flags);
>  
>  	/* Acknowledge interrupt */
> -	writel(BCM2835_DMA_INT, c->chan_base + BCM2835_DMA_CS);
> +	cs = readl(c->chan_base + BCM2835_DMA_CS);
> +	writel(cs, c->chan_base + BCM2835_DMA_CS);
>  
>  	d = c->desc;
>  
> -	if (d) {
> +	/*
> +	 * If this IRQ handler is threaded, clients may terminate descriptors
> +	 * and issue new ones before the IRQ handler runs.  Avoid finalizing
> +	 * such a newly issued descriptor by checking the END flag.
> +	 */
> +	if (d && cs & BCM2835_DMA_END) {
>  		if (d->cyclic) {
>  			/* call the cyclic callback */
>  			vchan_cyclic_callback(&d->vd);

The descriptor may be finished between the read and the write of the
CS register, and in that case the interrupt for the finished descriptor
will be acknowledged but the descriptor will not be finalized because
END was not yet set when the register was read. I haven't seen this
race in the real world but it's definitely not correct and I've fixed
it as well for v2.

Thanks,

Lukas
