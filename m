Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D5F3C433EF
	for <linux-rt-users@archiver.kernel.org>; Wed,  3 Nov 2021 17:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6F0D61076
	for <linux-rt-users@archiver.kernel.org>; Wed,  3 Nov 2021 17:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbhKCRIB (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 3 Nov 2021 13:08:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38720 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233062AbhKCRH6 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 3 Nov 2021 13:07:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635959121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LgfOv5Fz6wLZvm6Rgi1f9KXwhG9hLdRO724+AjgnKSw=;
        b=jVFe4yuuM42NKKKa7ysL1VQskgijkVDdwr90iHwZjrhLr1nsV3KVtUBS/1zLSojLU3f1lf
        L18ze2kUYnMtq5DPtPdln2PU/X03cwu8GUpbkNBxMmlAAMaEkbWLlcVsBbyFKrhOm/cddh
        NNlGUPV3Sy2CdLP5m/qMCbYGeAPQbK4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-jPRDO61COGaFX_N1Dc25Xw-1; Wed, 03 Nov 2021 13:05:20 -0400
X-MC-Unique: jPRDO61COGaFX_N1Dc25Xw-1
Received: by mail-wm1-f72.google.com with SMTP id o22-20020a1c7516000000b0030d6f9c7f5fso1350764wmc.1
        for <linux-rt-users@vger.kernel.org>; Wed, 03 Nov 2021 10:05:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LgfOv5Fz6wLZvm6Rgi1f9KXwhG9hLdRO724+AjgnKSw=;
        b=n4nOiZR+R91X1dGGBhBUOd29CuoPRaNaWeEyW00s9hUxPliDBNolknSbqOoHerTvUW
         NfZ4eMmlti9ADI/1hWyRqcq6gCqU1m3NpUo66CMfigvlVkKBgyf++RqxWkCD6Ddt/TTz
         xhr++absHmke1MASWU/WbOIL34XRbXIabFt6W87Q4/qfj6+LYB4KSHiWcaL9O8VBDmTJ
         TBxVkDhUDo6+qeBBgZXhj1c4ICtIpN35neUvW4mbv2G6ZkJz1pqGri5npgnFdTgUOPlL
         zOL4oaK2M2mNnbqVISYXGF/uVgMm7LVgNqyjAz/PKjp2aUtZunvn2cH8sK6W1wGmKG5U
         XoVA==
X-Gm-Message-State: AOAM5326Sr16ZQPwYMmVwl86r8/jKeVzPqMcC6nr2hzXl1XxeNu4VXFj
        vn8QvHEjiZ1UmieDcCvyJ2rtUPJRcRyYTRkKnIskMGyOhrQ4tNsj8Aw8FGygt8c2XvTXBh71kNH
        eBRv56LzXckmsl5aAgSeMeg9RzAw=
X-Received: by 2002:adf:8b41:: with SMTP id v1mr59256094wra.255.1635959118978;
        Wed, 03 Nov 2021 10:05:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzBQcX8lYmzjC6CiT+zQNAvU5Ugr38t440jY6GVWANQUQa1Lk1Pj9neqCHeo0EkJT1jT+bnww==
X-Received: by 2002:adf:8b41:: with SMTP id v1mr59256052wra.255.1635959118727;
        Wed, 03 Nov 2021 10:05:18 -0700 (PDT)
Received: from vian.redhat.com ([2a0c:5a80:3c10:3400:3c70:6643:6e71:7eae])
        by smtp.gmail.com with ESMTPSA id h22sm2900610wmq.14.2021.11.03.10.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 10:05:17 -0700 (PDT)
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        frederic@kernel.org, tglx@linutronix.de, peterz@infradead.org,
        mtosatti@redhat.com, nilal@redhat.com, mgorman@suse.de,
        linux-rt-users@vger.kernel.org, vbabka@suse.cz, cl@linux.com,
        ppandit@redhat.com, Nicolas Saenz Julienne <nsaenzju@redhat.com>
Subject: [PATCH v2 1/3] mm/page_alloc: Don't pass pfn to free_unref_page_commit()
Date:   Wed,  3 Nov 2021 18:05:10 +0100
Message-Id: <20211103170512.2745765-2-nsaenzju@redhat.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211103170512.2745765-1-nsaenzju@redhat.com>
References: <20211103170512.2745765-1-nsaenzju@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

free_unref_page_commit() doesn't make use of its pfn argument, so get
rid of it.

Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
---
 mm/page_alloc.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c5952749ad40..9ef03dfb8f95 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3355,8 +3355,8 @@ static int nr_pcp_high(struct per_cpu_pages *pcp, struct zone *zone)
 	return min(READ_ONCE(pcp->batch) << 2, high);
 }
 
-static void free_unref_page_commit(struct page *page, unsigned long pfn,
-				   int migratetype, unsigned int order)
+static void free_unref_page_commit(struct page *page, int migratetype,
+				   unsigned int order)
 {
 	struct zone *zone = page_zone(page);
 	struct per_cpu_pages *pcp;
@@ -3405,7 +3405,7 @@ void free_unref_page(struct page *page, unsigned int order)
 	}
 
 	local_lock_irqsave(&pagesets.lock, flags);
-	free_unref_page_commit(page, pfn, migratetype, order);
+	free_unref_page_commit(page, migratetype, order);
 	local_unlock_irqrestore(&pagesets.lock, flags);
 }
 
@@ -3415,13 +3415,13 @@ void free_unref_page(struct page *page, unsigned int order)
 void free_unref_page_list(struct list_head *list)
 {
 	struct page *page, *next;
-	unsigned long flags, pfn;
+	unsigned long flags;
 	int batch_count = 0;
 	int migratetype;
 
 	/* Prepare pages for freeing */
 	list_for_each_entry_safe(page, next, list, lru) {
-		pfn = page_to_pfn(page);
+		unsigned long pfn = page_to_pfn(page);
 		if (!free_unref_page_prepare(page, pfn, 0)) {
 			list_del(&page->lru);
 			continue;
@@ -3437,15 +3437,10 @@ void free_unref_page_list(struct list_head *list)
 			free_one_page(page_zone(page), page, pfn, 0, migratetype, FPI_NONE);
 			continue;
 		}
-
-		set_page_private(page, pfn);
 	}
 
 	local_lock_irqsave(&pagesets.lock, flags);
 	list_for_each_entry_safe(page, next, list, lru) {
-		pfn = page_private(page);
-		set_page_private(page, 0);
-
 		/*
 		 * Non-isolated types over MIGRATE_PCPTYPES get added
 		 * to the MIGRATE_MOVABLE pcp list.
@@ -3455,7 +3450,7 @@ void free_unref_page_list(struct list_head *list)
 			migratetype = MIGRATE_MOVABLE;
 
 		trace_mm_page_free_batched(page);
-		free_unref_page_commit(page, pfn, migratetype, 0);
+		free_unref_page_commit(page, migratetype, 0);
 
 		/*
 		 * Guard against excessive IRQ disabled times when we get
-- 
2.33.1

