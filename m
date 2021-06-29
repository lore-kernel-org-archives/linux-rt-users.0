Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464A1C11F66
	for <linux-rt-users@archiver.kernel.org>; Tue, 29 Jun 2021 04:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 284BD61D4D
	for <linux-rt-users@archiver.kernel.org>; Tue, 29 Jun 2021 04:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbhF2ELX (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 29 Jun 2021 00:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhF2ELW (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 29 Jun 2021 00:11:22 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E100C061574
        for <linux-rt-users@vger.kernel.org>; Mon, 28 Jun 2021 21:08:55 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id g22so25085305iom.1
        for <linux-rt-users@vger.kernel.org>; Mon, 28 Jun 2021 21:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=X2xuzAx2GePHTHGXf9tapdAxWaiRAttX3a8Er12goOI=;
        b=nBlVNaolMDHE1xPOafbfx3cRsuKrIi+60W5J8G2sEI8OnT4wP/CoLjFT8tqRvKSzUe
         g9jEiXT5VnurYBzFB3ftzJGYIcRl1wQCQYC2mfsaMnj46Z/8PqdktLZWXXWece/4cItu
         SGFiKLJJy9tTMXWohsPJgod9zNGg3iJeJAnD+JhyE/okWGMTzrQWLmLEDKYea3Auxt6K
         ShiocBx3nTdQcmdRTwWLFrBYyZmjaqgGr5+gNpbUnmxh8/JzIk1qnv4wHxW0TRdDxEj+
         eEjeTt5u8Irql2LZMODPSApiwErqZeEf+JiKBUUEqhraPRVZxms94kOMxzKWEJ1zG5p5
         C4LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=X2xuzAx2GePHTHGXf9tapdAxWaiRAttX3a8Er12goOI=;
        b=T3+SkszB1MHrUNgizrOB1riUljdUls/cuPsGEV6oSOq8hZue1TK8U8m51IVCjZZqBH
         kqOJUykLyVvAFrByg5E5W8o0nLkx05c43UxSgTSotKysQBd8yu87CvA9sYRMrk5nkQL2
         cDYCUlnMUJRtAs1r9+WkaXD+vKxK0v1OLD3cXFkJPYf9Rtf1NhQttNXPJForoOsXTWgD
         6zQKIT1bbB8d6TiO6hmfgG5eqCwy/3Ag90JeEyj2m6jv/H5ZVg0yWGO9hwz95OZLZDxl
         wPXZj7wjQwaXiVCufZAqz8uXLpOfaLn/Femc24m8iffSfsaEKRCXqkL2ddhzB57E4O4J
         yNfw==
X-Gm-Message-State: AOAM532Z8oa1se92/2umAr9v9Z/2ZqRMfrZN3XGJ/4svBbpJFcfqvNtx
        +yKfzF70gPrwu8OERDmbyrSSIwBi/EDHL/rQwrTqy3KxrV8=
X-Google-Smtp-Source: ABdhPJz/u90YIGUwvFKhLm/dKquyjUMBvVr9KeTsBvCnYj9v1IaLHljr/7stL7ZGkBeLLgHknuPafMW7Sq9JJG39Jso=
X-Received: by 2002:a02:9665:: with SMTP id c92mr2512133jai.56.1624939734777;
 Mon, 28 Jun 2021 21:08:54 -0700 (PDT)
MIME-Version: 1.0
From:   manty kuma <mantykuma@gmail.com>
Date:   Tue, 29 Jun 2021 13:08:44 +0900
Message-ID: <CAB6A5-CnnwQTYQ2268GGRSwnzFQvsLK=sVbn7XAGNrNG-vDr1g@mail.gmail.com>
Subject: preempt_rt: drm: frequent DRM hangs with 5.10 preempt RT kernel
To:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

I am using 5.10.41 with RT patchsets and consistently seeing GPU hangs
as shown below.

-----
i915 0000:00:02.0: [drm] Resetting rcs0 for preemption time out
i915 0000:00:02.0: [drm] abcd_plannings[13636] context reset due to GPU hang
i915 0000:00:02.0: [drm] GPU HANG: ecode 9:1:85dffffb, in abcd_plannings [13636]
-----

The GPU hangs only when using the PREEMPT_RT. Without PREEMPT_RT,  the
driver is stable.

Raised an issue with intel.
https://gitlab.freedesktop.org/drm/intel/-/issues/3625
The response to the issues raised for drm hangs seems to take forever.
So, I want to see if i can do something to figure out the issue.

Checking from the past history, seeing commits like
1dfffa0051eae890ce36924651ecff60df5d779e, i see that some adaptations
are necessary for DRM driver to work as desired on PREEMPT_RT. I am
hoping something like that is needed to fix this issue too.

Any directions on how I can debug this further? I have a kdump
solution in place. Currently I am planning to trigger a panic right
after a hang is detected and see from the dump if there is any clue as
to what the real issue could be.

Any pointers/probable fixes/suggestions will be very helpful!
Thank you

-Manty
