From: William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: Re: [PATCH v2 9/9] gpio: pci-idio-16: make use of raw_spinlock
 variants
Date: Wed, 22 Mar 2017 08:46:09 -0400
Message-ID: <20170322124609.GC22323@sophia>
References: <cover.1490135047.git.julia@ni.com>
 <a5d7b7ed45046ec6f7b5fbf9c284281e02204198.1490135047.git.julia@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        linux-gpio@vger.kernel.org
To: Julia Cartwright <julia@ni.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a5d7b7ed45046ec6f7b5fbf9c284281e02204198.1490135047.git.julia@ni.com>
Sender: linux-gpio-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, Mar 21, 2017 at 05:43:09PM -0500, Julia Cartwright wrote:
>The pci-idio-16 gpio driver currently implements an irq_chip for handling
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
> drivers/gpio/gpio-pci-idio-16.c | 28 ++++++++++++++--------------
> 1 file changed, 14 insertions(+), 14 deletions(-)
>
>diff --git a/drivers/gpio/gpio-pci-idio-16.c b/drivers/gpio/gpio-pci-idio-16.c
>index 269ab628634b..7de4f6a2cb49 100644
>--- a/drivers/gpio/gpio-pci-idio-16.c
>+++ b/drivers/gpio/gpio-pci-idio-16.c
>@@ -59,7 +59,7 @@ struct idio_16_gpio_reg {
>  */
> struct idio_16_gpio {
> 	struct gpio_chip chip;
>-	spinlock_t lock;
>+	raw_spinlock_t lock;
> 	struct idio_16_gpio_reg __iomem *reg;
> 	unsigned long irq_mask;
> };
>@@ -121,7 +121,7 @@ static void idio_16_gpio_set(struct gpio_chip *chip, unsigned int offset,
> 	} else
> 		base = &idio16gpio->reg->out0_7;
> 
>-	spin_lock_irqsave(&idio16gpio->lock, flags);
>+	raw_spin_lock_irqsave(&idio16gpio->lock, flags);
> 
> 	if (value)
> 		out_state = ioread8(base) | mask;
>@@ -130,7 +130,7 @@ static void idio_16_gpio_set(struct gpio_chip *chip, unsigned int offset,
> 
> 	iowrite8(out_state, base);
> 
>-	spin_unlock_irqrestore(&idio16gpio->lock, flags);
>+	raw_spin_unlock_irqrestore(&idio16gpio->lock, flags);
> }
> 
> static void idio_16_gpio_set_multiple(struct gpio_chip *chip,
>@@ -140,7 +140,7 @@ static void idio_16_gpio_set_multiple(struct gpio_chip *chip,
> 	unsigned long flags;
> 	unsigned int out_state;
> 
>-	spin_lock_irqsave(&idio16gpio->lock, flags);
>+	raw_spin_lock_irqsave(&idio16gpio->lock, flags);
> 
> 	/* process output lines 0-7 */
> 	if (*mask & 0xFF) {
>@@ -160,7 +160,7 @@ static void idio_16_gpio_set_multiple(struct gpio_chip *chip,
> 		iowrite8(out_state, &idio16gpio->reg->out8_15);
> 	}
> 
>-	spin_unlock_irqrestore(&idio16gpio->lock, flags);
>+	raw_spin_unlock_irqrestore(&idio16gpio->lock, flags);
> }
> 
> static void idio_16_irq_ack(struct irq_data *data)
>@@ -177,11 +177,11 @@ static void idio_16_irq_mask(struct irq_data *data)
> 	idio16gpio->irq_mask &= ~mask;
> 
> 	if (!idio16gpio->irq_mask) {
>-		spin_lock_irqsave(&idio16gpio->lock, flags);
>+		raw_spin_lock_irqsave(&idio16gpio->lock, flags);
> 
> 		iowrite8(0, &idio16gpio->reg->irq_ctl);
> 
>-		spin_unlock_irqrestore(&idio16gpio->lock, flags);
>+		raw_spin_unlock_irqrestore(&idio16gpio->lock, flags);
> 	}
> }
> 
>@@ -196,11 +196,11 @@ static void idio_16_irq_unmask(struct irq_data *data)
> 	idio16gpio->irq_mask |= mask;
> 
> 	if (!prev_irq_mask) {
>-		spin_lock_irqsave(&idio16gpio->lock, flags);
>+		raw_spin_lock_irqsave(&idio16gpio->lock, flags);
> 
> 		ioread8(&idio16gpio->reg->irq_ctl);
> 
>-		spin_unlock_irqrestore(&idio16gpio->lock, flags);
>+		raw_spin_unlock_irqrestore(&idio16gpio->lock, flags);
> 	}
> }
> 
>@@ -229,11 +229,11 @@ static irqreturn_t idio_16_irq_handler(int irq, void *dev_id)
> 	struct gpio_chip *const chip = &idio16gpio->chip;
> 	int gpio;
> 
>-	spin_lock(&idio16gpio->lock);
>+	raw_spin_lock(&idio16gpio->lock);
> 
> 	irq_status = ioread8(&idio16gpio->reg->irq_status);
> 
>-	spin_unlock(&idio16gpio->lock);
>+	raw_spin_unlock(&idio16gpio->lock);
> 
> 	/* Make sure our device generated IRQ */
> 	if (!(irq_status & 0x3) || !(irq_status & 0x4))
>@@ -242,12 +242,12 @@ static irqreturn_t idio_16_irq_handler(int irq, void *dev_id)
> 	for_each_set_bit(gpio, &idio16gpio->irq_mask, chip->ngpio)
> 		generic_handle_irq(irq_find_mapping(chip->irqdomain, gpio));
> 
>-	spin_lock(&idio16gpio->lock);
>+	raw_spin_lock(&idio16gpio->lock);
> 
> 	/* Clear interrupt */
> 	iowrite8(0, &idio16gpio->reg->in0_7);
> 
>-	spin_unlock(&idio16gpio->lock);
>+	raw_spin_unlock(&idio16gpio->lock);
> 
> 	return IRQ_HANDLED;
> }
>@@ -302,7 +302,7 @@ static int idio_16_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> 	idio16gpio->chip.set = idio_16_gpio_set;
> 	idio16gpio->chip.set_multiple = idio_16_gpio_set_multiple;
> 
>-	spin_lock_init(&idio16gpio->lock);
>+	raw_spin_lock_init(&idio16gpio->lock);
> 
> 	err = devm_gpiochip_add_data(dev, &idio16gpio->chip, idio16gpio);
> 	if (err) {
>-- 
>2.12.0
>
