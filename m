Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78029C433EF
	for <linux-rt-users@archiver.kernel.org>; Fri,  8 Oct 2021 16:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FAFC61038
	for <linux-rt-users@archiver.kernel.org>; Fri,  8 Oct 2021 16:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbhJHQVv (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 8 Oct 2021 12:21:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24623 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230240AbhJHQVv (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 8 Oct 2021 12:21:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633709995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L06CeZVaZT/gwZhsOIEkX6vSsXsDjU7RBD3vrAJ3vYE=;
        b=FLpiQ/WlvC5/6rIxFwU+3AwoHCUI4MLKgqk2iwXvUTTPnD31pJyJzvmm2VCrAzfTwoKWy8
        i+BhXfKmLsJMDTOywloBrEgpB3EoZuBipmBfJRAl3I0qWkQ2nyaoV3tJxQg8PVdgxzEWMq
        2iBOO7zZJ1H+vdXewMcnW0cFLhgbhJI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-YYlne-1vN5isg69LYVLwGQ-1; Fri, 08 Oct 2021 12:19:38 -0400
X-MC-Unique: YYlne-1vN5isg69LYVLwGQ-1
Received: by mail-wr1-f71.google.com with SMTP id h11-20020adfa4cb000000b00160c791a550so7531009wrb.6
        for <linux-rt-users@vger.kernel.org>; Fri, 08 Oct 2021 09:19:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L06CeZVaZT/gwZhsOIEkX6vSsXsDjU7RBD3vrAJ3vYE=;
        b=lWGrfe70e0cVYl2DCk7VNU4kI0UqwNiOPh1QMmRvsclpmga1OhzY5nXKDs1oLR6YyG
         6jSZB/1STICBjsqhM8XPyLKG8ZsanEqvHXLl5HS/ZvjRTSdEQIKaJi+whqdRdcnZg4gU
         yZAXgihU7Kx0lGvKODjOyplUgsN7+m5u2DmDHQZXWC1oH0nLmT4S8ICxxd7eXTUyvPtU
         yb8OlUBJrCwlWG8Scn3LUUE9VbM/cKiIR81Km6hPZm4cmXVJn87//ay0r8/UAIemfesc
         szMFkr4r3XwVqPyrm8DukPZxrkMxvhrFkwKN8l9/N75sdM3OLAlBMnWfR3ORCsrhdwfk
         JA9g==
X-Gm-Message-State: AOAM532GWasVf2hkXJX66ki8beeI7gGT0cT+R/IkoeWfgh4hxmZQiQQ0
        JrxhN5iDw9O5Xklzl38YqRivhGRcitDmZoPjnzpRmGi0S7oPfCKwXaHkZG6KVetKwc+2qCgadHh
        9jV//xA77fqR8J+6fswLqGSXz7ck=
X-Received: by 2002:adf:a347:: with SMTP id d7mr5432852wrb.139.1633709976756;
        Fri, 08 Oct 2021 09:19:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzu56ejsI05RU1p5BB9pvX/swKCZbkkrpJVl0uXpJwrS/cA6sAiV/Eyj4pPabDtwM7aHct1Yg==
X-Received: by 2002:adf:a347:: with SMTP id d7mr5432815wrb.139.1633709976480;
        Fri, 08 Oct 2021 09:19:36 -0700 (PDT)
Received: from vian.redhat.com ([2a0c:5a80:1d03:b900:c3d1:5974:ce92:3123])
        by smtp.gmail.com with ESMTPSA id f184sm2901753wmf.22.2021.10.08.09.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 09:19:35 -0700 (PDT)
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        frederic@kernel.org, tglx@linutronix.de, peterz@infradead.org,
        mtosatti@redhat.com, nilal@redhat.com, mgorman@suse.de,
        linux-rt-users@vger.kernel.org, vbabka@suse.cz, cl@linux.com,
        paulmck@kernel.org, ppandit@redhat.com,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>
Subject: [RFC 3/3] mm/page_alloc: Add remote draining support to per-cpu lists
Date:   Fri,  8 Oct 2021 18:19:22 +0200
Message-Id: <20211008161922.942459-4-nsaenzju@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211008161922.942459-1-nsaenzju@redhat.com>
References: <20211008161922.942459-1-nsaenzju@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

page_alloc.c's per-cpu page lists are currently protected using local
locks. While performance savvy, this doesn't allow for remote access to
these structures. CPUs requiring system-wide per-cpu list drains get
around this by scheduling drain work on all CPUs. That said, some select
setups like systems with NOHZ_FULL CPUs, aren't well suited to this, as
they can't handle interruptions of any sort.

To mitigate this, replace the current draining mechanism with one that
allows remotely draining the lists in a lock-less manner. It leverages
the fact that the per-cpu page lists are accessed through indirection,
and that the pointer can be updated atomically. Upon draining we now:

 - Atomically switch the per-cpu lists pointers to ones pointing to
   empty lists.

 - Wait for a grace period so as for all concurrent writers holding the
   old per-cpu lists pointer finish updating them[1].

 - Remotely flush the old lists now that we know nobody holds a
   reference to them. Concurrent access to the drain process is
   protected by a mutex.

RCU guarantees atomicity both while dereferencing the per-cpu lists
pointer and replacing it. It also checks for RCU critical
section/locking correctness, as all writers have to hold their per-cpu
pagesets local lock. Memory ordering on both pointers' data is
guaranteed by synchronize_rcu() and the 'pcpu_drain_mutex'. Also,
synchronize_rcu_expedited() is used to minimize hangs during low memory
situations.

Accesses to the pcplists like the ones in mm/vmstat.c don't require RCU
supervision since they can handle outdated data, but they do use
READ_ONCE() in order to avoid compiler weirdness and be explicit about
the concurrent nature of the pcplists pointer.

As a side effect to all this we now have to promote the spin_lock() in
free_pcppages_bulk() to spin_lock_irqsave() since not all function users
enter with interrupts disabled.

Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>

[1] Note that whatever concurrent writers were doing, the result was
    going to be flushed anyway as the old mechanism disabled preemption
    as the means for serialization, so per-cpu drain works were already
    stepping over whatever was being processed concurrently to the drain
    call.
---
 include/linux/mmzone.h |  18 ++++++-
 mm/page_alloc.c        | 114 ++++++++++++++++++++---------------------
 mm/vmstat.c            |   6 +--
 3 files changed, 75 insertions(+), 63 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index fb023da9a181..c112e7831c54 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -365,13 +365,27 @@ struct per_cpu_pages {
 	short expire;		/* When 0, remote pagesets are drained */
 #endif
 
-	struct pcplists *lp;
+	/*
+	 * Having two pcplists allows us to remotely flush them in a lock-less
+	 * manner: we atomically switch the 'lp' and 'drain' pointers, wait a
+	 * grace period to synchronize against concurrent users of 'lp', and
+	 * safely free whatever is left in 'drain'.
+	 *
+	 * All accesses to 'lp' are protected by local locks, which also serve
+	 * as RCU critical section delimiters. 'lp' should only be dereferenced
+	 * *once* per critical section.
+	 *
+	 * See mm/page_alloc.c's __drain_all_pages() for the bulk of the remote
+	 * drain implementation.
+	 */
+	struct pcplists __rcu *lp;
+	struct pcplists *drain;
 	struct pcplists {
 		/* Number of pages in the lists */
 		int count;
 		/* Lists of pages, one per migrate type stored on the pcp-lists */
 		struct list_head lists[NR_PCP_LISTS];
-	} __private pcplists;
+	} __private pcplists[2];
 };
 
 struct per_cpu_zonestat {
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 842816f269da..d56d06dde66a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -147,13 +147,7 @@ DEFINE_PER_CPU(int, _numa_mem_);		/* Kernel "local memory" node */
 EXPORT_PER_CPU_SYMBOL(_numa_mem_);
 #endif
 
-/* work_structs for global per-cpu drains */
-struct pcpu_drain {
-	struct zone *zone;
-	struct work_struct work;
-};
 static DEFINE_MUTEX(pcpu_drain_mutex);
-static DEFINE_PER_CPU(struct pcpu_drain, pcpu_drain);
 
 #ifdef CONFIG_GCC_PLUGIN_LATENT_ENTROPY
 volatile unsigned long latent_entropy __latent_entropy;
@@ -1448,6 +1442,7 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 	int prefetch_nr = READ_ONCE(pcp->batch);
 	bool isolated_pageblocks;
 	struct page *page, *tmp;
+	unsigned long flags;
 	LIST_HEAD(head);
 
 	/*
@@ -1511,11 +1506,7 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 	}
 	lp->count -= nr_freed;
 
-	/*
-	 * local_lock_irq held so equivalent to spin_lock_irqsave for
-	 * both PREEMPT_RT and non-PREEMPT_RT configurations.
-	 */
-	spin_lock(&zone->lock);
+	spin_lock_irqsave(&zone->lock, flags);
 	isolated_pageblocks = has_isolate_pageblock(zone);
 
 	/*
@@ -1538,7 +1529,7 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 		__free_one_page(page, page_to_pfn(page), zone, order, mt, FPI_NONE);
 		trace_mm_page_pcpu_drain(page, order, mt);
 	}
-	spin_unlock(&zone->lock);
+	spin_unlock_irqrestore(&zone->lock, flags);
 }
 
 static void free_one_page(struct zone *zone,
@@ -3076,7 +3067,7 @@ void drain_zone_pages(struct zone *zone, struct per_cpu_pages *pcp)
 
 	local_lock_irqsave(&pagesets.lock, flags);
 	batch = READ_ONCE(pcp->batch);
-	lp = pcp->lp;
+	lp = rcu_dereference_check(pcp->lp, lockdep_is_held(this_cpu_ptr(&pagesets.lock)));
 	to_drain = min(lp->count, batch);
 	if (to_drain > 0)
 		free_pcppages_bulk(zone, to_drain, pcp, lp);
@@ -3100,7 +3091,7 @@ static void drain_pages_zone(unsigned int cpu, struct zone *zone)
 	local_lock_irqsave(&pagesets.lock, flags);
 
 	pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
-	lp = pcp->lp;
+	lp = rcu_dereference_check(pcp->lp, lockdep_is_held(this_cpu_ptr(&pagesets.lock)));
 	if (lp->count)
 		free_pcppages_bulk(zone, lp->count, pcp, lp);
 
@@ -3139,24 +3130,6 @@ void drain_local_pages(struct zone *zone)
 		drain_pages(cpu);
 }
 
-static void drain_local_pages_wq(struct work_struct *work)
-{
-	struct pcpu_drain *drain;
-
-	drain = container_of(work, struct pcpu_drain, work);
-
-	/*
-	 * drain_all_pages doesn't use proper cpu hotplug protection so
-	 * we can race with cpu offline when the WQ can move this from
-	 * a cpu pinned worker to an unbound one. We can operate on a different
-	 * cpu which is alright but we also have to make sure to not move to
-	 * a different one.
-	 */
-	preempt_disable();
-	drain_local_pages(drain->zone);
-	preempt_enable();
-}
-
 /*
  * The implementation of drain_all_pages(), exposing an extra parameter to
  * drain on all cpus.
@@ -3169,6 +3142,8 @@ static void drain_local_pages_wq(struct work_struct *work)
  */
 static void __drain_all_pages(struct zone *zone, bool force_all_cpus)
 {
+	struct per_cpu_pages *pcp;
+	struct zone *z;
 	int cpu;
 
 	/*
@@ -3177,13 +3152,6 @@ static void __drain_all_pages(struct zone *zone, bool force_all_cpus)
 	 */
 	static cpumask_t cpus_with_pcps;
 
-	/*
-	 * Make sure nobody triggers this path before mm_percpu_wq is fully
-	 * initialized.
-	 */
-	if (WARN_ON_ONCE(!mm_percpu_wq))
-		return;
-
 	/*
 	 * Do not drain if one is already in progress unless it's specific to
 	 * a zone. Such callers are primarily CMA and memory hotplug and need
@@ -3202,8 +3170,6 @@ static void __drain_all_pages(struct zone *zone, bool force_all_cpus)
 	 * disables preemption as part of its processing
 	 */
 	for_each_online_cpu(cpu) {
-		struct per_cpu_pages *pcp;
-		struct zone *z;
 		bool has_pcps = false;
 		struct pcplists *lp;
 
@@ -3214,12 +3180,12 @@ static void __drain_all_pages(struct zone *zone, bool force_all_cpus)
 			 */
 			has_pcps = true;
 		} else if (zone) {
-			lp = per_cpu_ptr(zone->per_cpu_pageset, cpu)->lp;
+			lp = READ_ONCE(per_cpu_ptr(zone->per_cpu_pageset, cpu)->lp);
 			if (lp->count)
 				has_pcps = true;
 		} else {
 			for_each_populated_zone(z) {
-				lp = per_cpu_ptr(z->per_cpu_pageset, cpu)->lp;
+				lp = READ_ONCE(per_cpu_ptr(z->per_cpu_pageset, cpu)->lp);
 				if (lp->count) {
 					has_pcps = true;
 					break;
@@ -3233,16 +3199,37 @@ static void __drain_all_pages(struct zone *zone, bool force_all_cpus)
 			cpumask_clear_cpu(cpu, &cpus_with_pcps);
 	}
 
+	if (!force_all_cpus && cpumask_empty(&cpus_with_pcps))
+	       goto exit;
+
+	for_each_cpu(cpu, &cpus_with_pcps) {
+	       for_each_populated_zone(z) {
+		       if (zone && zone != z)
+			       continue;
+
+		       pcp = per_cpu_ptr(z->per_cpu_pageset, cpu);
+		       pcp->drain = rcu_replace_pointer(pcp->lp, pcp->drain,
+					       mutex_is_locked(&pcpu_drain_mutex));
+	       }
+	}
+
+	synchronize_rcu_expedited();
+
 	for_each_cpu(cpu, &cpus_with_pcps) {
-		struct pcpu_drain *drain = per_cpu_ptr(&pcpu_drain, cpu);
+		for_each_populated_zone(z) {
+			int count;
+
+			pcp = per_cpu_ptr(z->per_cpu_pageset, cpu);
+			count = pcp->drain->count;
+			if (!count)
+			       continue;
 
-		drain->zone = zone;
-		INIT_WORK(&drain->work, drain_local_pages_wq);
-		queue_work_on(cpu, mm_percpu_wq, &drain->work);
+			free_pcppages_bulk(z, count, pcp, pcp->drain);
+			VM_BUG_ON(pcp->drain->count);
+		}
 	}
-	for_each_cpu(cpu, &cpus_with_pcps)
-		flush_work(&per_cpu_ptr(&pcpu_drain, cpu)->work);
 
+exit:
 	mutex_unlock(&pcpu_drain_mutex);
 }
 
@@ -3378,7 +3365,7 @@ static void free_unref_page_commit(struct page *page, unsigned long pfn,
 
 	__count_vm_event(PGFREE);
 	pcp = this_cpu_ptr(zone->per_cpu_pageset);
-	lp = pcp->lp;
+	lp = rcu_dereference_check(pcp->lp, lockdep_is_held(this_cpu_ptr(&pagesets.lock)));
 	pindex = order_to_pindex(migratetype, order);
 	list_add(&page->lru, &lp->lists[pindex]);
 	lp->count += 1 << order;
@@ -3614,7 +3601,7 @@ struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
 	struct pcplists *lp;
 	struct page *page;
 
-	lp = pcp->lp;
+	lp = rcu_dereference_check(pcp->lp, lockdep_is_held(this_cpu_ptr(&pagesets.lock)));
 	list = &lp->lists[order_to_pindex(migratetype, order)];
 
 	do {
@@ -5886,8 +5873,12 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 		if (show_mem_node_skip(filter, zone_to_nid(zone), nodemask))
 			continue;
 
-		for_each_online_cpu(cpu)
-			free_pcp += per_cpu_ptr(zone->per_cpu_pageset, cpu)->lp->count;
+		for_each_online_cpu(cpu) {
+			struct pcplists *lp;
+
+			lp = READ_ONCE(per_cpu_ptr(zone->per_cpu_pageset, cpu)->lp);
+			free_pcp += lp->count;
+		}
 	}
 
 	printk("active_anon:%lu inactive_anon:%lu isolated_anon:%lu\n"
@@ -5980,8 +5971,12 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 			continue;
 
 		free_pcp = 0;
-		for_each_online_cpu(cpu)
-			free_pcp += per_cpu_ptr(zone->per_cpu_pageset, cpu)->lp->count;
+		for_each_online_cpu(cpu) {
+			struct pcplists *lp;
+
+			lp = READ_ONCE(per_cpu_ptr(zone->per_cpu_pageset, cpu)->lp);
+			free_pcp += lp->count;
+		}
 
 		show_node(zone);
 		printk(KERN_CONT
@@ -6022,7 +6017,7 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 			K(zone_page_state(zone, NR_MLOCK)),
 			K(zone_page_state(zone, NR_BOUNCE)),
 			K(free_pcp),
-			K(this_cpu_read(zone->per_cpu_pageset)->lp->count),
+			K(READ_ONCE(this_cpu_ptr(zone->per_cpu_pageset)->lp)->count),
 			K(zone_page_state(zone, NR_FREE_CMA_PAGES)));
 		printk("lowmem_reserve[]:");
 		for (i = 0; i < MAX_NR_ZONES; i++)
@@ -6886,10 +6881,13 @@ static void per_cpu_pages_init(struct per_cpu_pages *pcp, struct per_cpu_zonesta
 	memset(pcp, 0, sizeof(*pcp));
 	memset(pzstats, 0, sizeof(*pzstats));
 
-	pcp->lp = &ACCESS_PRIVATE(pcp, pcplists);
+	pcp->lp = &ACCESS_PRIVATE(pcp, pcplists[0]);
+	pcp->drain = &ACCESS_PRIVATE(pcp, pcplists[1]);
 
-	for (pindex = 0; pindex < NR_PCP_LISTS; pindex++)
+	for (pindex = 0; pindex < NR_PCP_LISTS; pindex++) {
 		INIT_LIST_HEAD(&pcp->lp->lists[pindex]);
+		INIT_LIST_HEAD(&pcp->drain->lists[pindex]);
+	}
 
 	/*
 	 * Set batch and high values safe for a boot pageset. A true percpu
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 5279d3f34e0b..1ffa4fc64a4f 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -856,7 +856,7 @@ static int refresh_cpu_vm_stats(bool do_pagesets)
 			 * if not then there is nothing to expire.
 			 */
 			if (!__this_cpu_read(pcp->expire) ||
-			       !this_cpu_ptr(pcp)->lp->count)
+			       !READ_ONCE(this_cpu_ptr(pcp)->lp)->count)
 				continue;
 
 			/*
@@ -870,7 +870,7 @@ static int refresh_cpu_vm_stats(bool do_pagesets)
 			if (__this_cpu_dec_return(pcp->expire))
 				continue;
 
-			if (this_cpu_ptr(pcp)->lp->count) {
+			if (READ_ONCE(this_cpu_ptr(pcp)->lp)->count) {
 				drain_zone_pages(zone, this_cpu_ptr(pcp));
 				changes++;
 			}
@@ -1707,7 +1707,7 @@ static void zoneinfo_show_print(struct seq_file *m, pg_data_t *pgdat,
 			   "\n              high:  %i"
 			   "\n              batch: %i",
 			   i,
-			   pcp->lp->count,
+			   READ_ONCE(pcp->lp)->count,
 			   pcp->high,
 			   pcp->batch);
 #ifdef CONFIG_SMP
-- 
2.31.1

