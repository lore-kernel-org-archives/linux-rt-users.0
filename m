Return-Path: <SRS0=V9Xa=WK=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672B4C433FF
	for <linux-rt-users@archiver.kernel.org>; Wed, 14 Aug 2019 17:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CD48206C1
	for <linux-rt-users@archiver.kernel.org>; Wed, 14 Aug 2019 17:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AS5dcPRn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbfHNREh (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 14 Aug 2019 13:04:37 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45365 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728597AbfHNREh (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 14 Aug 2019 13:04:37 -0400
Received: by mail-wr1-f65.google.com with SMTP id q12so21516981wrj.12
        for <linux-rt-users@vger.kernel.org>; Wed, 14 Aug 2019 10:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/EVWf+xWjvMsOKZ8OcbBXxb08l0Jiaai1ZK2ldA0K3I=;
        b=AS5dcPRniYAr/hXMD5VyThZvnF1yNmi0gHZPMnSvIHbJjqGLHDTMty0D+fH0+kbq1T
         D7oWBkKMlUc7+1SWcOQAGgfMDVggTsfeD1mzfOYq6AvglgyTN4iA47pjqRfzjlPxnxHe
         XZSa6w7IPihDeD2mQKIDpqxfJQk+xlBBL9ZeMPAGq5zF+UTH9NLaOvMUq3sZV8W/G2qH
         PEZ5fBhSxD5t1uz4uDwbaN4VATs1Lna9M4OG57lY+PlR8jne5UZgjbh+2TecmeNaenrs
         EwZexPgZO6EdqWX9VjkeJ52RwrIUiEoJGW98P12UADPdQxS0eeZg2Awru71gSDSS354A
         k1HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/EVWf+xWjvMsOKZ8OcbBXxb08l0Jiaai1ZK2ldA0K3I=;
        b=Sm9enNocwCibcVSTH/BNKMB/sY1g7+AkHgx+ZwkHYsxRwtLp9RTbJWBXue4c4KZ/eB
         ZAfOU6HieS0T1soY6ZKUMlcXvtEefUmh8u0u/gYuuPCoKavHR+23C7bv1/kOb5lXIJpa
         zizYu7E8hk7Mr4RJIM9B0X9VgvM+ux34L/zhXOrKa8sF5ZoXjPDS1rmVAUeTOeWH3eWd
         UcYMY2+JBZzJOl/fWe1QMl+xkWmwjk4m83JBVfaitiS+5MHPeLyb2kRFgZgYPaQ36D+a
         qWtRXRy/OTSFnwWes5bkpwp7uaan4gNyRu5s2RXPx44FqNQVXbFyImCU+SA3n6iJWQ7i
         16lg==
X-Gm-Message-State: APjAAAWmRy1VxnyRNXmjwb0COcubPdBE816SDJVNlB5diNFbXsi4JO1T
        ZYzlsndigiNA4+LmG+nBno2px5Zm/wPEBdxFFws=
X-Google-Smtp-Source: APXvYqwirqCcxWVAPKqk/WmKCQCs1fi8PW9ljuMBT0MN8HtrE1lAgqk6ZPTb7djxsE3emqkX2aFdvIL4SwDDnlkaEUw=
X-Received: by 2002:a5d:564f:: with SMTP id j15mr764904wrw.326.1565802274943;
 Wed, 14 Aug 2019 10:04:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAD56B7eF_KhWvg=m6iy5YSJF-81v-zcmX7+8Kd0wGMrALHwU1A@mail.gmail.com>
 <alpine.DEB.2.21.1907170111160.1767@nanos.tec.linutronix.de>
 <CAD56B7eswTRxbeA8foXyVVZ7Bd+_y40dtOLkHxuAf4kVge7VDg@mail.gmail.com>
 <alpine.DEB.2.21.1907171001150.1767@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1907171009280.1767@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1907171101150.1767@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1907171220400.1767@nanos.tec.linutronix.de>
 <CAD56B7eomeb5Lr2juFWtZmtqSx3SkPijW03QZz8xv39He26PrA@mail.gmail.com>
 <20190813095306.xqgq3uusdpj7dhy7@linutronix.de> <CAD56B7fqosJAhiCLikhcxv_3wY7ETOv++kmQcr-=9NKEGq7Agw@mail.gmail.com>
 <20190814112656.z3de2rgbqzpaquz5@linutronix.de>
In-Reply-To: <20190814112656.z3de2rgbqzpaquz5@linutronix.de>
From:   Paul Thomas <pthomas8589@gmail.com>
Date:   Wed, 14 Aug 2019 13:04:21 -0400
Message-ID: <CAD56B7ezpaONhXCddu6RTE33-iXG7+J=xf417xu_uT-YKPV6RQ@mail.gmail.com>
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

On Wed, Aug 14, 2019 at 7:26 AM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2019-08-13 14:02:39 [-0400], Paul Thomas wrote:
> > I still get large latencies, like this:
> > root@xu5:/opt/rt-tests# ./cyclictest -h ./cyclictest -S -m -n -p 99 -i
> > 200 -h 400 -D 900
> > # /dev/cpu_dma_latency set to 0us
> > policy: fifo: loadavg: 0.10 0.10 0.03 1/134 1901
> >
> > T: 0 ( 1886) P:99 I:200 C:2724618 Min:      5 Act:    6 Avg:    6 Max:      45
> > T: 1 ( 1887) P:99 I:200 C:2724525 Min:      5 Act:    7 Avg:    6 Max:      29
> > T: 2 ( 1888) P:99 I:200 C:2724246 Min:      5 Act:    6 Avg:    6 Max:    6338
> > T: 3 ( 1889) P:99 I:200 C:2724339 Min:      5 Act:    8 Avg:    6 Max:     141
> >
> > This is with the Lazy preempt commit in there.
>
> I re-read the thread and figured out that you talk about 5.0 while I was
> testing on 5.2. On my ARM64 box I end up with
>
> |T: 0 ( 9577) P:99 I:250 C:19979015 Min:      3 Act:    4 Avg:    3 Max:      19
> |T: 1 ( 9578) P:99 I:250 C:19978958 Min:      3 Act:    3 Avg:    3 Max:      24
> |T: 2 ( 9579) P:99 I:250 C:19978901 Min:      3 Act:    4 Avg:    4 Max:      22
> |T: 3 ( 9580) P:99 I:250 C:19978843 Min:      3 Act:    3 Avg:    3 Max:      19
>
> with the patch I sent you. Without it, had spikes between 130us and
> 160us. Since you said it is not working, I looked more and came up with
> this:
>
> diff --git a/arch/arm64/include/asm/preempt.h b/arch/arm64/include/asm/preempt.h
> index 3bfad251203b5..ca1c6fe8dd347 100644
> --- a/arch/arm64/include/asm/preempt.h
> +++ b/arch/arm64/include/asm/preempt.h
> @@ -73,6 +73,8 @@ static inline bool __preempt_count_dec_and_test(void)
>         if (!pc || !READ_ONCE(ti->preempt_count))
>                 return true;
>  #ifdef CONFIG_PREEMPT_LAZY
> +       if ((pc & ~PREEMPT_NEED_RESCHED))
> +               return false;
>         if (current_thread_info()->preempt_lazy_count)
>                 return false;
>         return test_thread_flag(TIF_NEED_RESCHED_LAZY);
>
> but this shouldn't make any difference for you (but it is a bug fix).
> Staring more into it, I don't see anything wrong.
>
> v5.0 is not supported any more. Do you think, that you could re-test on
> 5.2-RT with those two patches I sent you?

Hi Sebastian,

Yes, for the test yesterday it was using 5.2.0-rt1, I should have
explained that in the first response, since I posted this we have
moved to 5.2.

I added the second patch as well and it was still happening. I took
another trace data set in case this is helpful.

I added an attachment to the bugzilla bug:
https://bugzilla.kernel.org/show_bug.cgi?id=204189

The attachment is here:
https://bugzilla.kernel.org/attachment.cgi?id=284391

We don't actually need Lazy Preempt, so now that we know what the
issues is we can just turn it off in the config? However I suspect
everyone wants to get to the bottom of what's going on at this point?

thanks,
Paul
