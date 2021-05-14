Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBD3C433ED
	for <linux-rt-users@archiver.kernel.org>; Fri, 14 May 2021 14:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 998AB61490
	for <linux-rt-users@archiver.kernel.org>; Fri, 14 May 2021 14:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbhENOy5 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 14 May 2021 10:54:57 -0400
Received: from outbound-smtp17.blacknight.com ([46.22.139.234]:37577 "EHLO
        outbound-smtp17.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232005AbhENOy4 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 14 May 2021 10:54:56 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp17.blacknight.com (Postfix) with ESMTPS id 963AD1C3889
        for <linux-rt-users@vger.kernel.org>; Fri, 14 May 2021 15:53:44 +0100 (IST)
Received: (qmail 14594 invoked from network); 14 May 2021 14:53:44 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.23.168])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 14 May 2021 14:53:44 -0000
Date:   Fri, 14 May 2021 15:46:22 +0100
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
Message-ID: <20210514144622.GA3735@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

mm/ is not W=1 clean for allnoconfig but the patch "mm/page_alloc: Split
per cpu page lists and zone stats" makes it worse with the following
warning

  mm/vmstat.c: In function ‘zoneinfo_show_print’:
  mm/vmstat.c:1698:28: warning: variable ‘pzstats’ set but not used [-Wunused-but-set-variable]
     struct per_cpu_zonestat *pzstats;
                              ^~~~~~~

This is a fix to the mmotm patch
mm-page_alloc-split-per-cpu-page-lists-and-zone-stats.patch.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/vmstat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/vmstat.c b/mm/vmstat.c
index e3bcd317ea55..a2c3f58253be 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1695,10 +1695,9 @@ static void zoneinfo_show_print(struct seq_file *m, pg_data_t *pgdat,
 	seq_printf(m, "\n  pagesets");
 	for_each_online_cpu(i) {
 		struct per_cpu_pages *pcp;
-		struct per_cpu_zonestat *pzstats;
+		struct per_cpu_zonestat __maybe_unused *pzstats;
 
 		pcp = per_cpu_ptr(zone->per_cpu_pageset, i);
-		pzstats = per_cpu_ptr(zone->per_cpu_zonestats, i);
 		seq_printf(m,
 			   "\n    cpu: %i"
 			   "\n              count: %i"
@@ -1709,6 +1708,7 @@ static void zoneinfo_show_print(struct seq_file *m, pg_data_t *pgdat,
 			   pcp->high,
 			   pcp->batch);
 #ifdef CONFIG_SMP
+		pzstats = per_cpu_ptr(zone->per_cpu_zonestats, i);
 		seq_printf(m, "\n  vm stats threshold: %d",
 				pzstats->stat_threshold);
 #endif
