Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B32DC433F5
	for <linux-rt-users@archiver.kernel.org>; Fri,  8 Oct 2021 16:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1141E610D1
	for <linux-rt-users@archiver.kernel.org>; Fri,  8 Oct 2021 16:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbhJHQVf (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 8 Oct 2021 12:21:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29142 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229534AbhJHQVd (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 8 Oct 2021 12:21:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633709978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2fuLR+YRtRHAlItHHlAWKLPVpJwI/vzr35BiENgc3FU=;
        b=hnTd7VlckB06dgtw3fVxFka6rS2uXK5p9deHhAKLanuishbFz5I/v2GT6jOh/SR9G6idVG
        OvimlXS033qZT+oOOSMfssXtPTA6wytuJE6NSXGDSbZnfZsc0y3oOxHY+ix7wjSxukETkW
        5HOK4WH2Tzl+QbdSZGK8Co2Jd7z7opI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-577-iAYXLoalNT-ymtLLcP9D8w-1; Fri, 08 Oct 2021 12:19:37 -0400
X-MC-Unique: iAYXLoalNT-ymtLLcP9D8w-1
Received: by mail-wr1-f69.google.com with SMTP id v15-20020adfa1cf000000b00160940b17a2so7710447wrv.19
        for <linux-rt-users@vger.kernel.org>; Fri, 08 Oct 2021 09:19:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2fuLR+YRtRHAlItHHlAWKLPVpJwI/vzr35BiENgc3FU=;
        b=Flr+/RjaCvgSR+N13wYCheACkHfBY1JUskEwTY+1QuRzB127Bz0J6uTcXJnX8mgOgw
         9UGNkG70pLkq1964Zk/EFtex/h8Zl5C8kOQXV2nwLv6vw733bhaaVxdmJpXZmHqP6G2M
         LO+AbXwS3qpn4s2aJXf3UytCWNRhAydZoQglyoiJflSx3vQy1WZgoO8auSICskvZ5I+r
         N4BAzYkjXyzJc1SwgGquciYPni27FH34S/i0zr3d8zvgbvzc+rqlbIhMupY8sM8x2bTu
         oOMaDOYvf2q5uspEGiaXJyYGPYkR669dxZws6xiBBrWp48cMbBygnu2euv1IMFHopWYT
         IyHQ==
X-Gm-Message-State: AOAM533NJGMmPc+7RSlZJObr333PM2ONKwX+FZQSHkzflW92fyJVQlp4
        +O5abVIV9CCzUA0wGDbI9I3AbyeLjIpVWhe7Q+OrZbqsjsfJisO7JeEJ8jEbc+mgpguOPPlm/f1
        bdG5tiXVlTnoGLj4bwr+/Hd2ZfIQ=
X-Received: by 2002:a05:600c:154f:: with SMTP id f15mr4502438wmg.92.1633709975484;
        Fri, 08 Oct 2021 09:19:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxOQOshorop78BPPPmvY4365BmT9Zj6yiWDgdBD9GJTejFjNxj+YIOr2lmIyGa7Qfdh1ZDiUg==
X-Received: by 2002:a05:600c:154f:: with SMTP id f15mr4502412wmg.92.1633709975241;
        Fri, 08 Oct 2021 09:19:35 -0700 (PDT)
Received: from vian.redhat.com ([2a0c:5a80:1d03:b900:c3d1:5974:ce92:3123])
        by smtp.gmail.com with ESMTPSA id f184sm2901753wmf.22.2021.10.08.09.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 09:19:34 -0700 (PDT)
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        frederic@kernel.org, tglx@linutronix.de, peterz@infradead.org,
        mtosatti@redhat.com, nilal@redhat.com, mgorman@suse.de,
        linux-rt-users@vger.kernel.org, vbabka@suse.cz, cl@linux.com,
        paulmck@kernel.org, ppandit@redhat.com,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>
Subject: [RFC 2/3] mm/page_alloc: Access lists in 'struct per_cpu_pages' indirectly
Date:   Fri,  8 Oct 2021 18:19:21 +0200
Message-Id: <20211008161922.942459-3-nsaenzju@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211008161922.942459-1-nsaenzju@redhat.com>
References: <20211008161922.942459-1-nsaenzju@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

In preparation to adding remote pcplists drain support, let's bundle
'struct per_cpu_pages' list heads and page count into a new structure,
'struct pcplists', and have all code access it indirectly through a
pointer. It'll be used by upcoming patches, which will maintain multiple
versions of pcplists and switch the pointer atomically.

free_pcppages_bulk() also gains a new argument, since we want to avoid
dereferencing the pcplists pointer twice per critical section (delimited
by the pagevec local locks).

'struct pcplists' data is marked as __private, so as to make sure nobody
accesses it directly, except for the initialization code. Note that
'struct per_cpu_pages' is used during boot, when no allocation is
possible.

Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
---
 include/linux/mmzone.h | 10 +++++--
 mm/page_alloc.c        | 66 +++++++++++++++++++++++++-----------------
 mm/vmstat.c            |  6 ++--
 3 files changed, 49 insertions(+), 33 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 6a1d79d84675..fb023da9a181 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -358,7 +358,6 @@ enum zone_watermarks {
 
 /* Fields and list protected by pagesets local_lock in page_alloc.c */
 struct per_cpu_pages {
-	int count;		/* number of pages in the list */
 	int high;		/* high watermark, emptying needed */
 	int batch;		/* chunk size for buddy add/remove */
 	short free_factor;	/* batch scaling factor during free */
@@ -366,8 +365,13 @@ struct per_cpu_pages {
 	short expire;		/* When 0, remote pagesets are drained */
 #endif
 
-	/* Lists of pages, one per migrate type stored on the pcp-lists */
-	struct list_head lists[NR_PCP_LISTS];
+	struct pcplists *lp;
+	struct pcplists {
+		/* Number of pages in the lists */
+		int count;
+		/* Lists of pages, one per migrate type stored on the pcp-lists */
+		struct list_head lists[NR_PCP_LISTS];
+	} __private pcplists;
 };
 
 struct per_cpu_zonestat {
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index dd89933503b4..842816f269da 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1438,7 +1438,8 @@ static inline void prefetch_buddy(struct page *page)
  * pinned" detection logic.
  */
 static void free_pcppages_bulk(struct zone *zone, int count,
-					struct per_cpu_pages *pcp)
+			       struct per_cpu_pages *pcp,
+			       struct pcplists *lp)
 {
 	int pindex = 0;
 	int batch_free = 0;
@@ -1453,7 +1454,7 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 	 * Ensure proper count is passed which otherwise would stuck in the
 	 * below while (list_empty(list)) loop.
 	 */
-	count = min(pcp->count, count);
+	count = min(lp->count, count);
 	while (count > 0) {
 		struct list_head *list;
 
@@ -1468,7 +1469,7 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 			batch_free++;
 			if (++pindex == NR_PCP_LISTS)
 				pindex = 0;
-			list = &pcp->lists[pindex];
+			list = &lp->lists[pindex];
 		} while (list_empty(list));
 
 		/* This is the only non-empty list. Free them all. */
@@ -1508,7 +1509,7 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 			}
 		} while (count > 0 && --batch_free && !list_empty(list));
 	}
-	pcp->count -= nr_freed;
+	lp->count -= nr_freed;
 
 	/*
 	 * local_lock_irq held so equivalent to spin_lock_irqsave for
@@ -3069,14 +3070,16 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
  */
 void drain_zone_pages(struct zone *zone, struct per_cpu_pages *pcp)
 {
+	struct pcplists *lp;
 	unsigned long flags;
 	int to_drain, batch;
 
 	local_lock_irqsave(&pagesets.lock, flags);
 	batch = READ_ONCE(pcp->batch);
-	to_drain = min(pcp->count, batch);
+	lp = pcp->lp;
+	to_drain = min(lp->count, batch);
 	if (to_drain > 0)
-		free_pcppages_bulk(zone, to_drain, pcp);
+		free_pcppages_bulk(zone, to_drain, pcp, lp);
 	local_unlock_irqrestore(&pagesets.lock, flags);
 }
 #endif
@@ -3092,12 +3095,14 @@ static void drain_pages_zone(unsigned int cpu, struct zone *zone)
 {
 	unsigned long flags;
 	struct per_cpu_pages *pcp;
+	struct pcplists *lp;
 
 	local_lock_irqsave(&pagesets.lock, flags);
 
 	pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
-	if (pcp->count)
-		free_pcppages_bulk(zone, pcp->count, pcp);
+	lp = pcp->lp;
+	if (lp->count)
+		free_pcppages_bulk(zone, lp->count, pcp, lp);
 
 	local_unlock_irqrestore(&pagesets.lock, flags);
 }
@@ -3158,7 +3163,7 @@ static void drain_local_pages_wq(struct work_struct *work)
  *
  * drain_all_pages() is optimized to only execute on cpus where pcplists are
  * not empty. The check for non-emptiness can however race with a free to
- * pcplist that has not yet increased the pcp->count from 0 to 1. Callers
+ * pcplist that has not yet increased the lp->count from 0 to 1. Callers
  * that need the guarantee that every CPU has drained can disable the
  * optimizing racy check.
  */
@@ -3200,21 +3205,22 @@ static void __drain_all_pages(struct zone *zone, bool force_all_cpus)
 		struct per_cpu_pages *pcp;
 		struct zone *z;
 		bool has_pcps = false;
+		struct pcplists *lp;
 
 		if (force_all_cpus) {
 			/*
-			 * The pcp.count check is racy, some callers need a
+			 * The lp->count check is racy, some callers need a
 			 * guarantee that no cpu is missed.
 			 */
 			has_pcps = true;
 		} else if (zone) {
-			pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
-			if (pcp->count)
+			lp = per_cpu_ptr(zone->per_cpu_pageset, cpu)->lp;
+			if (lp->count)
 				has_pcps = true;
 		} else {
 			for_each_populated_zone(z) {
-				pcp = per_cpu_ptr(z->per_cpu_pageset, cpu);
-				if (pcp->count) {
+				lp = per_cpu_ptr(z->per_cpu_pageset, cpu)->lp;
+				if (lp->count) {
 					has_pcps = true;
 					break;
 				}
@@ -3366,19 +3372,21 @@ static void free_unref_page_commit(struct page *page, unsigned long pfn,
 {
 	struct zone *zone = page_zone(page);
 	struct per_cpu_pages *pcp;
+	struct pcplists *lp;
 	int high;
 	int pindex;
 
 	__count_vm_event(PGFREE);
 	pcp = this_cpu_ptr(zone->per_cpu_pageset);
+	lp = pcp->lp;
 	pindex = order_to_pindex(migratetype, order);
-	list_add(&page->lru, &pcp->lists[pindex]);
-	pcp->count += 1 << order;
+	list_add(&page->lru, &lp->lists[pindex]);
+	lp->count += 1 << order;
 	high = nr_pcp_high(pcp, zone);
-	if (pcp->count >= high) {
+	if (lp->count >= high) {
 		int batch = READ_ONCE(pcp->batch);
 
-		free_pcppages_bulk(zone, nr_pcp_free(pcp, high, batch), pcp);
+		free_pcppages_bulk(zone, nr_pcp_free(pcp, high, batch), pcp, lp);
 	}
 }
 
@@ -3603,9 +3611,11 @@ struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
 			struct per_cpu_pages *pcp)
 {
 	struct list_head *list;
+	struct pcplists *lp;
 	struct page *page;
 
-	list = &pcp->lists[order_to_pindex(migratetype, order)];
+	lp = pcp->lp;
+	list = &lp->lists[order_to_pindex(migratetype, order)];
 
 	do {
 		if (list_empty(list)) {
@@ -3625,14 +3635,14 @@ struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
 					batch, list,
 					migratetype, alloc_flags);
 
-			pcp->count += alloced << order;
+			lp->count += alloced << order;
 			if (unlikely(list_empty(list)))
 				return NULL;
 		}
 
 		page = list_first_entry(list, struct page, lru);
 		list_del(&page->lru);
-		pcp->count -= 1 << order;
+		lp->count -= 1 << order;
 	} while (check_new_pcp(page));
 
 	return page;
@@ -5877,7 +5887,7 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 			continue;
 
 		for_each_online_cpu(cpu)
-			free_pcp += per_cpu_ptr(zone->per_cpu_pageset, cpu)->count;
+			free_pcp += per_cpu_ptr(zone->per_cpu_pageset, cpu)->lp->count;
 	}
 
 	printk("active_anon:%lu inactive_anon:%lu isolated_anon:%lu\n"
@@ -5971,7 +5981,7 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 
 		free_pcp = 0;
 		for_each_online_cpu(cpu)
-			free_pcp += per_cpu_ptr(zone->per_cpu_pageset, cpu)->count;
+			free_pcp += per_cpu_ptr(zone->per_cpu_pageset, cpu)->lp->count;
 
 		show_node(zone);
 		printk(KERN_CONT
@@ -6012,7 +6022,7 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 			K(zone_page_state(zone, NR_MLOCK)),
 			K(zone_page_state(zone, NR_BOUNCE)),
 			K(free_pcp),
-			K(this_cpu_read(zone->per_cpu_pageset->count)),
+			K(this_cpu_read(zone->per_cpu_pageset)->lp->count),
 			K(zone_page_state(zone, NR_FREE_CMA_PAGES)));
 		printk("lowmem_reserve[]:");
 		for (i = 0; i < MAX_NR_ZONES; i++)
@@ -6848,7 +6858,7 @@ static int zone_highsize(struct zone *zone, int batch, int cpu_online)
 
 /*
  * pcp->high and pcp->batch values are related and generally batch is lower
- * than high. They are also related to pcp->count such that count is lower
+ * than high. They are also related to pcp->lp->count such that count is lower
  * than high, and as soon as it reaches high, the pcplist is flushed.
  *
  * However, guaranteeing these relations at all times would require e.g. write
@@ -6856,7 +6866,7 @@ static int zone_highsize(struct zone *zone, int batch, int cpu_online)
  * thus be prone to error and bad for performance. Thus the update only prevents
  * store tearing. Any new users of pcp->batch and pcp->high should ensure they
  * can cope with those fields changing asynchronously, and fully trust only the
- * pcp->count field on the local CPU with interrupts disabled.
+ * pcp->lp->count field on the local CPU with interrupts disabled.
  *
  * mutex_is_locked(&pcp_batch_high_lock) required when calling this function
  * outside of boot time (or some other assurance that no concurrent updaters
@@ -6876,8 +6886,10 @@ static void per_cpu_pages_init(struct per_cpu_pages *pcp, struct per_cpu_zonesta
 	memset(pcp, 0, sizeof(*pcp));
 	memset(pzstats, 0, sizeof(*pzstats));
 
+	pcp->lp = &ACCESS_PRIVATE(pcp, pcplists);
+
 	for (pindex = 0; pindex < NR_PCP_LISTS; pindex++)
-		INIT_LIST_HEAD(&pcp->lists[pindex]);
+		INIT_LIST_HEAD(&pcp->lp->lists[pindex]);
 
 	/*
 	 * Set batch and high values safe for a boot pageset. A true percpu
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 8ce2620344b2..5279d3f34e0b 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -856,7 +856,7 @@ static int refresh_cpu_vm_stats(bool do_pagesets)
 			 * if not then there is nothing to expire.
 			 */
 			if (!__this_cpu_read(pcp->expire) ||
-			       !__this_cpu_read(pcp->count))
+			       !this_cpu_ptr(pcp)->lp->count)
 				continue;
 
 			/*
@@ -870,7 +870,7 @@ static int refresh_cpu_vm_stats(bool do_pagesets)
 			if (__this_cpu_dec_return(pcp->expire))
 				continue;
 
-			if (__this_cpu_read(pcp->count)) {
+			if (this_cpu_ptr(pcp)->lp->count) {
 				drain_zone_pages(zone, this_cpu_ptr(pcp));
 				changes++;
 			}
@@ -1707,7 +1707,7 @@ static void zoneinfo_show_print(struct seq_file *m, pg_data_t *pgdat,
 			   "\n              high:  %i"
 			   "\n              batch: %i",
 			   i,
-			   pcp->count,
+			   pcp->lp->count,
 			   pcp->high,
 			   pcp->batch);
 #ifdef CONFIG_SMP
-- 
2.31.1

