Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39525C432BE
	for <linux-rt-users@archiver.kernel.org>; Tue, 31 Aug 2021 13:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FCC160FED
	for <linux-rt-users@archiver.kernel.org>; Tue, 31 Aug 2021 13:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235771AbhHaNWr (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 31 Aug 2021 09:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233826AbhHaNWq (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 31 Aug 2021 09:22:46 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2236C061575;
        Tue, 31 Aug 2021 06:21:51 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id b10so24727631ioq.9;
        Tue, 31 Aug 2021 06:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lZmPD4SHVGlfaRzVgc2ILkEjKAxHk6jaXHXHOU0iYlE=;
        b=d9GrGnJJoGKxD63GXnbpa3jdLaB2rNDS7a2SmT49CwEtthYZzDoR0u8Pt3BMy5BIXo
         8k9Wd3Fzv+K4FKWuCxj3eINWjXfqbWOXmVRCN1txWVfv4fuRBu/fYyRlHjJlSC2d7tni
         89ZamxskTq/4da++6EeA/E9UoX9YoOB/u6JHzL3Q7NgvVtEAQp8qhaCCQ7Pj5PhABSjM
         IO2YKNdnAZtcasSn/PFN2+XgV9+53qVg2PJVHCrnTKP7KVZVfBnjQU0k3VX/78hEanlQ
         WxreEOklTr0CpN7CcKYXocDxuQixkOzldfrZ3wPPv4ld7fT4MhXmcnM4feBdydgBw38G
         qyHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lZmPD4SHVGlfaRzVgc2ILkEjKAxHk6jaXHXHOU0iYlE=;
        b=N9Jt9ETR8EXUCCZKt/gTejNfKWaGWJjkEhVJlazNev4PCy+ZGzh8CwrGzeM/8t2yc8
         iaoQPIIAsgJa3+sMTnn5xW1ZM9RAPc0up5WH142arLImzLNIsZ1vg69dZdKShMyad8af
         g1gLJ2jUB2FOgSnfZupNenBHCVnCuqIZyzZtNJAb7ZwnJgEHU8w++F5AJE8NyX7BYThi
         mQz2/RURd4VIzkbFqstY229wdII8/irwowKn9LnEl2z70HbP15tmzoGWfS8DYq9P4rQK
         jMs5aqNi3N+UvfzVTjIlKUwqIN+GMbbl5wOyCYvzPrW49y2+N/Uk1N28EuSX0Sx/D2S4
         DJ9Q==
X-Gm-Message-State: AOAM531iF8xYHqTVt7FiHacknaKFs3GIaoraaRAmwfNnfvew4MZSCUHT
        y1kgfR2TX3fvqEGUEFyoYxPCpJsFsv5p19TLWjE=
X-Google-Smtp-Source: ABdhPJywUas5gJXI/d4QLJfvlaWNmMjmUTPQ1/doVDEJ7q0QwZOksyBczn0BXAsrmLfq1pkucdhFPjF0INN+DHyBmvE=
X-Received: by 2002:a02:ce37:: with SMTP id v23mr2832763jar.81.1630416110999;
 Tue, 31 Aug 2021 06:21:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210824112946.9324-1-laoar.shao@gmail.com> <YS3/jhuRNS2GGVrp@hirez.programming.kicks-ass.net>
 <YS4IE1Dxf0ite81A@hirez.programming.kicks-ass.net>
In-Reply-To: <YS4IE1Dxf0ite81A@hirez.programming.kicks-ass.net>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Tue, 31 Aug 2021 21:21:14 +0800
Message-ID: <CALOAHbB53Mnqn-bfxY7EUt-MEDZ_NpjmHYMruf3D+WzN1JGAYg@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] sched: support schedstats for RT sched class
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

On Tue, Aug 31, 2021 at 6:44 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Aug 31, 2021 at 12:08:15PM +0200, Peter Zijlstra wrote:
> > On Tue, Aug 24, 2021 at 11:29:39AM +0000, Yafang Shao wrote:
>
> > > After the patchset, schestats are orgnized as follows,
> > > struct task_struct {
> > >     ...
> > >     struct sched_statistics statistics;
> > >     ...
> > >     struct sched_entity *se;
> > >     struct sched_rt_entity *rt;
> > >     ...
> > > };
> > >
> > > struct task_group {                    |---> stats[0] : of CPU0
> > >     ...                                |
> > >     struct sched_statistics **stats; --|---> stats[1] : of CPU1
> > >     ...                                |
> > >                                        |---> stats[n] : of CPUn
> > >  #ifdef CONFIG_FAIR_GROUP_SCHED
> > >     struct sched_entity **se;
> > >  #endif
> > >  #ifdef CONFIG_RT_GROUP_SCHED
> > >     struct sched_rt_entity  **rt_se;
> > >  #endif
> > >     ...
> > > };
> >
> > Yeah, this seems to give a terrible mess, let me see if I can come up
> > with anything less horrible.
>
> Here, isn't this *MUCH* saner ?
>

Seems like a good idea.
I will verify it.


> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -521,7 +521,7 @@ struct sched_statistics {
>         u64                             nr_wakeups_passive;
>         u64                             nr_wakeups_idle;
>  #endif
> -};
> +} ____cacheline_aligned;
>
>  struct sched_entity {
>         /* For load-balancing: */
> @@ -537,8 +537,6 @@ struct sched_entity {
>
>         u64                             nr_migrations;
>
> -       struct sched_statistics         statistics;
> -
>  #ifdef CONFIG_FAIR_GROUP_SCHED
>         int                             depth;
>         struct sched_entity             *parent;
> @@ -802,6 +800,8 @@ struct task_struct {
>         struct uclamp_se                uclamp[UCLAMP_CNT];
>  #endif
>
> +       struct sched_statistics         stats;
> +

The stats was kept close to 'struct sched_entity se' before, because I
don't want to change the original layout of 'struct task_struct' too
much, in case the change may impact the cache line.
I'm not sure whether it is proper to place it here, I will verify it.

>  #ifdef CONFIG_PREEMPT_NOTIFIERS
>         /* List of struct preempt_notifier: */
>         struct hlist_head               preempt_notifiers;
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3489,11 +3489,11 @@ ttwu_stat(struct task_struct *p, int cpu
>  #ifdef CONFIG_SMP
>         if (cpu == rq->cpu) {
>                 __schedstat_inc(rq->ttwu_local);
> -               __schedstat_inc(p->se.statistics.nr_wakeups_local);
> +               __schedstat_inc(p->stats.nr_wakeups_local);
>         } else {
>                 struct sched_domain *sd;
>
> -               __schedstat_inc(p->se.statistics.nr_wakeups_remote);
> +               __schedstat_inc(p->stats.nr_wakeups_remote);
>                 rcu_read_lock();
>                 for_each_domain(rq->cpu, sd) {
>                         if (cpumask_test_cpu(cpu, sched_domain_span(sd))) {
> @@ -3505,14 +3505,14 @@ ttwu_stat(struct task_struct *p, int cpu
>         }
>
>         if (wake_flags & WF_MIGRATED)
> -               __schedstat_inc(p->se.statistics.nr_wakeups_migrate);
> +               __schedstat_inc(p->stats.nr_wakeups_migrate);
>  #endif /* CONFIG_SMP */
>
>         __schedstat_inc(rq->ttwu_count);
> -       __schedstat_inc(p->se.statistics.nr_wakeups);
> +       __schedstat_inc(p->stats.nr_wakeups);
>
>         if (wake_flags & WF_SYNC)
> -               __schedstat_inc(p->se.statistics.nr_wakeups_sync);
> +               __schedstat_inc(p->stats.nr_wakeups_sync);
>  }
>
>  /*
> @@ -4196,7 +4196,7 @@ static void __sched_fork(unsigned long c
>
>  #ifdef CONFIG_SCHEDSTATS
>         /* Even if schedstat is disabled, there should not be garbage */
> -       memset(&p->se.statistics, 0, sizeof(p->se.statistics));
> +       memset(&p->stats, 0, sizeof(p->stats));
>  #endif
>
>         RB_CLEAR_NODE(&p->dl.rb_node);
> @@ -9619,9 +9619,9 @@ void normalize_rt_tasks(void)
>                         continue;
>
>                 p->se.exec_start = 0;
> -               schedstat_set(p->se.statistics.wait_start,  0);
> -               schedstat_set(p->se.statistics.sleep_start, 0);
> -               schedstat_set(p->se.statistics.block_start, 0);
> +               schedstat_set(p->stats.wait_start,  0);
> +               schedstat_set(p->stats.sleep_start, 0);
> +               schedstat_set(p->stats.block_start, 0);
>
>                 if (!dl_task(p) && !rt_task(p)) {
>                         /*
> @@ -10467,7 +10467,7 @@ static int cpu_cfs_stat_show(struct seq_
>                 int i;
>
>                 for_each_possible_cpu(i)
> -                       ws += schedstat_val(tg->se[i]->statistics.wait_sum);
> +                       ws += schedstat_val(tg->stats[i]->wait_sum);
>
>                 seq_printf(sf, "wait_sum %llu\n", ws);
>         }
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1265,8 +1265,8 @@ static void update_curr_dl(struct rq *rq
>                 return;
>         }
>
> -       schedstat_set(curr->se.statistics.exec_max,
> -                     max(curr->se.statistics.exec_max, delta_exec));
> +       schedstat_set(curr->stats.exec_max,
> +                     max(curr->stats.exec_max, delta_exec));
>
>         curr->se.sum_exec_runtime += delta_exec;
>         account_group_exec_runtime(curr, delta_exec);
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -819,6 +819,21 @@ static void update_tg_load_avg(struct cf
>  }
>  #endif /* CONFIG_SMP */
>
> +struct sched_entity_stats {
> +       struct sched_entity     se;
> +       struct sched_statistics stats;
> +} __no_randomize_layout;
> +
> +static inline struct sched_statistics *
> +__schedstats_from_se(struct sched_entity *se)
> +{
> +#ifdef CONFIG_FAIR_GROUP_SCHED
> +       if (!entity_is_task(se))
> +               return &container_of(se, struct sched_entity_stats, se)->stats;
> +#endif
> +       return &task_of(se)->stats;
> +}
> +
>  /*
>   * Update the current task's runtime statistics.
>   */
> @@ -837,8 +852,10 @@ static void update_curr(struct cfs_rq *c
>
>         curr->exec_start = now;
>
> -       schedstat_set(curr->statistics.exec_max,
> -                     max(delta_exec, curr->statistics.exec_max));
> +       if (schedstat_enabled()) {
> +               struct sched_statistics *stats = __schedstats_from_se(curr);
> +               __schedstat_set(stats->exec_max, max(delta_exec, stats->exec_max));
> +       }
>
>         curr->sum_exec_runtime += delta_exec;
>         schedstat_add(cfs_rq->exec_clock, delta_exec);
> @@ -866,39 +883,45 @@ static inline void
>  update_stats_wait_start(struct cfs_rq *cfs_rq, struct sched_entity *se)
>  {
>         u64 wait_start, prev_wait_start;
> +       struct sched_statistics *stats;
>
>         if (!schedstat_enabled())
>                 return;
>
> +       stats = __schedstats_from_se(se);
> +
>         wait_start = rq_clock(rq_of(cfs_rq));
> -       prev_wait_start = schedstat_val(se->statistics.wait_start);
> +       prev_wait_start = schedstat_val(stats->wait_start);
>
>         if (entity_is_task(se) && task_on_rq_migrating(task_of(se)) &&
>             likely(wait_start > prev_wait_start))
>                 wait_start -= prev_wait_start;
>
> -       __schedstat_set(se->statistics.wait_start, wait_start);
> +       __schedstat_set(stats->wait_start, wait_start);
>  }
>
>  static inline void
>  update_stats_wait_end(struct cfs_rq *cfs_rq, struct sched_entity *se)
>  {
> -       struct task_struct *p;
> +       struct sched_statistics *stats;
> +       struct task_struct *p = NULL;
>         u64 delta;
>
>         if (!schedstat_enabled())
>                 return;
>
> +       stats = __schedstats_from_se(se);
> +
>         /*
>          * When the sched_schedstat changes from 0 to 1, some sched se
>          * maybe already in the runqueue, the se->statistics.wait_start
>          * will be 0.So it will let the delta wrong. We need to avoid this
>          * scenario.
>          */
> -       if (unlikely(!schedstat_val(se->statistics.wait_start)))
> +       if (unlikely(!schedstat_val(stats->wait_start)))
>                 return;
>
> -       delta = rq_clock(rq_of(cfs_rq)) - schedstat_val(se->statistics.wait_start);
> +       delta = rq_clock(rq_of(cfs_rq)) - schedstat_val(stats->wait_start);
>
>         if (entity_is_task(se)) {
>                 p = task_of(se);
> @@ -908,30 +931,33 @@ update_stats_wait_end(struct cfs_rq *cfs
>                          * time stamp can be adjusted to accumulate wait time
>                          * prior to migration.
>                          */
> -                       __schedstat_set(se->statistics.wait_start, delta);
> +                       __schedstat_set(stats->wait_start, delta);
>                         return;
>                 }
>                 trace_sched_stat_wait(p, delta);
>         }
>
> -       __schedstat_set(se->statistics.wait_max,
> -                     max(schedstat_val(se->statistics.wait_max), delta));
> -       __schedstat_inc(se->statistics.wait_count);
> -       __schedstat_add(se->statistics.wait_sum, delta);
> -       __schedstat_set(se->statistics.wait_start, 0);
> +       __schedstat_set(stats->wait_max,
> +                     max(schedstat_val(stats->wait_max), delta));
> +       __schedstat_inc(stats->wait_count);
> +       __schedstat_add(stats->wait_sum, delta);
> +       __schedstat_set(stats->wait_start, 0);
>  }
>
>  static inline void
>  update_stats_enqueue_sleeper(struct cfs_rq *cfs_rq, struct sched_entity *se)
>  {
> +       struct sched_statistics *stats;
>         struct task_struct *tsk = NULL;
>         u64 sleep_start, block_start;
>
>         if (!schedstat_enabled())
>                 return;
>
> -       sleep_start = schedstat_val(se->statistics.sleep_start);
> -       block_start = schedstat_val(se->statistics.block_start);
> +       stats = __schedstats_from_se(se);
> +
> +       sleep_start = schedstat_val(stats->sleep_start);
> +       block_start = schedstat_val(stats->block_start);
>
>         if (entity_is_task(se))
>                 tsk = task_of(se);
> @@ -942,11 +968,11 @@ update_stats_enqueue_sleeper(struct cfs_
>                 if ((s64)delta < 0)
>                         delta = 0;
>
> -               if (unlikely(delta > schedstat_val(se->statistics.sleep_max)))
> -                       __schedstat_set(se->statistics.sleep_max, delta);
> +               if (unlikely(delta > schedstat_val(stats->sleep_max)))
> +                       __schedstat_set(stats->sleep_max, delta);
>
> -               __schedstat_set(se->statistics.sleep_start, 0);
> -               __schedstat_add(se->statistics.sum_sleep_runtime, delta);
> +               __schedstat_set(stats->sleep_start, 0);
> +               __schedstat_add(stats->sum_sleep_runtime, delta);
>
>                 if (tsk) {
>                         account_scheduler_latency(tsk, delta >> 10, 1);
> @@ -959,16 +985,16 @@ update_stats_enqueue_sleeper(struct cfs_
>                 if ((s64)delta < 0)
>                         delta = 0;
>
> -               if (unlikely(delta > schedstat_val(se->statistics.block_max)))
> -                       __schedstat_set(se->statistics.block_max, delta);
> +               if (unlikely(delta > schedstat_val(stats->block_max)))
> +                       __schedstat_set(stats->block_max, delta);
>
> -               __schedstat_set(se->statistics.block_start, 0);
> -               __schedstat_add(se->statistics.sum_sleep_runtime, delta);
> +               __schedstat_set(stats->block_start, 0);
> +               __schedstat_add(stats->sum_sleep_runtime, delta);
>
>                 if (tsk) {
>                         if (tsk->in_iowait) {
> -                               __schedstat_add(se->statistics.iowait_sum, delta);
> -                               __schedstat_inc(se->statistics.iowait_count);
> +                               __schedstat_add(stats->iowait_sum, delta);
> +                               __schedstat_inc(stats->iowait_count);
>                                 trace_sched_stat_iowait(tsk, delta);
>                         }
>
> @@ -1030,10 +1056,10 @@ update_stats_dequeue(struct cfs_rq *cfs_
>                 /* XXX racy against TTWU */
>                 state = READ_ONCE(tsk->__state);
>                 if (state & TASK_INTERRUPTIBLE)
> -                       __schedstat_set(se->statistics.sleep_start,
> +                       __schedstat_set(tsk->stats.sleep_start,
>                                       rq_clock(rq_of(cfs_rq)));
>                 if (state & TASK_UNINTERRUPTIBLE)
> -                       __schedstat_set(se->statistics.block_start,
> +                       __schedstat_set(tsk->stats.block_start,
>                                       rq_clock(rq_of(cfs_rq)));
>         }
>  }
> @@ -4502,9 +4528,10 @@ set_next_entity(struct cfs_rq *cfs_rq, s
>          */
>         if (schedstat_enabled() &&
>             rq_of(cfs_rq)->cfs.load.weight >= 2*se->load.weight) {
> -               __schedstat_set(se->statistics.slice_max,
> -                       max((u64)schedstat_val(se->statistics.slice_max),
> -                           se->sum_exec_runtime - se->prev_sum_exec_runtime));
> +               struct sched_statistics *stats = __schedstats_from_se(se);
> +               __schedstat_set(stats->slice_max,
> +                               max((u64)stats->slice_max,
> +                                   se->sum_exec_runtime - se->prev_sum_exec_runtime));
>         }
>
>         se->prev_sum_exec_runtime = se->sum_exec_runtime;
> @@ -5993,12 +6020,12 @@ static int wake_affine(struct sched_doma
>         if (sched_feat(WA_WEIGHT) && target == nr_cpumask_bits)
>                 target = wake_affine_weight(sd, p, this_cpu, prev_cpu, sync);
>
> -       schedstat_inc(p->se.statistics.nr_wakeups_affine_attempts);
> +       schedstat_inc(p->stats.nr_wakeups_affine_attempts);
>         if (target == nr_cpumask_bits)
>                 return prev_cpu;
>
>         schedstat_inc(sd->ttwu_move_affine);
> -       schedstat_inc(p->se.statistics.nr_wakeups_affine);
> +       schedstat_inc(p->stats.nr_wakeups_affine);
>         return target;
>  }
>
> @@ -7802,7 +7829,7 @@ int can_migrate_task(struct task_struct
>         if (!cpumask_test_cpu(env->dst_cpu, p->cpus_ptr)) {
>                 int cpu;
>
> -               schedstat_inc(p->se.statistics.nr_failed_migrations_affine);
> +               schedstat_inc(p->stats.nr_failed_migrations_affine);
>
>                 env->flags |= LBF_SOME_PINNED;
>
> @@ -7836,7 +7863,7 @@ int can_migrate_task(struct task_struct
>         env->flags &= ~LBF_ALL_PINNED;
>
>         if (task_running(env->src_rq, p)) {
> -               schedstat_inc(p->se.statistics.nr_failed_migrations_running);
> +               schedstat_inc(p->stats.nr_failed_migrations_running);
>                 return 0;
>         }
>
> @@ -7858,12 +7885,12 @@ int can_migrate_task(struct task_struct
>             env->sd->nr_balance_failed > env->sd->cache_nice_tries) {
>                 if (tsk_cache_hot == 1) {
>                         schedstat_inc(env->sd->lb_hot_gained[env->idle]);
> -                       schedstat_inc(p->se.statistics.nr_forced_migrations);
> +                       schedstat_inc(p->stats.nr_forced_migrations);
>                 }
>                 return 1;
>         }
>
> -       schedstat_inc(p->se.statistics.nr_failed_migrations_hot);
> +       schedstat_inc(p->stats.nr_failed_migrations_hot);
>         return 0;
>  }
>
> @@ -11390,7 +11417,7 @@ int alloc_fair_sched_group(struct task_g
>                 if (!cfs_rq)
>                         goto err;
>
> -               se = kzalloc_node(sizeof(struct sched_entity),
> +               se = kzalloc_node(sizeof(struct sched_entity_stats),
>                                   GFP_KERNEL, cpu_to_node(i));
>                 if (!se)
>                         goto err_free_rq;
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -1009,8 +1009,8 @@ static void update_curr_rt(struct rq *rq
>         if (unlikely((s64)delta_exec <= 0))
>                 return;
>
> -       schedstat_set(curr->se.statistics.exec_max,
> -                     max(curr->se.statistics.exec_max, delta_exec));
> +       schedstat_set(curr->stats.exec_max,
> +                     max(curr->stats.exec_max, delta_exec));
>
>         curr->se.sum_exec_runtime += delta_exec;
>         account_group_exec_runtime(curr, delta_exec);
> --- a/kernel/sched/stats.h
> +++ b/kernel/sched/stats.h
> @@ -41,6 +41,7 @@ rq_sched_info_dequeue(struct rq *rq, uns
>  #define   schedstat_val_or_zero(var)   ((schedstat_enabled()) ? (var) : 0)
>
>  #else /* !CONFIG_SCHEDSTATS: */
> +
>  static inline void rq_sched_info_arrive  (struct rq *rq, unsigned long long delta) { }
>  static inline void rq_sched_info_dequeue(struct rq *rq, unsigned long long delta) { }
>  static inline void rq_sched_info_depart  (struct rq *rq, unsigned long long delta) { }
> @@ -53,6 +54,7 @@ static inline void rq_sched_info_depart
>  # define   schedstat_set(var, val)     do { } while (0)
>  # define   schedstat_val(var)          0
>  # define   schedstat_val_or_zero(var)  0
> +
>  #endif /* CONFIG_SCHEDSTATS */
>
>  #ifdef CONFIG_PSI
> --- a/kernel/sched/stop_task.c
> +++ b/kernel/sched/stop_task.c
> @@ -78,8 +78,8 @@ static void put_prev_task_stop(struct rq
>         if (unlikely((s64)delta_exec < 0))
>                 delta_exec = 0;
>
> -       schedstat_set(curr->se.statistics.exec_max,
> -                       max(curr->se.statistics.exec_max, delta_exec));
> +       schedstat_set(curr->stats.exec_max,
> +                     max(curr->stats.exec_max, delta_exec));
>
>         curr->se.sum_exec_runtime += delta_exec;
>         account_group_exec_runtime(curr, delta_exec);



-- 
Thanks
Yafang
