Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0FFC433E0
	for <linux-rt-users@archiver.kernel.org>; Tue, 16 Feb 2021 08:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B2C064E04
	for <linux-rt-users@archiver.kernel.org>; Tue, 16 Feb 2021 08:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbhBPI3j (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 16 Feb 2021 03:29:39 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37614 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbhBPI3Q (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 16 Feb 2021 03:29:16 -0500
Date:   Tue, 16 Feb 2021 09:28:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613464110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=sxTm2e9lioefjFW5+NcOah0NJ3vVwBkcVFVUyPwkQ0o=;
        b=lGLWOC/qttpfp0v5PNuwCxzErqu3U9EQIfrzXEKrga6f05CTaA7gZSq4DitDrkOa9riJln
        RiHW88vgtqU7EC6K82URpkimQUbAno7XR5x8WZtz4W8q+SrrdinxSyWVsnWQ90phPmtd4Q
        f2F6ksTPj/cyWf1ZIFp9b8IAUzvFMteuZmThwQ265SmuYSIkJxNygCnqKmkS+UicfFtpfV
        w49lfICuvsqThTB+WXBKdpkECWFAKWzHlmGq+8RtDQrN6ed/l818TH+rLWcWc+o1wdKQtT
        3GRn3YOz7uzGD0cjyVE//TZqw2YLYp49tjHaDJb0PbV7eAcfEGVIlnnx5SXGTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613464110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=sxTm2e9lioefjFW5+NcOah0NJ3vVwBkcVFVUyPwkQ0o=;
        b=Ezq+zNoMnn2my87N1Prv1TCVtewcYblRmdXaWGdFaRSF9mlKIy6Q7t8bkyU8bjg21c5yrR
        Fd57s6jx4jOCcvBQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.10.16-rt30
Message-ID: <20210216082829.4mgsu42tfuo7mgzq@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.10.16-rt30 patch set. 

Changes since v5.10.16-rt29:

  - Due to recent softirq rework it was not possible to compile a kernel
    with RT && !SMP. Reported by Jonathan Schwender, patch by Christian
    Eggers.

  - Update the block-mq patches to the version, that has been staged for
    upstream.

Known issues
     - kdb/kgdb can easily deadlock.
     - kmsg dumpers expecting not to be called in parallel can clobber
       their temp buffer.
     - netconsole triggers WARN.

The delta patch against v5.10.16-rt29 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.10/incr/patch-5.10.16-rt29-rt30.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.10.16-rt30

The RT patch against v5.10.16 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10.16-rt30.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patches-5.10.16-rt30.tar.xz

Sebastian

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 5b27fd6c8c7c2..b293f74ea8cad 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -565,15 +565,12 @@ void blk_mq_end_request(struct request *rq, blk_status_t error)
 }
 EXPORT_SYMBOL(blk_mq_end_request);
 
-static void blk_complete_reqs(struct llist_head *cpu_list)
+static void blk_complete_reqs(struct llist_head *list)
 {
-	struct llist_node *entry;
-	struct request *rq, *rq_next;
+	struct llist_node *entry = llist_reverse_order(llist_del_all(list));
+	struct request *rq, *next;
 
-	entry = llist_del_all(cpu_list);
-	entry = llist_reverse_order(entry);
-
-	llist_for_each_entry_safe(rq, rq_next, entry, ipi_list)
+	llist_for_each_entry_safe(rq, next, entry, ipi_list)
 		rq->q->mq_ops->complete(rq);
 }
 
@@ -619,9 +616,34 @@ static inline bool blk_mq_complete_need_ipi(struct request *rq)
 	return cpu_online(rq->mq_ctx->cpu);
 }
 
+static void blk_mq_complete_send_ipi(struct request *rq)
+{
+	struct llist_head *list;
+	unsigned int cpu;
+
+	cpu = rq->mq_ctx->cpu;
+	list = &per_cpu(blk_cpu_done, cpu);
+	if (llist_add(&rq->ipi_list, list)) {
+		rq->csd.func = __blk_mq_complete_request_remote;
+		rq->csd.info = rq;
+		rq->csd.flags = 0;
+		smp_call_function_single_async(cpu, &rq->csd);
+	}
+}
+
+static void blk_mq_raise_softirq(struct request *rq)
+{
+	struct llist_head *list;
+
+	preempt_disable();
+	list = this_cpu_ptr(&blk_cpu_done);
+	if (llist_add(&rq->ipi_list, list))
+		raise_softirq(BLOCK_SOFTIRQ);
+	preempt_enable();
+}
+
 bool blk_mq_complete_request_remote(struct request *rq)
 {
-	struct llist_head *cpu_list;
 	WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);
 
 	/*
@@ -632,27 +654,15 @@ bool blk_mq_complete_request_remote(struct request *rq)
 		return false;
 
 	if (blk_mq_complete_need_ipi(rq)) {
-		unsigned int cpu;
-
-		cpu = rq->mq_ctx->cpu;
-		cpu_list = &per_cpu(blk_cpu_done, cpu);
-		if (llist_add(&rq->ipi_list, cpu_list)) {
-			rq->csd.func = __blk_mq_complete_request_remote;
-			rq->csd.flags = 0;
-			smp_call_function_single_async(cpu, &rq->csd);
-		}
-	} else {
-		if (rq->q->nr_hw_queues > 1)
-			return false;
-
-		preempt_disable();
-		cpu_list = this_cpu_ptr(&blk_cpu_done);
-		if (llist_add(&rq->ipi_list, cpu_list))
-			raise_softirq(BLOCK_SOFTIRQ);
-		preempt_enable();
+		blk_mq_complete_send_ipi(rq);
+		return true;
 	}
 
-	return true;
+	if (rq->q->nr_hw_queues == 1) {
+		blk_mq_raise_softirq(rq);
+		return true;
+	}
+	return false;
 }
 EXPORT_SYMBOL_GPL(blk_mq_complete_request_remote);
 
diff --git a/kernel/smp.c b/kernel/smp.c
index 4d17501433be7..23778281aaa70 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -14,6 +14,7 @@
 #include <linux/export.h>
 #include <linux/percpu.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/gfp.h>
 #include <linux/smp.h>
 #include <linux/cpu.h>
@@ -449,6 +450,19 @@ void flush_smp_call_function_from_idle(void)
 
 	local_irq_save(flags);
 	flush_smp_call_function_queue(true);
+
+	if (local_softirq_pending()) {
+
+		if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
+			do_softirq();
+		} else {
+			struct task_struct *ksoftirqd = this_cpu_ksoftirqd();
+
+			if (ksoftirqd && ksoftirqd->state != TASK_RUNNING)
+				wake_up_process(ksoftirqd);
+		}
+	}
+
 	local_irq_restore(flags);
 }
 
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 3efa760417280..f0074f1344402 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -867,7 +867,7 @@ void tasklet_kill(struct tasklet_struct *t)
 }
 EXPORT_SYMBOL(tasklet_kill);
 
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT)
 void tasklet_unlock(struct tasklet_struct *t)
 {
 	smp_mb__before_atomic();
diff --git a/localversion-rt b/localversion-rt
index 90290c642ed52..b72862e06be43 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt29
+-rt30
