Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD64C04A68
	for <linux-rt-users@archiver.kernel.org>; Thu, 28 Jul 2022 19:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbiG1TvJ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 28 Jul 2022 15:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiG1TvI (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 28 Jul 2022 15:51:08 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07FD21E28
        for <linux-rt-users@vger.kernel.org>; Thu, 28 Jul 2022 12:51:07 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id q18so3574328wrx.8
        for <linux-rt-users@vger.kernel.org>; Thu, 28 Jul 2022 12:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hc8tNYTSdzLvTo670mXF8ACqL3yRvg61zCqsdXamFkg=;
        b=kiCYc3LELQVweS/lhrZGzKGjmfGa80NTv92+ximWlZI4Ia4Hjtzl98wutjRD25o9cN
         RByRe3gSvl1wij2avgem+s4eekI4H0fgP3R1gWjiImSoblTRrjVZFp5nmF7IpcHt/ixW
         BWxee6/2NcOjJH/mfNezfP7o0+tHlX9XwbRA1/TDAIJwT+UfB5c/JwEA54edVQUTjjCB
         gokqHWcm/gn1rzFsWoObVC22i6VBRj/UT2bAy7pjixTrbvqFFoJ396xcqrmL+5vizTB6
         iEgGkyx8J2T8Vc/lCOUGAIo1XRbcH+LPuXxdjReMnTS+2/Nyn4pBj7b+tzP1bYOaBnXc
         9L6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hc8tNYTSdzLvTo670mXF8ACqL3yRvg61zCqsdXamFkg=;
        b=qHYQfr2TFtukPVSTTpbPuDcZSXDWm/mU7sX2uLBZDqE0okqa59MRxbLclQVG7LVyWv
         C9sb9boJKDI/uH5uDKVMeR0grGBd044BWUwn5GFOfr+/Z3Q4MecKkibom9Gr4QmWlqlL
         HSFCgOaSGAvigLcknh1L4quyP2e8udAb47c7nvm/lca8lzpWZnsSRd+Ijs3GfjSu/bVF
         hopKgvXM2YyYLfg5XhvtHaZG6w5+TjtjO/tl8TJ2JkikukyiKmyOEaDjqV1wzf8LMPvp
         1x4zrAhRdG0xoraXDrcr5RDdUqb0dP1+fsKT8h1a48E8FEFemWHzbkzCBi6+4dAIU/Kd
         W0vg==
X-Gm-Message-State: ACgBeo1tHYsEEvJYiZQBj0vUkqdTuou7JbKcYbHX/xvU53PRrsDd9oNK
        LvUTapW+BEMbNV1MbLxKFZNBam8pPz/5MHv36+fc
X-Google-Smtp-Source: AA6agR545VIvg5ZkorYjGVQ/qjbTWavMmqg5AZND4NrreckMEGh67Qmius8EPp1om3CFstRHaNXzg0xSm5PEptsFUgI=
X-Received: by 2002:a05:6000:1d86:b0:21d:6433:1455 with SMTP id
 bk6-20020a0560001d8600b0021d64331455mr309115wrb.514.1659037866117; Thu, 28
 Jul 2022 12:51:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220726180502.2932619-1-jstultz@google.com> <da2be617-4f3e-9733-2ae3-42d1c271107a@redhat.com>
In-Reply-To: <da2be617-4f3e-9733-2ae3-42d1c271107a@redhat.com>
From:   John Stultz <jstultz@google.com>
Date:   Thu, 28 Jul 2022 12:50:54 -0700
Message-ID: <CANDhNCrUnnrTkN07XJQFQdKyr2YiAu=pWLMmPkv9bMDfXmq2qw@mail.gmail.com>
Subject: Re: [PATCH] cyclictest: Fix threads being affined even when -a isn't set
To:     John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org,
        "Connor O'Brien" <connoro@google.com>,
        Qais Yousef <qais.yousef@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, Jul 28, 2022 at 7:48 AM John Kacur <jkacur@redhat.com> wrote:
> On Tue, 26 Jul 2022, John Stultz wrote:
> > diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> > index decea78..02f32f6 100644
> > --- a/src/cyclictest/cyclictest.c
> > +++ b/src/cyclictest/cyclictest.c
> > @@ -1270,8 +1270,6 @@ static void process_options(int argc, char *argv[], int max_cpus)
> >       /* if smp wasn't requested, test for numa automatically */
> >       if (!smp) {
> >               numa = numa_initialize();
> > -             if (setaffinity == AFFINITY_UNSPECIFIED)
> > -                     setaffinity = AFFINITY_USEALL;
> >       }
> >
> >       if (option_affinity) {
> > --
> > 2.37.1.359.gd136c6c3e2-goog
> >
> >
>
> Okay, I see what's happening. We removed the numa flag to automate if
> the user doesn't specify smi, then we use numa if we detect that it is
> available and in that case we assume AFFINITY_USEALL. Part of this was an
> attempt to reduce the alphabet soup that the cyclictest commandline was
> becoming. However, I see your point, if a person doesn't ask for affinity,
> then, it shouldn't be assumed.
>
> Your patch of course doesn't work as it is, because we'll end-up passing a
> cpu=-1 value to rt_numa_numa_node_of_cpu(int cpu) resulting in
> FATAL: invalid cpu passed to numa_node_of_cpu(-1)
> but it illustrated your point.

Ah. Apologies! Interestingly I didn't see this on the device I was
testing with, but I can reproduce it on another system.

> I'm off for a few days, but I'll tackle this when I come back on.

I've got an approach that in the numa case, has a separate node_cpu
value which is normally cpu but if cpu is -1 it will use the result of
cpu_for_thread_ua(). That should at least match previous behavior with
regards to the numa allocation logic.

I'll send that out in a second here and you can take or tweak it as
you feel best when you're back.

thanks
-john
