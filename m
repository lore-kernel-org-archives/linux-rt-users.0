Return-Path: <SRS0=zk30=VU=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DBFC76190
	for <linux-rt-users@archiver.kernel.org>; Tue, 23 Jul 2019 19:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95B16218F0
	for <linux-rt-users@archiver.kernel.org>; Tue, 23 Jul 2019 19:03:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732186AbfGWTDl (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 23 Jul 2019 15:03:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:60892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729050AbfGWTDl (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 23 Jul 2019 15:03:41 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 881D9218F0;
        Tue, 23 Jul 2019 19:03:36 +0000 (UTC)
Date:   Tue, 23 Jul 2019 15:03:35 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <wagi@monom.org>, tom.zanussi@linux.intel.com
Subject: [ANNOUNCE] 4.19.59-rt24
Message-ID: <20190723150335.291cff59@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


Dear RT Folks,

I'm pleased to announce the 4.19.59-rt24 stable release.


You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.19-rt
  Head SHA1: dd209b062b86dd951cf1da93f20aa497fe99d52d


Or to build 4.19.59-rt24 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.59.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.19/patch-4.19.59-rt24.patch.xz



You can also build from 4.19.59-rt23 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.19/incr/patch-4.19.59-rt23-rt24.patch.xz



Enjoy,

-- Steve


Changes from v4.19.59-rt23:

---

Luis Claudio R. Goncalves (1):
      mm/zswap: Do not disable preemption in zswap_frontswap_store()

Sebastian Andrzej Siewior (12):
      kthread: add a global worker thread.
      genirq: Do not invoke the affinity callback via a workqueue on RT
      genirq: Handle missing work_struct in irq_set_affinity_notifier()
      arm: imx6: cpuidle: Use raw_spinlock_t
      rcu: Don't allow to change rcu_normal_after_boot on RT
      sched/core: Drop a preempt_disable_rt() statement
      timers: Redo the notification of canceling timers on -RT
      Revert "futex: Ensure lock/unlock symetry versus pi_lock and hash bucket lock"
      Revert "futex: Fix bug on when a requeued RT task times out"
      Revert "rtmutex: Handle the various new futex race conditions"
      Revert "futex: workaround migrate_disable/enable in different context"
      futex: Make the futex_hash_bucket lock raw

Steven Rostedt (VMware) (1):
      Linux 4.19.59-rt24

Thomas Gleixner (1):
      futex: Delay deallocation of pi_state

kbuild test robot (1):
      pci/switchtec: fix stream_open.cocci warnings

----
 arch/arm/mach-imx/cpuidle-imx6q.c |  10 +-
 drivers/block/loop.c              |   2 +-
 drivers/pci/switch/switchtec.c    |   2 +-
 drivers/spi/spi-rockchip.c        |   1 +
 fs/timerfd.c                      |   5 +-
 include/linux/blk-cgroup.h        |   2 +-
 include/linux/hrtimer.h           |  17 +--
 include/linux/interrupt.h         |   5 +-
 include/linux/kthread-cgroup.h    |  17 +++
 include/linux/kthread.h           |  17 ++-
 include/linux/posix-timers.h      |   1 +
 init/main.c                       |   1 +
 kernel/futex.c                    | 231 ++++++++++++++++----------------------
 kernel/irq/manage.c               |  24 ++--
 kernel/kthread.c                  |  14 +++
 kernel/locking/rtmutex.c          |  65 +----------
 kernel/locking/rtmutex_common.h   |   3 -
 kernel/rcu/update.c               |   2 +
 kernel/sched/core.c               |   9 +-
 kernel/time/alarmtimer.c          |   2 +-
 kernel/time/hrtimer.c             |  36 ++----
 kernel/time/itimer.c              |   2 +-
 kernel/time/posix-cpu-timers.c    |  23 ++++
 kernel/time/posix-timers.c        |  69 +++++-------
 kernel/time/posix-timers.h        |   2 +
 kernel/time/timer.c               |  96 ++++++++--------
 localversion-rt                   |   2 +-
 mm/zswap.c                        |  12 +-
 28 files changed, 291 insertions(+), 381 deletions(-)
---------------------------
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
index f1e63eb7cbca..aa76c816dbb4 100644
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
index 77d4fb86d05b..ea70bc0b06e9 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -360,7 +360,7 @@ static int switchtec_dev_open(struct inode *inode, struct file *filp)
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
 
diff --git a/fs/timerfd.c b/fs/timerfd.c
index 82d0f52414a6..f845093466be 100644
--- a/fs/timerfd.c
+++ b/fs/timerfd.c
@@ -471,10 +471,11 @@ static int do_timerfd_settime(int ufd, int flags,
 				break;
 		}
 		spin_unlock_irq(&ctx->wqh.lock);
+
 		if (isalarm(ctx))
-			hrtimer_wait_for_timer(&ctx->t.alarm.timer);
+			hrtimer_grab_expiry_lock(&ctx->t.alarm.timer);
 		else
-			hrtimer_wait_for_timer(&ctx->t.tmr);
+			hrtimer_grab_expiry_lock(&ctx->t.tmr);
 	}
 
 	/*
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 6d766a19f2bb..0473efda4c65 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -14,7 +14,7 @@
  * 	              Nauman Rafique <nauman@google.com>
  */
 
-#include <linux/cgroup.h>
+#include <linux/kthread-cgroup.h>
 #include <linux/percpu_counter.h>
 #include <linux/seq_file.h>
 #include <linux/radix-tree.h>
diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 2bdb047c7656..6c4c38186c99 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -22,7 +22,6 @@
 #include <linux/percpu.h>
 #include <linux/timer.h>
 #include <linux/timerqueue.h>
-#include <linux/wait.h>
 
 struct hrtimer_clock_base;
 struct hrtimer_cpu_base;
@@ -193,6 +192,8 @@ enum  hrtimer_base_type {
  * @nr_retries:		Total number of hrtimer interrupt retries
  * @nr_hangs:		Total number of hrtimer interrupt hangs
  * @max_hang_time:	Maximum time spent in hrtimer_interrupt
+ * @softirq_expiry_lock: Lock which is taken while softirq based hrtimer are
+ *			 expired
  * @expires_next:	absolute time of the next event, is required for remote
  *			hrtimer enqueue; it is the total first expiry time (hard
  *			and soft hrtimer are taken into account)
@@ -220,12 +221,10 @@ struct hrtimer_cpu_base {
 	unsigned short			nr_hangs;
 	unsigned int			max_hang_time;
 #endif
+	spinlock_t			softirq_expiry_lock;
 	ktime_t				expires_next;
 	struct hrtimer			*next_timer;
 	ktime_t				softirq_expires_next;
-#ifdef CONFIG_PREEMPT_RT_BASE
-	wait_queue_head_t		wait;
-#endif
 	struct hrtimer			*softirq_next_timer;
 	struct hrtimer_clock_base	clock_base[HRTIMER_MAX_CLOCK_BASES];
 } ____cacheline_aligned;
@@ -426,6 +425,7 @@ static inline void hrtimer_start(struct hrtimer *timer, ktime_t tim,
 
 extern int hrtimer_cancel(struct hrtimer *timer);
 extern int hrtimer_try_to_cancel(struct hrtimer *timer);
+extern void hrtimer_grab_expiry_lock(const struct hrtimer *timer);
 
 static inline void hrtimer_start_expires(struct hrtimer *timer,
 					 enum hrtimer_mode mode)
@@ -443,13 +443,6 @@ static inline void hrtimer_restart(struct hrtimer *timer)
 	hrtimer_start_expires(timer, HRTIMER_MODE_ABS);
 }
 
-/* Softirq preemption could deadlock timer removal */
-#ifdef CONFIG_PREEMPT_RT_BASE
-  extern void hrtimer_wait_for_timer(const struct hrtimer *timer);
-#else
-# define hrtimer_wait_for_timer(timer)	do { cpu_relax(); } while (0)
-#endif
-
 /* Query timers: */
 extern ktime_t __hrtimer_get_remaining(const struct hrtimer *timer, bool adjust);
 
@@ -475,7 +468,7 @@ static inline int hrtimer_is_queued(struct hrtimer *timer)
  * Helper function to check, whether the timer is running the callback
  * function
  */
-static inline int hrtimer_callback_running(const struct hrtimer *timer)
+static inline int hrtimer_callback_running(struct hrtimer *timer)
 {
 	return timer->base->running == timer;
 }
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 72333899f043..a9321f6429f2 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -13,7 +13,7 @@
 #include <linux/hrtimer.h>
 #include <linux/kref.h>
 #include <linux/workqueue.h>
-#include <linux/swork.h>
+#include <linux/kthread.h>
 
 #include <linux/atomic.h>
 #include <asm/ptrace.h>
@@ -228,7 +228,6 @@ extern void resume_device_irqs(void);
  * struct irq_affinity_notify - context for notification of IRQ affinity changes
  * @irq:		Interrupt to which notification applies
  * @kref:		Reference count, for internal use
- * @swork:		Swork item, for internal use
  * @work:		Work item, for internal use
  * @notify:		Function to be called on change.  This will be
  *			called in process context.
@@ -241,7 +240,7 @@ struct irq_affinity_notify {
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
index ad292898f7f2..7cf56eb54103 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -4,7 +4,6 @@
 /* Simple interface for creating and stopping kernel threads without mess. */
 #include <linux/err.h>
 #include <linux/sched.h>
-#include <linux/cgroup.h>
 
 __printf(4, 5)
 struct task_struct *kthread_create_on_node(int (*threadfn)(void *data),
@@ -106,7 +105,7 @@ struct kthread_delayed_work {
 };
 
 #define KTHREAD_WORKER_INIT(worker)	{				\
-	.lock = __SPIN_LOCK_UNLOCKED((worker).lock),			\
+	.lock = __RAW_SPIN_LOCK_UNLOCKED((worker).lock),		\
 	.work_list = LIST_HEAD_INIT((worker).work_list),		\
 	.delayed_work_list = LIST_HEAD_INIT((worker).delayed_work_list),\
 	}
@@ -198,14 +197,12 @@ bool kthread_cancel_delayed_work_sync(struct kthread_delayed_work *work);
 
 void kthread_destroy_worker(struct kthread_worker *worker);
 
-#ifdef CONFIG_BLK_CGROUP
-void kthread_associate_blkcg(struct cgroup_subsys_state *css);
-struct cgroup_subsys_state *kthread_blkcg(void);
-#else
-static inline void kthread_associate_blkcg(struct cgroup_subsys_state *css) { }
-static inline struct cgroup_subsys_state *kthread_blkcg(void)
+extern struct kthread_worker kthread_global_worker;
+void kthread_init_global_worker(void);
+
+static inline bool kthread_schedule_work(struct kthread_work *work)
 {
-	return NULL;
+	return kthread_queue_work(&kthread_global_worker, work);
 }
-#endif
+
 #endif /* _LINUX_KTHREAD_H */
diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index 0571b498db73..3e6c91bdf2ef 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -15,6 +15,7 @@ struct cpu_timer_list {
 	u64 expires, incr;
 	struct task_struct *task;
 	int firing;
+	int firing_cpu;
 };
 
 /*
diff --git a/init/main.c b/init/main.c
index 4a7471606e53..b0e95351c22c 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1130,6 +1130,7 @@ static noinline void __init kernel_init_freeable(void)
 	smp_prepare_cpus(setup_max_cpus);
 
 	workqueue_init();
+	kthread_init_global_worker();
 
 	init_mm_internals();
 
diff --git a/kernel/futex.c b/kernel/futex.c
index fe90164aa6ec..688b6fcb79cb 100644
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
 
@@ -875,6 +897,7 @@ void exit_pi_state_list(struct task_struct *curr)
 	struct futex_pi_state *pi_state;
 	struct futex_hash_bucket *hb;
 	union futex_key key = FUTEX_KEY_INIT;
+	LIST_HEAD(to_free);
 
 	if (!futex_cmpxchg_enabled)
 		return;
@@ -908,7 +931,7 @@ void exit_pi_state_list(struct task_struct *curr)
 		}
 		raw_spin_unlock_irq(&curr->pi_lock);
 
-		spin_lock(&hb->lock);
+		raw_spin_lock(&hb->lock);
 		raw_spin_lock_irq(&pi_state->pi_mutex.wait_lock);
 		raw_spin_lock(&curr->pi_lock);
 		/*
@@ -918,10 +941,8 @@ void exit_pi_state_list(struct task_struct *curr)
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
 
@@ -932,7 +953,7 @@ void exit_pi_state_list(struct task_struct *curr)
 
 		raw_spin_unlock(&curr->pi_lock);
 		raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
-		spin_unlock(&hb->lock);
+		raw_spin_unlock(&hb->lock);
 
 		rt_mutex_futex_unlock(&pi_state->pi_mutex);
 		put_pi_state(pi_state);
@@ -940,6 +961,8 @@ void exit_pi_state_list(struct task_struct *curr)
 		raw_spin_lock_irq(&curr->pi_lock);
 	}
 	raw_spin_unlock_irq(&curr->pi_lock);
+
+	free_pi_state_list(&to_free);
 }
 
 #endif
@@ -1426,7 +1449,7 @@ static void __unqueue_futex(struct futex_q *q)
 {
 	struct futex_hash_bucket *hb;
 
-	if (WARN_ON_SMP(!q->lock_ptr || !spin_is_locked(q->lock_ptr))
+	if (WARN_ON_SMP(!q->lock_ptr || !raw_spin_is_locked(q->lock_ptr))
 	    || WARN_ON(plist_node_empty(&q->list)))
 		return;
 
@@ -1554,21 +1577,21 @@ static inline void
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
@@ -1596,7 +1619,7 @@ futex_wake(u32 __user *uaddr, unsigned int flags, int nr_wake, u32 bitset)
 	if (!hb_waiters_pending(hb))
 		goto out_put_key;
 
-	spin_lock(&hb->lock);
+	raw_spin_lock(&hb->lock);
 
 	plist_for_each_entry_safe(this, next, &hb->chain, list) {
 		if (match_futex (&this->key, &key)) {
@@ -1615,7 +1638,7 @@ futex_wake(u32 __user *uaddr, unsigned int flags, int nr_wake, u32 bitset)
 		}
 	}
 
-	spin_unlock(&hb->lock);
+	raw_spin_unlock(&hb->lock);
 	wake_up_q(&wake_q);
 out_put_key:
 	put_futex_key(&key);
@@ -1922,6 +1945,7 @@ static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
 	struct futex_hash_bucket *hb1, *hb2;
 	struct futex_q *this, *next;
 	DEFINE_WAKE_Q(wake_q);
+	LIST_HEAD(to_free);
 
 	if (nr_wake < 0 || nr_requeue < 0)
 		return -EINVAL;
@@ -2149,16 +2173,6 @@ static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
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
@@ -2169,7 +2183,7 @@ static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
 				 * object.
 				 */
 				this->pi_state = NULL;
-				put_pi_state(pi_state);
+				put_pi_state_atomic(pi_state, &to_free);
 				/*
 				 * We stop queueing more waiters and let user
 				 * space deal with the mess.
@@ -2186,7 +2200,7 @@ static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
 	 * in futex_proxy_trylock_atomic() or in lookup_pi_state(). We
 	 * need to drop it here again.
 	 */
-	put_pi_state(pi_state);
+	put_pi_state_atomic(pi_state, &to_free);
 
 out_unlock:
 	double_unlock_hb(hb1, hb2);
@@ -2207,6 +2221,7 @@ static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
 out_put_key1:
 	put_futex_key(&key1);
 out:
+	free_pi_state_list(&to_free);
 	return ret ? ret : task_count;
 }
 
@@ -2230,7 +2245,7 @@ static inline struct futex_hash_bucket *queue_lock(struct futex_q *q)
 
 	q->lock_ptr = &hb->lock;
 
-	spin_lock(&hb->lock); /* implies smp_mb(); (A) */
+	raw_spin_lock(&hb->lock); /* implies smp_mb(); (A) */
 	return hb;
 }
 
@@ -2238,7 +2253,7 @@ static inline void
 queue_unlock(struct futex_hash_bucket *hb)
 	__releases(&hb->lock)
 {
-	spin_unlock(&hb->lock);
+	raw_spin_unlock(&hb->lock);
 	hb_waiters_dec(hb);
 }
 
@@ -2277,7 +2292,7 @@ static inline void queue_me(struct futex_q *q, struct futex_hash_bucket *hb)
 	__releases(&hb->lock)
 {
 	__queue_me(q, hb);
-	spin_unlock(&hb->lock);
+	raw_spin_unlock(&hb->lock);
 }
 
 /**
@@ -2293,41 +2308,41 @@ static inline void queue_me(struct futex_q *q, struct futex_hash_bucket *hb)
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
 
@@ -2343,13 +2358,16 @@ static int unqueue_me(struct futex_q *q)
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
@@ -2482,7 +2500,7 @@ static int fixup_pi_state_owner(u32 __user *uaddr, struct futex_q *q,
 	 */
 handle_err:
 	raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
-	spin_unlock(q->lock_ptr);
+	raw_spin_unlock(q->lock_ptr);
 
 	switch (err) {
 	case -EFAULT:
@@ -2500,7 +2518,7 @@ static int fixup_pi_state_owner(u32 __user *uaddr, struct futex_q *q,
 		break;
 	}
 
-	spin_lock(q->lock_ptr);
+	raw_spin_lock(q->lock_ptr);
 	raw_spin_lock_irq(&pi_state->pi_mutex.wait_lock);
 
 	/*
@@ -2596,7 +2614,7 @@ static void futex_wait_queue_me(struct futex_hash_bucket *hb, struct futex_q *q,
 	/*
 	 * The task state is guaranteed to be set before another task can
 	 * wake it. set_current_state() is implemented using smp_store_mb() and
-	 * queue_me() calls spin_unlock() upon completion, both serializing
+	 * queue_me() calls raw_spin_unlock() upon completion, both serializing
 	 * access to the hash list and forcing another memory barrier.
 	 */
 	set_current_state(TASK_INTERRUPTIBLE);
@@ -2887,15 +2905,7 @@ static int futex_lock_pi(u32 __user *uaddr, unsigned int flags,
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
@@ -2903,7 +2913,6 @@ static int futex_lock_pi(u32 __user *uaddr, unsigned int flags,
 	 */
 	ret = __rt_mutex_start_proxy_lock(&q.pi_state->pi_mutex, &rt_waiter, current);
 	raw_spin_unlock_irq(&q.pi_state->pi_mutex.wait_lock);
-	migrate_enable();
 
 	if (ret) {
 		if (ret == 1)
@@ -2917,7 +2926,7 @@ static int futex_lock_pi(u32 __user *uaddr, unsigned int flags,
 	ret = rt_mutex_wait_proxy_lock(&q.pi_state->pi_mutex, to, &rt_waiter);
 
 cleanup:
-	spin_lock(q.lock_ptr);
+	raw_spin_lock(q.lock_ptr);
 	/*
 	 * If we failed to acquire the lock (deadlock/signal/timeout), we must
 	 * first acquire the hb->lock before removing the lock from the
@@ -3018,7 +3027,7 @@ static int futex_unlock_pi(u32 __user *uaddr, unsigned int flags)
 		return ret;
 
 	hb = hash_futex(&key);
-	spin_lock(&hb->lock);
+	raw_spin_lock(&hb->lock);
 
 	/*
 	 * Check waiters first. We do not trust user space values at
@@ -3052,21 +3061,11 @@ static int futex_unlock_pi(u32 __user *uaddr, unsigned int flags)
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
@@ -3101,7 +3100,7 @@ static int futex_unlock_pi(u32 __user *uaddr, unsigned int flags)
 	 * owner.
 	 */
 	if ((ret = cmpxchg_futex_value_locked(&curval, uaddr, uval, 0))) {
-		spin_unlock(&hb->lock);
+		raw_spin_unlock(&hb->lock);
 		switch (ret) {
 		case -EFAULT:
 			goto pi_faulted;
@@ -3121,7 +3120,7 @@ static int futex_unlock_pi(u32 __user *uaddr, unsigned int flags)
 	ret = (curval == uval) ? 0 : -EAGAIN;
 
 out_unlock:
-	spin_unlock(&hb->lock);
+	raw_spin_unlock(&hb->lock);
 out_putkey:
 	put_futex_key(&key);
 	return ret;
@@ -3237,7 +3236,7 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 	struct hrtimer_sleeper timeout, *to = NULL;
 	struct futex_pi_state *pi_state = NULL;
 	struct rt_mutex_waiter rt_waiter;
-	struct futex_hash_bucket *hb, *hb2;
+	struct futex_hash_bucket *hb;
 	union futex_key key2 = FUTEX_KEY_INIT;
 	struct futex_q q = futex_q_init;
 	int res, ret;
@@ -3295,55 +3294,20 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
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
@@ -3352,8 +3316,9 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
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
@@ -3363,8 +3328,9 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
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
@@ -3378,8 +3344,7 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 		pi_mutex = &q.pi_state->pi_mutex;
 		ret = rt_mutex_wait_proxy_lock(pi_mutex, to, &rt_waiter);
 
-		spin_lock(&hb2->lock);
-		BUG_ON(&hb2->lock != q.lock_ptr);
+		raw_spin_lock(q.lock_ptr);
 		if (ret && !rt_mutex_cleanup_proxy_lock(pi_mutex, &rt_waiter))
 			ret = 0;
 
@@ -3816,7 +3781,7 @@ static int __init futex_init(void)
 	for (i = 0; i < futex_hashsize; i++) {
 		atomic_set(&futex_queues[i].waiters, 0);
 		plist_head_init(&futex_queues[i].chain);
-		spin_lock_init(&futex_queues[i].lock);
+		raw_spin_lock_init(&futex_queues[i].lock);
 	}
 
 	return 0;
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 7f4041357d2f..b2736d7d863b 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -261,7 +261,7 @@ int irq_set_affinity_locked(struct irq_data *data, const struct cpumask *mask,
 		kref_get(&desc->affinity_notify->kref);
 
 #ifdef CONFIG_PREEMPT_RT_BASE
-		swork_queue(&desc->affinity_notify->swork);
+		kthread_schedule_work(&desc->affinity_notify->work);
 #else
 		schedule_work(&desc->affinity_notify->work);
 #endif
@@ -326,21 +326,11 @@ static void _irq_affinity_notify(struct irq_affinity_notify *notify)
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
 
@@ -383,8 +373,7 @@ irq_set_affinity_notifier(unsigned int irq, struct irq_affinity_notify *notify)
 		notify->irq = irq;
 		kref_init(&notify->kref);
 #ifdef CONFIG_PREEMPT_RT_BASE
-		INIT_SWORK(&notify->swork, irq_affinity_notify);
-		init_helper_thread();
+		kthread_init_work(&notify->work, irq_affinity_notify);
 #else
 		INIT_WORK(&notify->work, irq_affinity_notify);
 #endif
@@ -396,8 +385,9 @@ irq_set_affinity_notifier(unsigned int irq, struct irq_affinity_notify *notify)
 	raw_spin_unlock_irqrestore(&desc->lock, flags);
 
 	if (old_notify) {
-#ifndef CONFIG_PREEMPT_RT_BASE
-		/* Need to address this for PREEMPT_RT */
+#ifdef CONFIG_PREEMPT_RT_BASE
+		kthread_cancel_work_sync(&notify->work);
+#else
 		cancel_work_sync(&old_notify->work);
 #endif
 		kref_put(&old_notify->kref, old_notify->release);
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 5641b55783a6..9db017761a1f 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -20,6 +20,7 @@
 #include <linux/freezer.h>
 #include <linux/ptrace.h>
 #include <linux/uaccess.h>
+#include <linux/cgroup.h>
 #include <trace/events/sched.h>
 
 static DEFINE_SPINLOCK(kthread_create_lock);
@@ -1180,6 +1181,19 @@ void kthread_destroy_worker(struct kthread_worker *worker)
 }
 EXPORT_SYMBOL(kthread_destroy_worker);
 
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
+
 #ifdef CONFIG_BLK_CGROUP
 /**
  * kthread_associate_blkcg - associate blkcg to current kthread
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 2a9bf2443acc..44a33057a83a 100644
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
@@ -1328,22 +1321,6 @@ static int task_blocks_on_rt_mutex(struct rt_mutex *lock,
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
@@ -1367,7 +1344,7 @@ static int task_blocks_on_rt_mutex(struct rt_mutex *lock,
 		rt_mutex_enqueue_pi(owner, waiter);
 
 		rt_mutex_adjust_prio(owner);
-		if (rt_mutex_real_waiter(owner->pi_blocked_on))
+		if (owner->pi_blocked_on)
 			chain_walk = 1;
 	} else if (rt_mutex_cond_detect_deadlock(waiter, chwalk)) {
 		chain_walk = 1;
@@ -1467,7 +1444,7 @@ static void remove_waiter(struct rt_mutex *lock,
 {
 	bool is_top_waiter = (waiter == rt_mutex_top_waiter(lock));
 	struct task_struct *owner = rt_mutex_owner(lock);
-	struct rt_mutex *next_lock = NULL;
+	struct rt_mutex *next_lock;
 
 	lockdep_assert_held(&lock->wait_lock);
 
@@ -1493,8 +1470,7 @@ static void remove_waiter(struct rt_mutex *lock,
 	rt_mutex_adjust_prio(owner);
 
 	/* Store the lock on which owner is blocked or NULL */
-	if (rt_mutex_real_waiter(owner->pi_blocked_on))
-		next_lock = task_blocked_on_lock(owner);
+	next_lock = task_blocked_on_lock(owner);
 
 	raw_spin_unlock(&owner->pi_lock);
 
@@ -1530,8 +1506,7 @@ void rt_mutex_adjust_pi(struct task_struct *task)
 	raw_spin_lock_irqsave(&task->pi_lock, flags);
 
 	waiter = task->pi_blocked_on;
-	if (!rt_mutex_real_waiter(waiter) ||
-	    rt_mutex_waiter_equal(waiter, task_to_waiter(task))) {
+	if (!waiter || rt_mutex_waiter_equal(waiter, task_to_waiter(task))) {
 		raw_spin_unlock_irqrestore(&task->pi_lock, flags);
 		return;
 	}
@@ -2350,34 +2325,6 @@ int __rt_mutex_start_proxy_lock(struct rt_mutex *lock,
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
index 546aaf058b9e..758dc43872e5 100644
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -132,9 +132,6 @@ enum rtmutex_chainwalk {
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
index 16d8dba23329..ed75addd3ccd 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -69,7 +69,9 @@ module_param(rcu_expedited, int, 0);
 extern int rcu_normal; /* from sysctl */
 module_param(rcu_normal, int, 0);
 static int rcu_normal_after_boot = IS_ENABLED(CONFIG_PREEMPT_RT_FULL);
+#ifndef CONFIG_PREEMPT_RT_FULL
 module_param(rcu_normal_after_boot, int, 0);
+#endif
 #endif /* #ifndef CONFIG_TINY_RCU */
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 91a9b2556fb0..1b2503b87473 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -558,14 +558,11 @@ void resched_cpu(int cpu)
  */
 int get_nohz_timer_target(void)
 {
-	int i, cpu;
+	int i, cpu = smp_processor_id();
 	struct sched_domain *sd;
 
-	preempt_disable_rt();
-	cpu = smp_processor_id();
-
 	if (!idle_cpu(cpu) && housekeeping_cpu(cpu, HK_FLAG_TIMER))
-		goto preempt_en_rt;
+		return cpu;
 
 	rcu_read_lock();
 	for_each_domain(cpu, sd) {
@@ -584,8 +581,6 @@ int get_nohz_timer_target(void)
 		cpu = housekeeping_any_cpu(HK_FLAG_TIMER);
 unlock:
 	rcu_read_unlock();
-preempt_en_rt:
-	preempt_enable_rt();
 	return cpu;
 }
 
diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 966708e8ce14..efa1e433974b 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -436,7 +436,7 @@ int alarm_cancel(struct alarm *alarm)
 		int ret = alarm_try_to_cancel(alarm);
 		if (ret >= 0)
 			return ret;
-		hrtimer_wait_for_timer(&alarm->timer);
+		hrtimer_grab_expiry_lock(&alarm->timer);
 	}
 }
 EXPORT_SYMBOL_GPL(alarm_cancel);
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index e1040b80362c..4534e7871c8c 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -963,33 +963,16 @@ u64 hrtimer_forward(struct hrtimer *timer, ktime_t now, ktime_t interval)
 }
 EXPORT_SYMBOL_GPL(hrtimer_forward);
 
-#ifdef CONFIG_PREEMPT_RT_BASE
-# define wake_up_timer_waiters(b)	wake_up(&(b)->wait)
-
-/**
- * hrtimer_wait_for_timer - Wait for a running timer
- *
- * @timer:	timer to wait for
- *
- * The function waits in case the timers callback function is
- * currently executed on the waitqueue of the timer base. The
- * waitqueue is woken up after the timer callback function has
- * finished execution.
- */
-void hrtimer_wait_for_timer(const struct hrtimer *timer)
+void hrtimer_grab_expiry_lock(const struct hrtimer *timer)
 {
 	struct hrtimer_clock_base *base = timer->base;
 
-	if (base && base->cpu_base &&
-	    base->index >= HRTIMER_BASE_MONOTONIC_SOFT)
-		wait_event(base->cpu_base->wait,
-				!(hrtimer_callback_running(timer)));
+	if (base && base->cpu_base) {
+		spin_lock(&base->cpu_base->softirq_expiry_lock);
+		spin_unlock(&base->cpu_base->softirq_expiry_lock);
+	}
 }
 
-#else
-# define wake_up_timer_waiters(b)	do { } while (0)
-#endif
-
 /*
  * enqueue_hrtimer - internal function to (re)start a timer
  *
@@ -1224,7 +1207,7 @@ int hrtimer_cancel(struct hrtimer *timer)
 
 		if (ret >= 0)
 			return ret;
-		hrtimer_wait_for_timer(timer);
+		hrtimer_grab_expiry_lock(timer);
 	}
 }
 EXPORT_SYMBOL_GPL(hrtimer_cancel);
@@ -1528,6 +1511,7 @@ static __latent_entropy void hrtimer_run_softirq(struct softirq_action *h)
 	unsigned long flags;
 	ktime_t now;
 
+	spin_lock(&cpu_base->softirq_expiry_lock);
 	raw_spin_lock_irqsave(&cpu_base->lock, flags);
 
 	now = hrtimer_update_base(cpu_base);
@@ -1537,7 +1521,7 @@ static __latent_entropy void hrtimer_run_softirq(struct softirq_action *h)
 	hrtimer_update_softirq_timer(cpu_base, true);
 
 	raw_spin_unlock_irqrestore(&cpu_base->lock, flags);
-	wake_up_timer_waiters(cpu_base);
+	spin_unlock(&cpu_base->softirq_expiry_lock);
 }
 
 #ifdef CONFIG_HIGH_RES_TIMERS
@@ -1947,9 +1931,7 @@ int hrtimers_prepare_cpu(unsigned int cpu)
 	cpu_base->softirq_next_timer = NULL;
 	cpu_base->expires_next = KTIME_MAX;
 	cpu_base->softirq_expires_next = KTIME_MAX;
-#ifdef CONFIG_PREEMPT_RT_BASE
-	init_waitqueue_head(&cpu_base->wait);
-#endif
+	spin_lock_init(&cpu_base->softirq_expiry_lock);
 	return 0;
 }
 
diff --git a/kernel/time/itimer.c b/kernel/time/itimer.c
index 55b0e58368bf..a5ff222df4c7 100644
--- a/kernel/time/itimer.c
+++ b/kernel/time/itimer.c
@@ -215,7 +215,7 @@ int do_setitimer(int which, struct itimerval *value, struct itimerval *ovalue)
 		/* We are sharing ->siglock with it_real_fn() */
 		if (hrtimer_try_to_cancel(timer) < 0) {
 			spin_unlock_irq(&tsk->sighand->siglock);
-			hrtimer_wait_for_timer(&tsk->signal->real_timer);
+			hrtimer_grab_expiry_lock(timer);
 			goto again;
 		}
 		expires = timeval_to_ktime(value->it_value);
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index baeeaef3b721..59ceedbb03f0 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -789,6 +789,7 @@ check_timers_list(struct list_head *timers,
 			return t->expires;
 
 		t->firing = 1;
+		t->firing_cpu = smp_processor_id();
 		list_move_tail(&t->entry, firing);
 	}
 
@@ -1134,6 +1135,20 @@ static inline int fastpath_timer_check(struct task_struct *tsk)
 	return 0;
 }
 
+static DEFINE_PER_CPU(spinlock_t, cpu_timer_expiry_lock) = __SPIN_LOCK_UNLOCKED(cpu_timer_expiry_lock);
+
+void cpu_timers_grab_expiry_lock(struct k_itimer *timer)
+{
+	int cpu = timer->it.cpu.firing_cpu;
+
+	if (cpu >= 0) {
+		spinlock_t *expiry_lock = per_cpu_ptr(&cpu_timer_expiry_lock, cpu);
+
+		spin_lock_irq(expiry_lock);
+		spin_unlock_irq(expiry_lock);
+	}
+}
+
 /*
  * This is called from the timer interrupt handler.  The irq handler has
  * already updated our counts.  We need to check if any timers fire now.
@@ -1144,6 +1159,7 @@ static void __run_posix_cpu_timers(struct task_struct *tsk)
 	LIST_HEAD(firing);
 	struct k_itimer *timer, *next;
 	unsigned long flags;
+	spinlock_t *expiry_lock;
 
 	/*
 	 * The fast path checks that there are no expired thread or thread
@@ -1152,6 +1168,9 @@ static void __run_posix_cpu_timers(struct task_struct *tsk)
 	if (!fastpath_timer_check(tsk))
 		return;
 
+	expiry_lock = this_cpu_ptr(&cpu_timer_expiry_lock);
+	spin_lock(expiry_lock);
+
 	if (!lock_task_sighand(tsk, &flags))
 		return;
 	/*
@@ -1186,6 +1205,7 @@ static void __run_posix_cpu_timers(struct task_struct *tsk)
 		list_del_init(&timer->it.cpu.entry);
 		cpu_firing = timer->it.cpu.firing;
 		timer->it.cpu.firing = 0;
+		timer->it.cpu.firing_cpu = -1;
 		/*
 		 * The firing flag is -1 if we collided with a reset
 		 * of the timer, which already reported this
@@ -1195,6 +1215,7 @@ static void __run_posix_cpu_timers(struct task_struct *tsk)
 			cpu_timer_fire(timer);
 		spin_unlock(&timer->it_lock);
 	}
+	spin_unlock(expiry_lock);
 }
 
 #ifdef CONFIG_PREEMPT_RT_BASE
@@ -1460,6 +1481,8 @@ static int do_cpu_nanosleep(const clockid_t which_clock, int flags,
 		spin_unlock_irq(&timer.it_lock);
 
 		while (error == TIMER_RETRY) {
+
+			cpu_timers_grab_expiry_lock(&timer);
 			/*
 			 * We need to handle case when timer was or is in the
 			 * middle of firing. In other cases we already freed
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index a5ec421e3437..c7e97d421590 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -821,25 +821,20 @@ static void common_hrtimer_arm(struct k_itimer *timr, ktime_t expires,
 		hrtimer_start_expires(timer, HRTIMER_MODE_ABS);
 }
 
-/*
- * Protected by RCU!
- */
-static void timer_wait_for_callback(const struct k_clock *kc, struct k_itimer *timr)
+static int common_hrtimer_try_to_cancel(struct k_itimer *timr)
 {
-#ifdef CONFIG_PREEMPT_RT_FULL
-	if (kc->timer_arm == common_hrtimer_arm)
-		hrtimer_wait_for_timer(&timr->it.real.timer);
-	else if (kc == &alarm_clock)
-		hrtimer_wait_for_timer(&timr->it.alarm.alarmtimer.timer);
-	else
-		/* FIXME: Whacky hack for posix-cpu-timers */
-		schedule_timeout(1);
-#endif
+	return hrtimer_try_to_cancel(&timr->it.real.timer);
 }
 
-static int common_hrtimer_try_to_cancel(struct k_itimer *timr)
+static void timer_wait_for_callback(const struct k_clock *kc, struct k_itimer *timer)
 {
-	return hrtimer_try_to_cancel(&timr->it.real.timer);
+	if (kc->timer_arm == common_hrtimer_arm)
+		hrtimer_grab_expiry_lock(&timer->it.real.timer);
+	else if (kc == &alarm_clock)
+		hrtimer_grab_expiry_lock(&timer->it.alarm.alarmtimer.timer);
+	else
+		/* posix-cpu-timers */
+		cpu_timers_grab_expiry_lock(timer);
 }
 
 /* Set a POSIX.1b interval timer. */
@@ -901,21 +896,21 @@ static int do_timer_settime(timer_t timer_id, int flags,
 	if (!timr)
 		return -EINVAL;
 
-	rcu_read_lock();
 	kc = timr->kclock;
 	if (WARN_ON_ONCE(!kc || !kc->timer_set))
 		error = -EINVAL;
 	else
 		error = kc->timer_set(timr, flags, new_spec64, old_spec64);
 
-	unlock_timer(timr, flag);
 	if (error == TIMER_RETRY) {
+		rcu_read_lock();
+		unlock_timer(timr, flag);
 		timer_wait_for_callback(kc, timr);
-		old_spec64 = NULL;	// We already got the old time...
 		rcu_read_unlock();
+		old_spec64 = NULL;	// We already got the old time...
 		goto retry;
 	}
-	rcu_read_unlock();
+	unlock_timer(timr, flag);
 
 	return error;
 }
@@ -977,13 +972,21 @@ int common_timer_del(struct k_itimer *timer)
 	return 0;
 }
 
-static inline int timer_delete_hook(struct k_itimer *timer)
+static int timer_delete_hook(struct k_itimer *timer)
 {
 	const struct k_clock *kc = timer->kclock;
+	int ret;
 
 	if (WARN_ON_ONCE(!kc || !kc->timer_del))
 		return -EINVAL;
-	return kc->timer_del(timer);
+	ret = kc->timer_del(timer);
+	if (ret == TIMER_RETRY) {
+		rcu_read_lock();
+		spin_unlock_irq(&timer->it_lock);
+		timer_wait_for_callback(kc, timer);
+		rcu_read_unlock();
+	}
+	return ret;
 }
 
 /* Delete a POSIX.1b interval timer. */
@@ -997,15 +1000,8 @@ SYSCALL_DEFINE1(timer_delete, timer_t, timer_id)
 	if (!timer)
 		return -EINVAL;
 
-	rcu_read_lock();
-	if (timer_delete_hook(timer) == TIMER_RETRY) {
-		unlock_timer(timer, flags);
-		timer_wait_for_callback(clockid_to_kclock(timer->it_clock),
-					timer);
-		rcu_read_unlock();
+	if (timer_delete_hook(timer) == TIMER_RETRY)
 		goto retry_delete;
-	}
-	rcu_read_unlock();
 
 	spin_lock(&current->sighand->siglock);
 	list_del(&timer->list);
@@ -1031,20 +1027,9 @@ static void itimer_delete(struct k_itimer *timer)
 retry_delete:
 	spin_lock_irqsave(&timer->it_lock, flags);
 
-	/* On RT we can race with a deletion */
-	if (!timer->it_signal) {
-		unlock_timer(timer, flags);
-		return;
-	}
-
-	if (timer_delete_hook(timer) == TIMER_RETRY) {
-		rcu_read_lock();
-		unlock_timer(timer, flags);
-		timer_wait_for_callback(clockid_to_kclock(timer->it_clock),
-					timer);
-		rcu_read_unlock();
+	if (timer_delete_hook(timer) == TIMER_RETRY)
 		goto retry_delete;
-	}
+
 	list_del(&timer->list);
 	/*
 	 * This keeps any tasks waiting on the spin lock from thinking
diff --git a/kernel/time/posix-timers.h b/kernel/time/posix-timers.h
index ddb21145211a..725bd230a8db 100644
--- a/kernel/time/posix-timers.h
+++ b/kernel/time/posix-timers.h
@@ -32,6 +32,8 @@ extern const struct k_clock clock_process;
 extern const struct k_clock clock_thread;
 extern const struct k_clock alarm_clock;
 
+extern void cpu_timers_grab_expiry_lock(struct k_itimer *timer);
+
 int posix_timer_event(struct k_itimer *timr, int si_private);
 
 void common_timer_get(struct k_itimer *timr, struct itimerspec64 *cur_setting);
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 781483c76b17..d6289d8df06b 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -44,7 +44,6 @@
 #include <linux/sched/debug.h>
 #include <linux/slab.h>
 #include <linux/compat.h>
-#include <linux/swait.h>
 
 #include <linux/uaccess.h>
 #include <asm/unistd.h>
@@ -198,9 +197,7 @@ EXPORT_SYMBOL(jiffies_64);
 struct timer_base {
 	raw_spinlock_t		lock;
 	struct timer_list	*running_timer;
-#ifdef CONFIG_PREEMPT_RT_FULL
-	struct swait_queue_head	wait_for_running_timer;
-#endif
+	spinlock_t		expiry_lock;
 	unsigned long		clk;
 	unsigned long		next_expiry;
 	unsigned int		cpu;
@@ -1189,33 +1186,6 @@ void add_timer_on(struct timer_list *timer, int cpu)
 }
 EXPORT_SYMBOL_GPL(add_timer_on);
 
-#ifdef CONFIG_PREEMPT_RT_FULL
-/*
- * Wait for a running timer
- */
-static void wait_for_running_timer(struct timer_list *timer)
-{
-	struct timer_base *base;
-	u32 tf = timer->flags;
-
-	if (tf & TIMER_MIGRATING)
-		return;
-
-	base = get_timer_base(tf);
-	swait_event_exclusive(base->wait_for_running_timer,
-			      base->running_timer != timer);
-}
-
-# define wakeup_timer_waiters(b)	swake_up_all(&(b)->wait_for_running_timer)
-#else
-static inline void wait_for_running_timer(struct timer_list *timer)
-{
-	cpu_relax();
-}
-
-# define wakeup_timer_waiters(b)	do { } while (0)
-#endif
-
 /**
  * del_timer - deactivate a timer.
  * @timer: the timer to be deactivated
@@ -1245,14 +1215,8 @@ int del_timer(struct timer_list *timer)
 }
 EXPORT_SYMBOL(del_timer);
 
-/**
- * try_to_del_timer_sync - Try to deactivate a timer
- * @timer: timer to delete
- *
- * This function tries to deactivate a timer. Upon successful (ret >= 0)
- * exit the timer is not queued and the handler is not running on any CPU.
- */
-int try_to_del_timer_sync(struct timer_list *timer)
+static int __try_to_del_timer_sync(struct timer_list *timer,
+				   struct timer_base **basep)
 {
 	struct timer_base *base;
 	unsigned long flags;
@@ -1260,7 +1224,7 @@ int try_to_del_timer_sync(struct timer_list *timer)
 
 	debug_assert_init(timer);
 
-	base = lock_timer_base(timer, &flags);
+	*basep = base = lock_timer_base(timer, &flags);
 
 	if (base->running_timer != timer)
 		ret = detach_if_pending(timer, base, true);
@@ -1269,9 +1233,42 @@ int try_to_del_timer_sync(struct timer_list *timer)
 
 	return ret;
 }
+
+/**
+ * try_to_del_timer_sync - Try to deactivate a timer
+ * @timer: timer to delete
+ *
+ * This function tries to deactivate a timer. Upon successful (ret >= 0)
+ * exit the timer is not queued and the handler is not running on any CPU.
+ */
+int try_to_del_timer_sync(struct timer_list *timer)
+{
+	struct timer_base *base;
+
+	return __try_to_del_timer_sync(timer, &base);
+}
 EXPORT_SYMBOL(try_to_del_timer_sync);
 
 #if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT_FULL)
+static int __del_timer_sync(struct timer_list *timer)
+{
+	struct timer_base *base;
+	int ret;
+
+	for (;;) {
+		ret = __try_to_del_timer_sync(timer, &base);
+		if (ret >= 0)
+			return ret;
+
+		/*
+		 * When accessing the lock, timers of base are no longer expired
+		 * and so timer is no longer running.
+		 */
+		spin_lock(&base->expiry_lock);
+		spin_unlock(&base->expiry_lock);
+	}
+}
+
 /**
  * del_timer_sync - deactivate a timer and wait for the handler to finish.
  * @timer: the timer to be deactivated
@@ -1327,12 +1324,8 @@ int del_timer_sync(struct timer_list *timer)
 	 * could lead to deadlock.
 	 */
 	WARN_ON(in_irq() && !(timer->flags & TIMER_IRQSAFE));
-	for (;;) {
-		int ret = try_to_del_timer_sync(timer);
-		if (ret >= 0)
-			return ret;
-		wait_for_running_timer(timer);
-	}
+
+	return __del_timer_sync(timer);
 }
 EXPORT_SYMBOL(del_timer_sync);
 #endif
@@ -1397,11 +1390,15 @@ static void expire_timers(struct timer_base *base, struct hlist_head *head)
 			raw_spin_unlock(&base->lock);
 			call_timer_fn(timer, fn);
 			base->running_timer = NULL;
+			spin_unlock(&base->expiry_lock);
+			spin_lock(&base->expiry_lock);
 			raw_spin_lock(&base->lock);
 		} else {
 			raw_spin_unlock_irq(&base->lock);
 			call_timer_fn(timer, fn);
 			base->running_timer = NULL;
+			spin_unlock(&base->expiry_lock);
+			spin_lock(&base->expiry_lock);
 			raw_spin_lock_irq(&base->lock);
 		}
 	}
@@ -1696,6 +1693,7 @@ static inline void __run_timers(struct timer_base *base)
 	if (!time_after_eq(jiffies, base->clk))
 		return;
 
+	spin_lock(&base->expiry_lock);
 	raw_spin_lock_irq(&base->lock);
 
 	/*
@@ -1723,7 +1721,7 @@ static inline void __run_timers(struct timer_base *base)
 			expire_timers(base, heads + levels);
 	}
 	raw_spin_unlock_irq(&base->lock);
-	wakeup_timer_waiters(base);
+	spin_unlock(&base->expiry_lock);
 }
 
 /*
@@ -1970,9 +1968,7 @@ static void __init init_timer_cpu(int cpu)
 		base->cpu = cpu;
 		raw_spin_lock_init(&base->lock);
 		base->clk = jiffies;
-#ifdef CONFIG_PREEMPT_RT_FULL
-		init_swait_queue_head(&base->wait_for_running_timer);
-#endif
+		spin_lock_init(&base->expiry_lock);
 	}
 }
 
diff --git a/localversion-rt b/localversion-rt
index 9a218ca23053..b2111a212663 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt23
+-rt24
diff --git a/mm/zswap.c b/mm/zswap.c
index cd91fd9d96b8..420225d3ff0b 100644
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
@@ -990,6 +991,8 @@ static void zswap_fill_page(void *ptr, unsigned long value)
 	memset_l(page, value, PAGE_SIZE / sizeof(unsigned long));
 }
 
+/* protect zswap_dstmem from concurrency */
+static DEFINE_LOCAL_IRQ_LOCK(zswap_dstmem_lock);
 /*********************************
 * frontswap hooks
 **********************************/
@@ -1066,12 +1069,11 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
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
@@ -1094,7 +1096,7 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
 	memcpy(buf, &zhdr, hlen);
 	memcpy(buf + hlen, dst, dlen);
 	zpool_unmap_handle(entry->pool->zpool, handle);
-	put_cpu_var(zswap_dstmem);
+	put_locked_var(zswap_dstmem_lock, zswap_dstmem);
 
 	/* populate entry */
 	entry->offset = offset;
@@ -1122,7 +1124,7 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
 	return 0;
 
 put_dstmem:
-	put_cpu_var(zswap_dstmem);
+	put_locked_var(zswap_dstmem_lock, zswap_dstmem);
 	zswap_pool_put(entry->pool);
 freepage:
 	zswap_entry_cache_free(entry);
