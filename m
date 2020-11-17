Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D58AC56202
	for <linux-rt-users@archiver.kernel.org>; Tue, 17 Nov 2020 17:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBFA324654
	for <linux-rt-users@archiver.kernel.org>; Tue, 17 Nov 2020 17:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hyVhRArx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbgKQRTx (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 17 Nov 2020 12:19:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:58830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbgKQRTw (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 17 Nov 2020 12:19:52 -0500
Received: from localhost.localdomain (c-73-209-127-30.hsd1.il.comcast.net [73.209.127.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F098624654;
        Tue, 17 Nov 2020 17:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605633592;
        bh=daJLU3n02mJ6i0JpeUafqSjeQahZMcJAuVKF7BfNorg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=hyVhRArxhBJv1lLMLg8aDWsMd+avk0FDIhgJpBPiQwzCrafHBqfbGejiDZ9gAyP38
         1MHHzFHMseNIb/8M3noYXl8kRMSi95ZCa8mr/9wJnvORzdYmJ4DKfwVvuwX8h8yGg1
         JmzQVLzGM7O9LOqPrJaKIrXkWUtUPcvJCaHk/cqw=
From:   zanussi@kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>, Tom Zanussi <zanussi@kernel.org>
Cc:     stable-rt@vger.kernel.org
Subject: [PATCH RT 1/3] mm/memcontrol: Disable preemption in __mod_memcg_lruvec_state()
Date:   Tue, 17 Nov 2020 11:19:46 -0600
Message-Id: <46fc7bbf28dfbafd2f6e87b736458c4ba060728c.1605633581.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1605633581.git.zanussi@kernel.org>
References: <cover.1605633581.git.zanussi@kernel.org>
In-Reply-To: <cover.1605633581.git.zanussi@kernel.org>
References: <cover.1605633581.git.zanussi@kernel.org>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

v4.19.152-rt66-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


[ Upstream commit 74858f0d38a8d3c069a0745ff53ae084c8e7cabb ]

The callers expect disabled preemption/interrupts while invoking
__mod_memcg_lruvec_state(). This works mainline because a lock of
somekind is acquired.

Use preempt_disable_rt() where per-CPU variables are accessed and a
stable pointer is expected. This is also done in __mod_zone_page_state()
for the same reason.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>

 Conflicts:
	mm/memcontrol.c
---
 include/linux/memcontrol.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index cc6b6532eb56..dbb2c4e27277 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -665,6 +665,7 @@ static inline void __mod_lruvec_state(struct lruvec *lruvec,
 
 	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
 
+	preempt_disable_rt();
 	/* Update memcg */
 	__mod_memcg_state(pn->memcg, idx, val);
 
@@ -675,6 +676,7 @@ static inline void __mod_lruvec_state(struct lruvec *lruvec,
 		x = 0;
 	}
 	__this_cpu_write(pn->lruvec_stat_cpu->count[idx], x);
+	preempt_enable_rt();
 }
 
 static inline void mod_lruvec_state(struct lruvec *lruvec,
-- 
2.17.1

