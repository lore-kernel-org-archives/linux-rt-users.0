Return-Path: <SRS0=doyN=BX=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E89C433DF
	for <linux-rt-users@archiver.kernel.org>; Thu, 13 Aug 2020 01:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 055162184D
	for <linux-rt-users@archiver.kernel.org>; Thu, 13 Aug 2020 01:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbgHMBqC (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 12 Aug 2020 21:46:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:33076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726518AbgHMBp5 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 12 Aug 2020 21:45:57 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BFE92087C;
        Thu, 13 Aug 2020 01:45:56 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1k62JX-00750B-Lg; Wed, 12 Aug 2020 21:45:55 -0400
Message-ID: <20200813014555.550173612@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 12 Aug 2020 21:45:36 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Subject: [PATCH RT 2/6] workqueue: Sync with upstream
References: <20200813014534.833107526@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

5.4.54-rt33-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

This is an all-on-one patch reverting the following commits:
  workqueue: Don't assume that the callback has interrupts disabled
  sched/swait: Add swait_event_lock_irq()
  workqueue: Use swait for wq_manager_wait
  workqueue: Convert the locks to raw type

and introducing the following commits from upstream:
  workqueue: Use rcuwait for wq_manager_wait
  workqueue: Convert the pool::lock and wq_mayday_lock to raw_spinlock_t

as an replacement.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/swait.h | 14 --------------
 kernel/workqueue.c    | 28 +++++++++++++++++++---------
 2 files changed, 19 insertions(+), 23 deletions(-)

diff --git a/include/linux/swait.h b/include/linux/swait.h
index 21ae66cd41d3..f426a0661aa0 100644
--- a/include/linux/swait.h
+++ b/include/linux/swait.h
@@ -299,18 +299,4 @@ do {									\
 	__ret;								\
 })
 
-#define __swait_event_lock_irq(wq, condition, lock, cmd)		\
-	___swait_event(wq, condition, TASK_UNINTERRUPTIBLE, 0,		\
-		       raw_spin_unlock_irq(&lock);			\
-		       cmd;						\
-		       schedule();					\
-		       raw_spin_lock_irq(&lock))
-
-#define swait_event_lock_irq(wq_head, condition, lock)			\
-	do {								\
-		if (condition)						\
-			break;						\
-		__swait_event_lock_irq(wq_head, condition, lock, );	\
-	} while (0)
-
 #endif /* _LINUX_SWAIT_H */
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 26341e8101ee..7c968aea01e1 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -50,7 +50,6 @@
 #include <linux/uaccess.h>
 #include <linux/sched/isolation.h>
 #include <linux/nmi.h>
-#include <linux/swait.h>
 
 #include "workqueue_internal.h"
 
@@ -302,7 +301,8 @@ static struct workqueue_attrs *wq_update_unbound_numa_attrs_buf;
 static DEFINE_MUTEX(wq_pool_mutex);	/* protects pools and workqueues list */
 static DEFINE_MUTEX(wq_pool_attach_mutex); /* protects worker attach/detach */
 static DEFINE_RAW_SPINLOCK(wq_mayday_lock);	/* protects wq->maydays list */
-static DECLARE_SWAIT_QUEUE_HEAD(wq_manager_wait); /* wait for manager to go away */
+/* wait for manager to go away */
+static struct rcuwait manager_wait = __RCUWAIT_INITIALIZER(manager_wait);
 
 static LIST_HEAD(workqueues);		/* PR: list of all workqueues */
 static bool workqueue_freezing;		/* PL: have wqs started freezing? */
@@ -1615,11 +1615,9 @@ EXPORT_SYMBOL_GPL(queue_work_node);
 void delayed_work_timer_fn(struct timer_list *t)
 {
 	struct delayed_work *dwork = from_timer(dwork, t, timer);
-	unsigned long flags;
 
-	local_irq_save(flags);
+	/* should have been called from irqsafe timer with irq already off */
 	__queue_work(dwork->cpu, dwork->wq, &dwork->work);
-	local_irq_restore(flags);
 }
 EXPORT_SYMBOL(delayed_work_timer_fn);
 
@@ -2147,7 +2145,7 @@ static bool manage_workers(struct worker *worker)
 
 	pool->manager = NULL;
 	pool->flags &= ~POOL_MANAGER_ACTIVE;
-	swake_up_one(&wq_manager_wait);
+	rcuwait_wake_up(&manager_wait);
 	return true;
 }
 
@@ -3511,6 +3509,18 @@ static void rcu_free_pool(struct rcu_head *rcu)
 	kfree(pool);
 }
 
+/* This returns with the lock held on success (pool manager is inactive). */
+static bool wq_manager_inactive(struct worker_pool *pool)
+{
+	raw_spin_lock_irq(&pool->lock);
+
+	if (pool->flags & POOL_MANAGER_ACTIVE) {
+		raw_spin_unlock_irq(&pool->lock);
+		return false;
+	}
+	return true;
+}
+
 /**
  * put_unbound_pool - put a worker_pool
  * @pool: worker_pool to put
@@ -3546,10 +3556,10 @@ static void put_unbound_pool(struct worker_pool *pool)
 	 * Become the manager and destroy all workers.  This prevents
 	 * @pool's workers from blocking on attach_mutex.  We're the last
 	 * manager and @pool gets freed with the flag set.
+	 * Because of how wq_manager_inactive() works, we will hold the
+	 * spinlock after a successful wait.
 	 */
-	raw_spin_lock_irq(&pool->lock);
-	swait_event_lock_irq(wq_manager_wait,
-			    !(pool->flags & POOL_MANAGER_ACTIVE), pool->lock);
+	rcuwait_wait_event(&manager_wait, wq_manager_inactive(pool));
 	pool->flags |= POOL_MANAGER_ACTIVE;
 
 	while ((worker = first_idle_worker(pool)))
-- 
2.28.0


