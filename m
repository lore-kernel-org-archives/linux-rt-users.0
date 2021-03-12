Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_40,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9305C433E0
	for <linux-rt-users@archiver.kernel.org>; Fri, 12 Mar 2021 15:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9673964FE0
	for <linux-rt-users@archiver.kernel.org>; Fri, 12 Mar 2021 15:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbhCLPrO (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 12 Mar 2021 10:47:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbhCLPrM (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 12 Mar 2021 10:47:12 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87913C061574
        for <linux-rt-users@vger.kernel.org>; Fri, 12 Mar 2021 07:47:11 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id x4so39774783lfu.7
        for <linux-rt-users@vger.kernel.org>; Fri, 12 Mar 2021 07:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=austral-dynamics-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sFkM/5XIydi4DCb4T7krFp16QJP9RweURg12CPgGbrM=;
        b=KCoQ56+Ka8FP9nM42Lzz0nX3HfcRRYLg4VGJRdTN2ppGDrA577IeFMhp3Tm/z9mTPP
         oF6Pk0tR2Xfh31+WyG+sVUgsUnT2yz1o2Cq15S3tBc63bmy4o8nG+gVvlFxflChhXpF2
         gakXQ7wPLesN0w77WL7r5W2ztgjmRvi9ViGbwIstnJoy6Y0xHNIPJdcvE2z2NWjIiY5O
         +WotVRNioWk9dE6leQvVT/2VnZ3dUB6RfAwf6MJDy8QYh22gEuL5xmys5cfsQeHGT2UO
         XM9B3axQLpZ9DrZ91NZwSnkmThF7EgHzjF3mKi09ddlcf4NBf5qI2qI2m7sx4FeUhwpX
         2eqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sFkM/5XIydi4DCb4T7krFp16QJP9RweURg12CPgGbrM=;
        b=j7QcFLv0XAkDcbhPFyp/hBVmRwxO3zBHozN9an0KAVjBA4qB4XCwgVO8nd+vwqdmsx
         abevdvfjbmTOF4y8uZxoa5QcrAWhbldgKc7GREx9mZeZBtrHIH0OcABx9+BKgjPD5fX6
         Ip3d5J05vjgrHjflo54Fghrf+CCSpiwopBGJZkLDuXDlvBvwywyYL7Pdsw9/FvTCfcZc
         eGdR6PE5mNgXBNmLA0SfGwaG0ffDHlH4GcOsHb3HiFKgwmGt6Eza2thm2IifT33yrKG1
         OkH9HROWMTMDSr/8ENpPK6OCToHMT7J0uELRERRmHvYBNmlWuFLg6h78FnXhUjP6+wQp
         bvBQ==
X-Gm-Message-State: AOAM531vzAGCpx+djNJ9NMkiFGCwFz0M3nFQVzg3MofElH+9V5BWxGKw
        WZH0DQv2i5NyxE8kDFKXCfHwDdVFohn8piAcOfkIQgkVYDHZow==
X-Google-Smtp-Source: ABdhPJwEnwk92sD5ZN/YqIbw/G12vr6i0P7eLeCFHdjsJ98on0pN4GnrFUtMgwsIo6XgEqUyA4hPZoTk8gmq7twTchY=
X-Received: by 2002:a19:d61a:: with SMTP id n26mr5479888lfg.383.1615564030119;
 Fri, 12 Mar 2021 07:47:10 -0800 (PST)
MIME-Version: 1.0
References: <CAKkbJ-ypaPZ5JKpXD+PykvO6oYzxEUdxXY2RbVJKWdGY3ALuLg@mail.gmail.com>
 <9be68ca5-9fec-161c-1b37-1b47c0a1d845@monom.org> <CAKkbJ-x4Er7RKhvrThtmmf-MT5uakdkc2G0ZL06i-fGsmBzmSg@mail.gmail.com>
 <YEpCkqfg4umsS4lv@lx-t490> <CAKkbJ-weFeM5EiBObqULkanBZpA6M9_Pfzu0seZ_cKBnNzEwyQ@mail.gmail.com>
 <YEpZwgED/4ddmsVf@lx-t490>
In-Reply-To: <YEpZwgED/4ddmsVf@lx-t490>
From:   Michel Macena Oliveira <michel@austral-dynamics.com>
Date:   Fri, 12 Mar 2021 12:45:17 -0300
Message-ID: <CAKkbJ-za8EdUqqxjj3fikgyF3ZO1ow2cKLvR820B8har3+y6UA@mail.gmail.com>
Subject: Re: PREEMPT_RT benchmark
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

>Sorry for being picky, but this was part of another e-mail sub-thread.
>You should've kept it there...
That is fine!  I'm learning!

About the rest of the answer was really helpful!
I'll do my research!
Thanks anyway!
