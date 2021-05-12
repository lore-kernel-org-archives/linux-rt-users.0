Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D424BC433B4
	for <linux-rt-users@archiver.kernel.org>; Wed, 12 May 2021 09:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A7CF613BC
	for <linux-rt-users@archiver.kernel.org>; Wed, 12 May 2021 09:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbhELJ5c (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 12 May 2021 05:57:32 -0400
Received: from outbound-smtp16.blacknight.com ([46.22.139.233]:47597 "EHLO
        outbound-smtp16.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230407AbhELJ5b (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 12 May 2021 05:57:31 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp16.blacknight.com (Postfix) with ESMTPS id D6C261C3833
        for <linux-rt-users@vger.kernel.org>; Wed, 12 May 2021 10:56:21 +0100 (IST)
Received: (qmail 30019 invoked from network); 12 May 2021 09:56:21 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.23.168])
  by 81.17.254.9 with ESMTPA; 12 May 2021 09:56:21 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux-MM <linux-mm@kvack.org>,
        Linux-RT-Users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 7/9] mm/page_alloc: Explicitly acquire the zone lock in __free_pages_ok
Date:   Wed, 12 May 2021 10:54:56 +0100
Message-Id: <20210512095458.30632-8-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210512095458.30632-1-mgorman@techsingularity.net>
References: <20210512095458.30632-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

__free_pages_ok() disables IRQs before calling a common helper
free_one_page() that acquires the zone lock. This is not safe according
to Documentation/locking/locktypes.rst and in this context, IRQ disabling
is not protecting a per_cpu_pages structure either or a local_lock would
be used.

This patch explicitly acquires the lock with spin_lock_irqsave instead of
relying on a helper. This removes the last instance of local_irq_save()
in page_alloc.c.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/page_alloc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 5879b595b74b..7da70b404f4e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1579,21 +1579,21 @@ static void __free_pages_ok(struct page *page, unsigned int order,
 	unsigned long flags;
 	int migratetype;
 	unsigned long pfn = page_to_pfn(page);
+	struct zone *zone = page_zone(page);
 
 	if (!free_pages_prepare(page, order, true, fpi_flags))
 		return;
 
 	migratetype = get_pfnblock_migratetype(page, pfn);
 
-	/*
-	 * TODO FIX: Disable IRQs before acquiring IRQ-safe zone->lock
-	 * and protect vmstat updates.
-	 */
-	local_irq_save(flags);
+	spin_lock_irqsave(&zone->lock, flags);
 	__count_vm_events(PGFREE, 1 << order);
-	free_one_page(page_zone(page), page, pfn, order, migratetype,
-		      fpi_flags);
-	local_irq_restore(flags);
+	if (unlikely(has_isolate_pageblock(zone) ||
+		is_migrate_isolate(migratetype))) {
+		migratetype = get_pfnblock_migratetype(page, pfn);
+	}
+	__free_one_page(page, pfn, zone, order, migratetype, fpi_flags);
+	spin_unlock_irqrestore(&zone->lock, flags);
 }
 
 void __free_pages_core(struct page *page, unsigned int order)
-- 
2.26.2

