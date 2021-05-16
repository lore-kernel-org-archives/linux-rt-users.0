Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2881C433B4
	for <linux-rt-users@archiver.kernel.org>; Sun, 16 May 2021 14:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DB5061186
	for <linux-rt-users@archiver.kernel.org>; Sun, 16 May 2021 14:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233946AbhEPOIY (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 16 May 2021 10:08:24 -0400
Received: from outbound-smtp15.blacknight.com ([46.22.139.232]:56469 "EHLO
        outbound-smtp15.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230467AbhEPOIX (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 16 May 2021 10:08:23 -0400
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp15.blacknight.com (Postfix) with ESMTPS id ABA1D1C42ED
        for <linux-rt-users@vger.kernel.org>; Sun, 16 May 2021 15:07:07 +0100 (IST)
Received: (qmail 21356 invoked from network); 16 May 2021 14:07:07 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.23.168])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 16 May 2021 14:07:07 -0000
Date:   Sun, 16 May 2021 15:07:05 +0100
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
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] mm/page_alloc: Split per cpu page lists and zone stats -fix
 -fix
Message-ID: <20210516140705.GB3735@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

mm/ is not W=1 clean for make allnoconfig but this patch accidentally
made it worse for i386 with the warning

  mm/vmstat.c: In function ‘refresh_cpu_vm_stats’:
  mm/vmstat.c:785:34: warning: unused variable ‘pcp’ [-Wunused-variable]
     struct per_cpu_pages __percpu *pcp = zone->per_cpu_pageset;
                                    ^~~

This is a second fix to the mmotm patch
mm-page_alloc-split-per-cpu-page-lists-and-zone-stats.patch.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/vmstat.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/vmstat.c b/mm/vmstat.c
index a2c3f58253be..f1400ba46beb 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -782,7 +782,9 @@ static int refresh_cpu_vm_stats(bool do_pagesets)
 
 	for_each_populated_zone(zone) {
 		struct per_cpu_zonestat __percpu *pzstats = zone->per_cpu_zonestats;
+#ifdef CONFIG_NUMA
 		struct per_cpu_pages __percpu *pcp = zone->per_cpu_pageset;
+#endif
 
 		for (i = 0; i < NR_VM_ZONE_STAT_ITEMS; i++) {
 			int v;
