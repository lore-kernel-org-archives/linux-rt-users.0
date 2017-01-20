From: Brian Wrenn <dcbrianw@gmail.com>
Subject: Re: [PATCH] pinctrl: qcom: Use raw spinlock variants
Date: Fri, 20 Jan 2017 12:07:55 -0500
Message-ID: <CAEYdEeQ0QH9RAc1pxuMZk7=tjYmmj-d9+tn5_yAr_3G=9=ON5g@mail.gmail.com>
References: <CAEYdEeQ63HZzi8yJk4eAAa=XeEeOFR_wqnL_PW3d6Nt5N955pQ@mail.gmail.com>
 <20170117201906.GB1335@jcartwri.amer.corp.natinst.com> <CACRpkdbxZw6QLKA0A8b=VuHmtkSHFywDT19pFZ3ioQ0kA=3VNg@mail.gmail.com>
 <CAEYdEeQ00axyXD0noFJDsPxHeMb0qhC6jTG4Lee7En+cOqHkXw@mail.gmail.com>
 <CAEYdEeR1Z0RWkGJ1PUyMujZf3kHqxZE-B6yHpXcNkcXVJg75Mg@mail.gmail.com> <20170120161347.GI1335@jcartwri.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-rt-users@vger.kernel.org,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
To: Julia Cartwright <julia@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:34934 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751314AbdATRII (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 20 Jan 2017 12:08:08 -0500
In-Reply-To: <20170120161347.GI1335@jcartwri.amer.corp.natinst.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Julia and others,

I'm happy to contribute and am grateful for the assistance.  It looks
like we'll be using PREEMPT RT for sometime to come from now onward,
so I may be reaching out for help again in the future.

Best Regards!
-Brian

On Fri, Jan 20, 2017 at 11:13 AM, Julia Cartwright <julia@ni.com> wrote:
> The MSM pinctrl driver currently implements an irq_chip for handling
> GPIO interrupts; due to how irq_chip handling is done, it's necessary
> for the irq_chip methods to be invoked from hardirq context, even on a
> a real-time kernel.  Because the spinlock_t type becomes a "sleeping"
> spinlock w/ RT kernels, it is not suitable to be used with irq_chips.
>
> A quick audit of the operations under the lock reveal that they do only
> minimal, bounded work, and are therefore safe to do under a raw
> spinlock.
>
> On real-time kernels, this fixes an OOPs which looks like the following,
> as reported by Brian Wrenn:
>
>     kernel BUG at kernel/locking/rtmutex.c:1014!
>     Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
>     Modules linked in: spidev_irq(O) smsc75xx wcn36xx [last unloaded: spidev]
>     CPU: 0 PID: 1163 Comm: irq/144-mmc0 Tainted: G        W  O    4.4.9-linaro-lt-qcom #1
>     PC is at rt_spin_lock_slowlock+0x80/0x2d8
>     LR is at rt_spin_lock_slowlock+0x68/0x2d8
>     [..]
>   Call trace:
>     rt_spin_lock_slowlock
>     rt_spin_lock
>     msm_gpio_irq_ack
>     handle_edge_irq
>     generic_handle_irq
>     msm_gpio_irq_handler
>     generic_handle_irq
>     __handle_domain_irq
>     gic_handle_irq
>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Reported-by: Brian Wrenn <dcbrianw@gmail.com>
> Tested-by: Brian Wrenn <dcbrianw@gmail.com>
> Signed-off-by: Julia Cartwright <julia@ni.com>
> ---
> Thanks for the test, Brian!  I've turned your response into a Tested-by.
>
> Linus-  on quick glance, this is but one of many drivers which suffer
> the same class of problem :(.  I'm wondering if we can do some
> coccinelle magic to check specifically drivers which implement irq_chip
> callbacks and use spin_locks...
>
>    Julia
>
>  drivers/pinctrl/qcom/pinctrl-msm.c | 48 +++++++++++++++++++-------------------
>  1 file changed, 24 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
> index 775c883..f8e9e1c 100644
> --- a/drivers/pinctrl/qcom/pinctrl-msm.c
> +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
> @@ -61,7 +61,7 @@ struct msm_pinctrl {
>         struct notifier_block restart_nb;
>         int irq;
>
> -       spinlock_t lock;
> +       raw_spinlock_t lock;
>
>         DECLARE_BITMAP(dual_edge_irqs, MAX_NR_GPIO);
>         DECLARE_BITMAP(enabled_irqs, MAX_NR_GPIO);
> @@ -153,14 +153,14 @@ static int msm_pinmux_set_mux(struct pinctrl_dev *pctldev,
>         if (WARN_ON(i == g->nfuncs))
>                 return -EINVAL;
>
> -       spin_lock_irqsave(&pctrl->lock, flags);
> +       raw_spin_lock_irqsave(&pctrl->lock, flags);
>
>         val = readl(pctrl->regs + g->ctl_reg);
>         val &= ~mask;
>         val |= i << g->mux_bit;
>         writel(val, pctrl->regs + g->ctl_reg);
>
> -       spin_unlock_irqrestore(&pctrl->lock, flags);
> +       raw_spin_unlock_irqrestore(&pctrl->lock, flags);
>
>         return 0;
>  }
> @@ -323,14 +323,14 @@ static int msm_config_group_set(struct pinctrl_dev *pctldev,
>                         break;
>                 case PIN_CONFIG_OUTPUT:
>                         /* set output value */
> -                       spin_lock_irqsave(&pctrl->lock, flags);
> +                       raw_spin_lock_irqsave(&pctrl->lock, flags);
>                         val = readl(pctrl->regs + g->io_reg);
>                         if (arg)
>                                 val |= BIT(g->out_bit);
>                         else
>                                 val &= ~BIT(g->out_bit);
>                         writel(val, pctrl->regs + g->io_reg);
> -                       spin_unlock_irqrestore(&pctrl->lock, flags);
> +                       raw_spin_unlock_irqrestore(&pctrl->lock, flags);
>
>                         /* enable output */
>                         arg = 1;
> @@ -351,12 +351,12 @@ static int msm_config_group_set(struct pinctrl_dev *pctldev,
>                         return -EINVAL;
>                 }
>
> -               spin_lock_irqsave(&pctrl->lock, flags);
> +               raw_spin_lock_irqsave(&pctrl->lock, flags);
>                 val = readl(pctrl->regs + g->ctl_reg);
>                 val &= ~(mask << bit);
>                 val |= arg << bit;
>                 writel(val, pctrl->regs + g->ctl_reg);
> -               spin_unlock_irqrestore(&pctrl->lock, flags);
> +               raw_spin_unlock_irqrestore(&pctrl->lock, flags);
>         }
>
>         return 0;
> @@ -384,13 +384,13 @@ static int msm_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
>
>         g = &pctrl->soc->groups[offset];
>
> -       spin_lock_irqsave(&pctrl->lock, flags);
> +       raw_spin_lock_irqsave(&pctrl->lock, flags);
>
>         val = readl(pctrl->regs + g->ctl_reg);
>         val &= ~BIT(g->oe_bit);
>         writel(val, pctrl->regs + g->ctl_reg);
>
> -       spin_unlock_irqrestore(&pctrl->lock, flags);
> +       raw_spin_unlock_irqrestore(&pctrl->lock, flags);
>
>         return 0;
>  }
> @@ -404,7 +404,7 @@ static int msm_gpio_direction_output(struct gpio_chip *chip, unsigned offset, in
>
>         g = &pctrl->soc->groups[offset];
>
> -       spin_lock_irqsave(&pctrl->lock, flags);
> +       raw_spin_lock_irqsave(&pctrl->lock, flags);
>
>         val = readl(pctrl->regs + g->io_reg);
>         if (value)
> @@ -417,7 +417,7 @@ static int msm_gpio_direction_output(struct gpio_chip *chip, unsigned offset, in
>         val |= BIT(g->oe_bit);
>         writel(val, pctrl->regs + g->ctl_reg);
>
> -       spin_unlock_irqrestore(&pctrl->lock, flags);
> +       raw_spin_unlock_irqrestore(&pctrl->lock, flags);
>
>         return 0;
>  }
> @@ -443,7 +443,7 @@ static void msm_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
>
>         g = &pctrl->soc->groups[offset];
>
> -       spin_lock_irqsave(&pctrl->lock, flags);
> +       raw_spin_lock_irqsave(&pctrl->lock, flags);
>
>         val = readl(pctrl->regs + g->io_reg);
>         if (value)
> @@ -452,7 +452,7 @@ static void msm_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
>                 val &= ~BIT(g->out_bit);
>         writel(val, pctrl->regs + g->io_reg);
>
> -       spin_unlock_irqrestore(&pctrl->lock, flags);
> +       raw_spin_unlock_irqrestore(&pctrl->lock, flags);
>  }
>
>  #ifdef CONFIG_DEBUG_FS
> @@ -571,7 +571,7 @@ static void msm_gpio_irq_mask(struct irq_data *d)
>
>         g = &pctrl->soc->groups[d->hwirq];
>
> -       spin_lock_irqsave(&pctrl->lock, flags);
> +       raw_spin_lock_irqsave(&pctrl->lock, flags);
>
>         val = readl(pctrl->regs + g->intr_cfg_reg);
>         val &= ~BIT(g->intr_enable_bit);
> @@ -579,7 +579,7 @@ static void msm_gpio_irq_mask(struct irq_data *d)
>
>         clear_bit(d->hwirq, pctrl->enabled_irqs);
>
> -       spin_unlock_irqrestore(&pctrl->lock, flags);
> +       raw_spin_unlock_irqrestore(&pctrl->lock, flags);
>  }
>
>  static void msm_gpio_irq_unmask(struct irq_data *d)
> @@ -592,7 +592,7 @@ static void msm_gpio_irq_unmask(struct irq_data *d)
>
>         g = &pctrl->soc->groups[d->hwirq];
>
> -       spin_lock_irqsave(&pctrl->lock, flags);
> +       raw_spin_lock_irqsave(&pctrl->lock, flags);
>
>         val = readl(pctrl->regs + g->intr_status_reg);
>         val &= ~BIT(g->intr_status_bit);
> @@ -604,7 +604,7 @@ static void msm_gpio_irq_unmask(struct irq_data *d)
>
>         set_bit(d->hwirq, pctrl->enabled_irqs);
>
> -       spin_unlock_irqrestore(&pctrl->lock, flags);
> +       raw_spin_unlock_irqrestore(&pctrl->lock, flags);
>  }
>
>  static void msm_gpio_irq_ack(struct irq_data *d)
> @@ -617,7 +617,7 @@ static void msm_gpio_irq_ack(struct irq_data *d)
>
>         g = &pctrl->soc->groups[d->hwirq];
>
> -       spin_lock_irqsave(&pctrl->lock, flags);
> +       raw_spin_lock_irqsave(&pctrl->lock, flags);
>
>         val = readl(pctrl->regs + g->intr_status_reg);
>         if (g->intr_ack_high)
> @@ -629,7 +629,7 @@ static void msm_gpio_irq_ack(struct irq_data *d)
>         if (test_bit(d->hwirq, pctrl->dual_edge_irqs))
>                 msm_gpio_update_dual_edge_pos(pctrl, g, d);
>
> -       spin_unlock_irqrestore(&pctrl->lock, flags);
> +       raw_spin_unlock_irqrestore(&pctrl->lock, flags);
>  }
>
>  static int msm_gpio_irq_set_type(struct irq_data *d, unsigned int type)
> @@ -642,7 +642,7 @@ static int msm_gpio_irq_set_type(struct irq_data *d, unsigned int type)
>
>         g = &pctrl->soc->groups[d->hwirq];
>
> -       spin_lock_irqsave(&pctrl->lock, flags);
> +       raw_spin_lock_irqsave(&pctrl->lock, flags);
>
>         /*
>          * For hw without possibility of detecting both edges
> @@ -716,7 +716,7 @@ static int msm_gpio_irq_set_type(struct irq_data *d, unsigned int type)
>         if (test_bit(d->hwirq, pctrl->dual_edge_irqs))
>                 msm_gpio_update_dual_edge_pos(pctrl, g, d);
>
> -       spin_unlock_irqrestore(&pctrl->lock, flags);
> +       raw_spin_unlock_irqrestore(&pctrl->lock, flags);
>
>         if (type & (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_LEVEL_HIGH))
>                 irq_set_handler_locked(d, handle_level_irq);
> @@ -732,11 +732,11 @@ static int msm_gpio_irq_set_wake(struct irq_data *d, unsigned int on)
>         struct msm_pinctrl *pctrl = gpiochip_get_data(gc);
>         unsigned long flags;
>
> -       spin_lock_irqsave(&pctrl->lock, flags);
> +       raw_spin_lock_irqsave(&pctrl->lock, flags);
>
>         irq_set_irq_wake(pctrl->irq, on);
>
> -       spin_unlock_irqrestore(&pctrl->lock, flags);
> +       raw_spin_unlock_irqrestore(&pctrl->lock, flags);
>
>         return 0;
>  }
> @@ -882,7 +882,7 @@ int msm_pinctrl_probe(struct platform_device *pdev,
>         pctrl->soc = soc_data;
>         pctrl->chip = msm_gpio_template;
>
> -       spin_lock_init(&pctrl->lock);
> +       raw_spin_lock_init(&pctrl->lock);
>
>         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>         pctrl->regs = devm_ioremap_resource(&pdev->dev, res);
> --
> 2.10.2
