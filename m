Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AAC4C433E6
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Mar 2021 17:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C630064FF3
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Mar 2021 17:05:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhCKRFU (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 11 Mar 2021 12:05:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbhCKREr (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 11 Mar 2021 12:04:47 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6ECFC061574
        for <linux-rt-users@vger.kernel.org>; Thu, 11 Mar 2021 09:04:46 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id n16so40985945lfb.4
        for <linux-rt-users@vger.kernel.org>; Thu, 11 Mar 2021 09:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=austral-dynamics-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Wk1i/+E59VN2p1GZdqBrFpoZ/HXhq+1XbL87BkgAge4=;
        b=GNuBLxVa+wcxkQ/IY1Cg1+V/SdTiR9m61FjABnYHITYh/AWfCnBkRgGqDL9zPmIQM3
         yGcc+N9qin/s2fEMIWOeSrcUnTh8i6TD8WxljA2NaJm6UKZp7AzDij/CFXLLMeEGGlN9
         CC4v/KS2AA2nzVvgqy3LDmyQyYMQDBCpz8P0+q/fU/PVRwkiQru4n+hsLOGUnexu1fz9
         pIFECIHgtHCcWw0meFj8jraJMMVe0VFTMQITzt3tOh7S7VaS6FRNzWNA/Yh+oqaEVz0w
         b7yr+VI9/Zfalgv1wbbDl87a0yz0A2TE69LPok73Wq/z6KF0l6N74YOX4Q2w4Rk66wP/
         7cCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Wk1i/+E59VN2p1GZdqBrFpoZ/HXhq+1XbL87BkgAge4=;
        b=scVr7QJpN8bu8owi1kEm/bFbT/4Zg0dkh4UUqGavY9zbSZYOelkWZT1cN7vjGqCMJJ
         TMmAqFKFUzxE4TjKV9UJwN3K3WIqgFWQ1SCAzGKlgBHw6YVC0FKe2mhVnkcN0Nyt/uUL
         djNSJ+UdAeXFcKdDLGEzyb1g/zDolubxTB8lA+fqKD8JV/0QYHrUkxjKs00J737OJbMz
         TUBuQ1hPLldPxutGwnmLHUckw5yddlzJPcCiuPlUXXnTdBD3Il7/4exYtr5dvkhiugH6
         oSecSgaWib9SxwYypkvHTNb2zJThmir52OeX+AR3cFiOL7D2m//uyssQ/K86Os+eHAwT
         WHCQ==
X-Gm-Message-State: AOAM531Jhb8VSX2+nmpvL4/xx5IdgH54GT7kzX/Cc82aA/6Po7nnyovm
        pjteesvgcF4MgXzlqtwuw7/kfo5QOX3jBWLKEV4m19jOXY0590V2
X-Google-Smtp-Source: ABdhPJwtupjA0ObzZ9xABi74Z2LZdnWFdXoUnnWvxbhMLR50W8aLVKRCyKmLA5Xp0q8wt297+4ZPI3kUEf2cr+G+1rw=
X-Received: by 2002:a05:6512:2212:: with SMTP id h18mr2804803lfu.330.1615482285301;
 Thu, 11 Mar 2021 09:04:45 -0800 (PST)
MIME-Version: 1.0
References: <CAKkbJ-ypaPZ5JKpXD+PykvO6oYzxEUdxXY2RbVJKWdGY3ALuLg@mail.gmail.com>
 <9be68ca5-9fec-161c-1b37-1b47c0a1d845@monom.org> <CAKkbJ-x4Er7RKhvrThtmmf-MT5uakdkc2G0ZL06i-fGsmBzmSg@mail.gmail.com>
 <YEpCkqfg4umsS4lv@lx-t490>
In-Reply-To: <YEpCkqfg4umsS4lv@lx-t490>
From:   Michel Macena Oliveira <michel@austral-dynamics.com>
Date:   Thu, 11 Mar 2021 14:02:53 -0300
Message-ID: <CAKkbJ-weFeM5EiBObqULkanBZpA6M9_Pfzu0seZ_cKBnNzEwyQ@mail.gmail.com>
Subject: Re: PREEMPT_RT benchmark
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

>[ again, no top-posting please... ]
Sorry for that,  I haven't noticed, but thanks for the advice.

>Well, if you do it for the benchmark, but not for production, then of
>course, the benchmark is meaningless.

Then in case of a RT application for production I should "live" with
this problem?

>If you're interested, I presented a small talk about the topic here:
  >https://linutronix.de/PDF/Realtime_and_graphics-acontradiction2021.pdf

Thanks, really helpful, but if I understand, in your application
you've used Intel CAT to mitigate the latency and plan to use Intel
MBA as well. Is that true?
