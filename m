From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [ANNOUNCE] v4.4.6-rt13
Date: Fri, 1 Apr 2016 23:33:17 +0200
Message-ID: <20160401213317.GF29603@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:55832 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754237AbcDAVdT (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 1 Apr 2016 17:33:19 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Dear RT folks!

I'm pleased to announce the v4.4.6-rt13 patch set.
Changes since v4.4.6-rt12:

- Alexandre Belloni sent patch for the AT91 to get rid of the free_irq()
  warning.

- Yang Shi sent a patch to address a "sleeping while atomic" warning in
  a writeback tracepoint. Until now it was disabled to avoid it, now it
  can be used again.

- Rik van Riel sent a patch to make the kvm async pagefault code use a
  simple wait queue.

- Mike Galbraith set a patch to address a "sleeping while atomic"
  warning in zsmalloc

- Network packets sent by a RT task could be delayed (but won't block the
  RT task) if a task with lower priority was interrupted while sending a
  packet. This is addressed by taking a qdisc lock so the high-prio task
  can boost a task with lower priority (and send the packet directy).

- Clark Williams reported a swait related complate_all() warning while
  coming out of suspend. Suspend to RAM (and hibernate) are now
  filtered out from the warning.

- Mike Galbraith sent a patch to address a "sleeping while atomic"
  warning in the zram driver.

- Josh Cartwright sent a patch to fix a lockdep splat in list_bl which
  was reported by Luis Claudio R. Goncalves.

Known issues:
  - CPU hotplug got a little better but can deadlock.

The delta patch against 4.4.6-rt12 is appended below and can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.4/incr/patch-4.4.6-rt12-rt13.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.4.6-rt13

The RT patch against 4.4.6 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.4/patch-4.4.6-rt13.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.4/patches-4.4.6-rt13.tar.xz

Sebastian

diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 47190bd399e7..807950860fb7 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -36,6 +36,7 @@
 #include <linux/kprobes.h>
 #include <linux/debugfs.h>
 #include <linux/nmi.h>
+#include <linux/swait.h>
 #include <asm/timer.h>
 #include <asm/cpu.h>
 #include <asm/traps.h>
@@ -91,14 +92,14 @@ static void kvm_io_delay(void)
 
 struct kvm_task_sleep_node {
 	struct hlist_node link;
-	wait_queue_head_t wq;
+	struct swait_queue_head wq;
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
+	DECLARE_SWAITQUEUE(wait);
 
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
+	init_swait_queue_head(&n.wq);
 	hlist_add_head(&n.link, &b->list);
-	spin_unlock(&b->lock);
+	raw_spin_unlock(&b->lock);
 
 	for (;;) {
 		if (!n.halted)
-			prepare_to_wait(&n.wq, &wait, TASK_UNINTERRUPTIBLE);
+			prepare_to_swait(&n.wq, &wait, TASK_UNINTERRUPTIBLE);
 		if (hlist_unhashed(&n.link))
 			break;
 
@@ -166,7 +167,7 @@ void kvm_async_pf_task_wait(u32 token)
 		}
 	}
 	if (!n.halted)
-		finish_wait(&n.wq, &wait);
+		finish_swait(&n.wq, &wait);
 
 	rcu_irq_exit();
 	return;
@@ -178,8 +179,8 @@ static void apf_task_wake_one(struct kvm_task_sleep_node *n)
 	hlist_del_init(&n->link);
 	if (n->halted)
 		smp_send_reschedule(n->cpu);
-	else if (waitqueue_active(&n->wq))
-		wake_up(&n->wq);
+	else if (swait_active(&n->wq))
+		swake_up(&n->wq);
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
@@ -225,17 +226,17 @@ void kvm_async_pf_task_wake(u32 token)
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
+		init_swait_queue_head(&n->wq);
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
index 370c2f76016d..65e0b375a291 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -520,6 +520,8 @@ static struct zram_meta *zram_meta_alloc(char *pool_name, u64 disksize)
 		goto out_error;
 	}
 
+	zram_meta_init_table_locks(meta, disksize);
+
 	return meta;
 
 out_error:
@@ -568,12 +570,12 @@ static int zram_decompress_page(struct zram *zram, char *mem, u32 index)
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
@@ -584,7 +586,7 @@ static int zram_decompress_page(struct zram *zram, char *mem, u32 index)
 	else
 		ret = zcomp_decompress(zram->comp, cmem, size, mem);
 	zs_unmap_object(meta->mem_pool, handle);
-	bit_spin_unlock(ZRAM_ACCESS, &meta->table[index].value);
+	zram_unlock_table(&meta->table[index]);
 
 	/* Should NEVER happen. Return bio error if it does. */
 	if (unlikely(ret)) {
@@ -604,14 +606,14 @@ static int zram_bvec_read(struct zram *zram, struct bio_vec *bvec,
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
@@ -689,10 +691,10 @@ static int zram_bvec_write(struct zram *zram, struct bio_vec *bvec, u32 index,
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
@@ -752,12 +754,12 @@ static int zram_bvec_write(struct zram *zram, struct bio_vec *bvec, u32 index,
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
@@ -800,9 +802,9 @@ static void zram_bio_discard(struct zram *zram, u32 index,
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
@@ -928,9 +930,9 @@ static void zram_slot_free_notify(struct block_device *bdev,
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
index 8e92339686d7..1e4a3c685ec7 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -72,6 +72,9 @@ enum zram_pageflags {
 struct zram_table_entry {
 	unsigned long handle;
 	unsigned long value;
+#ifdef CONFIG_PREEMPT_RT_BASE
+	spinlock_t lock;
+#endif
 };
 
 struct zram_stats {
@@ -119,4 +122,42 @@ struct zram {
 	 */
 	bool claim; /* Protected by bdev->bd_mutex */
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
+static inline void zram_meta_init_locks(struct zram_meta *meta, u64 disksize) { }
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
diff --git a/drivers/clocksource/timer-atmel-pit.c b/drivers/clocksource/timer-atmel-pit.c
index a7abdb6638cd..7a40f7e88468 100644
--- a/drivers/clocksource/timer-atmel-pit.c
+++ b/drivers/clocksource/timer-atmel-pit.c
@@ -46,6 +46,7 @@ struct pit_data {
 	u32		cycle;
 	u32		cnt;
 	unsigned int	irq;
+	bool		irq_requested;
 	struct clk	*mck;
 };
 
@@ -96,7 +97,10 @@ static int pit_clkevt_shutdown(struct clock_event_device *dev)
 
 	/* disable irq, leaving the clocksource active */
 	pit_write(data->base, AT91_PIT_MR, (data->cycle - 1) | AT91_PIT_PITEN);
-	free_irq(data->irq, data);
+	if (data->irq_requested) {
+		free_irq(data->irq, data);
+		data->irq_requested = false;
+	}
 	return 0;
 }
 
@@ -115,6 +119,8 @@ static int pit_clkevt_set_periodic(struct clock_event_device *dev)
 	if (ret)
 		panic(pr_fmt("Unable to setup IRQ\n"));
 
+	data->irq_requested = true;
+
 	/* update clocksource counter */
 	data->cnt += data->cycle * PIT_PICNT(pit_read(data->base, AT91_PIT_PIVR));
 	pit_write(data->base, AT91_PIT_MR,
diff --git a/include/linux/list_bl.h b/include/linux/list_bl.h
index 44f0b5560473..89ffaa7bd342 100644
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
diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 8b6ec7ef0854..9b77d4cc929f 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -194,6 +194,12 @@ struct platform_freeze_ops {
 	void (*end)(void);
 };
 
+#if defined(CONFIG_SUSPEND) || defined(CONFIG_HIBERNATION)
+extern bool pm_in_action;
+#else
+# define pm_in_action false
+#endif
+
 #ifdef CONFIG_SUSPEND
 /**
  * suspend_set_ops - set platform dependent suspend operations
diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
index 253ef2833c46..73614ce1d204 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -132,60 +132,30 @@ DEFINE_EVENT(writeback_dirty_inode_template, writeback_dirty_inode,
 );
 
 #ifdef CREATE_TRACE_POINTS
-#if defined(CONFIG_CGROUP_WRITEBACK) && !defined(CONFIG_PREEMPT_RT_FULL)
+#ifdef CONFIG_CGROUP_WRITEBACK
 
-static inline size_t __trace_wb_cgroup_size(struct bdi_writeback *wb)
+static inline unsigned int __trace_wb_assign_cgroup(struct bdi_writeback *wb)
 {
-	return kernfs_path_len(wb->memcg_css->cgroup->kn) + 1;
+	return wb->memcg_css->cgroup->kn->ino;
 }
 
-static inline void __trace_wb_assign_cgroup(char *buf, struct bdi_writeback *wb)
-{
-	struct cgroup *cgrp = wb->memcg_css->cgroup;
-	char *path;
-
-	path = cgroup_path(cgrp, buf, kernfs_path_len(cgrp->kn) + 1);
-	WARN_ON_ONCE(path != buf);
-}
-
-static inline size_t __trace_wbc_cgroup_size(struct writeback_control *wbc)
+static inline unsigned int __trace_wbc_assign_cgroup(struct writeback_control *wbc)
 {
 	if (wbc->wb)
-		return __trace_wb_cgroup_size(wbc->wb);
+		return __trace_wb_assign_cgroup(wbc->wb);
 	else
-		return 2;
+		return -1U;
 }
-
-static inline void __trace_wbc_assign_cgroup(char *buf,
-					     struct writeback_control *wbc)
-{
-	if (wbc->wb)
-		__trace_wb_assign_cgroup(buf, wbc->wb);
-	else
-		strcpy(buf, "/");
-}
-
 #else	/* CONFIG_CGROUP_WRITEBACK */
 
-static inline size_t __trace_wb_cgroup_size(struct bdi_writeback *wb)
+static inline unsigned int __trace_wb_assign_cgroup(struct bdi_writeback *wb)
 {
-	return 2;
+	return -1U;
 }
 
-static inline void __trace_wb_assign_cgroup(char *buf, struct bdi_writeback *wb)
+static inline unsigned int __trace_wbc_assign_cgroup(struct writeback_control *wbc)
 {
-	strcpy(buf, "/");
-}
-
-static inline size_t __trace_wbc_cgroup_size(struct writeback_control *wbc)
-{
-	return 2;
-}
-
-static inline void __trace_wbc_assign_cgroup(char *buf,
-					     struct writeback_control *wbc)
-{
-	strcpy(buf, "/");
+	return -1U;
 }
 
 #endif	/* CONFIG_CGROUP_WRITEBACK */
@@ -201,7 +171,7 @@ DECLARE_EVENT_CLASS(writeback_write_inode_template,
 		__array(char, name, 32)
 		__field(unsigned long, ino)
 		__field(int, sync_mode)
-		__dynamic_array(char, cgroup, __trace_wbc_cgroup_size(wbc))
+		__field(unsigned int, cgroup_ino)
 	),
 
 	TP_fast_assign(
@@ -209,14 +179,14 @@ DECLARE_EVENT_CLASS(writeback_write_inode_template,
 			dev_name(inode_to_bdi(inode)->dev), 32);
 		__entry->ino		= inode->i_ino;
 		__entry->sync_mode	= wbc->sync_mode;
-		__trace_wbc_assign_cgroup(__get_str(cgroup), wbc);
+		__entry->cgroup_ino	= __trace_wbc_assign_cgroup(wbc);
 	),
 
-	TP_printk("bdi %s: ino=%lu sync_mode=%d cgroup=%s",
+	TP_printk("bdi %s: ino=%lu sync_mode=%d cgroup_ino=%u",
 		__entry->name,
 		__entry->ino,
 		__entry->sync_mode,
-		__get_str(cgroup)
+		__entry->cgroup_ino
 	)
 );
 
@@ -246,7 +216,7 @@ DECLARE_EVENT_CLASS(writeback_work_class,
 		__field(int, range_cyclic)
 		__field(int, for_background)
 		__field(int, reason)
-		__dynamic_array(char, cgroup, __trace_wb_cgroup_size(wb))
+		__field(unsigned int, cgroup_ino)
 	),
 	TP_fast_assign(
 		strncpy(__entry->name,
@@ -258,10 +228,10 @@ DECLARE_EVENT_CLASS(writeback_work_class,
 		__entry->range_cyclic = work->range_cyclic;
 		__entry->for_background	= work->for_background;
 		__entry->reason = work->reason;
-		__trace_wb_assign_cgroup(__get_str(cgroup), wb);
+		__entry->cgroup_ino = __trace_wb_assign_cgroup(wb);
 	),
 	TP_printk("bdi %s: sb_dev %d:%d nr_pages=%ld sync_mode=%d "
-		  "kupdate=%d range_cyclic=%d background=%d reason=%s cgroup=%s",
+		  "kupdate=%d range_cyclic=%d background=%d reason=%s cgroup_ino=%u",
 		  __entry->name,
 		  MAJOR(__entry->sb_dev), MINOR(__entry->sb_dev),
 		  __entry->nr_pages,
@@ -270,7 +240,7 @@ DECLARE_EVENT_CLASS(writeback_work_class,
 		  __entry->range_cyclic,
 		  __entry->for_background,
 		  __print_symbolic(__entry->reason, WB_WORK_REASON),
-		  __get_str(cgroup)
+		  __entry->cgroup_ino
 	)
 );
 #define DEFINE_WRITEBACK_WORK_EVENT(name) \
@@ -300,15 +270,15 @@ DECLARE_EVENT_CLASS(writeback_class,
 	TP_ARGS(wb),
 	TP_STRUCT__entry(
 		__array(char, name, 32)
-		__dynamic_array(char, cgroup, __trace_wb_cgroup_size(wb))
+		__field(unsigned int, cgroup_ino)
 	),
 	TP_fast_assign(
 		strncpy(__entry->name, dev_name(wb->bdi->dev), 32);
-		__trace_wb_assign_cgroup(__get_str(cgroup), wb);
+		__entry->cgroup_ino = __trace_wb_assign_cgroup(wb);
 	),
-	TP_printk("bdi %s: cgroup=%s",
+	TP_printk("bdi %s: cgroup_ino=%u",
 		  __entry->name,
-		  __get_str(cgroup)
+		  __entry->cgroup_ino
 	)
 );
 #define DEFINE_WRITEBACK_EVENT(name) \
@@ -347,7 +317,7 @@ DECLARE_EVENT_CLASS(wbc_class,
 		__field(int, range_cyclic)
 		__field(long, range_start)
 		__field(long, range_end)
-		__dynamic_array(char, cgroup, __trace_wbc_cgroup_size(wbc))
+		__field(unsigned int, cgroup_ino)
 	),
 
 	TP_fast_assign(
@@ -361,12 +331,12 @@ DECLARE_EVENT_CLASS(wbc_class,
 		__entry->range_cyclic	= wbc->range_cyclic;
 		__entry->range_start	= (long)wbc->range_start;
 		__entry->range_end	= (long)wbc->range_end;
-		__trace_wbc_assign_cgroup(__get_str(cgroup), wbc);
+		__entry->cgroup_ino	= __trace_wbc_assign_cgroup(wbc);
 	),
 
 	TP_printk("bdi %s: towrt=%ld skip=%ld mode=%d kupd=%d "
 		"bgrd=%d reclm=%d cyclic=%d "
-		"start=0x%lx end=0x%lx cgroup=%s",
+		"start=0x%lx end=0x%lx cgroup_ino=%u",
 		__entry->name,
 		__entry->nr_to_write,
 		__entry->pages_skipped,
@@ -377,7 +347,7 @@ DECLARE_EVENT_CLASS(wbc_class,
 		__entry->range_cyclic,
 		__entry->range_start,
 		__entry->range_end,
-		__get_str(cgroup)
+		__entry->cgroup_ino
 	)
 )
 
@@ -398,7 +368,7 @@ TRACE_EVENT(writeback_queue_io,
 		__field(long,		age)
 		__field(int,		moved)
 		__field(int,		reason)
-		__dynamic_array(char, cgroup, __trace_wb_cgroup_size(wb))
+		__field(unsigned int,	cgroup_ino)
 	),
 	TP_fast_assign(
 		unsigned long *older_than_this = work->older_than_this;
@@ -408,15 +378,15 @@ TRACE_EVENT(writeback_queue_io,
 				  (jiffies - *older_than_this) * 1000 / HZ : -1;
 		__entry->moved	= moved;
 		__entry->reason	= work->reason;
-		__trace_wb_assign_cgroup(__get_str(cgroup), wb);
+		__entry->cgroup_ino	= __trace_wb_assign_cgroup(wb);
 	),
-	TP_printk("bdi %s: older=%lu age=%ld enqueue=%d reason=%s cgroup=%s",
+	TP_printk("bdi %s: older=%lu age=%ld enqueue=%d reason=%s cgroup_ino=%u",
 		__entry->name,
 		__entry->older,	/* older_than_this in jiffies */
 		__entry->age,	/* older_than_this in relative milliseconds */
 		__entry->moved,
 		__print_symbolic(__entry->reason, WB_WORK_REASON),
-		__get_str(cgroup)
+		__entry->cgroup_ino
 	)
 );
 
@@ -484,7 +454,7 @@ TRACE_EVENT(bdi_dirty_ratelimit,
 		__field(unsigned long,	dirty_ratelimit)
 		__field(unsigned long,	task_ratelimit)
 		__field(unsigned long,	balanced_dirty_ratelimit)
-		__dynamic_array(char, cgroup, __trace_wb_cgroup_size(wb))
+		__field(unsigned int,	cgroup_ino)
 	),
 
 	TP_fast_assign(
@@ -496,13 +466,13 @@ TRACE_EVENT(bdi_dirty_ratelimit,
 		__entry->task_ratelimit	= KBps(task_ratelimit);
 		__entry->balanced_dirty_ratelimit =
 					KBps(wb->balanced_dirty_ratelimit);
-		__trace_wb_assign_cgroup(__get_str(cgroup), wb);
+		__entry->cgroup_ino	= __trace_wb_assign_cgroup(wb);
 	),
 
 	TP_printk("bdi %s: "
 		  "write_bw=%lu awrite_bw=%lu dirty_rate=%lu "
 		  "dirty_ratelimit=%lu task_ratelimit=%lu "
-		  "balanced_dirty_ratelimit=%lu cgroup=%s",
+		  "balanced_dirty_ratelimit=%lu cgroup_ino=%u",
 		  __entry->bdi,
 		  __entry->write_bw,		/* write bandwidth */
 		  __entry->avg_write_bw,	/* avg write bandwidth */
@@ -510,7 +480,7 @@ TRACE_EVENT(bdi_dirty_ratelimit,
 		  __entry->dirty_ratelimit,	/* base ratelimit */
 		  __entry->task_ratelimit, /* ratelimit with position control */
 		  __entry->balanced_dirty_ratelimit, /* the balanced ratelimit */
-		  __get_str(cgroup)
+		  __entry->cgroup_ino
 	)
 );
 
@@ -548,7 +518,7 @@ TRACE_EVENT(balance_dirty_pages,
 		__field(	 long,	pause)
 		__field(unsigned long,	period)
 		__field(	 long,	think)
-		__dynamic_array(char, cgroup, __trace_wb_cgroup_size(wb))
+		__field(unsigned int,	cgroup_ino)
 	),
 
 	TP_fast_assign(
@@ -571,7 +541,7 @@ TRACE_EVENT(balance_dirty_pages,
 		__entry->period		= period * 1000 / HZ;
 		__entry->pause		= pause * 1000 / HZ;
 		__entry->paused		= (jiffies - start_time) * 1000 / HZ;
-		__trace_wb_assign_cgroup(__get_str(cgroup), wb);
+		__entry->cgroup_ino	= __trace_wb_assign_cgroup(wb);
 	),
 
 
@@ -580,7 +550,7 @@ TRACE_EVENT(balance_dirty_pages,
 		  "bdi_setpoint=%lu bdi_dirty=%lu "
 		  "dirty_ratelimit=%lu task_ratelimit=%lu "
 		  "dirtied=%u dirtied_pause=%u "
-		  "paused=%lu pause=%ld period=%lu think=%ld cgroup=%s",
+		  "paused=%lu pause=%ld period=%lu think=%ld cgroup_ino=%u",
 		  __entry->bdi,
 		  __entry->limit,
 		  __entry->setpoint,
@@ -595,7 +565,7 @@ TRACE_EVENT(balance_dirty_pages,
 		  __entry->pause,	/* ms */
 		  __entry->period,	/* ms */
 		  __entry->think,	/* ms */
-		  __get_str(cgroup)
+		  __entry->cgroup_ino
 	  )
 );
 
@@ -609,8 +579,7 @@ TRACE_EVENT(writeback_sb_inodes_requeue,
 		__field(unsigned long, ino)
 		__field(unsigned long, state)
 		__field(unsigned long, dirtied_when)
-		__dynamic_array(char, cgroup,
-				__trace_wb_cgroup_size(inode_to_wb(inode)))
+		__field(unsigned int, cgroup_ino)
 	),
 
 	TP_fast_assign(
@@ -619,16 +588,16 @@ TRACE_EVENT(writeback_sb_inodes_requeue,
 		__entry->ino		= inode->i_ino;
 		__entry->state		= inode->i_state;
 		__entry->dirtied_when	= inode->dirtied_when;
-		__trace_wb_assign_cgroup(__get_str(cgroup), inode_to_wb(inode));
+		__entry->cgroup_ino	= __trace_wb_assign_cgroup(inode_to_wb(inode));
 	),
 
-	TP_printk("bdi %s: ino=%lu state=%s dirtied_when=%lu age=%lu cgroup=%s",
+	TP_printk("bdi %s: ino=%lu state=%s dirtied_when=%lu age=%lu cgroup_ino=%u",
 		  __entry->name,
 		  __entry->ino,
 		  show_inode_state(__entry->state),
 		  __entry->dirtied_when,
 		  (jiffies - __entry->dirtied_when) / HZ,
-		  __get_str(cgroup)
+		  __entry->cgroup_ino
 	)
 );
 
@@ -684,7 +653,7 @@ DECLARE_EVENT_CLASS(writeback_single_inode_template,
 		__field(unsigned long, writeback_index)
 		__field(long, nr_to_write)
 		__field(unsigned long, wrote)
-		__dynamic_array(char, cgroup, __trace_wbc_cgroup_size(wbc))
+		__field(unsigned int, cgroup_ino)
 	),
 
 	TP_fast_assign(
@@ -696,11 +665,11 @@ DECLARE_EVENT_CLASS(writeback_single_inode_template,
 		__entry->writeback_index = inode->i_mapping->writeback_index;
 		__entry->nr_to_write	= nr_to_write;
 		__entry->wrote		= nr_to_write - wbc->nr_to_write;
-		__trace_wbc_assign_cgroup(__get_str(cgroup), wbc);
+		__entry->cgroup_ino	= __trace_wbc_assign_cgroup(wbc);
 	),
 
 	TP_printk("bdi %s: ino=%lu state=%s dirtied_when=%lu age=%lu "
-		  "index=%lu to_write=%ld wrote=%lu cgroup=%s",
+		  "index=%lu to_write=%ld wrote=%lu cgroup_ino=%u",
 		  __entry->name,
 		  __entry->ino,
 		  show_inode_state(__entry->state),
@@ -709,7 +678,7 @@ DECLARE_EVENT_CLASS(writeback_single_inode_template,
 		  __entry->writeback_index,
 		  __entry->nr_to_write,
 		  __entry->wrote,
-		  __get_str(cgroup)
+		  __entry->cgroup_ino
 	)
 );
 
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index bfd9e0982f15..fbb23f93e8d6 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -648,6 +648,10 @@ static void power_down(void)
 		cpu_relax();
 }
 
+#ifndef CONFIG_SUSPEND
+bool pm_in_action;
+#endif
+
 /**
  * hibernate - Carry out system hibernation, including saving the image.
  */
@@ -660,6 +664,8 @@ int hibernate(void)
 		return -EPERM;
 	}
 
+	pm_in_action = true;
+
 	lock_system_sleep();
 	/* The snapshot device should not be opened while we're running */
 	if (!atomic_add_unless(&snapshot_device_available, -1, 0)) {
@@ -725,6 +731,7 @@ int hibernate(void)
 	atomic_inc(&snapshot_device_available);
  Unlock:
 	unlock_system_sleep();
+	pm_in_action = false;
 	return error;
 }
 
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 80ebc0726290..393bc342c586 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -522,6 +522,8 @@ static int enter_state(suspend_state_t state)
 	return error;
 }
 
+bool pm_in_action;
+
 /**
  * pm_suspend - Externally visible function for suspending the system.
  * @state: System sleep state to enter.
@@ -536,6 +538,8 @@ int pm_suspend(suspend_state_t state)
 	if (state <= PM_SUSPEND_ON || state >= PM_SUSPEND_MAX)
 		return -EINVAL;
 
+	pm_in_action = true;
+
 	error = enter_state(state);
 	if (error) {
 		suspend_stats.fail++;
@@ -543,6 +547,7 @@ int pm_suspend(suspend_state_t state)
 	} else {
 		suspend_stats.success++;
 	}
+	pm_in_action = false;
 	return error;
 }
 EXPORT_SYMBOL(pm_suspend);
diff --git a/kernel/sched/swait.c b/kernel/sched/swait.c
index 8459561f0379..205fe36868f9 100644
--- a/kernel/sched/swait.c
+++ b/kernel/sched/swait.c
@@ -1,5 +1,6 @@
 #include <linux/sched.h>
 #include <linux/swait.h>
+#include <linux/suspend.h>
 
 void __init_swait_queue_head(struct swait_queue_head *q, const char *name,
 			     struct lock_class_key *key)
@@ -42,7 +43,9 @@ void swake_up_all_locked(struct swait_queue_head *q)
 		list_del_init(&curr->task_list);
 		wakes++;
 	}
-	WARN_ON(wakes > 2);
+	if (pm_in_action)
+		return;
+	WARN(wakes > 2, "complate_all() with %d waiters\n", wakes);
 }
 EXPORT_SYMBOL(swake_up_all_locked);
 
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index fc083996e40a..18cc59fb1bc6 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1289,7 +1289,7 @@ void *zs_map_object(struct zs_pool *pool, unsigned long handle,
 	class = pool->size_class[class_idx];
 	off = obj_idx_to_offset(page, obj_idx, class->size);
 
-	area = &get_cpu_var(zs_map_area);
+	area = per_cpu_ptr(&zs_map_area, get_cpu_light());
 	area->vm_mm = mm;
 	if (off + class->size <= PAGE_SIZE) {
 		/* this object is contained entirely within a page */
@@ -1342,7 +1342,7 @@ void zs_unmap_object(struct zs_pool *pool, unsigned long handle)
 
 		__zs_unmap_object(area, pages, off, class->size);
 	}
-	put_cpu_var(zs_map_area);
+	put_cpu_light();
 	unpin_tag(handle);
 }
 EXPORT_SYMBOL_GPL(zs_unmap_object);
diff --git a/net/core/dev.c b/net/core/dev.c
index cc364be3587b..0e17592adbff 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2891,7 +2891,11 @@ static inline int __dev_xmit_skb(struct sk_buff *skb, struct Qdisc *q,
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
 
