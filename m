Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D85AAC4338F
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Jul 2021 10:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C135860E73
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Jul 2021 10:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbhGWJ1u (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 23 Jul 2021 05:27:50 -0400
Received: from outbound-smtp49.blacknight.com ([46.22.136.233]:51511 "EHLO
        outbound-smtp49.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231273AbhGWJ1t (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 23 Jul 2021 05:27:49 -0400
X-Greylist: delayed 447 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Jul 2021 05:27:49 EDT
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp49.blacknight.com (Postfix) with ESMTPS id 3F058FB30D
        for <linux-rt-users@vger.kernel.org>; Fri, 23 Jul 2021 11:01:05 +0100 (IST)
Received: (qmail 9456 invoked from network); 23 Jul 2021 10:01:04 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPA; 23 Jul 2021 10:01:04 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>, Linux-MM <linux-mm@kvack.org>,
        Linux-RT-Users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 2/2] mm/vmstat: Protect per cpu variables with preempt disable on RT
Date:   Fri, 23 Jul 2021 11:00:34 +0100
Message-Id: <20210723100034.13353-3-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210723100034.13353-1-mgorman@techsingularity.net>
References: <20210723100034.13353-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

Disable preemption on -RT for the vmstat code. On vanila the code runs
in IRQ-off regions while on -RT it may not when stats are updated under
a local_lock. "preempt_disable" ensures that the same resources is not
updated in parallel due to preemption.

This patch differs from the preempt-rt version where __count_vm_event and
__count_vm_events are also protected. The counters are explicitly "allowed
to be to be racy" so there is no need to protect them from preemption. Only
the accurate page stats that are updated by a read-modify-write need
protection.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/vmstat.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/mm/vmstat.c b/mm/vmstat.c
index b0534e068166..d06332c221b1 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -319,6 +319,7 @@ void __mod_zone_page_state(struct zone *zone, enum zone_stat_item item,
 	long x;
 	long t;
 
+	preempt_disable_rt();
 	x = delta + __this_cpu_read(*p);
 
 	t = __this_cpu_read(pcp->stat_threshold);
@@ -328,6 +329,7 @@ void __mod_zone_page_state(struct zone *zone, enum zone_stat_item item,
 		x = 0;
 	}
 	__this_cpu_write(*p, x);
+	preempt_enable_rt();
 }
 EXPORT_SYMBOL(__mod_zone_page_state);
 
@@ -350,6 +352,7 @@ void __mod_node_page_state(struct pglist_data *pgdat, enum node_stat_item item,
 		delta >>= PAGE_SHIFT;
 	}
 
+	preempt_disable_rt();
 	x = delta + __this_cpu_read(*p);
 
 	t = __this_cpu_read(pcp->stat_threshold);
@@ -359,6 +362,7 @@ void __mod_node_page_state(struct pglist_data *pgdat, enum node_stat_item item,
 		x = 0;
 	}
 	__this_cpu_write(*p, x);
+	preempt_enable_rt();
 }
 EXPORT_SYMBOL(__mod_node_page_state);
 
@@ -391,6 +395,7 @@ void __inc_zone_state(struct zone *zone, enum zone_stat_item item)
 	s8 __percpu *p = pcp->vm_stat_diff + item;
 	s8 v, t;
 
+	preempt_disable_rt();
 	v = __this_cpu_inc_return(*p);
 	t = __this_cpu_read(pcp->stat_threshold);
 	if (unlikely(v > t)) {
@@ -399,6 +404,7 @@ void __inc_zone_state(struct zone *zone, enum zone_stat_item item)
 		zone_page_state_add(v + overstep, zone, item);
 		__this_cpu_write(*p, -overstep);
 	}
+	preempt_enable_rt();
 }
 
 void __inc_node_state(struct pglist_data *pgdat, enum node_stat_item item)
@@ -409,6 +415,7 @@ void __inc_node_state(struct pglist_data *pgdat, enum node_stat_item item)
 
 	VM_WARN_ON_ONCE(vmstat_item_in_bytes(item));
 
+	preempt_disable_rt();
 	v = __this_cpu_inc_return(*p);
 	t = __this_cpu_read(pcp->stat_threshold);
 	if (unlikely(v > t)) {
@@ -417,6 +424,7 @@ void __inc_node_state(struct pglist_data *pgdat, enum node_stat_item item)
 		node_page_state_add(v + overstep, pgdat, item);
 		__this_cpu_write(*p, -overstep);
 	}
+	preempt_enable_rt();
 }
 
 void __inc_zone_page_state(struct page *page, enum zone_stat_item item)
@@ -437,6 +445,7 @@ void __dec_zone_state(struct zone *zone, enum zone_stat_item item)
 	s8 __percpu *p = pcp->vm_stat_diff + item;
 	s8 v, t;
 
+	preempt_disable_rt();
 	v = __this_cpu_dec_return(*p);
 	t = __this_cpu_read(pcp->stat_threshold);
 	if (unlikely(v < - t)) {
@@ -445,6 +454,7 @@ void __dec_zone_state(struct zone *zone, enum zone_stat_item item)
 		zone_page_state_add(v - overstep, zone, item);
 		__this_cpu_write(*p, overstep);
 	}
+	preempt_enable_rt();
 }
 
 void __dec_node_state(struct pglist_data *pgdat, enum node_stat_item item)
@@ -455,6 +465,7 @@ void __dec_node_state(struct pglist_data *pgdat, enum node_stat_item item)
 
 	VM_WARN_ON_ONCE(vmstat_item_in_bytes(item));
 
+	preempt_disable_rt();
 	v = __this_cpu_dec_return(*p);
 	t = __this_cpu_read(pcp->stat_threshold);
 	if (unlikely(v < - t)) {
@@ -463,6 +474,7 @@ void __dec_node_state(struct pglist_data *pgdat, enum node_stat_item item)
 		node_page_state_add(v - overstep, pgdat, item);
 		__this_cpu_write(*p, overstep);
 	}
+	preempt_enable_rt();
 }
 
 void __dec_zone_page_state(struct page *page, enum zone_stat_item item)
-- 
2.26.2

