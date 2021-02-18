Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27304C433DB
	for <linux-rt-users@archiver.kernel.org>; Thu, 18 Feb 2021 15:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA23C64E3E
	for <linux-rt-users@archiver.kernel.org>; Thu, 18 Feb 2021 15:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbhBRPza (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 18 Feb 2021 10:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbhBRNue (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 18 Feb 2021 08:50:34 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F41C061574
        for <linux-rt-users@vger.kernel.org>; Thu, 18 Feb 2021 05:49:20 -0800 (PST)
Date:   Thu, 18 Feb 2021 14:49:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613656159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DyYbqBZW2O8A5RW6DKUNh+BmF5s+iA6VqKkYZ7TraLw=;
        b=NOxqdak9J7pKxsB2omGaqYEdIIsjNj2mbwEILpumV+9ji+t+aQ079mIJMQw1IYM+BcWIsi
        DnX2L851eA76m+jM1aj/t+WND9MnRkWxImMkRxoX69MeHPhG1HCs47q+dAOXZz6juLsrlA
        9/KBpVldkKY2oh6NVjUDEH7sCofT52rWvWmRvG67wkDKZueIxQ0yoBJmyyuUbEnrDVXxPt
        f1fFBgMlOEgzvx8hV1KcqDhN0OfMSwSsQ9hSrC5iL9QFvbS9xGIaiHSKsITHKxWu0ERR86
        Gy9Cr0lw9dmwOuuziPZAa4e7jPWYIZiDqxNu1Z5lC30NM3q3EDn7kc9umaNXGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613656159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DyYbqBZW2O8A5RW6DKUNh+BmF5s+iA6VqKkYZ7TraLw=;
        b=7mwdAY1V5OHL3HE2Cdbt/jb4kh7wx1GUucscfRFlZ7wGrxeUOeB+xEosIKJ9Hw7MWmz1ch
        pfffambXy7wSPXCA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "angelo@kernel-space.org" <angelo@kernel-space.org>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: arm64: imx8qxp: irq 464: nobody cared (try booting with the
 "irqpoll" option)
Message-ID: <20210218134918.gdnjxmscwei5t2cz@linutronix.de>
References: <da64238e-dc1e-c479-44e2-0ea18d9577b8@kernel-space.org>
 <20210208122918.wyvto62kwyevfkyx@linutronix.de>
 <38dca2b5-f878-b6f5-09db-c7f48bb4fba4@kernel-space.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <38dca2b5-f878-b6f5-09db-c7f48bb4fba4@kernel-space.org>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-02-08 19:26:28 [+0100], angelo@kernel-space.org wrote:
> Hi Sebastian,
Hi,

> > From the backtrace it looks like the IRQ #464 is handled by
> > lpi2c_imx_isr(), returns always with IRQ_NONE but the IRQ fires again
> > and again.
> 
> On imx_5.4.70_2.3.0, still the irq routine is returning
> always IRQ_HANDLED. So i am supposing proper handling is
> probably not the issue.
> 
> https://source.codeaurora.org/external/imx/linux-imx/tree/drivers/i2c/busses/i2c-imx-lpi2c.c?h=imx_5.4.70_2.3.0#n528

interesting. This does not explain why the core disabled it.

> > It appears that IRQ-masking is not working properly but then the
> > stacktrace says handle_edge_irq() and I have my doubts if it is really
> > an EDGE interrupt.
> 
> As an interrupt parent for this i2c module, devicetree
> specify a special "intmux" controller/module,
> (interrupt multiplexer module).
> 
> https://source.codeaurora.org/external/imx/linux-imx/tree/drivers/irqchip/irq-imx-intmux.c?h=imx_5.4.70_2.3.0
> 
> It uses handle_edge_irq so it should be fine,.

It is hard to tell without a look into the manual. From browsing over
the driver, that lock in imx_intmux_irq_mask() should be a
raw_spinlock_t. There should be a warning otherwise with
CONFIG_DEBUG_ATOMIC_SLEEP. But then this is an EDGE handler without
irq_ack. So it does nothing. And mask/unmask is probably only used on
request_irq() / free_irq() so no warning here.

> Issue seems coming after an initial i2c "read" from a pca953x i2c-gpio
> expander connected in this i2c bus. This i2c register read is issued
> from
> 
> ret = devm_gpiochip_add_data(&client->dev, &chip->gpio_chip, chip);
> 
> https://source.codeaurora.org/external/imx/linux-imx/tree/drivers/gpio/gpio-pca953x.c?h=imx_5.4.70_2.3.0#n1112
> 
> That following a bit the code seems to involve some spinlocks.
> 
> After this i2c read, that probably triggers the first interrupt,
> looking by oscilloscope, seems i2c communication is interrupted.
> 
> I am still investigating on this, every help/hint is welcome.

My guess is that the interrupt muxing is not working properly.

Sebastian
