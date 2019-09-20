Return-Path: <SRS0=GKw7=XP=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF60C3A5A2
	for <linux-rt-users@archiver.kernel.org>; Fri, 20 Sep 2019 21:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1448A218AE
	for <linux-rt-users@archiver.kernel.org>; Fri, 20 Sep 2019 21:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730593AbfITV4i (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 20 Sep 2019 17:56:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:47104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730488AbfITV4Y (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 20 Sep 2019 17:56:24 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C3822184C;
        Fri, 20 Sep 2019 21:56:23 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1iBQt4-0005Jp-FK; Fri, 20 Sep 2019 17:56:22 -0400
Message-Id: <20190920215622.351085938@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 20 Sep 2019 17:53:17 -0400
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
Subject: [RFC][PATCH RT 6/7] block: blk-mq: move blk_queue_usage_counter_release() into process
 context
References: <20190920215311.165260719@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit 61c928ecf4fe200bda9b49a0813b5ba0f43995b5 ]

| BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:914
| in_atomic(): 1, irqs_disabled(): 0, pid: 255, name: kworker/u257:6
| 5 locks held by kworker/u257:6/255:
|  #0:  ("events_unbound"){.+.+.+}, at: [<ffffffff8108edf1>] process_one_work+0x171/0x5e0
|  #1:  ((&entry->work)){+.+.+.}, at: [<ffffffff8108edf1>] process_one_work+0x171/0x5e0
|  #2:  (&shost->scan_mutex){+.+.+.}, at: [<ffffffffa000faa3>] __scsi_add_device+0xa3/0x130 [scsi_mod]
|  #3:  (&set->tag_list_lock){+.+...}, at: [<ffffffff812f09fa>] blk_mq_init_queue+0x96a/0xa50
|  #4:  (rcu_read_lock_sched){......}, at: [<ffffffff8132887d>] percpu_ref_kill_and_confirm+0x1d/0x120
| Preemption disabled at:[<ffffffff812eff76>] blk_mq_freeze_queue_start+0x56/0x70
|
| CPU: 2 PID: 255 Comm: kworker/u257:6 Not tainted 3.18.7-rt0+ #1
| Workqueue: events_unbound async_run_entry_fn
|  0000000000000003 ffff8800bc29f998 ffffffff815b3a12 0000000000000000
|  0000000000000000 ffff8800bc29f9b8 ffffffff8109aa16 ffff8800bc29fa28
|  ffff8800bc5d1bc8 ffff8800bc29f9e8 ffffffff815b8dd4 ffff880000000000
| Call Trace:
|  [<ffffffff815b3a12>] dump_stack+0x4f/0x7c
|  [<ffffffff8109aa16>] __might_sleep+0x116/0x190
|  [<ffffffff815b8dd4>] rt_spin_lock+0x24/0x60
|  [<ffffffff810b6089>] __wake_up+0x29/0x60
|  [<ffffffff812ee06e>] blk_mq_usage_counter_release+0x1e/0x20
|  [<ffffffff81328966>] percpu_ref_kill_and_confirm+0x106/0x120
|  [<ffffffff812eff76>] blk_mq_freeze_queue_start+0x56/0x70
|  [<ffffffff812f0000>] blk_mq_update_tag_set_depth+0x40/0xd0
|  [<ffffffff812f0a1c>] blk_mq_init_queue+0x98c/0xa50
|  [<ffffffffa000dcf0>] scsi_mq_alloc_queue+0x20/0x60 [scsi_mod]
|  [<ffffffffa000ea35>] scsi_alloc_sdev+0x2f5/0x370 [scsi_mod]
|  [<ffffffffa000f494>] scsi_probe_and_add_lun+0x9e4/0xdd0 [scsi_mod]
|  [<ffffffffa000fb26>] __scsi_add_device+0x126/0x130 [scsi_mod]
|  [<ffffffffa013033f>] ata_scsi_scan_host+0xaf/0x200 [libata]
|  [<ffffffffa012b5b6>] async_port_probe+0x46/0x60 [libata]
|  [<ffffffff810978fb>] async_run_entry_fn+0x3b/0xf0
|  [<ffffffff8108ee81>] process_one_work+0x201/0x5e0

percpu_ref_kill_and_confirm() invokes blk_mq_usage_counter_release() in
a rcu-sched region. swait based wake queue can't be used due to
wake_up_all() usage and disabled interrupts in !RT configs (as reported
by Corey Minyard).
The wq_has_sleeper() check has been suggested by Peter Zijlstra.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 block/blk-core.c       | 12 +++++++++++-
 include/linux/blkdev.h |  2 ++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 3f08d6fd0787..8d4c5d69c5c4 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -969,12 +969,21 @@ void blk_queue_exit(struct request_queue *q)
 	percpu_ref_put(&q->q_usage_counter);
 }
 
+static void blk_queue_usage_counter_release_wrk(struct kthread_work *work)
+{
+	struct request_queue *q =
+		container_of(work, struct request_queue, mq_pcpu_wake);
+
+	wake_up_all(&q->mq_freeze_wq);
+}
+
 static void blk_queue_usage_counter_release(struct percpu_ref *ref)
 {
 	struct request_queue *q =
 		container_of(ref, struct request_queue, q_usage_counter);
 
-	wake_up_all(&q->mq_freeze_wq);
+	if (wq_has_sleeper(&q->mq_freeze_wq))
+		kthread_schedule_work(&q->mq_pcpu_wake);
 }
 
 static void blk_rq_timed_out_timer(struct timer_list *t)
@@ -1071,6 +1080,7 @@ struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id,
 	queue_flag_set_unlocked(QUEUE_FLAG_BYPASS, q);
 
 	init_waitqueue_head(&q->mq_freeze_wq);
+	kthread_init_work(&q->mq_pcpu_wake, blk_queue_usage_counter_release_wrk);
 
 	/*
 	 * Init percpu_ref in atomic mode so that it's faster to shutdown.
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index f1960add94df..15a489abfb62 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -13,6 +13,7 @@
 #include <linux/llist.h>
 #include <linux/timer.h>
 #include <linux/workqueue.h>
+#include <linux/kthread.h>
 #include <linux/pagemap.h>
 #include <linux/backing-dev-defs.h>
 #include <linux/wait.h>
@@ -655,6 +656,7 @@ struct request_queue {
 #endif
 	struct rcu_head		rcu_head;
 	wait_queue_head_t	mq_freeze_wq;
+	struct kthread_work	mq_pcpu_wake;
 	struct percpu_ref	q_usage_counter;
 	struct list_head	all_q_node;
 
-- 
2.20.1


