Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1375C432BE
	for <linux-rt-users@archiver.kernel.org>; Tue, 31 Aug 2021 13:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC1E360FED
	for <linux-rt-users@archiver.kernel.org>; Tue, 31 Aug 2021 13:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233409AbhHaN06 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 31 Aug 2021 09:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234255AbhHaN0u (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 31 Aug 2021 09:26:50 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAEB7C061575;
        Tue, 31 Aug 2021 06:25:55 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id y18so24806614ioc.1;
        Tue, 31 Aug 2021 06:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7NvgPHh532zLFsZQEQ10urcOdKS8PwchEX/gRShxyoU=;
        b=nNOrZH+dH+SQd2F+GrdNHDcvmF0JiO9rqTOgY9HF7Ggo+N6UbSrvgkCkGfJA76Y/Td
         6VLGjXweZdUPteQJvgsnmrXVzCwSCNhgDbQlSLNWUed7pPF0pYovKj1ZSZJqlLtnhDbE
         gQeSw4ytqIm0U9fV8S/J3C+pA0MzoH+mhRTb0fKm5Vv/9+oOZ6Rpw93VCNRhNahY/fn6
         eHp9NIyNINZHASm2otSsV5S1VRaJMr0PxB7c/FwKOoE/adVW83RhyXGHs0g2HESql1BC
         KU/82OsqCaMXkJ7CzxNdzHJRV/6DIMtc4m47NbZ8qi5801xGZcI0xILC4AAJeFTCiWYa
         zROQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7NvgPHh532zLFsZQEQ10urcOdKS8PwchEX/gRShxyoU=;
        b=PPMslF/NlSd1JyEbq9QcijNYEnkUeuo4naNpB6wVpmnmhTyn/YUyt9JKoDW+PeuEXW
         VFdVD0DzNtfXiJD5TredGwv7ppfPKMY0e8Q+ALglG/zEEqhaPMZ7lGt0gp0hsvg5Wlt6
         Y96jFMPAfpiXU2iIkhCxReAcbk+66QzdANgfiE92Klvyxab06QYv1R5Depl2kF/hvYF6
         A/Uw8GznhTUWAyZ2mz7PimefYFYQN52xedJOYVV78MVzLeEb8l/Iejw0qqmSiHTTeMF5
         LXUD73PNClEMcmc/RxDDHDt5JyiYbQLTRn2nA4urPa7XvYn7/7PJv7+6ps2yYE8OY+lT
         mePg==
X-Gm-Message-State: AOAM5307gU5cT9+C/6MouR+DkxJzOm5JzegLpxyJcKzbdZZy+95H+7sC
        b25HqCS/kVr7cpSTUMVzjmLJcTaO+7XTytIBqAA=
X-Google-Smtp-Source: ABdhPJxD8hvmgGncEE0Y0aJkbZXtsK1Tj1wsfbQNBuHVfdiVKAEX4hr7XP2N93XBuaBQ8BeOUplNeIeQf5t9YUuESuA=
X-Received: by 2002:a5d:94c6:: with SMTP id y6mr23174101ior.202.1630416355361;
 Tue, 31 Aug 2021 06:25:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210824112946.9324-1-laoar.shao@gmail.com> <20210824112946.9324-3-laoar.shao@gmail.com>
 <YS4A8Jld5zC5qbAx@hirez.programming.kicks-ass.net>
In-Reply-To: <YS4A8Jld5zC5qbAx@hirez.programming.kicks-ass.net>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Tue, 31 Aug 2021 21:25:19 +0800
Message-ID: <CALOAHbD13G4LpBxAxaa7U0qAbF_ApNqgoS8wVrPs5hmBvjLjDA@mail.gmail.com>
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

On Tue, Aug 31, 2021 at 6:15 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Aug 24, 2021 at 11:29:41AM +0000, Yafang Shao wrote:
> > diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> > index 49716228efb4..4cfee2aa1a2d 100644
> > --- a/kernel/sched/debug.c
> > +++ b/kernel/sched/debug.c
>
> > @@ -442,9 +442,11 @@ static void print_cfs_group_stats(struct seq_file *m, int cpu, struct task_group
> >       struct sched_entity *se = tg->se[cpu];
> >
> >  #define P(F)         SEQ_printf(m, "  .%-30s: %lld\n",       #F, (long long)F)
> > -#define P_SCHEDSTAT(F)       SEQ_printf(m, "  .%-30s: %lld\n",       #F, (long long)schedstat_val(F))
> > +#define P_SCHEDSTAT(F)       SEQ_printf(m, "  .%-30s: %lld\n",       \
> > +             "se->statistics."#F, (long long)schedstat_val(tg->stats[cpu]->F))
> >  #define PN(F)                SEQ_printf(m, "  .%-30s: %lld.%06ld\n", #F, SPLIT_NS((long long)F))
> > -#define PN_SCHEDSTAT(F)      SEQ_printf(m, "  .%-30s: %lld.%06ld\n", #F, SPLIT_NS((long long)schedstat_val(F)))
> > +#define PN_SCHEDSTAT(F)      SEQ_printf(m, "  .%-30s: %lld.%06ld\n", \
> > +             "se->statistics."#F, SPLIT_NS((long long)schedstat_val(tg->stats[cpu]->F)))
> >
> >       if (!se)
> >               return;
>
> > @@ -948,8 +950,8 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
> >               "---------------------------------------------------------"
> >               "----------\n");
> >
> > -#define P_SCHEDSTAT(F)  __PS(#F, schedstat_val(p->F))
> > -#define PN_SCHEDSTAT(F) __PSN(#F, schedstat_val(p->F))
> > +#define P_SCHEDSTAT(F)  __PS("se.statistics."#F, schedstat_val(p->stats.F))
> > +#define PN_SCHEDSTAT(F) __PSN("se.statistics."#F, schedstat_val(p->stats.F))
> >
> >       PN(se.exec_start);
> >       PN(se.vruntime);
>
> That's sad... can't we keep it #F, this is all SCHED_DEBUG code anyway.

Sure, I will change it.

-- 
Thanks
Yafang
