Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01FCAC433DB
	for <linux-rt-users@archiver.kernel.org>; Tue,  9 Feb 2021 23:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0EE664E3C
	for <linux-rt-users@archiver.kernel.org>; Tue,  9 Feb 2021 23:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233812AbhBIXZ2 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 9 Feb 2021 18:25:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbhBIWQ6 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 9 Feb 2021 17:16:58 -0500
Received: from mail.kernel-space.org (unknown [IPv6:2a01:4f8:c2c:5a84::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE321C061223
        for <linux-rt-users@vger.kernel.org>; Tue,  9 Feb 2021 11:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
        s=20190913; t=1612897749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dbF9KKCJr0F9zd5WfkSXKv1fXPCjyclgA92gL1bfBxk=;
        b=o4En/HH6rKgKGogShnTqxTr6SBndocO8+sE1EyGUdQyV/x5+cwYb4QGa0EDgkoQYKiDDYc
        vtQECgRzh2oygjMA6CJPmTcIwD1wjWp++z77dXXE8D3LBZjnXwtG7BdZCSqy73WOsSB2b5
        lDKa1wZ6KCIqT3GiEwTaxSKFbY20BMU=
Received: from [192.168.0.2] (host-82-54-239-193.retail.telecomitalia.it [82.54.239.193])
        by sysam.it (OpenSMTPD) with ESMTPSA id 3e16cf15 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 9 Feb 2021 19:09:09 +0000 (UTC)
Message-ID: <d2d772dc-57f0-39f0-abec-caa8297d3e32@kernel-space.org>
Date:   Tue, 9 Feb 2021 20:08:53 +0100
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

Hi,

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
> It appears that IRQ-masking is not working properly but then the
> stacktrace says handle_edge_irq() and I have my doubts if it is really
> an EDGE interrupt.
> Looking at lpi2c_imx_isr() in v5.11, it returns always with IRQ_HANDLED
> looks like different code between your BSP and upstream. Also always
> returning IRQ_HANDLED will duct tape the problem if the driver is
> handling / acking the interrupt
> 
> You should see something a big number of interrupts (in
> /proc/interrupts) for the #464 interrupt.
> I suggest to update something more recent like v5.10 without the FSL
> bsp if possible.
> 
>> Regards,
> 
> Sebastian
> 

I finally found a solution, replacing drivers/irqchip/irq-imx-intmux.c
code with mainline. It seems quite reliable, i cannot replicate
the issue anymore. Any comment is welcome.


Regards,
-- 
Angelo Dureghello
+++ kernelspace +++
+E: angelo@kernel-space.org

