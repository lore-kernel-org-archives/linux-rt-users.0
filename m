Return-Path: <SRS0=Nlir=4F=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62602C34022
	for <linux-rt-users@archiver.kernel.org>; Mon, 17 Feb 2020 18:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46FA220725
	for <linux-rt-users@archiver.kernel.org>; Mon, 17 Feb 2020 18:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729819AbgBQSGo (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 17 Feb 2020 13:06:44 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33786 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbgBQSGn (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 17 Feb 2020 13:06:43 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j3kn3-00042e-Je; Mon, 17 Feb 2020 19:06:41 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id A302A1039FA; Mon, 17 Feb 2020 19:06:40 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Laurentiu-Cristian Duca <laurentiu.duca@gmail.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: kernel panic in SPI rt driver interrupt
In-Reply-To: <CAPm8-H5n0f3dAEa=vM++aUZTxu4H_zvNp-4bjzriByJDGSefnA@mail.gmail.com>
References: <CAPm8-H5n0f3dAEa=vM++aUZTxu4H_zvNp-4bjzriByJDGSefnA@mail.gmail.com>
Date:   Mon, 17 Feb 2020 19:06:40 +0100
Message-ID: <87pnednl5b.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Laurentiu-Cristian Duca <laurentiu.duca@gmail.com> writes:
>   I am an open source enthusiast and
>   I have written a driver for Texas Instruments omap4 mcspi
>   beaglebone black open source board, linux preempt_rt kernel 5.4.5-rt3.
>   I have the following problem (if you want all the code
>   I will post it, it is gpl open source):
>
> - in the interrupt I do
> 	mcspi->interrupt_done = 1;
> 	wake_up_interruptible(&mcspi->wq);
>
> - in the transfer function I do
> 	/* Enable interrupts last. */
> 	mcspi->interrupt_done = 0;
> 	l = OMAP2_MCSPI_IRQENABLE_TX0_EMPTY |
> 			OMAP2_MCSPI_IRQENABLE_RX0_FULL;
> 	mcspi_write_reg(mcspi->master, OMAP2_MCSPI_IRQENABLE, l);
>
> 	/* TX_EMPTY will be raised only after SPI data is sent */
> 	mcspi_wr_fifo(mcspi);
>
> 	/* wait for transfer completion */
> 	wait_event_interruptible(mcspi->wq, (mcspi->interrupt_done > 0));
>
> - I try to make one million small SPI transfers (8 bytes per transfer),
> but after about 10000 transfers I get kernel oops and then panic

Not a surprise.

> [  166.994607] 000: PC is at rt_spin_lock_slowlock_locked+0x268/0x304
> [  167.391044] 000: [<c0909e40>] (rt_spin_lock_slowlock_locked) from [<c0909f30>] (rt_spin_lock_slowlock+0x54/0x7c)
> [  167.401265] 000: [<c0909f30>] (rt_spin_lock_slowlock) from [<c01891bc>] (__wake_up_common_lock+0x58/0xa8)
> [  167.410882] 000: [<c01891bc>] (__wake_up_common_lock) from [<c0189220>] (__wake_up+0x14/0x1c)
> [  167.419445] 000: [<c0189220>] (__wake_up) from [<bf00056c>] (omap2_mcspi_irq_handler_rt+0xa4/0x118 [spi_omap2_mcspi])
> [  167.430114] 000: [<bf00056c>] (omap2_mcspi_irq_handler_rt [spi_omap2_mcspi]) from [<c019dfa0>]
> (__handle_irq_event_percpu+0x50/0x2c4) [  167.442181] 000: [<c019dfa0>] (__handle_irq_event_percpu) from
> [<c019e280>] (handle_irq_event_percpu+0x6c/0xc4) [  167.452315] 000: [<c019e280>] (handle_irq_event_percpu) from
> [<c019e344>] (handle_irq_event+0x6c/0xb0) [  167.461663] 000: [<c019e344>] (handle_irq_event) from [<c01a28b0>]
> (handle_level_irq+0xdc/0x1bc) [  167.470491] 000: [<c01a28b0>] (handle_level_irq) from [<c019d0dc>]
> (generic_handle_irq+0x20/0x34) [  167.479403] 000: [<c019d0dc>] (generic_handle_irq) from

You're using a interrupt with IRQF_NO_THREAD and call into a function
which is not safe to use from hard interrupt context on RT
i.e. wake_up(). Remove IRQF_NO_THREAD and your problem goes away.

Thanks,

        tglx
