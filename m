Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C870C433B4
	for <linux-rt-users@archiver.kernel.org>; Wed, 14 Apr 2021 16:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2189861168
	for <linux-rt-users@archiver.kernel.org>; Wed, 14 Apr 2021 16:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352724AbhDNQbo (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 14 Apr 2021 12:31:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:43334 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233369AbhDNQbm (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 14 Apr 2021 12:31:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2E18EAF80;
        Wed, 14 Apr 2021 16:31:19 +0000 (UTC)
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
 <20210414133931.4555-6-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 05/11] mm/page_alloc: Batch the accounting updates in the
 bulk allocator
Message-ID: <e9301fe4-04ce-8bb0-e76c-1ac824c8e1a5@suse.cz>
Date:   Wed, 14 Apr 2021 18:31:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210414133931.4555-6-mgorman@techsingularity.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 4/14/21 3:39 PM, Mel Gorman wrote:
> Now that the zone_statistics are simple counters that do not require
> special protection, the bulk allocator accounting updates can be batch
> updated without adding too much complexity with protected RMW updates or
> using xchg.
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  include/linux/vmstat.h |  8 ++++++++
>  mm/page_alloc.c        | 30 +++++++++++++-----------------
>  2 files changed, 21 insertions(+), 17 deletions(-)
> 
> diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
> index dde4dec4e7dd..8473b8fa9756 100644
> --- a/include/linux/vmstat.h
> +++ b/include/linux/vmstat.h
> @@ -246,6 +246,14 @@ __count_numa_event(struct zone *zone, enum numa_stat_item item)
>  	raw_cpu_inc(pzstats->vm_numa_event[item]);
>  }
>  
> +static inline void
> +__count_numa_events(struct zone *zone, enum numa_stat_item item, long delta)
> +{
> +	struct per_cpu_zonestat __percpu *pzstats = zone->per_cpu_zonestats;
> +
> +	raw_cpu_add(pzstats->vm_numa_event[item], delta);
> +}
> +
>  extern void __count_numa_event(struct zone *zone, enum numa_stat_item item);
>  extern unsigned long sum_zone_node_page_state(int node,
>  					      enum zone_stat_item item);
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 9d0f047647e3..cff0f1c98b28 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3411,7 +3411,8 @@ void __putback_isolated_page(struct page *page, unsigned int order, int mt)
>   *
>   * Must be called with interrupts disabled.
>   */
> -static inline void zone_statistics(struct zone *preferred_zone, struct zone *z)
> +static inline void zone_statistics(struct zone *preferred_zone, struct zone *z,
> +				   long nr_account)
>  {
>  #ifdef CONFIG_NUMA
>  	enum numa_stat_item local_stat = NUMA_LOCAL;
> @@ -3424,12 +3425,12 @@ static inline void zone_statistics(struct zone *preferred_zone, struct zone *z)
>  		local_stat = NUMA_OTHER;
>  
>  	if (zone_to_nid(z) == zone_to_nid(preferred_zone))
> -		__count_numa_event(z, NUMA_HIT);
> +		__count_numa_events(z, NUMA_HIT, nr_account);
>  	else {
> -		__count_numa_event(z, NUMA_MISS);
> -		__count_numa_event(preferred_zone, NUMA_FOREIGN);
> +		__count_numa_events(z, NUMA_MISS, nr_account);
> +		__count_numa_events(preferred_zone, NUMA_FOREIGN, nr_account);
>  	}
> -	__count_numa_event(z, local_stat);
> +	__count_numa_events(z, local_stat, nr_account);
>  #endif
>  }
>  
> @@ -3475,7 +3476,7 @@ static struct page *rmqueue_pcplist(struct zone *preferred_zone,
>  	page = __rmqueue_pcplist(zone,  migratetype, alloc_flags, pcp, list);
>  	if (page) {
>  		__count_zid_vm_events(PGALLOC, page_zonenum(page), 1);
> -		zone_statistics(preferred_zone, zone);
> +		zone_statistics(preferred_zone, zone, 1);
>  	}
>  	local_unlock_irqrestore(&pagesets.lock, flags);
>  	return page;
> @@ -3536,7 +3537,7 @@ struct page *rmqueue(struct zone *preferred_zone,
>  				  get_pcppage_migratetype(page));
>  
>  	__count_zid_vm_events(PGALLOC, page_zonenum(page), 1 << order);
> -	zone_statistics(preferred_zone, zone);
> +	zone_statistics(preferred_zone, zone, 1);
>  	local_irq_restore(flags);
>  
>  out:
> @@ -5019,7 +5020,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
>  	struct alloc_context ac;
>  	gfp_t alloc_gfp;
>  	unsigned int alloc_flags = ALLOC_WMARK_LOW;
> -	int nr_populated = 0;
> +	int nr_populated = 0, nr_account = 0;
>  
>  	if (unlikely(nr_pages <= 0))
>  		return 0;
> @@ -5092,15 +5093,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
>  				goto failed_irq;
>  			break;
>  		}
> -
> -		/*
> -		 * Ideally this would be batched but the best way to do
> -		 * that cheaply is to first convert zone_statistics to
> -		 * be inaccurate per-cpu counter like vm_events to avoid
> -		 * a RMW cycle then do the accounting with IRQs enabled.
> -		 */
> -		__count_zid_vm_events(PGALLOC, zone_idx(zone), 1);
> -		zone_statistics(ac.preferred_zoneref->zone, zone);
> +		nr_account++;
>  
>  		prep_new_page(page, 0, gfp, 0);
>  		if (page_list)
> @@ -5110,6 +5103,9 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
>  		nr_populated++;
>  	}
>  
> +	__count_zid_vm_events(PGALLOC, zone_idx(zone), nr_account);
> +	zone_statistics(ac.preferred_zoneref->zone, zone, nr_account);
> +
>  	local_unlock_irqrestore(&pagesets.lock, flags);
>  
>  	return nr_populated;
> 

