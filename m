Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F12DDC433E6
	for <linux-rt-users@archiver.kernel.org>; Mon, 22 Feb 2021 09:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C17A9601FE
	for <linux-rt-users@archiver.kernel.org>; Mon, 22 Feb 2021 09:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbhBVJao (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 22 Feb 2021 04:30:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbhBVJaj (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 Feb 2021 04:30:39 -0500
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D379C061786
        for <linux-rt-users@vger.kernel.org>; Mon, 22 Feb 2021 01:29:59 -0800 (PST)
Received: by mail-yb1-xb44.google.com with SMTP id m9so12224377ybk.8
        for <linux-rt-users@vger.kernel.org>; Mon, 22 Feb 2021 01:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=S7LR7QTgjCjjd77SprX+Hy7IecT2TgF9U9HQcfBxvLc=;
        b=tHO36Wm9C1cFyAK5zEAYp1EqppbLZnW9wq+VCXVMIj03/YKR1hAonFJ+xpMHlnBp/H
         lBp/kS85gPevtXEPxLmWzMr1w3WloEfIlQDBdCQ0NxvnbSeAA1XSmuM1vbvNoNmCt+hU
         diVxUGsRj11Ico2QyY2NGxgV6MxPD6sRn1HLcm7cy2LonNt/w+a2R7//CLQIBzxlnBxX
         6ALsFbgBVi3b12341vliRVGosnikw/eTeHWprTKmBdkx/B0SPFPwoR580Ew8YnJoRRU4
         j/5pBZrqyn4okwXGCvP2cEuZYDFvWlR/zRI5cv+IpBYE9pwqjhHo56CTG2ilkl73HWlY
         Syow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=S7LR7QTgjCjjd77SprX+Hy7IecT2TgF9U9HQcfBxvLc=;
        b=pDM2IQyGIn2LWJ0bYkaQ+NPYUU9qG4UuiRwpdSZgRE07lCLp0BYeAO9vFoX5zSREkt
         BjYu5hlVSgvroOgNalKiuZv0SKvp/WXLa1Cs/ThGvQhmXUZQHyevi8AoEvCI+pCLbzft
         2h8pfyMrnvv9yS85ffPwIaKAwM/c+lEyGkonq6b7O7tJI9IXe18Fk4Mf1t5JmZEmAgNh
         SagwWZfsDQXKEHbUuWMTkG2bXCNTlvGSQFaQ31YTqNRSG4/mFON53H9lEKvFWXe/aM8Z
         GSuin9H6qy/mwexoU/SKykl2l+FQ+99qbSV1FKs3BJ2mDLObBebxVGTyXLyGghE9j1oy
         Gvew==
X-Gm-Message-State: AOAM532xqpQ0z+9ZN+b6pNrqcpHPv13+kTKgH6R+WlTU6cmyudcpadzh
        AcPomI/nrizHGPslo3gtAjKtzLXXT46lYW5YVhN9UKD+AN6YCA==
X-Google-Smtp-Source: ABdhPJwPwE6Kn5adUkZEMAJyRIPcMVmgsraSAOCc5/7h1J5oKT+tv2/RTT1yoSwyMPKZNain0hUKPrN8jZi5OucQhDY=
X-Received: by 2002:a25:31c2:: with SMTP id x185mr30278969ybx.93.1613986198479;
 Mon, 22 Feb 2021 01:29:58 -0800 (PST)
MIME-Version: 1.0
References: <CAJa5FiHcaG7EB3eAD17w_6GhZm0yqvD0Ev3DvJAU7meOG6C--g@mail.gmail.com>
 <YDNsojcMWpa2Ynsi@lx-t490>
In-Reply-To: <YDNsojcMWpa2Ynsi@lx-t490>
From:   =?UTF-8?B?6bmP6bKy?= <kunpeng0891@gmail.com>
Date:   Mon, 22 Feb 2021 17:29:47 +0800
Message-ID: <CAJa5FiExdgUfpXMje0cAe_KH+0M53MunejedM1bzEKh5xnt93g@mail.gmail.com>
Subject: Re: Question about rt-patch use in arm64 kvm host and guest o
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Ahmed S. Darwish <a.darwish@linutronix.de> =E4=BA=8E2021=E5=B9=B42=E6=9C=88=
22=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=884:34=E5=86=99=E9=81=93=EF=
=BC=9A
>
> On Feb 22, 2021, =E9=B9=8F=E9=B2=B2 wrote:
> > I'm trying to use rt-ptach in arm64 kvm to improve real-time performanc=
e.
> > I couldn=E2=80=99t find useful information on the web so I think this m=
ail
> > list is the most appropriate place to ask this question.
> >
> > Rt-patch can use in arm64 kvm host linux and guest linux ? Where can I
> > find reference examples?
> >
>
> I've read some articles on the topic last year, and the best (by far)
> was this one:
>
>   Realtime KVM
>   https://lwn.net/Articles/656807
>
> It written by Bonzini, the KVM maintainer. The includes links/references
> are also very valuable.
>
> Good luck,
>
> --
> Ahmed S. Darwish

Thank for your reply.

I have read this article carefully before, but this article focuses on
the x86 system.
I don't know if anyone has used rt-patch successfully on arm64 kvm? Or
have a lot of problems with arm64 kvm?

Best,
Kun
