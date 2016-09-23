From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: Got stacktrace "irq 17: nobody cared" on Intel GalileoGen2 with
 4.6.7-rt13
Date: Fri, 23 Sep 2016 17:39:38 +0200
Message-ID: <ea685403-9c42-95ce-9528-3dce338a98d7@siemens.com>
References: <1474532371.10922.50.camel@denx.de>
 <b8c6cd44-4a29-fe84-af0d-747584c04ad0@siemens.com>
 <20160922134912.6ttkfpphn2ga4z22@linutronix.de>
 <1474553779.10922.87.camel@denx.de>
 <20160922144122.ywq7p27fcxlplo6d@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Claudius Heine <ch@denx.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from david.siemens.de ([192.35.17.14]:51853 "EHLO david.siemens.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965902AbcIWPjm (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 23 Sep 2016 11:39:42 -0400
In-Reply-To: <20160922144122.ywq7p27fcxlplo6d@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2016-09-22 16:41, Sebastian Andrzej Siewior wrote:
> On 2016-09-22 16:16:19 [+0200], Claudius Heine wrote:
>> Thanks for your help, but I am sorry to disappoint:
> 
> I am surprised. You have UART and SPI sharing the interrupt and from
> output it is SPI that does not cooperate.
> Disable SPI and the warning/error should go.
> Maybe RT hits a condition the SPI driver return IRQ_NONE instead of
> doing something.

It does, but I'm not yet understanding why (the driver's status register
actually does not list any reasons, but when disabling the device, the
problem is gone). I'll try to dig deeper, just to exclude a generic -rt
problem.


However, I found a workaround for our target, with positive side effect
(one slow legacy INT less, one shared INT less - we could do more):

diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
index 520ed1d..4ec458f 100644
--- a/drivers/spi/spi-pxa2xx-pci.c
+++ b/drivers/spi/spi-pxa2xx-pci.c
@@ -168,6 +168,7 @@ static int pxa2xx_spi_pci_probe(struct pci_dev *dev,
 		dev_err(&dev->dev, "failed to ioremap() registers\n");
 		return -EIO;
 	}
+	pci_enable_msi(dev);
 	ssp->irq = dev->irq;
 	ssp->port_id = (c->port_id >= 0) ? c->port_id : dev->devfn;
 	ssp->type = c->type;


As you've written that code: Any reason why we should refrain from doing
that upstream?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux
