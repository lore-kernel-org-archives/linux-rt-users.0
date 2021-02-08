Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A23C433E6
	for <linux-rt-users@archiver.kernel.org>; Mon,  8 Feb 2021 12:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDF0164E8B
	for <linux-rt-users@archiver.kernel.org>; Mon,  8 Feb 2021 12:30:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbhBHMa3 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 8 Feb 2021 07:30:29 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36488 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbhBHMaB (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 8 Feb 2021 07:30:01 -0500
Date:   Mon, 8 Feb 2021 13:29:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612787359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=33y8fMyhqemoPBBvUbcbiP0bZu+iLif9tpMhfAgz2l4=;
        b=QRM6lnF3yx8hwXK7MAcSd2EdMqFPEH2VZjZuijEKY+o/onzbxUl3oxjXzhpcm65wSGq3sq
        54tlhucOm0fr1hZiunBnPCToxs3shZQOcNCzufq3I1ff1grWQT4kqy19eMYmRQ4EVqc19q
        DIFDvVyKu/o1hm1og6Y64idhQpp+snmR+X8TJT2phmPxHov+Gis0b/BZ/y8tzTWpa8XlUN
        u9iMLdSlZgjEkQYnqjxKeDAYfEUdmd+XJORH+B9wUFgOWQ4vW5afE/1Qzw2xBviJ6cdizq
        8mautBA9I+deMAhW7QZFWP+56H5QI1p8kCR9xy9oTwdP/enKq2/toUaB8FfSLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612787359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=33y8fMyhqemoPBBvUbcbiP0bZu+iLif9tpMhfAgz2l4=;
        b=mm/LoDEkeADXa436tPNvSStrgupcoG/OOnYjnYa8RubVQ2uTYepG4MdsQWNA0cQuykZaiT
        H0A+iMtTMh7zMbCQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "angelo@kernel-space.org" <angelo@kernel-space.org>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: arm64: imx8qxp: irq 464: nobody cared (try booting with the
 "irqpoll" option)
Message-ID: <20210208122918.wyvto62kwyevfkyx@linutronix.de>
References: <da64238e-dc1e-c479-44e2-0ea18d9577b8@kernel-space.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <da64238e-dc1e-c479-44e2-0ea18d9577b8@kernel-space.org>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-02-05 11:15:13 [+0100], angelo@kernel-space.org wrote:
> Hi all,
Hi,

> applied patch-5.4.70-rt40 over linux-imx from nxp
> (imx_5.4.70_2.3.0), this since imx8qxp-mek board seems not
> totally supported in mainline stable 5.4.
>=20
> The patch applies properly, but at boot, at 50% of the cases,
> i get:
>=20
=E2=80=A6
> [    2.231799] 003: imx-lpi2c 37230000.i2c: using scl,sda for recovery
> [    2.232464] 003: pca953x 16-0020: using no AI
> [    2.517161] 000: irq 464: nobody cared (try booting with the
> "irqpoll" option)
> [    2.517170] 000: CPU: 0 PID: 0 Comm: swapper/0 Not tainted
> 5.4.70-rt40-00116-gc1de1cbc567a-dirty #51
> [    2.517176] 000: Hardware name: Freescale i.MX8QXP MEK (DT)
> [    2.517181] 000: Call trace:
=E2=80=A6
> [    2.517233] 000:  handle_edge_irq+0xbc/0x200
> [    2.517238] 000:  generic_handle_irq+0x24/0x38
> [    2.517244] 000:  imx_intmux_irq_handler+0xac/0x140
> [    2.517252] 000:  generic_handle_irq+0x24/0x38
> [    2.517259] 000:  __handle_domain_irq+0x90/0x100
> [    2.517267] 000:  gic_handle_irq+0x5c/0x14c
> [    2.517272] 000:  el1_irq+0xb8/0x180
> [    2.517277] 000:  arch_cpu_idle+0x1c/0x30
> [    2.517284] 000:  default_idle_call+0x20/0x48
> [    2.517291] 000:  do_idle+0x248/0x288
> [    2.517297] 000:  cpu_startup_entry+0x24/0x78
> [    2.517303] 000:  rest_init+0xd4/0xe0
> [    2.517308] 000:  arch_call_rest_init+0xc/0x14
> [    2.517316] 000:  start_kernel+0x414/0x448
> [    2.517322] 000: handlers:
> [    2.517331] 000: [<00000000206db772>] irq_default_primary_handler
> threaded [<00000000ffd05448>] lpi2c_imx_isr
> [    2.517341] 000: Disabling IRQ #464
>=20
> I know nxp related issues are probably now welcome here,
> but if some chance/hint to have rt working, welcome.

=46rom the backtrace it looks like the IRQ #464 is handled by
lpi2c_imx_isr(), returns always with IRQ_NONE but the IRQ fires again
and again.
It appears that IRQ-masking is not working properly but then the
stacktrace says handle_edge_irq() and I have my doubts if it is really
an EDGE interrupt.
Looking at lpi2c_imx_isr() in v5.11, it returns always with IRQ_HANDLED
looks like different code between your BSP and upstream. Also always
returning IRQ_HANDLED will duct tape the problem if the driver is
handling / acking the interrupt

You should see something a big number of interrupts (in
/proc/interrupts) for the #464 interrupt.
I suggest to update something more recent like v5.10 without the FSL
bsp if possible.

> Regards,

Sebastian
