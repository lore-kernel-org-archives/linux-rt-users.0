From: Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] 3.18.36-rt38
Date: Thu, 14 Jul 2016 10:57:47 -0400
Message-ID: <20160714105747.00cb1494@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0221.hostedemail.com ([216.40.44.221]:39931 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751176AbcGNO5y (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 14 Jul 2016 10:57:54 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Dear RT Folks,

I'm pleased to announce the 3.18.36-rt38 stable release.


You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v3.18-rt
  Head SHA1: cf3a38958bb4b88e877e89b7e323d1f26cd35b46


Or to build 3.18.36-rt38 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.18.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.18.36.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.18/patch-3.18.36-rt38.patch.xz



You can also build from 3.18.36-rt37 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.18/incr/patch-3.18.36-rt37-rt38.patch.xz



Enjoy,

-- Steve


Changes from v3.18.36-rt37:

---

Josh Cartwright (1):
      list_bl: fixup bogus lockdep warning

Luiz Capitulino (1):
      mm: perform lru_add_drain_all() remotely

Mike Galbraith (2):
      mm/zsmalloc: Use get/put_cpu_light in zs_map_object()/zs_unmap_object()
      drivers/block/zram: Replace bit spinlocks with rtmutex for -rt

Peter Zijlstra (1):
      sched,preempt: Fix preempt_count manipulations

Rik van Riel (1):
      kvm, rt: change async pagefault code locking for PREEMPT_RT

Sebastian Andrzej Siewior (6):
      net: dev: always take qdisc's busylock in __dev_xmit_skb()
      drivers/block/zram: fixup compile for !RT
      kernel/printk: Don't try to print from IRQ/NMI region
      arm: lazy preempt: correct resched condition
      locallock: add local_lock_on()
      trace: correct off by one while recording the trace-event

Steven Rostedt (Red Hat) (1):
      Linux 3.18.36-rt38

Thomas Gleixner (1):
      perf/x86/intel/rapl: Make PMU lock raw

----
 arch/arm/kernel/entry-armv.S                |  6 ++++-
 arch/x86/kernel/cpu/perf_event_intel_rapl.c | 20 +++++++-------
 arch/x86/kernel/kvm.c                       | 37 +++++++++++++-------------
 drivers/block/zram/zram_drv.c               | 30 +++++++++++----------
 drivers/block/zram/zram_drv.h               | 41 +++++++++++++++++++++++++++++
 include/asm-generic/preempt.h               |  4 +--
 include/linux/list_bl.h                     | 12 +++++----
 include/linux/locallock.h                   |  6 +++++
 kernel/printk/printk.c                      | 10 +++++++
 kernel/trace/trace_events.c                 |  8 ++++++
 localversion-rt                             |  2 +-
 mm/swap.c                                   | 37 +++++++++++++++++++++-----
 mm/zsmalloc.c                               |  4 +--
 net/core/dev.c                              |  4 +++
 14 files changed, 161 insertions(+), 60 deletions(-)
---------------------------
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 61af605ae614..1c4842879e17 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -236,7 +236,11 @@ svc_preempt:
 	bne	1b
 	tst	r0, #_TIF_NEED_RESCHED_LAZY
 	reteq	r8				@ go again
-	b	1b
+	ldr	r0, [tsk, #TI_PREEMPT_LAZY]	@ get preempt lazy count
+	teq	r0, #0				@ if preempt lazy count != 0
+	beq	1b
+	ret	r8				@ go again
+
 #endif
 
 __und_fault:
diff --git a/arch/x86/kernel/cpu/perf_event_intel_rapl.c b/arch/x86/kernel/cpu/perf_event_intel_rapl.c
index 611d821eac1a..f35cf3f095fe 100644
--- a/arch/x86/kernel/cpu/perf_event_intel_rapl.c
+++ b/arch/x86/kernel/cpu/perf_event_intel_rapl.c
@@ -104,7 +104,7 @@ static struct kobj_attribute format_attr_##_var =		\
 #define RAPL_CNTR_WIDTH 32 /* 32-bit rapl counters */
 
 struct rapl_pmu {
-	spinlock_t	 lock;
+	raw_spinlock_t	 lock;
 	int		 hw_unit;  /* 1/2^hw_unit Joule */
 	int		 n_active; /* number of active events */
 	struct list_head active_list;
@@ -194,13 +194,13 @@ static enum hrtimer_restart rapl_hrtimer_handle(struct hrtimer *hrtimer)
 	if (!pmu->n_active)
 		return HRTIMER_NORESTART;
 
-	spin_lock_irqsave(&pmu->lock, flags);
+	raw_spin_lock_irqsave(&pmu->lock, flags);
 
 	list_for_each_entry(event, &pmu->active_list, active_entry) {
 		rapl_event_update(event);
 	}
 
-	spin_unlock_irqrestore(&pmu->lock, flags);
+	raw_spin_unlock_irqrestore(&pmu->lock, flags);
 
 	hrtimer_forward_now(hrtimer, pmu->timer_interval);
 
@@ -237,9 +237,9 @@ static void rapl_pmu_event_start(struct perf_event *event, int mode)
 	struct rapl_pmu *pmu = __this_cpu_read(rapl_pmu);
 	unsigned long flags;
 
-	spin_lock_irqsave(&pmu->lock, flags);
+	raw_spin_lock_irqsave(&pmu->lock, flags);
 	__rapl_pmu_event_start(pmu, event);
-	spin_unlock_irqrestore(&pmu->lock, flags);
+	raw_spin_unlock_irqrestore(&pmu->lock, flags);
 }
 
 static void rapl_pmu_event_stop(struct perf_event *event, int mode)
@@ -248,7 +248,7 @@ static void rapl_pmu_event_stop(struct perf_event *event, int mode)
 	struct hw_perf_event *hwc = &event->hw;
 	unsigned long flags;
 
-	spin_lock_irqsave(&pmu->lock, flags);
+	raw_spin_lock_irqsave(&pmu->lock, flags);
 
 	/* mark event as deactivated and stopped */
 	if (!(hwc->state & PERF_HES_STOPPED)) {
@@ -273,7 +273,7 @@ static void rapl_pmu_event_stop(struct perf_event *event, int mode)
 		hwc->state |= PERF_HES_UPTODATE;
 	}
 
-	spin_unlock_irqrestore(&pmu->lock, flags);
+	raw_spin_unlock_irqrestore(&pmu->lock, flags);
 }
 
 static int rapl_pmu_event_add(struct perf_event *event, int mode)
@@ -282,14 +282,14 @@ static int rapl_pmu_event_add(struct perf_event *event, int mode)
 	struct hw_perf_event *hwc = &event->hw;
 	unsigned long flags;
 
-	spin_lock_irqsave(&pmu->lock, flags);
+	raw_spin_lock_irqsave(&pmu->lock, flags);
 
 	hwc->state = PERF_HES_UPTODATE | PERF_HES_STOPPED;
 
 	if (mode & PERF_EF_START)
 		__rapl_pmu_event_start(pmu, event);
 
-	spin_unlock_irqrestore(&pmu->lock, flags);
+	raw_spin_unlock_irqrestore(&pmu->lock, flags);
 
 	return 0;
 }
@@ -551,7 +551,7 @@ static int rapl_cpu_prepare(int cpu)
 	if (!pmu)
 		return -1;
 
-	spin_lock_init(&pmu->lock);
+	raw_spin_lock_init(&pmu->lock);
 
 	INIT_LIST_HEAD(&pmu->active_list);
 
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 94f643484300..9c542227d791 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -36,6 +36,7 @@
 #include <linux/kprobes.h>
 #include <linux/debugfs.h>
 #include <linux/nmi.h>
+#include <linux/wait-simple.h>
 #include <asm/timer.h>
 #include <asm/cpu.h>
 #include <asm/traps.h>
@@ -91,14 +92,14 @@ static void kvm_io_delay(void)
 
 struct kvm_task_sleep_node {
 	struct hlist_node link;
-	wait_queue_head_t wq;
+	struct swait_head wq;
 	u32 token;
 	int cpu;
 	bool halted;
 };
 
 static struct kvm_task_sleep_head {
-	spinlock_t lock;
+	raw_spinlock_t lock;
 	struct hlist_head list;
 } async_pf_sleepers[KVM_TASK_SLEEP_HASHSIZE];
 
@@ -122,17 +123,17 @@ void kvm_async_pf_task_wait(u32 token)
 	u32 key = hash_32(token, KVM_TASK_SLEEP_HASHBITS);
 	struct kvm_task_sleep_head *b = &async_pf_sleepers[key];
 	struct kvm_task_sleep_node n, *e;
-	DEFINE_WAIT(wait);
+	DEFINE_SWAITER(wait);
 
 	rcu_irq_enter();
 
-	spin_lock(&b->lock);
+	raw_spin_lock(&b->lock);
 	e = _find_apf_task(b, token);
 	if (e) {
 		/* dummy entry exist -> wake up was delivered ahead of PF */
 		hlist_del(&e->link);
 		kfree(e);
-		spin_unlock(&b->lock);
+		raw_spin_unlock(&b->lock);
 
 		rcu_irq_exit();
 		return;
@@ -141,13 +142,13 @@ void kvm_async_pf_task_wait(u32 token)
 	n.token = token;
 	n.cpu = smp_processor_id();
 	n.halted = is_idle_task(current) || preempt_count() > 1;
-	init_waitqueue_head(&n.wq);
+	init_swait_head(&n.wq);
 	hlist_add_head(&n.link, &b->list);
-	spin_unlock(&b->lock);
+	raw_spin_unlock(&b->lock);
 
 	for (;;) {
 		if (!n.halted)
-			prepare_to_wait(&n.wq, &wait, TASK_UNINTERRUPTIBLE);
+			swait_prepare(&n.wq, &wait, TASK_UNINTERRUPTIBLE);
 		if (hlist_unhashed(&n.link))
 			break;
 
@@ -166,7 +167,7 @@ void kvm_async_pf_task_wait(u32 token)
 		}
 	}
 	if (!n.halted)
-		finish_wait(&n.wq, &wait);
+		swait_finish(&n.wq, &wait);
 
 	rcu_irq_exit();
 	return;
@@ -178,8 +179,8 @@ static void apf_task_wake_one(struct kvm_task_sleep_node *n)
 	hlist_del_init(&n->link);
 	if (n->halted)
 		smp_send_reschedule(n->cpu);
-	else if (waitqueue_active(&n->wq))
-		wake_up(&n->wq);
+	else if (swaitqueue_active(&n->wq))
+		swait_wake(&n->wq);
 }
 
 static void apf_task_wake_all(void)
@@ -189,14 +190,14 @@ static void apf_task_wake_all(void)
 	for (i = 0; i < KVM_TASK_SLEEP_HASHSIZE; i++) {
 		struct hlist_node *p, *next;
 		struct kvm_task_sleep_head *b = &async_pf_sleepers[i];
-		spin_lock(&b->lock);
+		raw_spin_lock(&b->lock);
 		hlist_for_each_safe(p, next, &b->list) {
 			struct kvm_task_sleep_node *n =
 				hlist_entry(p, typeof(*n), link);
 			if (n->cpu == smp_processor_id())
 				apf_task_wake_one(n);
 		}
-		spin_unlock(&b->lock);
+		raw_spin_unlock(&b->lock);
 	}
 }
 
@@ -212,7 +213,7 @@ void kvm_async_pf_task_wake(u32 token)
 	}
 
 again:
-	spin_lock(&b->lock);
+	raw_spin_lock(&b->lock);
 	n = _find_apf_task(b, token);
 	if (!n) {
 		/*
@@ -225,17 +226,17 @@ again:
 			 * Allocation failed! Busy wait while other cpu
 			 * handles async PF.
 			 */
-			spin_unlock(&b->lock);
+			raw_spin_unlock(&b->lock);
 			cpu_relax();
 			goto again;
 		}
 		n->token = token;
 		n->cpu = smp_processor_id();
-		init_waitqueue_head(&n->wq);
+		init_swait_head(&n->wq);
 		hlist_add_head(&n->link, &b->list);
 	} else
 		apf_task_wake_one(n);
-	spin_unlock(&b->lock);
+	raw_spin_unlock(&b->lock);
 	return;
 }
 EXPORT_SYMBOL_GPL(kvm_async_pf_task_wake);
@@ -486,7 +487,7 @@ void __init kvm_guest_init(void)
 	paravirt_ops_setup();
 	register_reboot_notifier(&kvm_pv_reboot_nb);
 	for (i = 0; i < KVM_TASK_SLEEP_HASHSIZE; i++)
-		spin_lock_init(&async_pf_sleepers[i].lock);
+		raw_spin_lock_init(&async_pf_sleepers[i].lock);
 	if (kvm_para_has_feature(KVM_FEATURE_ASYNC_PF))
 		x86_init.irqs.trap_init = kvm_apf_trap_init;
 
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 3920ee45aa59..548b5bb5eeb6 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -336,6 +336,8 @@ static struct zram_meta *zram_meta_alloc(u64 disksize)
 		goto free_table;
 	}
 
+	zram_meta_init_table_locks(meta, disksize);
+
 	return meta;
 
 free_table:
@@ -425,12 +427,12 @@ static int zram_decompress_page(struct zram *zram, char *mem, u32 index)
 	unsigned long handle;
 	size_t size;
 
-	bit_spin_lock(ZRAM_ACCESS, &meta->table[index].value);
+	zram_lock_table(&meta->table[index]);
 	handle = meta->table[index].handle;
 	size = zram_get_obj_size(meta, index);
 
 	if (!handle || zram_test_flag(meta, index, ZRAM_ZERO)) {
-		bit_spin_unlock(ZRAM_ACCESS, &meta->table[index].value);
+		zram_unlock_table(&meta->table[index]);
 		clear_page(mem);
 		return 0;
 	}
@@ -441,7 +443,7 @@ static int zram_decompress_page(struct zram *zram, char *mem, u32 index)
 	else
 		ret = zcomp_decompress(zram->comp, cmem, size, mem);
 	zs_unmap_object(meta->mem_pool, handle);
-	bit_spin_unlock(ZRAM_ACCESS, &meta->table[index].value);
+	zram_unlock_table(&meta->table[index]);
 
 	/* Should NEVER happen. Return bio error if it does. */
 	if (unlikely(ret)) {
@@ -461,14 +463,14 @@ static int zram_bvec_read(struct zram *zram, struct bio_vec *bvec,
 	struct zram_meta *meta = zram->meta;
 	page = bvec->bv_page;
 
-	bit_spin_lock(ZRAM_ACCESS, &meta->table[index].value);
+	zram_lock_table(&meta->table[index]);
 	if (unlikely(!meta->table[index].handle) ||
 			zram_test_flag(meta, index, ZRAM_ZERO)) {
-		bit_spin_unlock(ZRAM_ACCESS, &meta->table[index].value);
+		zram_unlock_table(&meta->table[index]);
 		handle_zero_page(bvec);
 		return 0;
 	}
-	bit_spin_unlock(ZRAM_ACCESS, &meta->table[index].value);
+	zram_unlock_table(&meta->table[index]);
 
 	if (is_partial_io(bvec))
 		/* Use  a temporary buffer to decompress the page */
@@ -563,10 +565,10 @@ static int zram_bvec_write(struct zram *zram, struct bio_vec *bvec, u32 index,
 		if (user_mem)
 			kunmap_atomic(user_mem);
 		/* Free memory associated with this sector now. */
-		bit_spin_lock(ZRAM_ACCESS, &meta->table[index].value);
+		zram_lock_table(&meta->table[index]);
 		zram_free_page(zram, index);
 		zram_set_flag(meta, index, ZRAM_ZERO);
-		bit_spin_unlock(ZRAM_ACCESS, &meta->table[index].value);
+		zram_unlock_table(&meta->table[index]);
 
 		atomic64_inc(&zram->stats.zero_pages);
 		ret = 0;
@@ -626,12 +628,12 @@ static int zram_bvec_write(struct zram *zram, struct bio_vec *bvec, u32 index,
 	 * Free memory associated with this sector
 	 * before overwriting unused sectors.
 	 */
-	bit_spin_lock(ZRAM_ACCESS, &meta->table[index].value);
+	zram_lock_table(&meta->table[index]);
 	zram_free_page(zram, index);
 
 	meta->table[index].handle = handle;
 	zram_set_obj_size(meta, index, clen);
-	bit_spin_unlock(ZRAM_ACCESS, &meta->table[index].value);
+	zram_unlock_table(&meta->table[index]);
 
 	/* Update stats */
 	atomic64_add(clen, &zram->stats.compr_data_size);
@@ -698,9 +700,9 @@ static void zram_bio_discard(struct zram *zram, u32 index,
 	}
 
 	while (n >= PAGE_SIZE) {
-		bit_spin_lock(ZRAM_ACCESS, &meta->table[index].value);
+		zram_lock_table(&meta->table[index]);
 		zram_free_page(zram, index);
-		bit_spin_unlock(ZRAM_ACCESS, &meta->table[index].value);
+		zram_unlock_table(&meta->table[index]);
 		atomic64_inc(&zram->stats.notify_free);
 		index++;
 		n -= PAGE_SIZE;
@@ -939,9 +941,9 @@ static void zram_slot_free_notify(struct block_device *bdev,
 	zram = bdev->bd_disk->private_data;
 	meta = zram->meta;
 
-	bit_spin_lock(ZRAM_ACCESS, &meta->table[index].value);
+	zram_lock_table(&meta->table[index]);
 	zram_free_page(zram, index);
-	bit_spin_unlock(ZRAM_ACCESS, &meta->table[index].value);
+	zram_unlock_table(&meta->table[index]);
 	atomic64_inc(&zram->stats.notify_free);
 }
 
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index c6ee271317f5..73e7e70d9a8d 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -78,6 +78,9 @@ enum zram_pageflags {
 struct zram_table_entry {
 	unsigned long handle;
 	unsigned long value;
+#ifdef CONFIG_PREEMPT_RT_BASE
+	spinlock_t lock;
+#endif
 };
 
 struct zram_stats {
@@ -120,4 +123,42 @@ struct zram {
 
 	char compressor[10];
 };
+
+#ifndef CONFIG_PREEMPT_RT_BASE
+static inline void zram_lock_table(struct zram_table_entry *table)
+{
+	bit_spin_lock(ZRAM_ACCESS, &table->value);
+}
+
+static inline void zram_unlock_table(struct zram_table_entry *table)
+{
+	bit_spin_unlock(ZRAM_ACCESS, &table->value);
+}
+
+static inline void zram_meta_init_table_locks(struct zram_meta *meta, u64 disksize) { }
+#else /* CONFIG_PREEMPT_RT_BASE */
+static inline void zram_lock_table(struct zram_table_entry *table)
+{
+	spin_lock(&table->lock);
+	__set_bit(ZRAM_ACCESS, &table->value);
+}
+
+static inline void zram_unlock_table(struct zram_table_entry *table)
+{
+	__clear_bit(ZRAM_ACCESS, &table->value);
+	spin_unlock(&table->lock);
+}
+
+static inline void zram_meta_init_table_locks(struct zram_meta *meta, u64 disksize)
+{
+        size_t num_pages = disksize >> PAGE_SHIFT;
+        size_t index;
+
+        for (index = 0; index < num_pages; index++) {
+		spinlock_t *lock = &meta->table[index].lock;
+		spin_lock_init(lock);
+        }
+}
+#endif /* CONFIG_PREEMPT_RT_BASE */
+
 #endif
diff --git a/include/asm-generic/preempt.h b/include/asm-generic/preempt.h
index 1cd3f5d767a8..ed1881dd9b36 100644
--- a/include/asm-generic/preempt.h
+++ b/include/asm-generic/preempt.h
@@ -7,10 +7,10 @@
 
 static __always_inline int preempt_count(void)
 {
-	return current_thread_info()->preempt_count;
+	return READ_ONCE(current_thread_info()->preempt_count);
 }
 
-static __always_inline int *preempt_count_ptr(void)
+static __always_inline volatile int *preempt_count_ptr(void)
 {
 	return &current_thread_info()->preempt_count;
 }
diff --git a/include/linux/list_bl.h b/include/linux/list_bl.h
index d8876a0cf036..017d0f1c1eb4 100644
--- a/include/linux/list_bl.h
+++ b/include/linux/list_bl.h
@@ -42,13 +42,15 @@ struct hlist_bl_node {
 	struct hlist_bl_node *next, **pprev;
 };
 
-static inline void INIT_HLIST_BL_HEAD(struct hlist_bl_head *h)
-{
-	h->first = NULL;
 #ifdef CONFIG_PREEMPT_RT_BASE
-	raw_spin_lock_init(&h->lock);
+#define INIT_HLIST_BL_HEAD(h)		\
+do {					\
+	(h)->first = NULL;		\
+	raw_spin_lock_init(&(h)->lock);	\
+} while (0)
+#else
+#define INIT_HLIST_BL_HEAD(h) (h)->first = NULL
 #endif
-}
 
 static inline void INIT_HLIST_BL_NODE(struct hlist_bl_node *h)
 {
diff --git a/include/linux/locallock.h b/include/linux/locallock.h
index 21653e9bfa20..015271ff8ec8 100644
--- a/include/linux/locallock.h
+++ b/include/linux/locallock.h
@@ -66,6 +66,9 @@ static inline void __local_lock(struct local_irq_lock *lv)
 #define local_lock(lvar)					\
 	do { __local_lock(&get_local_var(lvar)); } while (0)
 
+#define local_lock_on(lvar, cpu)				\
+	do { __local_lock(&per_cpu(lvar, cpu)); } while (0)
+
 static inline int __local_trylock(struct local_irq_lock *lv)
 {
 	if (lv->owner != current && spin_trylock_local(&lv->lock)) {
@@ -104,6 +107,9 @@ static inline void __local_unlock(struct local_irq_lock *lv)
 		put_local_var(lvar);				\
 	} while (0)
 
+#define local_unlock_on(lvar, cpu)                       \
+	do { __local_unlock(&per_cpu(lvar, cpu)); } while (0)
+
 static inline void __local_lock_irq(struct local_irq_lock *lv)
 {
 	spin_lock_irqsave(&lv->lock, lv->flags);
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index df1198461db3..2799395a8f0a 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1429,6 +1429,11 @@ static void call_console_drivers(int level, const char *text, size_t len)
 	if (!console_drivers)
 		return;
 
+	if (IS_ENABLED(CONFIG_PREEMPT_RT_BASE)) {
+		if (in_irq() || in_nmi())
+			return;
+	}
+
 	migrate_disable();
 	for_each_console(con) {
 		if (exclusive_console && con != exclusive_console)
@@ -2382,6 +2387,11 @@ void console_unblank(void)
 {
 	struct console *c;
 
+	if (IS_ENABLED(CONFIG_PREEMPT_RT_BASE)) {
+		if (in_irq() || in_nmi())
+			return;
+	}
+
 	/*
 	 * console_unblank can no longer be called in interrupt context unless
 	 * oops_in_progress is set to 1..
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index b6dd7f3bfc03..7bf7478c3e38 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -200,6 +200,14 @@ void *ftrace_event_buffer_reserve(struct ftrace_event_buffer *fbuffer,
 
 	local_save_flags(fbuffer->flags);
 	fbuffer->pc = preempt_count();
+	/*
+	 * If CONFIG_PREEMPT is enabled, then the tracepoint itself disables
+	 * preemption (adding one to the preempt_count). Since we are
+	 * interested in the preempt_count at the time the tracepoint was
+	 * hit, we need to subtract one to offset the increment.
+	 */
+	if (IS_ENABLED(CONFIG_PREEMPT))
+		fbuffer->pc--;
 	fbuffer->ftrace_file = ftrace_file;
 
 	fbuffer->event =
diff --git a/localversion-rt b/localversion-rt
index a3b2408c1da6..49bae8d6aa67 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt37
+-rt38
diff --git a/mm/swap.c b/mm/swap.c
index acb833351464..745dd2a52288 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -811,9 +811,15 @@ void lru_add_drain_cpu(int cpu)
 		unsigned long flags;
 
 		/* No harm done if a racing interrupt already did this */
+#ifdef CONFIG_PREEMPT_RT_BASE
+		local_lock_irqsave_on(rotate_lock, flags, cpu);
+		pagevec_move_tail(pvec);
+		local_unlock_irqrestore_on(rotate_lock, flags, cpu);
+#else
 		local_lock_irqsave(rotate_lock, flags);
 		pagevec_move_tail(pvec);
 		local_unlock_irqrestore(rotate_lock, flags);
+#endif
 	}
 
 	pvec = &per_cpu(lru_deactivate_pvecs, cpu);
@@ -856,12 +862,32 @@ void lru_add_drain(void)
 	local_unlock_cpu(swapvec_lock);
 }
 
+
+#ifdef CONFIG_PREEMPT_RT_BASE
+static inline void remote_lru_add_drain(int cpu, struct cpumask *has_work)
+{
+	local_lock_on(swapvec_lock, cpu);
+	lru_add_drain_cpu(cpu);
+	local_unlock_on(swapvec_lock, cpu);
+}
+
+#else
+
 static void lru_add_drain_per_cpu(struct work_struct *dummy)
 {
 	lru_add_drain();
 }
 
 static DEFINE_PER_CPU(struct work_struct, lru_add_drain_work);
+static inline void remote_lru_add_drain(int cpu, struct cpumask *has_work)
+{
+	struct work_struct *work = &per_cpu(lru_add_drain_work, cpu);
+
+	INIT_WORK(work, lru_add_drain_per_cpu);
+	schedule_work_on(cpu, work);
+	cpumask_set_cpu(cpu, has_work);
+}
+#endif
 
 void lru_add_drain_all(void)
 {
@@ -874,20 +900,17 @@ void lru_add_drain_all(void)
 	cpumask_clear(&has_work);
 
 	for_each_online_cpu(cpu) {
-		struct work_struct *work = &per_cpu(lru_add_drain_work, cpu);
-
 		if (pagevec_count(&per_cpu(lru_add_pvec, cpu)) ||
 		    pagevec_count(&per_cpu(lru_rotate_pvecs, cpu)) ||
 		    pagevec_count(&per_cpu(lru_deactivate_pvecs, cpu)) ||
-		    need_activate_page_drain(cpu)) {
-			INIT_WORK(work, lru_add_drain_per_cpu);
-			schedule_work_on(cpu, work);
-			cpumask_set_cpu(cpu, &has_work);
-		}
+		    need_activate_page_drain(cpu))
+			remote_lru_add_drain(cpu, &has_work);
 	}
 
+#ifndef CONFIG_PREEMPT_RT_BASE
 	for_each_cpu(cpu, &has_work)
 		flush_work(&per_cpu(lru_add_drain_work, cpu));
+#endif
 
 	put_online_cpus();
 	mutex_unlock(&lock);
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 839a48c3ca27..1db2077e38f7 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1127,7 +1127,7 @@ void *zs_map_object(struct zs_pool *pool, unsigned long handle,
 	class = &pool->size_class[class_idx];
 	off = obj_idx_to_offset(page, obj_idx, class->size);
 
-	area = &get_cpu_var(zs_map_area);
+	area = per_cpu_ptr(&zs_map_area, get_cpu_light());
 	area->vm_mm = mm;
 	if (off + class->size <= PAGE_SIZE) {
 		/* this object is contained entirely within a page */
@@ -1173,7 +1173,7 @@ void zs_unmap_object(struct zs_pool *pool, unsigned long handle)
 
 		__zs_unmap_object(area, pages, off, class->size);
 	}
-	put_cpu_var(zs_map_area);
+	put_cpu_light();
 }
 EXPORT_SYMBOL_GPL(zs_unmap_object);
 
diff --git a/net/core/dev.c b/net/core/dev.c
index da674bb38606..438c5afa5b01 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2801,7 +2801,11 @@ static inline int __dev_xmit_skb(struct sk_buff *skb, struct Qdisc *q,
 	 * This permits __QDISC___STATE_RUNNING owner to get the lock more
 	 * often and dequeue packets faster.
 	 */
+#ifdef CONFIG_PREEMPT_RT_FULL
+	contended = true;
+#else
 	contended = qdisc_is_running(q);
+#endif
 	if (unlikely(contended))
 		spin_lock(&q->busylock);
 
