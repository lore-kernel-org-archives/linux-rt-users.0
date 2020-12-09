Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 288E5C4361B
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Dec 2020 14:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0D1023406
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Dec 2020 14:53:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733219AbgLIOxZ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 9 Dec 2020 09:53:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732372AbgLIOxZ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 9 Dec 2020 09:53:25 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F424C061793
        for <linux-rt-users@vger.kernel.org>; Wed,  9 Dec 2020 06:52:45 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id t16so2054580wra.3
        for <linux-rt-users@vger.kernel.org>; Wed, 09 Dec 2020 06:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QO+mDdc0W+GDe87CR6+J/pH9JlgkXQ9+W7Jahz1zoF4=;
        b=g9Xue5OG7EgSbVCscVZfnyXDCXaL+U6x8BVxb8qWNccgIVM5Pno4SkL9aGGc006+qz
         jcErJyaSq+DL/OcldXEsQ7PTMFZNy7C8HI8lbpfRJeNbj+CY9ni9f0YgyVKw+FFnh5aa
         yCiKBlDYja7hs0IuChBIxdI24YraSbk2BqOFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QO+mDdc0W+GDe87CR6+J/pH9JlgkXQ9+W7Jahz1zoF4=;
        b=LYUa+fMk5mtYxPE2TmgKGrZa0rCkziK1fhx6lUuV/gvPHib9Jhrrq575s3vZMoqGRo
         XNVSX1zlZSQG5WJ02F57jL3Uv9ajyoLLh0PViGNs7n4Zq7csE1eM+tmBtwkGOQaTbKYP
         9eBkXKkvWXH+jaUD3nZafoVS5bTNDMg8uDh7Zau9+wQVfNNd5QoylCAUhlhMD07BgXv6
         a0iF9e9kePyDWuk11IpdQzRYKtjkEoSROY7A2mleSEm+4AQNSGGY/Z82rsFjPG4hSLOf
         wYX5O9niKiT+6Ok19WEX5RL4FwPKq8eI/KtXLudomHnqg8U6R/ahTHYuvpzRK9CMA7Hj
         pywg==
X-Gm-Message-State: AOAM533D4nBtYs6Y17VTHmoj3vLpSDnHkFcrduu0jv2IrPEZShcpgsDK
        Ib7iDGHgolwpEQmB4EkJ+6R73A==
X-Google-Smtp-Source: ABdhPJyhALIcSeelDT7f6z1tke+0gzPilS0oVWeaT6VDdfYT0A6zqk0G9/PHg4pkylf1EdTY7kw2Bg==
X-Received: by 2002:adf:f98b:: with SMTP id f11mr3207719wrr.235.1607525563914;
        Wed, 09 Dec 2020 06:52:43 -0800 (PST)
Received: from taos.konsulko.bg (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id 189sm3831957wma.22.2020.12.09.06.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 06:52:43 -0800 (PST)
From:   Vitaly Wool <vitaly.wool@konsulko.com>
To:     linux-mm@kvack.org
Cc:     lkml@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mike Galbraith <efault@gmx.de>, akpm@linux-foundation.org,
        Vitaly Wool <vitaly.wool@konsulko.com>
Subject: [PATCH 2/3] z3fold: Remove preempt disabled sections for RT
Date:   Wed,  9 Dec 2020 16:51:50 +0200
Message-Id: <20201209145151.18994-3-vitaly.wool@konsulko.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201209145151.18994-1-vitaly.wool@konsulko.com>
References: <20201209145151.18994-1-vitaly.wool@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Replace get_cpu_ptr() with migrate_disable()+this_cpu_ptr()
so RT can take spinlocks that become sleeping locks.

Signed-off-by Mike Galbraith <efault@gmx.de>
Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.com>
---
 mm/z3fold.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index 6c2325cd3fba..9fc1cc9630fe 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -610,14 +610,16 @@ static inline void add_to_unbuddied(struct z3fold_pool *pool,
 {
 	if (zhdr->first_chunks == 0 || zhdr->last_chunks == 0 ||
 			zhdr->middle_chunks == 0) {
-		struct list_head *unbuddied = get_cpu_ptr(pool->unbuddied);
-
+		struct list_head *unbuddied;
 		int freechunks = num_free_chunks(zhdr);
+
+		migrate_disable();
+		unbuddied = this_cpu_ptr(pool->unbuddied);
 		spin_lock(&pool->lock);
 		list_add(&zhdr->buddy, &unbuddied[freechunks]);
 		spin_unlock(&pool->lock);
 		zhdr->cpu = smp_processor_id();
-		put_cpu_ptr(pool->unbuddied);
+		migrate_enable();
 	}
 }
 
@@ -854,8 +856,9 @@ static inline struct z3fold_header *__z3fold_alloc(struct z3fold_pool *pool,
 	int chunks = size_to_chunks(size), i;
 
 lookup:
+	migrate_disable();
 	/* First, try to find an unbuddied z3fold page. */
-	unbuddied = get_cpu_ptr(pool->unbuddied);
+	unbuddied = this_cpu_ptr(pool->unbuddied);
 	for_each_unbuddied_list(i, chunks) {
 		struct list_head *l = &unbuddied[i];
 
@@ -873,7 +876,7 @@ static inline struct z3fold_header *__z3fold_alloc(struct z3fold_pool *pool,
 		    !z3fold_page_trylock(zhdr)) {
 			spin_unlock(&pool->lock);
 			zhdr = NULL;
-			put_cpu_ptr(pool->unbuddied);
+			migrate_enable();
 			if (can_sleep)
 				cond_resched();
 			goto lookup;
@@ -887,7 +890,7 @@ static inline struct z3fold_header *__z3fold_alloc(struct z3fold_pool *pool,
 		    test_bit(PAGE_CLAIMED, &page->private)) {
 			z3fold_page_unlock(zhdr);
 			zhdr = NULL;
-			put_cpu_ptr(pool->unbuddied);
+			migrate_enable();
 			if (can_sleep)
 				cond_resched();
 			goto lookup;
@@ -902,7 +905,7 @@ static inline struct z3fold_header *__z3fold_alloc(struct z3fold_pool *pool,
 		kref_get(&zhdr->refcount);
 		break;
 	}
-	put_cpu_ptr(pool->unbuddied);
+	migrate_enable();
 
 	if (!zhdr) {
 		int cpu;
-- 
2.20.1

