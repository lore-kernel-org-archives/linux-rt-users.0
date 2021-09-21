Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C83C433F5
	for <linux-rt-users@archiver.kernel.org>; Tue, 21 Sep 2021 16:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C259B6109E
	for <linux-rt-users@archiver.kernel.org>; Tue, 21 Sep 2021 16:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234391AbhIUQPR (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 21 Sep 2021 12:15:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59317 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234302AbhIUQPL (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 21 Sep 2021 12:15:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632240822;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gPP7p4f7+ZBDSuJ4Fq24/tKP4H9YfAjznqdigXY0rzo=;
        b=Yqj5R0yPJERdChoAY7vFiAkRQ9ZYagzSveQT7bKU4I4geHiUmJP13r/6v3GxVcLoihCQkn
        NRNwXGlESReLv/WAuVygKhSTUtmnoLNiv3aQL03w1oJc85IGNepIbrPUT3VktUr/k+3H09
        IaisiNjNPb0tGkZ9wFKxQtFjRX3IeIE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596-hWVitI2xNNuvjT72iFjE2Q-1; Tue, 21 Sep 2021 12:13:40 -0400
X-MC-Unique: hWVitI2xNNuvjT72iFjE2Q-1
Received: by mail-wr1-f72.google.com with SMTP id f7-20020a5d50c7000000b0015e288741a4so9260201wrt.9
        for <linux-rt-users@vger.kernel.org>; Tue, 21 Sep 2021 09:13:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gPP7p4f7+ZBDSuJ4Fq24/tKP4H9YfAjznqdigXY0rzo=;
        b=5l3kd12SqqdPY6A/1MBKvGkynZyWGvFx3xxlxYUNmm64ojGiGNWsflsT98frjoQTWC
         amStYJdVYW7LcnnlhnT/J1QwRX0cBtGi5dJYg6nnj9CoWX3JIwNdxylZT48DE0yHPTV+
         Dn+j/JsCIZb99FPq4H5VhjpoIxMbH3QWCrjpFYz7lD7Cd0X5CFO7Z6BAPRjk+jF46Uiy
         u7s8vI1eln0/zVt+tDb2Nzn7ISXuiyCjTgGUKN6eHal+0ST5xwFDWxu/WOrI7WkbDICq
         66zd4uKlrtQzn3HK9ahdC0RZKnykRdTEAov09Ptx/9RoHcYhz8Xo06aiBpQ32aUdhj0P
         daTg==
X-Gm-Message-State: AOAM530vU04KddBDcVToVAAC0QlLmeQvdyzBU5NXwb+o0VvMZTiAulKJ
        cdLHjSEeErLKvMwRwBXhI/KHof8mkuPiPFbILM6YqN+OY2jfmJYfZ0wnd8n8NbuYfYk2yxEDcf/
        9sYL6TxoEyYIt7sowEwBATsA+j6o=
X-Received: by 2002:a05:600c:4105:: with SMTP id j5mr5481456wmi.138.1632240819168;
        Tue, 21 Sep 2021 09:13:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzOTu0J3jQPhjB0rCNk6fDnFpnh+/g5dnPXrEPxVjKH2eCKCxgBKKRAmpV4rD/xGG21/HWfXg==
X-Received: by 2002:a05:600c:4105:: with SMTP id j5mr5481424wmi.138.1632240818845;
        Tue, 21 Sep 2021 09:13:38 -0700 (PDT)
Received: from vian.redhat.com ([2a0c:5a80:1d03:b900:c3d1:5974:ce92:3123])
        by smtp.gmail.com with ESMTPSA id t1sm19786477wrz.39.2021.09.21.09.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 09:13:38 -0700 (PDT)
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     akpm@linux-foundation.org, frederic@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, cl@linux.com, peterz@infradead.org,
        juri.lelli@redhat.com, mingo@redhat.com, mtosatti@redhat.com,
        nilal@redhat.com, mgorman@suse.de, ppandit@redhat.com,
        williams@redhat.com, bigeasy@linutronix.de,
        anna-maria@linutronix.de, linux-rt-users@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>
Subject: [PATCH 4/6] mm/page_alloc: Introduce alternative per-cpu list locking
Date:   Tue, 21 Sep 2021 18:13:22 +0200
Message-Id: <20210921161323.607817-5-nsaenzju@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210921161323.607817-1-nsaenzju@redhat.com>
References: <20210921161323.607817-1-nsaenzju@redhat.com>
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

To mitigate this, introduce an alternative locking scheme using
spinlocks that will permit remotely accessing these per-cpu page lists.
It's disabled by default, with no functional change to regular users,
and enabled through the 'remote_pcpu_cache_access' static key. Upcoming
patches will make use of this static key.

This is based on previous work by Thomas Gleixner, Anna-Maria Gleixner,
and Sebastian Andrzej Siewior[1].

[1] https://patchwork.kernel.org/project/linux-mm/patch/20190424111208.24459-3-bigeasy@linutronix.de/
Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
---
 mm/page_alloc.c | 87 ++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 68 insertions(+), 19 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3b610b05d9b8..3244eb2ab51b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -123,10 +123,12 @@ static DEFINE_MUTEX(pcp_batch_high_lock);
 #define MIN_PERCPU_PAGELIST_HIGH_FRACTION (8)
 
 struct pagesets {
-	local_lock_t lock;
+	local_lock_t local;
+	spinlock_t spin;
 };
 static DEFINE_PER_CPU(struct pagesets, pagesets) = {
-	.lock = INIT_LOCAL_LOCK(lock),
+	.local = INIT_LOCAL_LOCK(pagesets.local),
+	.spin = __SPIN_LOCK_UNLOCKED(pagesets.spin),
 };
 
 #ifdef CONFIG_USE_PERCPU_NUMA_NODE_ID
@@ -207,6 +209,52 @@ static int __init early_init_on_free(char *buf)
 }
 early_param("init_on_free", early_init_on_free);
 
+static inline void pagesets_lock_irqsave(struct pagesets *locks,
+					 unsigned long *flagsp)
+{
+	if (static_branch_unlikely(&remote_pcpu_cache_access)) {
+		/* Avoid migration between this_cpu_ptr() and spin_lock_irqsave() */
+		migrate_disable();
+		spin_lock_irqsave(this_cpu_ptr(&locks->spin), *flagsp);
+	} else {
+		local_lock_irqsave(&locks->local, *flagsp);
+	}
+}
+
+/*
+ * pagesets_lock_irqsave_cpu() should only be used from remote CPUs when
+ * 'remote_pcpu_cache_access' is enabled or the target CPU is dead. Otherwise,
+ * it can still be called on the local CPU with migration disabled.
+ */
+static inline void pagesets_lock_irqsave_cpu(struct pagesets *locks,
+					     unsigned long *flagsp, int cpu)
+{
+	if (static_branch_unlikely(&remote_pcpu_cache_access))
+		spin_lock_irqsave(per_cpu_ptr(&locks->spin, cpu), *flagsp);
+	else
+		local_lock_irqsave(&locks->local, *flagsp);
+}
+
+static inline void pagesets_unlock_irqrestore(struct pagesets *locks,
+					      unsigned long flags)
+{
+	if (static_branch_unlikely(&remote_pcpu_cache_access)) {
+		spin_unlock_irqrestore(this_cpu_ptr(&locks->spin), flags);
+		migrate_enable();
+	} else {
+		local_unlock_irqrestore(&locks->local, flags);
+	}
+}
+
+static inline void pagesets_unlock_irqrestore_cpu(struct pagesets *locks,
+						  unsigned long flags, int cpu)
+{
+	if (static_branch_unlikely(&remote_pcpu_cache_access))
+		spin_unlock_irqrestore(per_cpu_ptr(&locks->spin, cpu), flags);
+	else
+		local_unlock_irqrestore(&locks->local, flags);
+}
+
 /*
  * A cached value of the page's pageblock's migratetype, used when the page is
  * put on a pcplist. Used to avoid the pageblock migratetype lookup when
@@ -3064,12 +3112,12 @@ void drain_zone_pages(struct zone *zone, struct per_cpu_pages *pcp)
 	unsigned long flags;
 	int to_drain, batch;
 
-	local_lock_irqsave(&pagesets.lock, flags);
+	pagesets_lock_irqsave(&pagesets, &flags);
 	batch = READ_ONCE(pcp->batch);
 	to_drain = min(pcp->count, batch);
 	if (to_drain > 0)
 		free_pcppages_bulk(zone, to_drain, pcp);
-	local_unlock_irqrestore(&pagesets.lock, flags);
+	pagesets_unlock_irqrestore(&pagesets, flags);
 }
 #endif
 
@@ -3077,21 +3125,22 @@ void drain_zone_pages(struct zone *zone, struct per_cpu_pages *pcp)
  * Drain pcplists of the indicated processor and zone.
  *
  * The processor must either be the current processor and the
- * thread pinned to the current processor or a processor that
- * is not online.
+ * thread pinned to the current processor, a processor that
+ * is not online, or a remote processor while 'remote_pcpu_cache_access' is
+ * enabled.
  */
 static void drain_pages_zone(unsigned int cpu, struct zone *zone)
 {
 	unsigned long flags;
 	struct per_cpu_pages *pcp;
 
-	local_lock_irqsave(&pagesets.lock, flags);
+	pagesets_lock_irqsave_cpu(&pagesets, &flags, cpu);
 
 	pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
 	if (pcp->count)
 		free_pcppages_bulk(zone, pcp->count, pcp);
 
-	local_unlock_irqrestore(&pagesets.lock, flags);
+	pagesets_unlock_irqrestore_cpu(&pagesets, flags, cpu);
 }
 
 /*
@@ -3402,9 +3451,9 @@ void free_unref_page(struct page *page, unsigned int order)
 		migratetype = MIGRATE_MOVABLE;
 	}
 
-	local_lock_irqsave(&pagesets.lock, flags);
+	pagesets_lock_irqsave(&pagesets, &flags);
 	free_unref_page_commit(page, pfn, migratetype, order);
-	local_unlock_irqrestore(&pagesets.lock, flags);
+	pagesets_unlock_irqrestore(&pagesets, flags);
 }
 
 /*
@@ -3439,7 +3488,7 @@ void free_unref_page_list(struct list_head *list)
 		set_page_private(page, pfn);
 	}
 
-	local_lock_irqsave(&pagesets.lock, flags);
+	pagesets_lock_irqsave(&pagesets, &flags);
 	list_for_each_entry_safe(page, next, list, lru) {
 		pfn = page_private(page);
 		set_page_private(page, 0);
@@ -3460,12 +3509,12 @@ void free_unref_page_list(struct list_head *list)
 		 * a large list of pages to free.
 		 */
 		if (++batch_count == SWAP_CLUSTER_MAX) {
-			local_unlock_irqrestore(&pagesets.lock, flags);
+			pagesets_unlock_irqrestore(&pagesets, flags);
 			batch_count = 0;
-			local_lock_irqsave(&pagesets.lock, flags);
+			pagesets_lock_irqsave(&pagesets, &flags);
 		}
 	}
-	local_unlock_irqrestore(&pagesets.lock, flags);
+	pagesets_unlock_irqrestore(&pagesets, flags);
 }
 
 /*
@@ -3639,7 +3688,7 @@ static struct page *rmqueue_pcplist(struct zone *preferred_zone,
 	struct page *page;
 	unsigned long flags;
 
-	local_lock_irqsave(&pagesets.lock, flags);
+	pagesets_lock_irqsave(&pagesets, &flags);
 
 	/*
 	 * On allocation, reduce the number of pages that are batch freed.
@@ -3650,7 +3699,7 @@ static struct page *rmqueue_pcplist(struct zone *preferred_zone,
 	pcp->free_factor >>= 1;
 	list = &pcp->lists[order_to_pindex(migratetype, order)];
 	page = __rmqueue_pcplist(zone, order, migratetype, alloc_flags, pcp, list);
-	local_unlock_irqrestore(&pagesets.lock, flags);
+	pagesets_unlock_irqrestore(&pagesets, flags);
 	if (page) {
 		__count_zid_vm_events(PGALLOC, page_zonenum(page), 1);
 		zone_statistics(preferred_zone, zone, 1);
@@ -5270,7 +5319,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 		goto failed;
 
 	/* Attempt the batch allocation */
-	local_lock_irqsave(&pagesets.lock, flags);
+	pagesets_lock_irqsave(&pagesets, &flags);
 	pcp = this_cpu_ptr(zone->per_cpu_pageset);
 	pcp_list = &pcp->lists[order_to_pindex(ac.migratetype, 0)];
 
@@ -5300,7 +5349,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 		nr_populated++;
 	}
 
-	local_unlock_irqrestore(&pagesets.lock, flags);
+	pagesets_unlock_irqrestore(&pagesets, flags);
 
 	__count_zid_vm_events(PGALLOC, zone_idx(zone), nr_account);
 	zone_statistics(ac.preferred_zoneref->zone, zone, nr_account);
@@ -5309,7 +5358,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 	return nr_populated;
 
 failed_irq:
-	local_unlock_irqrestore(&pagesets.lock, flags);
+	pagesets_unlock_irqrestore(&pagesets, flags);
 
 failed:
 	page = __alloc_pages(gfp, 0, preferred_nid, nodemask);
-- 
2.31.1

