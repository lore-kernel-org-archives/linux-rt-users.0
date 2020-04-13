Return-Path: <SRS0=ow68=55=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67571C2BBC7
	for <linux-rt-users@archiver.kernel.org>; Mon, 13 Apr 2020 04:21:05 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 322D42072C
	for <linux-rt-users@archiver.kernel.org>; Mon, 13 Apr 2020 04:21:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 322D42072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-rt-users-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbgDMEUB (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 13 Apr 2020 00:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:58634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgDMEUA (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 13 Apr 2020 00:20:00 -0400
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33EE1C0A3BE0
        for <linux-rt-users@vger.kernel.org>; Sun, 12 Apr 2020 21:20:01 -0700 (PDT)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com [147.11.189.41])
        by mail1.windriver.com (8.15.2/8.15.2) with ESMTPS id 03D4IMPd007917
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=FAIL)
        for <linux-rt-users@vger.kernel.org>; Sun, 12 Apr 2020 21:18:22 -0700 (PDT)
Received: from pek-lpggp3.wrs.com (128.224.153.76) by ALA-HCB.corp.ad.wrs.com
 (147.11.189.41) with Microsoft SMTP Server id 14.3.487.0; Sun, 12 Apr 2020
 21:18:21 -0700
From:   Liwei Song <liwei.song@windriver.com>
To:     linux-rt <linux-rt-users@vger.kernel.org>
CC:     <liwei.song@windriver.com>
Subject: [PATCH RT] mm: do not warn for suspend when allocate memory on RT
Date:   Mon, 13 Apr 2020 12:18:17 +0800
Message-ID: <20200413041817.27514-1-liwei.song@windriver.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Interrupts are off during resume from RAM, this will triger a warning
when allocate memory in non-preemptible context on RT since commit
b5d5bc970f209 ("mm: Warn on memory allocation in non-preemptible
context on RT"), exclude suspend from this warning check.

Fixes: b5d5bc970f209 ("mm: Warn on memory allocation in non-preemptible context on RT")
Signed-off-by: Liwei Song <liwei.song@windriver.com>
---
 mm/slub.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 1929645daa53..ebff24ae50ea 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2771,7 +2771,8 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s,
 	unsigned long tid;
 
 	if (IS_ENABLED(CONFIG_PREEMPT_RT) && IS_ENABLED(CONFIG_DEBUG_ATOMIC_SLEEP))
-		WARN_ON_ONCE(!preemptible() && system_state >= SYSTEM_SCHEDULING);
+		WARN_ON_ONCE(!preemptible() && system_state >= SYSTEM_SCHEDULING &&
+				system_state != SYSTEM_SUSPEND);
 
 	s = slab_pre_alloc_hook(s, gfpflags);
 	if (!s)
@@ -3236,7 +3237,8 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 	int i;
 
 	if (IS_ENABLED(CONFIG_PREEMPT_RT) && IS_ENABLED(CONFIG_DEBUG_ATOMIC_SLEEP))
-		WARN_ON_ONCE(!preemptible() && system_state >= SYSTEM_SCHEDULING);
+		WARN_ON_ONCE(!preemptible() && system_state >= SYSTEM_SCHEDULING &&
+				system_state != SYSTEM_SUSPEND);
 
 	/* memcg and kmem_cache debug support */
 	s = slab_pre_alloc_hook(s, flags);
-- 
2.17.1

