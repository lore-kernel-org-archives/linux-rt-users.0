Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C36CCC43461
	for <linux-rt-users@archiver.kernel.org>; Wed, 14 Apr 2021 17:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B25161177
	for <linux-rt-users@archiver.kernel.org>; Wed, 14 Apr 2021 17:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350095AbhDNRWH (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 14 Apr 2021 13:22:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:47272 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349855AbhDNRWF (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 14 Apr 2021 13:22:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F35C0B007;
        Wed, 14 Apr 2021 17:21:42 +0000 (UTC)
Subject: Re: [PATCH 07/11] mm/page_alloc: Remove duplicate checks if
 migratetype should be isolated
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
 <20210414133931.4555-8-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <e5a41984-998f-730f-852b-3de82b582d01@suse.cz>
Date:   Wed, 14 Apr 2021 19:21:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210414133931.4555-8-mgorman@techsingularity.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 4/14/21 3:39 PM, Mel Gorman wrote:
> Both free_pcppages_bulk() and free_one_page() have very similar
> checks about whether a page's migratetype has changed under the
> zone lock. Use a common helper.
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Seems like for free_pcppages_bulk() this patch makes it check for each page on
the pcplist
- zone->nr_isolate_pageblock != 0 instead of local bool (the performance might
be the same I guess on modern cpu though)
- is_migrate_isolate(migratetype) for a migratetype obtained by
get_pcppage_migratetype() which cannot be migrate_isolate so the check is useless.

As such it doesn't seem a worthwhile cleanup to me considering all the other
microoptimisations?

> ---
>  mm/page_alloc.c | 32 ++++++++++++++++++++++----------
>  1 file changed, 22 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 295624fe293b..1ed370668e7f 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1354,6 +1354,23 @@ static inline void prefetch_buddy(struct page *page)
>  	prefetch(buddy);
>  }
>  
> +/*
> + * The migratetype of a page may have changed due to isolation so check.
> + * Assumes the caller holds the zone->lock to serialise against page
> + * isolation.
> + */
> +static inline int
> +check_migratetype_isolated(struct zone *zone, struct page *page, unsigned long pfn, int migratetype)
> +{
> +	/* If isolating, check if the migratetype has changed */
> +	if (unlikely(has_isolate_pageblock(zone) ||
> +		is_migrate_isolate(migratetype))) {
> +		migratetype = get_pfnblock_migratetype(page, pfn);
> +	}
> +
> +	return migratetype;
> +}
> +
>  /*
>   * Frees a number of pages from the PCP lists
>   * Assumes all pages on list are in same zone, and of same order.
> @@ -1371,7 +1388,6 @@ static void free_pcppages_bulk(struct zone *zone, int count,
>  	int migratetype = 0;
>  	int batch_free = 0;
>  	int prefetch_nr = READ_ONCE(pcp->batch);
> -	bool isolated_pageblocks;
>  	struct page *page, *tmp;
>  	LIST_HEAD(head);
>  
> @@ -1433,21 +1449,20 @@ static void free_pcppages_bulk(struct zone *zone, int count,
>  	 * both PREEMPT_RT and non-PREEMPT_RT configurations.
>  	 */
>  	spin_lock(&zone->lock);
> -	isolated_pageblocks = has_isolate_pageblock(zone);
>  
>  	/*
>  	 * Use safe version since after __free_one_page(),
>  	 * page->lru.next will not point to original list.
>  	 */
>  	list_for_each_entry_safe(page, tmp, &head, lru) {
> +		unsigned long pfn = page_to_pfn(page);
>  		int mt = get_pcppage_migratetype(page);
> +
>  		/* MIGRATE_ISOLATE page should not go to pcplists */
>  		VM_BUG_ON_PAGE(is_migrate_isolate(mt), page);
> -		/* Pageblock could have been isolated meanwhile */
> -		if (unlikely(isolated_pageblocks))
> -			mt = get_pageblock_migratetype(page);
>  
> -		__free_one_page(page, page_to_pfn(page), zone, 0, mt, FPI_NONE);
> +		mt = check_migratetype_isolated(zone, page, pfn, mt);
> +		__free_one_page(page, pfn, zone, 0, mt, FPI_NONE);
>  		trace_mm_page_pcpu_drain(page, 0, mt);
>  	}
>  	spin_unlock(&zone->lock);
> @@ -1459,10 +1474,7 @@ static void free_one_page(struct zone *zone,
>  				int migratetype, fpi_t fpi_flags)
>  {
>  	spin_lock(&zone->lock);
> -	if (unlikely(has_isolate_pageblock(zone) ||
> -		is_migrate_isolate(migratetype))) {
> -		migratetype = get_pfnblock_migratetype(page, pfn);
> -	}
> +	migratetype = check_migratetype_isolated(zone, page, pfn, migratetype);
>  	__free_one_page(page, pfn, zone, order, migratetype, fpi_flags);
>  	spin_unlock(&zone->lock);
>  }
> 

