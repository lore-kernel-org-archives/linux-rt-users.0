Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A53C5C64E7B
	for <linux-rt-users@archiver.kernel.org>; Tue,  1 Dec 2020 12:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C56E2085B
	for <linux-rt-users@archiver.kernel.org>; Tue,  1 Dec 2020 12:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbgLAMm3 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 1 Dec 2020 07:42:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:54614 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727055AbgLAMm3 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 1 Dec 2020 07:42:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 81DBCACC4;
        Tue,  1 Dec 2020 12:41:47 +0000 (UTC)
Date:   Tue, 1 Dec 2020 12:41:44 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        qianjun.kernel@gmail.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 3/6] sched: make struct sched_statistics independent of
 fair sched class
Message-ID: <20201201124144.GT3306@suse.de>
References: <20201201115416.26515-1-laoar.shao@gmail.com>
 <20201201115416.26515-4-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20201201115416.26515-4-laoar.shao@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Dec 01, 2020 at 07:54:13PM +0800, Yafang Shao wrote:
> If we want to use schedstats facility, we should move out of
> struct sched_statistics from the struct sched_entity or add it into other
> sctructs of sched entity as well. Obviously the latter one is bad because
> that requires more spaces. So we should move it into a common struct which
> can be used by all sched classes.
> 
> The struct sched_statistics is the schedular statistics of a task_struct
> or a task_group. So we can move it into struct task_struct and
> struct task_group to achieve the goal.
> 
> Below is the detailed explaination of the change in the structs.
> 
> - Before this patch
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
> - After this patch
> 
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
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

I didn't see anything wrong as such, it's mostly a mechanical
conversion. The one slight caveat is the potential change in cache
location for the statistics but it's not necessarily negative. The stats
potentially move to a different cache line but it's less obvious whether
that even matters given the location is very similar.

There is increased overhead now when schedstats are *enabled* because
_schedstat_from_sched_entity() has to be called but it appears that it is
protected by a schedstat_enabled() check. So ok, schedstats when enabled
are now a bit more expensive but they were expensive in the first place
so does it matter?

I'd have been happied if there was a comparison with schedstats enabled
just in case the overhead is too high but it could also do with a second
set of eyeballs.

It's somewhat tentative but

Acked-by: Mel Gorman <mgorman@suse.de>

-- 
Mel Gorman
SUSE Labs
