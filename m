Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88CF4C433ED
	for <linux-rt-users@archiver.kernel.org>; Thu, 22 Apr 2021 11:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54B0F6145C
	for <linux-rt-users@archiver.kernel.org>; Thu, 22 Apr 2021 11:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236030AbhDVLPj (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 22 Apr 2021 07:15:39 -0400
Received: from outbound-smtp37.blacknight.com ([46.22.139.220]:40731 "EHLO
        outbound-smtp37.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235867AbhDVLPi (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 22 Apr 2021 07:15:38 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp37.blacknight.com (Postfix) with ESMTPS id 402A91947
        for <linux-rt-users@vger.kernel.org>; Thu, 22 Apr 2021 12:15:02 +0100 (IST)
Received: (qmail 9848 invoked from network); 22 Apr 2021 11:15:01 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.17.248])
  by 81.17.254.9 with ESMTPA; 22 Apr 2021 11:15:01 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux-MM <linux-mm@kvack.org>,
        Linux-RT-Users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 1/9] mm/page_alloc: Split per cpu page lists and zone stats
Date:   Thu, 22 Apr 2021 12:14:33 +0100
Message-Id: <20210422111441.24318-2-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210422111441.24318-1-mgorman@techsingularity.net>
References: <20210422111441.24318-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The per-cpu page allocator lists and the per-cpu vmstat deltas are stored
in the same struct per_cpu_pages even though vmstats have no direct impact
on the per-cpu page lists. This is inconsistent because the vmstats for a
node are stored on a dedicated structure. The bigger issue is that the
per_cpu_pages structure is not cache-aligned and stat updates either
cache conflict with adjacent per-cpu lists incurring a runtime cost or
padding is required incurring a memory cost.

This patch splits the per-cpu pagelists and the vmstat deltas into separate
structures. It's mostly a mechanical conversion but some variable renaming
is done to clearly distinguish the per-cpu pages structure (pcp) from
the vmstats (pzstats).

Superficially, this appears to increase the size of the per_cpu_pages
structure but the movement of expire fills a structure hole so there is
no impact overall.

[lkp@intel.com: Check struct per_cpu_zonestat has a non-zero size]
[vbabka@suse.cz: Init zone->per_cpu_zonestats properly]
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 include/linux/mmzone.h | 18 ++++----
 include/linux/vmstat.h |  8 ++--
 mm/page_alloc.c        | 85 ++++++++++++++++++++-----------------
 mm/vmstat.c            | 96 ++++++++++++++++++++++--------------------
 4 files changed, 111 insertions(+), 96 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 47946cec7584..a4393ac27336 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -341,20 +341,21 @@ struct per_cpu_pages {
 	int count;		/* number of pages in the list */
 	int high;		/* high watermark, emptying needed */
 	int batch;		/* chunk size for buddy add/remove */
+#ifdef CONFIG_NUMA
+	int expire;		/* When 0, remote pagesets are drained */
+#endif
 
 	/* Lists of pages, one per migrate type stored on the pcp-lists */
 	struct list_head lists[MIGRATE_PCPTYPES];
 };
 
-struct per_cpu_pageset {
-	struct per_cpu_pages pcp;
-#ifdef CONFIG_NUMA
-	s8 expire;
-	u16 vm_numa_stat_diff[NR_VM_NUMA_STAT_ITEMS];
-#endif
+struct per_cpu_zonestat {
 #ifdef CONFIG_SMP
-	s8 stat_threshold;
 	s8 vm_stat_diff[NR_VM_ZONE_STAT_ITEMS];
+	s8 stat_threshold;
+#endif
+#ifdef CONFIG_NUMA
+	u16 vm_numa_stat_diff[NR_VM_NUMA_STAT_ITEMS];
 #endif
 };
 
@@ -470,7 +471,8 @@ struct zone {
 	int node;
 #endif
 	struct pglist_data	*zone_pgdat;
-	struct per_cpu_pageset __percpu *pageset;
+	struct per_cpu_pages	__percpu *per_cpu_pageset;
+	struct per_cpu_zonestat	__percpu *per_cpu_zonestats;
 	/*
 	 * the high and batch values are copied to individual pagesets for
 	 * faster access
diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index 506d625163a1..1736ea9d24a7 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -163,7 +163,7 @@ static inline unsigned long zone_numa_state_snapshot(struct zone *zone,
 	int cpu;
 
 	for_each_online_cpu(cpu)
-		x += per_cpu_ptr(zone->pageset, cpu)->vm_numa_stat_diff[item];
+		x += per_cpu_ptr(zone->per_cpu_zonestats, cpu)->vm_numa_stat_diff[item];
 
 	return x;
 }
@@ -236,7 +236,7 @@ static inline unsigned long zone_page_state_snapshot(struct zone *zone,
 #ifdef CONFIG_SMP
 	int cpu;
 	for_each_online_cpu(cpu)
-		x += per_cpu_ptr(zone->pageset, cpu)->vm_stat_diff[item];
+		x += per_cpu_ptr(zone->per_cpu_zonestats, cpu)->vm_stat_diff[item];
 
 	if (x < 0)
 		x = 0;
@@ -291,7 +291,7 @@ struct ctl_table;
 int vmstat_refresh(struct ctl_table *, int write, void *buffer, size_t *lenp,
 		loff_t *ppos);
 
-void drain_zonestat(struct zone *zone, struct per_cpu_pageset *);
+void drain_zonestat(struct zone *zone, struct per_cpu_zonestat *);
 
 int calculate_pressure_threshold(struct zone *zone);
 int calculate_normal_threshold(struct zone *zone);
@@ -399,7 +399,7 @@ static inline void cpu_vm_stats_fold(int cpu) { }
 static inline void quiet_vmstat(void) { }
 
 static inline void drain_zonestat(struct zone *zone,
-			struct per_cpu_pageset *pset) { }
+			struct per_cpu_zonestat *pzstats) { }
 #endif		/* CONFIG_SMP */
 
 static inline void __mod_zone_freepage_state(struct zone *zone, int nr_pages,
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 9bf0db982f14..2d6283cab22d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2981,15 +2981,14 @@ void drain_zone_pages(struct zone *zone, struct per_cpu_pages *pcp)
 static void drain_pages_zone(unsigned int cpu, struct zone *zone)
 {
 	unsigned long flags;
-	struct per_cpu_pageset *pset;
 	struct per_cpu_pages *pcp;
 
 	local_irq_save(flags);
-	pset = per_cpu_ptr(zone->pageset, cpu);
 
-	pcp = &pset->pcp;
+	pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
 	if (pcp->count)
 		free_pcppages_bulk(zone, pcp->count, pcp);
+
 	local_irq_restore(flags);
 }
 
@@ -3088,7 +3087,7 @@ static void __drain_all_pages(struct zone *zone, bool force_all_cpus)
 	 * disables preemption as part of its processing
 	 */
 	for_each_online_cpu(cpu) {
-		struct per_cpu_pageset *pcp;
+		struct per_cpu_pages *pcp;
 		struct zone *z;
 		bool has_pcps = false;
 
@@ -3099,13 +3098,13 @@ static void __drain_all_pages(struct zone *zone, bool force_all_cpus)
 			 */
 			has_pcps = true;
 		} else if (zone) {
-			pcp = per_cpu_ptr(zone->pageset, cpu);
-			if (pcp->pcp.count)
+			pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
+			if (pcp->count)
 				has_pcps = true;
 		} else {
 			for_each_populated_zone(z) {
-				pcp = per_cpu_ptr(z->pageset, cpu);
-				if (pcp->pcp.count) {
+				pcp = per_cpu_ptr(z->per_cpu_pageset, cpu);
+				if (pcp->count) {
 					has_pcps = true;
 					break;
 				}
@@ -3235,7 +3234,7 @@ static void free_unref_page_commit(struct page *page, unsigned long pfn)
 		migratetype = MIGRATE_MOVABLE;
 	}
 
-	pcp = &this_cpu_ptr(zone->pageset)->pcp;
+	pcp = this_cpu_ptr(zone->per_cpu_pageset);
 	list_add(&page->lru, &pcp->lists[migratetype]);
 	pcp->count++;
 	if (pcp->count >= READ_ONCE(pcp->high))
@@ -3451,7 +3450,7 @@ static struct page *rmqueue_pcplist(struct zone *preferred_zone,
 	unsigned long flags;
 
 	local_irq_save(flags);
-	pcp = &this_cpu_ptr(zone->pageset)->pcp;
+	pcp = this_cpu_ptr(zone->per_cpu_pageset);
 	list = &pcp->lists[migratetype];
 	page = __rmqueue_pcplist(zone,  migratetype, alloc_flags, pcp, list);
 	if (page) {
@@ -5054,7 +5053,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 
 	/* Attempt the batch allocation */
 	local_irq_save(flags);
-	pcp = &this_cpu_ptr(zone->pageset)->pcp;
+	pcp = this_cpu_ptr(zone->per_cpu_pageset);
 	pcp_list = &pcp->lists[ac.migratetype];
 
 	while (nr_populated < nr_pages) {
@@ -5667,7 +5666,7 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 			continue;
 
 		for_each_online_cpu(cpu)
-			free_pcp += per_cpu_ptr(zone->pageset, cpu)->pcp.count;
+			free_pcp += per_cpu_ptr(zone->per_cpu_pageset, cpu)->count;
 	}
 
 	printk("active_anon:%lu inactive_anon:%lu isolated_anon:%lu\n"
@@ -5759,7 +5758,7 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 
 		free_pcp = 0;
 		for_each_online_cpu(cpu)
-			free_pcp += per_cpu_ptr(zone->pageset, cpu)->pcp.count;
+			free_pcp += per_cpu_ptr(zone->per_cpu_pageset, cpu)->count;
 
 		show_node(zone);
 		printk(KERN_CONT
@@ -5800,7 +5799,7 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 			K(zone_page_state(zone, NR_MLOCK)),
 			K(zone_page_state(zone, NR_BOUNCE)),
 			K(free_pcp),
-			K(this_cpu_read(zone->pageset->pcp.count)),
+			K(this_cpu_read(zone->per_cpu_pageset->count)),
 			K(zone_page_state(zone, NR_FREE_CMA_PAGES)));
 		printk("lowmem_reserve[]:");
 		for (i = 0; i < MAX_NR_ZONES; i++)
@@ -6127,11 +6126,12 @@ static void build_zonelists(pg_data_t *pgdat)
  * not check if the processor is online before following the pageset pointer.
  * Other parts of the kernel may not check if the zone is available.
  */
-static void pageset_init(struct per_cpu_pageset *p);
+static void per_cpu_pages_init(struct per_cpu_pages *pcp, struct per_cpu_zonestat *pzstats);
 /* These effectively disable the pcplists in the boot pageset completely */
 #define BOOT_PAGESET_HIGH	0
 #define BOOT_PAGESET_BATCH	1
-static DEFINE_PER_CPU(struct per_cpu_pageset, boot_pageset);
+static DEFINE_PER_CPU(struct per_cpu_pages, boot_pageset);
+static DEFINE_PER_CPU(struct per_cpu_zonestat, boot_zonestats);
 static DEFINE_PER_CPU(struct per_cpu_nodestat, boot_nodestats);
 
 static void __build_all_zonelists(void *data)
@@ -6198,7 +6198,7 @@ build_all_zonelists_init(void)
 	 * (a chicken-egg dilemma).
 	 */
 	for_each_possible_cpu(cpu)
-		pageset_init(&per_cpu(boot_pageset, cpu));
+		per_cpu_pages_init(&per_cpu(boot_pageset, cpu), &per_cpu(boot_zonestats, cpu));
 
 	mminit_verify_zonelist();
 	cpuset_init_current_mems_allowed();
@@ -6576,14 +6576,13 @@ static void pageset_update(struct per_cpu_pages *pcp, unsigned long high,
 	WRITE_ONCE(pcp->high, high);
 }
 
-static void pageset_init(struct per_cpu_pageset *p)
+static void per_cpu_pages_init(struct per_cpu_pages *pcp, struct per_cpu_zonestat *pzstats)
 {
-	struct per_cpu_pages *pcp;
 	int migratetype;
 
-	memset(p, 0, sizeof(*p));
+	memset(pcp, 0, sizeof(*pcp));
+	memset(pzstats, 0, sizeof(*pzstats));
 
-	pcp = &p->pcp;
 	for (migratetype = 0; migratetype < MIGRATE_PCPTYPES; migratetype++)
 		INIT_LIST_HEAD(&pcp->lists[migratetype]);
 
@@ -6600,12 +6599,12 @@ static void pageset_init(struct per_cpu_pageset *p)
 static void __zone_set_pageset_high_and_batch(struct zone *zone, unsigned long high,
 		unsigned long batch)
 {
-	struct per_cpu_pageset *p;
+	struct per_cpu_pages *pcp;
 	int cpu;
 
 	for_each_possible_cpu(cpu) {
-		p = per_cpu_ptr(zone->pageset, cpu);
-		pageset_update(&p->pcp, high, batch);
+		pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
+		pageset_update(pcp, high, batch);
 	}
 }
 
@@ -6640,13 +6639,20 @@ static void zone_set_pageset_high_and_batch(struct zone *zone)
 
 void __meminit setup_zone_pageset(struct zone *zone)
 {
-	struct per_cpu_pageset *p;
 	int cpu;
 
-	zone->pageset = alloc_percpu(struct per_cpu_pageset);
+	/* Size may be 0 on !SMP && !NUMA */
+	if (sizeof(struct per_cpu_zonestat) > 0)
+		zone->per_cpu_zonestats = alloc_percpu(struct per_cpu_zonestat);
+
+	zone->per_cpu_pageset = alloc_percpu(struct per_cpu_pages);
 	for_each_possible_cpu(cpu) {
-		p = per_cpu_ptr(zone->pageset, cpu);
-		pageset_init(p);
+		struct per_cpu_pages *pcp;
+		struct per_cpu_zonestat *pzstats;
+
+		pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
+		pzstats = per_cpu_ptr(zone->per_cpu_zonestats, cpu);
+		per_cpu_pages_init(pcp, pzstats);
 	}
 
 	zone_set_pageset_high_and_batch(zone);
@@ -6673,9 +6679,9 @@ void __init setup_per_cpu_pageset(void)
 	 * the nodes these zones are associated with.
 	 */
 	for_each_possible_cpu(cpu) {
-		struct per_cpu_pageset *pcp = &per_cpu(boot_pageset, cpu);
-		memset(pcp->vm_numa_stat_diff, 0,
-		       sizeof(pcp->vm_numa_stat_diff));
+		struct per_cpu_zonestat *pzstats = &per_cpu(boot_zonestats, cpu);
+		memset(pzstats->vm_numa_stat_diff, 0,
+		       sizeof(pzstats->vm_numa_stat_diff));
 	}
 #endif
 
@@ -6691,7 +6697,8 @@ static __meminit void zone_pcp_init(struct zone *zone)
 	 * relies on the ability of the linker to provide the
 	 * offset of a (static) per cpu variable into the per cpu area.
 	 */
-	zone->pageset = &boot_pageset;
+	zone->per_cpu_pageset = &boot_pageset;
+	zone->per_cpu_zonestats = &boot_zonestats;
 	zone->pageset_high = BOOT_PAGESET_HIGH;
 	zone->pageset_batch = BOOT_PAGESET_BATCH;
 
@@ -8953,15 +8960,17 @@ void zone_pcp_enable(struct zone *zone)
 void zone_pcp_reset(struct zone *zone)
 {
 	int cpu;
-	struct per_cpu_pageset *pset;
+	struct per_cpu_zonestat *pzstats;
 
-	if (zone->pageset != &boot_pageset) {
+	if (zone->per_cpu_pageset != &boot_pageset) {
 		for_each_online_cpu(cpu) {
-			pset = per_cpu_ptr(zone->pageset, cpu);
-			drain_zonestat(zone, pset);
+			pzstats = per_cpu_ptr(zone->per_cpu_zonestats, cpu);
+			drain_zonestat(zone, pzstats);
 		}
-		free_percpu(zone->pageset);
-		zone->pageset = &boot_pageset;
+		free_percpu(zone->per_cpu_pageset);
+		free_percpu(zone->per_cpu_zonestats);
+		zone->per_cpu_pageset = &boot_pageset;
+		zone->per_cpu_zonestats = &boot_zonestats;
 	}
 }
 
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 74b2c374b86c..8a8f1a26b231 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -44,7 +44,7 @@ static void zero_zone_numa_counters(struct zone *zone)
 	for (item = 0; item < NR_VM_NUMA_STAT_ITEMS; item++) {
 		atomic_long_set(&zone->vm_numa_stat[item], 0);
 		for_each_online_cpu(cpu)
-			per_cpu_ptr(zone->pageset, cpu)->vm_numa_stat_diff[item]
+			per_cpu_ptr(zone->per_cpu_zonestats, cpu)->vm_numa_stat_diff[item]
 						= 0;
 	}
 }
@@ -266,7 +266,7 @@ void refresh_zone_stat_thresholds(void)
 		for_each_online_cpu(cpu) {
 			int pgdat_threshold;
 
-			per_cpu_ptr(zone->pageset, cpu)->stat_threshold
+			per_cpu_ptr(zone->per_cpu_zonestats, cpu)->stat_threshold
 							= threshold;
 
 			/* Base nodestat threshold on the largest populated zone. */
@@ -303,7 +303,7 @@ void set_pgdat_percpu_threshold(pg_data_t *pgdat,
 
 		threshold = (*calculate_pressure)(zone);
 		for_each_online_cpu(cpu)
-			per_cpu_ptr(zone->pageset, cpu)->stat_threshold
+			per_cpu_ptr(zone->per_cpu_zonestats, cpu)->stat_threshold
 							= threshold;
 	}
 }
@@ -316,7 +316,7 @@ void set_pgdat_percpu_threshold(pg_data_t *pgdat,
 void __mod_zone_page_state(struct zone *zone, enum zone_stat_item item,
 			   long delta)
 {
-	struct per_cpu_pageset __percpu *pcp = zone->pageset;
+	struct per_cpu_zonestat __percpu *pcp = zone->per_cpu_zonestats;
 	s8 __percpu *p = pcp->vm_stat_diff + item;
 	long x;
 	long t;
@@ -389,7 +389,7 @@ EXPORT_SYMBOL(__mod_node_page_state);
  */
 void __inc_zone_state(struct zone *zone, enum zone_stat_item item)
 {
-	struct per_cpu_pageset __percpu *pcp = zone->pageset;
+	struct per_cpu_zonestat __percpu *pcp = zone->per_cpu_zonestats;
 	s8 __percpu *p = pcp->vm_stat_diff + item;
 	s8 v, t;
 
@@ -435,7 +435,7 @@ EXPORT_SYMBOL(__inc_node_page_state);
 
 void __dec_zone_state(struct zone *zone, enum zone_stat_item item)
 {
-	struct per_cpu_pageset __percpu *pcp = zone->pageset;
+	struct per_cpu_zonestat __percpu *pcp = zone->per_cpu_zonestats;
 	s8 __percpu *p = pcp->vm_stat_diff + item;
 	s8 v, t;
 
@@ -495,7 +495,7 @@ EXPORT_SYMBOL(__dec_node_page_state);
 static inline void mod_zone_state(struct zone *zone,
        enum zone_stat_item item, long delta, int overstep_mode)
 {
-	struct per_cpu_pageset __percpu *pcp = zone->pageset;
+	struct per_cpu_zonestat __percpu *pcp = zone->per_cpu_zonestats;
 	s8 __percpu *p = pcp->vm_stat_diff + item;
 	long o, n, t, z;
 
@@ -781,19 +781,20 @@ static int refresh_cpu_vm_stats(bool do_pagesets)
 	int changes = 0;
 
 	for_each_populated_zone(zone) {
-		struct per_cpu_pageset __percpu *p = zone->pageset;
+		struct per_cpu_zonestat __percpu *pzstats = zone->per_cpu_zonestats;
+		struct per_cpu_pages __percpu *pcp = zone->per_cpu_pageset;
 
 		for (i = 0; i < NR_VM_ZONE_STAT_ITEMS; i++) {
 			int v;
 
-			v = this_cpu_xchg(p->vm_stat_diff[i], 0);
+			v = this_cpu_xchg(pzstats->vm_stat_diff[i], 0);
 			if (v) {
 
 				atomic_long_add(v, &zone->vm_stat[i]);
 				global_zone_diff[i] += v;
 #ifdef CONFIG_NUMA
 				/* 3 seconds idle till flush */
-				__this_cpu_write(p->expire, 3);
+				__this_cpu_write(pcp->expire, 3);
 #endif
 			}
 		}
@@ -801,12 +802,12 @@ static int refresh_cpu_vm_stats(bool do_pagesets)
 		for (i = 0; i < NR_VM_NUMA_STAT_ITEMS; i++) {
 			int v;
 
-			v = this_cpu_xchg(p->vm_numa_stat_diff[i], 0);
+			v = this_cpu_xchg(pzstats->vm_numa_stat_diff[i], 0);
 			if (v) {
 
 				atomic_long_add(v, &zone->vm_numa_stat[i]);
 				global_numa_diff[i] += v;
-				__this_cpu_write(p->expire, 3);
+				__this_cpu_write(pcp->expire, 3);
 			}
 		}
 
@@ -819,23 +820,23 @@ static int refresh_cpu_vm_stats(bool do_pagesets)
 			 * Check if there are pages remaining in this pageset
 			 * if not then there is nothing to expire.
 			 */
-			if (!__this_cpu_read(p->expire) ||
-			       !__this_cpu_read(p->pcp.count))
+			if (!__this_cpu_read(pcp->expire) ||
+			       !__this_cpu_read(pcp->count))
 				continue;
 
 			/*
 			 * We never drain zones local to this processor.
 			 */
 			if (zone_to_nid(zone) == numa_node_id()) {
-				__this_cpu_write(p->expire, 0);
+				__this_cpu_write(pcp->expire, 0);
 				continue;
 			}
 
-			if (__this_cpu_dec_return(p->expire))
+			if (__this_cpu_dec_return(pcp->expire))
 				continue;
 
-			if (__this_cpu_read(p->pcp.count)) {
-				drain_zone_pages(zone, this_cpu_ptr(&p->pcp));
+			if (__this_cpu_read(pcp->count)) {
+				drain_zone_pages(zone, this_cpu_ptr(pcp));
 				changes++;
 			}
 		}
@@ -882,27 +883,27 @@ void cpu_vm_stats_fold(int cpu)
 	int global_node_diff[NR_VM_NODE_STAT_ITEMS] = { 0, };
 
 	for_each_populated_zone(zone) {
-		struct per_cpu_pageset *p;
+		struct per_cpu_zonestat *pzstats;
 
-		p = per_cpu_ptr(zone->pageset, cpu);
+		pzstats = per_cpu_ptr(zone->per_cpu_zonestats, cpu);
 
 		for (i = 0; i < NR_VM_ZONE_STAT_ITEMS; i++)
-			if (p->vm_stat_diff[i]) {
+			if (pzstats->vm_stat_diff[i]) {
 				int v;
 
-				v = p->vm_stat_diff[i];
-				p->vm_stat_diff[i] = 0;
+				v = pzstats->vm_stat_diff[i];
+				pzstats->vm_stat_diff[i] = 0;
 				atomic_long_add(v, &zone->vm_stat[i]);
 				global_zone_diff[i] += v;
 			}
 
 #ifdef CONFIG_NUMA
 		for (i = 0; i < NR_VM_NUMA_STAT_ITEMS; i++)
-			if (p->vm_numa_stat_diff[i]) {
+			if (pzstats->vm_numa_stat_diff[i]) {
 				int v;
 
-				v = p->vm_numa_stat_diff[i];
-				p->vm_numa_stat_diff[i] = 0;
+				v = pzstats->vm_numa_stat_diff[i];
+				pzstats->vm_numa_stat_diff[i] = 0;
 				atomic_long_add(v, &zone->vm_numa_stat[i]);
 				global_numa_diff[i] += v;
 			}
@@ -936,24 +937,24 @@ void cpu_vm_stats_fold(int cpu)
  * this is only called if !populated_zone(zone), which implies no other users of
  * pset->vm_stat_diff[] exsist.
  */
-void drain_zonestat(struct zone *zone, struct per_cpu_pageset *pset)
+void drain_zonestat(struct zone *zone, struct per_cpu_zonestat *pzstats)
 {
 	int i;
 
 	for (i = 0; i < NR_VM_ZONE_STAT_ITEMS; i++)
-		if (pset->vm_stat_diff[i]) {
-			int v = pset->vm_stat_diff[i];
-			pset->vm_stat_diff[i] = 0;
+		if (pzstats->vm_stat_diff[i]) {
+			int v = pzstats->vm_stat_diff[i];
+			pzstats->vm_stat_diff[i] = 0;
 			atomic_long_add(v, &zone->vm_stat[i]);
 			atomic_long_add(v, &vm_zone_stat[i]);
 		}
 
 #ifdef CONFIG_NUMA
 	for (i = 0; i < NR_VM_NUMA_STAT_ITEMS; i++)
-		if (pset->vm_numa_stat_diff[i]) {
-			int v = pset->vm_numa_stat_diff[i];
+		if (pzstats->vm_numa_stat_diff[i]) {
+			int v = pzstats->vm_numa_stat_diff[i];
 
-			pset->vm_numa_stat_diff[i] = 0;
+			pzstats->vm_numa_stat_diff[i] = 0;
 			atomic_long_add(v, &zone->vm_numa_stat[i]);
 			atomic_long_add(v, &vm_numa_stat[i]);
 		}
@@ -965,8 +966,8 @@ void drain_zonestat(struct zone *zone, struct per_cpu_pageset *pset)
 void __inc_numa_state(struct zone *zone,
 				 enum numa_stat_item item)
 {
-	struct per_cpu_pageset __percpu *pcp = zone->pageset;
-	u16 __percpu *p = pcp->vm_numa_stat_diff + item;
+	struct per_cpu_zonestat __percpu *pzstats = zone->per_cpu_zonestats;
+	u16 __percpu *p = pzstats->vm_numa_stat_diff + item;
 	u16 v;
 
 	v = __this_cpu_inc_return(*p);
@@ -1685,21 +1686,23 @@ static void zoneinfo_show_print(struct seq_file *m, pg_data_t *pgdat,
 
 	seq_printf(m, "\n  pagesets");
 	for_each_online_cpu(i) {
-		struct per_cpu_pageset *pageset;
+		struct per_cpu_pages *pcp;
+		struct per_cpu_zonestat *pzstats;
 
-		pageset = per_cpu_ptr(zone->pageset, i);
+		pcp = per_cpu_ptr(zone->per_cpu_pageset, i);
+		pzstats = per_cpu_ptr(zone->per_cpu_zonestats, i);
 		seq_printf(m,
 			   "\n    cpu: %i"
 			   "\n              count: %i"
 			   "\n              high:  %i"
 			   "\n              batch: %i",
 			   i,
-			   pageset->pcp.count,
-			   pageset->pcp.high,
-			   pageset->pcp.batch);
+			   pcp->count,
+			   pcp->high,
+			   pcp->batch);
 #ifdef CONFIG_SMP
 		seq_printf(m, "\n  vm stats threshold: %d",
-				pageset->stat_threshold);
+				pzstats->stat_threshold);
 #endif
 	}
 	seq_printf(m,
@@ -1910,17 +1913,18 @@ static bool need_update(int cpu)
 	struct zone *zone;
 
 	for_each_populated_zone(zone) {
-		struct per_cpu_pageset *p = per_cpu_ptr(zone->pageset, cpu);
+		struct per_cpu_zonestat *pzstats = per_cpu_ptr(zone->per_cpu_zonestats, cpu);
 		struct per_cpu_nodestat *n;
+
 		/*
 		 * The fast way of checking if there are any vmstat diffs.
 		 */
-		if (memchr_inv(p->vm_stat_diff, 0, NR_VM_ZONE_STAT_ITEMS *
-			       sizeof(p->vm_stat_diff[0])))
+		if (memchr_inv(pzstats->vm_stat_diff, 0, NR_VM_ZONE_STAT_ITEMS *
+			       sizeof(pzstats->vm_stat_diff[0])))
 			return true;
 #ifdef CONFIG_NUMA
-		if (memchr_inv(p->vm_numa_stat_diff, 0, NR_VM_NUMA_STAT_ITEMS *
-			       sizeof(p->vm_numa_stat_diff[0])))
+		if (memchr_inv(pzstats->vm_numa_stat_diff, 0, NR_VM_NUMA_STAT_ITEMS *
+			       sizeof(pzstats->vm_numa_stat_diff[0])))
 			return true;
 #endif
 		if (last_pgdat == zone->zone_pgdat)
-- 
2.26.2

