Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A5E0C63697
	for <linux-rt-users@archiver.kernel.org>; Sat, 21 Nov 2020 04:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF82720BED
	for <linux-rt-users@archiver.kernel.org>; Sat, 21 Nov 2020 04:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C4fXvl7s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbgKUEhR (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 20 Nov 2020 23:37:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbgKUEhP (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 20 Nov 2020 23:37:15 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EED3C0613CF;
        Fri, 20 Nov 2020 20:37:15 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id j23so12145771iog.6;
        Fri, 20 Nov 2020 20:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GxU0HP1djTM3lDHlFd6cPEto5l1+9kQkhL2w4jd53JI=;
        b=C4fXvl7ss550/GgmLKw0Mq9GegRxOPcBmBcGMUgKkOthdTHwxSn/gAYQ0Gv3BXlC8R
         EqOgZw9XOPHc75J9NAYJgqsz3G2eE/Gi1gkVcNkd4Iy0Boy98szjumAZ+fwX99hYf2eV
         aMYJW0mA55lu+MRtg+htzg1MSmXIoxO8J/bYZRJVUI2MtysKz1Nry2akRp1UfMk+unWd
         os+SlVT/Yb+L1Nq8APZ/GqtCxYHa1c4PxuMN8pPx5LVRKrzQYy8f8lLlZ7D0IFVg42Yf
         vTomaZm4vsyrFeEhvib46GeGoQIGWOCIKfa4EsPb1qCx9RlRYepJyd8vWwY2VS0cRfB3
         CNwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GxU0HP1djTM3lDHlFd6cPEto5l1+9kQkhL2w4jd53JI=;
        b=g04DLDE+EAf0rAnu9HZAQZBlZFoIjOBEWSlNrJ1k9jN29DL58Tm3sW8bDliY+lm1de
         j29xq0/HCwC+8btCODSq1ZzHGjGemp1KicXB7AVlvW8wPus93zJLbNuC7+/MDvYpAOJO
         sBclXyUstOtNnFq1WWaPcE4GlK7Z4xOWO2BfCPtm4tr4+vTzcP8gUe/lgVJxgIGHDnXa
         sOlZ+eMrmQRN/e2aPN21umCwcGVWnc99yTIhLrEI1OLl6ShC6cgKzF/1z340WH/FCVVw
         k4hWMCIPK9QYA+iFAxYuyLtR9JK8y53fdG0AenD+A3IZfYGgEn3l67kVFZ+6sHpb3gKO
         YaTA==
X-Gm-Message-State: AOAM532sT+kOfjXcX/MEnqy2rUa9MSRrGDAeMpjzj5wcfH5CC05v2h6H
        PVuwoRG17eCN+sowJuFlOoy5KwxrWa/1N/fsUG8=
X-Google-Smtp-Source: ABdhPJz+QeHu3hCJQ3mYEiLmNx+LdcYfY8c0+kJXd805LQaN/ogiq0U5Ua8APF01zSwUu5XdwEnFyzwIEKqzF7TTt7w=
X-Received: by 2002:a5d:9cc7:: with SMTP id w7mr27409225iow.202.1605933434468;
 Fri, 20 Nov 2020 20:37:14 -0800 (PST)
MIME-Version: 1.0
References: <20201119035230.45330-1-laoar.shao@gmail.com> <20201119035230.45330-5-laoar.shao@gmail.com>
 <CAKc596LnYtNgBr0eR2MHiAa2VFEJSSecbUg2jZvMLCSLbmxyhw@mail.gmail.com>
In-Reply-To: <CAKc596LnYtNgBr0eR2MHiAa2VFEJSSecbUg2jZvMLCSLbmxyhw@mail.gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Sat, 21 Nov 2020 12:36:38 +0800
Message-ID: <CALOAHbBCpeMaCFWv7xf6YF3Endb4XTJDrXUSqjMMC3drNVdj-Q@mail.gmail.com>
Subject: Re: [RFC PATCH 4/4] sched, rt: support schedstat for RT sched class
To:     jun qian <qianjun.kernel@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, bristot@redhat.com,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, Nov 20, 2020 at 10:39 AM jun qian <qianjun.kernel@gmail.com> wrote:
>
> Yafang Shao <laoar.shao@gmail.com> =E4=BA=8E2020=E5=B9=B411=E6=9C=8819=E6=
=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=8811:55=E5=86=99=E9=81=93=EF=BC=9A
> >
> > We want to measure the latency of RT tasks in our production
> > environment with schedstat facility, but currently schedstat is only
> > supported for fair sched class. This patch enable it for RT sched class
> > as well.
> >
> > The schedstat statistics are define in struct sched_entity, which is a
> > member of struct task_struct, so we can resue it for RT sched class.
> >
> > The schedstat usage in RT sched class is similar with fair sched class,
> > for example,
> >                 fair                            RT
> > enqueue         update_stats_enqueue_fair       update_stats_enqueue_rt
> > dequeue         update_stats_dequeue_fair       update_stats_dequeue_rt
> > put_prev_task   update_stats_wait_start         update_stats_wait_start
> > set_next_task   update_stats_wait_end           update_stats_wait_end
> > show            /proc/[pid]/sched               /proc/[pid]/sched
> >
> > The sched:sched_stats_* tracepoints can be used to trace RT tasks as
> > well.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  kernel/sched/rt.c    | 61 ++++++++++++++++++++++++++++++++++++++++++++
> >  kernel/sched/sched.h |  2 ++
> >  2 files changed, 63 insertions(+)
> >
> > diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> > index b9ec886702a1..a318236b7166 100644
> > --- a/kernel/sched/rt.c
> > +++ b/kernel/sched/rt.c
> > @@ -1246,6 +1246,46 @@ void dec_rt_tasks(struct sched_rt_entity *rt_se,=
 struct rt_rq *rt_rq)
> >         dec_rt_group(rt_se, rt_rq);
> >  }
> >
>
> Does the deadline schedule class should be considered also?
>

deadline sched class can be supported as well per my understanding, I
think we can do it later.
This patchset only aims to support RT sched class.

> thanks
>
> > +static inline void
> > +update_stats_enqueue_rt(struct rq *rq, struct sched_entity *se,
> > +                       struct sched_rt_entity *rt_se, int flags)
> > +{
> > +       struct rt_rq *rt_rq =3D &rq->rt;
> > +
> > +       if (!schedstat_enabled())
> > +               return;
> > +
> > +       if (rt_se !=3D rt_rq->curr)
> > +               update_stats_wait_start(rq, se);
> > +
> > +       if (flags & ENQUEUE_WAKEUP)
> > +               update_stats_enqueue_sleeper(rq, se);
> > +}
> > +
> > +static inline void
> > +update_stats_dequeue_rt(struct rq *rq, struct sched_entity *se,
> > +                       struct sched_rt_entity *rt_se, int flags)
> > +{
> > +       struct rt_rq *rt_rq =3D &rq->rt;
> > +
> > +       if (!schedstat_enabled())
> > +               return;
> > +
> > +       if (rt_se !=3D rt_rq->curr)
> > +               update_stats_wait_end(rq, se);
> > +
> > +       if ((flags & DEQUEUE_SLEEP) && rt_entity_is_task(rt_se)) {
> > +               struct task_struct *tsk =3D rt_task_of(rt_se);
> > +
> > +               if (tsk->state & TASK_INTERRUPTIBLE)
> > +                       __schedstat_set(se->statistics.sleep_start,
> > +                                       rq_clock(rq));
> > +               if (tsk->state & TASK_UNINTERRUPTIBLE)
> > +                       __schedstat_set(se->statistics.block_start,
> > +                                       rq_clock(rq));
> > +       }
> > +}
> > +
> >  /*
> >   * Change rt_se->run_list location unless SAVE && !MOVE
> >   *
> > @@ -1275,6 +1315,7 @@ static void __enqueue_rt_entity(struct sched_rt_e=
ntity *rt_se, unsigned int flag
> >         struct rt_prio_array *array =3D &rt_rq->active;
> >         struct rt_rq *group_rq =3D group_rt_rq(rt_se);
> >         struct list_head *queue =3D array->queue + rt_se_prio(rt_se);
> > +       struct task_struct *task =3D rt_task_of(rt_se);
> >
> >         /*
> >          * Don't enqueue the group if its throttled, or when empty.
> > @@ -1288,6 +1329,8 @@ static void __enqueue_rt_entity(struct sched_rt_e=
ntity *rt_se, unsigned int flag
> >                 return;
> >         }
> >
> > +       update_stats_enqueue_rt(rq_of_rt_rq(rt_rq), &task->se, rt_se, f=
lags);
> > +
> >         if (move_entity(flags)) {
> >                 WARN_ON_ONCE(rt_se->on_list);
> >                 if (flags & ENQUEUE_HEAD)
> > @@ -1307,7 +1350,9 @@ static void __dequeue_rt_entity(struct sched_rt_e=
ntity *rt_se, unsigned int flag
> >  {
> >         struct rt_rq *rt_rq =3D rt_rq_of_se(rt_se);
> >         struct rt_prio_array *array =3D &rt_rq->active;
> > +       struct task_struct *task =3D rt_task_of(rt_se);
> >
> > +       update_stats_dequeue_rt(rq_of_rt_rq(rt_rq), &task->se, rt_se, f=
lags);
> >         if (move_entity(flags)) {
> >                 WARN_ON_ONCE(!rt_se->on_list);
> >                 __delist_rt_entity(rt_se, array);
> > @@ -1374,6 +1419,7 @@ enqueue_task_rt(struct rq *rq, struct task_struct=
 *p, int flags)
> >         if (flags & ENQUEUE_WAKEUP)
> >                 rt_se->timeout =3D 0;
> >
> > +       check_schedstat_required();
> >         enqueue_rt_entity(rt_se, flags);
> >
> >         if (!task_current(rq, p) && p->nr_cpus_allowed > 1)
> > @@ -1574,6 +1620,12 @@ static void check_preempt_curr_rt(struct rq *rq,=
 struct task_struct *p, int flag
> >
> >  static inline void set_next_task_rt(struct rq *rq, struct task_struct =
*p, bool first)
> >  {
> > +       struct sched_rt_entity *rt_se =3D &p->rt;
> > +       struct rt_rq *rt_rq =3D &rq->rt;
> > +
> > +       if (on_rt_rq(&p->rt))
> > +               update_stats_wait_end(rq, &p->se);
> > +
> >         update_stats_curr_start(rq, &p->se);
> >
> >         /* The running task is never eligible for pushing */
> > @@ -1591,6 +1643,8 @@ static inline void set_next_task_rt(struct rq *rq=
, struct task_struct *p, bool f
> >                 update_rt_rq_load_avg(rq_clock_pelt(rq), rq, 0);
> >
> >         rt_queue_push_tasks(rq);
> > +
> > +       rt_rq->curr =3D rt_se;
> >  }
> >
> >  static struct sched_rt_entity *pick_next_rt_entity(struct rq *rq,
> > @@ -1638,6 +1692,11 @@ static struct task_struct *pick_next_task_rt(str=
uct rq *rq)
> >
> >  static void put_prev_task_rt(struct rq *rq, struct task_struct *p)
> >  {
> > +       struct rt_rq *rt_rq =3D &rq->rt;
> > +
> > +       if (on_rt_rq(&p->rt))
> > +               update_stats_wait_start(rq, &p->se);
> > +
> >         update_curr_rt(rq);
> >
> >         update_rt_rq_load_avg(rq_clock_pelt(rq), rq, 1);
> > @@ -1648,6 +1707,8 @@ static void put_prev_task_rt(struct rq *rq, struc=
t task_struct *p)
> >          */
> >         if (on_rt_rq(&p->rt) && p->nr_cpus_allowed > 1)
> >                 enqueue_pushable_task(rq, p);
> > +
> > +       rt_rq->curr =3D NULL;
> >  }
> >
> >  #ifdef CONFIG_SMP
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index 28986736ced9..7787afbd5723 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -649,6 +649,8 @@ struct rt_rq {
> >         struct rq               *rq;
> >         struct task_group       *tg;
> >  #endif
> > +
> > +       struct sched_rt_entity  *curr;
> >  };
> >
> >  static inline bool rt_rq_is_runnable(struct rt_rq *rt_rq)
> > --
> > 2.18.4
> >



--=20
Thanks
Yafang
