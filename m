Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CCA2C433B4
	for <linux-rt-users@archiver.kernel.org>; Wed, 14 Apr 2021 13:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CC97611AD
	for <linux-rt-users@archiver.kernel.org>; Wed, 14 Apr 2021 13:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351473AbhDNNkd (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 14 Apr 2021 09:40:33 -0400
Received: from outbound-smtp46.blacknight.com ([46.22.136.58]:32939 "EHLO
        outbound-smtp46.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351453AbhDNNkZ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 14 Apr 2021 09:40:25 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp46.blacknight.com (Postfix) with ESMTPS id 0190123600C
        for <linux-rt-users@vger.kernel.org>; Wed, 14 Apr 2021 14:40:03 +0100 (IST)
Received: (qmail 28465 invoked from network); 14 Apr 2021 13:40:02 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPA; 14 Apr 2021 13:40:02 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Linux-MM <linux-mm@kvack.org>,
        Linux-RT-Users <linux-rt-users@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 02/11] mm/page_alloc: Convert per-cpu list protection to local_lock
Date:   Wed, 14 Apr 2021 14:39:22 +0100
Message-Id: <20210414133931.4555-3-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210414133931.4555-1-mgorman@techsingularity.net>
References: <20210414133931.4555-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

There is a lack of clarity of what exactly local_irq_save/local_irq_restore
protects in page_alloc.c . It conflates the protection of per-cpu page
allocation structures with per-cpu vmstat deltas.

This patch protects the PCP structure using local_lock which for most
configurations is identical to IRQ enabling/disabling. The scope of the
lock is still wider than it should be but this is decreased later.

It is possible for the local_lock to be embedded safely within struct
per_cpu_pages but it adds complexity to free_unref_page_list so it is
implemented as a separate patch later in the series.

[lkp@intel.com: Make pagesets static]
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 include/linux/mmzone.h |  2 ++
 mm/page_alloc.c        | 50 +++++++++++++++++++++++++++++-------------
 2 files changed, 37 insertions(+), 15 deletions(-)

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
index 2d6283cab22d..4e92d43c25f6 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -112,6 +112,13 @@ typedef int __bitwise fpi_t;
 static DEFINE_MUTEX(pcp_batch_high_lock);
 #define MIN_PERCPU_PAGELIST_FRACTION	(8)
 
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
@@ -1421,6 +1428,10 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 		} while (--count && --batch_free && !list_empty(list));
 	}
 
+	/*
+	 * local_lock_irq held so equivalent to spin_lock_irqsave for
+	 * both PREEMPT_RT and non-PREEMPT_RT configurations.
+	 */
 	spin_lock(&zone->lock);
 	isolated_pageblocks = has_isolate_pageblock(zone);
 
@@ -1541,6 +1552,11 @@ static void __free_pages_ok(struct page *page, unsigned int order,
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
@@ -2910,6 +2926,10 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
 {
 	int i, allocated = 0;
 
+	/*
+	 * local_lock_irq held so equivalent to spin_lock_irqsave for
+	 * both PREEMPT_RT and non-PREEMPT_RT configurations.
+	 */
 	spin_lock(&zone->lock);
 	for (i = 0; i < count; ++i) {
 		struct page *page = __rmqueue(zone, order, migratetype,
@@ -2962,12 +2982,12 @@ void drain_zone_pages(struct zone *zone, struct per_cpu_pages *pcp)
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
 
@@ -2983,13 +3003,13 @@ static void drain_pages_zone(unsigned int cpu, struct zone *zone)
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
@@ -3252,9 +3272,9 @@ void free_unref_page(struct page *page)
 	if (!free_unref_page_prepare(page, pfn))
 		return;
 
-	local_irq_save(flags);
+	local_lock_irqsave(&pagesets.lock, flags);
 	free_unref_page_commit(page, pfn);
-	local_irq_restore(flags);
+	local_unlock_irqrestore(&pagesets.lock, flags);
 }
 
 /*
@@ -3274,7 +3294,7 @@ void free_unref_page_list(struct list_head *list)
 		set_page_private(page, pfn);
 	}
 
-	local_irq_save(flags);
+	local_lock_irqsave(&pagesets.lock, flags);
 	list_for_each_entry_safe(page, next, list, lru) {
 		unsigned long pfn = page_private(page);
 
@@ -3287,12 +3307,12 @@ void free_unref_page_list(struct list_head *list)
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
@@ -3449,7 +3469,7 @@ static struct page *rmqueue_pcplist(struct zone *preferred_zone,
 	struct page *page;
 	unsigned long flags;
 
-	local_irq_save(flags);
+	local_lock_irqsave(&pagesets.lock, flags);
 	pcp = this_cpu_ptr(zone->per_cpu_pageset);
 	list = &pcp->lists[migratetype];
 	page = __rmqueue_pcplist(zone,  migratetype, alloc_flags, pcp, list);
@@ -3457,7 +3477,7 @@ static struct page *rmqueue_pcplist(struct zone *preferred_zone,
 		__count_zid_vm_events(PGALLOC, page_zonenum(page), 1);
 		zone_statistics(preferred_zone, zone);
 	}
-	local_irq_restore(flags);
+	local_unlock_irqrestore(&pagesets.lock, flags);
 	return page;
 }
 
@@ -5052,7 +5072,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 		goto failed;
 
 	/* Attempt the batch allocation */
-	local_irq_save(flags);
+	local_lock_irqsave(&pagesets.lock, flags);
 	pcp = this_cpu_ptr(zone->per_cpu_pageset);
 	pcp_list = &pcp->lists[ac.migratetype];
 
@@ -5090,12 +5110,12 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
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
-- 
2.26.2

