From: Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] 4.4.102-rt117
Date: Thu, 14 Dec 2017 23:18:24 -0500
Message-ID: <20171214231824.4f86a438@vmware.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com, Alex Shi <alex.shi@linaro.org>
To: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


Dear RT Folks,

I'm pleased to announce the 4.4.102-rt117 stable release.


You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.4-rt
  Head SHA1: 3e11a4219d6b61555b365769df6c165e2eafba47


Or to build 4.4.102-rt117 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.4.tar.xz

  http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.4.102.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.4/patch-4.4.102-rt117.patch.xz



You can also build from 4.4.102-rt116 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.4/incr/patch-4.4.102-rt116-rt117.patch.xz



Enjoy,

-- Steve


Changes from v4.4.102-rt116:

---

Alex Shi (1):
      cpu_pm: replace raw_notifier to atomic_notifier

Mike Galbraith (1):
      kernel/hrtimer/hotplug: don't wake ktimersoftd while holding the hrtimer base lock

Mikulas Patocka (1):
      locking/rt-mutex: fix deadlock in device mapper / block-IO

Sebastian Andrzej Siewior (6):
      Revert "fs: jbd2: pull your plug when waiting for space"
      kernel/hrtimer: migrate deferred timer on CPU down
      kernel/hrtimer: don't wakeup a process while holding the hrtimer base lock
      Bluetooth: avoid recursive locking in hci_send_to_channel()
      rt/locking: allow recursive local_trylock()
      net: use trylock in icmp_sk

Steven Rostedt (VMware) (1):
      Linux 4.4.102-rt117

----
 fs/jbd2/checkpoint.c      |  2 --
 include/linux/locallock.h |  9 +++++++++
 kernel/cpu_pm.c           | 43 ++++++-------------------------------------
 kernel/locking/rtmutex.c  | 25 ++++++++++++++++++++-----
 kernel/time/hrtimer.c     | 35 ++++++++++++++++++++++++++---------
 localversion-rt           |  2 +-
 net/bluetooth/hci_sock.c  | 17 +++++++++++------
 net/ipv4/icmp.c           |  6 +++++-
 8 files changed, 78 insertions(+), 61 deletions(-)
---------------------------
diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
index 6e18a06aaabe..684996c8a3a4 100644
--- a/fs/jbd2/checkpoint.c
+++ b/fs/jbd2/checkpoint.c
@@ -116,8 +116,6 @@ void __jbd2_log_wait_for_space(journal_t *journal)
 	nblocks = jbd2_space_needed(journal);
 	while (jbd2_log_space_left(journal) < nblocks) {
 		write_unlock(&journal->j_state_lock);
-		if (current->plug)
-			io_schedule();
 		mutex_lock(&journal->j_checkpoint_mutex);
 
 		/*
diff --git a/include/linux/locallock.h b/include/linux/locallock.h
index e572a3971631..0baaf28dc4ee 100644
--- a/include/linux/locallock.h
+++ b/include/linux/locallock.h
@@ -77,6 +77,9 @@ static inline int __local_trylock(struct local_irq_lock *lv)
 		lv->owner = current;
 		lv->nestcnt = 1;
 		return 1;
+	} else if (lv->owner == current) {
+		lv->nestcnt++;
+		return 1;
 	}
 	return 0;
 }
@@ -250,6 +253,12 @@ static inline int __local_unlock_irqrestore(struct local_irq_lock *lv,
 
 static inline void local_irq_lock_init(int lvar) { }
 
+#define local_trylock(lvar)					\
+	({							\
+		preempt_disable();				\
+		1;						\
+	})
+
 #define local_lock(lvar)			preempt_disable()
 #define local_unlock(lvar)			preempt_enable()
 #define local_lock_irq(lvar)			local_irq_disable()
diff --git a/kernel/cpu_pm.c b/kernel/cpu_pm.c
index 009cc9a17d95..10f4640f991e 100644
--- a/kernel/cpu_pm.c
+++ b/kernel/cpu_pm.c
@@ -22,14 +22,13 @@
 #include <linux/spinlock.h>
 #include <linux/syscore_ops.h>
 
-static DEFINE_RWLOCK(cpu_pm_notifier_lock);
-static RAW_NOTIFIER_HEAD(cpu_pm_notifier_chain);
+static ATOMIC_NOTIFIER_HEAD(cpu_pm_notifier_chain);
 
 static int cpu_pm_notify(enum cpu_pm_event event, int nr_to_call, int *nr_calls)
 {
 	int ret;
 
-	ret = __raw_notifier_call_chain(&cpu_pm_notifier_chain, event, NULL,
+	ret = __atomic_notifier_call_chain(&cpu_pm_notifier_chain, event, NULL,
 		nr_to_call, nr_calls);
 
 	return notifier_to_errno(ret);
@@ -47,14 +46,7 @@ static int cpu_pm_notify(enum cpu_pm_event event, int nr_to_call, int *nr_calls)
  */
 int cpu_pm_register_notifier(struct notifier_block *nb)
 {
-	unsigned long flags;
-	int ret;
-
-	write_lock_irqsave(&cpu_pm_notifier_lock, flags);
-	ret = raw_notifier_chain_register(&cpu_pm_notifier_chain, nb);
-	write_unlock_irqrestore(&cpu_pm_notifier_lock, flags);
-
-	return ret;
+	return atomic_notifier_chain_register(&cpu_pm_notifier_chain, nb);
 }
 EXPORT_SYMBOL_GPL(cpu_pm_register_notifier);
 
@@ -69,14 +61,7 @@ EXPORT_SYMBOL_GPL(cpu_pm_register_notifier);
  */
 int cpu_pm_unregister_notifier(struct notifier_block *nb)
 {
-	unsigned long flags;
-	int ret;
-
-	write_lock_irqsave(&cpu_pm_notifier_lock, flags);
-	ret = raw_notifier_chain_unregister(&cpu_pm_notifier_chain, nb);
-	write_unlock_irqrestore(&cpu_pm_notifier_lock, flags);
-
-	return ret;
+	return atomic_notifier_chain_unregister(&cpu_pm_notifier_chain, nb);
 }
 EXPORT_SYMBOL_GPL(cpu_pm_unregister_notifier);
 
@@ -100,7 +85,6 @@ int cpu_pm_enter(void)
 	int nr_calls;
 	int ret = 0;
 
-	read_lock(&cpu_pm_notifier_lock);
 	ret = cpu_pm_notify(CPU_PM_ENTER, -1, &nr_calls);
 	if (ret)
 		/*
@@ -108,7 +92,6 @@ int cpu_pm_enter(void)
 		 * PM entry who are notified earlier to prepare for it.
 		 */
 		cpu_pm_notify(CPU_PM_ENTER_FAILED, nr_calls - 1, NULL);
-	read_unlock(&cpu_pm_notifier_lock);
 
 	return ret;
 }
@@ -128,13 +111,7 @@ EXPORT_SYMBOL_GPL(cpu_pm_enter);
  */
 int cpu_pm_exit(void)
 {
-	int ret;
-
-	read_lock(&cpu_pm_notifier_lock);
-	ret = cpu_pm_notify(CPU_PM_EXIT, -1, NULL);
-	read_unlock(&cpu_pm_notifier_lock);
-
-	return ret;
+	return cpu_pm_notify(CPU_PM_EXIT, -1, NULL);
 }
 EXPORT_SYMBOL_GPL(cpu_pm_exit);
 
@@ -159,7 +136,6 @@ int cpu_cluster_pm_enter(void)
 	int nr_calls;
 	int ret = 0;
 
-	read_lock(&cpu_pm_notifier_lock);
 	ret = cpu_pm_notify(CPU_CLUSTER_PM_ENTER, -1, &nr_calls);
 	if (ret)
 		/*
@@ -167,7 +143,6 @@ int cpu_cluster_pm_enter(void)
 		 * PM entry who are notified earlier to prepare for it.
 		 */
 		cpu_pm_notify(CPU_CLUSTER_PM_ENTER_FAILED, nr_calls - 1, NULL);
-	read_unlock(&cpu_pm_notifier_lock);
 
 	return ret;
 }
@@ -190,13 +165,7 @@ EXPORT_SYMBOL_GPL(cpu_cluster_pm_enter);
  */
 int cpu_cluster_pm_exit(void)
 {
-	int ret;
-
-	read_lock(&cpu_pm_notifier_lock);
-	ret = cpu_pm_notify(CPU_CLUSTER_PM_EXIT, -1, NULL);
-	read_unlock(&cpu_pm_notifier_lock);
-
-	return ret;
+	return cpu_pm_notify(CPU_CLUSTER_PM_EXIT, -1, NULL);
 }
 EXPORT_SYMBOL_GPL(cpu_cluster_pm_exit);
 
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index b5b89c51f27e..bb42267257ad 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -22,6 +22,7 @@
 #include <linux/sched/deadline.h>
 #include <linux/timer.h>
 #include <linux/ww_mutex.h>
+#include <linux/blkdev.h>
 
 #include "rtmutex_common.h"
 
@@ -1998,9 +1999,19 @@ rt_mutex_fastlock(struct rt_mutex *lock, int state,
 	if (likely(rt_mutex_cmpxchg_acquire(lock, NULL, current))) {
 		rt_mutex_deadlock_account_lock(lock, current);
 		return 0;
-	} else
-		return slowfn(lock, state, NULL, RT_MUTEX_MIN_CHAINWALK,
-			      ww_ctx);
+	}
+
+	/*
+	 * If rt_mutex blocks, the function sched_submit_work will not call
+	 * blk_schedule_flush_plug (because tsk_is_pi_blocked would be true).
+	 * We must call blk_schedule_flush_plug here, if we don't call it,
+	 * a deadlock in device mapper may happen.
+	 */
+	if (unlikely(blk_needs_flush_plug(current)))
+		blk_schedule_flush_plug(current);
+
+	return slowfn(lock, state, NULL, RT_MUTEX_MIN_CHAINWALK,
+		      ww_ctx);
 }
 
 static inline int
@@ -2017,8 +2028,12 @@ rt_mutex_timed_fastlock(struct rt_mutex *lock, int state,
 	    likely(rt_mutex_cmpxchg_acquire(lock, NULL, current))) {
 		rt_mutex_deadlock_account_lock(lock, current);
 		return 0;
-	} else
-		return slowfn(lock, state, timeout, chwalk, ww_ctx);
+	}
+
+	if (unlikely(blk_needs_flush_plug(current)))
+		blk_schedule_flush_plug(current);
+
+	return slowfn(lock, state, timeout, chwalk, ww_ctx);
 }
 
 static inline int
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index ba3d60144838..120fc8932165 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1461,7 +1461,7 @@ static inline int hrtimer_rt_defer(struct hrtimer *timer) { return 0; }
 
 static enum hrtimer_restart hrtimer_wakeup(struct hrtimer *timer);
 
-static void __hrtimer_run_queues(struct hrtimer_cpu_base *cpu_base, ktime_t now)
+static int __hrtimer_run_queues(struct hrtimer_cpu_base *cpu_base, ktime_t now)
 {
 	struct hrtimer_clock_base *base = cpu_base->clock_base;
 	unsigned int active = cpu_base->active_bases;
@@ -1511,8 +1511,7 @@ static void __hrtimer_run_queues(struct hrtimer_cpu_base *cpu_base, ktime_t now)
 				raise = 1;
 		}
 	}
-	if (raise)
-		raise_softirq_irqoff(HRTIMER_SOFTIRQ);
+	return raise;
 }
 
 #ifdef CONFIG_HIGH_RES_TIMERS
@@ -1526,6 +1525,7 @@ void hrtimer_interrupt(struct clock_event_device *dev)
 	struct hrtimer_cpu_base *cpu_base = this_cpu_ptr(&hrtimer_bases);
 	ktime_t expires_next, now, entry_time, delta;
 	int retries = 0;
+	int raise;
 
 	BUG_ON(!cpu_base->hres_active);
 	cpu_base->nr_events++;
@@ -1544,7 +1544,7 @@ retry:
 	 */
 	cpu_base->expires_next.tv64 = KTIME_MAX;
 
-	__hrtimer_run_queues(cpu_base, now);
+	raise = __hrtimer_run_queues(cpu_base, now);
 
 	/* Reevaluate the clock bases for the next expiry */
 	expires_next = __hrtimer_get_next_event(cpu_base);
@@ -1555,6 +1555,8 @@ retry:
 	cpu_base->expires_next = expires_next;
 	cpu_base->in_hrtirq = 0;
 	raw_spin_unlock(&cpu_base->lock);
+	if (raise)
+		raise_softirq_irqoff(HRTIMER_SOFTIRQ);
 
 	/* Reprogramming necessary ? */
 	if (!tick_program_event(expires_next, 0)) {
@@ -1634,6 +1636,7 @@ void hrtimer_run_queues(void)
 {
 	struct hrtimer_cpu_base *cpu_base = this_cpu_ptr(&hrtimer_bases);
 	ktime_t now;
+	int raise;
 
 	if (__hrtimer_hres_active(cpu_base))
 		return;
@@ -1652,8 +1655,10 @@ void hrtimer_run_queues(void)
 
 	raw_spin_lock(&cpu_base->lock);
 	now = hrtimer_update_base(cpu_base);
-	__hrtimer_run_queues(cpu_base, now);
+	raise = __hrtimer_run_queues(cpu_base, now);
 	raw_spin_unlock(&cpu_base->lock);
+	if (raise)
+		raise_softirq_irqoff(HRTIMER_SOFTIRQ);
 }
 
 /*
@@ -1852,7 +1857,7 @@ static void init_hrtimers_cpu(int cpu)
 
 #ifdef CONFIG_HOTPLUG_CPU
 
-static void migrate_hrtimer_list(struct hrtimer_clock_base *old_base,
+static int migrate_hrtimer_list(struct hrtimer_clock_base *old_base,
 				struct hrtimer_clock_base *new_base)
 {
 	struct hrtimer *timer;
@@ -1880,12 +1885,21 @@ static void migrate_hrtimer_list(struct hrtimer_clock_base *old_base,
 		 */
 		enqueue_hrtimer(timer, new_base);
 	}
+#ifdef CONFIG_PREEMPT_RT_BASE
+	list_splice_tail(&old_base->expired, &new_base->expired);
+	/*
+	 * Tell the caller to raise HRTIMER_SOFTIRQ.  We can't safely
+	 * acquire ktimersoftd->pi_lock while the base lock is held.
+	 */
+	return !list_empty(&new_base->expired);
+#endif
+	return 0;
 }
 
 static void migrate_hrtimers(int scpu)
 {
 	struct hrtimer_cpu_base *old_base, *new_base;
-	int i;
+	int i, raise = 0;
 
 	BUG_ON(cpu_online(scpu));
 	tick_cancel_sched_timer(scpu);
@@ -1901,13 +1915,16 @@ static void migrate_hrtimers(int scpu)
 	raw_spin_lock_nested(&old_base->lock, SINGLE_DEPTH_NESTING);
 
 	for (i = 0; i < HRTIMER_MAX_CLOCK_BASES; i++) {
-		migrate_hrtimer_list(&old_base->clock_base[i],
-				     &new_base->clock_base[i]);
+		raise |= migrate_hrtimer_list(&old_base->clock_base[i],
+					      &new_base->clock_base[i]);
 	}
 
 	raw_spin_unlock(&old_base->lock);
 	raw_spin_unlock(&new_base->lock);
 
+	if (raise)
+		raise_softirq_irqoff(HRTIMER_SOFTIRQ);
+
 	/* Check, if we got expired work to do */
 	__hrtimer_peek_ahead_timers();
 	local_irq_enable();
diff --git a/localversion-rt b/localversion-rt
index 34eca4e89203..9788245dd428 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt116
+-rt117
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index c842f40c1173..035a5f6e3de9 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -213,15 +213,13 @@ void hci_send_to_sock(struct hci_dev *hdev, struct sk_buff *skb)
 }
 
 /* Send frame to sockets with specific channel */
-void hci_send_to_channel(unsigned short channel, struct sk_buff *skb,
-			 int flag, struct sock *skip_sk)
+static void __hci_send_to_channel(unsigned short channel, struct sk_buff *skb,
+				  int flag, struct sock *skip_sk)
 {
 	struct sock *sk;
 
 	BT_DBG("channel %u len %d", channel, skb->len);
 
-	read_lock(&hci_sk_list.lock);
-
 	sk_for_each(sk, &hci_sk_list.head) {
 		struct sk_buff *nskb;
 
@@ -247,6 +245,13 @@ void hci_send_to_channel(unsigned short channel, struct sk_buff *skb,
 			kfree_skb(nskb);
 	}
 
+}
+
+void hci_send_to_channel(unsigned short channel, struct sk_buff *skb,
+			 int flag, struct sock *skip_sk)
+{
+	read_lock(&hci_sk_list.lock);
+	__hci_send_to_channel(channel, skb, flag, skip_sk);
 	read_unlock(&hci_sk_list.lock);
 }
 
@@ -299,8 +304,8 @@ void hci_send_to_monitor(struct hci_dev *hdev, struct sk_buff *skb)
 	hdr->index = cpu_to_le16(hdev->id);
 	hdr->len = cpu_to_le16(skb->len);
 
-	hci_send_to_channel(HCI_CHANNEL_MONITOR, skb_copy,
-			    HCI_SOCK_TRUSTED, NULL);
+	__hci_send_to_channel(HCI_CHANNEL_MONITOR, skb_copy,
+			      HCI_SOCK_TRUSTED, NULL);
 	kfree_skb(skb_copy);
 }
 
diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index ff2593269089..2c1ce3e80ee4 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -219,7 +219,11 @@ static inline struct sock *icmp_xmit_lock(struct net *net)
 
 	local_bh_disable();
 
-	local_lock(icmp_sk_lock);
+	if (!local_trylock(icmp_sk_lock)) {
+		local_bh_enable();
+		return NULL;
+	}
+
 	sk = icmp_sk(net);
 
 	if (unlikely(!spin_trylock(&sk->sk_lock.slock))) {
