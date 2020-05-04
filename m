Return-Path: <SRS0=LbvN=6S=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E057FC47257
	for <linux-rt-users@archiver.kernel.org>; Mon,  4 May 2020 14:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEAFA206D9
	for <linux-rt-users@archiver.kernel.org>; Mon,  4 May 2020 14:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbgEDOxc (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 4 May 2020 10:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728597AbgEDOxa (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 4 May 2020 10:53:30 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F21BC061A0E
        for <linux-rt-users@vger.kernel.org>; Mon,  4 May 2020 07:53:30 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jVcTF-0007Sc-AP; Mon, 04 May 2020 16:53:25 +0200
Date:   Mon, 4 May 2020 16:53:25 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Liwei Song <liwei.song@windriver.com>
Cc:     linux-rt <linux-rt-users@vger.kernel.org>,
        Mike Galbraith <efault@gmx.de>
Subject: [PATCH RT] mm: Don't warn about atomic memory allocations during
 suspend
Message-ID: <20200504145325.3rjc3iskg2coejje@linutronix.de>
References: <20200413041817.27514-1-liwei.song@windriver.com>
 <20200416170943.hjoytlggvfzzdqjt@linutronix.de>
 <8cd11f67-dbf8-cce9-548f-ccc544f9486c@windriver.com>
 <20200421145147.lejozjuvjjd4nmyf@linutronix.de>
 <0662fa80-3dbd-3b47-3677-f22716f5661f@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0662fa80-3dbd-3b47-3677-f22716f5661f@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Liwei Song <liwei.song@windriver.com>

The ACPI code allocates larger amount of memory during resume. This
triggers a warning because the allocation happens with disabled
interrupts.
At this stage only one CPU is active so there should be no lock
contention. If SLUB needs to call into the buddy allocator for more
memory then it should not enable interrupts.

Limit the check to system state with more CPUs and scheduling and only
enable interrupts in SLUB at this stage.

Signed-off-by: Liwei Song <liwei.song@windriver.com>
[bigeasy: commit description, allocate_slab() hunk]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---

Are you okay with this Liwei?

 mm/slub.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 15c194ff16e6e..6ea1057edf1ab 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1655,7 +1655,7 @@ static struct page *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 		enableirqs = true;
 
 #ifdef CONFIG_PREEMPT_RT
-	if (system_state > SYSTEM_BOOTING)
+	if (system_state > SYSTEM_BOOTING && system_state < SYSTEM_SUSPEND)
 		enableirqs = true;
 #endif
 	if (enableirqs)
@@ -2771,7 +2771,8 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s,
 	unsigned long tid;
 
 	if (IS_ENABLED(CONFIG_PREEMPT_RT) && IS_ENABLED(CONFIG_DEBUG_ATOMIC_SLEEP))
-		WARN_ON_ONCE(!preemptible() && system_state >= SYSTEM_SCHEDULING);
+		WARN_ON_ONCE(!preemptible() &&
+			     (system_state > SYSTEM_BOOTING && system_state < SYSTEM_SUSPEND));
 
 	s = slab_pre_alloc_hook(s, gfpflags);
 	if (!s)
@@ -3236,7 +3237,8 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 	int i;
 
 	if (IS_ENABLED(CONFIG_PREEMPT_RT) && IS_ENABLED(CONFIG_DEBUG_ATOMIC_SLEEP))
-		WARN_ON_ONCE(!preemptible() && system_state >= SYSTEM_SCHEDULING);
+		WARN_ON_ONCE(!preemptible() &&
+			     (system_state > SYSTEM_BOOTING && system_state < SYSTEM_SUSPEND));
 
 	/* memcg and kmem_cache debug support */
 	s = slab_pre_alloc_hook(s, flags);
-- 
2.26.2

