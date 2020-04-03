Return-Path: <SRS0=GZ+T=5T=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B041C43331
	for <linux-rt-users@archiver.kernel.org>; Fri,  3 Apr 2020 17:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C0BA206F6
	for <linux-rt-users@archiver.kernel.org>; Fri,  3 Apr 2020 17:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbgDCRG1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 3 Apr 2020 13:06:27 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40733 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728188AbgDCRG0 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 3 Apr 2020 13:06:26 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jKPlw-0001Qt-UN; Fri, 03 Apr 2020 19:06:24 +0200
Date:   Fri, 3 Apr 2020 19:06:24 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Tim Sander <tim@krieglstein.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        RT <linux-rt-users@vger.kernel.org>
Subject: Re: Bugsplat with 5.4.10-rt5
Message-ID: <20200403170624.6ft4ktp4xsrgdrl6@linutronix.de>
References: <51153360.nHRbzzT6yM@dabox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <51153360.nHRbzzT6yM@dabox>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-03-31 10:08:55 [+0200], Tim Sander wrote:
…
> static irqreturn_t sigif_irq_handler(int irq, void *data)
> {
…
> #ifdef CONFIG_PREEMPT_RT_FULL

CONFIG_PREEMPT_RT_FULL has been replaced by CONFIG_PREEMPT_RT

>         if (priv->wakeupTask)
>                 wake_up_process(priv->wakeupTask);
> #else
>         wake_up_interruptible(&priv->wait);
> #endif
>         uint32_t regval = ioread32(&reg->rx_config);
>         iowrite32(regval | 2, &reg->rx_config);
>         iowrite32(regval & 0xfffffffd , &reg->rx_config);
>         return IRQ_HANDLED;
> }
> 
> I will try v5.4.28-rt19 later and see how that goes.

Sebastian
