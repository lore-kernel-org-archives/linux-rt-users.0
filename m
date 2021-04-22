Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4EAEC433B4
	for <linux-rt-users@archiver.kernel.org>; Thu, 22 Apr 2021 15:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91A7061222
	for <linux-rt-users@archiver.kernel.org>; Thu, 22 Apr 2021 15:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237921AbhDVPTX (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 22 Apr 2021 11:19:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:34440 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237954AbhDVPTP (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 22 Apr 2021 11:19:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5C5EEB170;
        Thu, 22 Apr 2021 15:18:39 +0000 (UTC)
To:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux-RT-Users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210422111441.24318-1-mgorman@techsingularity.net>
 <20210422111441.24318-4-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 3/9] mm/vmstat: Convert NUMA statistics to basic NUMA
 counters
Message-ID: <ba72d967-aa4e-47e5-5f99-df3dd0bf21d2@suse.cz>
Date:   Thu, 22 Apr 2021 17:18:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210422111441.24318-4-mgorman@techsingularity.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 4/22/21 1:14 PM, Mel Gorman wrote:
> NUMA statistics are maintained on the zone level for hits, misses, foreign
> etc but nothing relies on them being perfectly accurate for functional
> correctness. The counters are used by userspace to get a general overview
> of a workloads NUMA behaviour but the page allocator incurs a high cost to
> maintain perfect accuracy similar to what is required for a vmstat like
> NR_FREE_PAGES. There even is a sysctl vm.numa_stat to allow userspace to
> turn off the collection of NUMA statistics like NUMA_HIT.
> 
> This patch converts NUMA_HIT and friends to be NUMA events with similar
> accuracy to VM events. There is a possibility that slight errors will be
> introduced but the overall trend as seen by userspace will be similar.
> The counters are no longer updated from vmstat_refresh context as it is
> unnecessary overhead for counters that may never be read by userspace.
> Note that counters could be maintained at the node level to save space
> but it would have a user-visible impact due to /proc/zoneinfo.
> 
> [lkp@intel.com: Fix misplaced closing brace for !CONFIG_NUMA]
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

...

> @@ -731,26 +722,34 @@ static int fold_diff(int *zone_diff, int *numa_diff, int *node_diff)
>  	}
>  	return changes;
>  }
> -#else
> -static int fold_diff(int *zone_diff, int *node_diff)
> +
> +#ifdef CONFIG_NUMA
> +static void fold_vm_zone_numa_events(struct zone *zone)
>  {
> -	int i;
> -	int changes = 0;
> +	int zone_numa_events[NR_VM_NUMA_EVENT_ITEMS] = { 0, };

Should this be long? pzstats are, the global counters too, so seems weird to use
int as intermediate sum counter.

> +	int cpu;
> +	enum numa_stat_item item;
>  
> -	for (i = 0; i < NR_VM_ZONE_STAT_ITEMS; i++)
> -		if (zone_diff[i]) {
> -			atomic_long_add(zone_diff[i], &vm_zone_stat[i]);
> -			changes++;
> -	}
> +	for_each_online_cpu(cpu) {
> +		struct per_cpu_zonestat *pzstats;
>  
> -	for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
> -		if (node_diff[i]) {
> -			atomic_long_add(node_diff[i], &vm_node_stat[i]);
> -			changes++;
> +		pzstats = per_cpu_ptr(zone->per_cpu_zonestats, cpu);
> +		for (item = 0; item < NR_VM_NUMA_EVENT_ITEMS; item++)
> +			zone_numa_events[item] += xchg(&pzstats->vm_numa_event[item], 0);
>  	}
> -	return changes;
> +
> +	for (item = 0; item < NR_VM_NUMA_EVENT_ITEMS; item++)
> +		zone_numa_event_add(zone_numa_events[item], zone, item);
>  }
> -#endif /* CONFIG_NUMA */
> +
> +void fold_vm_numa_events(void)
> +{
> +	struct zone *zone;
> +
> +	for_each_populated_zone(zone)
> +		fold_vm_zone_numa_events(zone);
> +}
> +#endif
>  
>  /*
>   * Update the zone counters for the current cpu.
> @@ -774,15 +773,14 @@ static int refresh_cpu_vm_stats(bool do_pagesets)
>  	struct zone *zone;
>  	int i;
>  	int global_zone_diff[NR_VM_ZONE_STAT_ITEMS] = { 0, };
> -#ifdef CONFIG_NUMA
> -	int global_numa_diff[NR_VM_NUMA_STAT_ITEMS] = { 0, };
> -#endif
>  	int global_node_diff[NR_VM_NODE_STAT_ITEMS] = { 0, };
>  	int changes = 0;
>  
>  	for_each_populated_zone(zone) {
>  		struct per_cpu_zonestat __percpu *pzstats = zone->per_cpu_zonestats;
> +#ifdef CONFIG_NUMA
>  		struct per_cpu_pages __percpu *pcp = zone->per_cpu_pageset;
> +#endif
>  
>  		for (i = 0; i < NR_VM_ZONE_STAT_ITEMS; i++) {
>  			int v;
> @@ -799,17 +797,6 @@ static int refresh_cpu_vm_stats(bool do_pagesets)
>  			}
>  		}
>  #ifdef CONFIG_NUMA
> -		for (i = 0; i < NR_VM_NUMA_STAT_ITEMS; i++) {
> -			int v;
> -
> -			v = this_cpu_xchg(pzstats->vm_numa_stat_diff[i], 0);
> -			if (v) {
> -
> -				atomic_long_add(v, &zone->vm_numa_stat[i]);
> -				global_numa_diff[i] += v;
> -				__this_cpu_write(pcp->expire, 3);
> -			}
> -		}
>  
>  		if (do_pagesets) {
>  			cond_resched();
> @@ -857,12 +844,7 @@ static int refresh_cpu_vm_stats(bool do_pagesets)
>  		}
>  	}
>  
> -#ifdef CONFIG_NUMA
> -	changes += fold_diff(global_zone_diff, global_numa_diff,
> -			     global_node_diff);
> -#else
>  	changes += fold_diff(global_zone_diff, global_node_diff);
> -#endif
>  	return changes;
>  }
>  
> @@ -877,9 +859,6 @@ void cpu_vm_stats_fold(int cpu)
>  	struct zone *zone;
>  	int i;
>  	int global_zone_diff[NR_VM_ZONE_STAT_ITEMS] = { 0, };
> -#ifdef CONFIG_NUMA
> -	int global_numa_diff[NR_VM_NUMA_STAT_ITEMS] = { 0, };
> -#endif
>  	int global_node_diff[NR_VM_NODE_STAT_ITEMS] = { 0, };
>  
>  	for_each_populated_zone(zone) {
> @@ -887,7 +866,7 @@ void cpu_vm_stats_fold(int cpu)
>  
>  		pzstats = per_cpu_ptr(zone->per_cpu_zonestats, cpu);
>  
> -		for (i = 0; i < NR_VM_ZONE_STAT_ITEMS; i++)
> +		for (i = 0; i < NR_VM_ZONE_STAT_ITEMS; i++) {
>  			if (pzstats->vm_stat_diff[i]) {
>  				int v;
>  
> @@ -896,17 +875,17 @@ void cpu_vm_stats_fold(int cpu)
>  				atomic_long_add(v, &zone->vm_stat[i]);
>  				global_zone_diff[i] += v;
>  			}
> -
> +		}
>  #ifdef CONFIG_NUMA
> -		for (i = 0; i < NR_VM_NUMA_STAT_ITEMS; i++)
> -			if (pzstats->vm_numa_stat_diff[i]) {
> +		for (i = 0; i < NR_VM_NUMA_EVENT_ITEMS; i++) {
> +			if (pzstats->vm_numa_event[i]) {
>  				int v;

Also long?

>  
> -				v = pzstats->vm_numa_stat_diff[i];
> -				pzstats->vm_numa_stat_diff[i] = 0;
> -				atomic_long_add(v, &zone->vm_numa_stat[i]);
> -				global_numa_diff[i] += v;
> +				v = pzstats->vm_numa_event[i];
> +				pzstats->vm_numa_event[i] = 0;
> +				zone_numa_event_add(v, zone, i);
>  			}
> +		}
>  #endif
>  	}
>  
> @@ -926,11 +905,7 @@ void cpu_vm_stats_fold(int cpu)
>  			}
>  	}
>  
> -#ifdef CONFIG_NUMA
> -	fold_diff(global_zone_diff, global_numa_diff, global_node_diff);
> -#else
>  	fold_diff(global_zone_diff, global_node_diff);
> -#endif
>  }
>  
>  /*
> @@ -939,43 +914,36 @@ void cpu_vm_stats_fold(int cpu)
>   */
>  void drain_zonestat(struct zone *zone, struct per_cpu_zonestat *pzstats)
>  {
> -	int i;
> +	int i, v;

And the 'v' here. Maybe keep using local to each loop below and make it long for
the NUMA one?

> -	for (i = 0; i < NR_VM_ZONE_STAT_ITEMS; i++)
> +	for (i = 0; i < NR_VM_ZONE_STAT_ITEMS; i++) {
>  		if (pzstats->vm_stat_diff[i]) {
> -			int v = pzstats->vm_stat_diff[i];
> +			v = pzstats->vm_stat_diff[i];
>  			pzstats->vm_stat_diff[i] = 0;
> -			atomic_long_add(v, &zone->vm_stat[i]);
> -			atomic_long_add(v, &vm_zone_stat[i]);
> +			zone_page_state_add(v, zone, i);
>  		}
> +	}
>  
>  #ifdef CONFIG_NUMA
> -	for (i = 0; i < NR_VM_NUMA_STAT_ITEMS; i++)
> -		if (pzstats->vm_numa_stat_diff[i]) {
> -			int v = pzstats->vm_numa_stat_diff[i];
> -
> -			pzstats->vm_numa_stat_diff[i] = 0;
> -			atomic_long_add(v, &zone->vm_numa_stat[i]);
> -			atomic_long_add(v, &vm_numa_stat[i]);
> +	for (i = 0; i < NR_VM_NUMA_EVENT_ITEMS; i++) {
> +		if (pzstats->vm_numa_event[i]) {
> +			v = pzstats->vm_numa_event[i];
> +			pzstats->vm_numa_event[i] = 0;
> +			zone_numa_event_add(v, zone, i);
>  		}
> +	}
>  #endif
>  }
>  #endif
>  
>  #ifdef CONFIG_NUMA
