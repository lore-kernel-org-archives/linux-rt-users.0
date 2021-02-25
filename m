Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEBDC433E0
	for <linux-rt-users@archiver.kernel.org>; Thu, 25 Feb 2021 03:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10EB364E7A
	for <linux-rt-users@archiver.kernel.org>; Thu, 25 Feb 2021 03:03:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233067AbhBYDCk (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 24 Feb 2021 22:02:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236937AbhBYDCe (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 24 Feb 2021 22:02:34 -0500
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3AE0C061574
        for <linux-rt-users@vger.kernel.org>; Wed, 24 Feb 2021 19:01:47 -0800 (PST)
Received: by mail-yb1-xb42.google.com with SMTP id p193so4000929yba.4
        for <linux-rt-users@vger.kernel.org>; Wed, 24 Feb 2021 19:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=rZLwIm/Tec5jB0u6FFrUy7NjOTwKo5kvhnCRFo9W9+8=;
        b=GoO6nRqc47V0B+jCcYZVDMhB+y/+ljsWVE0s7/01xU/a18sZGpP/jy1YS9bI+rrTAK
         OwZ/8hayI68+60VZkVWOeu+ZEHBOrs/xtY0pIxj4cfme85O4iRQeK/vUDUDhgQPA9hN3
         Xwhx/up/J+Axh+tzmqf/YOMGxKJ74GJgVQtdtuxf/xgCNv2DfQ4fVrXBILhlwYXl+7/6
         TZokI01y1gO3ajqxeNi3Nuya5xbhpkbfvqdnoSm55OmDnEnA97grMw0fnqZKPu95TMFH
         oDiYUGMzpGsx3krz0yQxDVS35R62RCEa2HKp9RVQBl8yR8GMA5ktzgFagYyG7jdzIGta
         YNZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=rZLwIm/Tec5jB0u6FFrUy7NjOTwKo5kvhnCRFo9W9+8=;
        b=LbBLOOYV5cU8l0yunNIEl7cO6AJ4hG3Pf3NweYTepJBISLmLohGwIlP3SLFmkPof2J
         lGA1pjUc20LyQcGBTopmcyY4B1LWG+mS9TB1C8yMlQjbwmY58j221Y3xwV1WPNt3F3HH
         IT172zhflJfOzPFOAZ1ZjIAcsAPdyE0WkCYoooOrQwZHIkWEfvEQSwuI/D5eBmN7DzvQ
         Ow4Qc3foexfZZLPDNH35UFdsO/t4qNQ9So61iqQEBjwzNtFO0V3MEMk7hxYoSnTLRaI4
         M3tXMYjN2wApsQwy+OwOoyMwsaZdQHVrYgw+cbhJ2axaGiQSYO+l4RpF/Z4G2Rz7Di7V
         67Fg==
X-Gm-Message-State: AOAM532t6UC4MJeXzhA9jd5xhmAsrqkizUJlfkv4yseie4gwWU5cYQsd
        zT8UpMYyOc0fWqigT7H6WhKOysVqsrp1kf9MrFmVD3UJ2kyWyg==
X-Google-Smtp-Source: ABdhPJycXNtFgrt0AQfgMUCDFeqy+BcO6PLeL21P5Mqp0UphYqz7RJbCw8atgl9gQiSgkH0K7th+OXS8SEPLc5pWLLQ=
X-Received: by 2002:a25:31c2:: with SMTP id x185mr1054243ybx.93.1614222107056;
 Wed, 24 Feb 2021 19:01:47 -0800 (PST)
MIME-Version: 1.0
References: <CAJa5FiHcaG7EB3eAD17w_6GhZm0yqvD0Ev3DvJAU7meOG6C--g@mail.gmail.com>
 <YDNsojcMWpa2Ynsi@lx-t490> <CAJa5FiExdgUfpXMje0cAe_KH+0M53MunejedM1bzEKh5xnt93g@mail.gmail.com>
 <YDOD5om6XVA4gbmp@lx-t490>
In-Reply-To: <YDOD5om6XVA4gbmp@lx-t490>
From:   kun peng <kunpeng0891@gmail.com>
Date:   Thu, 25 Feb 2021 11:01:35 +0800
Message-ID: <CAJa5FiGt=d77J_wRSzqU32rKES_imuySPmByfT2Pscivif5j_w@mail.gmail.com>
Subject: Re: Question about rt-patch use in arm64 kvm host and guest o
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Ahmed S. Darwish <a.darwish@linutronix.de> =E4=BA=8E2021=E5=B9=B42=E6=9C=88=
22=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=886:13=E5=86=99=E9=81=93=EF=
=BC=9A
>
> On Mon, Feb 22, 2021 at 05:29:47PM +0800, =E9=B9=8F=E9=B2=B2 wrote:
> >
> > I have read this article carefully before, but this article focuses on
> > the x86 system.
> >
>
> Most of the details in that article are not x86-specific.
>
> > I don't know if anyone has used rt-patch successfully on arm64 kvm? Or
> > have a lot of problems with arm64 kvm?
> >
>
> Maybe someone on the list can jump-in and provide their experience.
>
> In general though, you will have to try things by yourself. Properly
> configure both the host and guest kernels for preempt_rt, monitor
> VMexits through "perf kvm" and try to minimize them, run cyclictest
> inside and outside of the guest, and see how things goes...
>
> And if this is an embedded device, you can also try Jailhouse.
>
> Good luck,
>
> --
> Ahmed S. Darwish


I have tested the use of RT-Patch in host and guest os on Raspberry Pi4.
Now everything seems to be working fine.

Thanks a lot

Best,
Kun
