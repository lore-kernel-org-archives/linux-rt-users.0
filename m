Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F10C43460
	for <linux-rt-users@archiver.kernel.org>; Wed,  7 Apr 2021 20:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45856611EE
	for <linux-rt-users@archiver.kernel.org>; Wed,  7 Apr 2021 20:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356321AbhDGU1J (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 7 Apr 2021 16:27:09 -0400
Received: from outbound-smtp31.blacknight.com ([81.17.249.62]:46992 "EHLO
        outbound-smtp31.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1356127AbhDGU0a (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 7 Apr 2021 16:26:30 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp31.blacknight.com (Postfix) with ESMTPS id CD24DC0D7B
        for <linux-rt-users@vger.kernel.org>; Wed,  7 Apr 2021 21:26:17 +0100 (IST)
Received: (qmail 18464 invoked from network); 7 Apr 2021 20:26:17 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPA; 7 Apr 2021 20:26:17 -0000
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
Subject: [PATCH 10/11] mm/page_alloc: Avoid conflating IRQs disabled with zone->lock
Date:   Wed,  7 Apr 2021 21:24:22 +0100
Message-Id: <20210407202423.16022-11-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210407202423.16022-1-mgorman@techsingularity.net>
References: <20210407202423.16022-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Historically when freeing pages, free_one_page() assumed that callers
had IRQs disabled and the zone->lock could be acquired with spin_lock().
This confuses the scope of what local_lock_irq is protecting and what
zone->lock is protecting in free_unref_page_list in particular.

This patch uses spin_lock_irqsave() for the zone->lock in
free_one_page() instead of relying on callers to have disabled
IRQs. free_unref_page_commit() is changed to only deal with PCP pages
protected by the local lock. free_unref_page_list() then first frees
isolated pages to the buddy lists with free_one_page() and frees the rest
of the pages to the PCP via free_unref_page_commit(). The end result
is that free_one_page() is no longer depending on side-effects of
local_lock to be correct.

Note that this may incur a performance penalty while memory hot-remove
is running but that is not a common operation.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/page_alloc.c | 67 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 41 insertions(+), 26 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d94ec53367bd..6d98d97b6cf5 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1473,10 +1473,12 @@ static void free_one_page(struct zone *zone,
 				unsigned int order,
 				int migratetype, fpi_t fpi_flags)
 {
-	spin_lock(&zone->lock);
+	unsigned long flags;
+
+	spin_lock_irqsave(&zone->lock, flags);
 	migratetype = check_migratetype_isolated(zone, page, pfn, migratetype);
 	__free_one_page(page, pfn, zone, order, migratetype, fpi_flags);
-	spin_unlock(&zone->lock);
+	spin_unlock_irqrestore(&zone->lock, flags);
 }
 
 static void __meminit __init_single_page(struct page *page, unsigned long pfn,
@@ -3238,31 +3240,13 @@ static bool free_unref_page_prepare(struct page *page, unsigned long pfn)
 	return true;
 }
 
-static void free_unref_page_commit(struct page *page, unsigned long pfn)
+static void free_unref_page_commit(struct page *page, unsigned long pfn,
+				   int migratetype)
 {
 	struct zone *zone = page_zone(page);
 	struct per_cpu_pages *pcp;
-	int migratetype;
 
-	migratetype = get_pcppage_migratetype(page);
 	__count_vm_event(PGFREE);
-
-	/*
-	 * We only track unmovable, reclaimable and movable on pcp lists.
-	 * Free ISOLATE pages back to the allocator because they are being
-	 * offlined but treat HIGHATOMIC as movable pages so we can get those
-	 * areas back if necessary. Otherwise, we may have to free
-	 * excessively into the page allocator
-	 */
-	if (migratetype >= MIGRATE_PCPTYPES) {
-		if (unlikely(is_migrate_isolate(migratetype))) {
-			free_one_page(zone, page, pfn, 0, migratetype,
-				      FPI_NONE);
-			return;
-		}
-		migratetype = MIGRATE_MOVABLE;
-	}
-
 	pcp = this_cpu_ptr(zone->per_cpu_pageset);
 	list_add(&page->lru, &pcp->lists[migratetype]);
 	pcp->count++;
@@ -3277,12 +3261,29 @@ void free_unref_page(struct page *page)
 {
 	unsigned long flags;
 	unsigned long pfn = page_to_pfn(page);
+	int migratetype;
 
 	if (!free_unref_page_prepare(page, pfn))
 		return;
 
+	/*
+	 * We only track unmovable, reclaimable and movable on pcp lists.
+	 * Place ISOLATE pages on the isolated list because they are being
+	 * offlined but treat HIGHATOMIC as movable pages so we can get those
+	 * areas back if necessary. Otherwise, we may have to free
+	 * excessively into the page allocator
+	 */
+	migratetype = get_pcppage_migratetype(page);
+	if (unlikely(migratetype >= MIGRATE_PCPTYPES)) {
+		if (unlikely(is_migrate_isolate(migratetype))) {
+			free_one_page(page_zone(page), page, pfn, 0, migratetype, FPI_NONE);
+			return;
+		}
+		migratetype = MIGRATE_MOVABLE;
+	}
+
 	local_lock_irqsave(&pagesets.lock, flags);
-	free_unref_page_commit(page, pfn);
+	free_unref_page_commit(page, pfn, migratetype);
 	local_unlock_irqrestore(&pagesets.lock, flags);
 }
 
@@ -3294,6 +3295,7 @@ void free_unref_page_list(struct list_head *list)
 	struct page *page, *next;
 	unsigned long flags, pfn;
 	int batch_count = 0;
+	int migratetype;
 
 	/* Prepare pages for freeing */
 	list_for_each_entry_safe(page, next, list, lru) {
@@ -3301,15 +3303,28 @@ void free_unref_page_list(struct list_head *list)
 		if (!free_unref_page_prepare(page, pfn))
 			list_del(&page->lru);
 		set_page_private(page, pfn);
+
+		/*
+		 * Free isolated pages directly to the allocator, see
+		 * comment in free_unref_page.
+		 */
+		migratetype = get_pcppage_migratetype(page);
+		if (unlikely(migratetype >= MIGRATE_PCPTYPES)) {
+			if (unlikely(is_migrate_isolate(migratetype))) {
+				free_one_page(page_zone(page), page, pfn, 0,
+							migratetype, FPI_NONE);
+				list_del(&page->lru);
+			}
+		}
 	}
 
 	local_lock_irqsave(&pagesets.lock, flags);
 	list_for_each_entry_safe(page, next, list, lru) {
-		unsigned long pfn = page_private(page);
-
+		pfn = page_private(page);
 		set_page_private(page, 0);
+		migratetype = get_pcppage_migratetype(page);
 		trace_mm_page_free_batched(page);
-		free_unref_page_commit(page, pfn);
+		free_unref_page_commit(page, pfn, migratetype);
 
 		/*
 		 * Guard against excessive IRQ disabled times when we get
-- 
2.26.2

