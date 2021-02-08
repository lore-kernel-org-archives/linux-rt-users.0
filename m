Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7217AC433DB
	for <linux-rt-users@archiver.kernel.org>; Mon,  8 Feb 2021 18:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C01564E84
	for <linux-rt-users@archiver.kernel.org>; Mon,  8 Feb 2021 18:28:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbhBHS2D (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 8 Feb 2021 13:28:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234021AbhBHS13 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 8 Feb 2021 13:27:29 -0500
Received: from mail.kernel-space.org (unknown [IPv6:2a01:4f8:c2c:5a84::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C05C06178B
        for <linux-rt-users@vger.kernel.org>; Mon,  8 Feb 2021 10:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
        s=20190913; t=1612808803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZKl4vR7RJYQUO+xWF/CfZheDk9VXIL4JMhKSIfAmwS4=;
        b=DOCWVXgQfrrHmZKRhKlMmBJqkmjy/71VgURDI1e6mPA4+B/T5vqt2gytTB2YC8WLE0UnO2
        tgRpDQzN7zZxzm/BZEgoBwlclj/UaiO+d7mHuSn0Xo8SNZve5G/k+4QoRn7WlsaHwoEQxR
        uumMmDWhd9cO04FORYawQkD7ZTfORLw=
Received: from [192.168.0.2] (host-82-54-239-193.retail.telecomitalia.it [82.54.239.193])
        by sysam.it (OpenSMTPD) with ESMTPSA id 4b338b75 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 8 Feb 2021 18:26:43 +0000 (UTC)
Message-ID: <38dca2b5-f878-b6f5-09db-c7f48bb4fba4@kernel-space.org>
Date:   Mon, 8 Feb 2021 19:26:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
Subject: Re: arm64: imx8qxp: irq 464: nobody cared (try booting with the
 "irqpoll" option)
Content-Language: en-US
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org
References: <da64238e-dc1e-c479-44e2-0ea18d9577b8@kernel-space.org>
 <20210208122918.wyvto62kwyevfkyx@linutronix.de>
From:   "angelo@kernel-space.org" <angelo@kernel-space.org>
In-Reply-To: <20210208122918.wyvto62kwyevfkyx@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Sebastian,

thanks a lot for your kind reply,

On 08/02/21 1:29 PM, Sebastian Andrzej Siewior wrote:
> On 2021-02-05 11:15:13 [+0100], angelo@kernel-space.org wrote:
>> Hi all,
> Hi,
> 
>> applied patch-5.4.70-rt40 over linux-imx from nxp
>> (imx_5.4.70_2.3.0), this since imx8qxp-mek board seems not
>> totally supported in mainline stable 5.4.
>>
>> The patch applies properly, but at boot, at 50% of the cases,
>> i get:
>>
> …
>> [    2.231799] 003: imx-lpi2c 37230000.i2c: using scl,sda for recovery
>> [    2.232464] 003: pca953x 16-0020: using no AI
>> [    2.517161] 000: irq 464: nobody cared (try booting with the
>> "irqpoll" option)
>> [    2.517170] 000: CPU: 0 PID: 0 Comm: swapper/0 Not tainted
>> 5.4.70-rt40-00116-gc1de1cbc567a-dirty #51
>> [    2.517176] 000: Hardware name: Freescale i.MX8QXP MEK (DT)
>> [    2.517181] 000: Call trace:
> …
>> [    2.517233] 000:  handle_edge_irq+0xbc/0x200
>> [    2.517238] 000:  generic_handle_irq+0x24/0x38
>> [    2.517244] 000:  imx_intmux_irq_handler+0xac/0x140
>> [    2.517252] 000:  generic_handle_irq+0x24/0x38
>> [    2.517259] 000:  __handle_domain_irq+0x90/0x100
>> [    2.517267] 000:  gic_handle_irq+0x5c/0x14c
>> [    2.517272] 000:  el1_irq+0xb8/0x180
>> [    2.517277] 000:  arch_cpu_idle+0x1c/0x30
>> [    2.517284] 000:  default_idle_call+0x20/0x48
>> [    2.517291] 000:  do_idle+0x248/0x288
>> [    2.517297] 000:  cpu_startup_entry+0x24/0x78
>> [    2.517303] 000:  rest_init+0xd4/0xe0
>> [    2.517308] 000:  arch_call_rest_init+0xc/0x14
>> [    2.517316] 000:  start_kernel+0x414/0x448
>> [    2.517322] 000: handlers:
>> [    2.517331] 000: [<00000000206db772>] irq_default_primary_handler
>> threaded [<00000000ffd05448>] lpi2c_imx_isr
>> [    2.517341] 000: Disabling IRQ #464
>>
>> I know nxp related issues are probably now welcome here,
>> but if some chance/hint to have rt working, welcome.
> 
> From the backtrace it looks like the IRQ #464 is handled by
> lpi2c_imx_isr(), returns always with IRQ_NONE but the IRQ fires again
> and again.

On imx_5.4.70_2.3.0, still the irq routine is returning
always IRQ_HANDLED. So i am supposing proper handling is
probably not the issue.

https://source.codeaurora.org/external/imx/linux-imx/tree/drivers/i2c/busses/i2c-imx-lpi2c.c?h=imx_5.4.70_2.3.0#n528

> It appears that IRQ-masking is not working properly but then the
> stacktrace says handle_edge_irq() and I have my doubts if it is really
> an EDGE interrupt.

As an interrupt parent for this i2c module, devicetree
specify a special "intmux" controller/module,
(interrupt multiplexer module).

https://source.codeaurora.org/external/imx/linux-imx/tree/drivers/irqchip/irq-imx-intmux.c?h=imx_5.4.70_2.3.0

It uses handle_edge_irq so it should be fine,.

> Looking at lpi2c_imx_isr() in v5.11, it returns always with IRQ_HANDLED
> looks like different code between your BSP and upstream. Also always
> returning IRQ_HANDLED will duct tape the problem if the driver is
> handling / acking the interrupt
> 
> You should see something a big number of interrupts (in
> /proc/interrupts) for the #464 interrupt.

Sure,

209:          2          0          0          0  gpio-mxc   3 Level 17-0050
324:          0          0          0          0  gpio-mxc  22 Edge
5b020000.mmc cd
464:     100006          0          0          0    intmux   9 Edge
466:          0          0          0          0  irqsteer  16 Level
 56228000.dsi_host
467:          0          0          0          0  irqsteer  16 Level


> I suggest to update something more recent like v5.10 without the FSL
> bsp if possible.
> 

Issue seems coming after an initial i2c "read" from a pca953x i2c-gpio
expander connected in this i2c bus. This i2c register read is issued
from

ret = devm_gpiochip_add_data(&client->dev, &chip->gpio_chip, chip);

https://source.codeaurora.org/external/imx/linux-imx/tree/drivers/gpio/gpio-pca953x.c?h=imx_5.4.70_2.3.0#n1112

That following a bit the code seems to involve some spinlocks.

After this i2c read, that probably triggers the first interrupt,
looking by oscilloscope, seems i2c communication is interrupted.

I am still investigating on this, every help/hint is welcome.

>> Regards,
> 
> Sebastian
> 

Thanks a lot,
-- 
Angelo Dureghello
+++ kernelspace +++
+E: angelo@kernel-space.org

