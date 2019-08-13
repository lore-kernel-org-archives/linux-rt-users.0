Return-Path: <SRS0=IBCX=WJ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CBA1C433FF
	for <linux-rt-users@archiver.kernel.org>; Tue, 13 Aug 2019 18:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C9232064A
	for <linux-rt-users@archiver.kernel.org>; Tue, 13 Aug 2019 18:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gmC7bIVl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbfHMSDN (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 13 Aug 2019 14:03:13 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35794 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbfHMSDN (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 13 Aug 2019 14:03:13 -0400
Received: by mail-wm1-f68.google.com with SMTP id l2so2234202wmg.0
        for <linux-rt-users@vger.kernel.org>; Tue, 13 Aug 2019 11:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d+9pQCC+EWRe0v9lAdcgSEcVFLJmrGAo4hVOIzlOJQY=;
        b=gmC7bIVllTX+nGxe+pCeB1RRtCFyjvouMv/S7Y2MznPgNFLNjDiBFz6qCbNEfxL2K4
         9Yf9MdEHhAsFTEBjmrk3b9HIAT34AvAj2OYANWsmHRe2vMpiVu/5T3d4V497qBWvLx4G
         9yKafgyTUQ4yTeeXwX7zSY3qsjWrn3ZWKp9a6EZrYGt2VXZ/GybjI7WqSYzqPKOb+wS8
         7x4Q8Lwv/gCnSgvcg5Ts2/jKNFqepuPQceBHwlQy/7jbe9C1QCs3jqLYwVtNt0i6BKcs
         lhF/qPJBpPvuPey4mg56SPYxCMvS2eIhtCLJ1THYLXESDi4bVJYtpghZjA6f4+0J3fBt
         j3yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d+9pQCC+EWRe0v9lAdcgSEcVFLJmrGAo4hVOIzlOJQY=;
        b=PfXZRR00/Oq5jzcrUHFcvNE74fAVsYpi2kbIxxor/XgzjPD8zikl0i39fQZ++V43pQ
         0GwQruUJ1SvufbLmaNZvM4VsSGJbeHuJ8ENvdaiZGGYhFUS8tl3ixyd4V7uopoTA6LhL
         uwnHfBdOv66hbQ0+KW26KGrSuWjxFFmfxnoc2DY8qQq0KKJpC9aBnNhAClWSp4ZTKgtt
         894NWWecQcOIr8P76I38dfke4bemdWZXNJ86kEjBai1/7/EwckYvBqL5jDx7z0qlcUwL
         8qEIbXzrvQ+XlH1JQeTq3X4NeJvn/vnWmkm8AdFqOCEQglmTXOLbsNyA+ETy0O0ilyEV
         p5Jg==
X-Gm-Message-State: APjAAAW/5nB7vDXarmwW/WbLCmvJpM5B0qKFtMRmkNGKGgefya1T0lfe
        XEW4nKAfd9PTzB4SpJBkqbee8YK7JWu+9e3wAj+RniLH
X-Google-Smtp-Source: APXvYqyZ+3/gYTEu5EZlISpPD6pjtOHDuD+chiMH7id+kqz+EBeeC6cb1ttMkKvEtuLDYzYh28tcNE+XE1lFI90Pp/g=
X-Received: by 2002:a7b:c929:: with SMTP id h9mr4694463wml.1.1565719391067;
 Tue, 13 Aug 2019 11:03:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAD56B7fdr5w0Pk5WHVWXa1ORyM=i+Ew66O+8buBwH0geeX+X0Q@mail.gmail.com>
 <alpine.DEB.2.21.1907162221350.1767@nanos.tec.linutronix.de>
 <CAD56B7eF_KhWvg=m6iy5YSJF-81v-zcmX7+8Kd0wGMrALHwU1A@mail.gmail.com>
 <alpine.DEB.2.21.1907170111160.1767@nanos.tec.linutronix.de>
 <CAD56B7eswTRxbeA8foXyVVZ7Bd+_y40dtOLkHxuAf4kVge7VDg@mail.gmail.com>
 <alpine.DEB.2.21.1907171001150.1767@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1907171009280.1767@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1907171101150.1767@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1907171220400.1767@nanos.tec.linutronix.de>
 <CAD56B7eomeb5Lr2juFWtZmtqSx3SkPijW03QZz8xv39He26PrA@mail.gmail.com> <20190813095306.xqgq3uusdpj7dhy7@linutronix.de>
In-Reply-To: <20190813095306.xqgq3uusdpj7dhy7@linutronix.de>
From:   Paul Thomas <pthomas8589@gmail.com>
Date:   Tue, 13 Aug 2019 14:02:39 -0400
Message-ID: <CAD56B7fqosJAhiCLikhcxv_3wY7ETOv++kmQcr-=9NKEGq7Agw@mail.gmail.com>
Subject: Re: poor cyclictest results with 5.0 series rt for arm64
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        dunc.mcphie@gmail.com, Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Aug 13, 2019 at 5:53 AM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2019-07-17 18:28:51 [-0400], Paul Thomas wrote:
> > On Wed, Jul 17, 2019 at 6:21 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> > >
> > > On Wed, 17 Jul 2019, Thomas Gleixner wrote:
> > > > On Wed, 17 Jul 2019, Thomas Gleixner wrote:
> > > >
> > > > The one below should fix it for real.
> > >
> > > That still has an issue which needs deeper investigation. Just keep the
> > > offending patch reverted for now.
> >
> > OK, sounds good.
>
> could you please try the following hunk?
>
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index 6808cd9526c67..63c6960262861 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -648,7 +648,8 @@ alternative_if ARM64_HAS_IRQ_PRIO_MASKING
>         orr     x24, x24, x0
>  alternative_else_nop_endif
>
> -       cbnz    x24, 2f                                 // preempt count != 0
> +       cbz     x24, 1f                                 // (need_resched + count) == 0
> +       cbnz    w24, 2f                                 // count != 0
>
>         ldr     w24, [tsk, #TSK_TI_PREEMPT_LAZY]        // get preempt lazy count
>         cbnz    w24, 2f                                 // preempt lazy count != 0
>
I still get large latencies, like this:
root@xu5:/opt/rt-tests# ./cyclictest -h ./cyclictest -S -m -n -p 99 -i
200 -h 400 -D 900
# /dev/cpu_dma_latency set to 0us
policy: fifo: loadavg: 0.10 0.10 0.03 1/134 1901

T: 0 ( 1886) P:99 I:200 C:2724618 Min:      5 Act:    6 Avg:    6 Max:      45
T: 1 ( 1887) P:99 I:200 C:2724525 Min:      5 Act:    7 Avg:    6 Max:      29
T: 2 ( 1888) P:99 I:200 C:2724246 Min:      5 Act:    6 Avg:    6 Max:    6338
T: 3 ( 1889) P:99 I:200 C:2724339 Min:      5 Act:    8 Avg:    6 Max:     141

This is with the Lazy preempt commit in there.

thanks,
Paul
