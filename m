Return-Path: <SRS0=fi+z=6M=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 566B6C83004
	for <linux-rt-users@archiver.kernel.org>; Tue, 28 Apr 2020 21:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E10A20731
	for <linux-rt-users@archiver.kernel.org>; Tue, 28 Apr 2020 21:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgD1Vh0 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 28 Apr 2020 17:37:26 -0400
Received: from foss.arm.com ([217.140.110.172]:59422 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726274AbgD1Vh0 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 28 Apr 2020 17:37:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C2CBD31B;
        Tue, 28 Apr 2020 14:37:25 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 71FA13F68F;
        Tue, 28 Apr 2020 14:37:24 -0700 (PDT)
References: <20200428050242.17717-1-swood@redhat.com> <20200428050242.17717-2-swood@redhat.com>
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
Subject: Re: [RFC PATCH 1/3] sched/fair: Call newidle_balance() from finish_task_switch()
In-reply-to: <20200428050242.17717-2-swood@redhat.com>
Date:   Tue, 28 Apr 2020 22:37:18 +0100
Message-ID: <jhjftcns35d.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


On 28/04/20 06:02, Scott Wood wrote:
> Thus, newidle_balance() is entered with interrupts enabled, which allows
> (in the next patch) enabling interrupts when the lock is dropped.
>
> Signed-off-by: Scott Wood <swood@redhat.com>
> ---
>  kernel/sched/core.c  |  7 ++++---
>  kernel/sched/fair.c  | 45 ++++++++++++++++----------------------------
>  kernel/sched/sched.h |  6 ++----
>  3 files changed, 22 insertions(+), 36 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 9a2fbf98fd6f..0294beb8d16c 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3241,6 +3241,10 @@ static struct rq *finish_task_switch(struct task_struct *prev)
>       }
>
>       tick_nohz_task_switch();
> +
> +	if (is_idle_task(current))
> +		newidle_balance();
> +

This means we must go through a switch_to(idle) before figuring out we
could've switched to a CFS task, and do it then. I'm curious to see the
performance impact of that.

>       return rq;
>  }
>
> @@ -10425,14 +10408,23 @@ static inline void nohz_newidle_balance(struct rq *this_rq) { }
>   *     0 - failed, no new tasks
>   *   > 0 - success, new (fair) tasks present
>   */
> -int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
> +int newidle_balance(void)
>  {
>       unsigned long next_balance = jiffies + HZ;
> -	int this_cpu = this_rq->cpu;
> +	int this_cpu;
>       struct sched_domain *sd;
> +	struct rq *this_rq;
>       int pulled_task = 0;
>       u64 curr_cost = 0;
>
> +	preempt_disable();
> +	this_rq = this_rq();
> +	this_cpu = this_rq->cpu;
> +	local_bh_disable();
> +	raw_spin_lock_irq(&this_rq->lock);
> +
> +	update_rq_clock(this_rq);
> +
>       update_misfit_status(NULL, this_rq);

I'm thinking this should be moved to where newidle_balance() used to be,
otherwise we have a window where the rq is flagged as having a misfit
task despite not having any runnable CFS tasks.

>       /*
>        * We must set idle_stamp _before_ calling idle_balance(), such that we
