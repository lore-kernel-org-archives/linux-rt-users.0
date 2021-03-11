Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 065C2C433E0
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Mar 2021 15:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEB4B64FF7
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Mar 2021 15:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234003AbhCKPGK (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 11 Mar 2021 10:06:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233921AbhCKPFt (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 11 Mar 2021 10:05:49 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1C0C061574
        for <linux-rt-users@vger.kernel.org>; Thu, 11 Mar 2021 07:05:48 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id v2so27261787lft.9
        for <linux-rt-users@vger.kernel.org>; Thu, 11 Mar 2021 07:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=austral-dynamics-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=PO/dIvRkAgIddp8p+DMn/BKAAKJFzJs05581/49xIJc=;
        b=pU0GaasMD3QQDyTf82ObAzRWZmPtEu/+yD7XGxoQd6HgGV1WS9BNYDs7K4gzQFoIO7
         YO5XlJHPymhpytlQgeMFHYVs9lDo7dUNeSN9EBi0RAOyLBb69DE8hOa6CTZj0n1aaHnS
         V17OvTDLJccvPnD06NXe/Q6wjws60cmXP5y5IiYR/TcJCBSTgq8RsPDinBEbHdQ5Hpg1
         8zDKi2ajOpyFIM68Lsi7tQb4Ttfa/dqJlyoRQTnh3G8BXlPXjLJvx9N2JcyMJxNCQeVU
         fIxmfUqMOfXn7WHWVZPgmhHUBX8ywnB0H93JtTtOp5ILtw95W04B7OB0eSY5e7Mn3JIz
         4DRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=PO/dIvRkAgIddp8p+DMn/BKAAKJFzJs05581/49xIJc=;
        b=UeVopOnFtsb5m3lNuVsNM+EaKczHMhS+KKC+EgxmoGgO2BVjMDc+Ed3NA9+WM7Rw84
         XxJcGaLI2iAIvX0oDdUzVuSsZ+zyWY45H8jTivY2mLUw+r3yU/o5Z9j0X86zjlw5JJwQ
         aOYWPcBzHuSsStPia5WDKGgw+J/7213dmMfK2++BfmPp4lTlkSu1X1VMpZgwThmrk/nM
         pJufezxloP/FrtyTkKll66BHdwRBH91xcf5LpNsgzbRMH4GzPJuxUUNnWl6zIpwiQupO
         273X7dJPDZPTDJod/upDVEfdKkiDHRvxFB6Ayn10HvCwv2PBcjmoetvK9OsB5RCtIx/l
         xjhA==
X-Gm-Message-State: AOAM532TFmLMNm+fApt31gndKNN3UcTeapVNuiog56xNx2UMLDxXDQhv
        M1k7DZMK7DPligVTeoBQunxLfz/q1vtzYPeUxPQitzlXgw8=
X-Google-Smtp-Source: ABdhPJwAcgpnPd62SHVZGNs6EK1p3N9Z2kp1Ygt26M1qRClv79XqP8fI59t1uG93C76uS+V1EsxSXyJlheCMkenLPe8=
X-Received: by 2002:a19:9116:: with SMTP id t22mr2645648lfd.93.1615475147135;
 Thu, 11 Mar 2021 07:05:47 -0800 (PST)
MIME-Version: 1.0
References: <CAKkbJ-ypaPZ5JKpXD+PykvO6oYzxEUdxXY2RbVJKWdGY3ALuLg@mail.gmail.com>
 <YEoT7Wvk8V1cbHng@lx-t490>
In-Reply-To: <YEoT7Wvk8V1cbHng@lx-t490>
From:   Michel Macena Oliveira <michel@austral-dynamics.com>
Date:   Thu, 11 Mar 2021 12:03:54 -0300
Message-ID: <CAKkbJ-yO46NsvYoC7fwtZNeT9BO5EvkiyKf8S+bGuqPXjEZTGg@mail.gmail.com>
Subject: Re: PREEMPT_RT benchmark
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Ahmed,
thanks for the answer!
Do you know if it would be valid for GTK interface applications?

Michel

Em qui., 11 de mar. de 2021 =C3=A0s 09:58, Ahmed S. Darwish
<a.darwish@linutronix.de> escreveu:
>
> On Wed, Mar 10, 2021 at 05:07:47PM -0300, Michel Macena Oliveira wrote:
> >
> > I'm currently developing a time benchmark application where I want
> > to measure a real time thread latency. My application is based on
> > Cyclictest from
> > the rt-tests suit.
> ...
> >
> > I programmed in such way that it would be equivalent to Cyclict test
> >
> ...
> >
> > At least that's what I expected, but my latencies are much bigger than
> > Cyclictest ones.
> >
>
> I don't know the nature of the "time benchmark" application you are
> writing.
>
> Just a small hint that if you're doing any heavy OpenGL graphics within
> that application, the latency can shoot up significantly. On some of our
> Intel boxes, this can lead to an increase of 100-200 microseconds.
>
> That's because since Intel Gen9+ GPUs, Intel shares the Last-Level Cache
> (and thus also memory bandwidth) between the GPU and the CPU. This
> benefits graphical applications, but hurts predicatbility significantly.
>
> Good luck,
>
> --
> Ahmed S. Darwish
> Linutronix GmbH
