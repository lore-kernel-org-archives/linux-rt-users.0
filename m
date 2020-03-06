Return-Path: <SRS0=FXzI=4X=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99050C10DCE
	for <linux-rt-users@archiver.kernel.org>; Fri,  6 Mar 2020 16:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7757A208CD
	for <linux-rt-users@archiver.kernel.org>; Fri,  6 Mar 2020 16:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgCFQDR (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 6 Mar 2020 11:03:17 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:54031 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbgCFQDR (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 6 Mar 2020 11:03:17 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jAFRT-0007xt-5f; Fri, 06 Mar 2020 17:03:15 +0100
Date:   Fri, 6 Mar 2020 17:03:15 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-rt-users@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH RT] mm: Warn on memory allocation in non-preemptible context
 on RT
Message-ID: <20200306160315.irbxjl3md4edsf7x@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The memory allocation via kmalloc(, GFP_ATOMIC) in atomic context
(disabled preemption or interrupts) is not allowed on RT because the
buddy allocator is using sleeping locks which can't be acquired in this
context.
Such an an allocation may not trigger a warning in the buddy allocator
if it is always satisfied in the SLUB allocator.

Add a warning on RT if a memory allocation was attempted in not
preemptible region.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 mm/slub.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/slub.c b/mm/slub.c
index 2cff48d13e3a7..7b2773c45e1ff 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2742,6 +2742,9 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s,
 	struct page *page;
 	unsigned long tid;
 
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && IS_ENABLED(CONFIG_DEBUG_ATOMIC_SLEEP))
+		WARN_ON_ONCE(!preemptible() && system_state >= SYSTEM_SCHEDULING);
+
 	s = slab_pre_alloc_hook(s, gfpflags);
 	if (!s)
 		return NULL;
@@ -3202,6 +3205,9 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 	LIST_HEAD(to_free);
 	int i;
 
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && IS_ENABLED(CONFIG_DEBUG_ATOMIC_SLEEP))
+		WARN_ON_ONCE(!preemptible() && system_state >= SYSTEM_SCHEDULING);
+
 	/* memcg and kmem_cache debug support */
 	s = slab_pre_alloc_hook(s, flags);
 	if (unlikely(!s))
-- 
2.25.1

