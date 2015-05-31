From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 4.0-rt] blk/blk-core.c: fix warning for non-rt builds
Date: Sun, 31 May 2015 14:06:09 -0400
Message-ID: <1433095569-11766-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-rt-users@vger.kernel.org>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:61276 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758376AbbEaSIe (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 31 May 2015 14:08:34 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

To fix:
  block/blk-core.c:103:5: warning: "CONFIG_PREEMPT_RT_FULL" is not defined

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---

[please squash into block-mq-don-t-complete-requests-via-IPI.patch]

 block/blk-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index f8a4e9484eb3..ea9a9f41793d 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -100,7 +100,7 @@ void blk_rq_init(struct request_queue *q, struct request *rq)
 
 	INIT_LIST_HEAD(&rq->queuelist);
 	INIT_LIST_HEAD(&rq->timeout_list);
-#if CONFIG_PREEMPT_RT_FULL
+#ifdef CONFIG_PREEMPT_RT_FULL
 	INIT_WORK(&rq->work, __blk_mq_complete_request_remote_work);
 #endif
 	rq->cpu = -1;
-- 
2.2.1

