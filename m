Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C86C4338F
	for <linux-rt-users@archiver.kernel.org>; Thu,  5 Aug 2021 20:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B74260F22
	for <linux-rt-users@archiver.kernel.org>; Thu,  5 Aug 2021 20:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240732AbhHEUQp (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 5 Aug 2021 16:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbhHEUQo (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 5 Aug 2021 16:16:44 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51D7C061765
        for <linux-rt-users@vger.kernel.org>; Thu,  5 Aug 2021 13:16:28 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id m193so11061603ybf.9
        for <linux-rt-users@vger.kernel.org>; Thu, 05 Aug 2021 13:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aurora.tech; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=xNIAL/Br8Kc/gNGTfEpLj+H4F6s0OrzVI0H2h19v/FI=;
        b=a1vETulMnixcNaslt0V4vQJ9BpDlGRDHRyPow/5NUMKlU4Vj0WygFJxCbjfb1M4RwV
         1Z+zP4DBxoWb/XpskYfJECIsPwjqJntvhtor1aY6v1LM1ZKpTvjCvjKqrOCUlWbIfn2l
         WZaxw7GP94jJOsyTXAY3xRM+7hnT4l1sYFyN3N+2lCfkK+Ag54XUXRoGlGqMftXdCb0l
         p46N9uGMCWZXIVMwjLyW3dPluloK1WRauGdpa1onrkwKKEt0S0+jHusYDu6mLvZdAf2J
         UWHDaMvNR0eyZFBgasbuGdfhsQFT+rr53uqCRNCv54OUFNhKoPTlN+mxgEashgcvLsws
         8aiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=xNIAL/Br8Kc/gNGTfEpLj+H4F6s0OrzVI0H2h19v/FI=;
        b=iO7ftsLrba6wv1jAB8Mkl1n4z7uOCH7FSb9VRFHD3DiuwiF1DjxkiPPB6KTX4nWZpW
         hQjkYmwjVD+i+/r04NWrH0lA3hfhrmytOPzV8tKTiOHIHnrHSbD630UWMSsnyLflu4l8
         xNt/slHpTkEbCI/GykOMKLPUz6UhbLjd+3sRuHZhMPS8KHFpJ3PjWhAcGl7ITOIxVHFF
         z2H8v7XguArcydOvIb7nu1xxJpiMONEvMQ3AEYCMAXGf1mfluD3RyKmuKNHXldEswmQh
         LtPdXYZMI4PtklPRdnOz8zDVMuhUh3lIBz+G+TaLy6aL6uShiEcByh2qOCMSyfmYPB/4
         NvOA==
X-Gm-Message-State: AOAM530Yz3a78zvVWtSpijuRQ/adWt4b3KEYpMVMVThupbudOV9RXD7x
        gh76+mieD9bQ9w4KW7IaBe1R+PuzPOY4XWhTnZb4I7OWsywEYg==
X-Google-Smtp-Source: ABdhPJxvMSqs6RC6GygNrW/ACUU3EZS44/6v9RQcu7jZ5WL6VvsHCkZDVmWmJMbvFPRmn0ip2bbVtks1BOUk4M98NIU=
X-Received: by 2002:a25:8082:: with SMTP id n2mr8270376ybk.79.1628194588139;
 Thu, 05 Aug 2021 13:16:28 -0700 (PDT)
MIME-Version: 1.0
From:   Alison Chaiken <achaiken@aurora.tech>
Date:   Thu, 5 Aug 2021 13:16:17 -0700
Message-ID: <CAFzL-7sj+Y79UC-CnB+6qDRe7EgPnjb0be63CwEJOfkdCvJYVw@mail.gmail.com>
Subject: hyperthreading and RT latency
To:     linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Daniel Wagner <dwagner@suse.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The advice in the RT wiki

    https://rt.wiki.kernel.org/index.php/HOWTO:_Build_an_RT-application#Hyper_threading

about configuring the kernel and building RT applications was written
in 2014, when we were on the 3.x series.   That makes one wonder how
relevant some of it is for the 5.x series, especially since processors
in common use have changed some since then.  Some of the advice,
notably about power management, obviously is timeless.

In particular, Daniel Wagner added:

    https://rt.wiki.kernel.org/index.php/HOWTO:_Build_an_RT-application#Hyper_threading

    "Hyper threading and also out of order execution of CPUs introduces
    'random' latencies. As mentioned in power management, it is
     recommended to disable these feature (if possible) or carefully
     benchmark the performance."

Is the advice still current?   Should we RT-users all still turn
hyperthreading off?   Given the security vulnerabilities associated
with hyperthreading, there are clearly some use cases where doing so
is indicated anyway.

Thanks,
Alison Chaiken
Aurora Technology
