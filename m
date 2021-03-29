Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B43C433DB
	for <linux-rt-users@archiver.kernel.org>; Mon, 29 Mar 2021 12:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E46D6192F
	for <linux-rt-users@archiver.kernel.org>; Mon, 29 Mar 2021 12:17:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbhC2MRT (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 29 Mar 2021 08:17:19 -0400
Received: from outbound-smtp22.blacknight.com ([81.17.249.190]:60330 "EHLO
        outbound-smtp22.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230143AbhC2MRE (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 29 Mar 2021 08:17:04 -0400
X-Greylist: delayed 573 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Mar 2021 08:17:03 EDT
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp22.blacknight.com (Postfix) with ESMTPS id B2F41BAA55
        for <linux-rt-users@vger.kernel.org>; Mon, 29 Mar 2021 13:07:29 +0100 (IST)
Received: (qmail 18847 invoked from network); 29 Mar 2021 12:07:29 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPA; 29 Mar 2021 12:07:29 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Linux-MM <linux-mm@kvack.org>
Cc:     Linux-RT-Users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 3/6] mm/vmstat: Convert NUMA statistics to basic NUMA counters
Date:   Mon, 29 Mar 2021 13:06:45 +0100
Message-Id: <20210329120648.19040-4-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210329120648.19040-1-mgorman@techsingularity.net>
References: <20210329120648.19040-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

NUMA statistics are maintained on the zone level for hits, misses, foreign
etc but nothing relies on them being perfectly accurate for functional
correctness. This is overkill as the counters are used by userspace to get
a general overview a workloads NUMA behaviour but the page allocator incurs
a high cost to maintain perfect accuracy similar to what is required for
a vmstat like NR_FREE_PAGES. There even is a sysctl vm.numa_stat to allow
userspace to turn off the collection of NUMA statistics like NUMA_HIT.

This patch converts NUMA_HIT and friends to be NUMA events with similar
accuracy to VM events. There is a possibility that slight errors will be
introduced but the overall trend as seen by userspace will be similar.
Note that while these counters could be maintained at the node level,
it would have a user-visible impact.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 drivers/base/node.c    |  18 +++--
 include/linux/mmzone.h |  11 ++-
 include/linux/vmstat.h |  42 +++++-----
 mm/mempolicy.c         |   2 +-
 mm/page_alloc.c        |  12 +--
 mm/vmstat.c            | 175 ++++++++++++-----------------------------
 6 files changed, 93 insertions(+), 167 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index f449dbb2c746..443a609db428 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -484,6 +484,7 @@ static DEVICE_ATTR(meminfo, 0444, node_read_meminfo, NULL);
 static ssize_t node_read_numastat(struct device *dev,
 				  struct device_attribute *attr, char *buf)
 {
+	fold_vm_numa_events();
 	return sysfs_emit(buf,
 			  "numa_hit %lu\n"
 			  "numa_miss %lu\n"
@@ -491,12 +492,12 @@ static ssize_t node_read_numastat(struct device *dev,
 			  "interleave_hit %lu\n"
 			  "local_node %lu\n"
 			  "other_node %lu\n",
-			  sum_zone_numa_state(dev->id, NUMA_HIT),
-			  sum_zone_numa_state(dev->id, NUMA_MISS),
-			  sum_zone_numa_state(dev->id, NUMA_FOREIGN),
-			  sum_zone_numa_state(dev->id, NUMA_INTERLEAVE_HIT),
-			  sum_zone_numa_state(dev->id, NUMA_LOCAL),
-			  sum_zone_numa_state(dev->id, NUMA_OTHER));
+			  sum_zone_numa_event_state(dev->id, NUMA_HIT),
+			  sum_zone_numa_event_state(dev->id, NUMA_MISS),
+			  sum_zone_numa_event_state(dev->id, NUMA_FOREIGN),
+			  sum_zone_numa_event_state(dev->id, NUMA_INTERLEAVE_HIT),
+			  sum_zone_numa_event_state(dev->id, NUMA_LOCAL),
+			  sum_zone_numa_event_state(dev->id, NUMA_OTHER));
 }
 static DEVICE_ATTR(numastat, 0444, node_read_numastat, NULL);
 
@@ -514,10 +515,11 @@ static ssize_t node_read_vmstat(struct device *dev,
 				     sum_zone_node_page_state(nid, i));
 
 #ifdef CONFIG_NUMA
-	for (i = 0; i < NR_VM_NUMA_STAT_ITEMS; i++)
+	fold_vm_numa_events();
+	for (i = 0; i < NR_VM_NUMA_EVENT_ITEMS; i++)
 		len += sysfs_emit_at(buf, len, "%s %lu\n",
 				     numa_stat_name(i),
-				     sum_zone_numa_state(nid, i));
+				     sum_zone_numa_event_state(nid, i));
 
 #endif
 	for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++) {
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 106da8fbc72a..693cd5f24f7d 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -135,10 +135,10 @@ enum numa_stat_item {
 	NUMA_INTERLEAVE_HIT,	/* interleaver preferred this zone */
 	NUMA_LOCAL,		/* allocation from local node */
 	NUMA_OTHER,		/* allocation from other node */
-	NR_VM_NUMA_STAT_ITEMS
+	NR_VM_NUMA_EVENT_ITEMS
 };
 #else
-#define NR_VM_NUMA_STAT_ITEMS 0
+#define NR_VM_NUMA_EVENT_ITEMS 0
 #endif
 
 enum zone_stat_item {
@@ -357,7 +357,10 @@ struct per_cpu_zonestat {
 	s8 stat_threshold;
 #endif
 #ifdef CONFIG_NUMA
-	u16 vm_numa_stat_diff[NR_VM_NUMA_STAT_ITEMS];
+	u16 vm_numa_stat_diff[NR_VM_NUMA_EVENT_ITEMS];
+#endif
+#ifdef CONFIG_NUMA
+	unsigned long vm_numa_event[NR_VM_NUMA_EVENT_ITEMS];
 #endif
 };
 
@@ -609,7 +612,7 @@ struct zone {
 	ZONE_PADDING(_pad3_)
 	/* Zone statistics */
 	atomic_long_t		vm_stat[NR_VM_ZONE_STAT_ITEMS];
-	atomic_long_t		vm_numa_stat[NR_VM_NUMA_STAT_ITEMS];
+	atomic_long_t		vm_numa_events[NR_VM_NUMA_EVENT_ITEMS];
 } ____cacheline_internodealigned_in_smp;
 
 enum pgdat_flags {
diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index 1736ea9d24a7..fc14415223c5 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -138,35 +138,27 @@ static inline void vm_events_fold_cpu(int cpu)
  * Zone and node-based page accounting with per cpu differentials.
  */
 extern atomic_long_t vm_zone_stat[NR_VM_ZONE_STAT_ITEMS];
-extern atomic_long_t vm_numa_stat[NR_VM_NUMA_STAT_ITEMS];
 extern atomic_long_t vm_node_stat[NR_VM_NODE_STAT_ITEMS];
 
 #ifdef CONFIG_NUMA
-static inline void zone_numa_state_add(long x, struct zone *zone,
-				 enum numa_stat_item item)
-{
-	atomic_long_add(x, &zone->vm_numa_stat[item]);
-	atomic_long_add(x, &vm_numa_stat[item]);
-}
-
-static inline unsigned long global_numa_state(enum numa_stat_item item)
+static inline unsigned long zone_numa_event_state(struct zone *zone,
+					enum numa_stat_item item)
 {
-	long x = atomic_long_read(&vm_numa_stat[item]);
-
-	return x;
+	return atomic_long_read(&zone->vm_numa_events[item]);
 }
 
-static inline unsigned long zone_numa_state_snapshot(struct zone *zone,
-					enum numa_stat_item item)
+static inline unsigned long
+global_numa_event_state(enum numa_stat_item item)
 {
-	long x = atomic_long_read(&zone->vm_numa_stat[item]);
-	int cpu;
+	struct zone *zone;
+	unsigned long x = 0;
 
-	for_each_online_cpu(cpu)
-		x += per_cpu_ptr(zone->per_cpu_zonestats, cpu)->vm_numa_stat_diff[item];
+	for_each_populated_zone(zone)
+		x += zone_numa_event_state(zone, item);
 
 	return x;
 }
+
 #endif /* CONFIG_NUMA */
 
 static inline void zone_page_state_add(long x, struct zone *zone,
@@ -245,18 +237,22 @@ static inline unsigned long zone_page_state_snapshot(struct zone *zone,
 }
 
 #ifdef CONFIG_NUMA
-extern void __inc_numa_state(struct zone *zone, enum numa_stat_item item);
+extern void __count_numa_event(struct zone *zone, enum numa_stat_item item);
 extern unsigned long sum_zone_node_page_state(int node,
 					      enum zone_stat_item item);
-extern unsigned long sum_zone_numa_state(int node, enum numa_stat_item item);
+extern unsigned long sum_zone_numa_event_state(int node, enum numa_stat_item item);
 extern unsigned long node_page_state(struct pglist_data *pgdat,
 						enum node_stat_item item);
 extern unsigned long node_page_state_pages(struct pglist_data *pgdat,
 					   enum node_stat_item item);
+extern void fold_vm_numa_events(void);
 #else
 #define sum_zone_node_page_state(node, item) global_zone_page_state(item)
 #define node_page_state(node, item) global_node_page_state(item)
 #define node_page_state_pages(node, item) global_node_page_state_pages(item)
+static inline void fold_vm_numa_events(void)
+{
+}
 #endif /* CONFIG_NUMA */
 
 #ifdef CONFIG_SMP
@@ -428,7 +424,7 @@ static inline const char *numa_stat_name(enum numa_stat_item item)
 static inline const char *node_stat_name(enum node_stat_item item)
 {
 	return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
-			   NR_VM_NUMA_STAT_ITEMS +
+			   NR_VM_NUMA_EVENT_ITEMS +
 			   item];
 }
 
@@ -440,7 +436,7 @@ static inline const char *lru_list_name(enum lru_list lru)
 static inline const char *writeback_stat_name(enum writeback_stat_item item)
 {
 	return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
-			   NR_VM_NUMA_STAT_ITEMS +
+			   NR_VM_NUMA_EVENT_ITEMS +
 			   NR_VM_NODE_STAT_ITEMS +
 			   item];
 }
@@ -449,7 +445,7 @@ static inline const char *writeback_stat_name(enum writeback_stat_item item)
 static inline const char *vm_event_name(enum vm_event_item item)
 {
 	return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
-			   NR_VM_NUMA_STAT_ITEMS +
+			   NR_VM_NUMA_EVENT_ITEMS +
 			   NR_VM_NODE_STAT_ITEMS +
 			   NR_VM_WRITEBACK_STAT_ITEMS +
 			   item];
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index cd0295567a04..99c06a9ae7ee 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2146,7 +2146,7 @@ static struct page *alloc_page_interleave(gfp_t gfp, unsigned order,
 		return page;
 	if (page && page_to_nid(page) == nid) {
 		preempt_disable();
-		__inc_numa_state(page_zone(page), NUMA_INTERLEAVE_HIT);
+		__count_numa_event(page_zone(page), NUMA_INTERLEAVE_HIT);
 		preempt_enable();
 	}
 	return page;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 7f8c73020688..7eb48632bcac 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3411,12 +3411,12 @@ static inline void zone_statistics(struct zone *preferred_zone, struct zone *z)
 		local_stat = NUMA_OTHER;
 
 	if (zone_to_nid(z) == zone_to_nid(preferred_zone))
-		__inc_numa_state(z, NUMA_HIT);
+		__count_numa_event(z, NUMA_HIT);
 	else {
-		__inc_numa_state(z, NUMA_MISS);
-		__inc_numa_state(preferred_zone, NUMA_FOREIGN);
+		__count_numa_event(z, NUMA_MISS);
+		__count_numa_event(preferred_zone, NUMA_FOREIGN);
 	}
-	__inc_numa_state(z, local_stat);
+	__count_numa_event(z, local_stat);
 #endif
 }
 
@@ -6687,8 +6687,8 @@ void __init setup_per_cpu_pageset(void)
 	 */
 	for_each_possible_cpu(cpu) {
 		struct per_cpu_zonestat *pzstats = &per_cpu(boot_zonestats, cpu);
-		memset(pzstats->vm_numa_stat_diff, 0,
-		       sizeof(pzstats->vm_numa_stat_diff));
+		memset(pzstats->vm_numa_event, 0,
+		       sizeof(pzstats->vm_numa_event));
 	}
 #endif
 
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 01b74ff73549..46bc61184afc 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -41,38 +41,24 @@ static void zero_zone_numa_counters(struct zone *zone)
 {
 	int item, cpu;
 
-	for (item = 0; item < NR_VM_NUMA_STAT_ITEMS; item++) {
-		atomic_long_set(&zone->vm_numa_stat[item], 0);
-		for_each_online_cpu(cpu)
-			per_cpu_ptr(zone->per_cpu_zonestats, cpu)->vm_numa_stat_diff[item]
+	for (item = 0; item < NR_VM_NUMA_EVENT_ITEMS; item++) {
+		atomic_long_set(&zone->vm_numa_events[item], 0);
+		for_each_online_cpu(cpu) {
+			per_cpu_ptr(zone->per_cpu_zonestats, cpu)->vm_numa_event[item]
 						= 0;
+		}
 	}
 }
 
-/* zero numa counters of all the populated zones */
-static void zero_zones_numa_counters(void)
+static void invalidate_numa_statistics(void)
 {
 	struct zone *zone;
 
+	/* zero numa counters of all the populated zones */
 	for_each_populated_zone(zone)
 		zero_zone_numa_counters(zone);
 }
 
-/* zero global numa counters */
-static void zero_global_numa_counters(void)
-{
-	int item;
-
-	for (item = 0; item < NR_VM_NUMA_STAT_ITEMS; item++)
-		atomic_long_set(&vm_numa_stat[item], 0);
-}
-
-static void invalid_numa_statistics(void)
-{
-	zero_zones_numa_counters();
-	zero_global_numa_counters();
-}
-
 static DEFINE_MUTEX(vm_numa_stat_lock);
 
 int sysctl_vm_numa_stat_handler(struct ctl_table *table, int write,
@@ -94,7 +80,7 @@ int sysctl_vm_numa_stat_handler(struct ctl_table *table, int write,
 		pr_info("enable numa statistics\n");
 	} else {
 		static_branch_disable(&vm_numa_stat_key);
-		invalid_numa_statistics();
+		invalidate_numa_statistics();
 		pr_info("disable numa statistics, and clear numa counters\n");
 	}
 
@@ -161,10 +147,8 @@ void vm_events_fold_cpu(int cpu)
  * vm_stat contains the global counters
  */
 atomic_long_t vm_zone_stat[NR_VM_ZONE_STAT_ITEMS] __cacheline_aligned_in_smp;
-atomic_long_t vm_numa_stat[NR_VM_NUMA_STAT_ITEMS] __cacheline_aligned_in_smp;
 atomic_long_t vm_node_stat[NR_VM_NODE_STAT_ITEMS] __cacheline_aligned_in_smp;
 EXPORT_SYMBOL(vm_zone_stat);
-EXPORT_SYMBOL(vm_numa_stat);
 EXPORT_SYMBOL(vm_node_stat);
 
 #ifdef CONFIG_SMP
@@ -706,8 +690,7 @@ EXPORT_SYMBOL(dec_node_page_state);
  * Fold a differential into the global counters.
  * Returns the number of counters updated.
  */
-#ifdef CONFIG_NUMA
-static int fold_diff(int *zone_diff, int *numa_diff, int *node_diff)
+static int fold_diff(int *zone_diff, int *node_diff)
 {
 	int i;
 	int changes = 0;
@@ -718,12 +701,6 @@ static int fold_diff(int *zone_diff, int *numa_diff, int *node_diff)
 			changes++;
 	}
 
-	for (i = 0; i < NR_VM_NUMA_STAT_ITEMS; i++)
-		if (numa_diff[i]) {
-			atomic_long_add(numa_diff[i], &vm_numa_stat[i]);
-			changes++;
-	}
-
 	for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
 		if (node_diff[i]) {
 			atomic_long_add(node_diff[i], &vm_node_stat[i]);
@@ -731,26 +708,36 @@ static int fold_diff(int *zone_diff, int *numa_diff, int *node_diff)
 	}
 	return changes;
 }
-#else
-static int fold_diff(int *zone_diff, int *node_diff)
+
+#ifdef CONFIG_NUMA
+static void fold_vm_zone_numa_events(struct zone *zone)
 {
-	int i;
-	int changes = 0;
+	int zone_numa_events[NR_VM_NUMA_EVENT_ITEMS] = { 0, };
+	int cpu;
+	enum numa_stat_item item;
 
-	for (i = 0; i < NR_VM_ZONE_STAT_ITEMS; i++)
-		if (zone_diff[i]) {
-			atomic_long_add(zone_diff[i], &vm_zone_stat[i]);
-			changes++;
+	for_each_online_cpu(cpu) {
+		struct per_cpu_zonestat *pzstats;
+
+		pzstats = per_cpu_ptr(zone->per_cpu_zonestats, cpu);
+		for (item = 0; item < NR_VM_NUMA_EVENT_ITEMS; item++) {
+			zone_numa_events[item] += pzstats->vm_numa_event[item];
+		}
 	}
 
-	for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
-		if (node_diff[i]) {
-			atomic_long_add(node_diff[i], &vm_node_stat[i]);
-			changes++;
+	for (item = 0; item < NR_VM_NUMA_EVENT_ITEMS; item++) {
+		atomic_long_set(&zone->vm_numa_events[item], zone_numa_events[item]);
 	}
-	return changes;
 }
-#endif /* CONFIG_NUMA */
+
+void fold_vm_numa_events(void)
+{
+	struct zone *zone;
+
+	for_each_populated_zone(zone)
+		fold_vm_zone_numa_events(zone);
+}
+#endif
 
 /*
  * Update the zone counters for the current cpu.
@@ -774,9 +761,6 @@ static int refresh_cpu_vm_stats(bool do_pagesets)
 	struct zone *zone;
 	int i;
 	int global_zone_diff[NR_VM_ZONE_STAT_ITEMS] = { 0, };
-#ifdef CONFIG_NUMA
-	int global_numa_diff[NR_VM_NUMA_STAT_ITEMS] = { 0, };
-#endif
 	int global_node_diff[NR_VM_NODE_STAT_ITEMS] = { 0, };
 	int changes = 0;
 
@@ -799,17 +783,6 @@ static int refresh_cpu_vm_stats(bool do_pagesets)
 			}
 		}
 #ifdef CONFIG_NUMA
-		for (i = 0; i < NR_VM_NUMA_STAT_ITEMS; i++) {
-			int v;
-
-			v = this_cpu_xchg(pzstats->vm_numa_stat_diff[i], 0);
-			if (v) {
-
-				atomic_long_add(v, &zone->vm_numa_stat[i]);
-				global_numa_diff[i] += v;
-				__this_cpu_write(pcp->expire, 3);
-			}
-		}
 
 		if (do_pagesets) {
 			cond_resched();
@@ -857,12 +830,7 @@ static int refresh_cpu_vm_stats(bool do_pagesets)
 		}
 	}
 
-#ifdef CONFIG_NUMA
-	changes += fold_diff(global_zone_diff, global_numa_diff,
-			     global_node_diff);
-#else
 	changes += fold_diff(global_zone_diff, global_node_diff);
-#endif
 	return changes;
 }
 
@@ -877,9 +845,6 @@ void cpu_vm_stats_fold(int cpu)
 	struct zone *zone;
 	int i;
 	int global_zone_diff[NR_VM_ZONE_STAT_ITEMS] = { 0, };
-#ifdef CONFIG_NUMA
-	int global_numa_diff[NR_VM_NUMA_STAT_ITEMS] = { 0, };
-#endif
 	int global_node_diff[NR_VM_NODE_STAT_ITEMS] = { 0, };
 
 	for_each_populated_zone(zone) {
@@ -888,7 +853,7 @@ void cpu_vm_stats_fold(int cpu)
 		pzstats = per_cpu_ptr(zone->per_cpu_zonestats, cpu);
 
 		preempt_disable();
-		for (i = 0; i < NR_VM_ZONE_STAT_ITEMS; i++)
+		for (i = 0; i < NR_VM_ZONE_STAT_ITEMS; i++) {
 			if (pzstats->vm_stat_diff[i]) {
 				int v;
 
@@ -897,18 +862,7 @@ void cpu_vm_stats_fold(int cpu)
 				atomic_long_add(v, &zone->vm_stat[i]);
 				global_zone_diff[i] += v;
 			}
-
-#ifdef CONFIG_NUMA
-		for (i = 0; i < NR_VM_NUMA_STAT_ITEMS; i++)
-			if (pzstats->vm_numa_stat_diff[i]) {
-				int v;
-
-				v = pzstats->vm_numa_stat_diff[i];
-				pzstats->vm_numa_stat_diff[i] = 0;
-				atomic_long_add(v, &zone->vm_numa_stat[i]);
-				global_numa_diff[i] += v;
-			}
-#endif
+		}
 		preempt_enable();
 	}
 
@@ -928,11 +882,7 @@ void cpu_vm_stats_fold(int cpu)
 			}
 	}
 
-#ifdef CONFIG_NUMA
-	fold_diff(global_zone_diff, global_numa_diff, global_node_diff);
-#else
 	fold_diff(global_zone_diff, global_node_diff);
-#endif
 }
 
 /*
@@ -951,35 +901,18 @@ void drain_zonestat(struct zone *zone, struct per_cpu_zonestat *pzstats)
 			atomic_long_add(v, &zone->vm_stat[i]);
 			atomic_long_add(v, &vm_zone_stat[i]);
 		}
-
-#ifdef CONFIG_NUMA
-	for (i = 0; i < NR_VM_NUMA_STAT_ITEMS; i++)
-		if (pzstats->vm_numa_stat_diff[i]) {
-			int v = pzstats->vm_numa_stat_diff[i];
-
-			pzstats->vm_numa_stat_diff[i] = 0;
-			atomic_long_add(v, &zone->vm_numa_stat[i]);
-			atomic_long_add(v, &vm_numa_stat[i]);
-		}
-#endif
 	preempt_enable();
 }
 #endif
 
 #ifdef CONFIG_NUMA
-void __inc_numa_state(struct zone *zone,
+/* See __count_vm_event comment on why raw_cpu_inc is used. */
+void __count_numa_event(struct zone *zone,
 				 enum numa_stat_item item)
 {
 	struct per_cpu_zonestat __percpu *pzstats = zone->per_cpu_zonestats;
-	u16 __percpu *p = pzstats->vm_numa_stat_diff + item;
-	u16 v;
 
-	v = __this_cpu_inc_return(*p);
-
-	if (unlikely(v > NUMA_STATS_THRESHOLD)) {
-		zone_numa_state_add(v, zone, item);
-		__this_cpu_write(*p, 0);
-	}
+	raw_cpu_inc(pzstats->vm_numa_event[item]);
 }
 
 /*
@@ -1004,15 +937,15 @@ unsigned long sum_zone_node_page_state(int node,
  * Determine the per node value of a numa stat item. To avoid deviation,
  * the per cpu stat number in vm_numa_stat_diff[] is also included.
  */
-unsigned long sum_zone_numa_state(int node,
+unsigned long sum_zone_numa_event_state(int node,
 				 enum numa_stat_item item)
 {
 	struct zone *zones = NODE_DATA(node)->node_zones;
-	int i;
 	unsigned long count = 0;
+	int i;
 
 	for (i = 0; i < MAX_NR_ZONES; i++)
-		count += zone_numa_state_snapshot(zones + i, item);
+		count += zone_numa_event_state(zones + i, item);
 
 	return count;
 }
@@ -1683,9 +1616,9 @@ static void zoneinfo_show_print(struct seq_file *m, pg_data_t *pgdat,
 			   zone_page_state(zone, i));
 
 #ifdef CONFIG_NUMA
-	for (i = 0; i < NR_VM_NUMA_STAT_ITEMS; i++)
+	for (i = 0; i < NR_VM_NUMA_EVENT_ITEMS; i++)
 		seq_printf(m, "\n      %-12s %lu", numa_stat_name(i),
-			   zone_numa_state_snapshot(zone, i));
+			   zone_numa_event_state(zone, i));
 #endif
 
 	seq_printf(m, "\n  pagesets");
@@ -1739,7 +1672,7 @@ static const struct seq_operations zoneinfo_op = {
 };
 
 #define NR_VMSTAT_ITEMS (NR_VM_ZONE_STAT_ITEMS + \
-			 NR_VM_NUMA_STAT_ITEMS + \
+			 NR_VM_NUMA_EVENT_ITEMS + \
 			 NR_VM_NODE_STAT_ITEMS + \
 			 NR_VM_WRITEBACK_STAT_ITEMS + \
 			 (IS_ENABLED(CONFIG_VM_EVENT_COUNTERS) ? \
@@ -1754,6 +1687,7 @@ static void *vmstat_start(struct seq_file *m, loff_t *pos)
 		return NULL;
 
 	BUILD_BUG_ON(ARRAY_SIZE(vmstat_text) < NR_VMSTAT_ITEMS);
+	fold_vm_numa_events();
 	v = kmalloc_array(NR_VMSTAT_ITEMS, sizeof(unsigned long), GFP_KERNEL);
 	m->private = v;
 	if (!v)
@@ -1763,9 +1697,9 @@ static void *vmstat_start(struct seq_file *m, loff_t *pos)
 	v += NR_VM_ZONE_STAT_ITEMS;
 
 #ifdef CONFIG_NUMA
-	for (i = 0; i < NR_VM_NUMA_STAT_ITEMS; i++)
-		v[i] = global_numa_state(i);
-	v += NR_VM_NUMA_STAT_ITEMS;
+	for (i = 0; i < NR_VM_NUMA_EVENT_ITEMS; i++)
+		v[i] = global_numa_event_state(i);
+	v += NR_VM_NUMA_EVENT_ITEMS;
 #endif
 
 	for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++) {
@@ -1868,16 +1802,6 @@ int vmstat_refresh(struct ctl_table *table, int write,
 			err = -EINVAL;
 		}
 	}
-#ifdef CONFIG_NUMA
-	for (i = 0; i < NR_VM_NUMA_STAT_ITEMS; i++) {
-		val = atomic_long_read(&vm_numa_stat[i]);
-		if (val < 0) {
-			pr_warn("%s: %s %ld\n",
-				__func__, numa_stat_name(i), val);
-			err = -EINVAL;
-		}
-	}
-#endif
 	if (err)
 		return err;
 	if (write)
@@ -1926,8 +1850,9 @@ static bool need_update(int cpu)
 		if (memchr_inv(pzstats->vm_stat_diff, 0, NR_VM_ZONE_STAT_ITEMS *
 			       sizeof(pzstats->vm_stat_diff[0])))
 			return true;
+
 #ifdef CONFIG_NUMA
-		if (memchr_inv(pzstats->vm_numa_stat_diff, 0, NR_VM_NUMA_STAT_ITEMS *
+		if (memchr_inv(pzstats->vm_numa_stat_diff, 0, NR_VM_NUMA_EVENT_ITEMS *
 			       sizeof(pzstats->vm_numa_stat_diff[0])))
 			return true;
 #endif
-- 
2.26.2

