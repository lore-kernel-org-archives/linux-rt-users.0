Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0131C4320E
	for <linux-rt-users@archiver.kernel.org>; Tue,  3 Aug 2021 23:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C734960C3F
	for <linux-rt-users@archiver.kernel.org>; Tue,  3 Aug 2021 23:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbhHCXmn (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 3 Aug 2021 19:42:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:42834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232296AbhHCXmm (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 3 Aug 2021 19:42:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B78B61037;
        Tue,  3 Aug 2021 23:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628034151;
        bh=Gyk5iVPK76bq7kpepchQcuoWh5YN1ChOAdrgEXiJG5E=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=NOzG/WI38BgVvSVx/LB+2aJ1wpdVTMLNoLu6SijXdHwEEU2VYRD7/Tvrm1TeZbLFN
         8goBwBz0fsv14zYbsVDgD8gMOmGRnsacguEXc/EJpqbTtNORAMSKKHvtW+2JviEf6x
         gi/BQ3kBk9kmI0O2I9IuEWv0JfR/H6SR7xdLtKdLQm0+Lq654LsTJL3BQLO7ydV88E
         qwE2CRQpzYcWc0KBVlb6i7nQkc1Rl5sQSyHC0D/neGmZIPaH2sALgrAdesFuPUDHAs
         IAga1054P5Fwu9tWxhxccAavPUrhSPARo5qq1b42wQlI67y6W+sjZAz5gRzhsAEj0V
         aXw9Z0uZB8SLg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 12C0E5C04D4; Tue,  3 Aug 2021 16:42:31 -0700 (PDT)
Date:   Tue, 3 Aug 2021 16:42:31 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        linux-rt-users@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 2/2] rcutorture: Nudge ksoftirqd priority for RCU boost
 testing
Message-ID: <20210803234231.GW4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210803225437.3612591-1-valentin.schneider@arm.com>
 <20210803225437.3612591-3-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210803225437.3612591-3-valentin.schneider@arm.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Aug 03, 2021 at 11:54:37PM +0100, Valentin Schneider wrote:
> As pointed out by commit 5e59fba573e6 ("rcutorture: Fix testing of RCU
> priority boosting"), timer expiry needs to run at a priority higher than
> that of the rcu_torture_boost threads (FIFO1) for RCU boost testing to
> function. If that's not the case, the rcu_torture_boost threads will
> prevent the wakeup of the RCU grace-period kthread, which means no boosting
> will be initiated.
> 
> Instead of setting this up manually, check the priority of ksoftirqd before
> starting the RCU boost test and nudge if required.
> 
> Note that this does not attempt to save and restore the scheduler
> parameters of ksoftirqd.
> 
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> ---
>  kernel/rcu/rcutorture.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index 680f66b65f14..3dd5fa75f469 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -948,12 +948,26 @@ static int rcu_torture_boost(void *arg)
>  	unsigned long endtime;
>  	unsigned long oldstarttime;
>  	struct rcu_boost_inflight rbi = { .inflight = 0 };
> +	struct task_struct *ksoftirqd = this_cpu_ksoftirqd();
>  
>  	VERBOSE_TOROUT_STRING("rcu_torture_boost started");
>  
>  	/* Set real-time priority. */
>  	sched_set_fifo_low(current);
>  
> +	/*
> +	 * Boost testing requires TIMER_SOFTIRQ to run at a higher priority
> +	 * than the CPU-hogging torture kthreads, otherwise said threads
> +	 * will never let timer expiry for the RCU GP kthread happen, which will
> +	 * prevent any boosting.
> +	 */
> +	if (current->normal_prio < ksoftirqd->normal_prio) {

Would it make sense to add IS_ENABLED(CONFIG_PREEMPT_RT) to the above
condition?

							Thanx, Paul

> +		struct sched_param sp = { .sched_priority = 2 };
> +
> +		pr_alert("%s(): Adjusting %s priority\n", __func__, ksoftirqd->comm);
> +		sched_setscheduler_nocheck(ksoftirqd, SCHED_FIFO, &sp);
> +	}
> +
>  	init_rcu_head_on_stack(&rbi.rcu);
>  	/* Each pass through the following loop does one boost-test cycle. */
>  	do {
> -- 
> 2.25.1
> 
