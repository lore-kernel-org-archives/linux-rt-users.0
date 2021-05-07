Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0FE2C433B4
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 May 2021 11:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9267613CD
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 May 2021 11:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234960AbhEGLF7 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 7 May 2021 07:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235044AbhEGLF5 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 7 May 2021 07:05:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCFBC061574;
        Fri,  7 May 2021 04:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lRYs3MBjPam5uFDrJpNKmRYRFbulvjWQ+uYeJOELlFY=; b=IbRrU0Pk9bYEEZD5wnPImHHgpw
        Vpb6wodTnDOpe4c/ul04OlE9JHie+dZEzUmO4w1wMX7+n/IWSNNnaHPdUIdbaD/LifW0MGpXc6A8v
        ChYiCsbuJW2Y0PgFVCwxPTlp/YOuZKMPqR5RfAOxFcvBEB/k9v+YFDMCyMYsaDpjBlOODcGrMFhZS
        Z+EianiEehs/Z7PyM74ZbNN6YKdqxfbxqigcyN9hGotEENHIF8k6fjbrJWgZ/bI2TsWyd21UrPuH+
        qd5PI/FgrCqrHeEnrbbzNEmb9EWE6q97VODBGHzIgJbnMIaT75ZPeAg2+ZAwvGKDjOznUTfR11EC2
        URG4Dxzw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1leyGI-0036qq-TT; Fri, 07 May 2021 11:03:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 868B4300103;
        Fri,  7 May 2021 13:03:12 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3F9772028F002; Fri,  7 May 2021 13:03:12 +0200 (CEST)
Date:   Fri, 7 May 2021 13:03:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Scott Wood <swood@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 3/3] sched/fair: break out of newidle balancing if an
 RT task appears
Message-ID: <YJUecEMZNDfD1Z4K@hirez.programming.kicks-ass.net>
References: <20210428232821.2506201-1-swood@redhat.com>
 <20210428232821.2506201-4-swood@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210428232821.2506201-4-swood@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


I'm going to pretend to have never seen the prior two patches. They do
absolutely horrible things for unspecified reasons. You've utterly
failed to explain what exactly is taking that 1ms+.

newidle_balance() already has 'stop, you're spending too much time'
controls; you've failed to explain how those are falling short and why
they cannot be improved.

On Wed, Apr 28, 2021 at 06:28:21PM -0500, Scott Wood wrote:
> The CFS load balancer can take a little while, to the point of it having
> a special LBF_NEED_BREAK flag, when the task moving code takes a
> breather.
> 
> However, at that point it will jump right back in to load balancing,
> without checking whether the CPU has gained any runnable real time
> (or deadline) tasks.
> 
> Break out of load balancing in the CPU_NEWLY_IDLE case, to allow the
> scheduling of the RT task.  Without this, latencies of over 1ms are
> seen on large systems.
> 
> Signed-off-by: Rik van Riel <riel@redhat.com>
> Reported-by: Clark Williams <williams@redhat.com>
> Signed-off-by: Clark Williams <williams@redhat.com>
> [swood: Limit change to newidle]
> Signed-off-by: Scott Wood <swood@redhat.com>
> ---
> v2: Only break out of newidle balancing
> 
>  kernel/sched/fair.c  | 24 ++++++++++++++++++++----
>  kernel/sched/sched.h |  6 ++++++
>  2 files changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index aa8c87b6aff8..c3500c963af2 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9502,10 +9502,21 @@ imbalanced_active_balance(struct lb_env *env)
>  	return 0;
>  }
>  
> -static int need_active_balance(struct lb_env *env)
> +static bool stop_balance_early(struct lb_env *env)
> +{
> +	return env->idle == CPU_NEWLY_IDLE && rq_has_higher_tasks(env->dst_rq);
> +}
> +
> +static int need_active_balance(struct lb_env *env, int *continue_balancing)
>  {
>  	struct sched_domain *sd = env->sd;
>  
> +	/* Run the realtime task now; load balance later. */
> +	if (stop_balance_early(env)) {
> +		*continue_balancing = 0;
> +		return 0;
> +	}

This placement doesn't make any sense. You very much want this to return
true for the sd->balance_interval = sd->min_interval block for example.

And the other callsite already has an if (idle != CPU_NEWLY_IDLE)
condition to use.

Also, I don't think we care about the higher thing here (either);
newidle is about getting *any* work here, if there's something to do, we
don't need to do more.

> +
>  	if (asym_active_balance(env))
>  		return 1;
>  
> @@ -9550,7 +9561,7 @@ static int should_we_balance(struct lb_env *env)
>  	 * to do the newly idle load balance.
>  	 */
>  	if (env->idle == CPU_NEWLY_IDLE)
> -		return 1;
> +		return !rq_has_higher_tasks(env->dst_rq);

has_higher_task makes no sense here, newidle can stop the moment
nr_running != 0.

>  
>  	/* Try to find first idle CPU */
>  	for_each_cpu_and(cpu, group_balance_mask(sg), env->cpus) {
> @@ -9660,6 +9671,11 @@ static int load_balance(int this_cpu, struct rq *this_rq,
>  
>  		local_irq_restore(rf.flags);
>  
> +		if (stop_balance_early(&env)) {
> +			*continue_balancing = 0;
> +			goto out;
> +		}

Same thing.

> +
>  		if (env.flags & LBF_NEED_BREAK) {
>  			env.flags &= ~LBF_NEED_BREAK;
>  			goto more_balance;
