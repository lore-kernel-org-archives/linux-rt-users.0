Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56EDFC388F9
	for <linux-rt-users@archiver.kernel.org>; Fri, 20 Nov 2020 02:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F27122237B
	for <linux-rt-users@archiver.kernel.org>; Fri, 20 Nov 2020 02:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQ2YTOzh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726172AbgKTCjr (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 19 Nov 2020 21:39:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgKTCjr (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 19 Nov 2020 21:39:47 -0500
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD3EC0613CF;
        Thu, 19 Nov 2020 18:39:46 -0800 (PST)
Received: by mail-vs1-xe44.google.com with SMTP id r14so4219422vsa.13;
        Thu, 19 Nov 2020 18:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+vzyaKweMOIfhYSIYWST2nw+snGS343yJhHMi633Nr0=;
        b=TQ2YTOzhtQgunP5ETxiq4ltpQ+OjCACiA6UKmIVRc4OVJI1TixkBAmCnaCt+tCHe3T
         sWnZsixD3/HSp+fjUB7l0fKPt4rDtqpc+YVwZxUBVb3bdY8cyHCo02irfi55PRjvxYBd
         3KZvBN6c5O80nOvzfqIKu2W+dRRWxKcbmxeyDimwf73Q/rTZddANVKg75r2GVa0E0sDf
         0mu9wO2dBPlY2S2nY1UPDvdqjcaUlEoXcWAX6cpTJF21eoNvQHC0Ck0pZNF6xUKWCMMq
         51MkzwJ+kKVEyu/JMvmAJKyAecYuVO9FRXB4WDo7rSy5OwPEWqEPWv9AMt9i2SItNLFp
         fy2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+vzyaKweMOIfhYSIYWST2nw+snGS343yJhHMi633Nr0=;
        b=mY1+dBHtoa5FcuInO+9PsAL8CY0lSebl8HvwYe781pbjrX0V0VXflSulyX6nrZfXKE
         83rJCYzFG1sjALGIK/ksH2pQbXuyhTxI/9EDCupGFfGBKmhBzBw/hY2rGxUxpjgZiFtk
         d35OEEaoLbiGKZtJGjLsgk5FQbYRMbdTVhUqbxiConeMd5QRBecDSnPT1DLDDXB9tLeA
         IUqA/n3UJ1O+iTtbO73HB3UX7PafsNRzll2wzroyRl+o2XQm0MugrN3BkB6gRc7GRSyt
         4p3ZtyZtynWgpsY6MI0NFtU8Q1Q+r/VE7F6wjZaPxB/BtKhTctPgaAaPV6pS9jGzwpjk
         RTNw==
X-Gm-Message-State: AOAM5322g00EB6E02HH8NFAR/+ameUzBPkWkL+60fF4VEU1blOmjCDiU
        IpcXveSkJU4/AHCRPTNnmI21hKiQekR9UeZyBIE=
X-Google-Smtp-Source: ABdhPJwcrfgcC+WQ/Kk13fKpo2Wug27BXgjZ6/b7LnDBB5khHgeq0ukYhjbcVU7vmGwcj5S3VW8Rd5E5tWHnr63ANv8=
X-Received: by 2002:a67:ce0e:: with SMTP id s14mr11241386vsl.13.1605839986126;
 Thu, 19 Nov 2020 18:39:46 -0800 (PST)
MIME-Version: 1.0
References: <20201119035230.45330-1-laoar.shao@gmail.com> <20201119035230.45330-5-laoar.shao@gmail.com>
In-Reply-To: <20201119035230.45330-5-laoar.shao@gmail.com>
From:   jun qian <qianjun.kernel@gmail.com>
Date:   Fri, 20 Nov 2020 10:39:35 +0800
Message-ID: <CAKc596LnYtNgBr0eR2MHiAa2VFEJSSecbUg2jZvMLCSLbmxyhw@mail.gmail.com>
Subject: Re: [RFC PATCH 4/4] sched, rt: support schedstat for RT sched class
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, bristot@redhat.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Yafang Shao <laoar.shao@gmail.com> =E4=BA=8E2020=E5=B9=B411=E6=9C=8819=E6=
=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=8811:55=E5=86=99=E9=81=93=EF=BC=9A
>
> We want to measure the latency of RT tasks in our production
> environment with schedstat facility, but currently schedstat is only
> supported for fair sched class. This patch enable it for RT sched class
> as well.
>
> The schedstat statistics are define in struct sched_entity, which is a
> member of struct task_struct, so we can resue it for RT sched class.
>
> The schedstat usage in RT sched class is similar with fair sched class,
> for example,
>                 fair                            RT
> enqueue         update_stats_enqueue_fair       update_stats_enqueue_rt
> dequeue         update_stats_dequeue_fair       update_stats_dequeue_rt
> put_prev_task   update_stats_wait_start         update_stats_wait_start
> set_next_task   update_stats_wait_end           update_stats_wait_end
> show            /proc/[pid]/sched               /proc/[pid]/sched
>
> The sched:sched_stats_* tracepoints can be used to trace RT tasks as
> well.
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  kernel/sched/rt.c    | 61 ++++++++++++++++++++++++++++++++++++++++++++
>  kernel/sched/sched.h |  2 ++
>  2 files changed, 63 insertions(+)
>
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index b9ec886702a1..a318236b7166 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -1246,6 +1246,46 @@ void dec_rt_tasks(struct sched_rt_entity *rt_se, s=
truct rt_rq *rt_rq)
>         dec_rt_group(rt_se, rt_rq);
>  }
>

Does the deadline schedule class should be considered also?

thanks

> +static inline void
> +update_stats_enqueue_rt(struct rq *rq, struct sched_entity *se,
> +                       struct sched_rt_entity *rt_se, int flags)
> +{
> +       struct rt_rq *rt_rq =3D &rq->rt;
> +
> +       if (!schedstat_enabled())
> +               return;
> +
> +       if (rt_se !=3D rt_rq->curr)
> +               update_stats_wait_start(rq, se);
> +
> +       if (flags & ENQUEUE_WAKEUP)
> +               update_stats_enqueue_sleeper(rq, se);
> +}
> +
> +static inline void
> +update_stats_dequeue_rt(struct rq *rq, struct sched_entity *se,
> +                       struct sched_rt_entity *rt_se, int flags)
> +{
> +       struct rt_rq *rt_rq =3D &rq->rt;
> +
> +       if (!schedstat_enabled())
> +               return;
> +
> +       if (rt_se !=3D rt_rq->curr)
> +               update_stats_wait_end(rq, se);
> +
> +       if ((flags & DEQUEUE_SLEEP) && rt_entity_is_task(rt_se)) {
> +               struct task_struct *tsk =3D rt_task_of(rt_se);
> +
> +               if (tsk->state & TASK_INTERRUPTIBLE)
> +                       __schedstat_set(se->statistics.sleep_start,
> +                                       rq_clock(rq));
> +               if (tsk->state & TASK_UNINTERRUPTIBLE)
> +                       __schedstat_set(se->statistics.block_start,
> +                                       rq_clock(rq));
> +       }
> +}
> +
>  /*
>   * Change rt_se->run_list location unless SAVE && !MOVE
>   *
> @@ -1275,6 +1315,7 @@ static void __enqueue_rt_entity(struct sched_rt_ent=
ity *rt_se, unsigned int flag
>         struct rt_prio_array *array =3D &rt_rq->active;
>         struct rt_rq *group_rq =3D group_rt_rq(rt_se);
>         struct list_head *queue =3D array->queue + rt_se_prio(rt_se);
> +       struct task_struct *task =3D rt_task_of(rt_se);
>
>         /*
>          * Don't enqueue the group if its throttled, or when empty.
> @@ -1288,6 +1329,8 @@ static void __enqueue_rt_entity(struct sched_rt_ent=
ity *rt_se, unsigned int flag
>                 return;
>         }
>
> +       update_stats_enqueue_rt(rq_of_rt_rq(rt_rq), &task->se, rt_se, fla=
gs);
> +
>         if (move_entity(flags)) {
>                 WARN_ON_ONCE(rt_se->on_list);
>                 if (flags & ENQUEUE_HEAD)
> @@ -1307,7 +1350,9 @@ static void __dequeue_rt_entity(struct sched_rt_ent=
ity *rt_se, unsigned int flag
>  {
>         struct rt_rq *rt_rq =3D rt_rq_of_se(rt_se);
>         struct rt_prio_array *array =3D &rt_rq->active;
> +       struct task_struct *task =3D rt_task_of(rt_se);
>
> +       update_stats_dequeue_rt(rq_of_rt_rq(rt_rq), &task->se, rt_se, fla=
gs);
>         if (move_entity(flags)) {
>                 WARN_ON_ONCE(!rt_se->on_list);
>                 __delist_rt_entity(rt_se, array);
> @@ -1374,6 +1419,7 @@ enqueue_task_rt(struct rq *rq, struct task_struct *=
p, int flags)
>         if (flags & ENQUEUE_WAKEUP)
>                 rt_se->timeout =3D 0;
>
> +       check_schedstat_required();
>         enqueue_rt_entity(rt_se, flags);
>
>         if (!task_current(rq, p) && p->nr_cpus_allowed > 1)
> @@ -1574,6 +1620,12 @@ static void check_preempt_curr_rt(struct rq *rq, s=
truct task_struct *p, int flag
>
>  static inline void set_next_task_rt(struct rq *rq, struct task_struct *p=
, bool first)
>  {
> +       struct sched_rt_entity *rt_se =3D &p->rt;
> +       struct rt_rq *rt_rq =3D &rq->rt;
> +
> +       if (on_rt_rq(&p->rt))
> +               update_stats_wait_end(rq, &p->se);
> +
>         update_stats_curr_start(rq, &p->se);
>
>         /* The running task is never eligible for pushing */
> @@ -1591,6 +1643,8 @@ static inline void set_next_task_rt(struct rq *rq, =
struct task_struct *p, bool f
>                 update_rt_rq_load_avg(rq_clock_pelt(rq), rq, 0);
>
>         rt_queue_push_tasks(rq);
> +
> +       rt_rq->curr =3D rt_se;
>  }
>
>  static struct sched_rt_entity *pick_next_rt_entity(struct rq *rq,
> @@ -1638,6 +1692,11 @@ static struct task_struct *pick_next_task_rt(struc=
t rq *rq)
>
>  static void put_prev_task_rt(struct rq *rq, struct task_struct *p)
>  {
> +       struct rt_rq *rt_rq =3D &rq->rt;
> +
> +       if (on_rt_rq(&p->rt))
> +               update_stats_wait_start(rq, &p->se);
> +
>         update_curr_rt(rq);
>
>         update_rt_rq_load_avg(rq_clock_pelt(rq), rq, 1);
> @@ -1648,6 +1707,8 @@ static void put_prev_task_rt(struct rq *rq, struct =
task_struct *p)
>          */
>         if (on_rt_rq(&p->rt) && p->nr_cpus_allowed > 1)
>                 enqueue_pushable_task(rq, p);
> +
> +       rt_rq->curr =3D NULL;
>  }
>
>  #ifdef CONFIG_SMP
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 28986736ced9..7787afbd5723 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -649,6 +649,8 @@ struct rt_rq {
>         struct rq               *rq;
>         struct task_group       *tg;
>  #endif
> +
> +       struct sched_rt_entity  *curr;
>  };
>
>  static inline bool rt_rq_is_runnable(struct rt_rq *rt_rq)
> --
> 2.18.4
>
