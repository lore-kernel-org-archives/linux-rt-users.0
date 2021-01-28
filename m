Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D90C433E9
	for <linux-rt-users@archiver.kernel.org>; Thu, 28 Jan 2021 06:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E81464DC4
	for <linux-rt-users@archiver.kernel.org>; Thu, 28 Jan 2021 06:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbhA1G3T (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 28 Jan 2021 01:29:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbhA1G3S (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 28 Jan 2021 01:29:18 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA8CC061574
        for <linux-rt-users@vger.kernel.org>; Wed, 27 Jan 2021 22:28:38 -0800 (PST)
Date:   Thu, 28 Jan 2021 07:28:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611815316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kRYFXYdv4l0Hx3FPgUlOXL3Un9k2DykmlxA4Z/J78y0=;
        b=sQS907uVzweDjUwqvChs3gwkqtQo3LsuNLCoB3Kp+KfIkvIE1LCwHrSUvur14iCQmTX9Uv
        IUle27UTn6CiCQVm4Vtud7lB522HcL8tC2c4mJ4TXZ9i4dvh3jgUFBdOnDNgFeV5i9FFBq
        H4+ip5ZW3DpEPOQHLPJJXjkwbYQnjZr1Rk4+5QnAjQyJuWJinIwe1n85ObE8o/L6NMyZvn
        Li96Ykai5ykIHWgCawj39kNDsGn6MXs1MpN/TimrdahbKB/S4JX0BSc1Q2sjy0g2L2xYtR
        eDik6xHIGHY0clW7EZxXbJDjQK4MfFs/EVirLp0DhVpH+UFskn7quu9H/3ALFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611815316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kRYFXYdv4l0Hx3FPgUlOXL3Un9k2DykmlxA4Z/J78y0=;
        b=9IDnRZwRXP6GT8ZP409ucTTwCkscVwGIm1C5XH7JxgJ8IaP1fC8W05CiSv4YEabhrsXw+F
        pVqnqrSyjie/jGBw==
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     David Runge <dave@sleepmap.de>
Cc:     linux-rt-users@vger.kernel.org,
        linux1394-devel@lists.sourceforge.net
Subject: Re: firewire-ohci fails to initialize Texas Instruments
 XIO2213A/B/XIO2221 based controller on realtime kernels [5.4.91-rt50,
 5.10.8-rt24]
Message-ID: <YBJZk9/77+E0TRk4@lx-t490>
References: <YAwPoaUZ1gTD5y+k@hmbx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YAwPoaUZ1gTD5y+k@hmbx>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Sat, Jan 23, 2021 at 12:59:29PM +0100, David Runge wrote:
...
>
> Unfortunately firewire-ohci is unable to initialize my firewire
> controller [1] (a PCIe card [2]) both on 5.4.91-rt50 and on 5.10.8-rt24: No
> device nodes (i.e. /dev/fw0) are created and therefore no connected devices can
> be initialized either.
>
...
> At this point in time I'm uncertain whether this is a general problem
> with the kernel module on the realtime kernels or a problem with the
> kernel module on the realtime kernels with my PCIe controller specifically.
> That it works using the ExpressCard34 based controller on my laptop makes it
> extra odd (but I guess the underlying driver is handling this
> differently due to the PCI bridge?).
>

Can you please send the full kernel log, with boot parameter
"firewire_ohci.debug=-1", for mainline v5.4.91 vs. v5.4.91-rt50?

Please also make sure to use the exact same defconfig for both, except
with CONFIG_PREEMPT_RT=y for the -rt kenrel of course.

This will help in comparing apples to apples, as you were posting the
results of different base kernels (vs. the -rt versions), and different
defconfigs (vs. -rt) within such kernels.

Good luck,

P.S. Since this maybe is a timing issue, and ohci bus reset handling
occurs at SCHED_OTHER workqueu context, were you by any chance running
unreasonably-intensive realtime workloads by the time the driver was
loaded?

Thanks,

--
Ahmed S. Darwish
