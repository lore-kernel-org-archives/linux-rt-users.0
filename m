Return-Path: <SRS0=fi+z=6M=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9CB6C83004
	for <linux-rt-users@archiver.kernel.org>; Tue, 28 Apr 2020 21:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEAAE20737
	for <linux-rt-users@archiver.kernel.org>; Tue, 28 Apr 2020 21:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgD1V4S (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 28 Apr 2020 17:56:18 -0400
Received: from foss.arm.com ([217.140.110.172]:59696 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726363AbgD1V4S (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 28 Apr 2020 17:56:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 687ED31B;
        Tue, 28 Apr 2020 14:56:17 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 17FF33F305;
        Tue, 28 Apr 2020 14:56:15 -0700 (PDT)
References: <20200428050242.17717-1-swood@redhat.com> <20200428050242.17717-4-swood@redhat.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Scott Wood <swood@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [RFC PATCH 3/3] sched,rt: break out of load balancing if an RT task appears
In-reply-to: <20200428050242.17717-4-swood@redhat.com>
Date:   Tue, 28 Apr 2020 22:56:13 +0100
Message-ID: <jhjees7s29u.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


On 28/04/20 06:02, Scott Wood wrote:
> From: Rik van Riel <riel@redhat.com>
>
> Bugzilla: 1331562
>
> The CFS load balancer can take a little while, to the point of
> it having a special LBF_NEED_BREAK flag, when the task moving
> code takes a breather.
>
> However, at that point it will jump right back in to load balancing,
> without checking whether the CPU has gained any runnable real time
> (or deadline) tasks.
>
> Only idle_balance used to check for runnable real time tasks on a
> CPU. This patch moves that check into a separate inline function,
> and calls that function in load_balance, at approximately the same
> granularity that LBF_NEED_BREAK happens.
>
> Besides breaking out of load_balance, this patch also clears
> continue_balancing, in order for rebalance_domains to break out
> of its loop when a realtime task becomes runnable.
>
> Signed-off-by: Rik van Riel <riel@redhat.com>
> Reported-by: Clark Williams <williams@redhat.com>
> Signed-off-by: Clark Williams <williams@redhat.com>
> ---
>  kernel/sched/fair.c  | 19 +++++++++++++++++--
>  kernel/sched/sched.h |  6 ++++++
>  2 files changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index dfde7f0ce3db..e7437e4e40b4 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9394,6 +9400,10 @@ static int should_we_balance(struct lb_env *env)
>       struct sched_group *sg = env->sd->groups;
>       int cpu, balance_cpu = -1;
>
> +	/* Run the realtime task now; load balance later. */
> +	if (rq_has_runnable_rt_task(env->dst_rq))
> +		return 0;
> +

I have a feeling this isn't very nice to CFS tasks, since we would now
"waste" load-balance attempts if they happen to coincide with an RT task
being runnable.

On your 72 CPUs machine, the system-wide balance happens (at best) every
72ms if you have idle time, every ~2300ms otherwise (every balance
CPU gets to try to balance however, so it's not as horrible as I'm making
it sound). This is totally worst-case scenario territory, and you'd hope
newidle_balance() could help here and there (as it isn't gated by any
balance interval).

Still, even for a single rq, postponing a system-wide balance for a
full balance interval (i.e. ~2 secs worst case here) just because we had a
single RT task running when we tried to balance seems a bit much.

It may be possible to hack something to detect those cases and reset the
interval to "now" when e.g. dequeuing the last RT task (& after having
previously aborted a load-balance due to RT/DL/foobar).

>       /*
>        * Ensure the balancing environment is consistent; can happen
>        * when the softirq triggers 'during' hotplug.
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 3d97c51544d7..a2a01dfd2bea 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1878,6 +1878,12 @@ static inline struct cpuidle_state *idle_get_state(struct rq *rq)
>
>       return rq->idle_state;
>  }
> +
> +/* Is there a task of a high priority class? */
> +static inline bool rq_has_runnable_rt_task(struct rq *rq)
> +{
> +	return unlikely(rq->nr_running != rq->cfs.h_nr_running);

Seeing as that can be RT, DL or stopper, that name is somewhat misleading.

> +}
>  #else
>  static inline void idle_set_state(struct rq *rq,
>                                 struct cpuidle_state *idle_state)
