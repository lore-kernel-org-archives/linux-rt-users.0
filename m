Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08795C64E7B
	for <linux-rt-users@archiver.kernel.org>; Thu,  3 Dec 2020 08:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A60922206
	for <linux-rt-users@archiver.kernel.org>; Thu,  3 Dec 2020 08:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729967AbgLCIsR (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 3 Dec 2020 03:48:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbgLCIsQ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 3 Dec 2020 03:48:16 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CECC061A4D;
        Thu,  3 Dec 2020 00:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rHEL9BvX3SUky5t36TE/Zf15Wkba6MgcWFvLSPnTlI4=; b=icSp/DC4tvyvPQZinddAfp6WvS
        5+gmgakzGziniji1CH54cCFqN6T8XqkWzrVT/aTmGv3jfsLX4hweB8hjBCaGKx4I8wHb+kCKSqh5p
        hc81uObxhgkWPicW95Qczj9mqwTIhdei3NphHrCUeA50S1aI7VhpQonCnnsUm01C50LIX5usUqIXO
        uAe6n03LfPfJS6FzmBB1AoYE5K8qPMIlIXMLDGpFC/jYhJWg0w8o02s+r8FuY1jaLIb1gl2cjFbH4
        AdREWHTbSzyAjMz/bqiIjmHc0OXDxVRqbZY/XS1xAvJnkZoe7L8uSM3Rz5JOXP55F89X8R5JAjyit
        2ku7W9RA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kkkGs-0000ql-9J; Thu, 03 Dec 2020 08:47:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B86B0302753;
        Thu,  3 Dec 2020 09:47:23 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 985FD20270BBE; Thu,  3 Dec 2020 09:47:23 +0100 (CET)
Date:   Thu, 3 Dec 2020 09:47:23 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Scott Wood <swood@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] sched/fair: Don't migrate with src_cpu == dst_cpu
Message-ID: <20201203084723.GG2414@hirez.programming.kicks-ass.net>
References: <20201203060449.3352126-1-swood@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203060449.3352126-1-swood@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, Dec 03, 2020 at 12:04:49AM -0600, Scott Wood wrote:
> Besides being a waste of time to try to move tasks to where they already
> are, this avoids triggering the WARN_ON_ONCE(is_migration_disabled(p))
> in set_task_cpu().
> 
> Signed-off-by: Scott Wood <swood@redhat.com>
> ---
> Patch is against tip/master.  Assertion was seen by running rteval on the
> RT tree.
> 
>  kernel/sched/fair.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index e7e21ac479a2..f443626164d4 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7574,7 +7574,8 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
>  
>  		/* Prevent to re-select dst_cpu via env's CPUs: */
>  		for_each_cpu_and(cpu, env->dst_grpmask, env->cpus) {
> -			if (cpumask_test_cpu(cpu, p->cpus_ptr)) {
> +			if (cpu != env->src_cpu &&
> +			    cpumask_test_cpu(cpu, p->cpus_ptr)) {
>  				env->flags |= LBF_DST_PINNED;
>  				env->new_dst_cpu = cpu;
>  				break;

Do we have _any_ clue as to how we ended up in that situation? The above
sounds like it should be a WARN and we should avoid getting here in the
first place.
