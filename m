Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC77C433ED
	for <linux-rt-users@archiver.kernel.org>; Wed, 14 Apr 2021 16:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78EFF611B0
	for <linux-rt-users@archiver.kernel.org>; Wed, 14 Apr 2021 16:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352667AbhDNQVE (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 14 Apr 2021 12:21:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:35032 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233512AbhDNQVB (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 14 Apr 2021 12:21:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A2135AF0E;
        Wed, 14 Apr 2021 16:20:38 +0000 (UTC)
Subject: Re: [PATCH 04/11] mm/vmstat: Inline NUMA event counter updates
To:     Mel Gorman <mgorman@techsingularity.net>,
        Linux-MM <linux-mm@kvack.org>,
        Linux-RT-Users <linux-rt-users@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Michal Hocko <mhocko@kernel.org>
References: <20210414133931.4555-1-mgorman@techsingularity.net>
 <20210414133931.4555-5-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <6b25af48-9c6e-2c55-03d5-763de4aba149@suse.cz>
Date:   Wed, 14 Apr 2021 18:20:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210414133931.4555-5-mgorman@techsingularity.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 4/14/21 3:39 PM, Mel Gorman wrote:
> __count_numa_event is small enough to be treated similarly to
> __count_vm_event so inline it.
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  include/linux/vmstat.h | 9 +++++++++
>  mm/vmstat.c            | 9 ---------
>  2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
> index fc14415223c5..dde4dec4e7dd 100644
> --- a/include/linux/vmstat.h
> +++ b/include/linux/vmstat.h
> @@ -237,6 +237,15 @@ static inline unsigned long zone_page_state_snapshot(struct zone *zone,
>  }
>  
>  #ifdef CONFIG_NUMA
> +/* See __count_vm_event comment on why raw_cpu_inc is used. */
> +static inline void
> +__count_numa_event(struct zone *zone, enum numa_stat_item item)
> +{
> +	struct per_cpu_zonestat __percpu *pzstats = zone->per_cpu_zonestats;
> +
> +	raw_cpu_inc(pzstats->vm_numa_event[item]);
> +}
> +
>  extern void __count_numa_event(struct zone *zone, enum numa_stat_item item);
>  extern unsigned long sum_zone_node_page_state(int node,
>  					      enum zone_stat_item item);
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 63bd84d122c0..b853df95ed0c 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -902,15 +902,6 @@ void drain_zonestat(struct zone *zone, struct per_cpu_zonestat *pzstats)
>  #endif
>  
>  #ifdef CONFIG_NUMA
> -/* See __count_vm_event comment on why raw_cpu_inc is used. */
> -void __count_numa_event(struct zone *zone,
> -				 enum numa_stat_item item)
> -{
> -	struct per_cpu_zonestat __percpu *pzstats = zone->per_cpu_zonestats;
> -
> -	raw_cpu_inc(pzstats->vm_numa_event[item]);
> -}
> -
>  /*
>   * Determine the per node value of a stat item. This function
>   * is called frequently in a NUMA machine, so try to be as
> 

