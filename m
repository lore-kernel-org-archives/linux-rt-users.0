Return-Path: <SRS0=hjoW=WL=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F332CC3A589
	for <linux-rt-users@archiver.kernel.org>; Thu, 15 Aug 2019 18:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDA442083B
	for <linux-rt-users@archiver.kernel.org>; Thu, 15 Aug 2019 18:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBsKQY7F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731200AbfHOSAu (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 15 Aug 2019 14:00:50 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44449 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730802AbfHOSAu (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 15 Aug 2019 14:00:50 -0400
Received: by mail-wr1-f65.google.com with SMTP id p17so2957758wrf.11
        for <linux-rt-users@vger.kernel.org>; Thu, 15 Aug 2019 11:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IqRV13/6CqcWKNWWIFqaOOC4Rk30piwVr9eIkQ/fvic=;
        b=SBsKQY7FF/bjcmDPibEuFuCxt3G0uwJ2eEhebF/mp3lmx+1+fDPWl4oeB8earPFJ6X
         bFhqOUSzjnEC2pHgk0TqSvMW7oVzsHpu/NvtkXhlT3BGb5A+PjiYZlAAtzbArtCx6B+d
         y/vEmR8g7FIX/si3Bm82EtuoAGo1Fxt9x9nhnjy6LF6fHukbOA0TL+pED1EMArmneXsg
         CeAF9nmby4QGZPWMRS7+AmIO8hhGT4kVBCr7fW6xE11J1Xjmn2k2YJnO7Nv/ialpBA/I
         Q7AuJ829a5klD+YOsklEb9wp+HbYXFpfNzsjX3zln2N20Qd/cWojd/uwOfYIXQ649+LX
         Pfkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IqRV13/6CqcWKNWWIFqaOOC4Rk30piwVr9eIkQ/fvic=;
        b=bshvcx1Y12pHTuPS1SGHczwzfdJkgVWUVCXZIA5DlPVtj4GbQv6VuSBrZg1SI8ww01
         k+zRGQc7Vghjrw5Ut6yDInSWQtvIuOR+CqoNHOfRr8xNk8h5XIg0x3oY1VCj8HM4CSzq
         x0fww6e46uXghdUjWMU9SPH6nPyexUTIEHhLRNwf2moNj2UI6zz9sIq0h8tc6kssqjh2
         gdKa5c8v95QgAbBazH6JRPQ8MSrM7x3ztCPNjYKDNuEZ41L3LzmECWrczAm1yq94i5zL
         0qNg43tWV1k7lkby6vg22KoxSgcckUgiUPUNfM6WRC2ovYbagGXDgL1jiW3wH4lT6+70
         V4kQ==
X-Gm-Message-State: APjAAAWr37s35iFUiYa9Jv+NMuFv/UXPQxpBL/cy0OOZ+1/67SqzdGro
        pLvW7eaQaD1OaGDph65FhA/kGOGU3jwbSwMcNCQ=
X-Google-Smtp-Source: APXvYqyqABVKUCyLcaUplTLV4AmsbtJYLO1AIBdDuBHZS8FCXdvQaPFWqRYTk3FA1gV/LPka4rKxpQn/MP3Ve3Q7QAE=
X-Received: by 2002:a5d:4dc6:: with SMTP id f6mr6649334wru.209.1565892047454;
 Thu, 15 Aug 2019 11:00:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAD56B7fdr5w0Pk5WHVWXa1ORyM=i+Ew66O+8buBwH0geeX+X0Q@mail.gmail.com>
 <alpine.DEB.2.21.1907162221350.1767@nanos.tec.linutronix.de>
 <CAD56B7eF_KhWvg=m6iy5YSJF-81v-zcmX7+8Kd0wGMrALHwU1A@mail.gmail.com>
 <alpine.DEB.2.21.1907170111160.1767@nanos.tec.linutronix.de>
 <CAD56B7eswTRxbeA8foXyVVZ7Bd+_y40dtOLkHxuAf4kVge7VDg@mail.gmail.com>
 <alpine.DEB.2.21.1907171001150.1767@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1907171009280.1767@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1907171101150.1767@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1907171220400.1767@nanos.tec.linutronix.de>
 <CAD56B7eomeb5Lr2juFWtZmtqSx3SkPijW03QZz8xv39He26PrA@mail.gmail.com> <20190813095306.xqgq3uusdpj7dhy7@linutronix.de>
In-Reply-To: <20190813095306.xqgq3uusdpj7dhy7@linutronix.de>
From:   Paul Thomas <pthomas8589@gmail.com>
Date:   Thu, 15 Aug 2019 14:00:34 -0400
Message-ID: <CAD56B7fnVpmiE+m71zHSNuQw49GWJJ0ySGUD3Zc2mih_CxUjpg@mail.gmail.com>
Subject: Re: poor cyclictest results with 5.0 series rt for arm64
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        dunc.mcphie@gmail.com, Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

> could you please try the following hunk?
>
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index 6808cd9526c67..63c6960262861 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -648,7 +648,8 @@ alternative_if ARM64_HAS_IRQ_PRIO_MASKING
>         orr     x24, x24, x0
>  alternative_else_nop_endif
>
> -       cbnz    x24, 2f                                 // preempt count != 0
> +       cbz     x24, 1f                                 // (need_resched + count) == 0
> +       cbnz    w24, 2f                                 // count != 0
>
>         ldr     w24, [tsk, #TSK_TI_PREEMPT_LAZY]        // get preempt lazy count
>         cbnz    w24, 2f                                 // preempt lazy count != 0
>
After correctly applying this patch I do not see large latencies, >15M
iterations and counting.
# ./cyclictest -S -m -n -p 99 -i 200 -h 700 -f
# /dev/cpu_dma_latency set to 0us
policy: fifo: loadavg: 0.04 0.06 0.18 1/134 2043

T: 0 ( 1968) P:99 I:200 C:15081932 Min:      6 Act:    8 Avg:    7 Max:      22
T: 1 ( 1969) P:99 I:200 C:15081831 Min:      6 Act:    9 Avg:    7 Max:      17
T: 2 ( 1970) P:99 I:200 C:15081727 Min:      6 Act:    9 Avg:    8 Max:      17
T: 3 ( 1971) P:99 I:200 C:15081619 Min:      6 Act:    9 Avg:    8 Max:      18

I apologize for messing this up the first time. I had copied the text
strait from gmail and it failed to apply. If I had used 'patch -l' or
copied it from the archive, then it directly applies and I wouldn't
have messed up when I put it in manually. Just for reference here's
how I screwed it up:
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 6808cd9526c6..be0933a3f5e3 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -651,7 +651,8 @@ alternative_else_nop_endif
        cbnz    x24, 2f                                 // preempt count != 0

        ldr     w24, [tsk, #TSK_TI_PREEMPT_LAZY]        // get preempt
lazy count
-       cbnz    w24, 2f                                 // preempt
lazy count != 0
+       cbz     x24, 1f                                 //
(need_resched + count) == 0
+       cbnz    w24, 2f                                 // count != 0

        ldr     x0, [tsk, #TSK_TI_FLAGS]                // get flags
        tbz     x0, #TIF_NEED_RESCHED_LAZY, 2f          // needs rescheduling?

thanks,
Paul
