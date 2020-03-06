Return-Path: <SRS0=FXzI=4X=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26189C10F25
	for <linux-rt-users@archiver.kernel.org>; Fri,  6 Mar 2020 18:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F36D720866
	for <linux-rt-users@archiver.kernel.org>; Fri,  6 Mar 2020 18:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgCFSky (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 6 Mar 2020 13:40:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:55942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbgCFSkx (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 6 Mar 2020 13:40:53 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8774620717;
        Fri,  6 Mar 2020 18:40:53 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jAHu0-002dzZ-FS; Fri, 06 Mar 2020 13:40:52 -0500
Message-Id: <20200306184052.332769343@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 06 Mar 2020 13:40:39 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        Matt Fleming <matt@codeblueprint.co.uk>
Subject: [PATCH RT 4/8] mm/memcontrol: Move misplaced local_unlock_irqrestore()
References: <20200306184035.948924528@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

4.19.106-rt45-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Matt Fleming <matt@codeblueprint.co.uk>

[ Upstream commit 071a1d6a6e14d0dec240a8c67b425140d7f92f6a ]

The comment about local_lock_irqsave() mentions just the counters and
css_put_many()'s callback just invokes a worker so it is safe to move the
unlock function after memcg_check_events() so css_put_many() can be invoked
without the lock acquired.

Cc: Daniel Wagner <wagi@monom.org>
Signed-off-by: Matt Fleming <matt@codeblueprint.co.uk>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
[bigeasy: rewrote the patch description]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 mm/memcontrol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 421ac74450f6..519528959eef 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6540,10 +6540,10 @@ void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
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
2.25.0


