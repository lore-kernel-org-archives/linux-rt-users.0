Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1259C433E1
	for <linux-rt-users@archiver.kernel.org>; Mon, 29 Mar 2021 12:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF1A56195C
	for <linux-rt-users@archiver.kernel.org>; Mon, 29 Mar 2021 12:17:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbhC2MRU (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 29 Mar 2021 08:17:20 -0400
Received: from outbound-smtp22.blacknight.com ([81.17.249.190]:59439 "EHLO
        outbound-smtp22.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230209AbhC2MRE (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 29 Mar 2021 08:17:04 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp22.blacknight.com (Postfix) with ESMTPS id 410B3BA9DA
        for <linux-rt-users@vger.kernel.org>; Mon, 29 Mar 2021 13:08:00 +0100 (IST)
Received: (qmail 20566 invoked from network); 29 Mar 2021 12:08:00 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPA; 29 Mar 2021 12:08:00 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Linux-MM <linux-mm@kvack.org>
Cc:     Linux-RT-Users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 6/6] mm/page_alloc: Reduce duration that IRQs are disabled for VM counters
Date:   Mon, 29 Mar 2021 13:06:48 +0100
Message-Id: <20210329120648.19040-7-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210329120648.19040-1-mgorman@techsingularity.net>
References: <20210329120648.19040-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

IRQs are left disabled for the zone and node VM event counters. On some
architectures this is unnecessary and it confuses what the scope of the
locking for per-cpu lists and VM counters are.

This patch reduces the scope of IRQs being disabled via local_[lock|unlock]
and relies on preemption disabling for the per-cpu counters. This
is not completely free on all architectures as architectures
without HAVE_CMPXCHG_DOUBLE will disable/enable IRQs again for the
mod_zone_freepage_state call. However, it clarifies what the per-cpu
pages lock protects and how zone stats may need IRQs disabled if ever
called from an IRQ context.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/page_alloc.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 32c64839c145..25d9351e75d8 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3461,11 +3461,17 @@ static struct page *rmqueue_pcplist(struct zone *preferred_zone,
 	pcp = this_cpu_ptr(zone->per_cpu_pageset);
 	list = &pcp->lists[migratetype];
 	page = __rmqueue_pcplist(zone,  migratetype, alloc_flags, pcp, list);
+	local_unlock_irqrestore(&pagesets.lock, flags);
 	if (page) {
+		/*
+		 * per-cpu counter updates are not preempt-safe but is
+		 * acceptable to race versus interrupts.
+		 */
+		preempt_disable();
 		__count_zid_vm_events(PGALLOC, page_zonenum(page), 1);
 		zone_statistics(preferred_zone, zone, 1);
+		preempt_enable();
 	}
-	local_unlock_irqrestore(&pagesets.lock, flags);
 	return page;
 }
 
@@ -3517,15 +3523,17 @@ struct page *rmqueue(struct zone *preferred_zone,
 		if (!page)
 			page = __rmqueue(zone, order, migratetype, alloc_flags);
 	} while (page && check_new_pages(page, order));
-	spin_unlock(&zone->lock);
+	spin_unlock_irqrestore(&zone->lock, flags);
+
 	if (!page)
 		goto failed;
+
+	preempt_disable();
 	__mod_zone_freepage_state(zone, -(1 << order),
 				  get_pcppage_migratetype(page));
-
 	__count_zid_vm_events(PGALLOC, page_zonenum(page), 1 << order);
 	zone_statistics(preferred_zone, zone, 1);
-	local_irq_restore(flags);
+	preempt_enable();
 
 out:
 	/* Separate test+clear to avoid unnecessary atomics */
@@ -5090,10 +5098,12 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 		nr_populated++;
 	}
 
+	local_unlock_irqrestore(&pagesets.lock, flags);
+
+	preempt_disable();
 	__count_zid_vm_events(PGALLOC, zone_idx(zone), nr_account);
 	zone_statistics(ac.preferred_zoneref->zone, zone, nr_account);
-
-	local_unlock_irqrestore(&pagesets.lock, flags);
+	preempt_enable();
 
 	return nr_populated;
 
-- 
2.26.2

