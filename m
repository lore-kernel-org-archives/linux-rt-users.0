Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACBFC433ED
	for <linux-rt-users@archiver.kernel.org>; Fri,  9 Apr 2021 13:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E649561106
	for <linux-rt-users@archiver.kernel.org>; Fri,  9 Apr 2021 13:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbhDINdN (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 9 Apr 2021 09:33:13 -0400
Received: from outbound-smtp07.blacknight.com ([46.22.139.12]:40295 "EHLO
        outbound-smtp07.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231127AbhDINdM (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 9 Apr 2021 09:33:12 -0400
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp07.blacknight.com (Postfix) with ESMTPS id 667DC1C3F25
        for <linux-rt-users@vger.kernel.org>; Fri,  9 Apr 2021 14:32:58 +0100 (IST)
Received: (qmail 26227 invoked from network); 9 Apr 2021 13:32:58 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 9 Apr 2021 13:32:58 -0000
Date:   Fri, 9 Apr 2021 14:32:56 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Linux-RT-Users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH 02/11] mm/page_alloc: Convert per-cpu list protection to
 local_lock
Message-ID: <20210409133256.GN3697@techsingularity.net>
References: <20210407202423.16022-1-mgorman@techsingularity.net>
 <20210407202423.16022-3-mgorman@techsingularity.net>
 <YG7gV7yAEEjOcQZY@hirez.programming.kicks-ass.net>
 <20210408174244.GG3697@techsingularity.net>
 <YG/2scd9ADdrIyCM@hirez.programming.kicks-ass.net>
 <20210409075939.GJ3697@techsingularity.net>
 <YHAPOKPTgJcLuDJl@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <YHAPOKPTgJcLuDJl@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, Apr 09, 2021 at 10:24:24AM +0200, Peter Zijlstra wrote:
> On Fri, Apr 09, 2021 at 08:59:39AM +0100, Mel Gorman wrote:
> > In the end I just gave up and kept it simple as there is no benefit to
> > !PREEMPT_RT which just disables IRQs. Maybe it'll be worth considering when
> > PREEMPT_RT is upstream and can be enabled. The series was functionally
> > tested on the PREEMPT_RT tree by reverting the page_alloc.c patch and
> > applies this series and all of its prerequisites on top.
> 
> Right, I see the problem. Fair enough; perhaps ammend the changelog to
> include some of that so that we can 'remember' in a few months why the
> code is 'funneh'.
> 

I updated the changelog and also added a comment above the
declaration. That said, there are some curious users already.
fs/squashfs/decompressor_multi_percpu.c looks like it always uses the
local_lock in CPU 0's per-cpu structure instead of stabilising a per-cpu
pointer. drivers/block/zram/zcomp.c appears to do the same although for
at least one of the zcomp_stream_get() callers, the CPU is pinned for
other reasons (bit spin lock held). I think it happens to work anyway
but it's weird and I'm not a fan.

Anyway, new version looks like is below.

-- 
[PATCH] mm/page_alloc: Convert per-cpu list protection to local_lock

There is a lack of clarity of what exactly local_irq_save/local_irq_restore
protects in page_alloc.c . It conflates the protection of per-cpu page
allocation structures with per-cpu vmstat deltas.

This patch protects the PCP structure using local_lock which for most
configurations is identical to IRQ enabling/disabling.  The scope of the
lock is still wider than it should be but this is decreased later.

local_lock is declared statically instead of placing it within a structure
and this is deliberate. Placing it in the zone offers limited benefit and
confuses what the lock is protecting -- struct per_cpu_pages. However,
putting it in per_cpu_pages is problematic because the task is not guaranteed
to be pinned to the CPU yet so looking up a per-cpu structure is unsafe.

[lkp@intel.com: Make pagesets static]
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 include/linux/mmzone.h |  2 ++
 mm/page_alloc.c        | 67 +++++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 54 insertions(+), 15 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index a4393ac27336..106da8fbc72a 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -20,6 +20,7 @@
 #include <linux/atomic.h>
 #include <linux/mm_types.h>
 #include <linux/page-flags.h>
+#include <linux/local_lock.h>
 #include <asm/page.h>
 
 /* Free memory management - zoned buddy allocator.  */
@@ -337,6 +338,7 @@ enum zone_watermarks {
 #define high_wmark_pages(z) (z->_watermark[WMARK_HIGH] + z->watermark_boost)
 #define wmark_pages(z, i) (z->_watermark[i] + z->watermark_boost)
 
+/* Fields and list protected by pagesets local_lock in page_alloc.c */
 struct per_cpu_pages {
 	int count;		/* number of pages in the list */
 	int high;		/* high watermark, emptying needed */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3bc4da4cbf9c..04644c3dd187 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -112,6 +112,30 @@ typedef int __bitwise fpi_t;
 static DEFINE_MUTEX(pcp_batch_high_lock);
 #define MIN_PERCPU_PAGELIST_FRACTION	(8)
 
+/*
+ * Protects the per_cpu_pages structures.
+ *
+ * This lock is not placed in struct per_cpu_pages because the task acquiring
+ * the lock is not guaranteed to be pinned to the CPU yet due to
+ * preempt/migrate/IRQs disabled or holding a spinlock. The pattern to acquire
+ * the lock would become
+ *
+ *   migrate_disable();
+ *   pcp = this_cpu_ptr(zone->per_cpu_pageset);
+ *   local_lock_irqsave(&pcp->lock, flags);
+ *
+ * While a helper would avoid code duplication, there is no inherent advantage
+ * and migrate_disable itself is undesirable (see include/linux/preempt.h).
+ * Similarly, putting the lock in the zone offers no particular benefit but
+ * confuses what the lock is protecting.
+ */
+struct pagesets {
+	local_lock_t lock;
+};
+static DEFINE_PER_CPU(struct pagesets, pagesets) = {
+	.lock = INIT_LOCAL_LOCK(lock),
+};
+
 #ifdef CONFIG_USE_PERCPU_NUMA_NODE_ID
 DEFINE_PER_CPU(int, numa_node);
 EXPORT_PER_CPU_SYMBOL(numa_node);
@@ -1421,6 +1445,10 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 		} while (--count && --batch_free && !list_empty(list));
 	}
 
+	/*
+	 * local_lock_irq held so equivalent to spin_lock_irqsave for
+	 * both PREEMPT_RT and non-PREEMPT_RT configurations.
+	 */
 	spin_lock(&zone->lock);
 	isolated_pageblocks = has_isolate_pageblock(zone);
 
@@ -1541,6 +1569,11 @@ static void __free_pages_ok(struct page *page, unsigned int order,
 		return;
 
 	migratetype = get_pfnblock_migratetype(page, pfn);
+
+	/*
+	 * TODO FIX: Disable IRQs before acquiring IRQ-safe zone->lock
+	 * and protect vmstat updates.
+	 */
 	local_irq_save(flags);
 	__count_vm_events(PGFREE, 1 << order);
 	free_one_page(page_zone(page), page, pfn, order, migratetype,
@@ -2910,6 +2943,10 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
 {
 	int i, allocated = 0;
 
+	/*
+	 * local_lock_irq held so equivalent to spin_lock_irqsave for
+	 * both PREEMPT_RT and non-PREEMPT_RT configurations.
+	 */
 	spin_lock(&zone->lock);
 	for (i = 0; i < count; ++i) {
 		struct page *page = __rmqueue(zone, order, migratetype,
@@ -2962,12 +2999,12 @@ void drain_zone_pages(struct zone *zone, struct per_cpu_pages *pcp)
 	unsigned long flags;
 	int to_drain, batch;
 
-	local_irq_save(flags);
+	local_lock_irqsave(&pagesets.lock, flags);
 	batch = READ_ONCE(pcp->batch);
 	to_drain = min(pcp->count, batch);
 	if (to_drain > 0)
 		free_pcppages_bulk(zone, to_drain, pcp);
-	local_irq_restore(flags);
+	local_unlock_irqrestore(&pagesets.lock, flags);
 }
 #endif
 
@@ -2983,13 +3020,13 @@ static void drain_pages_zone(unsigned int cpu, struct zone *zone)
 	unsigned long flags;
 	struct per_cpu_pages *pcp;
 
-	local_irq_save(flags);
+	local_lock_irqsave(&pagesets.lock, flags);
 
 	pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
 	if (pcp->count)
 		free_pcppages_bulk(zone, pcp->count, pcp);
 
-	local_irq_restore(flags);
+	local_unlock_irqrestore(&pagesets.lock, flags);
 }
 
 /*
@@ -3252,9 +3289,9 @@ void free_unref_page(struct page *page)
 	if (!free_unref_page_prepare(page, pfn))
 		return;
 
-	local_irq_save(flags);
+	local_lock_irqsave(&pagesets.lock, flags);
 	free_unref_page_commit(page, pfn);
-	local_irq_restore(flags);
+	local_unlock_irqrestore(&pagesets.lock, flags);
 }
 
 /*
@@ -3274,7 +3311,7 @@ void free_unref_page_list(struct list_head *list)
 		set_page_private(page, pfn);
 	}
 
-	local_irq_save(flags);
+	local_lock_irqsave(&pagesets.lock, flags);
 	list_for_each_entry_safe(page, next, list, lru) {
 		unsigned long pfn = page_private(page);
 
@@ -3287,12 +3324,12 @@ void free_unref_page_list(struct list_head *list)
 		 * a large list of pages to free.
 		 */
 		if (++batch_count == SWAP_CLUSTER_MAX) {
-			local_irq_restore(flags);
+			local_unlock_irqrestore(&pagesets.lock, flags);
 			batch_count = 0;
-			local_irq_save(flags);
+			local_lock_irqsave(&pagesets.lock, flags);
 		}
 	}
-	local_irq_restore(flags);
+	local_unlock_irqrestore(&pagesets.lock, flags);
 }
 
 /*
@@ -3449,7 +3486,7 @@ static struct page *rmqueue_pcplist(struct zone *preferred_zone,
 	struct page *page;
 	unsigned long flags;
 
-	local_irq_save(flags);
+	local_lock_irqsave(&pagesets.lock, flags);
 	pcp = this_cpu_ptr(zone->per_cpu_pageset);
 	list = &pcp->lists[migratetype];
 	page = __rmqueue_pcplist(zone,  migratetype, alloc_flags, pcp, list);
@@ -3457,7 +3494,7 @@ static struct page *rmqueue_pcplist(struct zone *preferred_zone,
 		__count_zid_vm_events(PGALLOC, page_zonenum(page), 1);
 		zone_statistics(preferred_zone, zone);
 	}
-	local_irq_restore(flags);
+	local_unlock_irqrestore(&pagesets.lock, flags);
 	return page;
 }
 
@@ -5052,7 +5089,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 		goto failed;
 
 	/* Attempt the batch allocation */
-	local_irq_save(flags);
+	local_lock_irqsave(&pagesets.lock, flags);
 	pcp = this_cpu_ptr(zone->per_cpu_pageset);
 	pcp_list = &pcp->lists[ac.migratetype];
 
@@ -5090,12 +5127,12 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 		nr_populated++;
 	}
 
-	local_irq_restore(flags);
+	local_unlock_irqrestore(&pagesets.lock, flags);
 
 	return nr_populated;
 
 failed_irq:
-	local_irq_restore(flags);
+	local_unlock_irqrestore(&pagesets.lock, flags);
 
 failed:
 	page = __alloc_pages(gfp, 0, preferred_nid, nodemask);
