Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ECC8C432BE
	for <linux-rt-users@archiver.kernel.org>; Tue, 31 Aug 2021 13:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA57D60FED
	for <linux-rt-users@archiver.kernel.org>; Tue, 31 Aug 2021 13:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234589AbhHaN1Z (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 31 Aug 2021 09:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233512AbhHaN1X (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 31 Aug 2021 09:27:23 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE305C061575;
        Tue, 31 Aug 2021 06:26:28 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id u7so19911577ilk.7;
        Tue, 31 Aug 2021 06:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9ZS2rq7TdX/lH9ThK6GDPfAidwJG5w2VZOyeSQOB1m0=;
        b=XHGcX+O7iUV4pWgRoeWLQ6OgWYc0j1iBce8scG93nSMR34nifJV/IKMcFSHs6WIqUh
         WGrcElbCwPTBYS2dbaORFGLxEKbt2icD/wlFJIXGLoMRBMPWPYik39nWWdFDiryUk+6Z
         FNhaBRNH6Oo7kM9NPX7GxzoIXD1idTx88ZehyLnB+E7zW5q8dQa4q6uhhmt0tcZkMnAH
         2ERhGsmurHKhrRPwn6DhuIRcSmGUMfi6G7+b2XbrixyCuYqPLDeXEU/20VgB3mfZDzBM
         q+6wdF9eHv6RPfSDhefv3IluZZv7pkPvXjAdyoxMWiFatGPUnt8LjpOgwp9OY3xhIav8
         GWlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9ZS2rq7TdX/lH9ThK6GDPfAidwJG5w2VZOyeSQOB1m0=;
        b=J3nBZVX+K+602Mk+orxzjQB5tIDGKOgce9tsoK6y0UwjmSnnC4WpQvJeNcqRLxZ8ny
         zLp6BqcCuWS+yhMdnlcB54+kf9PWMy6SGceHLfOv4fynV+GlCZ0/8T5c1GMrFhOJqRby
         g/obNRRZ8CvlvqFsdEkGgCmmEKsD1WGDCABYWMW+KR84kAtDHdLkxrQ4A1l7OExunsYU
         OLokvbrSTTR89IPJzqKAlYOU9OlG/rD7Xwn4REP9as9a5M2/61NN6/qZlbS7RRbNeR3Q
         HgsaaaI5BlHOa9xAhlSGF2kMRSUJ9Wjgde1jJlIOY1Xbx/F+QWxengq4N2USPfu3b94q
         OzSA==
X-Gm-Message-State: AOAM533SiW5nhaowCrv69LEDMUQ2cD+2TYMiVm9BEtbQN6//2ENyQMXN
        BtHFby2nnrHFzAOOvFFmeIiLLQg5C7vzYNb8B9g=
X-Google-Smtp-Source: ABdhPJz5gsMDI0G+bxOkqlvJqa7jGXoSCu6MF8hlitRetsAxgu6aybdHpkBYhStLdP5Eu92OgfQ9O57hSwcTFKqlokQ=
X-Received: by 2002:a05:6e02:1aa2:: with SMTP id l2mr20570434ilv.168.1630416388169;
 Tue, 31 Aug 2021 06:26:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210824112946.9324-1-laoar.shao@gmail.com> <20210824112946.9324-3-laoar.shao@gmail.com>
 <YS4CRi7nzfGk2o7u@hirez.programming.kicks-ass.net>
In-Reply-To: <YS4CRi7nzfGk2o7u@hirez.programming.kicks-ass.net>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Tue, 31 Aug 2021 21:25:52 +0800
Message-ID: <CALOAHbAAyAOx9Ck27LhqV-sddTTWsk0cqMdHRNiA5O-r_9K+cQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] sched: make struct sched_statistics independent of
 fair sched class
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

On Tue, Aug 31, 2021 at 6:19 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Aug 24, 2021 at 11:29:41AM +0000, Yafang Shao wrote:
>
> > +#ifdef CONFIG_FAIR_GROUP_SCHED
> > +static inline void
> > +__schedstats_from_sched_entity(struct sched_entity *se,
> > +                           struct sched_statistics **stats)
> > +{
> > +     struct task_group *tg;
> > +     struct task_struct *p;
> > +     struct cfs_rq *cfs;
> > +     int cpu;
> > +
> > +     if (entity_is_task(se)) {
> > +             p = task_of(se);
> > +             *stats = &p->stats;
> > +     } else {
> > +             cfs = group_cfs_rq(se);
> > +             tg = cfs->tg;
> > +             cpu = cpu_of(rq_of(cfs));
> > +             *stats = tg->stats[cpu];
> > +     }
> > +}
> > +
> > +#else
> > +
> > +static inline void
> > +__schedstats_from_sched_entity(struct sched_entity *se,
> > +                           struct sched_statistics **stats)
> > +{
> > +     struct task_struct *p;
> > +
> > +     p = task_of(se);
> > +     *stats = &p->stats;
> > +}
> > +
> > +#endif
> > +
> >  /*
> >   * Update the current task's runtime statistics.
> >   */
> > @@ -826,6 +861,7 @@ static void update_curr(struct cfs_rq *cfs_rq)
> >  {
> >       struct sched_entity *curr = cfs_rq->curr;
> >       u64 now = rq_clock_task(rq_of(cfs_rq));
> > +     struct sched_statistics *stats = NULL;
> >       u64 delta_exec;
> >
> >       if (unlikely(!curr))
> > @@ -837,8 +873,11 @@ static void update_curr(struct cfs_rq *cfs_rq)
> >
> >       curr->exec_start = now;
> >
> > -     schedstat_set(curr->statistics.exec_max,
> > -                   max(delta_exec, curr->statistics.exec_max));
> > +     if (schedstat_enabled()) {
> > +             __schedstats_from_sched_entity(curr, &stats);
> > +             __schedstat_set(stats->exec_max,
> > +                             max(delta_exec, stats->exec_max));
> > +     }
> >
> >       curr->sum_exec_runtime += delta_exec;
> >       schedstat_add(cfs_rq->exec_clock, delta_exec);
>
>
> That's just really odd style; what's wrong with something like:
>

I will change it.

> static inline struct sched_statistics *
> __schedstats_from_se(struct sched_entity *se)
> {
>         ...
> }
>
>         if (schedstats_enabled()) {
>                 struct sched_statistics *stats = __schedstats_from_se(curr);
>                 __schedstat_set(stats->exec_max, max(stats->exec_max, delta_exec));
>         }
>
>


-- 
Thanks
Yafang
