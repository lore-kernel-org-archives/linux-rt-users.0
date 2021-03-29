Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0397CC433E0
	for <linux-rt-users@archiver.kernel.org>; Mon, 29 Mar 2021 12:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFDF36192F
	for <linux-rt-users@archiver.kernel.org>; Mon, 29 Mar 2021 12:17:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbhC2MRU (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 29 Mar 2021 08:17:20 -0400
Received: from outbound-smtp07.blacknight.com ([46.22.139.12]:41769 "EHLO
        outbound-smtp07.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230098AbhC2MRD (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 29 Mar 2021 08:17:03 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp07.blacknight.com (Postfix) with ESMTPS id 8FDD51C34CC
        for <linux-rt-users@vger.kernel.org>; Mon, 29 Mar 2021 13:07:19 +0100 (IST)
Received: (qmail 18342 invoked from network); 29 Mar 2021 12:07:19 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPA; 29 Mar 2021 12:07:19 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Linux-MM <linux-mm@kvack.org>
Cc:     Linux-RT-Users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 2/6] mm/page_alloc: Convert per-cpu list protection to local_lock
Date:   Mon, 29 Mar 2021 13:06:44 +0100
Message-Id: <20210329120648.19040-3-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210329120648.19040-1-mgorman@techsingularity.net>
References: <20210329120648.19040-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

There is a lack of clarity of what exactly local_irq_save/local_irq_restore
protects in page_alloc.c . It conflates the protection of per-cpu page
allocation structures with per-cpu vmstat deltas.

This patch protects the PCP structure using local_lock which
for most configurations is identical to IRQ enabling/disabling.
The scope of the lock is still wider than it should be but this is
decreased in later patches. The per-cpu vmstat deltas are protected by
preempt_disable/preempt_enable where necessary instead of relying on
IRQ disable/enable.

[lkp@intel.com: Make pagesets static]
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 include/linux/mmzone.h |  2 ++
 mm/page_alloc.c        | 43 ++++++++++++++++++++++++------------------
 mm/vmstat.c            |  4 ++++
 3 files changed, 31 insertions(+), 18 deletions(-)

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
index 32006e66564a..7f8c73020688 100644
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
@@ -2962,12 +2969,12 @@ void drain_zone_pages(struct zone *zone, struct per_cpu_pages *pcp)
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
 
@@ -2983,13 +2990,13 @@ static void drain_pages_zone(unsigned int cpu, struct zone *zone)
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
@@ -3252,9 +3259,9 @@ void free_unref_page(struct page *page)
 	if (!free_unref_page_prepare(page, pfn))
 		return;
 
-	local_irq_save(flags);
+	local_lock_irqsave(&pagesets.lock, flags);
 	free_unref_page_commit(page, pfn);
-	local_irq_restore(flags);
+	local_unlock_irqrestore(&pagesets.lock, flags);
 }
 
 /*
@@ -3274,7 +3281,7 @@ void free_unref_page_list(struct list_head *list)
 		set_page_private(page, pfn);
 	}
 
-	local_irq_save(flags);
+	local_lock_irqsave(&pagesets.lock, flags);
 	list_for_each_entry_safe(page, next, list, lru) {
 		unsigned long pfn = page_private(page);
 
@@ -3287,12 +3294,12 @@ void free_unref_page_list(struct list_head *list)
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
@@ -3449,7 +3456,7 @@ static struct page *rmqueue_pcplist(struct zone *preferred_zone,
 	struct page *page;
 	unsigned long flags;
 
-	local_irq_save(flags);
+	local_lock_irqsave(&pagesets.lock, flags);
 	pcp = this_cpu_ptr(zone->per_cpu_pageset);
 	list = &pcp->lists[migratetype];
 	page = __rmqueue_pcplist(zone,  migratetype, alloc_flags, pcp, list);
@@ -3457,7 +3464,7 @@ static struct page *rmqueue_pcplist(struct zone *preferred_zone,
 		__count_zid_vm_events(PGALLOC, page_zonenum(page), 1);
 		zone_statistics(preferred_zone, zone);
 	}
-	local_irq_restore(flags);
+	local_unlock_irqrestore(&pagesets.lock, flags);
 	return page;
 }
 
@@ -5052,7 +5059,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 		goto failed;
 
 	/* Attempt the batch allocation */
-	local_irq_save(flags);
+	local_lock_irqsave(&pagesets.lock, flags);
 	pcp = this_cpu_ptr(zone->per_cpu_pageset);
 	pcp_list = &pcp->lists[ac.migratetype];
 
@@ -5090,7 +5097,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 		nr_populated++;
 	}
 
-	local_irq_restore(flags);
+	local_unlock_irqrestore(&pagesets.lock, flags);
 
 	return nr_populated;
 
@@ -8958,12 +8965,13 @@ void zone_pcp_enable(struct zone *zone)
 
 void zone_pcp_reset(struct zone *zone)
 {
-	unsigned long flags;
 	int cpu;
 	struct per_cpu_zonestat *pzstats;
 
-	/* avoid races with drain_pages()  */
-	local_irq_save(flags);
+	/*
+	 * No race with drain_pages. drain_zonestat disables preemption
+	 * and drain_pages relies on the pcp local_lock.
+	 */
 	if (zone->per_cpu_pageset != &boot_pageset) {
 		for_each_online_cpu(cpu) {
 			pzstats = per_cpu_ptr(zone->per_cpu_zonestats, cpu);
@@ -8974,7 +8982,6 @@ void zone_pcp_reset(struct zone *zone)
 		zone->per_cpu_pageset = &boot_pageset;
 		zone->per_cpu_zonestats = &boot_zonestats;
 	}
-	local_irq_restore(flags);
 }
 
 #ifdef CONFIG_MEMORY_HOTREMOVE
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 8a8f1a26b231..01b74ff73549 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -887,6 +887,7 @@ void cpu_vm_stats_fold(int cpu)
 
 		pzstats = per_cpu_ptr(zone->per_cpu_zonestats, cpu);
 
+		preempt_disable();
 		for (i = 0; i < NR_VM_ZONE_STAT_ITEMS; i++)
 			if (pzstats->vm_stat_diff[i]) {
 				int v;
@@ -908,6 +909,7 @@ void cpu_vm_stats_fold(int cpu)
 				global_numa_diff[i] += v;
 			}
 #endif
+		preempt_enable();
 	}
 
 	for_each_online_pgdat(pgdat) {
@@ -941,6 +943,7 @@ void drain_zonestat(struct zone *zone, struct per_cpu_zonestat *pzstats)
 {
 	int i;
 
+	preempt_disable();
 	for (i = 0; i < NR_VM_ZONE_STAT_ITEMS; i++)
 		if (pzstats->vm_stat_diff[i]) {
 			int v = pzstats->vm_stat_diff[i];
@@ -959,6 +962,7 @@ void drain_zonestat(struct zone *zone, struct per_cpu_zonestat *pzstats)
 			atomic_long_add(v, &vm_numa_stat[i]);
 		}
 #endif
+	preempt_enable();
 }
 #endif
 
-- 
2.26.2

