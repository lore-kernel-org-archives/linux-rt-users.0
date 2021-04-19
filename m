Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E7CC433ED
	for <linux-rt-users@archiver.kernel.org>; Mon, 19 Apr 2021 14:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45AA3611CE
	for <linux-rt-users@archiver.kernel.org>; Mon, 19 Apr 2021 14:15:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241184AbhDSOP4 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 19 Apr 2021 10:15:56 -0400
Received: from outbound-smtp63.blacknight.com ([46.22.136.252]:47753 "EHLO
        outbound-smtp63.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238920AbhDSOPz (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 19 Apr 2021 10:15:55 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp63.blacknight.com (Postfix) with ESMTPS id 3101FFAE2B
        for <linux-rt-users@vger.kernel.org>; Mon, 19 Apr 2021 15:15:24 +0100 (IST)
Received: (qmail 16014 invoked from network); 19 Apr 2021 14:15:24 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPA; 19 Apr 2021 14:15:23 -0000
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
Subject: [PATCH 09/10] mm/page_alloc: Update PGFREE outside the zone lock in __free_pages_ok
Date:   Mon, 19 Apr 2021 15:13:40 +0100
Message-Id: <20210419141341.26047-10-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210419141341.26047-1-mgorman@techsingularity.net>
References: <20210419141341.26047-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

VM events do not need explicit protection by disabling IRQs so
update the counter with IRQs enabled in __free_pages_ok.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/page_alloc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index a9c1282d9c7b..44a5eb067b38 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1557,13 +1557,14 @@ static void __free_pages_ok(struct page *page, unsigned int order,
 	migratetype = get_pfnblock_migratetype(page, pfn);
 
 	spin_lock_irqsave(&zone->lock, flags);
-	__count_vm_events(PGFREE, 1 << order);
 	if (unlikely(has_isolate_pageblock(zone) ||
 		is_migrate_isolate(migratetype))) {
 		migratetype = get_pfnblock_migratetype(page, pfn);
 	}
 	__free_one_page(page, pfn, zone, order, migratetype, fpi_flags);
 	spin_unlock_irqrestore(&zone->lock, flags);
+
+	__count_vm_events(PGFREE, 1 << order);
 }
 
 void __free_pages_core(struct page *page, unsigned int order)
-- 
2.26.2

