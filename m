Return-Path: <SRS0=y2gO=BY=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41CB5C433E3
	for <linux-rt-users@archiver.kernel.org>; Fri, 14 Aug 2020 22:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2335F20838
	for <linux-rt-users@archiver.kernel.org>; Fri, 14 Aug 2020 22:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbgHNW0C (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 14 Aug 2020 18:26:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:33664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726596AbgHNW0C (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 14 Aug 2020 18:26:02 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8B8220768;
        Fri, 14 Aug 2020 22:26:00 +0000 (UTC)
Date:   Fri, 14 Aug 2020 18:25:59 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Subject: [ANNOUNCE] 5.4.54-rt33
Message-ID: <20200814182559.536b5ef3@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


Dear RT Folks,

I'm pleased to announce the 5.4.54-rt33 stable release.


You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.4-rt
  Head SHA1: 8b0dbd94090c0b782f374bb645a93517b6b8d887


Or to build 5.4.54-rt33 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v5.x/linux-5.4.tar.xz

  http://www.kernel.org/pub/linux/kernel/v5.x/patch-5.4.54.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/5.4/patch-5.4.54-rt33.patch.xz



You can also build from 5.4.54-rt32 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/5.4/incr/patch-5.4.54-rt32-rt33.patch.xz



Enjoy,

-- Steve


Changes from v5.4.54-rt32:

---

Ahmed S. Darwish (1):
      net: phy: fixed_phy: Remove unused seqcount

Matt Fleming (1):
      signal: Prevent double-free of user struct

Sebastian Andrzej Siewior (3):
      workqueue: Sync with upstream
      Bluetooth: Acquire sk_lock.slock without disabling interrupts
      rwsem: Provide down_read_non_owner() and up_read_non_owner() for -RT

Steven Rostedt (VMware) (1):
      Linux 5.4.54-rt33

----
 drivers/net/phy/fixed_phy.c | 28 +++++++++++-----------------
 include/linux/swait.h       | 14 --------------
 kernel/locking/rwsem.c      |  8 ++++----
 kernel/signal.c             |  4 ++--
 kernel/workqueue.c          | 28 +++++++++++++++++++---------
 localversion-rt             |  2 +-
 net/bluetooth/rfcomm/sock.c |  7 ++-----
 7 files changed, 39 insertions(+), 52 deletions(-)
---------------------------
diff --git a/drivers/net/phy/fixed_phy.c b/drivers/net/phy/fixed_phy.c
index 4190f9ed5313..9ed715e9be40 100644
--- a/drivers/net/phy/fixed_phy.c
+++ b/drivers/net/phy/fixed_phy.c
@@ -19,7 +19,6 @@
 #include <linux/slab.h>
 #include <linux/of.h>
 #include <linux/gpio/consumer.h>
-#include <linux/seqlock.h>
 #include <linux/idr.h>
 #include <linux/netdevice.h>
 #include <linux/linkmode.h>
@@ -34,7 +33,6 @@ struct fixed_mdio_bus {
 struct fixed_phy {
 	int addr;
 	struct phy_device *phydev;
-	seqcount_t seqcount;
 	struct fixed_phy_status status;
 	bool no_carrier;
 	int (*link_update)(struct net_device *, struct fixed_phy_status *);
@@ -80,19 +78,17 @@ static int fixed_mdio_read(struct mii_bus *bus, int phy_addr, int reg_num)
 	list_for_each_entry(fp, &fmb->phys, node) {
 		if (fp->addr == phy_addr) {
 			struct fixed_phy_status state;
-			int s;
-
-			do {
-				s = read_seqcount_begin(&fp->seqcount);
-				fp->status.link = !fp->no_carrier;
-				/* Issue callback if user registered it. */
-				if (fp->link_update)
-					fp->link_update(fp->phydev->attached_dev,
-							&fp->status);
-				/* Check the GPIO for change in status */
-				fixed_phy_update(fp);
-				state = fp->status;
-			} while (read_seqcount_retry(&fp->seqcount, s));
+
+			fp->status.link = !fp->no_carrier;
+
+			/* Issue callback if user registered it. */
+			if (fp->link_update)
+				fp->link_update(fp->phydev->attached_dev,
+						&fp->status);
+
+			/* Check the GPIO for change in status */
+			fixed_phy_update(fp);
+			state = fp->status;
 
 			return swphy_read_reg(reg_num, &state);
 		}
@@ -150,8 +146,6 @@ static int fixed_phy_add_gpiod(unsigned int irq, int phy_addr,
 	if (!fp)
 		return -ENOMEM;
 
-	seqcount_init(&fp->seqcount);
-
 	if (irq != PHY_POLL)
 		fmb->mii_bus->irq[phy_addr] = irq;
 
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
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 0d11ba11a32a..0325c721f9b3 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -1616,15 +1616,15 @@ void _down_write_nest_lock(struct rw_semaphore *sem, struct lockdep_map *nest)
 }
 EXPORT_SYMBOL(_down_write_nest_lock);
 
-#ifndef CONFIG_PREEMPT_RT
 void down_read_non_owner(struct rw_semaphore *sem)
 {
 	might_sleep();
 	__down_read(sem);
+#ifndef CONFIG_PREEMPT_RT
 	__rwsem_set_reader_owned(sem, NULL);
+#endif
 }
 EXPORT_SYMBOL(down_read_non_owner);
-#endif
 
 void down_write_nested(struct rw_semaphore *sem, int subclass)
 {
@@ -1649,13 +1649,13 @@ int __sched down_write_killable_nested(struct rw_semaphore *sem, int subclass)
 }
 EXPORT_SYMBOL(down_write_killable_nested);
 
-#ifndef CONFIG_PREEMPT_RT
 void up_read_non_owner(struct rw_semaphore *sem)
 {
+#ifndef CONFIG_PREEMPT_RT
 	DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
+#endif
 	__up_read(sem);
 }
 EXPORT_SYMBOL(up_read_non_owner);
-#endif
 
 #endif
diff --git a/kernel/signal.c b/kernel/signal.c
index def2e8e37f1f..aa924f0141cf 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -494,8 +494,8 @@ static void sigqueue_free_current(struct sigqueue *q)
 
 	up = q->user;
 	if (rt_prio(current->normal_prio) && !put_task_cache(current, q)) {
-		atomic_dec(&up->sigpending);
-		free_uid(up);
+		if (atomic_dec_and_test(&up->sigpending))
+			free_uid(up);
 	} else
 		  __sigqueue_free(q);
 }
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
diff --git a/localversion-rt b/localversion-rt
index ce6a482618d5..e1d836252017 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt32
+-rt33
diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 90bb53aa4bee..2c27aa2acf1c 100644
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
