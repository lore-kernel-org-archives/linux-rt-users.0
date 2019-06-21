Return-Path: <SRS0=sCGC=UU=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0222C43613
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 Jun 2019 00:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D2A62075E
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 Jun 2019 00:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fN8Io1DZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725921AbfFUAya (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 20 Jun 2019 20:54:30 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:43933 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfFUAya (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 20 Jun 2019 20:54:30 -0400
Received: by mail-vs1-f65.google.com with SMTP id j26so2759759vsn.10
        for <linux-rt-users@vger.kernel.org>; Thu, 20 Jun 2019 17:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FhG56tORuaHKR7TMLHft1EP6k8k9LpLBiCGCkpEnSn4=;
        b=fN8Io1DZpPidQXhOgLOwNRuWVXsnxBgV2K4K0dvSCj7TE+310CR+nc6PmtTfGimkwV
         SiENqpxwEllr95ZrfiLwpG5gowFtG1iMQtrdX6mjvDbiUho+xtE7MnyKTl8gi+1/nnEC
         GJgP8OAspl7fu8kE09OIj2JK9b5W7RNweb9T9FrlkLVdO/BrIHf/iT5ghce2fFfS/xph
         3J499cLX9xppkoS1My2fFD+hJm8hr1LThZLvRtLYBsayL0vLZBRXTxm7EmKnXyWzBBp7
         O+WziGNphisxs8vNZNENfEWhG/B4faFShyDWZn+IbFv1wP3He8VrQsiPvfC5k4G45Wd+
         EuvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FhG56tORuaHKR7TMLHft1EP6k8k9LpLBiCGCkpEnSn4=;
        b=HirHWFRDKUanJBPoZ7xjMfnpoqpaRKdHrYz76WV1fmnoD/s0wP7YU8FvwyS3mowIYV
         3P+gGioKUl+gUkCSvPJUhdPDCeY8I4+rwQ0R4p3RREwjTNE0oTFgdJ+Ej5KFAHYfWePT
         VqxOKH8+qVo7fY0/HiiV1xsa6DANS3cA0tBVHOubB54sOuNMYoY2+PKD8dwP6mlxf78A
         38RoSK15ep0wI+eDbntNWlSsm8W32sVP9tOb8QJ0QOHLRuim9bJUoRNY+ou2jFGu7SXH
         fZZbmoHPke2U4LSCtfDxxm2yyopVfUMdScv3P7kB7f04wBtJIl+s7YbU9wTmorTjdRat
         BRZw==
X-Gm-Message-State: APjAAAUjvIrGklCpzj9+zazbHug43a4IlXTEYqwANMP20LepZ7BWncUb
        5c14y1f5IQsLwq4KnQ3PKuuQFoqZ1zRYuGRgQWI=
X-Google-Smtp-Source: APXvYqzDxxh0Tgj3Y3/Y+D9GPBBqe42YpgrkSN4BjAjOACWsMX/lEG6ZBoTpWo/ORWboqthdnFhec1kAnTEaiBUCJn8=
X-Received: by 2002:a67:d50f:: with SMTP id l15mr62141822vsj.108.1561078469188;
 Thu, 20 Jun 2019 17:54:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAEVNDXsR03jGXKO5diQbjMQecS=wXxdEW5eGQAAL1PPOQ_RO6Q@mail.gmail.com>
 <CAJfkoWqsPJoxeQwxCYAU1kG6ny5BBuiTCpiqM+KgAsZH58trbw@mail.gmail.com>
In-Reply-To: <CAJfkoWqsPJoxeQwxCYAU1kG6ny5BBuiTCpiqM+KgAsZH58trbw@mail.gmail.com>
From:   Ming Yang <minos.future@gmail.com>
Date:   Thu, 20 Jun 2019 17:54:18 -0700
Message-ID: <CAEVNDXv88RvDgWDhxD=3XW=0kO3TSBYy57q0s1u985z1TaaFVg@mail.gmail.com>
Subject: Re: sched_deadline sched_setattr fails after setting cpuset
To:     Luca Abeni <lucabe72@gmail.com>
Cc:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Luca,

Thanks for the reply.  I couldn't get the errno anymore... Sorry for
the confusion!  The minimal main in appendix B runs well for me too.

Btw, rt-tests released today still have the bug.

I have a question about the admission test with cpuset.  Is the
sched_deadline admission test examined with respect to the CPUs
allowed in the cpuset?
I get deterministic admission test result without cpuset.  m-1 cores
can be utilized (not m?).
But with cpuset, the total utilization of accepted sched_deadline
tasks seems not respecting the cpuset and changes every run.  For
example, if cpuset contains 4 cores, I can have task sets (bound to
this cpuset) utilizing 400%, 600%, or 300% before failing to add
another task. It could be my program's issue. I'm still looking into
it.

Thanks,
Ming

On Thu, Jun 20, 2019 at 2:02 PM Luca Abeni <lucabe72@gmail.com> wrote:
>
> Hi,
>
> On Thu, 20 Jun 2019 at 22:25, Ming Yang <minos.future@gmail.com> wrote:
> >
> > Hi,
> >
> > sched_setattr for SCHED_DEADLINE fails if it is called after setting
> > cpuset that doesn't include all CPUs. The sched_deadline document
> > states that cgroup/cpuset should be used for task affinity.  But I got
> > errno EPERM when calling sched_setattr, after setting cpuset.
>
> Which kernel are you using? I just tried on 5.0.0 (actually, it is
> Ubuntu's 5.0.0-17-lowlatency) and it worked.
> I followed the cpuset instructions from the documentation (except for
> not mounting the cpuset fs: Ubuntu already mounted it for me), and the
> "Minimal main()" from Appendix B of the document.
> The SCHED_DEADLINE thread runs correctly, with the specified runtime
> and period, and is affine to CPU 0 only.
>
> What did you exactly do, to get the failure?
>
> > Section 5.1 example in sched_deadline document is broken. Not only
> > rt-app doesn't run in the way shown in the example anymore, but also
> > other sched_deadline program fails.
>
> Yes, rt-app behaviour changed... But other SCHED_DEADLINE programs
> (for example, the program from Appendix B) seem to work correctly.
>
>
> >
> > rt-tests deadline_test.c illustrated a working way to use cpuset for
> > sched_deadline tasks.  It sets cpuset *after* sched_setattr
> > (https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git/tree/src/sched_deadline/deadline_test.c?h=unstable/devel/latest).
> > I suppose this is the only way to assign CPUs for sched_dealine tasks
> > now.
>
> I suspect this is actually a bug... Juri had a patchset to fix it, if
> I remember correctly.
>
>
> > Can anyone please explain why sched_setattr fails after setting
> > cpuset?
>
> It does not fail here... Maybe this is a bug introduced after 5.0.0,
> or maybe there is some other difference between your setup an my one.
>
>
> Luca
>
> >  Does the sched_deadline scheduler rejects both affinity mask
> > and cpuset now?
> > Does this mean admission test always assume all CPUs and no admission
> > test would be examined when setting the cpuset of the task?
> >
> > Thanks,
> > Ming
