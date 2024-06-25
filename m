Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE43A14900E;
	Tue, 25 Jun 2024 09:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719306460; cv=none; b=oomT3r5zlQwTB6lQtyH+kLuuVDWozq58L6A9bgXtFy/5+hxm4t0kfIbM7xSFfRNgD1c4UCmsVjmim+KnOoJPHbjiJbrqoYZ9MMfgsgwlCduryfByd+tIYyozsEaMPdCvjZpyqUWAk3iK5S8Xd/NCoNQy0RpwJAOmhU9Rzr3Fm+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719306460; c=relaxed/simple;
	bh=YhhDXEPtSNtSdmHsdz9zZrbrftObBq7CfFpV8swbDMI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iSkswM/q1YgpGZ1IUsOFJv6FszS8a8hS1XsgSfsO+fSdN16aVNviblmwufkIPS//VfGlNZwq1N1Nt35ejXT8dEuMXY4WK1e2ICluTENAsDkx6Lagrxv2VnZxTmMN8BL35mlmJNJT9jeCOqaCBqP2OovifXYfO0oD7pwnPqoDofw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=316766RL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wRqDaedP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="316766RL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wRqDaedP"
Date: Tue, 25 Jun 2024 11:07:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719306455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=47Kav8LXC8c9iFTHqR6sQ4RiWncDpGLHYJGOo9RCPig=;
	b=316766RLJfd8+zU+GmdZci2QjwBSm0hrfvlkg2GrfeK9N82mdflsLcEvEnQyxjnb9hPnuk
	H+LGo8lar5PTAOezW7VPdkWgf0BToZMknWIzDjRoLbHhP4BjUxzc9sdFotMDUVDjTqtkfk
	jSdO/it9jI3P5N1NKuT61nHC+SYbssbEMr1avOkvAZWyfN8tq3ISFb5lRMsW+itEk2E0/E
	grHa2Va9f1HLaNqoPbmfh6IL7uiFefQSCUrvsxkpsOUTPaj7KHPUR/UAnmgdn7uqdUd8CA
	GVQInvZh5IFskbzGFG4KpItaEtlNkj9EVL0pp4b4dypamnlg3M8vK7sJPgZInw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719306455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=47Kav8LXC8c9iFTHqR6sQ4RiWncDpGLHYJGOo9RCPig=;
	b=wRqDaedPuNHxQl+H8NAt8Pg5YE0lrT2egVanb7VkiuMwjqwzlssbM5oNekxzaBnsJYZ9hs
	oSjkIiiI/UxRS3Aw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v6.10-rc5-rt9
Message-ID: <20240625090734.F2QP6hPW@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Dear RT folks!

I'm pleased to announce the v6.10-rc5-rt9 patch set. 

Changes since v6.10-rc5-rt8:

  - Update the net/BH series to version nine that has been posted.

  - Update the zram patches based on feedback from upstream.

  - There can be warning about a softlocked CPU if there is a lot of
    output via printk() and printing thread therefore prints for a long
    time. This requires a non-preemptible kernel. Reported by Derek
    Barbosa.

  - Integrated Frederick's perf series. The original series to fix "perf
    test sigtrap" has been rebased on top of it and an updated based on
    Frederick's review. It has been posted v4.

Known issues
    None.

The delta patch against v6.10-rc5-rt8 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.10/incr/patch-6.10-rc5-rt8-rt9.patch.xz

You can get this release via the git tree at:

    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.10-rc5-rt9

The RT patch against v6.10-rc5 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.10/older/patch-6.10-rc5-rt9.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.10/older/patches-6.10-rc5-rt9.tar.xz

Sebastian

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index aab5fb3b1aba6..a35d4bd2e60ef 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -57,7 +57,6 @@ static void zram_free_page(struct zram *zram, size_t index);
 static int zram_read_page(struct zram *zram, struct page *page, u32 index,
 			  struct bio *parent);
 
-#ifdef CONFIG_PREEMPT_RT
 static void zram_meta_init_table_locks(struct zram *zram, size_t num_pages)
 {
 	size_t index;
@@ -68,46 +67,19 @@ static void zram_meta_init_table_locks(struct zram *zram, size_t num_pages)
 
 static int zram_slot_trylock(struct zram *zram, u32 index)
 {
-	int ret;
-
-	ret = spin_trylock(&zram->table[index].lock);
-	if (ret)
-		__set_bit(ZRAM_LOCK, &zram->table[index].flags);
-	return ret;
+	return spin_trylock(&zram->table[index].lock);
 }
 
 static void zram_slot_lock(struct zram *zram, u32 index)
 {
 	spin_lock(&zram->table[index].lock);
-	__set_bit(ZRAM_LOCK, &zram->table[index].flags);
 }
 
 static void zram_slot_unlock(struct zram *zram, u32 index)
 {
-	__clear_bit(ZRAM_LOCK, &zram->table[index].flags);
 	spin_unlock(&zram->table[index].lock);
 }
 
-#else
-
-static void zram_meta_init_table_locks(struct zram *zram, size_t num_pages) { }
-
-static int zram_slot_trylock(struct zram *zram, u32 index)
-{
-	return bit_spin_trylock(ZRAM_LOCK, &zram->table[index].flags);
-}
-
-static void zram_slot_lock(struct zram *zram, u32 index)
-{
-	bit_spin_lock(ZRAM_LOCK, &zram->table[index].flags);
-}
-
-static void zram_slot_unlock(struct zram *zram, u32 index)
-{
-	bit_spin_unlock(ZRAM_LOCK, &zram->table[index].flags);
-}
-#endif
-
 static inline bool init_done(struct zram *zram)
 {
 	return zram->disksize;
@@ -1320,7 +1292,7 @@ static void zram_free_page(struct zram *zram, size_t index)
 	zram_set_handle(zram, index, 0);
 	zram_set_obj_size(zram, index, 0);
 	WARN_ON_ONCE(zram->table[index].flags &
-		~(1UL << ZRAM_LOCK | 1UL << ZRAM_UNDER_WB));
+		~(1UL << ZRAM_UNDER_WB));
 }
 
 /*
@@ -2440,9 +2412,10 @@ static void destroy_devices(void)
 
 static int __init zram_init(void)
 {
+	struct zram_table_entry zram_te;
 	int ret;
 
-	BUILD_BUG_ON(__NR_ZRAM_PAGEFLAGS > BITS_PER_LONG);
+	BUILD_BUG_ON(__NR_ZRAM_PAGEFLAGS > sizeof(zram_te.flags) * 8);
 
 	ret = cpuhp_setup_state_multi(CPUHP_ZCOMP_PREPARE, "block/zram:prepare",
 				      zcomp_cpu_up_prepare, zcomp_cpu_dead);
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index 4e0c7c6d48132..531cefc666682 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -45,9 +45,7 @@
 
 /* Flags for zram pages (table[page_no].flags) */
 enum zram_pageflags {
-	/* zram slot is locked */
-	ZRAM_LOCK = ZRAM_FLAG_SHIFT,
-	ZRAM_SAME,	/* Page consists the same element */
+	ZRAM_SAME = ZRAM_FLAG_SHIFT,	/* Page consists the same element */
 	ZRAM_WB,	/* page is stored on backing_device */
 	ZRAM_UNDER_WB,	/* page is under writeback */
 	ZRAM_HUGE,	/* Incompressible page */
@@ -68,10 +66,8 @@ struct zram_table_entry {
 		unsigned long handle;
 		unsigned long element;
 	};
-	unsigned long flags;
-#ifdef CONFIG_PREEMPT_RT
+	unsigned int flags;
 	spinlock_t lock;
-#endif
 #ifdef CONFIG_ZRAM_TRACK_ENTRY_ACTIME
 	ktime_t ac_time;
 #endif
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 27e30bf2a1c50..65ece0d5b4b6d 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -786,6 +786,7 @@ struct perf_event {
 	struct irq_work			pending_disable_irq;
 	struct callback_head		pending_task;
 	unsigned int			pending_work;
+	struct rcuwait			pending_work_wait;
 
 	atomic_t			event_limit;
 
@@ -970,12 +971,6 @@ struct perf_event_context {
 	local_t				nr_pending;
 };
 
-/*
- * Number of contexts where an event can trigger:
- *	task, softirq, hardirq, nmi.
- */
-#define PERF_NR_CONTEXTS	4
-
 struct perf_cpu_pmu_context {
 	struct perf_event_pmu_context	epc;
 	struct perf_event_pmu_context	*task_epc;
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 34c6169f631eb..c582eb3ed7a6b 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -736,6 +736,12 @@ enum perf_event_task_context {
 	perf_nr_task_contexts,
 };
 
+/*
+ * Number of contexts where an event can trigger:
+ *      task, softirq, hardirq, nmi.
+ */
+#define PERF_NR_CONTEXTS	4
+
 struct wake_q_node {
 	struct wake_q_node *next;
 };
@@ -1260,6 +1266,7 @@ struct task_struct {
 	unsigned int			futex_state;
 #endif
 #ifdef CONFIG_PERF_EVENTS
+	u8				perf_recursion[PERF_NR_CONTEXTS];
 	struct perf_event_context	*perf_event_ctxp;
 	struct mutex			perf_event_mutex;
 	struct list_head		perf_event_list;
diff --git a/include/linux/task_work.h b/include/linux/task_work.h
index 795ef5a684294..26b8a47f41fca 100644
--- a/include/linux/task_work.h
+++ b/include/linux/task_work.h
@@ -30,7 +30,8 @@ int task_work_add(struct task_struct *task, struct callback_head *twork,
 
 struct callback_head *task_work_cancel_match(struct task_struct *task,
 	bool (*match)(struct callback_head *, void *data), void *data);
-struct callback_head *task_work_cancel(struct task_struct *, task_work_func_t);
+struct callback_head *task_work_cancel_func(struct task_struct *, task_work_func_t);
+bool task_work_cancel(struct task_struct *task, struct callback_head *cb);
 void task_work_run(void);
 
 static inline void exit_task_work(struct task_struct *task)
diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index 1273be84392cf..ad57944b6c40e 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -29,7 +29,7 @@ static inline size_t perf_callchain_entry__sizeof(void)
 				 sysctl_perf_event_max_contexts_per_stack));
 }
 
-static DEFINE_PER_CPU(int, callchain_recursion[PERF_NR_CONTEXTS]);
+static DEFINE_PER_CPU(u8, callchain_recursion[PERF_NR_CONTEXTS]);
 static atomic_t nr_callchain_events;
 static DEFINE_MUTEX(callchain_mutex);
 static struct callchain_cpus_entries *callchain_cpus_entries;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index c51a782374aff..8bba63ea9c686 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5191,10 +5191,35 @@ static bool exclusive_event_installable(struct perf_event *event,
 static void perf_addr_filters_splice(struct perf_event *event,
 				       struct list_head *head);
 
+static void perf_pending_task_sync(struct perf_event *event)
+{
+	struct callback_head *head = &event->pending_task;
+
+	if (!event->pending_work)
+		return;
+	/*
+	 * If the task is queued to the current task's queue, we
+	 * obviously can't wait for it to complete. Simply cancel it.
+	 */
+	if (task_work_cancel(current, head)) {
+		event->pending_work = 0;
+		local_dec(&event->ctx->nr_pending);
+		return;
+	}
+
+	/*
+	 * All accesses related to the event are within the same RCU section in
+	 * perf_pending_task(). The RCU grace period before the event is freed
+	 * will make sure all those accesses are complete by then.
+	 */
+	rcuwait_wait_event(&event->pending_work_wait, !event->pending_work, TASK_UNINTERRUPTIBLE);
+}
+
 static void _free_event(struct perf_event *event)
 {
 	irq_work_sync(&event->pending_irq);
 	irq_work_sync(&event->pending_disable_irq);
+	perf_pending_task_sync(event);
 
 	unaccount_event(event);
 
@@ -6823,14 +6848,30 @@ static void perf_pending_irq(struct irq_work *entry)
 static void perf_pending_task(struct callback_head *head)
 {
 	struct perf_event *event = container_of(head, struct perf_event, pending_task);
+	int rctx;
+
+	/*
+	 * All accesses to the event must belong to the same implicit RCU read-side
+	 * critical section as the ->pending_work reset. See comment in
+	 * perf_pending_task_sync().
+	 */
+	rcu_read_lock();
+	/*
+	 * If we 'fail' here, that's OK, it means recursion is already disabled
+	 * and we won't recurse 'further'.
+	 */
+	rctx = perf_swevent_get_recursion_context();
 
 	if (event->pending_work) {
 		event->pending_work = 0;
 		perf_sigtrap(event);
 		local_dec(&event->ctx->nr_pending);
+		rcuwait_wake_up(&event->pending_work_wait);
 	}
+	rcu_read_unlock();
 
-	put_event(event);
+	if (rctx >= 0)
+		perf_swevent_put_recursion_context(rctx);
 }
 
 #ifdef CONFIG_GUEST_PERF_EVENTS
@@ -9691,11 +9732,15 @@ static int __perf_event_overflow(struct perf_event *event,
 
 		if (regs)
 			pending_id = hash32_ptr((void *)instruction_pointer(regs)) ?: 1;
-		if (!event->pending_work) {
+
+		if (!event->pending_work &&
+		    !task_work_add(current, &event->pending_task, TWA_RESUME)) {
 			event->pending_work = pending_id;
 			local_inc(&event->ctx->nr_pending);
-			WARN_ON_ONCE(!atomic_long_inc_not_zero(&event->refcount));
-			task_work_add(current, &event->pending_task, TWA_RESUME);
+
+			event->pending_addr = 0;
+			if (valid_sample && (data->sample_flags & PERF_SAMPLE_ADDR))
+				event->pending_addr = data->addr;
 			/*
 			 * The NMI path returns directly to userland. The
 			 * irq_work is raised as a dummy interrupt to ensure
@@ -9704,6 +9749,7 @@ static int __perf_event_overflow(struct perf_event *event,
 			 */
 			if (in_nmi())
 				irq_work_queue(&event->pending_disable_irq);
+
 		} else if (event->attr.exclude_kernel && valid_sample) {
 			/*
 			 * Should not be able to return to user space without
@@ -9719,10 +9765,6 @@ static int __perf_event_overflow(struct perf_event *event,
 			 */
 			WARN_ON_ONCE(event->pending_work != pending_id);
 		}
-
-		event->pending_addr = 0;
-		if (valid_sample && (data->sample_flags & PERF_SAMPLE_ADDR))
-			event->pending_addr = data->addr;
 	}
 
 	READ_ONCE(event->overflow_handler)(event, data, regs);
@@ -9750,11 +9792,7 @@ struct swevent_htable {
 	struct swevent_hlist		*swevent_hlist;
 	struct mutex			hlist_mutex;
 	int				hlist_refcount;
-
-	/* Recursion avoidance in each contexts */
-	int				recursion[PERF_NR_CONTEXTS];
 };
-
 static DEFINE_PER_CPU(struct swevent_htable, swevent_htable);
 
 /*
@@ -9952,17 +9990,13 @@ DEFINE_PER_CPU(struct pt_regs, __perf_regs[4]);
 
 int perf_swevent_get_recursion_context(void)
 {
-	struct swevent_htable *swhash = this_cpu_ptr(&swevent_htable);
-
-	return get_recursion_context(swhash->recursion);
+	return get_recursion_context(current->perf_recursion);
 }
 EXPORT_SYMBOL_GPL(perf_swevent_get_recursion_context);
 
 void perf_swevent_put_recursion_context(int rctx)
 {
-	struct swevent_htable *swhash = this_cpu_ptr(&swevent_htable);
-
-	put_recursion_context(swhash->recursion, rctx);
+	put_recursion_context(current->perf_recursion, rctx);
 }
 
 void ___perf_sw_event(u32 event_id, u64 nr, struct pt_regs *regs, u64 addr)
@@ -11954,6 +11988,7 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 	init_irq_work(&event->pending_irq, perf_pending_irq);
 	event->pending_disable_irq = IRQ_WORK_INIT_HARD(perf_pending_disable);
 	init_task_work(&event->pending_task, perf_pending_task);
+	rcuwait_init(&event->pending_work_wait);
 
 	mutex_init(&event->mmap_mutex);
 	raw_spin_lock_init(&event->addr_filters.lock);
@@ -13065,13 +13100,6 @@ static void sync_child_event(struct perf_event *child_event)
 		     &parent_event->child_total_time_running);
 }
 
-static bool task_work_cb_match(struct callback_head *cb, void *data)
-{
-	struct perf_event *event = container_of(cb, struct perf_event, pending_task);
-
-	return event == data;
-}
-
 static void
 perf_event_exit_event(struct perf_event *event, struct perf_event_context *ctx)
 {
@@ -13111,17 +13139,6 @@ perf_event_exit_event(struct perf_event *event, struct perf_event_context *ctx)
 		 * Kick perf_poll() for is_event_hup();
 		 */
 		perf_event_wakeup(parent_event);
-		/*
-		 * Cancel pending task_work and update counters if it has not
-		 * yet been delivered to userland. free_event() expects the
-		 * reference counter at 1 and keeping the event around until the
-		 * task return to userland will be a unexpected.
-		 */
-		if (event->pending_work &&
-		    task_work_cancel_match(current, task_work_cb_match, event)) {
-			put_event(event);
-			local_dec(&event->ctx->nr_pending);
-		}
 		free_event(event);
 		put_event(parent_event);
 		return;
@@ -13647,6 +13664,7 @@ int perf_event_init_task(struct task_struct *child, u64 clone_flags)
 {
 	int ret;
 
+	memset(child->perf_recursion, 0, sizeof(child->perf_recursion));
 	child->perf_event_ctxp = NULL;
 	mutex_init(&child->perf_event_mutex);
 	INIT_LIST_HEAD(&child->perf_event_list);
diff --git a/kernel/events/internal.h b/kernel/events/internal.h
index 5150d5f84c033..f0daaa6f2a33b 100644
--- a/kernel/events/internal.h
+++ b/kernel/events/internal.h
@@ -208,7 +208,7 @@ arch_perf_out_copy_user(void *dst, const void *src, unsigned long n)
 
 DEFINE_OUTPUT_COPY(__output_copy_user, arch_perf_out_copy_user)
 
-static inline int get_recursion_context(int *recursion)
+static inline int get_recursion_context(u8 *recursion)
 {
 	unsigned char rctx = interrupt_context_level();
 
@@ -221,7 +221,7 @@ static inline int get_recursion_context(int *recursion)
 	return rctx;
 }
 
-static inline void put_recursion_context(int *recursion, int rctx)
+static inline void put_recursion_context(u8 *recursion, unsigned char rctx)
 {
 	barrier();
 	recursion[rctx]--;
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 71b0fc2d0aeaa..dd53298ef1a5c 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1337,7 +1337,7 @@ static int irq_thread(void *data)
 	 * synchronize_hardirq(). So neither IRQTF_RUNTHREAD nor the
 	 * oneshot mask bit can be set.
 	 */
-	task_work_cancel(current, irq_thread_dtor);
+	task_work_cancel_func(current, irq_thread_dtor);
 	return 0;
 }
 
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index bb9689f94d302..0813ce88a49c5 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1119,6 +1119,7 @@ static int nbcon_kthread_func(void *__console)
 		}
 
 		console_srcu_read_unlock(cookie);
+		cond_resched();
 
 	} while (backlog);
 
diff --git a/kernel/task_work.c b/kernel/task_work.c
index 95a7e1b7f1dab..2134ac8057a94 100644
--- a/kernel/task_work.c
+++ b/kernel/task_work.c
@@ -120,9 +120,9 @@ static bool task_work_func_match(struct callback_head *cb, void *data)
 }
 
 /**
- * task_work_cancel - cancel a pending work added by task_work_add()
- * @task: the task which should execute the work
- * @func: identifies the work to remove
+ * task_work_cancel_func - cancel a pending work matching a function added by task_work_add()
+ * @task: the task which should execute the func's work
+ * @func: identifies the func to match with a work to remove
  *
  * Find the last queued pending work with ->func == @func and remove
  * it from queue.
@@ -131,11 +131,35 @@ static bool task_work_func_match(struct callback_head *cb, void *data)
  * The found work or NULL if not found.
  */
 struct callback_head *
-task_work_cancel(struct task_struct *task, task_work_func_t func)
+task_work_cancel_func(struct task_struct *task, task_work_func_t func)
 {
 	return task_work_cancel_match(task, task_work_func_match, func);
 }
 
+static bool task_work_match(struct callback_head *cb, void *data)
+{
+	return cb == data;
+}
+
+/**
+ * task_work_cancel - cancel a pending work added by task_work_add()
+ * @task: the task which should execute the work
+ * @cb: the callback to remove if queued
+ *
+ * Remove a callback from a task's queue if queued.
+ *
+ * RETURNS:
+ * True if the callback was queued and got cancelled, false otherwise.
+ */
+bool task_work_cancel(struct task_struct *task, struct callback_head *cb)
+{
+	struct callback_head *ret;
+
+	ret = task_work_cancel_match(task, task_work_match, cb);
+
+	return ret == cb;
+}
+
 /**
  * task_work_run - execute the works added by task_work_add()
  *
@@ -168,7 +192,7 @@ void task_work_run(void)
 		if (!work)
 			break;
 		/*
-		 * Synchronize with task_work_cancel(). It can not remove
+		 * Synchronize with task_work_cancel_match(). It can not remove
 		 * the first entry == work, cmpxchg(task_works) must fail.
 		 * But it can remove another entry from the ->next list.
 		 */
diff --git a/localversion-rt b/localversion-rt
index 700c857efd9ba..22746d6390a42 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt8
+-rt9
diff --git a/net/core/dev.c b/net/core/dev.c
index 7d59afa862630..bd3cead02b530 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6339,6 +6339,7 @@ enum {
 static void busy_poll_stop(struct napi_struct *napi, void *have_poll_lock,
 			   unsigned flags, u16 budget)
 {
+	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
 	bool skip_schedule = false;
 	unsigned long timeout;
 	int rc;
@@ -6356,6 +6357,7 @@ static void busy_poll_stop(struct napi_struct *napi, void *have_poll_lock,
 	clear_bit(NAPI_STATE_IN_BUSY_POLL, &napi->state);
 
 	local_bh_disable();
+	bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
 
 	if (flags & NAPI_F_PREFER_BUSY_POLL) {
 		napi->defer_hard_irqs_count = READ_ONCE(napi->dev->napi_defer_hard_irqs);
@@ -6378,6 +6380,7 @@ static void busy_poll_stop(struct napi_struct *napi, void *have_poll_lock,
 	netpoll_poll_unlock(have_poll_lock);
 	if (rc == budget)
 		__busy_poll_stop(napi, skip_schedule);
+	bpf_net_ctx_clear(bpf_net_ctx);
 	local_bh_enable();
 }
 
diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index 4bc3e9398ee3d..ab927a142f515 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -1694,7 +1694,7 @@ long keyctl_session_to_parent(void)
 		goto unlock;
 
 	/* cancel an already pending keyring replacement */
-	oldwork = task_work_cancel(parent, key_change_session_keyring);
+	oldwork = task_work_cancel_func(parent, key_change_session_keyring);
 
 	/* the replacement session keyring is applied just prior to userspace
 	 * restarting */
