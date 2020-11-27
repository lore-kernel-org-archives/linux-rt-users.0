Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B8EC2D0E4
	for <linux-rt-users@archiver.kernel.org>; Fri, 27 Nov 2020 14:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27DCA20B1F
	for <linux-rt-users@archiver.kernel.org>; Fri, 27 Nov 2020 14:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="BD8TTxjI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730914AbgK0O1b (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 27 Nov 2020 09:27:31 -0500
Received: from m15114.mail.126.com ([220.181.15.114]:42112 "EHLO
        m15114.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730837AbgK0O1b (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 27 Nov 2020 09:27:31 -0500
X-Greylist: delayed 1831 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Nov 2020 09:27:30 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=OaA3oEiQuNBSoZYg2M
        XpDhlH5QmelGcwiGpxTrVzrVM=; b=BD8TTxjIXkpQQ+rQb+Ir+iAHRjjoJ/22DN
        JXPC9zvp7hmO8JBPo0nEyah3WtOpieOiLUZwGuo+8Q/pw6Ac4T61eRr60Mf4EjGY
        I+S9xMfqQA6/Y5v73cXV2JjCnV27KxRa73DlnKU97ZroSaPp326dOFM1Gut/0+sI
        Y2LpfE1Ww=
Received: from localhost.localdomain (unknown [113.91.142.252])
        by smtp7 (Coremail) with SMTP id DsmowAB3fGxRBcFf9xujLQ--.24119S2;
        Fri, 27 Nov 2020 21:55:32 +0800 (CST)
From:   zqiu2000@126.com
To:     linux-rt-users@vger.kernel.org
Cc:     bigeasy@linutronix.de, tglx@linutronix.de, rostedt@goodmis.org,
        lcapitulino@redhat.com, Zanxiong Qiu <zqiu2000@126.com>
Subject: [PATCH v2 RT] mm/swap: use local lock in deactivate_page()
Date:   Fri, 27 Nov 2020 21:54:56 +0800
Message-Id: <20201127135456.8145-1-zqiu2000@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: DsmowAB3fGxRBcFf9xujLQ--.24119S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KF45WFy7WFyrAr18ZryDGFg_yoW8Xr1kpa
        yDCa9IyF1DXFyYvay7XrnFvFy5W39Ygw47J3yUAa13ur1jy3W0vF1xKws0kw1fG3Z3ArW7
        uws8Xr1av3Z0yaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jWeHDUUUUU=
X-Originating-IP: [113.91.142.252]
X-CM-SenderInfo: p2tl3jqqqqqiyswou0bp/1tbi6BLpFFpECMJ0TAAAsr
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Zanxiong Qiu <zqiu2000@126.com>

get_cpu_var() calls preempt_disable(), while on RT kernel,
pagevec_lru_move_fn() will call spinlock and might schedule
the context out and hence the schedule bug occurred, issue
is found on 5.4.70-rt40 and reproducable on 5.4.74-rt41.

32154a0abcc ("mm: Revert the DEFINE_PER_CPU_PAGEVEC implementation")
reverted the lock/unlock_swap_pvec function, however,
deactivate_page() part was missed at that time as it's newly
added in v5.4.

Signed-off-by: Zanxiong Qiu <zqiu2000@126.com>
Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
v1 -> v2: tweek the commit msg, remove call stack, add acked-by.

 mm/swap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index cdb4f1fa3a48..463cac334fcf 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -666,12 +666,13 @@ void deactivate_file_page(struct page *page)
 void deactivate_page(struct page *page)
 {
 	if (PageLRU(page) && PageActive(page) && !PageUnevictable(page)) {
-		struct pagevec *pvec = &get_cpu_var(lru_deactivate_pvecs);
+		struct pagevec *pvec = &get_locked_var(swapvec_lock,
+							lru_deactivate_pvecs);
 
 		get_page(page);
 		if (!pagevec_add(pvec, page) || PageCompound(page))
 			pagevec_lru_move_fn(pvec, lru_deactivate_fn, NULL);
-		put_cpu_var(lru_deactivate_pvecs);
+		put_locked_var(swapvec_lock, lru_deactivate_pvecs);
 	}
 }
 
-- 
2.17.1

