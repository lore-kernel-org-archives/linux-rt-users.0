Return-Path: <SRS0=BA5Y=SK=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20436C10F14
	for <linux-rt-users@archiver.kernel.org>; Mon,  8 Apr 2019 19:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E83832087F
	for <linux-rt-users@archiver.kernel.org>; Mon,  8 Apr 2019 19:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554750937;
	bh=uvROHEpNp2NBptS+cCMC5UsCFczqwBdYKoGvYyEyhMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=BtcFslOBeFtS0SI6d0t+8Hs4xPTv8gEm1AXBGHzeNcZHc96Skhze0l7krqvgjHsCi
	 95SpufjPRZJJw8LGzEvp3CCvXC12wMaS2R9h3Isb3Y/5SxpLUWgBa9KtC/XvFvUoyk
	 GPxalBdoyzsw2Bs1zpdYkrskckU+ildOfQmzSXcY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfDHTO1 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 8 Apr 2019 15:14:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:45170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726921AbfDHTOZ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 8 Apr 2019 15:14:25 -0400
Received: from tzanussi-mobl.hsd1.il.comcast.net (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90B3E2148E;
        Mon,  8 Apr 2019 19:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554750865;
        bh=uvROHEpNp2NBptS+cCMC5UsCFczqwBdYKoGvYyEyhMw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=UkHmTBS711n8hyuEFVZYqba8WZm5mzNBkeBzGsaZpMwtDoGhUcuZqXK3tCms0eBBU
         zWuF9anI0tE2SkMDSBxeRbxkre3pDHdo44j1vFj0NrVF0LKEaTu0ZEEJApdnjgNiM+
         5844lH0KrjN1SKBClzUn6tdWaNLHXA5SNFNXFXoM=
From:   Tom Zanussi <zanussi@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Cc:     rostedt@goodmis.org, tglx@linutronix.de, C.Emde@osadl.org,
        jkacur@redhat.com, bigeasy@linutronix.de,
        daniel.wagner@siemens.com, julia@ni.com, amartin@nvidia.com
Subject: [PATCH 04/13] locking/rt-mutex: Flush block plug on __down_read()
Date:   Mon,  8 Apr 2019 14:14:06 -0500
Message-Id: <79f9717af336849789ff62bab08a5c05d78ae1f8.1554737688.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1554737688.git.tom.zanussi@linux.intel.com>
References: <cover.1554737688.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1554737688.git.tom.zanussi@linux.intel.com>
References: <cover.1554737688.git.tom.zanussi@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

4.14.109-rt58-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Scott Wood <swood@redhat.com>

[ Upstream commit 0d5d32425a0cab4a282dd79fc953d76a3ab17072 ]

__down_read() bypasses the rtmutex frontend to call
rt_mutex_slowlock_locked() directly, and thus it needs to call
blk_schedule_flush_flug() itself.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Scott Wood <swood@redhat.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>

 Conflicts:
	kernel/locking/rwsem-rt.c
---
 kernel/locking/rtmutex.c  | 2 +-
 kernel/locking/rwsem-rt.c | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 2cf515877b8e..1177f2815040 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1946,7 +1946,7 @@ rt_mutex_fastlock(struct rt_mutex *lock, int state,
 	 * If rt_mutex blocks, the function sched_submit_work will not call
 	 * blk_schedule_flush_plug (because tsk_is_pi_blocked would be true).
 	 * We must call blk_schedule_flush_plug here, if we don't call it,
-	 * a deadlock in device mapper may happen.
+	 * a deadlock in I/O may happen.
 	 */
 	if (unlikely(blk_needs_flush_plug(current)))
 		blk_schedule_flush_plug(current);
diff --git a/kernel/locking/rwsem-rt.c b/kernel/locking/rwsem-rt.c
index 26991ddb6c5a..dbdde2476b1c 100644
--- a/kernel/locking/rwsem-rt.c
+++ b/kernel/locking/rwsem-rt.c
@@ -1,5 +1,6 @@
 /*
  */
+#include <linux/blkdev.h>
 #include <linux/rwsem.h>
 #include <linux/sched/debug.h>
 #include <linux/sched/signal.h>
@@ -86,6 +87,14 @@ void __sched __down_read(struct rw_semaphore *sem)
 
 	if (__down_read_trylock(sem))
 		return;
+	/*
+	 * If rt_mutex blocks, the function sched_submit_work will not call
+	 * blk_schedule_flush_plug (because tsk_is_pi_blocked would be true).
+	 * We must call blk_schedule_flush_plug here, if we don't call it,
+	 * a deadlock in I/O may happen.
+	 */
+	if (unlikely(blk_needs_flush_plug(current)))
+		blk_schedule_flush_plug(current);
 
 	might_sleep();
 	raw_spin_lock_irq(&m->wait_lock);
-- 
2.14.1

