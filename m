Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0829C433B4
	for <linux-rt-users@archiver.kernel.org>; Wed,  7 Apr 2021 20:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 996906121E
	for <linux-rt-users@archiver.kernel.org>; Wed,  7 Apr 2021 20:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356229AbhDGU0c (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 7 Apr 2021 16:26:32 -0400
Received: from outbound-smtp61.blacknight.com ([46.22.136.249]:51127 "EHLO
        outbound-smtp61.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1356231AbhDGUZj (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 7 Apr 2021 16:25:39 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp61.blacknight.com (Postfix) with ESMTPS id 72928FB3DF
        for <linux-rt-users@vger.kernel.org>; Wed,  7 Apr 2021 21:25:26 +0100 (IST)
Received: (qmail 16150 invoked from network); 7 Apr 2021 20:25:26 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPA; 7 Apr 2021 20:25:26 -0000
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
Subject: [PATCH 05/11] mm/vmstat: Inline NUMA event counter updates
Date:   Wed,  7 Apr 2021 21:24:17 +0100
Message-Id: <20210407202423.16022-6-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210407202423.16022-1-mgorman@techsingularity.net>
References: <20210407202423.16022-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

__count_numa_event is small enough to be treated similarly to
__count_vm_event so inline it.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 include/linux/vmstat.h | 9 +++++++++
 mm/vmstat.c            | 9 ---------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index fc14415223c5..dde4dec4e7dd 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -237,6 +237,15 @@ static inline unsigned long zone_page_state_snapshot(struct zone *zone,
 }
 
 #ifdef CONFIG_NUMA
+/* See __count_vm_event comment on why raw_cpu_inc is used. */
+static inline void
+__count_numa_event(struct zone *zone, enum numa_stat_item item)
+{
+	struct per_cpu_zonestat __percpu *pzstats = zone->per_cpu_zonestats;
+
+	raw_cpu_inc(pzstats->vm_numa_event[item]);
+}
+
 extern void __count_numa_event(struct zone *zone, enum numa_stat_item item);
 extern unsigned long sum_zone_node_page_state(int node,
 					      enum zone_stat_item item);
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 63bd84d122c0..b853df95ed0c 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -902,15 +902,6 @@ void drain_zonestat(struct zone *zone, struct per_cpu_zonestat *pzstats)
 #endif
 
 #ifdef CONFIG_NUMA
-/* See __count_vm_event comment on why raw_cpu_inc is used. */
-void __count_numa_event(struct zone *zone,
-				 enum numa_stat_item item)
-{
-	struct per_cpu_zonestat __percpu *pzstats = zone->per_cpu_zonestats;
-
-	raw_cpu_inc(pzstats->vm_numa_event[item]);
-}
-
 /*
  * Determine the per node value of a stat item. This function
  * is called frequently in a NUMA machine, so try to be as
-- 
2.26.2

