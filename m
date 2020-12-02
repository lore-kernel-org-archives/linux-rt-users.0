Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F354EC64E90
	for <linux-rt-users@archiver.kernel.org>; Wed,  2 Dec 2020 02:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94B32221E2
	for <linux-rt-users@archiver.kernel.org>; Wed,  2 Dec 2020 02:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbgLBCHY (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 1 Dec 2020 21:07:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727353AbgLBCHX (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 1 Dec 2020 21:07:23 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB7AC0613CF;
        Tue,  1 Dec 2020 18:06:43 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id f20so307149ioc.12;
        Tue, 01 Dec 2020 18:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tFDfDEdQKBl9vPSL1U8L9C11wjoCJ0q+c95rGgqliG8=;
        b=D2J6O9gFjpj6MNEAWy94WKTlzPC3L/n/KqL+Gwux96KOtm5yK0fBZA8BFh+zQ200YI
         QX9OffZGWfZeL/yFI7WKsIcB7pDuPPneQ6AXSmUB+aUDQfOjavOteEgM40PSlc67KH+t
         VtRogUoAsMHHuBd9y3zFgfPNMDrqChKdft/4/gnxT1wCnEyjbTSa5CcfMWVn8BrFdgZZ
         d53FsD1wDGoSrGk7R2j2CC0bFG9WKdjMnyohyKfaGYX89P3vNPoXzNF5H5utuHNHqKVx
         ty5jS6ngm/CR5AtRNoN6c2F8xNGh80iydj4fw6PgNab3IYaTVQeWTZf/q4KHWgMvouAd
         07mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tFDfDEdQKBl9vPSL1U8L9C11wjoCJ0q+c95rGgqliG8=;
        b=OFpdS/JinyDqOpVIC3QApmI+t0zgBDA+LdY1q6ZykBDYdSbM0HSyn0Xm8zM3bRNP6x
         G0+UOYsFUHf7emVttG5YL5ZDRDRHeDJvrk5AEJe7rBWTsI83aHCmXM01xqqSzAjXs8v8
         XwFmSK72Gp03ofZ36mTUe4Y3eFgBBLM8PFqp7TVfzU7F027murYvl6lmQtGENPq0zM1n
         ubSgAyi/AwaGjwIR54yi6r9YSR0aeTF01Zrciy2WXtm5kaX1GXNGxkasDsiC2aXY6JLH
         W3cFrpSRlKZr+n0DoNqMMexBGemXdWbz2J7UPR+/23zCLVFUz6VRmdFMqkAiQj1kYts3
         6/Tw==
X-Gm-Message-State: AOAM533fP6gAGQlFPz5s++h6bEqCXNdVF6aTNzO9vYXtRNJw9Est68VC
        UJpOjNV2CoVrPtfYurHsxKzdTM5AsYIKAey4Paw=
X-Google-Smtp-Source: ABdhPJyRxOYn6PNwjHcu1kjPRJpZOtYkBWmDj6Wjr6urekinmkTZEsfMFObpBITc55NsJUWGXTCuqNKcbQoCGISzf8w=
X-Received: by 2002:a05:6602:1305:: with SMTP id h5mr179381iov.202.1606874802933;
 Tue, 01 Dec 2020 18:06:42 -0800 (PST)
MIME-Version: 1.0
References: <20201201115416.26515-1-laoar.shao@gmail.com> <20201201115416.26515-4-laoar.shao@gmail.com>
 <20201201124144.GT3306@suse.de>
In-Reply-To: <20201201124144.GT3306@suse.de>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Wed, 2 Dec 2020 10:06:06 +0800
Message-ID: <CALOAHbCMvWGTR9Ks8b-v-nZuU1rJujDQZro3qG2tgGiqFwPO1w@mail.gmail.com>
Subject: Re: [PATCH 3/6] sched: make struct sched_statistics independent of
 fair sched class
To:     Mel Gorman <mgorman@suse.de>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>, bristot@redhat.com,
        jun qian <qianjun.kernel@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Dec 1, 2020 at 8:41 PM Mel Gorman <mgorman@suse.de> wrote:
>
> On Tue, Dec 01, 2020 at 07:54:13PM +0800, Yafang Shao wrote:
> > If we want to use schedstats facility, we should move out of
> > struct sched_statistics from the struct sched_entity or add it into other
> > sctructs of sched entity as well. Obviously the latter one is bad because
> > that requires more spaces. So we should move it into a common struct which
> > can be used by all sched classes.
> >
> > The struct sched_statistics is the schedular statistics of a task_struct
> > or a task_group. So we can move it into struct task_struct and
> > struct task_group to achieve the goal.
> >
> > Below is the detailed explaination of the change in the structs.
> >
> > - Before this patch
> >
> > struct task_struct {            |-> struct sched_entity {
> >     ...                         |       ...
> >     struct sched_entity *se; ---|       struct sched_statistics statistics;
> >     struct sched_rt_entity *rt;         ...
> >     ...                                 ...
> > };                                  };
> >
> > struct task_group {             |--> se[0]->statistics : schedstats of CPU0
> >     ...                         |
> >  #ifdef CONFIG_FAIR_GROUP_SCHED |
> >     struct sched_entity **se; --|--> se[1]->statistics : schedstats of CPU1
> >                                 |
> >  #endif                         |
> >                                 |--> se[N]->statistics : schedstats of CPUn
> >
> >  #ifdef CONFIG_FAIR_GROUP_SCHED
> >     struct sched_rt_entity  **rt_se; (N/A)
> >  #endif
> >     ...
> > };
> >
> > The '**se' in task_group is allocated in the fair sched class, which is
> > hard to be reused by other sched class.
> >
> > - After this patch
> >
> > struct task_struct {
> >     ...
> >     struct sched_statistics statistics;
> >     ...
> >     struct sched_entity *se;
> >     struct sched_rt_entity *rt;
> >     ...
> > };
> >
> > struct task_group {                    |---> stats[0] : of CPU0
> >     ...                                |
> >     struct sched_statistics **stats; --|---> stats[1] : of CPU1
> >     ...                                |
> >                                        |---> stats[n] : of CPUn
> >  #ifdef CONFIG_FAIR_GROUP_SCHED
> >     struct sched_entity **se;
> >  #endif
> >  #ifdef CONFIG_RT_GROUP_SCHED
> >     struct sched_rt_entity  **rt_se;
> >  #endif
> >     ...
> > };
> >
> > After the patch it is clearly that both of se or rt_se can easily get the
> > sched_statistics by a task_struct or a task_group.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
>
> I didn't see anything wrong as such, it's mostly a mechanical
> conversion. The one slight caveat is the potential change in cache
> location for the statistics but it's not necessarily negative. The stats
> potentially move to a different cache line but it's less obvious whether
> that even matters given the location is very similar.
>
> There is increased overhead now when schedstats are *enabled* because
> _schedstat_from_sched_entity() has to be called but it appears that it is
> protected by a schedstat_enabled() check. So ok, schedstats when enabled
> are now a bit more expensive but they were expensive in the first place
> so does it matter?
>
> I'd have been happied if there was a comparison with schedstats enabled
> just in case the overhead is too high but it could also do with a second
> set of eyeballs.
>

Sure, I will do the comparison. Thanks for the review again.


> It's somewhat tentative but
>
> Acked-by: Mel Gorman <mgorman@suse.de>
>
> --
> Mel Gorman
> SUSE Labs



-- 
Thanks
Yafang
