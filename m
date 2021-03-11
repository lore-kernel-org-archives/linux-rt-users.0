Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97212C433E0
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Mar 2021 14:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 548AF64DDA
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Mar 2021 14:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233970AbhCKO7N (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 11 Mar 2021 09:59:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233962AbhCKO6p (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 11 Mar 2021 09:58:45 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B202C061574
        for <linux-rt-users@vger.kernel.org>; Thu, 11 Mar 2021 06:58:44 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id q25so40217402lfc.8
        for <linux-rt-users@vger.kernel.org>; Thu, 11 Mar 2021 06:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=austral-dynamics-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=oQ4gNlA29uLYaqukVepQ7MZospwRrQxunXXR/K/Cb90=;
        b=iT8dCIoQpMOQKjqu3vLqiQ/yWsBGBNwxjSPxG7d5KrnFCJdnlvpxZjGbWC8ZFkmrAC
         Z3Yf74Xoke22Y70uPXeMjVqpOQCZ8LFmUnMbTdqXxymSumdpO00m6klb0xsMt2Q/s1t9
         LgO5TTEq4jZnpd8nw2CxjVDjWdnSV/ry9N5w34FhW2/ENflwYkqqcveMLaW4IHQV3fU1
         NVkn/IFNsLZAXvH8XoD3PZpLw/nd8gyKi2ETjIUnVEpwkxGLADwFL6FrIkau4/kVITMH
         yT3WTkopCu1jcnUw4Sy9jPw7g7Wei3W9N8BAy4fTKSfuDi6E2kBmFYM0nkeouRXDSJQ/
         Rt2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=oQ4gNlA29uLYaqukVepQ7MZospwRrQxunXXR/K/Cb90=;
        b=S/PHKUZ5sV9nW6GJnPw2Ed16Zeb7OnsNsjgLHw87nY1iUMis0YD3q6H8PU0RrtVVHr
         Glk1S1r4L/0rv3KJT/zLRGJH5Hf6FVsIce5OT0zKDSI/eKOUZDHVb6z3y3Kxs2bAhKij
         x6fsamNFOqT6/0AvxyBmi9S6bs3QieUCdgI35+yXZ1pVNUDOuGPYIRqGfGrR1ik5OSXb
         0ewjiChtCuagCTg7fvPmhuGj+14yHb0gjIFLyytzAdJl1KnMaVRYNo4fofgpaNBT8CdC
         fwKzw/K5C+cli68sXw0A2ISJ7MSXhzzJHNevlxEwuiuRSethMAohrdp62blf/zG/xmnQ
         k2IQ==
X-Gm-Message-State: AOAM5332XCcnG8nvI16yAz3gy1Itl5H/UDiq2h1FHUSIVe2vzT8QDmZr
        wJAIMO1oS6gIyCCy5TvXn4/DUvvuSxCLNsFgvo8+4FFktfQyQg==
X-Google-Smtp-Source: ABdhPJxxm9BOUr1rIzHxpiAMbdhDQnhBuBxtl884CLwpjV8gFmRgdZUMJ/J0ITkYfnLmK7FzqQ1BsueDIZ0GdmtcdEo=
X-Received: by 2002:a05:6512:2212:: with SMTP id h18mr2508180lfu.330.1615474722875;
 Thu, 11 Mar 2021 06:58:42 -0800 (PST)
MIME-Version: 1.0
References: <CAKkbJ-ypaPZ5JKpXD+PykvO6oYzxEUdxXY2RbVJKWdGY3ALuLg@mail.gmail.com>
 <9be68ca5-9fec-161c-1b37-1b47c0a1d845@monom.org>
In-Reply-To: <9be68ca5-9fec-161c-1b37-1b47c0a1d845@monom.org>
From:   Michel Macena Oliveira <michel@austral-dynamics.com>
Date:   Thu, 11 Mar 2021 11:56:50 -0300
Message-ID: <CAKkbJ-x4Er7RKhvrThtmmf-MT5uakdkc2G0ZL06i-fGsmBzmSg@mail.gmail.com>
Subject: Re: PREEMPT_RT benchmark
To:     Daniel Wagner <wagi@monom.org>, linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Daniel,
Thanks for your answer! That was the problem!
If I understand correctly  when Cyclictest writes to the
cpu_dma_latency file, the processor does not sleep and remain
full power all the time. Is there any problem writing a RT application
(not a benchmark one) with this trick?
Could it cause any harm to the system?
My idea is to develop a RT application in which I have a scheduled
thread to compute and deliver results in a given time or interval.

Michel

Em qui., 11 de mar. de 2021 =C3=A0s 09:27, Daniel Wagner <wagi@monom.org> e=
screveu:
>
> Hi Michel,
>
> On 10.03.21 21:07, Michel Macena Oliveira wrote:
> > At least that's what I expected, but my latencies are much bigger than
> > Cyclictest ones.
> >  From cyclictest I get an average in my computer of  something between
> > 2300 and 2500 nanoseconds.  However, in my application I'm having
> > something between 47000 and 55000 nanoseconds. As you can see it is
> > much higher!
> >
> > I'm not sure of what I'm doing wrong, could you help or suggest somethi=
ng?
>
> Check if your system uses power managment. cyclictest disables the power
> management by using the /dev/cpu_dma_latency API.
>
> HTH,
> Daniel
