Return-Path: <SRS0=3DPx=UT=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 449FAC43613
	for <linux-rt-users@archiver.kernel.org>; Thu, 20 Jun 2019 21:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18FA6206BA
	for <linux-rt-users@archiver.kernel.org>; Thu, 20 Jun 2019 21:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cu7fE+mp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbfFTVCB (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 20 Jun 2019 17:02:01 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43066 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfFTVCB (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 20 Jun 2019 17:02:01 -0400
Received: by mail-ot1-f67.google.com with SMTP id i8so4116798oth.10
        for <linux-rt-users@vger.kernel.org>; Thu, 20 Jun 2019 14:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YbwLMHJoT9bAMzc7ZVtRowqGV5AriL8qmPCBW9B5Srg=;
        b=Cu7fE+mpd8fVb80qWrvY4Zy8UpK1/kENtrA5mvosTFZvJci9vB72ylOoeJL7+4LPqM
         FnLb/ns3e+CgzIJXN5264gbJhGID/qv31OmfpQu2gRIUbeQplX/uU9MMwgZbcUFTPnVP
         on6vIWcdxodXtzHOnoULocwkL3sA+P5p9BBNmbaZTM7s9CMw7LtS6djVUECbP6ZfjkXn
         6kDNDfeMk0D63QE4u8r1Ngwk2gtwItjkrM72QP/czWCQ0Hrje02Pe0Re7bCfOqXYaHeA
         59z+Vfhzopw6Tva3jKL5Fsm5opYErIwglMyg28rJ8LHiCWhIqquGSrvX2wS1GSLRU8La
         L6xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YbwLMHJoT9bAMzc7ZVtRowqGV5AriL8qmPCBW9B5Srg=;
        b=Ha7WOuJKkK5x7bq1O93QOgzrLo69O8Sxx3RnwLm3EcnLfgaMitMKh/B4OSXWOYrjyQ
         GwQZHtzNYOYJVoFeHvNc0W9t8qwFAl18xcNXZ2lFywcjxHWUkCzsm5uKfBtBu9RYSiKF
         uP9GVcX0vZslG4bvPfi39XW+JgobO6WI63bldxys3kq2Xf512gvlIZC86KHjsi2En5ew
         xo7EjkvtLeC8KKZjSroTy8Z3eBXKFASH9RmOgQxF20S72WsiPl0s6k6ggN9KTQ9exK5b
         4GdyZQkf5v5q41wMv651x2V7S967menzk111I+n7oC8mhp0orya6zdeSjoJeixrOoFIs
         B9Gw==
X-Gm-Message-State: APjAAAV2eNpNFamHaW8YGmO47KpIHlROEoXWrCv0l5cxE21pfz1dAw6m
        7jlC9VNn/Sk5s4d26ze6kyY9l9avVYweYiAkRuv4Qb+s
X-Google-Smtp-Source: APXvYqzYl9K34uXzTOcTmy9iGoSQOcgNdag4+njCTT2PUKKCDYRE42YzH4cVGPw/rXJtnwlcuqw7c+9Aa4R/6apv38Q=
X-Received: by 2002:a9d:66d0:: with SMTP id t16mr40585691otm.153.1561064520832;
 Thu, 20 Jun 2019 14:02:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAEVNDXsR03jGXKO5diQbjMQecS=wXxdEW5eGQAAL1PPOQ_RO6Q@mail.gmail.com>
In-Reply-To: <CAEVNDXsR03jGXKO5diQbjMQecS=wXxdEW5eGQAAL1PPOQ_RO6Q@mail.gmail.com>
From:   Luca Abeni <lucabe72@gmail.com>
Date:   Thu, 20 Jun 2019 23:01:49 +0200
Message-ID: <CAJfkoWqsPJoxeQwxCYAU1kG6ny5BBuiTCpiqM+KgAsZH58trbw@mail.gmail.com>
Subject: Re: sched_deadline sched_setattr fails after setting cpuset
To:     Ming Yang <minos.future@gmail.com>
Cc:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

On Thu, 20 Jun 2019 at 22:25, Ming Yang <minos.future@gmail.com> wrote:
>
> Hi,
>
> sched_setattr for SCHED_DEADLINE fails if it is called after setting
> cpuset that doesn't include all CPUs. The sched_deadline document
> states that cgroup/cpuset should be used for task affinity.  But I got
> errno EPERM when calling sched_setattr, after setting cpuset.

Which kernel are you using? I just tried on 5.0.0 (actually, it is
Ubuntu's 5.0.0-17-lowlatency) and it worked.
I followed the cpuset instructions from the documentation (except for
not mounting the cpuset fs: Ubuntu already mounted it for me), and the
"Minimal main()" from Appendix B of the document.
The SCHED_DEADLINE thread runs correctly, with the specified runtime
and period, and is affine to CPU 0 only.

What did you exactly do, to get the failure?

> Section 5.1 example in sched_deadline document is broken. Not only
> rt-app doesn't run in the way shown in the example anymore, but also
> other sched_deadline program fails.

Yes, rt-app behaviour changed... But other SCHED_DEADLINE programs
(for example, the program from Appendix B) seem to work correctly.


>
> rt-tests deadline_test.c illustrated a working way to use cpuset for
> sched_deadline tasks.  It sets cpuset *after* sched_setattr
> (https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git/tree/src/sched_deadline/deadline_test.c?h=unstable/devel/latest).
> I suppose this is the only way to assign CPUs for sched_dealine tasks
> now.

I suspect this is actually a bug... Juri had a patchset to fix it, if
I remember correctly.


> Can anyone please explain why sched_setattr fails after setting
> cpuset?

It does not fail here... Maybe this is a bug introduced after 5.0.0,
or maybe there is some other difference between your setup an my one.


Luca

>  Does the sched_deadline scheduler rejects both affinity mask
> and cpuset now?
> Does this mean admission test always assume all CPUs and no admission
> test would be examined when setting the cpuset of the task?
>
> Thanks,
> Ming
