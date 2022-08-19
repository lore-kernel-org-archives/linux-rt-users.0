Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94845C28B2B
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Aug 2022 09:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348146AbiHSJZB (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 19 Aug 2022 05:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347773AbiHSJY5 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 19 Aug 2022 05:24:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6436CF2CB0;
        Fri, 19 Aug 2022 02:24:54 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1660901092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SFpZPmAZbg9aYpYaDW9xH1XA1PmNf7BWb8++FP22dOY=;
        b=keoycPeF29sCd2tZ21AjFtDu96wwYVLA86mnaS8WNHcNcguquZhKX+ZHl44BaazlIHVgcr
        JLyO1iT7b14vo7rA7QXz910dn5Ef/LAVj+nn73gNOlDo2g8/raO95v07P+5w/9OT28A+IJ
        S8vvw5T8ikvb94uXviuatIxxQlbAKo/rqzI0jtpgQxYqzebmPafu1Du2bDxsTLi8ya+i8M
        d1astSFn21CcZSVDkKFwH680ehgoGkD1BE/Sptun1H9eLvsxxZbxcwIDmwLMIKH8DB9z1G
        ggZf/dOGVWnCGiWBdpIUWZtJuhHeBMI0DjZvtdsarBdOkZisj6X+nUGG7MMDhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1660901092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SFpZPmAZbg9aYpYaDW9xH1XA1PmNf7BWb8++FP22dOY=;
        b=Axcb4CmypsTfl9Fxuwt6bc1aXdgKWo4qtSUtBKgf8e2njAIVzaWyP/LPvSp/nn0jtRbfAj
        cgpDJcWxSLTz85Dw==
To:     Mark Gross <markgross@kernel.org>
Cc:     linux-rt-users@vger.kernel.org, stable-rt@vger.kernel.org,
        Salvatore Bonaccorso <carnil@debian.org>
Subject: [PATCH 4/9] Revert "workqueue: Prevent deadlock/stall on RT"
Date:   Fri, 19 Aug 2022 11:24:41 +0200
Message-Id: <20220819092446.980320-5-bigeasy@linutronix.de>
In-Reply-To: <20220819092446.980320-1-bigeasy@linutronix.de>
References: <20220819092446.980320-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

This reverts the PREEMPT_RT related changes to workqueue. It reverts the
extra locking needed to protect the worker which will soon become
obsolete.
The sched/core.c changes, which were introduced in the original commit,
must remain as the following code will rely on it.

This is a preparation to pull in the PREEMPT_RT related changes which
were merged upstream.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/workqueue.c | 60 ++++++++++------------------------------------
 1 file changed, 13 insertions(+), 47 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 0c2c383eb7d0e..6b3f3f54a05e9 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -124,11 +124,6 @@ enum {
  *    cpu or grabbing pool->lock is enough for read access.  If
  *    POOL_DISASSOCIATED is set, it's identical to L.
  *
- *    On RT we need the extra protection via rt_lock_idle_list() for
- *    the list manipulations against read access from
- *    wq_worker_sleeping(). All other places are nicely serialized via
- *    pool->lock.
- *
  * A: pool->attach_mutex protected.
  *
  * PL: wq_pool_mutex protected.
@@ -434,31 +429,6 @@ static void workqueue_sysfs_unregister(struct workqueu=
e_struct *wq);
 		if (({ assert_rcu_or_wq_mutex(wq); false; })) { }	\
 		else
=20
-#ifdef CONFIG_PREEMPT_RT_BASE
-static inline void rt_lock_idle_list(struct worker_pool *pool)
-{
-	preempt_disable();
-}
-static inline void rt_unlock_idle_list(struct worker_pool *pool)
-{
-	preempt_enable();
-}
-static inline void sched_lock_idle_list(struct worker_pool *pool) { }
-static inline void sched_unlock_idle_list(struct worker_pool *pool) { }
-#else
-static inline void rt_lock_idle_list(struct worker_pool *pool) { }
-static inline void rt_unlock_idle_list(struct worker_pool *pool) { }
-static inline void sched_lock_idle_list(struct worker_pool *pool)
-{
-	spin_lock_irq(&pool->lock);
-}
-static inline void sched_unlock_idle_list(struct worker_pool *pool)
-{
-	spin_unlock_irq(&pool->lock);
-}
-#endif
-
-
 #ifdef CONFIG_DEBUG_OBJECTS_WORK
=20
 static struct debug_obj_descr work_debug_descr;
@@ -865,16 +835,10 @@ static struct worker *first_idle_worker(struct worker=
_pool *pool)
  */
 static void wake_up_worker(struct worker_pool *pool)
 {
-	struct worker *worker;
-
-	rt_lock_idle_list(pool);
-
-	worker =3D first_idle_worker(pool);
+	struct worker *worker =3D first_idle_worker(pool);
=20
 	if (likely(worker))
 		wake_up_process(worker->task);
-
-	rt_unlock_idle_list(pool);
 }
=20
 /**
@@ -903,7 +867,7 @@ void wq_worker_running(struct task_struct *task)
  */
 void wq_worker_sleeping(struct task_struct *task)
 {
-	struct worker *worker =3D kthread_data(task);
+	struct worker *next, *worker =3D kthread_data(task);
 	struct worker_pool *pool;
=20
 	/*
@@ -920,18 +884,26 @@ void wq_worker_sleeping(struct task_struct *task)
 		return;
=20
 	worker->sleeping =3D 1;
+	spin_lock_irq(&pool->lock);
=20
 	/*
 	 * The counterpart of the following dec_and_test, implied mb,
 	 * worklist not empty test sequence is in insert_work().
 	 * Please read comment there.
+	 *
+	 * NOT_RUNNING is clear.  This means that we're bound to and
+	 * running on the local cpu w/ rq lock held and preemption
+	 * disabled, which in turn means that none else could be
+	 * manipulating idle_list, so dereferencing idle_list without pool
+	 * lock is safe.
 	 */
 	if (atomic_dec_and_test(&pool->nr_running) &&
 	    !list_empty(&pool->worklist)) {
-		sched_lock_idle_list(pool);
-		wake_up_worker(pool);
-		sched_unlock_idle_list(pool);
+		next =3D first_idle_worker(pool);
+		if (next)
+			wake_up_process(next->task);
 	}
+	spin_unlock_irq(&pool->lock);
 }
=20
 /**
@@ -1661,9 +1633,7 @@ static void worker_enter_idle(struct worker *worker)
 	worker->last_active =3D jiffies;
=20
 	/* idle_list is LIFO */
-	rt_lock_idle_list(pool);
 	list_add(&worker->entry, &pool->idle_list);
-	rt_unlock_idle_list(pool);
=20
 	if (too_many_workers(pool) && !timer_pending(&pool->idle_timer))
 		mod_timer(&pool->idle_timer, jiffies + IDLE_WORKER_TIMEOUT);
@@ -1696,9 +1666,7 @@ static void worker_leave_idle(struct worker *worker)
 		return;
 	worker_clr_flags(worker, WORKER_IDLE);
 	pool->nr_idle--;
-	rt_lock_idle_list(pool);
 	list_del_init(&worker->entry);
-	rt_unlock_idle_list(pool);
 }
=20
 static struct worker *alloc_worker(int node)
@@ -1864,9 +1832,7 @@ static void destroy_worker(struct worker *worker)
 	pool->nr_workers--;
 	pool->nr_idle--;
=20
-	rt_lock_idle_list(pool);
 	list_del_init(&worker->entry);
-	rt_unlock_idle_list(pool);
 	worker->flags |=3D WORKER_DIE;
 	wake_up_process(worker->task);
 }
--=20
2.37.2

