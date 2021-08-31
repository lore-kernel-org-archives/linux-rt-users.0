Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A59A6C4320E
	for <linux-rt-users@archiver.kernel.org>; Tue, 31 Aug 2021 13:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D94960FE6
	for <linux-rt-users@archiver.kernel.org>; Tue, 31 Aug 2021 13:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233251AbhHaN3O (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 31 Aug 2021 09:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235281AbhHaN3D (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 31 Aug 2021 09:29:03 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3EBC061575;
        Tue, 31 Aug 2021 06:28:08 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id v2so19876701ilg.12;
        Tue, 31 Aug 2021 06:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GAjUavHb+mKCA+LR8XMdkthAV445J68UiBOR63afig8=;
        b=Xjr+jfs7WbfMHS9FcwQG7T8a777R6OZrkDqW4AIM/t9r78+dCb8YBTRtSek12TZfm6
         BfO4DED3U9hqQh+RhkqZUJIkG8KRXvhhFfecaradgrLMg5GrFoec+XYM5EsndB9MOJqA
         vGKJKHBfY/4Sca0wm4JT1LiaZ9Ga38jxxMQDngHuQTFbli9UTGXedbEb+HF1Z8mRkQ5G
         S3901as2Q3U3S07ocQRkWLMuStaj3CVOwkADUXKVovhAIurY86pqKDNLSYltLVifTD4x
         9b7Ub1+8BSBUgtWayaNxyOmeInSFym28CWNHwEwvXCvyXYVhxFSngzu8egPFH1YXG8OL
         jIGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GAjUavHb+mKCA+LR8XMdkthAV445J68UiBOR63afig8=;
        b=WApBhx4aDC8o5HnKqcOF/QlaJIcqn7YolnbPBIjx5zaeQJcJvWO4PffUEngZ7lQ7OX
         djA3NZYvXZQ79ZyWCVSELTA0fo2sc9mhU70zz8SxAutfwegZTZ4TEas642OPXLxY92/6
         m1UxpbKbdgG84i2EZFxw+7jKQBPl8igEZjEn79OPmD/xguGEDvXD9RXvzaoIrbgg0lVs
         FLCNdv7V8DEIyn5xqACU4IoCdh3fLKQ9/zDUTLQEYk1rl8A12qnC1vw9JkJ83W+87Pqt
         D0hwwvz6NpV2XJunSTqjQPsq4R6jeIBo6rIGByuIA/OM/2li4kjR2gT1JbnMqu+WsGx2
         GDcQ==
X-Gm-Message-State: AOAM530OBXIzQZVWD3IplnCT0iobFQRgSWMQkIxmx6MTx6yVNARXjpIy
        syOwzwHkFOBACQbG+MaVR0dHaMGUKRj8l2Xg7ec=
X-Google-Smtp-Source: ABdhPJzMu1/OA6ud1LgH3AgbbavAxLUcqpKixsiBDEVCN+2y57HM4deJQJphAQZhLPIheq/VL3l+2ElNYG3p0X2FPf0=
X-Received: by 2002:a05:6e02:524:: with SMTP id h4mr20244874ils.203.1630416487805;
 Tue, 31 Aug 2021 06:28:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210824112946.9324-1-laoar.shao@gmail.com> <20210824112946.9324-4-laoar.shao@gmail.com>
 <YS4Nbzz6Kosfhx5M@hirez.programming.kicks-ass.net>
In-Reply-To: <YS4Nbzz6Kosfhx5M@hirez.programming.kicks-ass.net>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Tue, 31 Aug 2021 21:27:31 +0800
Message-ID: <CALOAHbDXu+VQQs-fGutj4MHOD9Z83aoQBuVD-QBaoijp6QZ5Dg@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] sched: make schedstats helpers independent of fair
 sched class
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Alison Chaiken <achaiken@aurora.tech>,
        kbuild test robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Aug 31, 2021 at 7:08 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Aug 24, 2021 at 11:29:42AM +0000, Yafang Shao wrote:
> > diff --git a/kernel/sched/stats.c b/kernel/sched/stats.c
> > index 3f93fc3b5648..b2542f4d3192 100644
> > --- a/kernel/sched/stats.c
> > +++ b/kernel/sched/stats.c
> > @@ -4,6 +4,109 @@
> >   */
> >  #include "sched.h"
> >
> > +void __update_stats_wait_start(struct rq *rq, struct task_struct *p,
> > +                            struct sched_statistics *stats)
> > +{
> > +u64 wait_start, prev_wait_start;
>
> indent fail...
>

Sorry about that.
It is strange that my checkpatch.pl didn't find this issue...

> > +
> > +     wait_start = rq_clock(rq);
> > +     prev_wait_start = schedstat_val(stats->wait_start);
> > +
> > +     if (p && likely(wait_start > prev_wait_start))
> > +             wait_start -= prev_wait_start;
> > +
> > +     __schedstat_set(stats->wait_start, wait_start);
> > +}
>
> > diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
> > index e6905e369c5d..9ecd81b91f26 100644
> > --- a/kernel/sched/stats.h
> > +++ b/kernel/sched/stats.h
>
> > @@ -40,6 +42,33 @@ rq_sched_info_dequeue(struct rq *rq, unsigned long long delta)
> >  #define   schedstat_val(var)         (var)
> >  #define   schedstat_val_or_zero(var) ((schedstat_enabled()) ? (var) : 0)
> >
> > +void __update_stats_wait_start(struct rq *rq, struct task_struct *p,
> > +                            struct sched_statistics *stats);
> > +
> > +void __update_stats_wait_end(struct rq *rq, struct task_struct *p,
> > +                          struct sched_statistics *stats);
> > +void __update_stats_enqueue_sleeper(struct rq *rq, struct task_struct *p,
> > +                                 struct sched_statistics *stats);
> > +
> > +static inline void
> > +check_schedstat_required(void)
> > +{
> > +     if (schedstat_enabled())
> > +             return;
> > +
> > +     /* Force schedstat enabled if a dependent tracepoint is active */
> > +     if (trace_sched_stat_wait_enabled()    ||
> > +             trace_sched_stat_sleep_enabled()   ||
> > +             trace_sched_stat_iowait_enabled()  ||
> > +             trace_sched_stat_blocked_enabled() ||
> > +             trace_sched_stat_runtime_enabled())  {
> > +             printk_deferred_once("Scheduler tracepoints stat_sleep, stat_iowait, "
> > +                                     "stat_blocked and stat_runtime require the "
> > +                                     "kernel parameter schedstats=enable or "
> > +                                     "kernel.sched_schedstats=1\n");
> > +     }
> > +}
>
> If you're moving this, you might as well reflow it to not have broken
> indentation.

Sure.


-- 
Thanks
Yafang
