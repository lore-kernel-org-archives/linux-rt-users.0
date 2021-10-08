Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE35C43217
	for <linux-rt-users@archiver.kernel.org>; Fri,  8 Oct 2021 16:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFAD161038
	for <linux-rt-users@archiver.kernel.org>; Fri,  8 Oct 2021 16:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbhJHQVg (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 8 Oct 2021 12:21:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40498 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230044AbhJHQVe (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 8 Oct 2021 12:21:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633709978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sKT1idpTNkVhaBOIkuTT61/rDCOAntRvXZQwZuQU3No=;
        b=DwdvOd5tHmEr4WDXgB2RE88IZjjUBJrAf5fjzUYxmh+Bouj+4AmdYaUdkL6VTzz5o8xJzT
        AI6U1htMaq5IBY5IoREpFFnD5KkCjzx69/nEXtkQ5NtNtBDbfJpFGUYnj26JD4D/MGnk4R
        lDDuVkDHef307QPlJVfAswHrmtZ0lvU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-liSMpATXO-i1iuvH41ImTg-1; Fri, 08 Oct 2021 12:19:35 -0400
X-MC-Unique: liSMpATXO-i1iuvH41ImTg-1
Received: by mail-wr1-f71.google.com with SMTP id 75-20020adf82d1000000b00160cbb0f800so6960999wrc.22
        for <linux-rt-users@vger.kernel.org>; Fri, 08 Oct 2021 09:19:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sKT1idpTNkVhaBOIkuTT61/rDCOAntRvXZQwZuQU3No=;
        b=TJ+Jx4LAfglQaVur4xGk9wC+7xJ0YXt4RZAbTZk7nKyJMZxNoG7rUWc5fF5zQPkBW5
         nnhcW7PLfOYNh2ZNIkVoeQfFr9sPNv7F/SiDPwpeX/w7fb9M5beBZ03SsbQ/sJa3z4gy
         p/qIOzI1mCYhwxAN+S3ZU2XNdAiARarVt85Zzv/Q5K4ynqvLI32dF6qzcX7xoAEPUc8Z
         mh3MdZUgiyUaR9MNwJJ5Jg6dMD5hgrc0aqasLCUmcq1iymZACMM8i8CCeDdBnu7+h+v/
         NZm/OuA95yY5nU6sE/Gz1cia3qApuW9BLAYrYFmHyi1HzvdZusk4DZT2Uu6KJYDAjmHm
         Rxew==
X-Gm-Message-State: AOAM530mZOmwBONnJoM8HP+N/xwcHdC5YWfce6TlToG0P9vHgTJG7HVJ
        FZIkYWxgiphAuiSO9au3jSVx4oyGqGzm0uDGMAYVAMVEUV8y4j9S0k3CiRegO+EfjfXBSQ4dBdY
        1+X7D+cz3aMHtwRR21ffhhf4jb5k=
X-Received: by 2002:a7b:c0da:: with SMTP id s26mr4467321wmh.58.1633709974149;
        Fri, 08 Oct 2021 09:19:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyajDwkhy5l3/UOB/lGC0lTJWJcdm20ijXtf9vCwLnu+uMQULK/wCDkF1fE82BbhRGEJC15RA==
X-Received: by 2002:a7b:c0da:: with SMTP id s26mr4467307wmh.58.1633709973984;
        Fri, 08 Oct 2021 09:19:33 -0700 (PDT)
Received: from vian.redhat.com ([2a0c:5a80:1d03:b900:c3d1:5974:ce92:3123])
        by smtp.gmail.com with ESMTPSA id f184sm2901753wmf.22.2021.10.08.09.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 09:19:33 -0700 (PDT)
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        frederic@kernel.org, tglx@linutronix.de, peterz@infradead.org,
        mtosatti@redhat.com, nilal@redhat.com, mgorman@suse.de,
        linux-rt-users@vger.kernel.org, vbabka@suse.cz, cl@linux.com,
        paulmck@kernel.org, ppandit@redhat.com,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>
Subject: [RFC 1/3] mm/page_alloc: Simplify __rmqueue_pcplist()'s arguments
Date:   Fri,  8 Oct 2021 18:19:20 +0200
Message-Id: <20211008161922.942459-2-nsaenzju@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211008161922.942459-1-nsaenzju@redhat.com>
References: <20211008161922.942459-1-nsaenzju@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Both users of __rmqueue_pcplist() use the same means to extract the
right list from their per-cpu lists: calculate the index based on the
page's migratetype and order. This data is already being passed to
__rmqueue_pcplist(), so centralize the list extraction process inside
the function.

Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
---
 mm/page_alloc.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b37435c274cf..dd89933503b4 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3600,11 +3600,13 @@ static inline
 struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
 			int migratetype,
 			unsigned int alloc_flags,
-			struct per_cpu_pages *pcp,
-			struct list_head *list)
+			struct per_cpu_pages *pcp)
 {
+	struct list_head *list;
 	struct page *page;
 
+	list = &pcp->lists[order_to_pindex(migratetype, order)];
+
 	do {
 		if (list_empty(list)) {
 			int batch = READ_ONCE(pcp->batch);
@@ -3643,7 +3645,6 @@ static struct page *rmqueue_pcplist(struct zone *preferred_zone,
 			unsigned int alloc_flags)
 {
 	struct per_cpu_pages *pcp;
-	struct list_head *list;
 	struct page *page;
 	unsigned long flags;
 
@@ -3656,8 +3657,7 @@ static struct page *rmqueue_pcplist(struct zone *preferred_zone,
 	 */
 	pcp = this_cpu_ptr(zone->per_cpu_pageset);
 	pcp->free_factor >>= 1;
-	list = &pcp->lists[order_to_pindex(migratetype, order)];
-	page = __rmqueue_pcplist(zone, order, migratetype, alloc_flags, pcp, list);
+	page = __rmqueue_pcplist(zone, order, migratetype, alloc_flags, pcp);
 	local_unlock_irqrestore(&pagesets.lock, flags);
 	if (page) {
 		__count_zid_vm_events(PGALLOC, page_zonenum(page), 1);
@@ -5202,7 +5202,6 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 	struct zone *zone;
 	struct zoneref *z;
 	struct per_cpu_pages *pcp;
-	struct list_head *pcp_list;
 	struct alloc_context ac;
 	gfp_t alloc_gfp;
 	unsigned int alloc_flags = ALLOC_WMARK_LOW;
@@ -5278,7 +5277,6 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 	/* Attempt the batch allocation */
 	local_lock_irqsave(&pagesets.lock, flags);
 	pcp = this_cpu_ptr(zone->per_cpu_pageset);
-	pcp_list = &pcp->lists[order_to_pindex(ac.migratetype, 0)];
 
 	while (nr_populated < nr_pages) {
 
@@ -5288,8 +5286,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 			continue;
 		}
 
-		page = __rmqueue_pcplist(zone, 0, ac.migratetype, alloc_flags,
-								pcp, pcp_list);
+		page = __rmqueue_pcplist(zone, 0, ac.migratetype, alloc_flags, pcp);
 		if (unlikely(!page)) {
 			/* Try and get at least one page */
 			if (!nr_populated)
-- 
2.31.1

