Return-Path: <SRS0=GKw7=XP=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28802C3A5A2
	for <linux-rt-users@archiver.kernel.org>; Fri, 20 Sep 2019 21:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF6BE21907
	for <linux-rt-users@archiver.kernel.org>; Fri, 20 Sep 2019 21:56:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730606AbfITV4s (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 20 Sep 2019 17:56:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:47080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730473AbfITV4X (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 20 Sep 2019 17:56:23 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 215A9217F5;
        Fri, 20 Sep 2019 21:56:23 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1iBQt4-0005JL-96; Fri, 20 Sep 2019 17:56:22 -0400
Message-Id: <20190920215622.166520596@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 20 Sep 2019 17:53:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <wagi@monom.org>, tom.zanussi@linux.intel.com
Subject: [RFC][PATCH RT 5/7] revert-block
References: <20190920215311.165260719@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Revert swork version of: block: blk-mq: move blk_queue_usage_counter_release() into process context

In order to switch to upstream, we need to revert the swork code.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 block/blk-core.c       | 14 +-------------
 include/linux/blkdev.h |  2 --
 2 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index f7e16b4466f0..3f08d6fd0787 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -969,21 +969,12 @@ void blk_queue_exit(struct request_queue *q)
 	percpu_ref_put(&q->q_usage_counter);
 }
 
-static void blk_queue_usage_counter_release_swork(struct swork_event *sev)
-{
-	struct request_queue *q =
-		container_of(sev, struct request_queue, mq_pcpu_wake);
-
-	wake_up_all(&q->mq_freeze_wq);
-}
-
 static void blk_queue_usage_counter_release(struct percpu_ref *ref)
 {
 	struct request_queue *q =
 		container_of(ref, struct request_queue, q_usage_counter);
 
-	if (wq_has_sleeper(&q->mq_freeze_wq))
-		swork_queue(&q->mq_pcpu_wake);
+	wake_up_all(&q->mq_freeze_wq);
 }
 
 static void blk_rq_timed_out_timer(struct timer_list *t)
@@ -1080,7 +1071,6 @@ struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id,
 	queue_flag_set_unlocked(QUEUE_FLAG_BYPASS, q);
 
 	init_waitqueue_head(&q->mq_freeze_wq);
-	INIT_SWORK(&q->mq_pcpu_wake, blk_queue_usage_counter_release_swork);
 
 	/*
 	 * Init percpu_ref in atomic mode so that it's faster to shutdown.
@@ -3970,8 +3960,6 @@ int __init blk_dev_init(void)
 	if (!kblockd_workqueue)
 		panic("Failed to create kblockd\n");
 
-	BUG_ON(swork_get());
-
 	request_cachep = kmem_cache_create("blkdev_requests",
 			sizeof(struct request), 0, SLAB_PANIC, NULL);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 7b7c0bc6a514..f1960add94df 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -27,7 +27,6 @@
 #include <linux/percpu-refcount.h>
 #include <linux/scatterlist.h>
 #include <linux/blkzoned.h>
-#include <linux/swork.h>
 
 struct module;
 struct scsi_ioctl_command;
@@ -656,7 +655,6 @@ struct request_queue {
 #endif
 	struct rcu_head		rcu_head;
 	wait_queue_head_t	mq_freeze_wq;
-	struct swork_event	mq_pcpu_wake;
 	struct percpu_ref	q_usage_counter;
 	struct list_head	all_q_node;
 
-- 
2.20.1


