Return-Path: <SRS0=P7c/=4J=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86383C35666
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 Feb 2020 21:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50BBF24650
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 Feb 2020 21:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582320366;
	bh=Nk7ieIw7uhXZur3CHmo8FQJnmX7WOV26wnY3gtojN5Y=;
	h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=LpVSo6h4tJ6HpUAiFwyzj3wqZRyF+gVhulQ9txMgCge3ffWRPp8u6EN0IdweeZ7WS
	 XWemIH/C4Tp4YBGrjdcApr6crtH7+SvuEiOFSklzn7b/2ZpUTaQcCzlCQ++Tds8zJn
	 ppuyHIDJOuvpHJRBVkb3i5DaZH0IqAvJ4ZWe8WZg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729666AbgBUVZi (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 21 Feb 2020 16:25:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:39406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729637AbgBUVZh (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 21 Feb 2020 16:25:37 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0D9F24691;
        Fri, 21 Feb 2020 21:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582320336;
        bh=Nk7ieIw7uhXZur3CHmo8FQJnmX7WOV26wnY3gtojN5Y=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=t2+l7r2v5eGPa1fJVGhheQhgtIDGXlbHp3exkiPBnJhalPX2vf3GIf03rxcpc1RYM
         eyb2ALnex4sBaaQqOltfzyCtOnEKl2NJ8NgEwnXS60GvNnG4B6m/f2g4Xm7f1oGxOw
         YIEWKO2MPcNbBOQ0f9Zj/Gno0WC8Gg/oY1ark/M0=
From:   zanussi@kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH RT 22/25] mm/memcontrol: Move misplaced local_unlock_irqrestore()
Date:   Fri, 21 Feb 2020 15:24:50 -0600
Message-Id: <960a2d2ccb60853d52f0dab91e391473dfa6035e.1582320278.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1582320278.git.zanussi@kernel.org>
References: <cover.1582320278.git.zanussi@kernel.org>
In-Reply-To: <cover.1582320278.git.zanussi@kernel.org>
References: <cover.1582320278.git.zanussi@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Matt Fleming <matt@codeblueprint.co.uk>

v4.14.170-rt75-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


[ Upstream commit 071a1d6a6e14d0dec240a8c67b425140d7f92f6a ]

The comment about local_lock_irqsave() mentions just the counters and
css_put_many()'s callback just invokes a worker so it is safe to move the
unlock function after memcg_check_events() so css_put_many() can be invoked
without the lock acquired.

Cc: Daniel Wagner <wagi@monom.org>
Signed-off-by: Matt Fleming <matt@codeblueprint.co.uk>
[bigeasy: rewrote the patch description]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 mm/memcontrol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 0503b31e2a87..a359a24ebd9f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6102,10 +6102,10 @@ void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
 	mem_cgroup_charge_statistics(memcg, page, PageTransHuge(page),
 				     -nr_entries);
 	memcg_check_events(memcg, page);
+	local_unlock_irqrestore(event_lock, flags);
 
 	if (!mem_cgroup_is_root(memcg))
 		css_put_many(&memcg->css, nr_entries);
-	local_unlock_irqrestore(event_lock, flags);
 }
 
 /**
-- 
2.14.1

