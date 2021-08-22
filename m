Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11AF0C4338F
	for <linux-rt-users@archiver.kernel.org>; Sun, 22 Aug 2021 06:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D63C16125F
	for <linux-rt-users@archiver.kernel.org>; Sun, 22 Aug 2021 06:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbhHVGzB (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 22 Aug 2021 02:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbhHVGy6 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 22 Aug 2021 02:54:58 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A59C061575
        for <linux-rt-users@vger.kernel.org>; Sat, 21 Aug 2021 23:54:18 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id v2so13957755ilg.12
        for <linux-rt-users@vger.kernel.org>; Sat, 21 Aug 2021 23:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bw5MEWjnKdkVXtnKDHViMdISNzvV+RAmBKX/6IZMj5g=;
        b=jDly84dSEk9CkPqnaFxNmtH1dzzd5pa9i2vsnEjxKlIgbwmOWNz7bxEKwdbj1mr4nn
         /6IJKVn70xsTlbd7e2kN3BwuR+utOEIgmvoFzrEq0R45VGpKS24fvZ0uKfFG1lvkbrqM
         6+6ynfk89+6Z/R2C49mWSOryY/hTgEeJUY24tzIEBPpRyPlPuvgSo1GolWo8jHGGxJlv
         WtjGPjtGanM5A7TfDETpVhchcw2AY/6UBV6DzujWowWEqoP/+kZ3kf9XpOFykK/kesLy
         0+4LezQjERdBMjKEdZR151cOZ05PcG3JTp5FsMhWU0Onn/QOxJUjRdvK3Ev3LskY8o9t
         Qung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bw5MEWjnKdkVXtnKDHViMdISNzvV+RAmBKX/6IZMj5g=;
        b=oJY5Q6bqd+VfEgYyYQwI4B+2h+4QASQOLpyYEov7dxYpUnRaAAJLJusFgUdKy+P0sS
         eCvsgvUCVwj5dpDjiTOVvIB8P2Ta6YxouP2IZC7BSPB8VnPpuaMW6sW3A87fbsWqHiLX
         nW59Kvw5cssDg+Nba9Eg5iD2q9zIOUNqR0iP0urIYF3SMPC9p+TusTT4pJi+dv+afptr
         vfwKCBrS7Xgfn6LO1NaJbVDK7UvoGwNsNFjpKJVXfzTscsVesGLglY4d1HMdGYq43Rjn
         7k+BKK/CXUfWqenEYJzZEUgPHJpV4WluXz+Ln5v9s9JOET+l0fDOW3SEDlVljd0aLCpS
         Jz8w==
X-Gm-Message-State: AOAM53240f22KFHU7YacOntg8CiyJnoj4wMQ+ubJwhFsQCzA0RaII9Ed
        5kp/9JjMdBKBVPW93cXwM97Au0seg1/zTaSORT4=
X-Google-Smtp-Source: ABdhPJyazD8VLIW+r0xOMOKSL/o/MEnerhCnefaEVN3BNxtT9uNGfgK6UfgE1yeGweu5+S0Emn6vGDc46kBeAx09uB0=
X-Received: by 2002:a05:6e02:1aa2:: with SMTP id l2mr11174528ilv.168.1629615256918;
 Sat, 21 Aug 2021 23:54:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAFzL-7vTPxWeXbd4cUBpJ--CfYj6TiRp1E_BYWHTgzJtUYWCew@mail.gmail.com>
In-Reply-To: <CAFzL-7vTPxWeXbd4cUBpJ--CfYj6TiRp1E_BYWHTgzJtUYWCew@mail.gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Sun, 22 Aug 2021 14:53:40 +0800
Message-ID: <CALOAHbD+HwzXJMsmCxdqMyFod6f+a3ka4dW0nPHTcH1xDs9ZwQ@mail.gmail.com>
Subject: Re: Re: Re: [PATCH v2 0/6] sched: support schedstats for RT sched class
To:     Alison Chaiken <achaiken@aurora.tech>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        Andrew Woods <awoods@aurora.tech>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Alison,


On Sat, Aug 21, 2021 at 3:02 AM Alison Chaiken <achaiken@aurora.tech> wrote:
>
> In https://lore.kernel.org/linux-rt-users/CALOAHbDZPo65Vc89sVCuYkJ6vr=zD-4ev=JN=j7ZAzKHzRibdA@mail.gmail.com/#t,
> Yafang Shao <laoar.shao@gmail.com> proposed changes to schedstats that
> would add support for RT-relevant schedulers to schedstats.  As far as
> I can tell, these patches were neither merged nor explicitly rejected.
>   Is that correct?

+ Peter, Ingo

The scheduler maintainer didn't give any feedback on this patchset.
Maybe they don't have any interest in it or they ignored it.

>  If mainline kernel has not accepted them, is
> there any reason that linux-rt-devel should not?    Perhaps
> linux-rt-devel wants to stop accepting patches that are not part of
> mainline in preference for moving them to staging in anticipation of
> becoming a pure-Kconfig option?
>

I think the best way is to merge this patchset to the mainline kernel first.

This feature can be disabled by setting  kernel.sched_schedstats to 0,
so I don't think we need to add a new option for RT schedstats.

I will refresh this patchset and resend it again.  Hope the maintainer
can give some feedback on it.

-- 
Thanks
Yafang
