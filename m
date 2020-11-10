Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC93C5517A
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Nov 2020 15:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F12320797
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Nov 2020 15:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731125AbgKJPka (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 10 Nov 2020 10:40:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:36382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730988AbgKJPk1 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 10 Nov 2020 10:40:27 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEC8F2076E;
        Tue, 10 Nov 2020 15:40:26 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kcVkv-008eDk-9W; Tue, 10 Nov 2020 10:40:25 -0500
Message-ID: <20201110154025.158617782@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 10 Nov 2020 10:38:55 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        stable-rt@vger.kernel.org
Subject: [PATCH RT 2/5] mm/memcontrol: Disable preemption in __mod_memcg_lruvec_state()
References: <20201110153853.463368981@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

5.4.74-rt42-rc2 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

The callers expect disabled preemption/interrupts while invoking
__mod_memcg_lruvec_state(). This works mainline because a lock of
somekind is acquired.

Use preempt_disable_rt() where per-CPU variables are accessed and a
stable pointer is expected. This is also done in __mod_zone_page_state()
for the same reason.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 mm/memcontrol.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 9bdb75ef6d62..c9d02e2272e1 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -752,6 +752,7 @@ void __mod_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
 	memcg = pn->memcg;
 
+	preempt_disable_rt();
 	/* Update memcg */
 	__mod_memcg_state(memcg, idx, val);
 
@@ -767,6 +768,7 @@ void __mod_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 		x = 0;
 	}
 	__this_cpu_write(pn->lruvec_stat_cpu->count[idx], x);
+	preempt_enable_rt();
 }
 
 void __mod_lruvec_slab_state(void *p, enum node_stat_item idx, int val)
-- 
2.28.0


