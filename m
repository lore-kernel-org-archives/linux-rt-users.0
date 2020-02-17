Return-Path: <SRS0=Nlir=4F=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221DAC34021
	for <linux-rt-users@archiver.kernel.org>; Mon, 17 Feb 2020 18:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E25682070B
	for <linux-rt-users@archiver.kernel.org>; Mon, 17 Feb 2020 18:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hWgQEhy2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729595AbgBQSPo (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 17 Feb 2020 13:15:44 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41199 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728857AbgBQSPo (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 17 Feb 2020 13:15:44 -0500
Received: by mail-ot1-f68.google.com with SMTP id r27so16938128otc.8
        for <linux-rt-users@vger.kernel.org>; Mon, 17 Feb 2020 10:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vdAt9PXs7qPigHaroti2c2yY9UwrdPHwXWPTaGpfPak=;
        b=hWgQEhy293SCDiMfa28sBlehtVR+dWDvLRRdBXzzYPv2r/WWKwvpZFztAYncJdT21H
         vU8edcrHzLWueV8E+pPGS5b1WfcN6pmYWeZV7hdWP1zdhU1anoO+9Gu5js9xexp2oj7J
         z+R46V+ghI6/9r+dKVjzMF180Z1+mdJ3V0EKFC/Nzd7CsNoVNOnHatlq6ytfzyoJ98ZJ
         ML925twLikNh/ZnOHiu7ud7HbMYGKzYNmC3AqdpOhTMe5J+gr629Mdhl03TpKK3JKWis
         lTrWxFL5LlF/K3N6ObuOOLK5ppBP/RYE6jp1Va5+gdUeICOXaj0PJ77ktUZuJBeIPzpj
         Jzlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vdAt9PXs7qPigHaroti2c2yY9UwrdPHwXWPTaGpfPak=;
        b=H2AKDPLeOcFJNH69Ee//PmVy5z1d1XV0ewMVQB04ERO+TwTV/Z+RKjB5+V+I1vXpmT
         3kN+g8b0o/Ol0+/Wcwm9XU25/Ew/GWtOHeq+Np+ctvsk6V/0DIiYgVDoi0Qp7tKZUAz7
         OUG7E3lk6Um0sKpG9J2RwfwCNB6TfLQkNzsPeBp0MS/mEfi4YmAjYxjv/DjCje6DkUkX
         P+7oT0THFm0FjcTLEdAY3r58WUAsPI6pNx5C9Ijos49BwJP70E8so3AFRQ2ytSDggrQI
         PjiPzhGR1w1V8doInfWgNNT2wi/LBYG7rNqDNkewcmdmfK2rY22Zm6EdChbnKvM4sTbJ
         uabw==
X-Gm-Message-State: APjAAAU071ipzq24jhYO+GXqcf8DLwIgWb2y/rJcecMPhYe/0Yjw5kRD
        NU6rn5u3KfNnsr5g9R7jpGnjSGZNvxLc0lngMro=
X-Google-Smtp-Source: APXvYqxBSuo21LJOUOWCGX3zVHlBkR6iMKARzOXkjpsk5z1xb4NJOu9R7fiQ8RvA8sMsa1Qy4re9kkSwBUYMrZJkwPU=
X-Received: by 2002:a05:6830:1198:: with SMTP id u24mr12627537otq.215.1581963343402;
 Mon, 17 Feb 2020 10:15:43 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a4a:9489:0:0:0:0:0 with HTTP; Mon, 17 Feb 2020 10:15:43
 -0800 (PST)
In-Reply-To: <87pnednl5b.fsf@nanos.tec.linutronix.de>
References: <CAPm8-H5n0f3dAEa=vM++aUZTxu4H_zvNp-4bjzriByJDGSefnA@mail.gmail.com>
 <87pnednl5b.fsf@nanos.tec.linutronix.de>
From:   Laurentiu-Cristian Duca <laurentiu.duca@gmail.com>
Date:   Mon, 17 Feb 2020 20:15:43 +0200
Message-ID: <CAPm8-H5uS-1TFPj_OZZe=tFuFya-RaW2_a_Ehfu4eFsd0D4xYw@mail.gmail.com>
Subject: Re: kernel panic in SPI rt driver interrupt
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

  Please tell me
what alternatives exists to replace wake_up/wait_event ?

Thank you very much

On 2/17/20, Thomas Gleixner <tglx@linutronix.de> wrote:
> Laurentiu-Cristian Duca <laurentiu.duca@gmail.com> writes:
>>   I am an open source enthusiast and
>>   I have written a driver for Texas Instruments omap4 mcspi
>>   beaglebone black open source board, linux preempt_rt kernel 5.4.5-rt3.
>>   I have the following problem (if you want all the code
>>   I will post it, it is gpl open source):
>>
>> - in the interrupt I do
>> 	mcspi->interrupt_done = 1;
>> 	wake_up_interruptible(&mcspi->wq);
>>
>> - in the transfer function I do
>> 	/* Enable interrupts last. */
>> 	mcspi->interrupt_done = 0;
>> 	l = OMAP2_MCSPI_IRQENABLE_TX0_EMPTY |
>> 			OMAP2_MCSPI_IRQENABLE_RX0_FULL;
>> 	mcspi_write_reg(mcspi->master, OMAP2_MCSPI_IRQENABLE, l);
>>
>> 	/* TX_EMPTY will be raised only after SPI data is sent */
>> 	mcspi_wr_fifo(mcspi);
>>
>> 	/* wait for transfer completion */
>> 	wait_event_interruptible(mcspi->wq, (mcspi->interrupt_done > 0));
>>
>> - I try to make one million small SPI transfers (8 bytes per transfer),
>> but after about 10000 transfers I get kernel oops and then panic
>
> Not a surprise.
>
>> [  166.994607] 000: PC is at rt_spin_lock_slowlock_locked+0x268/0x304
>> [  167.391044] 000: [<c0909e40>] (rt_spin_lock_slowlock_locked) from
>> [<c0909f30>] (rt_spin_lock_slowlock+0x54/0x7c)
>> [  167.401265] 000: [<c0909f30>] (rt_spin_lock_slowlock) from [<c01891bc>]
>> (__wake_up_common_lock+0x58/0xa8)
>> [  167.410882] 000: [<c01891bc>] (__wake_up_common_lock) from [<c0189220>]
>> (__wake_up+0x14/0x1c)
>> [  167.419445] 000: [<c0189220>] (__wake_up) from [<bf00056c>]
>> (omap2_mcspi_irq_handler_rt+0xa4/0x118 [spi_omap2_mcspi])
>> [  167.430114] 000: [<bf00056c>] (omap2_mcspi_irq_handler_rt
>> [spi_omap2_mcspi]) from [<c019dfa0>]
>> (__handle_irq_event_percpu+0x50/0x2c4) [  167.442181] 000: [<c019dfa0>]
>> (__handle_irq_event_percpu) from
>> [<c019e280>] (handle_irq_event_percpu+0x6c/0xc4) [  167.452315] 000:
>> [<c019e280>] (handle_irq_event_percpu) from
>> [<c019e344>] (handle_irq_event+0x6c/0xb0) [  167.461663] 000: [<c019e344>]
>> (handle_irq_event) from [<c01a28b0>]
>> (handle_level_irq+0xdc/0x1bc) [  167.470491] 000: [<c01a28b0>]
>> (handle_level_irq) from [<c019d0dc>]
>> (generic_handle_irq+0x20/0x34) [  167.479403] 000: [<c019d0dc>]
>> (generic_handle_irq) from
>
> You're using a interrupt with IRQF_NO_THREAD and call into a function
> which is not safe to use from hard interrupt context on RT
> i.e. wake_up(). Remove IRQF_NO_THREAD and your problem goes away.
>
> Thanks,
>
>         tglx
>
