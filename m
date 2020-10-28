Return-Path: <SRS0=4gYA=EE=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE4BC388F7
	for <linux-rt-users@archiver.kernel.org>; Thu, 29 Oct 2020 02:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A7E82076B
	for <linux-rt-users@archiver.kernel.org>; Thu, 29 Oct 2020 02:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JLLV+L2V";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZPZXAQ7X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgJ1Ve3 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 28 Oct 2020 17:34:29 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57292 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbgJ1Ve2 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 28 Oct 2020 17:34:28 -0400
Date:   Wed, 28 Oct 2020 21:17:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603916273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=KzbJNYabc9NFX7hq5cJ3Ez++H2iOGcEOzca4Ca4c7+c=;
        b=JLLV+L2VEvtSwjKqfR1cBgnv5MEJk9peX5gO0ZuUjnSv8HeUejUnI87aaE9s2FEZJ2EDxY
        LPBDfbsHI2czXyaV1N83Sh5iDJf3WBhl35sv7pmma+l1vFkwE7UQ7FhC4xDR49Gm05sWXp
        DhwmMk7iwtgzT8hcYmF40LbbgP3h+AZjEsa3yf5vRtNZW59Kp5QPTPCai0RdtOEtwMspcr
        0hK0fZS184jcAnMTp/Emx2P5pNTEZ8tnewCgb91rikZiNlhaqQq1BjNrC6Ers0iyuUFhgH
        AhrXa5LhYlQgOMw+YG2Cx9APG7D2DLQQxkNErQ9bT91b/5qsJYpLd5LrUKxl7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603916273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=KzbJNYabc9NFX7hq5cJ3Ez++H2iOGcEOzca4Ca4c7+c=;
        b=ZPZXAQ7X8/NqiW+9jPAEhXcaZf9VW2PLBuXPH2PeFx8Bqyo1ZYlH1gK81oOi5sBOZMNfCD
        I6MZR/t4Tb4VoJDA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.9.1-rt20
Message-ID: <20201028201751.mubvosvimcv4ftjv@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.9.1-rt20 patch set. 

Changes since v5.9.1-rt19:

  - Tiny update to the rtmutex patches (make __read_rt_trylock()
    static).

  - The test_lockup module failed to compile. Reported by Fernando
    Lopez-Lezcano.

  - The `kcompactd' daemon together with MEMCG could have accessed
    per-CPU variables in preemtible context.

  - The patch for the crash in the block layer (previously reported by
    David Runge) has been replaced with another set of patches which
    were submitted upstream.

Known issues
     - It has been pointed out that due to changes to the printk code the
       internal buffer representation changed. This is only an issue if tools
       like `crash' are used to extract the printk buffer from a kernel memory
       image.

The delta patch against v5.9.1-rt19 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.9/incr/patch-5.9.1-rt19-rt20.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.9.1-rt20

The RT patch against v5.9.1 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.9/older/patch-5.9.1-rt20.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.9/older/patches-5.9.1-rt20.tar.xz

Sebastian
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 99d2fb51e0e84..1f9b312595a19 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -41,7 +41,7 @@
 #include "blk-mq-sched.h"
 #include "blk-rq-qos.h"
 
-static DEFINE_PER_CPU(struct list_head, blk_cpu_done);
+static DEFINE_PER_CPU(struct llist_head, blk_cpu_done);
 
 static void blk_mq_poll_stats_start(struct request_queue *q);
 static void blk_mq_poll_stats_fn(struct blk_stat_callback *cb);
@@ -565,91 +565,49 @@ void blk_mq_end_request(struct request *rq, blk_status_t error)
 }
 EXPORT_SYMBOL(blk_mq_end_request);
 
-/*
- * Softirq action handler - move entries to local list and loop over them
- * while passing them to the queue registered handler.
- */
-static __latent_entropy void blk_done_softirq(struct softirq_action *h)
+static void blk_complete_reqs(struct llist_head *cpu_list)
 {
-	struct list_head *cpu_list, local_list;
+	struct llist_node *entry;
+	struct request *rq, *rq_next;
 
-	local_irq_disable();
-	cpu_list = this_cpu_ptr(&blk_cpu_done);
-	list_replace_init(cpu_list, &local_list);
-	local_irq_enable();
+	entry = llist_del_all(cpu_list);
+	entry = llist_reverse_order(entry);
 
-	while (!list_empty(&local_list)) {
-		struct request *rq;
-
-		rq = list_entry(local_list.next, struct request, ipi_list);
-		list_del_init(&rq->ipi_list);
+	llist_for_each_entry_safe(rq, rq_next, entry, ipi_list)
 		rq->q->mq_ops->complete(rq);
-	}
 }
 
-static void blk_mq_trigger_softirq(struct request *rq)
+static __latent_entropy void blk_done_softirq(struct softirq_action *h)
 {
-	struct list_head *list;
-	unsigned long flags;
-
-	local_irq_save(flags);
-	list = this_cpu_ptr(&blk_cpu_done);
-	list_add_tail(&rq->ipi_list, list);
-
-	/*
-	 * If the list only contains our just added request, signal a raise of
-	 * the softirq.  If there are already entries there, someone already
-	 * raised the irq but it hasn't run yet.
-	 */
-	if (list->next == &rq->ipi_list)
-		raise_softirq_irqoff(BLOCK_SOFTIRQ);
-	local_irq_restore(flags);
-	preempt_check_resched_rt();
+	blk_complete_reqs(this_cpu_ptr(&blk_cpu_done));
 }
 
 static int blk_softirq_cpu_dead(unsigned int cpu)
 {
-	/*
-	 * If a CPU goes away, splice its entries to the current CPU
-	 * and trigger a run of the softirq
-	 */
-	local_irq_disable();
-	list_splice_init(&per_cpu(blk_cpu_done, cpu),
-			 this_cpu_ptr(&blk_cpu_done));
-	raise_softirq_irqoff(BLOCK_SOFTIRQ);
-	local_irq_enable();
-	preempt_check_resched_rt();
-
+	blk_complete_reqs(&per_cpu(blk_cpu_done, cpu));
 	return 0;
 }
 
-
 static void __blk_mq_complete_request_remote(void *data)
 {
-	struct request *rq = data;
-
-	/*
-	 * For most of single queue controllers, there is only one irq vector
-	 * for handling I/O completion, and the only irq's affinity is set
-	 * to all possible CPUs.  On most of ARCHs, this affinity means the irq
-	 * is handled on one specific CPU.
-	 *
-	 * So complete I/O requests in softirq context in case of single queue
-	 * devices to avoid degrading I/O performance due to irqsoff latency.
-	 */
-	if (rq->q->nr_hw_queues == 1)
-		blk_mq_trigger_softirq(rq);
-	else
-		rq->q->mq_ops->complete(rq);
+	__raise_softirq_irqoff(BLOCK_SOFTIRQ);
 }
 
 static inline bool blk_mq_complete_need_ipi(struct request *rq)
 {
 	int cpu = raw_smp_processor_id();
 
-	if (!IS_ENABLED(CONFIG_SMP) || IS_ENABLED(CONFIG_PREEMPT_RT) ||
+	if (!IS_ENABLED(CONFIG_SMP) ||
 	    !test_bit(QUEUE_FLAG_SAME_COMP, &rq->q->queue_flags))
 		return false;
+	/*
+	 * With force threaded interrupts enabled, raising softirq from an SMP
+	 * function call will always result in waking the ksoftirqd thread.
+	 * This is probably worse than completing the request on a different
+	 * cache domain.
+	 */
+	if (force_irqthreads)
+		return false;
 
 	/* same CPU or cache domain?  Complete locally */
 	if (cpu == rq->mq_ctx->cpu ||
@@ -663,6 +621,7 @@ static inline bool blk_mq_complete_need_ipi(struct request *rq)
 
 bool blk_mq_complete_request_remote(struct request *rq)
 {
+	struct llist_head *cpu_list;
 	WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);
 
 	/*
@@ -673,14 +632,21 @@ bool blk_mq_complete_request_remote(struct request *rq)
 		return false;
 
 	if (blk_mq_complete_need_ipi(rq)) {
-		rq->csd.func = __blk_mq_complete_request_remote;
-		rq->csd.info = rq;
-		rq->csd.flags = 0;
-		smp_call_function_single_async(rq->mq_ctx->cpu, &rq->csd);
+		unsigned int cpu;
+
+		cpu = rq->mq_ctx->cpu;
+		cpu_list = &per_cpu(blk_cpu_done, cpu);
+		if (llist_add(&rq->ipi_list, cpu_list)) {
+			rq->csd.func = __blk_mq_complete_request_remote;
+			rq->csd.flags = 0;
+			smp_call_function_single_async(cpu, &rq->csd);
+		}
 	} else {
 		if (rq->q->nr_hw_queues > 1)
 			return false;
-		blk_mq_trigger_softirq(rq);
+		cpu_list = this_cpu_ptr(&blk_cpu_done);
+		if (llist_add(&rq->ipi_list, cpu_list))
+			raise_softirq(BLOCK_SOFTIRQ);
 	}
 
 	return true;
@@ -3883,7 +3849,7 @@ static int __init blk_mq_init(void)
 	int i;
 
 	for_each_possible_cpu(i)
-		INIT_LIST_HEAD(&per_cpu(blk_cpu_done, i));
+		init_llist_head(&per_cpu(blk_cpu_done, i));
 	open_softirq(BLOCK_SOFTIRQ, blk_done_softirq);
 
 	cpuhp_setup_state_nocalls(CPUHP_BLOCK_SOFTIRQ_DEAD,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 868e11face00e..28231798f1613 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -154,7 +154,7 @@ struct request {
 	 */
 	union {
 		struct hlist_node hash;	/* merge hash */
-		struct list_head ipi_list;
+		struct llist_node ipi_list;
 	};
 
 	/*
diff --git a/kernel/locking/rwlock-rt.c b/kernel/locking/rwlock-rt.c
index 4cd72a2968a6f..3d2d1f14b5135 100644
--- a/kernel/locking/rwlock-rt.c
+++ b/kernel/locking/rwlock-rt.c
@@ -61,7 +61,7 @@ void __rwlock_biased_rt_init(struct rt_rw_lock *lock, const char *name,
 	lock->rtmutex.save_state = 1;
 }
 
-int __read_rt_trylock(struct rt_rw_lock *lock)
+static int __read_rt_trylock(struct rt_rw_lock *lock)
 {
 	int r, old;
 
diff --git a/lib/test_lockup.c b/lib/test_lockup.c
index f1a020bcc763e..864554e769738 100644
--- a/lib/test_lockup.c
+++ b/lib/test_lockup.c
@@ -480,6 +480,21 @@ static int __init test_lockup_init(void)
 		return -EINVAL;
 
 #ifdef CONFIG_DEBUG_SPINLOCK
+#ifdef CONFIG_PREEMPT_RT
+	if (test_magic(lock_spinlock_ptr,
+		       offsetof(spinlock_t, lock.wait_lock.magic),
+		       SPINLOCK_MAGIC) ||
+	    test_magic(lock_rwlock_ptr,
+		       offsetof(rwlock_t, rtmutex.wait_lock.magic),
+		       SPINLOCK_MAGIC) ||
+	    test_magic(lock_mutex_ptr,
+		       offsetof(struct mutex, lock.wait_lock.magic),
+		       SPINLOCK_MAGIC) ||
+	    test_magic(lock_rwsem_ptr,
+		       offsetof(struct rw_semaphore, rtmutex.wait_lock.magic),
+		       SPINLOCK_MAGIC))
+		return -EINVAL;
+#else
 	if (test_magic(lock_spinlock_ptr,
 		       offsetof(spinlock_t, rlock.magic),
 		       SPINLOCK_MAGIC) ||
@@ -493,6 +508,7 @@ static int __init test_lockup_init(void)
 		       offsetof(struct rw_semaphore, wait_lock.magic),
 		       SPINLOCK_MAGIC))
 		return -EINVAL;
+#endif
 #endif
 
 	if ((wait_state != TASK_RUNNING ||
diff --git a/localversion-rt b/localversion-rt
index 483ad771f201a..e095ab8197147 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt19
+-rt20
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index f35ffe52cc4f8..09fa87f7a8119 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -829,6 +829,7 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
 	memcg = pn->memcg;
 
+	preempt_disable_rt();
 	/* Update memcg */
 	__mod_memcg_state(memcg, idx, val);
 
@@ -848,6 +849,7 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 		x = 0;
 	}
 	__this_cpu_write(pn->lruvec_stat_cpu->count[idx], x);
+	preempt_enable_rt();
 }
 
 /**
