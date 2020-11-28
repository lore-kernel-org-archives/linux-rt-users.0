Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A7EC6379D
	for <linux-rt-users@archiver.kernel.org>; Sat, 28 Nov 2020 03:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 450F322250
	for <linux-rt-users@archiver.kernel.org>; Sat, 28 Nov 2020 03:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QmbkriXe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729422AbgK1DLe (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 27 Nov 2020 22:11:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729019AbgK1DJn (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 27 Nov 2020 22:09:43 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B84C0613D1;
        Fri, 27 Nov 2020 19:09:20 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id i9so6479718ioo.2;
        Fri, 27 Nov 2020 19:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dbqk6fkQ9N7vOdYQCsQVKy+jkNB2WegUijRwuAKX+1I=;
        b=QmbkriXetoIAO7mIOUOdfd38AMJXvvcNwuQbnT+Nf5lruzncsaknPJD7Ak6WQYEkya
         0qprZbf8dvVUkJuPn8uxYflqfmykBQ9NRw1/GwPRv43RbRaCrANluOs7FQlFmtwq+6H1
         BEEhSxz2Tn0KUoJ5f8yHH5V/DyWNho4NW2nEV3snGTGtQA/L2RYmd8SHpfLmRqWdzt7o
         iYdGZkz2lP0Xvv8scOmTz9/MohfHND8DxzcNdXAcHLho3x1Mc+4hLvW+3CTa9ET1lDuK
         aQERoog6kqrKew5qiaacfKQPfnlgpLS9qbYCwFFqS+Za68xg+blqDUSTn+JEn7/lroMF
         laZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dbqk6fkQ9N7vOdYQCsQVKy+jkNB2WegUijRwuAKX+1I=;
        b=c8GB+V0DZGXq8y2Mu4dzW+khVx1H61V1qurl7dcSd65UtB3TrWJY4YMRQMFlb7maVv
         Pxe+Y/1WAGDjRI5qzb1wGHvEM6FhxSkrPaiOTMXN+DOi2gcefH6uBLzYPJBcPLBKcHT5
         d39JUnC0NwhOu3LRH5uolmR9JeRQdmNl1pFXdjEHKjC2Sc+8mg29M2q+hqWRA0ZeUnjZ
         H939kUQ7tZ6GzjFgBpSEG7L5aiXGF9J599XIEEk3/3wSvywIhUItqAsZJORJUjSxKCLM
         QFuqC8Y0RkXw1Hh0ca7xRbKHPJ0ON0gJVjRQYd8XgnDWZp46bgT20WzV2dweqA1v2c4q
         7vBw==
X-Gm-Message-State: AOAM531fZYNwCzaDGqsMZqzCD0kCroN5Xkp73jKGJFA5a+o24hQELOj2
        Xl63MVmtghK4IVPDr0LApgeLzedu4HkVlBJDfOg=
X-Google-Smtp-Source: ABdhPJxGv5y6/ARIkZqD7n0LM/B9ZFgMkoh5jp0GqNCTFao+/cI+XrhX2niyJrrNlMEPcQBpku7sPBltflTjIQsJ2xY=
X-Received: by 2002:a02:ccbc:: with SMTP id t28mr10016301jap.97.1606532959688;
 Fri, 27 Nov 2020 19:09:19 -0800 (PST)
MIME-Version: 1.0
References: <20201127161229.19336-1-laoar.shao@gmail.com>
In-Reply-To: <20201127161229.19336-1-laoar.shao@gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Sat, 28 Nov 2020 11:08:43 +0800
Message-ID: <CALOAHbCF67J-NCsqN=ipym6pCRMLJfws9oiEaokOX6_BKx2xZQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 0/5] sched: support schedstats for RT sched class
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, bristot@redhat.com,
        jun qian <qianjun.kernel@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Sat, Nov 28, 2020 at 12:12 AM Yafang Shao <laoar.shao@gmail.com> wrote:
>
> We want to measure the latency of RT tasks in our production
> environment with schedstats facility, but currently schedstats is only
> supported for fair sched class. This patch enable it for RT sched class
> as well.
>
> - Structure
>
> Before we make schedstats available for RT sched class, we should make
> struct sched_statistics independent of fair sched class first.
>
>
> The struct sched_statistics is the schedular statistics of a task_struct
> or a task_group. So we can move it into struct task_struct and
> struct task_group to achieve the goal.
>
> Below is the detailed explaination of the change in the structs.
>
> The struct before this patch:
>
> struct task_struct {            |-> struct sched_entity {
>     ...                         |       ...
>     struct sched_entity *se; ---|       struct sched_statistics statistics;
>     struct sched_rt_entity *rt;         ...
>     ...                                 ...
> };                                  };
>
> struct task_group {             |--> se[0]->statistics : schedstats of CPU0
>     ...                         |
>  #ifdef CONFIG_FAIR_GROUP_SCHED |
>     struct sched_entity **se; --|--> se[1]->statistics : schedstats of CPU1
>                                 |
>  #endif                         |
>                                 |--> se[N]->statistics : schedstats of CPUn
>
>  #ifdef CONFIG_FAIR_GROUP_SCHED
>     struct sched_rt_entity  **rt_se; (N/A)
>  #endif
>     ...
> };
>
> The '**se' in task_group is allocated in the fair sched class, which is
> hard to be reused by other sched class.
>
> The struct after this patch:
> struct task_struct {
>     ...
>     struct sched_statistics statistics;
>     ...
>     struct sched_entity *se;
>     struct sched_rt_entity *rt;
>     ...
> };
>
> struct task_group {                    |---> stats[0] : of CPU0
>     ...                                |
>     struct sched_statistics **stats; --|---> stats[1] : of CPU1
>     ...                                |
>                                        |---> stats[n] : of CPUn
>  #ifdef CONFIG_FAIR_GROUP_SCHED
>     struct sched_entity **se;
>  #endif
>  #ifdef CONFIG_RT_GROUP_SCHED
>     struct sched_rt_entity  **rt_se;
>  #endif
>     ...
> };
>
> After the patch it is clearly that both of se or rt_se can easily get the
> sched_statistics by a task_struct or a task_group.
>
> - Function Interface
>
> The original prototype of the schedstats helpers are
>
> update_stats_wait_*(struct cfs_rq *cfs_rq, struct sched_entity *se)
>
> The cfs_rq in these helpers is used to get the rq_clock, and the se is
> used to get the struct sched_statistics and the struct task_struct. In
> order to make these helpers available by all sched classes, we can pass
> the rq, sched_statistics and task_struct directly.
>
> Then the new helpers are
>
> update_stats_wait_*(struct rq *rq, struct task_struct *p,
>                     struct sched_statistics *stats)
>
> which are independent of fair sched class.
>
> To avoid vmlinux growing too large or introducing ovehead when
> !schedstat_enabled(), some new helpers after schedstat_enabled() are also
> introduced, Suggested by Mel. These helpers are in sched/stats.c,
>
> __update_stats_wait_*(struct rq *rq, struct task_struct *p,
>                       struct sched_statistics *stats)
>
> - Implementation
>
> After we make the struct sched_statistics and the helpers of it
> independent of fair sched class, we can easily use the schedstats
> facility for RT sched class.
>
> The schedstat usage in RT sched class is similar with fair sched class,
> for example,
>                 fair                            RT
> enqueue         update_stats_enqueue_fair       update_stats_enqueue_rt
> dequeue         update_stats_dequeue_fair       update_stats_dequeue_rt
> put_prev_task   update_stats_wait_start         update_stats_wait_start
> set_next_task   update_stats_wait_end           update_stats_wait_end
>
> - Usage
>
> The user can get the schedstats information in the same way in fair sched
> class. For example,
>                 fair                            RT
> task show       /proc/[pid]/sched               /proc/[pid]/sched
> group show      cpu.stat in cgroup              cpu.stat in cgroup
>
> The sched:sched_stat_{wait, sleep, iowait, blocked} tracepoints can
> be used to trace RT tasks as well. sched_stat_runtime can also be
> supported in the future if it is helpful.
>
> Yafang Shao (5):
>   sched: don't include stats.h in sched.h
>   sched, fair: use __schedstat_set() in set_next_entity()
>   sched: make struct sched_statistics independent of fair sched class
>   sched: make schedstats helpers independent of fair sched class
>   sched, rt: support schedstats for RT sched class
>
>  include/linux/sched.h    |   3 +-
>  kernel/sched/core.c      |  25 +++--
>  kernel/sched/deadline.c  |   5 +-
>  kernel/sched/debug.c     |  82 +++++++--------
>  kernel/sched/fair.c      | 209 +++++++++++++++------------------------
>  kernel/sched/idle.c      |   1 +
>  kernel/sched/rt.c        | 178 ++++++++++++++++++++++++++++++++-
>  kernel/sched/sched.h     |  13 ++-
>  kernel/sched/stats.c     | 105 ++++++++++++++++++++
>  kernel/sched/stats.h     |  80 +++++++++++++++
>  kernel/sched/stop_task.c |   5 +-
>  11 files changed, 517 insertions(+), 189 deletions(-)
>
> --
> 2.18.4
>

Ah, the patch #5 is missed,pls ignore this patchset. I will resend them.

-- 
Thanks
Yafang
