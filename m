Return-Path: <SRS0=Iani=WR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A3F5C3A5A0
	for <linux-rt-users@archiver.kernel.org>; Wed, 21 Aug 2019 15:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBCBE22DA7
	for <linux-rt-users@archiver.kernel.org>; Wed, 21 Aug 2019 15:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566399929;
	bh=S/SnJCGysQiN/45ReVdQFYEJrsd5uCkYPWN9pFMPdU0=;
	h=Subject:From:To:Date:List-ID:From;
	b=AtZafKUpPCv5IgDeIxzOMqKQNuqE3iXZw5DNI8S/SPJO2L6VVQxvBM9I4+IR87bbA
	 BC+58Ob+cFVj+2z+YxHoPz4aMtj2MYHBmsL8Xj5cNAWoDucD6pJnmpXgySXdz32V4A
	 7bjZTFGNWBM4VOtYScBUMx8ZlXLnMd5tO2yFgbC4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbfHUPFX (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 21 Aug 2019 11:05:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:52530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726677AbfHUPFX (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 21 Aug 2019 11:05:23 -0400
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E19C20870;
        Wed, 21 Aug 2019 15:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566399919;
        bh=S/SnJCGysQiN/45ReVdQFYEJrsd5uCkYPWN9pFMPdU0=;
        h=Subject:From:To:Date:From;
        b=YkhZ2y/HA2Y9l0H5tjfL1l7Ny7GocxRFmcaUjNgWf3Mt1iFc+z35sdS4bjcnphyqS
         tlDfuxLuORawenmoMYl3iQVDyK0Izry6GmtOyfYCdiqGFrZjgA908dqxVkTBJgGh8B
         y06HJVWdNxf39k3W6tL3/UbCMal3qKauzHPN117E=
Message-ID: <1566399917.20187.4.camel@kernel.org>
Subject: [ANNOUNCE] 4.14.137-rt65
From:   Tom Zanussi <zanussi@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <zanussi@kernel.org>,
        Julia Cartwright <julia@ni.com>
Date:   Wed, 21 Aug 2019 10:05:17 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 4.14.137-rt65 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.14-rt
  Head SHA1: 99fb7f1893d07e9ff67f78488cda74a2be903213

Or to build 4.14.137-rt65 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.137.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/patch-4.14.137-rt65.patch.xz


You can also build from 4.14.137-rt64 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/incr/patch-4.14.137-rt64-rt65.patch.xz

Enjoy!

   Tom

Changes from v4.14.137-rt64:
---

Corey Minyard (1):
      sched/completion: Fix a lockup in wait_for_completion()

Luis Claudio R. Goncalves (1):
      mm/zswap: Do not disable preemption in zswap_frontswap_store()

Sebastian Andrzej Siewior (13):
      kthread: add a global worker thread.
      genirq: Do not invoke the affinity callback via a workqueue on RT
      genirq: Handle missing work_struct in irq_set_affinity_notifier()
      locking/rwsem: Rename rwsem_rt.h to rwsem-rt.h
      locking/lockdep: Don't complain about incorrect name for no validate class
      arm: imx6: cpuidle: Use raw_spinlock_t
      rcu: Don't allow to change rcu_normal_after_boot on RT
      sched/core: Drop a preempt_disable_rt() statement
      Revert "futex: Ensure lock/unlock symetry versus pi_lock and hash bucket lock"
      Revert "futex: Fix bug on when a requeued RT task times out"
      Revert "rtmutex: Handle the various new futex race conditions"
      Revert "futex: workaround migrate_disable/enable in different context"
      futex: Make the futex_hash_bucket lock raw

Thomas Gleixner (1):
      futex: Delay deallocation of pi_state

Tom Zanussi (2):
      kthread: Use __RAW_SPIN_LOCK_UNLOCK to initialize kthread_worker lock
      Linux 4.14.137-rt65

kbuild test robot (1):
      pci/switchtec: fix stream_open.cocci warnings
---
arch/arm/mach-imx/cpuidle-imx6q.c        |  10 +-
 drivers/block/loop.c                     |   2 +-
 drivers/pci/switch/switchtec.c           |   2 +-
 drivers/spi/spi-rockchip.c               |   1 +
 include/linux/blk-cgroup.h               |   1 +
 include/linux/interrupt.h                |   5 +-
 include/linux/kthread-cgroup.h           |  17 +++
 include/linux/kthread.h                  |  10 +-
 include/linux/{rwsem_rt.h => rwsem-rt.h} |   0
 include/linux/rwsem.h                    |   2 +-
 init/main.c                              |   1 +
 kernel/futex.c                           | 232 +++++++++++++------------------
 kernel/irq/manage.c                      |  23 +--
 kernel/kthread.c                         |  13 ++
 kernel/locking/lockdep.c                 |   3 +-
 kernel/locking/rtmutex.c                 |  65 +--------
 kernel/locking/rtmutex_common.h          |   3 -
 kernel/rcu/update.c                      |   2 +
 kernel/sched/completion.c                |   2 +-
 kernel/sched/core.c                      |   9 +-
 localversion-rt                          |   2 +-
 mm/zswap.c                               |  12 +-
 22 files changed, 179 insertions(+), 238 deletions(-)
---
diff --git a/arch/arm/mach-imx/cpuidle-imx6q.c b/arch/arm/mach-imx/cpuidle-imx6q.c
index 326e870d7123..d9ac80aa1eb0 100644
--- a/arch/arm/mach-imx/cpuidle-imx6q.c
+++ b/arch/arm/mach-imx/cpuidle-imx6q.c
@@ -17,22 +17,22 @@
 #include "hardware.h"
 
 static int num_idle_cpus = 0;
-static DEFINE_SPINLOCK(cpuidle_lock);
+static DEFINE_RAW_SPINLOCK(cpuidle_lock);
 
 static int imx6q_enter_wait(struct cpuidle_device *dev,
 			    struct cpuidle_driver *drv, int index)
 {
-	spin_lock(&cpuidle_lock);
+	raw_spin_lock(&cpuidle_lock);
 	if (++num_idle_cpus == num_online_cpus())
 		imx6_set_lpm(WAIT_UNCLOCKED);
-	spin_unlock(&cpuidle_lock);
+	raw_spin_unlock(&cpuidle_lock);
 
 	cpu_do_idle();
 
-	spin_lock(&cpuidle_lock);
+	raw_spin_lock(&cpuidle_lock);
 	if (num_idle_cpus-- == num_online_cpus())
 		imx6_set_lpm(WAIT_CLOCKED);
-	spin_unlock(&cpuidle_lock);
+	raw_spin_unlock(&cpuidle_lock);
 
 	return index;
 }
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index bd447de4a5b8..2a07dfc9b3ae 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -70,7 +70,7 @@
 #include <linux/writeback.h>
 #include <linux/completion.h>
 #include <linux/highmem.h>
-#include <linux/kthread.h>
+#include <linux/kthread-cgroup.h>
 #include <linux/splice.h>
 #include <linux/sysfs.h>
 #include <linux/miscdevice.h>
diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index 69875a196ad8..2b6641c9e868 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -625,7 +625,7 @@ static int switchtec_dev_open(struct inode *inode, struct file *filp)
 		return PTR_ERR(stuser);
 
 	filp->private_data = stuser;
-	nonseekable_open(inode, filp);
+	stream_open(inode, filp);
 
 	dev_dbg(&stdev->dev, "%s: %p\n", __func__, stuser);
 
diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index fdcf3076681b..b56619418cea 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -22,6 +22,7 @@
 #include <linux/spi/spi.h>
 #include <linux/pm_runtime.h>
 #include <linux/scatterlist.h>
+#include <linux/interrupt.h>
 
 #define DRIVER_NAME "rockchip-spi"
 
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 8bbc3716507a..a9454ad4de06 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -20,6 +20,7 @@
 #include <linux/radix-tree.h>
 #include <linux/blkdev.h>
 #include <linux/atomic.h>
+#include <linux/kthread-cgroup.h>
 
 /* percpu_counter batch for blkg_[rw]stats, per-cpu drift doesn't matter */
 #define BLKG_STAT_CPU_BATCH	(INT_MAX / 2)
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 0f25fa19b2d8..233e3c027f53 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -15,7 +15,7 @@
 #include <linux/hrtimer.h>
 #include <linux/kref.h>
 #include <linux/workqueue.h>
-#include <linux/swork.h>
+#include <linux/kthread.h>
 
 #include <linux/atomic.h>
 #include <asm/ptrace.h>
@@ -230,7 +230,6 @@ extern void resume_device_irqs(void);
  * struct irq_affinity_notify - context for notification of IRQ affinity changes
  * @irq:		Interrupt to which notification applies
  * @kref:		Reference count, for internal use
- * @swork:		Swork item, for internal use
  * @work:		Work item, for internal use
  * @notify:		Function to be called on change.  This will be
  *			called in process context.
@@ -243,7 +242,7 @@ struct irq_affinity_notify {
 	unsigned int irq;
 	struct kref kref;
 #ifdef CONFIG_PREEMPT_RT_BASE
-	struct swork_event swork;
+	struct kthread_work work;
 #else
 	struct work_struct work;
 #endif
diff --git a/include/linux/kthread-cgroup.h b/include/linux/kthread-cgroup.h
new file mode 100644
index 000000000000..53d34bca9d72
--- /dev/null
+++ b/include/linux/kthread-cgroup.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_KTHREAD_CGROUP_H
+#define _LINUX_KTHREAD_CGROUP_H
+#include <linux/kthread.h>
+#include <linux/cgroup.h>
+
+#ifdef CONFIG_BLK_CGROUP
+void kthread_associate_blkcg(struct cgroup_subsys_state *css);
+struct cgroup_subsys_state *kthread_blkcg(void);
+#else
+static inline void kthread_associate_blkcg(struct cgroup_subsys_state *css) { }
+static inline struct cgroup_subsys_state *kthread_blkcg(void)
+{
+	return NULL;
+}
+#endif
+#endif
diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index 4e0449df82c3..59b85b01fb8b 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -105,7 +105,7 @@ struct kthread_delayed_work {
 };
 
 #define KTHREAD_WORKER_INIT(worker)	{				\
-	.lock = __SPIN_LOCK_UNLOCKED((worker).lock),			\
+	.lock = __RAW_SPIN_LOCK_UNLOCKED((worker).lock),		\
 	.work_list = LIST_HEAD_INIT((worker).work_list),		\
 	.delayed_work_list = LIST_HEAD_INIT((worker).delayed_work_list),\
 	}
@@ -199,4 +199,12 @@ bool kthread_cancel_delayed_work_sync(struct kthread_delayed_work *work);
 
 void kthread_destroy_worker(struct kthread_worker *worker);
 
+extern struct kthread_worker kthread_global_worker;
+void kthread_init_global_worker(void);
+
+static inline bool kthread_schedule_work(struct kthread_work *work)
+{
+	return kthread_queue_work(&kthread_global_worker, work);
+}
+
 #endif /* _LINUX_KTHREAD_H */
diff --git a/include/linux/rwsem_rt.h b/include/linux/rwsem-rt.h
similarity index 100%
rename from include/linux/rwsem_rt.h
rename to include/linux/rwsem-rt.h
diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index 513df11a364e..ac0857d60e04 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -21,7 +21,7 @@
 #endif
 
 #ifdef CONFIG_PREEMPT_RT_FULL
-#include <linux/rwsem_rt.h>
+#include <linux/rwsem-rt.h>
 #else /* PREEMPT_RT_FULL */
 
 struct rw_semaphore;
diff --git a/init/main.c b/init/main.c
index f32aebb5ce54..18c1297b2889 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1059,6 +1059,7 @@ static noinline void __init kernel_init_freeable(void)
 	smp_prepare_cpus(setup_max_cpus);
 
 	workqueue_init();
+	kthread_init_global_worker();
 
 	init_mm_internals();
 
diff --git a/kernel/futex.c b/kernel/futex.c
index ad0abb0e339f..5f1cfa2f02b6 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -240,7 +240,7 @@ struct futex_q {
 	struct plist_node list;
 
 	struct task_struct *task;
-	spinlock_t *lock_ptr;
+	raw_spinlock_t *lock_ptr;
 	union futex_key key;
 	struct futex_pi_state *pi_state;
 	struct rt_mutex_waiter *rt_waiter;
@@ -261,7 +261,7 @@ static const struct futex_q futex_q_init = {
  */
 struct futex_hash_bucket {
 	atomic_t waiters;
-	spinlock_t lock;
+	raw_spinlock_t lock;
 	struct plist_head chain;
 } ____cacheline_aligned_in_smp;
 
@@ -822,13 +822,13 @@ static void get_pi_state(struct futex_pi_state *pi_state)
  * Drops a reference to the pi_state object and frees or caches it
  * when the last reference is gone.
  */
-static void put_pi_state(struct futex_pi_state *pi_state)
+static struct futex_pi_state *__put_pi_state(struct futex_pi_state *pi_state)
 {
 	if (!pi_state)
-		return;
+		return NULL;
 
 	if (!atomic_dec_and_test(&pi_state->refcount))
-		return;
+		return NULL;
 
 	/*
 	 * If pi_state->owner is NULL, the owner is most probably dying
@@ -848,9 +848,7 @@ static void put_pi_state(struct futex_pi_state *pi_state)
 		raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
 	}
 
-	if (current->pi_state_cache) {
-		kfree(pi_state);
-	} else {
+	if (!current->pi_state_cache) {
 		/*
 		 * pi_state->list is already empty.
 		 * clear pi_state->owner.
@@ -859,6 +857,30 @@ static void put_pi_state(struct futex_pi_state *pi_state)
 		pi_state->owner = NULL;
 		atomic_set(&pi_state->refcount, 1);
 		current->pi_state_cache = pi_state;
+		pi_state = NULL;
+	}
+	return pi_state;
+}
+
+static void put_pi_state(struct futex_pi_state *pi_state)
+{
+	kfree(__put_pi_state(pi_state));
+}
+
+static void put_pi_state_atomic(struct futex_pi_state *pi_state,
+				struct list_head *to_free)
+{
+	if (__put_pi_state(pi_state))
+		list_add(&pi_state->list, to_free);
+}
+
+static void free_pi_state_list(struct list_head *to_free)
+{
+	struct futex_pi_state *p, *next;
+
+	list_for_each_entry_safe(p, next, to_free, list) {
+		list_del(&p->list);
+		kfree(p);
 	}
 }
 
@@ -893,6 +915,7 @@ void exit_pi_state_list(struct task_struct *curr)
 	struct futex_pi_state *pi_state;
 	struct futex_hash_bucket *hb;
 	union futex_key key = FUTEX_KEY_INIT;
+	LIST_HEAD(to_free);
 
 	if (!futex_cmpxchg_enabled)
 		return;
@@ -926,7 +949,7 @@ void exit_pi_state_list(struct task_struct *curr)
 		}
 		raw_spin_unlock_irq(&curr->pi_lock);
 
-		spin_lock(&hb->lock);
+		raw_spin_lock(&hb->lock);
 		raw_spin_lock_irq(&pi_state->pi_mutex.wait_lock);
 		raw_spin_lock(&curr->pi_lock);
 		/*
@@ -936,10 +959,8 @@ void exit_pi_state_list(struct task_struct *curr)
 		if (head->next != next) {
 			/* retain curr->pi_lock for the loop invariant */
 			raw_spin_unlock(&pi_state->pi_mutex.wait_lock);
-			raw_spin_unlock_irq(&curr->pi_lock);
-			spin_unlock(&hb->lock);
-			raw_spin_lock_irq(&curr->pi_lock);
-			put_pi_state(pi_state);
+			raw_spin_unlock(&hb->lock);
+			put_pi_state_atomic(pi_state, &to_free);
 			continue;
 		}
 
@@ -950,7 +971,7 @@ void exit_pi_state_list(struct task_struct *curr)
 
 		raw_spin_unlock(&curr->pi_lock);
 		raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
-		spin_unlock(&hb->lock);
+		raw_spin_unlock(&hb->lock);
 
 		rt_mutex_futex_unlock(&pi_state->pi_mutex);
 		put_pi_state(pi_state);
@@ -958,6 +979,8 @@ void exit_pi_state_list(struct task_struct *curr)
 		raw_spin_lock_irq(&curr->pi_lock);
 	}
 	raw_spin_unlock_irq(&curr->pi_lock);
+
+	free_pi_state_list(&to_free);
 }
 
 #endif
@@ -1444,7 +1467,7 @@ static void __unqueue_futex(struct futex_q *q)
 {
 	struct futex_hash_bucket *hb;
 
-	if (WARN_ON_SMP(!q->lock_ptr || !spin_is_locked(q->lock_ptr))
+	if (WARN_ON_SMP(!q->lock_ptr || !raw_spin_is_locked(q->lock_ptr))
 	    || WARN_ON(plist_node_empty(&q->list)))
 		return;
 
@@ -1572,21 +1595,21 @@ static inline void
 double_lock_hb(struct futex_hash_bucket *hb1, struct futex_hash_bucket *hb2)
 {
 	if (hb1 <= hb2) {
-		spin_lock(&hb1->lock);
+		raw_spin_lock(&hb1->lock);
 		if (hb1 < hb2)
-			spin_lock_nested(&hb2->lock, SINGLE_DEPTH_NESTING);
+			raw_spin_lock_nested(&hb2->lock, SINGLE_DEPTH_NESTING);
 	} else { /* hb1 > hb2 */
-		spin_lock(&hb2->lock);
-		spin_lock_nested(&hb1->lock, SINGLE_DEPTH_NESTING);
+		raw_spin_lock(&hb2->lock);
+		raw_spin_lock_nested(&hb1->lock, SINGLE_DEPTH_NESTING);
 	}
 }
 
 static inline void
 double_unlock_hb(struct futex_hash_bucket *hb1, struct futex_hash_bucket *hb2)
 {
-	spin_unlock(&hb1->lock);
+	raw_spin_unlock(&hb1->lock);
 	if (hb1 != hb2)
-		spin_unlock(&hb2->lock);
+		raw_spin_unlock(&hb2->lock);
 }
 
 /*
@@ -1614,7 +1637,7 @@ futex_wake(u32 __user *uaddr, unsigned int flags, int nr_wake, u32 bitset)
 	if (!hb_waiters_pending(hb))
 		goto out_put_key;
 
-	spin_lock(&hb->lock);
+	raw_spin_lock(&hb->lock);
 
 	plist_for_each_entry_safe(this, next, &hb->chain, list) {
 		if (match_futex (&this->key, &key)) {
@@ -1633,7 +1656,7 @@ futex_wake(u32 __user *uaddr, unsigned int flags, int nr_wake, u32 bitset)
 		}
 	}
 
-	spin_unlock(&hb->lock);
+	raw_spin_unlock(&hb->lock);
 	wake_up_q(&wake_q);
 out_put_key:
 	put_futex_key(&key);
@@ -1940,6 +1963,7 @@ static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
 	struct futex_hash_bucket *hb1, *hb2;
 	struct futex_q *this, *next;
 	DEFINE_WAKE_Q(wake_q);
+	LIST_HEAD(to_free);
 
 	if (nr_wake < 0 || nr_requeue < 0)
 		return -EINVAL;
@@ -2167,16 +2191,6 @@ static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
 				requeue_pi_wake_futex(this, &key2, hb2);
 				drop_count++;
 				continue;
-			} else if (ret == -EAGAIN) {
-				/*
-				 * Waiter was woken by timeout or
-				 * signal and has set pi_blocked_on to
-				 * PI_WAKEUP_INPROGRESS before we
-				 * tried to enqueue it on the rtmutex.
-				 */
-				this->pi_state = NULL;
-				put_pi_state(pi_state);
-				continue;
 			} else if (ret) {
 				/*
 				 * rt_mutex_start_proxy_lock() detected a
@@ -2187,7 +2201,7 @@ static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
 				 * object.
 				 */
 				this->pi_state = NULL;
-				put_pi_state(pi_state);
+				put_pi_state_atomic(pi_state, &to_free);
 				/*
 				 * We stop queueing more waiters and let user
 				 * space deal with the mess.
@@ -2204,7 +2218,7 @@ static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
 	 * in futex_proxy_trylock_atomic() or in lookup_pi_state(). We
 	 * need to drop it here again.
 	 */
-	put_pi_state(pi_state);
+	put_pi_state_atomic(pi_state, &to_free);
 
 out_unlock:
 	double_unlock_hb(hb1, hb2);
@@ -2225,6 +2239,7 @@ static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
 out_put_key1:
 	put_futex_key(&key1);
 out:
+	free_pi_state_list(&to_free);
 	return ret ? ret : task_count;
 }
 
@@ -2248,7 +2263,8 @@ static inline struct futex_hash_bucket *queue_lock(struct futex_q *q)
 
 	q->lock_ptr = &hb->lock;
 
-	spin_lock(&hb->lock); /* implies smp_mb(); (A) */
+	raw_spin_lock(&hb->lock);
+
 	return hb;
 }
 
@@ -2256,7 +2272,7 @@ static inline void
 queue_unlock(struct futex_hash_bucket *hb)
 	__releases(&hb->lock)
 {
-	spin_unlock(&hb->lock);
+	raw_spin_unlock(&hb->lock);
 	hb_waiters_dec(hb);
 }
 
@@ -2295,7 +2311,7 @@ static inline void queue_me(struct futex_q *q, struct futex_hash_bucket *hb)
 	__releases(&hb->lock)
 {
 	__queue_me(q, hb);
-	spin_unlock(&hb->lock);
+	raw_spin_unlock(&hb->lock);
 }
 
 /**
@@ -2311,41 +2327,41 @@ static inline void queue_me(struct futex_q *q, struct futex_hash_bucket *hb)
  */
 static int unqueue_me(struct futex_q *q)
 {
-	spinlock_t *lock_ptr;
+	raw_spinlock_t *lock_ptr;
 	int ret = 0;
 
 	/* In the common case we don't take the spinlock, which is nice. */
 retry:
 	/*
-	 * q->lock_ptr can change between this read and the following spin_lock.
-	 * Use READ_ONCE to forbid the compiler from reloading q->lock_ptr and
-	 * optimizing lock_ptr out of the logic below.
+	 * q->lock_ptr can change between this read and the following
+	 * raw_spin_lock. Use READ_ONCE to forbid the compiler from reloading
+	 * q->lock_ptr and optimizing lock_ptr out of the logic below.
 	 */
 	lock_ptr = READ_ONCE(q->lock_ptr);
 	if (lock_ptr != NULL) {
-		spin_lock(lock_ptr);
+		raw_spin_lock(lock_ptr);
 		/*
 		 * q->lock_ptr can change between reading it and
-		 * spin_lock(), causing us to take the wrong lock.  This
+		 * raw_spin_lock(), causing us to take the wrong lock.  This
 		 * corrects the race condition.
 		 *
 		 * Reasoning goes like this: if we have the wrong lock,
 		 * q->lock_ptr must have changed (maybe several times)
-		 * between reading it and the spin_lock().  It can
-		 * change again after the spin_lock() but only if it was
-		 * already changed before the spin_lock().  It cannot,
+		 * between reading it and the raw_spin_lock().  It can
+		 * change again after the raw_spin_lock() but only if it was
+		 * already changed before the raw_spin_lock().  It cannot,
 		 * however, change back to the original value.  Therefore
 		 * we can detect whether we acquired the correct lock.
 		 */
 		if (unlikely(lock_ptr != q->lock_ptr)) {
-			spin_unlock(lock_ptr);
+			raw_spin_unlock(lock_ptr);
 			goto retry;
 		}
 		__unqueue_futex(q);
 
 		BUG_ON(q->pi_state);
 
-		spin_unlock(lock_ptr);
+		raw_spin_unlock(lock_ptr);
 		ret = 1;
 	}
 
@@ -2361,13 +2377,16 @@ static int unqueue_me(struct futex_q *q)
 static void unqueue_me_pi(struct futex_q *q)
 	__releases(q->lock_ptr)
 {
+	struct futex_pi_state *ps;
+
 	__unqueue_futex(q);
 
 	BUG_ON(!q->pi_state);
-	put_pi_state(q->pi_state);
+	ps = __put_pi_state(q->pi_state);
 	q->pi_state = NULL;
 
-	spin_unlock(q->lock_ptr);
+	raw_spin_unlock(q->lock_ptr);
+	kfree(ps);
 }
 
 static int fixup_pi_state_owner(u32 __user *uaddr, struct futex_q *q,
@@ -2500,7 +2519,7 @@ static int fixup_pi_state_owner(u32 __user *uaddr, struct futex_q *q,
 	 */
 handle_err:
 	raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
-	spin_unlock(q->lock_ptr);
+	raw_spin_unlock(q->lock_ptr);
 
 	switch (err) {
 	case -EFAULT:
@@ -2518,7 +2537,7 @@ static int fixup_pi_state_owner(u32 __user *uaddr, struct futex_q *q,
 		break;
 	}
 
-	spin_lock(q->lock_ptr);
+	raw_spin_lock(q->lock_ptr);
 	raw_spin_lock_irq(&pi_state->pi_mutex.wait_lock);
 
 	/*
@@ -2614,7 +2633,7 @@ static void futex_wait_queue_me(struct futex_hash_bucket *hb, struct futex_q *q,
 	/*
 	 * The task state is guaranteed to be set before another task can
 	 * wake it. set_current_state() is implemented using smp_store_mb() and
-	 * queue_me() calls spin_unlock() upon completion, both serializing
+	 * queue_me() calls raw_spin_unlock() upon completion, both serializing
 	 * access to the hash list and forcing another memory barrier.
 	 */
 	set_current_state(TASK_INTERRUPTIBLE);
@@ -2905,15 +2924,7 @@ static int futex_lock_pi(u32 __user *uaddr, unsigned int flags,
 	 * before __rt_mutex_start_proxy_lock() is done.
 	 */
 	raw_spin_lock_irq(&q.pi_state->pi_mutex.wait_lock);
-	/*
-	 * the migrate_disable() here disables migration in the in_atomic() fast
-	 * path which is enabled again in the following spin_unlock(). We have
-	 * one migrate_disable() pending in the slow-path which is reversed
-	 * after the raw_spin_unlock_irq() where we leave the atomic context.
-	 */
-	migrate_disable();
-
-	spin_unlock(q.lock_ptr);
+	raw_spin_unlock(q.lock_ptr);
 	/*
 	 * __rt_mutex_start_proxy_lock() unconditionally enqueues the @rt_waiter
 	 * such that futex_unlock_pi() is guaranteed to observe the waiter when
@@ -2921,7 +2932,6 @@ static int futex_lock_pi(u32 __user *uaddr, unsigned int flags,
 	 */
 	ret = __rt_mutex_start_proxy_lock(&q.pi_state->pi_mutex, &rt_waiter, current);
 	raw_spin_unlock_irq(&q.pi_state->pi_mutex.wait_lock);
-	migrate_enable();
 
 	if (ret) {
 		if (ret == 1)
@@ -2935,7 +2945,7 @@ static int futex_lock_pi(u32 __user *uaddr, unsigned int flags,
 	ret = rt_mutex_wait_proxy_lock(&q.pi_state->pi_mutex, to, &rt_waiter);
 
 cleanup:
-	spin_lock(q.lock_ptr);
+	raw_spin_lock(q.lock_ptr);
 	/*
 	 * If we failed to acquire the lock (deadlock/signal/timeout), we must
 	 * first acquire the hb->lock before removing the lock from the
@@ -3036,7 +3046,7 @@ static int futex_unlock_pi(u32 __user *uaddr, unsigned int flags)
 		return ret;
 
 	hb = hash_futex(&key);
-	spin_lock(&hb->lock);
+	raw_spin_lock(&hb->lock);
 
 	/*
 	 * Check waiters first. We do not trust user space values at
@@ -3070,21 +3080,11 @@ static int futex_unlock_pi(u32 __user *uaddr, unsigned int flags)
 		 * rt_waiter. Also see the WARN in wake_futex_pi().
 		 */
 		raw_spin_lock_irq(&pi_state->pi_mutex.wait_lock);
-		/*
-		 * Magic trickery for now to make the RT migrate disable
-		 * logic happy. The following spin_unlock() happens with
-		 * interrupts disabled so the internal migrate_enable()
-		 * won't undo the migrate_disable() which was issued when
-		 * locking hb->lock.
-		 */
-		migrate_disable();
-		spin_unlock(&hb->lock);
+		raw_spin_unlock(&hb->lock);
 
 		/* drops pi_state->pi_mutex.wait_lock */
 		ret = wake_futex_pi(uaddr, uval, pi_state);
 
-		migrate_enable();
-
 		put_pi_state(pi_state);
 
 		/*
@@ -3119,7 +3119,7 @@ static int futex_unlock_pi(u32 __user *uaddr, unsigned int flags)
 	 * owner.
 	 */
 	if ((ret = cmpxchg_futex_value_locked(&curval, uaddr, uval, 0))) {
-		spin_unlock(&hb->lock);
+		raw_spin_unlock(&hb->lock);
 		switch (ret) {
 		case -EFAULT:
 			goto pi_faulted;
@@ -3139,7 +3139,7 @@ static int futex_unlock_pi(u32 __user *uaddr, unsigned int flags)
 	ret = (curval == uval) ? 0 : -EAGAIN;
 
 out_unlock:
-	spin_unlock(&hb->lock);
+	raw_spin_unlock(&hb->lock);
 out_putkey:
 	put_futex_key(&key);
 	return ret;
@@ -3255,7 +3255,7 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 	struct hrtimer_sleeper timeout, *to = NULL;
 	struct futex_pi_state *pi_state = NULL;
 	struct rt_mutex_waiter rt_waiter;
-	struct futex_hash_bucket *hb, *hb2;
+	struct futex_hash_bucket *hb;
 	union futex_key key2 = FUTEX_KEY_INIT;
 	struct futex_q q = futex_q_init;
 	int res, ret;
@@ -3313,55 +3313,20 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 	/* Queue the futex_q, drop the hb lock, wait for wakeup. */
 	futex_wait_queue_me(hb, &q, to);
 
-	/*
-	 * On RT we must avoid races with requeue and trying to block
-	 * on two mutexes (hb->lock and uaddr2's rtmutex) by
-	 * serializing access to pi_blocked_on with pi_lock.
-	 */
-	raw_spin_lock_irq(&current->pi_lock);
-	if (current->pi_blocked_on) {
-		/*
-		 * We have been requeued or are in the process of
-		 * being requeued.
-		 */
-		raw_spin_unlock_irq(&current->pi_lock);
-	} else {
-		/*
-		 * Setting pi_blocked_on to PI_WAKEUP_INPROGRESS
-		 * prevents a concurrent requeue from moving us to the
-		 * uaddr2 rtmutex. After that we can safely acquire
-		 * (and possibly block on) hb->lock.
-		 */
-		current->pi_blocked_on = PI_WAKEUP_INPROGRESS;
-		raw_spin_unlock_irq(&current->pi_lock);
-
-		spin_lock(&hb->lock);
-
-		/*
-		 * Clean up pi_blocked_on. We might leak it otherwise
-		 * when we succeeded with the hb->lock in the fast
-		 * path.
-		 */
-		raw_spin_lock_irq(&current->pi_lock);
-		current->pi_blocked_on = NULL;
-		raw_spin_unlock_irq(&current->pi_lock);
-
-		ret = handle_early_requeue_pi_wakeup(hb, &q, &key2, to);
-		spin_unlock(&hb->lock);
-		if (ret)
-			goto out_put_keys;
-	}
+	raw_spin_lock(&hb->lock);
+	ret = handle_early_requeue_pi_wakeup(hb, &q, &key2, to);
+	raw_spin_unlock(&hb->lock);
+	if (ret)
+		goto out_put_keys;
 
 	/*
-	 * In order to be here, we have either been requeued, are in
-	 * the process of being requeued, or requeue successfully
-	 * acquired uaddr2 on our behalf.  If pi_blocked_on was
-	 * non-null above, we may be racing with a requeue.  Do not
-	 * rely on q->lock_ptr to be hb2->lock until after blocking on
-	 * hb->lock or hb2->lock. The futex_requeue dropped our key1
-	 * reference and incremented our key2 reference count.
+	 * In order for us to be here, we know our q.key == key2, and since
+	 * we took the hb->lock above, we also know that futex_requeue() has
+	 * completed and we no longer have to concern ourselves with a wakeup
+	 * race with the atomic proxy lock acquisition by the requeue code. The
+	 * futex_requeue dropped our key1 reference and incremented our key2
+	 * reference count.
 	 */
-	hb2 = hash_futex(&key2);
 
 	/* Check if the requeue code acquired the second futex for us. */
 	if (!q.rt_waiter) {
@@ -3370,8 +3335,9 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 		 * did a lock-steal - fix up the PI-state in that case.
 		 */
 		if (q.pi_state && (q.pi_state->owner != current)) {
-			spin_lock(&hb2->lock);
-			BUG_ON(&hb2->lock != q.lock_ptr);
+			struct futex_pi_state *ps_free;
+
+			raw_spin_lock(q.lock_ptr);
 			ret = fixup_pi_state_owner(uaddr2, &q, current);
 			if (ret && rt_mutex_owner(&q.pi_state->pi_mutex) == current) {
 				pi_state = q.pi_state;
@@ -3381,8 +3347,9 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 			 * Drop the reference to the pi state which
 			 * the requeue_pi() code acquired for us.
 			 */
-			put_pi_state(q.pi_state);
-			spin_unlock(&hb2->lock);
+			ps_free = __put_pi_state(q.pi_state);
+			raw_spin_unlock(q.lock_ptr);
+			kfree(ps_free);
 		}
 	} else {
 		struct rt_mutex *pi_mutex;
@@ -3396,8 +3363,7 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 		pi_mutex = &q.pi_state->pi_mutex;
 		ret = rt_mutex_wait_proxy_lock(pi_mutex, to, &rt_waiter);
 
-		spin_lock(&hb2->lock);
-		BUG_ON(&hb2->lock != q.lock_ptr);
+		raw_spin_lock(q.lock_ptr);
 		if (ret && !rt_mutex_cleanup_proxy_lock(pi_mutex, &rt_waiter))
 			ret = 0;
 
@@ -3832,7 +3798,7 @@ static int __init futex_init(void)
 	for (i = 0; i < futex_hashsize; i++) {
 		atomic_set(&futex_queues[i].waiters, 0);
 		plist_head_init(&futex_queues[i].chain);
-		spin_lock_init(&futex_queues[i].lock);
+		raw_spin_lock_init(&futex_queues[i].lock);
 	}
 
 	return 0;
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index f9415590661c..071691963f7b 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -228,7 +228,7 @@ int irq_set_affinity_locked(struct irq_data *data, const struct cpumask *mask,
 		kref_get(&desc->affinity_notify->kref);
 
 #ifdef CONFIG_PREEMPT_RT_BASE
-		swork_queue(&desc->affinity_notify->swork);
+		kthread_schedule_work(&desc->affinity_notify->work);
 #else
 		schedule_work(&desc->affinity_notify->work);
 #endif
@@ -293,21 +293,11 @@ static void _irq_affinity_notify(struct irq_affinity_notify *notify)
 }
 
 #ifdef CONFIG_PREEMPT_RT_BASE
-static void init_helper_thread(void)
-{
-	static int init_sworker_once;
-
-	if (init_sworker_once)
-		return;
-	if (WARN_ON(swork_get()))
-		return;
-	init_sworker_once = 1;
-}
 
-static void irq_affinity_notify(struct swork_event *swork)
+static void irq_affinity_notify(struct kthread_work *work)
 {
 	struct irq_affinity_notify *notify =
-		container_of(swork, struct irq_affinity_notify, swork);
+		container_of(work, struct irq_affinity_notify, work);
 	_irq_affinity_notify(notify);
 }
 
@@ -350,8 +340,7 @@ irq_set_affinity_notifier(unsigned int irq, struct irq_affinity_notify *notify)
 		notify->irq = irq;
 		kref_init(&notify->kref);
 #ifdef CONFIG_PREEMPT_RT_BASE
-		INIT_SWORK(&notify->swork, irq_affinity_notify);
-		init_helper_thread();
+		kthread_init_work(&notify->work, irq_affinity_notify);
 #else
 		INIT_WORK(&notify->work, irq_affinity_notify);
 #endif
@@ -363,7 +352,9 @@ irq_set_affinity_notifier(unsigned int irq, struct irq_affinity_notify *notify)
 	raw_spin_unlock_irqrestore(&desc->lock, flags);
 
 	if (old_notify) {
-#ifndef CONFIG_PREEMPT_RT_BASE
+#ifdef CONFIG_PREEMPT_RT_BASE
+		kthread_cancel_work_sync(&notify->work);
+#else
 		cancel_work_sync(&old_notify->work);
 #endif
 		kref_put(&old_notify->kref, old_notify->release);
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 430fd79cd3fe..44498522e5d5 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -1161,3 +1161,16 @@ void kthread_destroy_worker(struct kthread_worker *worker)
 	kfree(worker);
 }
 EXPORT_SYMBOL(kthread_destroy_worker);
+
+DEFINE_KTHREAD_WORKER(kthread_global_worker);
+EXPORT_SYMBOL(kthread_global_worker);
+
+__init void kthread_init_global_worker(void)
+{
+	kthread_global_worker.task = kthread_create(kthread_worker_fn,
+						    &kthread_global_worker,
+						    "kswork");
+	if (WARN_ON(IS_ERR(kthread_global_worker.task)))
+		return;
+	wake_up_process(kthread_global_worker.task);
+}
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index e576d234f3ea..f194de27123d 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -719,7 +719,8 @@ look_up_lock_class(struct lockdep_map *lock, unsigned int subclass)
 			 * Huh! same key, different name? Did someone trample
 			 * on some memory? We're most confused.
 			 */
-			WARN_ON_ONCE(class->name != lock->name);
+			WARN_ON_ONCE(class->name != lock->name &&
+				     lock->key != &__lockdep_no_validate__);
 			return class;
 		}
 	}
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 1177f2815040..e1497623780b 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -142,12 +142,6 @@ static void fixup_rt_mutex_waiters(struct rt_mutex *lock)
 		WRITE_ONCE(*p, owner & ~RT_MUTEX_HAS_WAITERS);
 }
 
-static int rt_mutex_real_waiter(struct rt_mutex_waiter *waiter)
-{
-	return waiter && waiter != PI_WAKEUP_INPROGRESS &&
-		waiter != PI_REQUEUE_INPROGRESS;
-}
-
 /*
  * We can speed up the acquire/release, if there's no debugging state to be
  * set up.
@@ -421,8 +415,7 @@ int max_lock_depth = 1024;
 
 static inline struct rt_mutex *task_blocked_on_lock(struct task_struct *p)
 {
-	return rt_mutex_real_waiter(p->pi_blocked_on) ?
-		p->pi_blocked_on->lock : NULL;
+	return p->pi_blocked_on ? p->pi_blocked_on->lock : NULL;
 }
 
 /*
@@ -558,7 +551,7 @@ static int rt_mutex_adjust_prio_chain(struct task_struct *task,
 	 * reached or the state of the chain has changed while we
 	 * dropped the locks.
 	 */
-	if (!rt_mutex_real_waiter(waiter))
+	if (!waiter)
 		goto out_unlock_pi;
 
 	/*
@@ -1341,22 +1334,6 @@ static int task_blocks_on_rt_mutex(struct rt_mutex *lock,
 		return -EDEADLK;
 
 	raw_spin_lock(&task->pi_lock);
-	/*
-	 * In the case of futex requeue PI, this will be a proxy
-	 * lock. The task will wake unaware that it is enqueueed on
-	 * this lock. Avoid blocking on two locks and corrupting
-	 * pi_blocked_on via the PI_WAKEUP_INPROGRESS
-	 * flag. futex_wait_requeue_pi() sets this when it wakes up
-	 * before requeue (due to a signal or timeout). Do not enqueue
-	 * the task if PI_WAKEUP_INPROGRESS is set.
-	 */
-	if (task != current && task->pi_blocked_on == PI_WAKEUP_INPROGRESS) {
-		raw_spin_unlock(&task->pi_lock);
-		return -EAGAIN;
-	}
-
-       BUG_ON(rt_mutex_real_waiter(task->pi_blocked_on));
-
 	waiter->task = task;
 	waiter->lock = lock;
 	waiter->prio = task->prio;
@@ -1380,7 +1357,7 @@ static int task_blocks_on_rt_mutex(struct rt_mutex *lock,
 		rt_mutex_enqueue_pi(owner, waiter);
 
 		rt_mutex_adjust_prio(owner);
-		if (rt_mutex_real_waiter(owner->pi_blocked_on))
+		if (owner->pi_blocked_on)
 			chain_walk = 1;
 	} else if (rt_mutex_cond_detect_deadlock(waiter, chwalk)) {
 		chain_walk = 1;
@@ -1480,7 +1457,7 @@ static void remove_waiter(struct rt_mutex *lock,
 {
 	bool is_top_waiter = (waiter == rt_mutex_top_waiter(lock));
 	struct task_struct *owner = rt_mutex_owner(lock);
-	struct rt_mutex *next_lock = NULL;
+	struct rt_mutex *next_lock;
 
 	lockdep_assert_held(&lock->wait_lock);
 
@@ -1506,8 +1483,7 @@ static void remove_waiter(struct rt_mutex *lock,
 	rt_mutex_adjust_prio(owner);
 
 	/* Store the lock on which owner is blocked or NULL */
-	if (rt_mutex_real_waiter(owner->pi_blocked_on))
-		next_lock = task_blocked_on_lock(owner);
+	next_lock = task_blocked_on_lock(owner);
 
 	raw_spin_unlock(&owner->pi_lock);
 
@@ -1543,8 +1519,7 @@ void rt_mutex_adjust_pi(struct task_struct *task)
 	raw_spin_lock_irqsave(&task->pi_lock, flags);
 
 	waiter = task->pi_blocked_on;
-	if (!rt_mutex_real_waiter(waiter) ||
-	    rt_mutex_waiter_equal(waiter, task_to_waiter(task))) {
+	if (!waiter || rt_mutex_waiter_equal(waiter, task_to_waiter(task))) {
 		raw_spin_unlock_irqrestore(&task->pi_lock, flags);
 		return;
 	}
@@ -2358,34 +2333,6 @@ int __rt_mutex_start_proxy_lock(struct rt_mutex *lock,
 	if (try_to_take_rt_mutex(lock, task, NULL))
 		return 1;
 
-#ifdef CONFIG_PREEMPT_RT_FULL
-	/*
-	 * In PREEMPT_RT there's an added race.
-	 * If the task, that we are about to requeue, times out,
-	 * it can set the PI_WAKEUP_INPROGRESS. This tells the requeue
-	 * to skip this task. But right after the task sets
-	 * its pi_blocked_on to PI_WAKEUP_INPROGRESS it can then
-	 * block on the spin_lock(&hb->lock), which in RT is an rtmutex.
-	 * This will replace the PI_WAKEUP_INPROGRESS with the actual
-	 * lock that it blocks on. We *must not* place this task
-	 * on this proxy lock in that case.
-	 *
-	 * To prevent this race, we first take the task's pi_lock
-	 * and check if it has updated its pi_blocked_on. If it has,
-	 * we assume that it woke up and we return -EAGAIN.
-	 * Otherwise, we set the task's pi_blocked_on to
-	 * PI_REQUEUE_INPROGRESS, so that if the task is waking up
-	 * it will know that we are in the process of requeuing it.
-	 */
-	raw_spin_lock(&task->pi_lock);
-	if (task->pi_blocked_on) {
-		raw_spin_unlock(&task->pi_lock);
-		return -EAGAIN;
-	}
-	task->pi_blocked_on = PI_REQUEUE_INPROGRESS;
-	raw_spin_unlock(&task->pi_lock);
-#endif
-
 	/* We enforce deadlock detection for futexes */
 	ret = task_blocks_on_rt_mutex(lock, waiter, task,
 				      RT_MUTEX_FULL_CHAINWALK);
diff --git a/kernel/locking/rtmutex_common.h b/kernel/locking/rtmutex_common.h
index 2a157c78e18c..2f6662d052d6 100644
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -131,9 +131,6 @@ enum rtmutex_chainwalk {
 /*
  * PI-futex support (proxy locking functions, etc.):
  */
-#define PI_WAKEUP_INPROGRESS	((struct rt_mutex_waiter *) 1)
-#define PI_REQUEUE_INPROGRESS	((struct rt_mutex_waiter *) 2)
-
 extern struct task_struct *rt_mutex_next_owner(struct rt_mutex *lock);
 extern void rt_mutex_init_proxy_locked(struct rt_mutex *lock,
 				       struct task_struct *proxy_owner);
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 2006a09680aa..307592810f6b 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -67,7 +67,9 @@ module_param(rcu_expedited, int, 0);
 extern int rcu_normal; /* from sysctl */
 module_param(rcu_normal, int, 0);
 static int rcu_normal_after_boot = IS_ENABLED(CONFIG_PREEMPT_RT_FULL);
+#ifndef CONFIG_PREEMPT_RT_FULL
 module_param(rcu_normal_after_boot, int, 0);
+#endif
 #endif /* #ifndef CONFIG_TINY_RCU */
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
diff --git a/kernel/sched/completion.c b/kernel/sched/completion.c
index 0fe2982e46a0..ac6d5efcd6ff 100644
--- a/kernel/sched/completion.c
+++ b/kernel/sched/completion.c
@@ -80,12 +80,12 @@ do_wait_for_common(struct completion *x,
 	if (!x->done) {
 		DECLARE_SWAITQUEUE(wait);
 
-		__prepare_to_swait(&x->wait, &wait);
 		do {
 			if (signal_pending_state(state, current)) {
 				timeout = -ERESTARTSYS;
 				break;
 			}
+			__prepare_to_swait(&x->wait, &wait);
 			__set_current_state(state);
 			raw_spin_unlock_irq(&x->wait.lock);
 			timeout = action(timeout);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7d2cc0715114..17da1c1aba56 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -583,14 +583,11 @@ void resched_cpu(int cpu)
  */
 int get_nohz_timer_target(void)
 {
-	int i, cpu;
+	int i, cpu = smp_processor_id();
 	struct sched_domain *sd;
 
-	preempt_disable_rt();
-	cpu = smp_processor_id();
-
 	if (!idle_cpu(cpu) && is_housekeeping_cpu(cpu))
-		goto preempt_en_rt;
+		return cpu;
 
 	rcu_read_lock();
 	for_each_domain(cpu, sd) {
@@ -609,8 +606,6 @@ int get_nohz_timer_target(void)
 		cpu = housekeeping_any_cpu();
 unlock:
 	rcu_read_unlock();
-preempt_en_rt:
-	preempt_enable_rt();
 	return cpu;
 }
 
diff --git a/localversion-rt b/localversion-rt
index 10474042df49..e2eb19782d4c 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt64
+-rt65
diff --git a/mm/zswap.c b/mm/zswap.c
index ebb0bc88c5f7..a2b4e14f851c 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -27,6 +27,7 @@
 #include <linux/highmem.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/locallock.h>
 #include <linux/types.h>
 #include <linux/atomic.h>
 #include <linux/frontswap.h>
@@ -953,6 +954,8 @@ static int zswap_shrink(void)
 	return ret;
 }
 
+/* protect zswap_dstmem from concurrency */
+static DEFINE_LOCAL_IRQ_LOCK(zswap_dstmem_lock);
 /*********************************
 * frontswap hooks
 **********************************/
@@ -1016,12 +1019,11 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
 	}
 
 	/* compress */
-	dst = get_cpu_var(zswap_dstmem);
-	tfm = *get_cpu_ptr(entry->pool->tfm);
+	dst = get_locked_var(zswap_dstmem_lock, zswap_dstmem);
+	tfm = *this_cpu_ptr(entry->pool->tfm);
 	src = kmap_atomic(page);
 	ret = crypto_comp_compress(tfm, src, PAGE_SIZE, dst, &dlen);
 	kunmap_atomic(src);
-	put_cpu_ptr(entry->pool->tfm);
 	if (ret) {
 		ret = -EINVAL;
 		goto put_dstmem;
@@ -1045,7 +1047,7 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
 	buf = (u8 *)(zhdr + 1);
 	memcpy(buf, dst, dlen);
 	zpool_unmap_handle(entry->pool->zpool, handle);
-	put_cpu_var(zswap_dstmem);
+	put_locked_var(zswap_dstmem_lock, zswap_dstmem);
 
 	/* populate entry */
 	entry->offset = offset;
@@ -1072,7 +1074,7 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
 	return 0;
 
 put_dstmem:
-	put_cpu_var(zswap_dstmem);
+	put_locked_var(zswap_dstmem_lock, zswap_dstmem);
 	zswap_pool_put(entry->pool);
 freepage:
 	zswap_entry_cache_free(entry);
