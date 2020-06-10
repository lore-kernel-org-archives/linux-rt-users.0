Return-Path: <SRS0=psFn=7X=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 582CBC433E0
	for <linux-rt-users@archiver.kernel.org>; Wed, 10 Jun 2020 11:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EE45204EC
	for <linux-rt-users@archiver.kernel.org>; Wed, 10 Jun 2020 11:37:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbgFJLh2 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 10 Jun 2020 07:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728855AbgFJLhY (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 10 Jun 2020 07:37:24 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E9BC03E96B;
        Wed, 10 Jun 2020 04:37:24 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jiz2n-0003TS-JA; Wed, 10 Jun 2020 13:37:21 +0200
Date:   Wed, 10 Jun 2020 13:37:21 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.6.17-rt9
Message-ID: <20200610113721.qgisnk4vwamfrezk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.6.17-rt9 patch set. 

Changes since v5.6.17-rt8:

  - Replace the workqueue related patches with those that have been
    merged upstream.

  - Don't acquire a sleeping lock with disabled interrupts in
    bluetooth/rfcomm. Reported by Luis Claudio R. Goncalves.

Known issues
     - It has been pointed out that due to changes to the printk code the
       internal buffer representation changed. This is only an issue if tools
       like `crash' are used to extract the printk buffer from a kernel memory
       image.

The delta patch against v5.6.17-rt8 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.6/incr/patch-5.6.17-rt8-rt9.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.6.17-rt9

The RT patch against v5.6.17 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.6/older/patch-5.6.17-rt9.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.6/older/patches-5.6.17-rt9.tar.xz

Sebastian

diff --git a/include/linux/swait.h b/include/linux/swait.h
index 21ae66cd41d30..f426a0661aa03 100644
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
index a62f326a0b0ad..e958258669972 100644
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
@@ -1609,11 +1609,9 @@ EXPORT_SYMBOL_GPL(queue_work_node);
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
 
@@ -2141,7 +2139,7 @@ static bool manage_workers(struct worker *worker)
 
 	pool->manager = NULL;
 	pool->flags &= ~POOL_MANAGER_ACTIVE;
-	swake_up_one(&wq_manager_wait);
+	rcuwait_wake_up(&manager_wait);
 	return true;
 }
 
@@ -3505,6 +3503,18 @@ static void rcu_free_pool(struct rcu_head *rcu)
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
@@ -3540,10 +3550,10 @@ static void put_unbound_pool(struct worker_pool *pool)
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
diff --git a/localversion-rt b/localversion-rt
index 700c857efd9ba..22746d6390a42 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt8
+-rt9
diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index b4eaf21360ef2..df14eebe80da8 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -64,15 +64,13 @@ static void rfcomm_sk_data_ready(struct rfcomm_dlc *d, struct sk_buff *skb)
 static void rfcomm_sk_state_change(struct rfcomm_dlc *d, int err)
 {
 	struct sock *sk = d->owner, *parent;
-	unsigned long flags;
 
 	if (!sk)
 		return;
 
 	BT_DBG("dlc %p state %ld err %d", d, d->state, err);
 
-	local_irq_save(flags);
-	bh_lock_sock(sk);
+	spin_lock_bh(&sk->sk_lock.slock);
 
 	if (err)
 		sk->sk_err = err;
@@ -93,8 +91,7 @@ static void rfcomm_sk_state_change(struct rfcomm_dlc *d, int err)
 		sk->sk_state_change(sk);
 	}
 
-	bh_unlock_sock(sk);
-	local_irq_restore(flags);
+	spin_unlock_bh(&sk->sk_lock.slock);
 
 	if (parent && sock_flag(sk, SOCK_ZAPPED)) {
 		/* We have to drop DLC lock here, otherwise
