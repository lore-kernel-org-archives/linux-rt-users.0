Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D628C433B4
	for <linux-rt-users@archiver.kernel.org>; Tue, 13 Apr 2021 16:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3911613B8
	for <linux-rt-users@archiver.kernel.org>; Tue, 13 Apr 2021 16:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346917AbhDMQwZ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 13 Apr 2021 12:52:25 -0400
Received: from outbound-smtp18.blacknight.com ([46.22.139.245]:45083 "EHLO
        outbound-smtp18.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346910AbhDMQwZ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 13 Apr 2021 12:52:25 -0400
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp18.blacknight.com (Postfix) with ESMTPS id 67E761C450E
        for <linux-rt-users@vger.kernel.org>; Tue, 13 Apr 2021 17:52:04 +0100 (IST)
Received: (qmail 21149 invoked from network); 13 Apr 2021 16:52:04 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 13 Apr 2021 16:52:04 -0000
Date:   Tue, 13 Apr 2021 17:52:02 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux-RT-Users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH 02/11] mm/page_alloc: Convert per-cpu list protection to
 local_lock
Message-ID: <20210413165201.GE3697@techsingularity.net>
References: <20210407202423.16022-3-mgorman@techsingularity.net>
 <YG7gV7yAEEjOcQZY@hirez.programming.kicks-ass.net>
 <20210408174244.GG3697@techsingularity.net>
 <YG/2scd9ADdrIyCM@hirez.programming.kicks-ass.net>
 <20210409075939.GJ3697@techsingularity.net>
 <YHAPOKPTgJcLuDJl@hirez.programming.kicks-ass.net>
 <20210409133256.GN3697@techsingularity.net>
 <YHCjK8OOhmxTbKu0@hirez.programming.kicks-ass.net>
 <20210412115612.GX3697@techsingularity.net>
 <87lf9nyy3v.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <87lf9nyy3v.ffs@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, Apr 12, 2021 at 11:47:00PM +0200, Thomas Gleixner wrote:
> On Mon, Apr 12 2021 at 12:56, Mel Gorman wrote:
> > On Fri, Apr 09, 2021 at 08:55:39PM +0200, Peter Zijlstra wrote:
> > I'll update the changelog and comment accordingly. I'll decide later
> > whether to leave it or move the location of the lock at the end of the
> > series. If the patch is added, it'll either incur the double lookup (not
> > that expensive, might be optimised by the compiler) or come up with a
> > helper that takes the lock and returns the per-cpu structure. The double
> > lookup probably makes more sense initially because there are multiple
> > potential users of a helper that says "pin to CPU, lookup, lock and return
> > a per-cpu structure" for both IRQ-safe and IRQ-unsafe variants with the
> > associated expansion of the local_lock API. It might be better to introduce
> > such a helper with multiple users converted at the same time and there are
> > other local_lock users in preempt-rt that could do with upstreaming first.
> 
> We had such helpers in RT a while ago but it turned into an helper
> explosion pretty fast. But that was one of the early versions of local
> locks which could not be embedded into a per CPU data structure due to
> raisins (my stupidity).
> 
> But with the more thought out approach of today we can have (+/- the
> obligatory naming bikeshedding):
> 
> <SNIP>

I don't have strong opinions on the name -- it's long but it's clear.
The overhead of local_lock_get_cpu_ptr has similar weight to get_cpu_ptr
in terms of the cost of preempt_disable. The helper also means that new
users of a local_lock embedded within a per-cpu structure do not have to
figure out if it's safe from scratch.

If the page allocator embeds local_lock within struct per_cpu_pages then
the conversion to the helper is at the end of the mail. The messiest part
is free_unref_page_commit and that is a mess because free_unref_page_list
has to check if a new lock is required in case a list of pages is from
different zones.

> <SNIP>
>
> and RT will then change that to:
> 
> --- a/include/linux/local_lock_internal.h
> +++ b/include/linux/local_lock_internal.h
> @@ -96,7 +96,7 @@ static inline void local_lock_release(lo
>  	({							\
>  		type *__pcp;					\
>  								\
> -		preempt_disable();				\
> +		ll_preempt_disable();				\
>  		__pcp = this_cpu_ptr(pcp);			\
>  		local_lock_acquire(&__pcp->lock);		\
>  		__pcp;						\
> @@ -106,7 +106,7 @@ static inline void local_lock_release(lo
>  	({							\
>  		type *__pcp;					\
>  								\
> -		local_irq_disable();				\
> +		ll_local_irq_disable();				\
>  		__pcp = this_cpu_ptr(pcp);			\
>  		local_lock_acquire(&__pcp->lock);		\
>  		__pcp;						\
> @@ -116,7 +116,7 @@ static inline void local_lock_release(lo
>  	({							\
>  		type *__pcp;					\
>  								\
> -		local_irq_save(flags);				\
> +		ll_local_irq_save(flags);			\
>  		__pcp = this_cpu_ptr(pcp);			\
>  		local_lock_acquire(&__pcp->lock);		\
>  		__pcp;						\
> 
> 
> where ll_xxx is defined as xxx for non-RT and on RT all of them
> get mapped to migrate_disable().
> 
> Thoughts?
> 

I think that works. I created the obvious definitions of ll_* and rebased
on top of preempt-rt to see. I'll see if it boots :P

Page allocator conversion to helper looks like

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d9d7f6d68243..2948a5502589 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3008,9 +3008,7 @@ static void drain_pages_zone(unsigned int cpu, struct zone *zone)
 	unsigned long flags;
 	struct per_cpu_pages *pcp;
 
-	local_lock_irqsave(&zone->per_cpu_pageset->lock, flags);
-
-	pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
+	pcp = local_lock_irqsave_get_cpu_ptr(zone->per_cpu_pageset, lock, flags);
 	if (pcp->count)
 		free_pcppages_bulk(zone, pcp->count, pcp);
 
@@ -3235,12 +3233,10 @@ static bool free_unref_page_prepare(struct page *page, unsigned long pfn)
 }
 
 static void free_unref_page_commit(struct page *page, struct zone *zone,
-				   unsigned long pfn, int migratetype)
+				   struct per_cpu_pages *pcp, unsigned long pfn,
+				   int migratetype)
 {
-	struct per_cpu_pages *pcp;
-
 	__count_vm_event(PGFREE);
-	pcp = this_cpu_ptr(zone->per_cpu_pageset);
 	list_add(&page->lru, &pcp->lists[migratetype]);
 	pcp->count++;
 	if (pcp->count >= READ_ONCE(pcp->high))
@@ -3252,6 +3248,7 @@ static void free_unref_page_commit(struct page *page, struct zone *zone,
  */
 void free_unref_page(struct page *page)
 {
+	struct per_cpu_pages *pcp;
 	struct zone *zone;
 	unsigned long flags;
 	unsigned long pfn = page_to_pfn(page);
@@ -3277,8 +3274,8 @@ void free_unref_page(struct page *page)
 	}
 
 	zone = page_zone(page);
-	local_lock_irqsave(&zone->per_cpu_pageset->lock, flags);
-	free_unref_page_commit(page, zone, pfn, migratetype);
+	pcp = local_lock_irqsave_get_cpu_ptr(zone->per_cpu_pageset, lock, flags);
+	free_unref_page_commit(page, zone, pcp, pfn, migratetype);
 	local_unlock_irqrestore(&zone->per_cpu_pageset->lock, flags);
 }
 
@@ -3287,6 +3284,7 @@ void free_unref_page(struct page *page)
  */
 void free_unref_page_list(struct list_head *list)
 {
+	struct per_cpu_pages *pcp;
 	struct zone *locked_zone;
 	struct page *page, *next;
 	unsigned long flags, pfn;
@@ -3320,7 +3318,7 @@ void free_unref_page_list(struct list_head *list)
 	/* Acquire the lock required for the first page. */
 	page = list_first_entry(list, struct page, lru);
 	locked_zone = page_zone(page);
-	local_lock_irqsave(&locked_zone->per_cpu_pageset->lock, flags);
+	pcp = local_lock_irqsave_get_cpu_ptr(locked_zone->per_cpu_pageset, lock, flags);
 
 	list_for_each_entry_safe(page, next, list, lru) {
 		struct zone *zone = page_zone(page);
@@ -3342,12 +3340,12 @@ void free_unref_page_list(struct list_head *list)
 #if defined(CONFIG_PREEMPT_RT) || defined(CONFIG_DEBUG_LOCK_ALLOC)
 		if (locked_zone != zone) {
 			local_unlock_irqrestore(&locked_zone->per_cpu_pageset->lock, flags);
-			local_lock_irqsave(&zone->per_cpu_pageset->lock, flags);
+			pcp = local_lock_irqsave_get_cpu_ptr(zone->per_cpu_pageset, lock, flags);
 			locked_zone = zone;
 		}
 #endif
 
-		free_unref_page_commit(page, zone, pfn, migratetype);
+		free_unref_page_commit(page, zone, pcp, pfn, migratetype);
 
 		/*
 		 * Guard against excessive IRQ disabled times when we get
@@ -3517,8 +3515,7 @@ static struct page *rmqueue_pcplist(struct zone *preferred_zone,
 	struct page *page;
 	unsigned long flags;
 
-	local_lock_irqsave(&zone->per_cpu_pageset->lock, flags);
-	pcp = this_cpu_ptr(zone->per_cpu_pageset);
+	pcp = local_lock_irqsave_get_cpu_ptr(zone->per_cpu_pageset, lock, flags);
 	list = &pcp->lists[migratetype];
 	page = __rmqueue_pcplist(zone,  migratetype, alloc_flags, pcp, list);
 	local_unlock_irqrestore(&zone->per_cpu_pageset->lock, flags);



-- 
Mel Gorman
SUSE Labs
