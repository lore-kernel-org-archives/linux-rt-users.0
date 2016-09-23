From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Got stacktrace "irq 17: nobody cared" on Intel GalileoGen2 with
 4.6.7-rt13
Date: Fri, 23 Sep 2016 18:00:17 +0200
Message-ID: <20160923160017.fiajrhsyzhvgi6hz@linutronix.de>
References: <1474532371.10922.50.camel@denx.de>
 <b8c6cd44-4a29-fe84-af0d-747584c04ad0@siemens.com>
 <20160922134912.6ttkfpphn2ga4z22@linutronix.de>
 <1474553779.10922.87.camel@denx.de>
 <20160922144122.ywq7p27fcxlplo6d@linutronix.de>
 <ea685403-9c42-95ce-9528-3dce338a98d7@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Claudius Heine <ch@denx.de>, linux-rt-users@vger.kernel.org
To: Jan Kiszka <jan.kiszka@siemens.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:42130 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034655AbcIWQAY (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 23 Sep 2016 12:00:24 -0400
Content-Disposition: inline
In-Reply-To: <ea685403-9c42-95ce-9528-3dce338a98d7@siemens.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2016-09-23 17:39:38 [+0200], Jan Kiszka wrote:
> diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
> index 520ed1d..4ec458f 100644
> --- a/drivers/spi/spi-pxa2xx-pci.c
> +++ b/drivers/spi/spi-pxa2xx-pci.c
> @@ -168,6 +168,7 @@ static int pxa2xx_spi_pci_probe(struct pci_dev *dev,
>  		dev_err(&dev->dev, "failed to ioremap() registers\n");
>  		return -EIO;
>  	}
> +	pci_enable_msi(dev);
>  	ssp->irq = dev->irq;
>  	ssp->port_id = (c->port_id >= 0) ? c->port_id : dev->devfn;
>  	ssp->type = c->type;
> 
> 
> As you've written that code: Any reason why we should refrain from doing
> that upstream?

I don't see why this pops up in -RT and not in !RT and this cures it. I
remember that the UART on CE4100 went crazy if you used inb/outb once
you enabled interrupts in multi mode (PCI A/B/C/D instead only A).
Switching over to MMIO access fixed that.

So. Enabling MSI unconditionally isn't usually that bad. If the HW does
not advertise MSI then nothing happens. However there is faulty HW that
advertises MSI and after enabling it you get no interrupts (grep for
XHCI_BROKEN_MSI if you want an example). I would suggest to enable it
and if people complain add an exception list (like XHCI does).
And you might want to disable MSI (but it might happen if you disable /
leave the PCI).

> Jan
> 

Sebastian
