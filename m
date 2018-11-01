Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from bmailout2.hostsharing.net ([83.223.90.240]:49257 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728627AbeKBAGx (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 1 Nov 2018 20:06:53 -0400
Date: Thu, 1 Nov 2018 16:03:30 +0100
From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH] pinctrl: bcm2835: Use raw spinlock for RT compatibility
Message-ID: <20181101150330.u3k65nphjiap57wt@wunner.de>
References: <d71c523a8a0af5628da59a44223a357102c2a193.1540627754.git.lukas@wunner.de>
 <CACRpkdZfciHUrx9YTFsYyKEEi6RMDeWxYqe7JPnJJipWOyUJ6A@mail.gmail.com>
 <20181029144507.GB9137@jcartwri.amer.corp.natinst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181029144507.GB9137@jcartwri.amer.corp.natinst.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Julia Cartwright <julia@ni.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>, Mathias Duckeck <m.duckeck@kunbus.de>, "tiejun.china@gmail.com" <tiejun.china@gmail.com>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>, "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>, Simon Arlott <simon@fire.lp0.eu>, Chris Boot <bootc@bootc.net>, Stephen Warren <swarren@wwwdotorg.org>

[cc += Simon Arlott, Chris Boot, Stephen Warren]

On Mon, Oct 29, 2018 at 02:45:08PM +0000, Julia Cartwright wrote:
> On Sat, Oct 27, 2018 at 10:15 AM Lukas Wunner <lukas@wunner.de> wrote:
> > The BCM2835 pinctrl driver acquires a spinlock in its ->irq_enable,
> > ->irq_disable and ->irq_set_type callbacks.  Spinlocks become sleeping
> > locks with CONFIG_PREEMPT_RT_FULL=y, therefore invocation of one of the
> > callbacks in atomic context may cause a hard lockup if at least two GPIO
> > pins in the same bank are used as interrupts.  The issue doesn't occur
> > with just a single interrupt pin per bank because the lock is never
> > contended.  I'm experiencing such lockups with GPIO 8 and 28 used as
> > level-triggered interrupts, i.e. with ->irq_disable being invoked on
> > reception of every IRQ.
> >
> > The critical section protected by the spinlock is very small (one bitop
> > and one RMW of an MMIO register), hence converting to a raw spinlock
> > seems a better trade-off than converting the driver to threaded IRQ
> > handling (which would increase latency to handle an interrupt).
> 
> The change seems reasonable to me.
> 
> As a side note: the bitops used to manage the enabled_irq_map are the
> atomic variants (set_bit, etc), is this actually necessary?  In other
> words, are they ever accessed outside of the spinlock?

There's a single occurrence of enabled_irq_map being used outside the
spinlock, it's in the IRQ handler itself, bcm2835_gpio_irq_handle_bank():

	events = bcm2835_gpio_rd(pc, GPEDS0 + bank * 4);
	events &= mask;
	events &= pc->enabled_irq_map[bank];

However this use of enabled_irq_map seems gratuitous to me:  Once the IRQ
has been disabled by bcm2835_gpio_irq_disable(), its bit should no longer
be set in the GPEDS0 / GPEDS1 register.  Vice-versa on enablement.  So why
does the IRQ handler take enabled_irq_map into consideration at all?

Maybe this is a remnant of an older version of the driver, so adding the
authors of e1b2dc70cd5b (which introduced the driver) to cc.

So what I have in mind is removal of enabled_irq_map from the IRQ handler
plus use of non-atomic bitops.  I'll give the patch below a spin when I'm
back in the office on Monday to test if it breaks anything.

Thanks,

Lukas

-- >8 --
diff --git a/drivers/pinctrl/bcm/pinctrl-bcm2835.c b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
index b77195a..72d7aec 100644
--- a/drivers/pinctrl/bcm/pinctrl-bcm2835.c
+++ b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
@@ -377,7 +377,6 @@ static void bcm2835_gpio_irq_handle_bank(struct bcm2835_pinctrl *pc,
 
 	events = bcm2835_gpio_rd(pc, GPEDS0 + bank * 4);
 	events &= mask;
-	events &= pc->enabled_irq_map[bank];
 	for_each_set_bit(offset, &events, 32) {
 		gpio = (32 * bank) + offset;
 		generic_handle_irq(irq_linear_revmap(pc->gpio_chip.irqdomain,
@@ -473,7 +472,7 @@ static void bcm2835_gpio_irq_enable(struct irq_data *data)
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&pc->irq_lock[bank], flags);
-	set_bit(offset, &pc->enabled_irq_map[bank]);
+	__set_bit(offset, &pc->enabled_irq_map[bank]);
 	bcm2835_gpio_irq_config(pc, gpio, true);
 	raw_spin_unlock_irqrestore(&pc->irq_lock[bank], flags);
 }
@@ -491,7 +490,7 @@ static void bcm2835_gpio_irq_disable(struct irq_data *data)
 	bcm2835_gpio_irq_config(pc, gpio, false);
 	/* Clear events that were latched prior to clearing event sources */
 	bcm2835_gpio_set_bit(pc, GPEDS0, gpio);
-	clear_bit(offset, &pc->enabled_irq_map[bank]);
+	__clear_bit(offset, &pc->enabled_irq_map[bank]);
 	raw_spin_unlock_irqrestore(&pc->irq_lock[bank], flags);
 }
 
