Return-Path: <SRS0=gYFm=DC=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C38DC4363D
	for <linux-rt-users@archiver.kernel.org>; Fri, 25 Sep 2020 09:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF484206B5
	for <linux-rt-users@archiver.kernel.org>; Fri, 25 Sep 2020 09:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="DvuhcIhN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbgIYJLq (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 25 Sep 2020 05:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727680AbgIYJLp (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 25 Sep 2020 05:11:45 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809C4C0613D3
        for <linux-rt-users@vger.kernel.org>; Fri, 25 Sep 2020 02:11:45 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id lo4so2627863ejb.8
        for <linux-rt-users@vger.kernel.org>; Fri, 25 Sep 2020 02:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=EINwdvc62tASjwpRJVndiLCvvVKWaOgZRLx0lxHJGdk=;
        b=DvuhcIhNXBHXC334WLX00vfEFn96hpowAqa9NMof2QJfUe1SjYf+qgDyay7PihvEfa
         +Ne60c2JdxHEx5vqRl3r8SXZ9SOvXQzSVKMMhih9rabjBs26Sb4XOLQW6bt8H80rGIhD
         wN/oNtgtQmBbkOOca7lNc11ukpfbBjB7uImCLFIL5GZGNdx3aUQyTR02VsquFHzkWEJG
         Zbwl8jE8WNVSRBSWFDs6ZBmW/VfGORc5dEdx00GxT5CwrsUQEgZEn4Bhcxeg16tAX5oQ
         V3FmKPR8u6FAHm8DlAZCPQNXFw9xcQUOagHEgiOmEEp2ijY/riZUv3lFs9Z8KzHydV86
         CcWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=EINwdvc62tASjwpRJVndiLCvvVKWaOgZRLx0lxHJGdk=;
        b=AzbLF9fMR/bKb9mh4YgbaXgyZuQkQIN4FojpCP/NUUYDKMjGW2VfrE4RFr6Vb+figG
         TqEzchaTpW4+z7tm8gIgcHd/5LV/sxVizeYFVxNlRAIP7Gq2AKU1HSRNNELlpwvJR6tj
         Uu1J2SFXy6BiisfyiyqKdR0ZjT4EpCSSpvS/bekP1g2n0Q0kjRsjw0xPMqdOQAqV/8li
         inL3G1uQ2h8jvSd4rNamfbbSYzMxRquVX5d4IwzBFpTDY3pLM9e/jAH7+5lfAEb9bFwg
         7pp/1GJjMeFKZH/7oHM3/WBHrncNfrZvXdILdLb1biD9Z7oxoH0VFWV4N/C9RFvMVU1n
         tKeQ==
X-Gm-Message-State: AOAM533P695bfx7X3bWu6HBz5GN7XJV/gYUzK1BVkhR10Uiifg0l90B+
        zhEfNIdAxdG/wGYcP3XYdMz0IA==
X-Google-Smtp-Source: ABdhPJx+uUP+3B9UO5TLURje87PEsrajL8+BhL6bIsWz0W4R6TpnWfp0fNyJq9eces+bJbQ4EicB1w==
X-Received: by 2002:a17:906:abc5:: with SMTP id kq5mr1707113ejb.284.1601025104165;
        Fri, 25 Sep 2020 02:11:44 -0700 (PDT)
Received: from localhost (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id i26sm1371709edq.47.2020.09.25.02.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 02:11:43 -0700 (PDT)
References: <24a844c3-c2e0-c735-ccb7-83736218b548@gmail.com> <7hk0wj9ki2.fsf@baylibre.com>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Brad Harper <bjharper@gmail.com>,
        linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org
Cc:     linux-rt-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: host: meson-gx-mmc: fix possible deadlock condition for preempt_rt
In-reply-to: <7hk0wj9ki2.fsf@baylibre.com>
Date:   Fri, 25 Sep 2020 11:11:42 +0200
Message-ID: <1jzh5e8bld.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


On Thu 24 Sep 2020 at 19:01, Kevin Hilman <khilman@baylibre.com> wrote:

> Hi Brad,
>
> Brad Harper <bjharper@gmail.com> writes:
>
>> Force threaded interrupts for meson_mmc_irq to prevent possible deadlock 
>> condition
>> during mmc operations when using preempt_rt with 5.9.0-rc3-rt3 patches 
>> on arm64.
>>
>> Using meson-gx-mmc with an emmc device on Hardkernel Odroid N2+ 
>> configured with
>> preempt_rt resulted in the soc becoming unresponsive.  With lock 
>> checking enabled
>> the below inconsistent lock state was observed during boot.
>>
>> After some discussions with tglx in IRC #linux-rt the attached patch was 
>> suggested
>> to remove IRQF_ONESHOT from request_threaded_irq.
>> This has been tested and confirmed by me to resolve both the 
>> unresponsive soc and
>> the inconsistent lock state warning when using 5.9.0-rc3-rt3 on arm64 
>> Odroid N2+.
>>
>> Further review and testing is required to ensure there are no adverse 
>> impacts or
>> concerns and that is the correct method to resolve the problem.  I will 
>> continue
>> to test on various amlogic devices with both standard mainline low 
>> latency kernel
>> and preempt_rt kernel with -rt patches.
>
> This looks right to me, thanks for sending a fix.
>
> For broader testing, I can add this to my testing branch so it gets
> booted on a bunch more platform in KernelCI also.
>
> However...
>
> [...]
>
>> Signed-off-by: Brad Harper <bjharper@gmail.com>
>> ---
>>   drivers/mmc/host/meson-gx-mmc.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/meson-gx-mmc.c 
>> b/drivers/mmc/host/meson-gx-mmc.c
>> index 08a3b1c05..130ac134d 100644
>> --- a/drivers/mmc/host/meson-gx-mmc.c
>> +++ b/drivers/mmc/host/meson-gx-mmc.c
>> @@ -1139,7 +1139,7 @@ static int meson_mmc_probe(struct platform_device 
>> *pdev)
>>                 host->regs + SD_EMMC_IRQ_EN);
>>
>>          ret = request_threaded_irq(host->irq, meson_mmc_irq,
>> -                                  meson_mmc_irq_thread, IRQF_ONESHOT,
>> +                                  meson_mmc_irq_thread, 0,
>>                                     dev_name(&pdev->dev), host);

I'm not sure about this.
As you have explained on IRC, I understand that IRQF_ONESHOT is causing
trouble with RT as the hard IRQ part of the thread will not be migrated
to a thread. That was certainly not the intent when putting this flag.

As described in include/linux/interrupt.h:
 * IRQF_ONESHOT - Interrupt is not reenabled after the hardirq handler finished.
 *                Used by threaded interrupts which need to keep the
 *                irq line disabled until the threaded handler has been run.

The intent was only that, making sure the irq is not re-enabled until
the threaded part is done. AFAIU, removing this flag would allow the
hard irq handler to fire again while we are not done handling the
previous IRQ in threaded part.

This seems pretty unsafe to me. Maybe we could improve the driver so it
copes with this case gracefully. ATM, I don't think it would.

Maybe I missed something and I am happy to be enlightened if that is the
case :)


>>          if (ret)
>>                  goto err_init_clk;
>
> This patch has been mangled by your mailer, so it doesn't apply cleanly.
> If you're using the gmail web UI, this is a common problem.
>
> I strongly recommend using git-send-email to send directly via gmail
> SMTP.  The git-send-email docs[1] give some examples on how to set this
> up.
>
> Kevin
>
> [1] https://git-scm.com/docs/git-send-email#_examples
>
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic

