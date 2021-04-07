Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 440BEC433ED
	for <linux-rt-users@archiver.kernel.org>; Wed,  7 Apr 2021 20:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 229B4611C1
	for <linux-rt-users@archiver.kernel.org>; Wed,  7 Apr 2021 20:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356185AbhDGUZ7 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 7 Apr 2021 16:25:59 -0400
Received: from outbound-smtp15.blacknight.com ([46.22.139.232]:40155 "EHLO
        outbound-smtp15.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1356184AbhDGUZU (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 7 Apr 2021 16:25:20 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp15.blacknight.com (Postfix) with ESMTPS id 2A71F1C40D1
        for <linux-rt-users@vger.kernel.org>; Wed,  7 Apr 2021 21:25:06 +0100 (IST)
Received: (qmail 15188 invoked from network); 7 Apr 2021 20:25:06 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPA; 7 Apr 2021 20:25:05 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Linux-MM <linux-mm@kvack.org>,
        Linux-RT-Users <linux-rt-users@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 03/11] mm/memory_hotplug: Make unpopulated zones PCP structures unreachable during hot remove
Date:   Wed,  7 Apr 2021 21:24:15 +0100
Message-Id: <20210407202423.16022-4-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210407202423.16022-1-mgorman@techsingularity.net>
References: <20210407202423.16022-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

zone_pcp_reset allegedly protects against a race with drain_pages
using local_irq_save but this is bogus. local_irq_save only operates
on the local CPU. If memory hotplug is running on CPU A and drain_pages
is running on CPU B, disabling IRQs on CPU A does not affect CPU B and
offers no protection.

This patch reorders memory hotremove such that the PCP structures
relevant to the zone are no longer reachable by the time the structures
are freed.  With this reordering, no protection is required to prevent
a use-after-free and the IRQs can be left enabled. zone_pcp_reset is
renamed to zone_pcp_destroy to make it clear that the per-cpu structures
are deleted when the function returns.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/internal.h       |  2 +-
 mm/memory_hotplug.c | 10 +++++++---
 mm/page_alloc.c     | 22 ++++++++++++++++------
 3 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 09adf152a10b..cc34ce4461b7 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -203,7 +203,7 @@ extern void free_unref_page(struct page *page);
 extern void free_unref_page_list(struct list_head *list);
 
 extern void zone_pcp_update(struct zone *zone);
-extern void zone_pcp_reset(struct zone *zone);
+extern void zone_pcp_destroy(struct zone *zone);
 extern void zone_pcp_disable(struct zone *zone);
 extern void zone_pcp_enable(struct zone *zone);
 
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 0cdbbfbc5757..3d059c9f9c2d 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1687,12 +1687,16 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
 	zone->nr_isolate_pageblock -= nr_pages / pageblock_nr_pages;
 	spin_unlock_irqrestore(&zone->lock, flags);
 
-	zone_pcp_enable(zone);
-
 	/* removal success */
 	adjust_managed_page_count(pfn_to_page(start_pfn), -nr_pages);
 	zone->present_pages -= nr_pages;
 
+	/*
+	 * Restore PCP after managed pages has been updated. Unpopulated
+	 * zones PCP structures will remain unusable.
+	 */
+	zone_pcp_enable(zone);
+
 	pgdat_resize_lock(zone->zone_pgdat, &flags);
 	zone->zone_pgdat->node_present_pages -= nr_pages;
 	pgdat_resize_unlock(zone->zone_pgdat, &flags);
@@ -1700,8 +1704,8 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
 	init_per_zone_wmark_min();
 
 	if (!populated_zone(zone)) {
-		zone_pcp_reset(zone);
 		build_all_zonelists(NULL);
+		zone_pcp_destroy(zone);
 	} else
 		zone_pcp_update(zone);
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e9e60d1a85d4..a8630003612b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8972,18 +8972,29 @@ void zone_pcp_disable(struct zone *zone)
 
 void zone_pcp_enable(struct zone *zone)
 {
-	__zone_set_pageset_high_and_batch(zone, zone->pageset_high, zone->pageset_batch);
+	/*
+	 * If the zone is populated, restore the high and batch counts.
+	 * If unpopulated, leave the high and batch count as 0 and 1
+	 * respectively as done by zone_pcp_disable. The per-cpu
+	 * structures will later be freed by zone_pcp_destroy.
+	 */
+	if (populated_zone(zone))
+		__zone_set_pageset_high_and_batch(zone, zone->pageset_high, zone->pageset_batch);
+
 	mutex_unlock(&pcp_batch_high_lock);
 }
 
-void zone_pcp_reset(struct zone *zone)
+/*
+ * Called when a zone has been hot-removed. At this point, the PCP has been
+ * drained, disabled and the zone is removed from the zonelists so the
+ * structures are no longer in use. PCP was disabled/drained by
+ * zone_pcp_disable. This function will drain any remaining vmstat deltas.
+ */
+void zone_pcp_destroy(struct zone *zone)
 {
-	unsigned long flags;
 	int cpu;
 	struct per_cpu_zonestat *pzstats;
 
-	/* avoid races with drain_pages()  */
-	local_irq_save(flags);
 	if (zone->per_cpu_pageset != &boot_pageset) {
 		for_each_online_cpu(cpu) {
 			pzstats = per_cpu_ptr(zone->per_cpu_zonestats, cpu);
@@ -8994,7 +9005,6 @@ void zone_pcp_reset(struct zone *zone)
 		zone->per_cpu_pageset = &boot_pageset;
 		zone->per_cpu_zonestats = &boot_zonestats;
 	}
-	local_irq_restore(flags);
 }
 
 #ifdef CONFIG_MEMORY_HOTREMOVE
-- 
2.26.2

