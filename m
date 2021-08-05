Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE79C4338F
	for <linux-rt-users@archiver.kernel.org>; Thu,  5 Aug 2021 16:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D69BA61154
	for <linux-rt-users@archiver.kernel.org>; Thu,  5 Aug 2021 16:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242865AbhHEQA4 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 5 Aug 2021 12:00:56 -0400
Received: from outbound-smtp53.blacknight.com ([46.22.136.237]:39259 "EHLO
        outbound-smtp53.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242783AbhHEQAz (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 5 Aug 2021 12:00:55 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp53.blacknight.com (Postfix) with ESMTPS id 7CF33FB00E
        for <linux-rt-users@vger.kernel.org>; Thu,  5 Aug 2021 17:00:40 +0100 (IST)
Received: (qmail 18016 invoked from network); 5 Aug 2021 16:00:40 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPA; 5 Aug 2021 16:00:40 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>, Linux-MM <linux-mm@kvack.org>,
        Linux-RT-Users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 1/1] mm/vmstat: Protect per cpu variables with preempt disable on RT
Date:   Thu,  5 Aug 2021 17:00:19 +0100
Message-Id: <20210805160019.1137-2-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210805160019.1137-1-mgorman@techsingularity.net>
References: <20210805160019.1137-1-mgorman@techsingularity.net>
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
protection. This patch also differs in that a preempt_[en|dis]able_rt
helper is not used. As vmstat is the only user of the helper, it was
suggested that it be open-coded in vmstat.c instead of risking the helper
being used in unnecessary contexts.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/vmstat.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/mm/vmstat.c b/mm/vmstat.c
index b0534e068166..2c7e7569a453 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -319,6 +319,16 @@ void __mod_zone_page_state(struct zone *zone, enum zone_stat_item item,
 	long x;
 	long t;
 
+	/*
+	 * Accurate vmstat updates require a RMW. On !PREEMPT_RT kernels,
+	 * atomicity is provided by IRQs being disabled -- either explicitly
+	 * or via local_lock_irq. On PREEMPT_RT, local_lock_irq only disables
+	 * CPU migrations and preemption potentially corrupts a counter so
+	 * disable preemption.
+	 */
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_disable();
+
 	x = delta + __this_cpu_read(*p);
 
 	t = __this_cpu_read(pcp->stat_threshold);
@@ -328,6 +338,9 @@ void __mod_zone_page_state(struct zone *zone, enum zone_stat_item item,
 		x = 0;
 	}
 	__this_cpu_write(*p, x);
+
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_enable();
 }
 EXPORT_SYMBOL(__mod_zone_page_state);
 
@@ -350,6 +363,10 @@ void __mod_node_page_state(struct pglist_data *pgdat, enum node_stat_item item,
 		delta >>= PAGE_SHIFT;
 	}
 
+	/* See __mod_node_page_state */
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_disable();
+
 	x = delta + __this_cpu_read(*p);
 
 	t = __this_cpu_read(pcp->stat_threshold);
@@ -359,6 +376,9 @@ void __mod_node_page_state(struct pglist_data *pgdat, enum node_stat_item item,
 		x = 0;
 	}
 	__this_cpu_write(*p, x);
+
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_enable();
 }
 EXPORT_SYMBOL(__mod_node_page_state);
 
@@ -391,6 +411,10 @@ void __inc_zone_state(struct zone *zone, enum zone_stat_item item)
 	s8 __percpu *p = pcp->vm_stat_diff + item;
 	s8 v, t;
 
+	/* See __mod_node_page_state */
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_disable();
+
 	v = __this_cpu_inc_return(*p);
 	t = __this_cpu_read(pcp->stat_threshold);
 	if (unlikely(v > t)) {
@@ -399,6 +423,9 @@ void __inc_zone_state(struct zone *zone, enum zone_stat_item item)
 		zone_page_state_add(v + overstep, zone, item);
 		__this_cpu_write(*p, -overstep);
 	}
+
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_enable();
 }
 
 void __inc_node_state(struct pglist_data *pgdat, enum node_stat_item item)
@@ -409,6 +436,10 @@ void __inc_node_state(struct pglist_data *pgdat, enum node_stat_item item)
 
 	VM_WARN_ON_ONCE(vmstat_item_in_bytes(item));
 
+	/* See __mod_node_page_state */
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_disable();
+
 	v = __this_cpu_inc_return(*p);
 	t = __this_cpu_read(pcp->stat_threshold);
 	if (unlikely(v > t)) {
@@ -417,6 +448,9 @@ void __inc_node_state(struct pglist_data *pgdat, enum node_stat_item item)
 		node_page_state_add(v + overstep, pgdat, item);
 		__this_cpu_write(*p, -overstep);
 	}
+
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_enable();
 }
 
 void __inc_zone_page_state(struct page *page, enum zone_stat_item item)
@@ -437,6 +471,10 @@ void __dec_zone_state(struct zone *zone, enum zone_stat_item item)
 	s8 __percpu *p = pcp->vm_stat_diff + item;
 	s8 v, t;
 
+	/* See __mod_node_page_state */
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_disable();
+
 	v = __this_cpu_dec_return(*p);
 	t = __this_cpu_read(pcp->stat_threshold);
 	if (unlikely(v < - t)) {
@@ -445,6 +483,9 @@ void __dec_zone_state(struct zone *zone, enum zone_stat_item item)
 		zone_page_state_add(v - overstep, zone, item);
 		__this_cpu_write(*p, overstep);
 	}
+
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_enable();
 }
 
 void __dec_node_state(struct pglist_data *pgdat, enum node_stat_item item)
@@ -455,6 +496,10 @@ void __dec_node_state(struct pglist_data *pgdat, enum node_stat_item item)
 
 	VM_WARN_ON_ONCE(vmstat_item_in_bytes(item));
 
+	/* See __mod_node_page_state */
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_disable();
+
 	v = __this_cpu_dec_return(*p);
 	t = __this_cpu_read(pcp->stat_threshold);
 	if (unlikely(v < - t)) {
@@ -463,6 +508,9 @@ void __dec_node_state(struct pglist_data *pgdat, enum node_stat_item item)
 		node_page_state_add(v - overstep, pgdat, item);
 		__this_cpu_write(*p, overstep);
 	}
+
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_enable();
 }
 
 void __dec_zone_page_state(struct page *page, enum zone_stat_item item)
-- 
2.31.1

