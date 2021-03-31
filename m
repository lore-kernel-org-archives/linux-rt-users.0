Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F05C433C1
	for <linux-rt-users@archiver.kernel.org>; Wed, 31 Mar 2021 09:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DA196196C
	for <linux-rt-users@archiver.kernel.org>; Wed, 31 Mar 2021 09:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234833AbhCaJz6 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 31 Mar 2021 05:55:58 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50514 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234758AbhCaJz5 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 31 Mar 2021 05:55:57 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617184556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n8egLNe9biouITjDj57a69uKUzbO74IUflUeJpXEdpM=;
        b=vgFKIwF1PDKfOwsLvywFqtaLQ1rldkb8KcKa17SY6OccT9RxhvdquFLWKyAcjsF+l7IzEN
        qsx+Uph3aia+K/A0I1zabNKRK5t6zFcNEU4He2oDTK2e+h+cltQUfPj6tN14h+tsvLjnLS
        QM4E9QH9Mp3CkrSZoso4BogGL1sn45Tb4HG95rL3u8Vw7bUs0dFJ2pg6B8R2hUJSgJs2U2
        pSrV10Chu0tqAPCEjEAogI5V+4QI2Paj0IH8o2P8J++LAQWCT3gWgATncpxHz0K63yuCS4
        I4/ZOqPE1XCZCnfIVGsjF5LQqwkanChLSJh1ol13z2OLweXAkeANYYbYC9gICQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617184556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n8egLNe9biouITjDj57a69uKUzbO74IUflUeJpXEdpM=;
        b=96Cww/ZrNvgw9pMzmh5ehCcFirJhESxBhLoSS9Xm9UvtZUJHcVgW2k375Y6GzDK4DTtJt1
        bUVhyatgMN7+yTBA==
To:     Mel Gorman <mgorman@techsingularity.net>,
        Linux-MM <linux-mm@kvack.org>
Cc:     Linux-RT-Users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 2/6] mm/page_alloc: Convert per-cpu list protection to local_lock
In-Reply-To: <20210329120648.19040-3-mgorman@techsingularity.net>
References: <20210329120648.19040-1-mgorman@techsingularity.net> <20210329120648.19040-3-mgorman@techsingularity.net>
Date:   Wed, 31 Mar 2021 11:55:56 +0200
Message-ID: <877dln640j.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, Mar 29 2021 at 13:06, Mel Gorman wrote:
> There is a lack of clarity of what exactly local_irq_save/local_irq_restore
> protects in page_alloc.c . It conflates the protection of per-cpu page
> allocation structures with per-cpu vmstat deltas.
>
> This patch protects the PCP structure using local_lock which
> for most configurations is identical to IRQ enabling/disabling.
> The scope of the lock is still wider than it should be but this is
> decreased in later patches. The per-cpu vmstat deltas are protected by
> preempt_disable/preempt_enable where necessary instead of relying on
> IRQ disable/enable.

Yes, this goes into the right direction and I really appreciate the
scoped protection for clarity sake.

>  #ifdef CONFIG_MEMORY_HOTREMOVE
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 8a8f1a26b231..01b74ff73549 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -887,6 +887,7 @@ void cpu_vm_stats_fold(int cpu)
>  
>  		pzstats = per_cpu_ptr(zone->per_cpu_zonestats, cpu);
>  
> +		preempt_disable();

What's the reason for the preempt_disable() here? A comment would be
appreciated.

>  		for (i = 0; i < NR_VM_ZONE_STAT_ITEMS; i++)
>  			if (pzstats->vm_stat_diff[i]) {
>  				int v;
> @@ -908,6 +909,7 @@ void cpu_vm_stats_fold(int cpu)
>  				global_numa_diff[i] += v;
>  			}
>  #endif
> +		preempt_enable();
>  	}
>  
>  	for_each_online_pgdat(pgdat) {
> @@ -941,6 +943,7 @@ void drain_zonestat(struct zone *zone, struct per_cpu_zonestat *pzstats)
>  {
>  	int i;
>  
> +	preempt_disable();

Same here.

>  	for (i = 0; i < NR_VM_ZONE_STAT_ITEMS; i++)
>  		if (pzstats->vm_stat_diff[i]) {
>  			int v = pzstats->vm_stat_diff[i];
> @@ -959,6 +962,7 @@ void drain_zonestat(struct zone *zone, struct per_cpu_zonestat *pzstats)
>  			atomic_long_add(v, &vm_numa_stat[i]);
>  		}
>  #endif
> +	preempt_enable();

Thanks,

        tglx
