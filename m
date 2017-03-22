From: William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: Re: [PATCH v2 8/9] gpio: 104-idio-16: make use of raw_spinlock
 variants
Date: Wed, 22 Mar 2017 08:45:22 -0400
Message-ID: <20170322124522.GB22323@sophia>
References: <cover.1490135047.git.julia@ni.com>
 <9b15e28c4aeeade4b44e9a2bb06c12ded5d0990b.1490135047.git.julia@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        linux-gpio@vger.kernel.org
To: Julia Cartwright <julia@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yw0-f193.google.com ([209.85.161.193]:35097 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759189AbdCVMsW (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 22 Mar 2017 08:48:22 -0400
Content-Disposition: inline
In-Reply-To: <9b15e28c4aeeade4b44e9a2bb06c12ded5d0990b.1490135047.git.julia@ni.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Mar 21, 2017 at 05:43:08PM -0500, Julia Cartwright wrote:
>The 104-idio-16 gpio driver currently implements an irq_chip for handling
>interrupts; due to how irq_chip handling is done, it's necessary for the
>irq_chip methods to be invoked from hardirq context, even on a a
>real-time kernel.  Because the spinlock_t type becomes a "sleeping"
>spinlock w/ RT kernels, it is not suitable to be used with irq_chips.
>
>A quick audit of the operations under the lock reveal that they do only
>minimal, bounded work, and are therefore safe to do under a raw spinlock.
>
>Signed-off-by: Julia Cartwright <julia@ni.com>

Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>

>---
>New patch as of v2 of series.
>
> drivers/gpio/gpio-104-idio-16.c | 24 ++++++++++++------------
> 1 file changed, 12 insertions(+), 12 deletions(-)
>
>diff --git a/drivers/gpio/gpio-104-idio-16.c b/drivers/gpio/gpio-104-idio-16.c
>index 7053cf736648..5281e1cedb01 100644
>--- a/drivers/gpio/gpio-104-idio-16.c
>+++ b/drivers/gpio/gpio-104-idio-16.c
>@@ -50,7 +50,7 @@ MODULE_PARM_DESC(irq, "ACCES 104-IDIO-16 interrupt line numbers");
>  */
> struct idio_16_gpio {
> 	struct gpio_chip chip;
>-	spinlock_t lock;
>+	raw_spinlock_t lock;
> 	unsigned long irq_mask;
> 	unsigned base;
> 	unsigned out_state;
>@@ -99,7 +99,7 @@ static void idio_16_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
> 	if (offset > 15)
> 		return;
> 
>-	spin_lock_irqsave(&idio16gpio->lock, flags);
>+	raw_spin_lock_irqsave(&idio16gpio->lock, flags);
> 
> 	if (value)
> 		idio16gpio->out_state |= mask;
>@@ -111,7 +111,7 @@ static void idio_16_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
> 	else
> 		outb(idio16gpio->out_state, idio16gpio->base);
> 
>-	spin_unlock_irqrestore(&idio16gpio->lock, flags);
>+	raw_spin_unlock_irqrestore(&idio16gpio->lock, flags);
> }
> 
> static void idio_16_gpio_set_multiple(struct gpio_chip *chip,
>@@ -120,7 +120,7 @@ static void idio_16_gpio_set_multiple(struct gpio_chip *chip,
> 	struct idio_16_gpio *const idio16gpio = gpiochip_get_data(chip);
> 	unsigned long flags;
> 
>-	spin_lock_irqsave(&idio16gpio->lock, flags);
>+	raw_spin_lock_irqsave(&idio16gpio->lock, flags);
> 
> 	idio16gpio->out_state &= ~*mask;
> 	idio16gpio->out_state |= *mask & *bits;
>@@ -130,7 +130,7 @@ static void idio_16_gpio_set_multiple(struct gpio_chip *chip,
> 	if ((*mask >> 8) & 0xFF)
> 		outb(idio16gpio->out_state >> 8, idio16gpio->base + 4);
> 
>-	spin_unlock_irqrestore(&idio16gpio->lock, flags);
>+	raw_spin_unlock_irqrestore(&idio16gpio->lock, flags);
> }
> 
> static void idio_16_irq_ack(struct irq_data *data)
>@@ -147,11 +147,11 @@ static void idio_16_irq_mask(struct irq_data *data)
> 	idio16gpio->irq_mask &= ~mask;
> 
> 	if (!idio16gpio->irq_mask) {
>-		spin_lock_irqsave(&idio16gpio->lock, flags);
>+		raw_spin_lock_irqsave(&idio16gpio->lock, flags);
> 
> 		outb(0, idio16gpio->base + 2);
> 
>-		spin_unlock_irqrestore(&idio16gpio->lock, flags);
>+		raw_spin_unlock_irqrestore(&idio16gpio->lock, flags);
> 	}
> }
> 
>@@ -166,11 +166,11 @@ static void idio_16_irq_unmask(struct irq_data *data)
> 	idio16gpio->irq_mask |= mask;
> 
> 	if (!prev_irq_mask) {
>-		spin_lock_irqsave(&idio16gpio->lock, flags);
>+		raw_spin_lock_irqsave(&idio16gpio->lock, flags);
> 
> 		inb(idio16gpio->base + 2);
> 
>-		spin_unlock_irqrestore(&idio16gpio->lock, flags);
>+		raw_spin_unlock_irqrestore(&idio16gpio->lock, flags);
> 	}
> }
> 
>@@ -201,11 +201,11 @@ static irqreturn_t idio_16_irq_handler(int irq, void *dev_id)
> 	for_each_set_bit(gpio, &idio16gpio->irq_mask, chip->ngpio)
> 		generic_handle_irq(irq_find_mapping(chip->irqdomain, gpio));
> 
>-	spin_lock(&idio16gpio->lock);
>+	raw_spin_lock(&idio16gpio->lock);
> 
> 	outb(0, idio16gpio->base + 1);
> 
>-	spin_unlock(&idio16gpio->lock);
>+	raw_spin_unlock(&idio16gpio->lock);
> 
> 	return IRQ_HANDLED;
> }
>@@ -249,7 +249,7 @@ static int idio_16_probe(struct device *dev, unsigned int id)
> 	idio16gpio->base = base[id];
> 	idio16gpio->out_state = 0xFFFF;
> 
>-	spin_lock_init(&idio16gpio->lock);
>+	raw_spin_lock_init(&idio16gpio->lock);
> 
> 	err = devm_gpiochip_add_data(dev, &idio16gpio->chip, idio16gpio);
> 	if (err) {
>-- 
>2.12.0
>
