Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C09F5C00140
	for <linux-rt-users@archiver.kernel.org>; Tue,  2 Aug 2022 12:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236442AbiHBM2z (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 2 Aug 2022 08:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237078AbiHBM2x (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 2 Aug 2022 08:28:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7013E51418
        for <linux-rt-users@vger.kernel.org>; Tue,  2 Aug 2022 05:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659443329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Nn7D1b+GTXDRMhPjjDw9wDMDc6fRBFgLaiKTIqh5zu4=;
        b=JrQKpfyR21gRCLX7zuHnazCSJCF/N/pEeZXaWQRhy/CuV8qIF4sQ5X9yBmDwBANG+3fLOY
        M282QRdWpDpddF3dxOd7JWBw83uP6MiSGRHJpVDdQZWY4RI1dftRBPLyawqP+Y8WmlL3gj
        8PgA7ULpwE4QZ9Wx3dz2Szg/yd4+jVM=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-657-btnCUAoOPEe6V3263wfzPg-1; Tue, 02 Aug 2022 08:28:46 -0400
X-MC-Unique: btnCUAoOPEe6V3263wfzPg-1
Received: by mail-pg1-f199.google.com with SMTP id q82-20020a632a55000000b0041bafd16728so3386679pgq.3
        for <linux-rt-users@vger.kernel.org>; Tue, 02 Aug 2022 05:28:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Nn7D1b+GTXDRMhPjjDw9wDMDc6fRBFgLaiKTIqh5zu4=;
        b=PjIXKihuTIUiuEL7WK+VyVCppcAZMJQVshzFlyC0R3D57JegpAY+CMxd8U7hr83Oh9
         6WgqhB8X7naWWa3AHOIo3VNkChcUBowo9ZhU8aNLXu9jaRo07+qAAOMdfPN8v2Putu+X
         ud9sdQJnvEiTy1hUJlwiy6E63QE1UVVPTdyM8QsHgSz9uslMX9RmQtby+0s2dpaPvfF7
         Avv8t3Gb7cFQWbZu7ql+6G7eCRPjbxu5fIUTBG71iEjGOUR4pwPnjHR42Tg/y1fu8C5P
         jS99/IBb00UYBjK8N8kF+MDO62n53IuSpmZYro3gF4z8Fsag4KU9U4Z303n5p8pj5w+Q
         fFiA==
X-Gm-Message-State: ACgBeo3mm6Z+MWZskR2KRBGTkkE4rwsHNds2Yh+/iF2un3FL81Qx49Gr
        5EhjQRqkBFUj2xRDQ0LBxKD2mBpNicnurchCd0M4/Cb4pBrQt/TOUkWxiEYNTh197jD7phssHNm
        735zg8Sf9ZPSGNO95k6lkt1FDjAd5RT4E6tvB6yKnkr0=
X-Received: by 2002:a17:903:260b:b0:16e:d654:6c41 with SMTP id jd11-20020a170903260b00b0016ed6546c41mr13724310plb.29.1659443325208;
        Tue, 02 Aug 2022 05:28:45 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5dZYIvVpMkgW4hByDOWyl+/USYvvmAC2XQKOBEvdzpSq8qDJJSnOX1XxJ6lqaDduAK/GFDWMZpMReFwbwZQwk=
X-Received: by 2002:a17:903:260b:b0:16e:d654:6c41 with SMTP id
 jd11-20020a170903260b00b0016ed6546c41mr13724286plb.29.1659443324922; Tue, 02
 Aug 2022 05:28:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220712112238.18824-1-goliath@infraroot.at> <60f230fb-de97-ead8-b3a3-12a591804c32@canonical.com>
 <YuQHe3g3Ydmljx7M@linutronix.de> <cac0fa51-0e02-b759-4887-cfa3141c9154@canonical.com>
 <aa48288b-2982-0756-4350-3287bdf6c09f@canonical.com>
In-Reply-To: <aa48288b-2982-0756-4350-3287bdf6c09f@canonical.com>
From:   Clark Williams <williams@redhat.com>
Date:   Tue, 2 Aug 2022 12:28:34 +0000
Message-ID: <CAMLffL_wDb01QX+C+g3oa1EvGNmt82WL=Cas8+OhUk+1e8UUEw@mail.gmail.com>
Subject: Re: [PATCH 0/4] Backport MEMCG changes from v5.17
To:     Joseph Salisbury <joseph.salisbury@canonical.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        David Oberhollenzer <goliath@infraroot.at>,
        linux-rt-users@vger.kernel.org, richard@nod.at
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

I'm currently working through some conflicts when I merged Greg's
v5.15.58 into the 5.15-rt stable tree, but I'd be very interesting in
testing in your patch after I get that resolved.

Clark

On Mon, Aug 1, 2022 at 10:36 PM Joseph Salisbury
<joseph.salisbury@canonical.com> wrote:
>
>
>
> On 8/1/22 14:17, Joseph Salisbury wrote:
> >
> >
> > On 7/29/22 12:14, Sebastian Andrzej Siewior wrote:
> >> On 2022-07-27 16:35:44 [-0400], Joseph Salisbury wrote:
> >>> Hi David,
> >> Hi,
> >>
> >>> Do you know if these patches will be merged into the 5.15 patchset?
> >> I'm going to look at these next week. Has this been tested?
> > If anyone is interested in testing these patches with the Ubuntu
> > distro, I created a 5.15.39 based test kernel which is packaged as a
> > .deb. This test kernel has the rt-42 patch set, and the four patches
> > from David.
> > This test kernel can be downloaded from:
> > https://people.canonical.com/~jsalisbury/MEMCG_UNSUPPORTED_TEST_KERNEL/
> Also, the test kernel is AMD64.  If anyone needs an ARM64 kernel, just
> let me know.
> >
> > This kernel will also be tested in an Ubuntu kernel bug[0].  The bug
> > reporter will be testing if the patches resolve a bug that affects
> > kubernetes, which is missing cgroup memory.  However, the bug reporter
> > will probably not be testing latency differences. That is something I
> > could look into next week.
> >
> > Joe
> >
> > [0] http://pad.lv/1978814
> >>
> >>> Thanks,
> >>>
> >>> Joe
> >> Sebastian
> >
>

