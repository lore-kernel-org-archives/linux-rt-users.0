Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40167C432BE
	for <linux-rt-users@archiver.kernel.org>; Tue, 31 Aug 2021 10:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17C8260FE8
	for <linux-rt-users@archiver.kernel.org>; Tue, 31 Aug 2021 10:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240921AbhHaKVF (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 31 Aug 2021 06:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234682AbhHaKVE (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 31 Aug 2021 06:21:04 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAAF2C061575;
        Tue, 31 Aug 2021 03:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3HC1u+t7nD+kgNZouX/L8goGQGQI/ehvF/XWNqquvtE=; b=BtqiQaUd96jX/cvQyn4LHGP0He
        MnhhEm1LxGe1ccadn3pRVsnLi+pX99ktL7ZI35nypv1S4ryWNfofhw5VHwFn19VQZO4XBtoyflSfv
        GbzDVWviYGHSvukol3IzpR3k3F2APISnGDQoL0I/bB+RI3eBUUosbDt0jo0A9yesBka9dhXegd+jY
        1CqxX9SECEnPhAQ4jWqI0BDmUTfDu9icL1Z4ulFbnx3QVEA+ziVk8lGOLxoRYETe8y1r4Ld29M82P
        nnuwRAT1Gw/lyiwF1hOyOHGYMPYVbNsgl27a3xlv3RqrX3KfTJKVTSS2WV63OhgEU6EvmJwvS0m4x
        +qdhJh+A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mL0rv-00Efqz-5F; Tue, 31 Aug 2021 10:19:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9D0A2300109;
        Tue, 31 Aug 2021 12:19:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7ACCD2C83EADB; Tue, 31 Aug 2021 12:19:50 +0200 (CEST)
Date:   Tue, 31 Aug 2021 12:19:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     mingo@redhat.com, mgorman@suse.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        achaiken@aurora.tech, lkp@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v3 2/7] sched: make struct sched_statistics independent
 of fair sched class
Message-ID: <YS4CRi7nzfGk2o7u@hirez.programming.kicks-ass.net>
References: <20210824112946.9324-1-laoar.shao@gmail.com>
 <20210824112946.9324-3-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210824112946.9324-3-laoar.shao@gmail.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Aug 24, 2021 at 11:29:41AM +0000, Yafang Shao wrote:

> +#ifdef CONFIG_FAIR_GROUP_SCHED
> +static inline void
> +__schedstats_from_sched_entity(struct sched_entity *se,
> +			      struct sched_statistics **stats)
> +{
> +	struct task_group *tg;
> +	struct task_struct *p;
> +	struct cfs_rq *cfs;
> +	int cpu;
> +
> +	if (entity_is_task(se)) {
> +		p = task_of(se);
> +		*stats = &p->stats;
> +	} else {
> +		cfs = group_cfs_rq(se);
> +		tg = cfs->tg;
> +		cpu = cpu_of(rq_of(cfs));
> +		*stats = tg->stats[cpu];
> +	}
> +}
> +
> +#else
> +
> +static inline void
> +__schedstats_from_sched_entity(struct sched_entity *se,
> +			      struct sched_statistics **stats)
> +{
> +	struct task_struct *p;
> +
> +	p = task_of(se);
> +	*stats = &p->stats;
> +}
> +
> +#endif
> +
>  /*
>   * Update the current task's runtime statistics.
>   */
> @@ -826,6 +861,7 @@ static void update_curr(struct cfs_rq *cfs_rq)
>  {
>  	struct sched_entity *curr = cfs_rq->curr;
>  	u64 now = rq_clock_task(rq_of(cfs_rq));
> +	struct sched_statistics *stats = NULL;
>  	u64 delta_exec;
>  
>  	if (unlikely(!curr))
> @@ -837,8 +873,11 @@ static void update_curr(struct cfs_rq *cfs_rq)
>  
>  	curr->exec_start = now;
>  
> -	schedstat_set(curr->statistics.exec_max,
> -		      max(delta_exec, curr->statistics.exec_max));
> +	if (schedstat_enabled()) {
> +		__schedstats_from_sched_entity(curr, &stats);
> +		__schedstat_set(stats->exec_max,
> +				max(delta_exec, stats->exec_max));
> +	}
>  
>  	curr->sum_exec_runtime += delta_exec;
>  	schedstat_add(cfs_rq->exec_clock, delta_exec);


That's just really odd style; what's wrong with something like:

static inline struct sched_statistics *
__schedstats_from_se(struct sched_entity *se)
{
	...
}

	if (schedstats_enabled()) {
		struct sched_statistics *stats = __schedstats_from_se(curr);
		__schedstat_set(stats->exec_max, max(stats->exec_max, delta_exec));
	}


