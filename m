Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE44C4361B
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Dec 2020 14:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED83223406
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Dec 2020 14:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733221AbgLIOxa (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 9 Dec 2020 09:53:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732372AbgLIOxa (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 9 Dec 2020 09:53:30 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000CFC0617B0
        for <linux-rt-users@vger.kernel.org>; Wed,  9 Dec 2020 06:52:49 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id t4so2032519wrr.12
        for <linux-rt-users@vger.kernel.org>; Wed, 09 Dec 2020 06:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P4ADCprBh51UPTi4qQxtPSZoVYMu6eRk2ZmPIDnYt18=;
        b=s7bpjjaM+he+DQ0FOJk5vfQ3eaUUaiKXW9uRqTL32jLoq0l5qwhPR2LSbXjPtM9jCo
         Ndajx5eH7/hFD0L5jsM0qiMS5CkFJOEnjvl8aH6rPjEm3qgUj0mNPGjSAU3b3lQ/ljjp
         RcFX7fXqiBKXPb1BetTi67nowt4N3tpLmpxK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P4ADCprBh51UPTi4qQxtPSZoVYMu6eRk2ZmPIDnYt18=;
        b=sjJbBpI7tIF1dVRTiEFAEkTdTNdz0OXZXMrZgM+DqBvf06txmxW8Wmaa9Y5sIWhO+M
         Zjt5nYTKr4CPHFskbkQq446aJzybHLgnXKX5NvfRWsNQn+4OypUXRJzCvevxNm0YiqML
         +QzUVk6sjVFcyYnaur6u28YEEdSP2g6ROqmr2tb2raySCwfJZ1uKI0X5Xlpiv2ot/E+0
         6jhSD0hNFSltMeVo7XqzNEgrJqtue5clFiosZ1zXIwFYUwfL2rBhP6ZPzp05K5UD2Br6
         oZo1VyaVyXNctiKD5mlR6kppDTAIsMVjh0nf7d+5cvIF++vHJDWXf2JVKEMUs8qoSiDt
         bv+A==
X-Gm-Message-State: AOAM530h4mmSxxVrMLToofz6M6xEbTqc5YX5QTEt7+DrhOph9i6E+3Xw
        w4P6OsYxc2d8qpPpNQHx6K7lnQ==
X-Google-Smtp-Source: ABdhPJzAV8h8z52C1fB1QxdKxxe0h/jX9fYk+kwacv+kji+UrtAAiYbtgGQJoUpd8tO6t+2NNJhiqg==
X-Received: by 2002:a5d:474d:: with SMTP id o13mr3078391wrs.379.1607525568708;
        Wed, 09 Dec 2020 06:52:48 -0800 (PST)
Received: from taos.konsulko.bg (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id 189sm3831957wma.22.2020.12.09.06.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 06:52:48 -0800 (PST)
From:   Vitaly Wool <vitaly.wool@konsulko.com>
To:     linux-mm@kvack.org
Cc:     lkml@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mike Galbraith <efault@gmx.de>, akpm@linux-foundation.org,
        Vitaly Wool <vitaly.wool@konsulko.com>, stable@kernel.org
Subject: [PATCH 3/3] z3fold: stricter locking and more careful reclaim
Date:   Wed,  9 Dec 2020 16:51:51 +0200
Message-Id: <20201209145151.18994-4-vitaly.wool@konsulko.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201209145151.18994-1-vitaly.wool@konsulko.com>
References: <20201209145151.18994-1-vitaly.wool@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Use temporary slots in reclaim function to avoid possible race when
freeing those.

While at it, make sure we check CLAIMED flag under page lock in the
reclaim function to make sure we are not racing with z3fold_alloc().

Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.com>
Cc: stable@kernel.org
---
 mm/z3fold.c | 143 +++++++++++++++++++++++++++++++---------------------
 1 file changed, 85 insertions(+), 58 deletions(-)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index 9fc1cc9630fe..dacb0d70fa61 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -181,6 +181,13 @@ enum z3fold_page_flags {
 	PAGE_CLAIMED, /* by either reclaim or free */
 };
 
+/*
+ * handle flags, go under HANDLE_FLAG_MASK
+ */
+enum z3fold_handle_flags {
+	HANDLES_NOFREE = 0,
+};
+
 /*
  * Forward declarations
  */
@@ -311,6 +318,12 @@ static inline void free_handle(unsigned long handle, struct z3fold_header *zhdr)
 	slots = handle_to_slots(handle);
 	write_lock(&slots->lock);
 	*(unsigned long *)handle = 0;
+
+	if (test_bit(HANDLES_NOFREE, &slots->pool)) {
+		write_unlock(&slots->lock);
+		return; /* simple case, nothing else to do */
+	}
+
 	if (zhdr->slots != slots)
 		zhdr->foreign_handles--;
 
@@ -623,6 +636,28 @@ static inline void add_to_unbuddied(struct z3fold_pool *pool,
 	}
 }
 
+static inline enum buddy get_free_buddy(struct z3fold_header *zhdr, int chunks)
+{
+	enum buddy bud = HEADLESS;
+
+	if (zhdr->middle_chunks) {
+		if (!zhdr->first_chunks &&
+		    chunks <= zhdr->start_middle - ZHDR_CHUNKS)
+			bud = FIRST;
+		else if (!zhdr->last_chunks)
+			bud = LAST;
+	} else {
+		if (!zhdr->first_chunks)
+			bud = FIRST;
+		else if (!zhdr->last_chunks)
+			bud = LAST;
+		else
+			bud = MIDDLE;
+	}
+
+	return bud;
+}
+
 static inline void *mchunk_memmove(struct z3fold_header *zhdr,
 				unsigned short dst_chunk)
 {
@@ -684,18 +719,7 @@ static struct z3fold_header *compact_single_buddy(struct z3fold_header *zhdr)
 		if (WARN_ON(new_zhdr == zhdr))
 			goto out_fail;
 
-		if (new_zhdr->first_chunks == 0) {
-			if (new_zhdr->middle_chunks != 0 &&
-					chunks >= new_zhdr->start_middle) {
-				new_bud = LAST;
-			} else {
-				new_bud = FIRST;
-			}
-		} else if (new_zhdr->last_chunks == 0) {
-			new_bud = LAST;
-		} else if (new_zhdr->middle_chunks == 0) {
-			new_bud = MIDDLE;
-		}
+		new_bud = get_free_buddy(new_zhdr, chunks);
 		q = new_zhdr;
 		switch (new_bud) {
 		case FIRST:
@@ -817,9 +841,8 @@ static void do_compact_page(struct z3fold_header *zhdr, bool locked)
 		return;
 	}
 
-	if (unlikely(PageIsolated(page) ||
-		     test_bit(PAGE_CLAIMED, &page->private) ||
-		     test_bit(PAGE_STALE, &page->private))) {
+	if (test_bit(PAGE_STALE, &page->private) ||
+	    test_and_set_bit(PAGE_CLAIMED, &page->private)) {
 		z3fold_page_unlock(zhdr);
 		return;
 	}
@@ -828,13 +851,16 @@ static void do_compact_page(struct z3fold_header *zhdr, bool locked)
 	    zhdr->mapped_count == 0 && compact_single_buddy(zhdr)) {
 		if (kref_put(&zhdr->refcount, release_z3fold_page_locked))
 			atomic64_dec(&pool->pages_nr);
-		else
+		else {
+			clear_bit(PAGE_CLAIMED, &page->private);
 			z3fold_page_unlock(zhdr);
+		}
 		return;
 	}
 
 	z3fold_compact_page(zhdr);
 	add_to_unbuddied(pool, zhdr);
+	clear_bit(PAGE_CLAIMED, &page->private);
 	z3fold_page_unlock(zhdr);
 }
 
@@ -1083,17 +1109,8 @@ static int z3fold_alloc(struct z3fold_pool *pool, size_t size, gfp_t gfp,
 retry:
 		zhdr = __z3fold_alloc(pool, size, can_sleep);
 		if (zhdr) {
-			if (zhdr->first_chunks == 0) {
-				if (zhdr->middle_chunks != 0 &&
-				    chunks >= zhdr->start_middle)
-					bud = LAST;
-				else
-					bud = FIRST;
-			} else if (zhdr->last_chunks == 0)
-				bud = LAST;
-			else if (zhdr->middle_chunks == 0)
-				bud = MIDDLE;
-			else {
+			bud = get_free_buddy(zhdr, chunks);
+			if (bud == HEADLESS) {
 				if (kref_put(&zhdr->refcount,
 					     release_z3fold_page_locked))
 					atomic64_dec(&pool->pages_nr);
@@ -1239,7 +1256,6 @@ static void z3fold_free(struct z3fold_pool *pool, unsigned long handle)
 		pr_err("%s: unknown bud %d\n", __func__, bud);
 		WARN_ON(1);
 		put_z3fold_header(zhdr);
-		clear_bit(PAGE_CLAIMED, &page->private);
 		return;
 	}
 
@@ -1254,8 +1270,7 @@ static void z3fold_free(struct z3fold_pool *pool, unsigned long handle)
 		z3fold_page_unlock(zhdr);
 		return;
 	}
-	if (unlikely(PageIsolated(page)) ||
-	    test_and_set_bit(NEEDS_COMPACTING, &page->private)) {
+	if (test_and_set_bit(NEEDS_COMPACTING, &page->private)) {
 		put_z3fold_header(zhdr);
 		clear_bit(PAGE_CLAIMED, &page->private);
 		return;
@@ -1319,6 +1334,10 @@ static int z3fold_reclaim_page(struct z3fold_pool *pool, unsigned int retries)
 	struct page *page = NULL;
 	struct list_head *pos;
 	unsigned long first_handle = 0, middle_handle = 0, last_handle = 0;
+	struct z3fold_buddy_slots slots __attribute__((aligned(SLOTS_ALIGN)));
+
+	rwlock_init(&slots.lock);
+	slots.pool = (unsigned long)pool | (1 << HANDLES_NOFREE);
 
 	spin_lock(&pool->lock);
 	if (!pool->ops || !pool->ops->evict || retries == 0) {
@@ -1333,35 +1352,36 @@ static int z3fold_reclaim_page(struct z3fold_pool *pool, unsigned int retries)
 		list_for_each_prev(pos, &pool->lru) {
 			page = list_entry(pos, struct page, lru);
 
-			/* this bit could have been set by free, in which case
-			 * we pass over to the next page in the pool.
-			 */
-			if (test_and_set_bit(PAGE_CLAIMED, &page->private)) {
-				page = NULL;
-				continue;
-			}
-
-			if (unlikely(PageIsolated(page))) {
-				clear_bit(PAGE_CLAIMED, &page->private);
-				page = NULL;
-				continue;
-			}
 			zhdr = page_address(page);
 			if (test_bit(PAGE_HEADLESS, &page->private))
 				break;
 
+			if (kref_get_unless_zero(&zhdr->refcount) == 0) {
+				zhdr = NULL;
+				break;
+			}
 			if (!z3fold_page_trylock(zhdr)) {
-				clear_bit(PAGE_CLAIMED, &page->private);
+				if (kref_put(&zhdr->refcount,
+						release_z3fold_page))
+					atomic64_dec(&pool->pages_nr);
 				zhdr = NULL;
 				continue; /* can't evict at this point */
 			}
-			if (zhdr->foreign_handles) {
-				clear_bit(PAGE_CLAIMED, &page->private);
-				z3fold_page_unlock(zhdr);
+
+			/* test_and_set_bit is of course atomic, but we still
+			 * need to do it under page lock, otherwise checking
+			 * that bit in __z3fold_alloc wouldn't make sense
+			 */
+			if (zhdr->foreign_handles ||
+			    test_and_set_bit(PAGE_CLAIMED, &page->private)) {
+				if (kref_put(&zhdr->refcount,
+						release_z3fold_page))
+					atomic64_dec(&pool->pages_nr);
+				else
+					z3fold_page_unlock(zhdr);
 				zhdr = NULL;
 				continue; /* can't evict such page */
 			}
-			kref_get(&zhdr->refcount);
 			list_del_init(&zhdr->buddy);
 			zhdr->cpu = -1;
 			break;
@@ -1383,12 +1403,16 @@ static int z3fold_reclaim_page(struct z3fold_pool *pool, unsigned int retries)
 			first_handle = 0;
 			last_handle = 0;
 			middle_handle = 0;
+			memset(slots.slot, 0, sizeof(slots.slot));
 			if (zhdr->first_chunks)
-				first_handle = encode_handle(zhdr, FIRST);
+				first_handle = __encode_handle(zhdr, &slots,
+								FIRST);
 			if (zhdr->middle_chunks)
-				middle_handle = encode_handle(zhdr, MIDDLE);
+				middle_handle = __encode_handle(zhdr, &slots,
+								MIDDLE);
 			if (zhdr->last_chunks)
-				last_handle = encode_handle(zhdr, LAST);
+				last_handle = __encode_handle(zhdr, &slots,
+								LAST);
 			/*
 			 * it's safe to unlock here because we hold a
 			 * reference to this page
@@ -1403,19 +1427,16 @@ static int z3fold_reclaim_page(struct z3fold_pool *pool, unsigned int retries)
 			ret = pool->ops->evict(pool, middle_handle);
 			if (ret)
 				goto next;
-			free_handle(middle_handle, zhdr);
 		}
 		if (first_handle) {
 			ret = pool->ops->evict(pool, first_handle);
 			if (ret)
 				goto next;
-			free_handle(first_handle, zhdr);
 		}
 		if (last_handle) {
 			ret = pool->ops->evict(pool, last_handle);
 			if (ret)
 				goto next;
-			free_handle(last_handle, zhdr);
 		}
 next:
 		if (test_bit(PAGE_HEADLESS, &page->private)) {
@@ -1429,9 +1450,11 @@ static int z3fold_reclaim_page(struct z3fold_pool *pool, unsigned int retries)
 			spin_unlock(&pool->lock);
 			clear_bit(PAGE_CLAIMED, &page->private);
 		} else {
+			struct z3fold_buddy_slots *slots = zhdr->slots;
 			z3fold_page_lock(zhdr);
 			if (kref_put(&zhdr->refcount,
 					release_z3fold_page_locked)) {
+				kmem_cache_free(pool->c_handle, slots);
 				atomic64_dec(&pool->pages_nr);
 				return 0;
 			}
@@ -1547,8 +1570,7 @@ static bool z3fold_page_isolate(struct page *page, isolate_mode_t mode)
 	VM_BUG_ON_PAGE(!PageMovable(page), page);
 	VM_BUG_ON_PAGE(PageIsolated(page), page);
 
-	if (test_bit(PAGE_HEADLESS, &page->private) ||
-	    test_bit(PAGE_CLAIMED, &page->private))
+	if (test_bit(PAGE_HEADLESS, &page->private))
 		return false;
 
 	zhdr = page_address(page);
@@ -1560,6 +1582,8 @@ static bool z3fold_page_isolate(struct page *page, isolate_mode_t mode)
 	if (zhdr->mapped_count != 0 || zhdr->foreign_handles != 0)
 		goto out;
 
+	if (test_and_set_bit(PAGE_CLAIMED, &page->private))
+		goto out;
 	pool = zhdr_to_pool(zhdr);
 	spin_lock(&pool->lock);
 	if (!list_empty(&zhdr->buddy))
@@ -1586,16 +1610,17 @@ static int z3fold_page_migrate(struct address_space *mapping, struct page *newpa
 
 	VM_BUG_ON_PAGE(!PageMovable(page), page);
 	VM_BUG_ON_PAGE(!PageIsolated(page), page);
+	VM_BUG_ON_PAGE(!test_bit(PAGE_CLAIMED, &page->private), page);
 	VM_BUG_ON_PAGE(!PageLocked(newpage), newpage);
 
 	zhdr = page_address(page);
 	pool = zhdr_to_pool(zhdr);
 
-	if (!z3fold_page_trylock(zhdr)) {
+	if (!z3fold_page_trylock(zhdr))
 		return -EAGAIN;
-	}
 	if (zhdr->mapped_count != 0 || zhdr->foreign_handles != 0) {
 		z3fold_page_unlock(zhdr);
+		clear_bit(PAGE_CLAIMED, &page->private);
 		return -EBUSY;
 	}
 	if (work_pending(&zhdr->work)) {
@@ -1637,6 +1662,7 @@ static int z3fold_page_migrate(struct address_space *mapping, struct page *newpa
 	queue_work_on(new_zhdr->cpu, pool->compact_wq, &new_zhdr->work);
 
 	page_mapcount_reset(page);
+	clear_bit(PAGE_CLAIMED, &page->private);
 	put_page(page);
 	return 0;
 }
@@ -1660,6 +1686,7 @@ static void z3fold_page_putback(struct page *page)
 	spin_lock(&pool->lock);
 	list_add(&page->lru, &pool->lru);
 	spin_unlock(&pool->lock);
+	clear_bit(PAGE_CLAIMED, &page->private);
 	z3fold_page_unlock(zhdr);
 }
 
-- 
2.20.1

