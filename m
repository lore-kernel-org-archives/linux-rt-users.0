Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC57CC25B0C
	for <linux-rt-users@archiver.kernel.org>; Mon,  8 Aug 2022 12:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243008AbiHHM4v (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 8 Aug 2022 08:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242005AbiHHM4m (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 8 Aug 2022 08:56:42 -0400
Received: from mail.infraroot.at (mail.infraroot.at [IPv6:2001:41d0:701:1100::afc])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80ACC5583
        for <linux-rt-users@vger.kernel.org>; Mon,  8 Aug 2022 05:56:41 -0700 (PDT)
Received: from localtoast.corp.sigma-star.at (unknown [82.150.214.1])
        by mail.infraroot.at (Postfix) with ESMTPSA id 5C44E416A6;
        Mon,  8 Aug 2022 14:56:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.infraroot.at 5C44E416A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infraroot.at;
        s=default; t=1659963399;
        bh=CMgh3pr6GL2N/zejbSB2FIVOGOefRGfoWDQiyPTC/MI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YWOjZcg+y7x16ZTqG9IOfCrWFwd4m1LC3sjfrTye6ZSPceS/6d0baKRgaBGieRqYA
         l6q2gnrUruBKjkc9g17Ot54wVmsHuHogmXSUoUf+DJniASTivwCjvTrJ6+4XBscEkR
         bS+cIhpyp+GIRibQkYq2La3UZ7Zz77sNzKQCmLso=
From:   David Oberhollenzer <goliath@infraroot.at>
To:     linux-rt-users@vger.kernel.org
Cc:     williams@redhat.com, bigeasy@linutronix.de, richard@nod.at,
        joseph.salisbury@canonical.com,
        David Oberhollenzer <goliath@infraroot.at>
Subject: [PATCH v2 07/10] mm/memcg: Add missing counter index which are not update in interrupt.
Date:   Mon,  8 Aug 2022 14:55:59 +0200
Message-Id: <20220808125602.97747-8-goliath@infraroot.at>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220808125602.97747-1-goliath@infraroot.at>
References: <20220808125602.97747-1-goliath@infraroot.at>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Shakeel Butt reported that I missed a few counters which are not updated
in-interrupt context and therefore disabling preemption is fine.

Please fold into:
     "Protect per-CPU counter by disabling preemption on PREEMPT_RT"

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
[do: backported to v5.15]
Signed-off-by: David Oberhollenzer <goliath@infraroot.at>
---
 mm/memcontrol.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4b5888bf0a60..50d2d5432018 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -774,10 +774,17 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 	 */
 	__memcg_stats_lock();
 	if (IS_ENABLED(CONFIG_DEBUG_VM)) {
-		if (idx == NR_ANON_MAPPED || idx == NR_FILE_MAPPED)
+		switch (idx) {
+		case NR_ANON_MAPPED:
+		case NR_FILE_MAPPED:
+		case NR_ANON_THPS:
+		case NR_SHMEM_PMDMAPPED:
+		case NR_FILE_PMDMAPPED:
 			WARN_ON_ONCE(!in_task());
-		else
+			break;
+		default:
 			WARN_ON_ONCE(!irqs_disabled());
+		}
 	}
 
 	/* Update memcg */
-- 
2.37.1

