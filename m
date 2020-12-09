Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2501C4361B
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Dec 2020 14:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C36A233EF
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Dec 2020 14:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733206AbgLIOxH (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 9 Dec 2020 09:53:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732325AbgLIOxG (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 9 Dec 2020 09:53:06 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3C3C0617A6
        for <linux-rt-users@vger.kernel.org>; Wed,  9 Dec 2020 06:52:26 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id 91so2040643wrj.7
        for <linux-rt-users@vger.kernel.org>; Wed, 09 Dec 2020 06:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J2hkHNzCDEGB0J9sgU5PXkAy+/sgZMRXXXGzM8sHpFc=;
        b=aBTkU87uGdVCZaCoNz7qeW5WKZ1AlBZKjV71BA10HzW0BnLo09qiTXT270YHzU/7rq
         +HhpphftS+8XYqug0QA7oT83TxR4Mq3Uxx2Gd6p8xmG1fUB72IgQ0Hw/1OcbKHVuzLcV
         xXU8O5z/YZBYDSwSLj8gjlmRVhyhjQQ3ODqkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J2hkHNzCDEGB0J9sgU5PXkAy+/sgZMRXXXGzM8sHpFc=;
        b=VBRnuCp8M3x7MSgBQbjtiroCEOCh71L/UDfNNn4Qupd3va6Y0yKj4B5VfGOte+M8g7
         CRvZfCdR7DnVCsfQcMhJp1ZnTBa6Tm4oMksOsn8er3qncMsxCZfWCq2Y2pEEjdx8pQr1
         ZrvwBOEz/95bbh8WeVQhkkGRdpVlJ7NV1cUtffzTkI7b2Rgoqf577Y6wpgQZX71ujBLe
         mpz8BOMWnznGuWUDZutXLDkrB8pJQwUI+0rLrjNwx1/f18BuIG9qHqF1S/5ehIZ+tS9m
         ZQndbTuGSEIk1EBJbVsxDLDH6gIRMQJUGGEv60UvTAykEeapJtaTdyuUp2CXTpK/xZ+r
         fG5w==
X-Gm-Message-State: AOAM532/jNoYXexQ9zbp3PdiljNnNWraKNMCI18s8w8yvPKnDW4O0wgm
        VUn/JhXccagbj1zMZxJo7Zai9w==
X-Google-Smtp-Source: ABdhPJzipTU+hiVIinfES/sQ4fz736DXvse1IQaCV4h73aNNUxx/Yt/FOMFgFm5Z/BlSVFysn1df7w==
X-Received: by 2002:adf:e802:: with SMTP id o2mr3204533wrm.251.1607525545292;
        Wed, 09 Dec 2020 06:52:25 -0800 (PST)
Received: from taos.konsulko.bg (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id 189sm3831957wma.22.2020.12.09.06.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 06:52:24 -0800 (PST)
From:   Vitaly Wool <vitaly.wool@konsulko.com>
To:     linux-mm@kvack.org
Cc:     lkml@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mike Galbraith <efault@gmx.de>, akpm@linux-foundation.org,
        Vitaly Wool <vitaly.wool@konsulko.com>, stable@kernel.org
Subject: [PATCH 1/3] z3fold: simplify freeing slots
Date:   Wed,  9 Dec 2020 16:51:49 +0200
Message-Id: <20201209145151.18994-2-vitaly.wool@konsulko.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201209145151.18994-1-vitaly.wool@konsulko.com>
References: <20201209145151.18994-1-vitaly.wool@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

There used to be two places in the code where slots could be freed,
namely when freeing the last allocated handle from the slots and
when releasing the z3fold header these slots aree linked to. The
logic to decide on whether to free certain slots was complicated
and error prone in both functions and it led to failures in RT case.

To fix that, make free_handle() the single point of freeing slots.

Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.com>
Tested-by: Mike Galbraith <efault@gmx.de>
Cc: stable@kernel.org
---
 mm/z3fold.c | 55 +++++++++++++----------------------------------------
 1 file changed, 13 insertions(+), 42 deletions(-)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index 18feaa0bc537..6c2325cd3fba 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -90,7 +90,7 @@ struct z3fold_buddy_slots {
 	 * be enough slots to hold all possible variants
 	 */
 	unsigned long slot[BUDDY_MASK + 1];
-	unsigned long pool; /* back link + flags */
+	unsigned long pool; /* back link */
 	rwlock_t lock;
 };
 #define HANDLE_FLAG_MASK	(0x03)
@@ -181,13 +181,6 @@ enum z3fold_page_flags {
 	PAGE_CLAIMED, /* by either reclaim or free */
 };
 
-/*
- * handle flags, go under HANDLE_FLAG_MASK
- */
-enum z3fold_handle_flags {
-	HANDLES_ORPHANED = 0,
-};
-
 /*
  * Forward declarations
  */
@@ -303,10 +296,9 @@ static inline void put_z3fold_header(struct z3fold_header *zhdr)
 		z3fold_page_unlock(zhdr);
 }
 
-static inline void free_handle(unsigned long handle)
+static inline void free_handle(unsigned long handle, struct z3fold_header *zhdr)
 {
 	struct z3fold_buddy_slots *slots;
-	struct z3fold_header *zhdr;
 	int i;
 	bool is_free;
 
@@ -316,22 +308,13 @@ static inline void free_handle(unsigned long handle)
 	if (WARN_ON(*(unsigned long *)handle == 0))
 		return;
 
-	zhdr = handle_to_z3fold_header(handle);
 	slots = handle_to_slots(handle);
 	write_lock(&slots->lock);
 	*(unsigned long *)handle = 0;
-	if (zhdr->slots == slots) {
-		write_unlock(&slots->lock);
-		return; /* simple case, nothing else to do */
-	}
+	if (zhdr->slots != slots)
+		zhdr->foreign_handles--;
 
-	/* we are freeing a foreign handle if we are here */
-	zhdr->foreign_handles--;
 	is_free = true;
-	if (!test_bit(HANDLES_ORPHANED, &slots->pool)) {
-		write_unlock(&slots->lock);
-		return;
-	}
 	for (i = 0; i <= BUDDY_MASK; i++) {
 		if (slots->slot[i]) {
 			is_free = false;
@@ -343,6 +326,8 @@ static inline void free_handle(unsigned long handle)
 	if (is_free) {
 		struct z3fold_pool *pool = slots_to_pool(slots);
 
+		if (zhdr->slots == slots)
+			zhdr->slots = NULL;
 		kmem_cache_free(pool->c_handle, slots);
 	}
 }
@@ -525,8 +510,6 @@ static void __release_z3fold_page(struct z3fold_header *zhdr, bool locked)
 {
 	struct page *page = virt_to_page(zhdr);
 	struct z3fold_pool *pool = zhdr_to_pool(zhdr);
-	bool is_free = true;
-	int i;
 
 	WARN_ON(!list_empty(&zhdr->buddy));
 	set_bit(PAGE_STALE, &page->private);
@@ -536,21 +519,6 @@ static void __release_z3fold_page(struct z3fold_header *zhdr, bool locked)
 		list_del_init(&page->lru);
 	spin_unlock(&pool->lock);
 
-	/* If there are no foreign handles, free the handles array */
-	read_lock(&zhdr->slots->lock);
-	for (i = 0; i <= BUDDY_MASK; i++) {
-		if (zhdr->slots->slot[i]) {
-			is_free = false;
-			break;
-		}
-	}
-	if (!is_free)
-		set_bit(HANDLES_ORPHANED, &zhdr->slots->pool);
-	read_unlock(&zhdr->slots->lock);
-
-	if (is_free)
-		kmem_cache_free(pool->c_handle, zhdr->slots);
-
 	if (locked)
 		z3fold_page_unlock(zhdr);
 
@@ -973,6 +941,9 @@ static inline struct z3fold_header *__z3fold_alloc(struct z3fold_pool *pool,
 		}
 	}
 
+	if (zhdr && !zhdr->slots)
+		zhdr->slots = alloc_slots(pool,
+					can_sleep ? GFP_NOIO : GFP_ATOMIC);
 	return zhdr;
 }
 
@@ -1270,7 +1241,7 @@ static void z3fold_free(struct z3fold_pool *pool, unsigned long handle)
 	}
 
 	if (!page_claimed)
-		free_handle(handle);
+		free_handle(handle, zhdr);
 	if (kref_put(&zhdr->refcount, release_z3fold_page_locked_list)) {
 		atomic64_dec(&pool->pages_nr);
 		return;
@@ -1429,19 +1400,19 @@ static int z3fold_reclaim_page(struct z3fold_pool *pool, unsigned int retries)
 			ret = pool->ops->evict(pool, middle_handle);
 			if (ret)
 				goto next;
-			free_handle(middle_handle);
+			free_handle(middle_handle, zhdr);
 		}
 		if (first_handle) {
 			ret = pool->ops->evict(pool, first_handle);
 			if (ret)
 				goto next;
-			free_handle(first_handle);
+			free_handle(first_handle, zhdr);
 		}
 		if (last_handle) {
 			ret = pool->ops->evict(pool, last_handle);
 			if (ret)
 				goto next;
-			free_handle(last_handle);
+			free_handle(last_handle, zhdr);
 		}
 next:
 		if (test_bit(PAGE_HEADLESS, &page->private)) {
-- 
2.20.1

