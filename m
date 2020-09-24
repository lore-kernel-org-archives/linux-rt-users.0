Return-Path: <SRS0=aBkN=DB=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E9CC4727D
	for <linux-rt-users@archiver.kernel.org>; Thu, 24 Sep 2020 17:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E8382311A
	for <linux-rt-users@archiver.kernel.org>; Thu, 24 Sep 2020 17:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="OGaeaq59"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbgIXRBn (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 24 Sep 2020 13:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbgIXRBn (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 24 Sep 2020 13:01:43 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C454C0613D3
        for <linux-rt-users@vger.kernel.org>; Thu, 24 Sep 2020 10:01:43 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id jw11so26859pjb.0
        for <linux-rt-users@vger.kernel.org>; Thu, 24 Sep 2020 10:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version:content-transfer-encoding;
        bh=wai6nrMcHMtaGESKTBMiyp6BzMJao/GERxFZZ1c+mrw=;
        b=OGaeaq59Tt/XijT63cFNXsWFUc7pRwS0n/R2QRbOGJnV7bvG3CXlKdq5J2kzaa78ME
         jbn6h+cKePv+nZUfj0dYZ/naRD1fpMeky67EjyNkTg//e+k2ICFEfpU8OpvLHodqmlsc
         e6Ly9/IjuYRLIh38hb9NRmaTWGZNwKnUqdSJcvhAoqJ+bkDsOq9MIKX2VARxrCjwg0q4
         3ou7RuM3Gjr8Xlz90Nu7tGCgohzhEADNN4nastiusrywUCf0Vc2eGX41ssiAock84bPQ
         FN7QmWmVC1S0RrKu5AL4uq0oDrScIks1DNrv6FZkIz5O5Zw4cWRsea78whS2daP/WxbN
         ZByA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=wai6nrMcHMtaGESKTBMiyp6BzMJao/GERxFZZ1c+mrw=;
        b=ic5FOlOBSRIm73Pxk8rqPLzUgEj8QfT2lrlMOdBHxBm8XDddZT8AVbvbVAlQFbdjKF
         Epk/FGQINTxXHWrzEcDGI9QBOCf3wUT8rAanZzv9bJEfMC2ATwP37J0vqdsrrbYOOePg
         0OaMqD1sbJLs1VE2glIfUKm7rRHGf4b0Y8KzU91jftxGMOPKZNTDg04wFLcngs3n3Q+V
         SaNLDZGv9VDRsWCdVLDv1KX8LXjRTNoyV/y27WrUP1mVYShHg1c0ok93/k1x3eEGsUGO
         EPUXH53MrS47TuKWXcB8LU1BCrHgruY/h4bl6gOvRg9zO7RWOrt55ai7kXYW85S4/Pnq
         YYjA==
X-Gm-Message-State: AOAM532NrHyagfbQUQJrlBisxqYlMeNJVsEq55b8idY5e+w/Iafg9h56
        tMznWYx7qoU71YSYSZqfdQ6rVw==
X-Google-Smtp-Source: ABdhPJyB4E6oTZ+1qw0qVBGbrUxEy2hRIRjCoD2OsburrUv+ugcG2SoS9sHIe6Pl0ettoc5fKwLfFg==
X-Received: by 2002:a17:90a:c20f:: with SMTP id e15mr102859pjt.163.1600966902382;
        Thu, 24 Sep 2020 10:01:42 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id y13sm51996pfr.141.2020.09.24.10.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 10:01:41 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Brad Harper <bjharper@gmail.com>,
        linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] mmc: host: meson-gx-mmc: fix possible deadlock condition for preempt_rt
In-Reply-To: <24a844c3-c2e0-c735-ccb7-83736218b548@gmail.com>
References: <24a844c3-c2e0-c735-ccb7-83736218b548@gmail.com>
Date:   Thu, 24 Sep 2020 10:01:41 -0700
Message-ID: <7hk0wj9ki2.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Brad,

Brad Harper <bjharper@gmail.com> writes:

> Force threaded interrupts for meson_mmc_irq to prevent possible deadlock=
=20
> condition
> during mmc operations when using preempt_rt with 5.9.0-rc3-rt3 patches=20
> on arm64.
>
> Using meson-gx-mmc with an emmc device on Hardkernel Odroid N2+=20
> configured with
> preempt_rt resulted in the soc becoming unresponsive.=C2=A0 With lock=20
> checking enabled
> the below inconsistent lock state was observed during boot.
>
> After some discussions with tglx in IRC #linux-rt the attached patch was=
=20
> suggested
> to remove IRQF_ONESHOT from request_threaded_irq.
> This has been tested and confirmed by me to resolve both the=20
> unresponsive soc and
> the inconsistent lock state warning when using 5.9.0-rc3-rt3 on arm64=20
> Odroid N2+.
>
> Further review and testing is required to ensure there are no adverse=20
> impacts or
> concerns and that is the correct method to resolve the problem.=C2=A0 I w=
ill=20
> continue
> to test on various amlogic devices with both standard mainline low=20
> latency kernel
> and preempt_rt kernel with -rt patches.

This looks right to me, thanks for sending a fix.

For broader testing, I can add this to my testing branch so it gets
booted on a bunch more platform in KernelCI also.

However...

[...]

> Signed-off-by: Brad Harper <bjharper@gmail.com>
> ---
>  =C2=A0drivers/mmc/host/meson-gx-mmc.c | 2 +-
>  =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c=20
> b/drivers/mmc/host/meson-gx-mmc.c
> index 08a3b1c05..130ac134d 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -1139,7 +1139,7 @@ static int meson_mmc_probe(struct platform_device=20
> *pdev)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 host->regs + SD_EMMC_IRQ_EN);
>
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D request_threaded_irq(=
host->irq, meson_mmc_irq,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 meson_mmc_irq_thread, I=
RQF_ONESHOT,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 meson_mmc_irq_thread, 0,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_name(&pdev->d=
ev), host);
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 goto err_init_clk;

This patch has been mangled by your mailer, so it doesn't apply cleanly.
If you're using the gmail web UI, this is a common problem.

I strongly recommend using git-send-email to send directly via gmail
SMTP.  The git-send-email docs[1] give some examples on how to set this
up.

Kevin

[1] https://git-scm.com/docs/git-send-email#_examples
