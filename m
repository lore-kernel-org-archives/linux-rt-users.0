Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBAE1C433ED
	for <linux-rt-users@archiver.kernel.org>; Thu, 15 Apr 2021 12:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B3FF613B0
	for <linux-rt-users@archiver.kernel.org>; Thu, 15 Apr 2021 12:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbhDOM0E (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 15 Apr 2021 08:26:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:49452 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232812AbhDOM0C (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 15 Apr 2021 08:26:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 74D5BAE56;
        Thu, 15 Apr 2021 12:25:37 +0000 (UTC)
Subject: Re: [PATCH 09/11] mm/page_alloc: Avoid conflating IRQs disabled with
 zone->lock
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
 <20210414133931.4555-10-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <838c6734-1e5d-6a26-8c88-90e89d407482@suse.cz>
Date:   Thu, 15 Apr 2021 14:25:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210414133931.4555-10-mgorman@techsingularity.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 4/14/21 3:39 PM, Mel Gorman wrote:
> Historically when freeing pages, free_one_page() assumed that callers
> had IRQs disabled and the zone->lock could be acquired with spin_lock().
> This confuses the scope of what local_lock_irq is protecting and what
> zone->lock is protecting in free_unref_page_list in particular.
> 
> This patch uses spin_lock_irqsave() for the zone->lock in
> free_one_page() instead of relying on callers to have disabled
> IRQs. free_unref_page_commit() is changed to only deal with PCP pages
> protected by the local lock. free_unref_page_list() then first frees
> isolated pages to the buddy lists with free_one_page() and frees the rest
> of the pages to the PCP via free_unref_page_commit(). The end result
> is that free_one_page() is no longer depending on side-effects of
> local_lock to be correct.
> 
> Note that this may incur a performance penalty while memory hot-remove
> is running but that is not a common operation.
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

A nit below:

> @@ -3294,6 +3295,7 @@ void free_unref_page_list(struct list_head *list)
>  	struct page *page, *next;
>  	unsigned long flags, pfn;
>  	int batch_count = 0;
> +	int migratetype;
>  
>  	/* Prepare pages for freeing */
>  	list_for_each_entry_safe(page, next, list, lru) {
> @@ -3301,15 +3303,28 @@ void free_unref_page_list(struct list_head *list)
>  		if (!free_unref_page_prepare(page, pfn))
>  			list_del(&page->lru);
>  		set_page_private(page, pfn);

Should probably move this below so we don't set private for pages that then go
through free_one_page()? Doesn't seem to be a bug, just unneccessary.

> +
> +		/*
> +		 * Free isolated pages directly to the allocator, see
> +		 * comment in free_unref_page.
> +		 */
> +		migratetype = get_pcppage_migratetype(page);
> +		if (unlikely(migratetype >= MIGRATE_PCPTYPES)) {
> +			if (unlikely(is_migrate_isolate(migratetype))) {
> +				free_one_page(page_zone(page), page, pfn, 0,
> +							migratetype, FPI_NONE);
> +				list_del(&page->lru);
> +			}
> +		}
>  	}
>  
>  	local_lock_irqsave(&pagesets.lock, flags);
>  	list_for_each_entry_safe(page, next, list, lru) {
> -		unsigned long pfn = page_private(page);
> -
> +		pfn = page_private(page);
>  		set_page_private(page, 0);
> +		migratetype = get_pcppage_migratetype(page);
>  		trace_mm_page_free_batched(page);
> -		free_unref_page_commit(page, pfn);
> +		free_unref_page_commit(page, pfn, migratetype);
>  
>  		/*
>  		 * Guard against excessive IRQ disabled times when we get
> 

