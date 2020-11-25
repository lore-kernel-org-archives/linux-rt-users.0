Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C18C63798
	for <linux-rt-users@archiver.kernel.org>; Wed, 25 Nov 2020 14:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 582A5206D9
	for <linux-rt-users@archiver.kernel.org>; Wed, 25 Nov 2020 14:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="J+9/FTjp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgKYObU (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 25 Nov 2020 09:31:20 -0500
Received: from m15113.mail.126.com ([220.181.15.113]:42705 "EHLO
        m15113.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbgKYObT (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 25 Nov 2020 09:31:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=WlQc1oc9UTfPaHDZPR
        jfl8o9b+OhppafzQquJx7MFFU=; b=J+9/FTjpKaOydVDAwdOMgBrR5Dhog0TEIN
        HE5rwnOp3l/HZt98ouIzGhuu7TvZIZa6Vmz3nqYKrVj6YdbbBpqPWr2iWRfcXKM3
        4Ntkaj+6Wx1D9PLyxFsn7VGvWAgcsBXFOruu9ZYBiy87QKifVgYJp/UqcDq6b/9F
        2ap3yMYgI=
Received: from localhost.localdomain (unknown [113.91.142.252])
        by smtp3 (Coremail) with SMTP id DcmowAAXHuo_ar5fy+fpLw--.39593S2;
        Wed, 25 Nov 2020 22:29:21 +0800 (CST)
From:   zqiu2000@126.com
To:     linux-rt-users@vger.kernel.org
Cc:     bigeasy@linutronix.de, tglx@linutronix.de, rostedt@goodmis.org,
        lcapitulino@redhat.com, Zanxiong Qiu <zqiu2000@126.com>
Subject: [PATCH RT] mm/swap: use local lock in deactivate_page()
Date:   Wed, 25 Nov 2020 22:28:58 +0800
Message-Id: <20201125142858.2559-1-zqiu2000@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: DcmowAAXHuo_ar5fy+fpLw--.39593S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJF4rXFW3tr4kAF4DCF1kuFg_yoW5AFyUpF
        ZrW34a9a4UZryjvFW7tryvvFy3JwsYka17Zr18Krnru3Wqvw4jyF12krWqk34kCF97ArW7
        Za1DXr1Syr1FyaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jF388UUUUU=
X-Originating-IP: [113.91.142.252]
X-CM-SenderInfo: p2tl3jqqqqqiyswou0bp/1tbi6BvnFFpECK9rCQAAsb
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Zanxiong Qiu <zqiu2000@126.com>

get_cpu_var() calls preempt_disable(), while on RT kernel,
pagevec_lru_move_fn() will call spinlock and might schedule
the context out and hence the schedule bug occurred, issue
is found on 5.4.70-rt40 and reproducable on 5.4.74-rt41.

[  306.340109] BUG: scheduling while atomic: stress-ng-vm/3361/0x00000002
...
[  306.340143] Preemption disabled at:
[  306.340143] [<ffffffffaa42c2fd>] deactivate_page+0x5d/0x110
...
[  306.340151] Call Trace:
[  306.340153]  dump_stack+0x50/0x70
[  306.340157]  ? deactivate_page+0x5d/0x110
[  306.340158]  __schedule_bug.cold+0x89/0x96
[  306.340160]  __schedule+0x576/0x860
[  306.340163]  ? _raw_spin_lock+0x13/0x30
[  306.340164]  schedule+0x43/0xd0
[  306.340166]  rt_spin_lock_slowlock_locked+0x117/0x2c0
[  306.340168]  ? __activate_page+0x2f0/0x2f0
[  306.340169]  rt_spin_lock_slowlock+0x51/0x80
[  306.340171]  pagevec_lru_move_fn+0x62/0xc0
[  306.340172]  deactivate_page+0xb3/0x110
[  306.340174]  madvise_cold_or_pageout_pte_range+0x277/0x2d0
[  306.340176]  ? free_unref_page_list+0x3ac/0x3c0
[  306.340177]  __walk_page_range+0x1f4/0x490
[  306.340181]  walk_page_range+0x89/0x110
[  306.340182]  madvise_cold+0x7e/0xc0
[  306.340183]  ? syscall_return_via_sysret+0xf/0x7f
[  306.340185]  ? __switch_to_asm+0x34/0x70
[  306.340186]  ? __switch_to_asm+0x40/0x70
[  306.340187]  ? __switch_to_asm+0x34/0x70
[  306.340188]  ? __switch_to_asm+0x40/0x70
[  306.340188]  ? _raw_spin_unlock_irq+0x17/0x50
[  306.340189]  ? find_vma+0x16/0x70
[  306.340190]  __do_sys_madvise+0x328/0x810
[  306.340193]  ? do_syscall_64+0x67/0x1f0
[  306.340195]  do_syscall_64+0x67/0x1f0
[  306.340196]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  306.340197] RIP: 0033:0x7f12e177510b

2154a0abcc9 ("mm: Revert the DEFINE_PER_CPU_PAGEVEC implementation")
reverted the lock/unlock_swap_pvec function, however, get_cpu_var()
was added back in deactivate_page(), actually, get_locked_var()
shall be used instead to avoid preempt_disable() call for RT.

Signed-off-by: Zanxiong Qiu <zqiu2000@126.com>
---
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

