Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8696F2D63E3;
	Wed,  3 Sep 2025 08:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756887957; cv=none; b=FqzsYvcqmm6TvPCfZWZNSlmpmPZiwn85pil5CwF+biiAjwiSVNdTm2o39fkVeTp3yhR0YUmtFiTsx+LHaq1Dp+RgsxhT/pNzigZiPBKJ6vaBd8RM2qh/+KoXeO6fyS5kErzUmU7CbLP0OykrJSX4MI2i4+3JMqe+zcqsWaBhFGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756887957; c=relaxed/simple;
	bh=6F2vKP8hmmGzKZ3u3nXIhYVk/Qq0taf7ZLm+joJaNfs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uPeDAy2l7E0tfi3JuxwVECLZjTq0t5kYHZFDQHXCMJbdY6G6rXqWkGEwRdZVsQ/TuSvACrjhU0QQgNpx4eT5Y3eK3wMS5vmlnLnk9ncNijhE6I2vRXVMjBZ7IZm65rK/cnFHotZXf+ntWChPLzp540qoKH8su1PGDf8AQ92v12g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i7c981sx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P4jdG4Di; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i7c981sx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P4jdG4Di"
Date: Wed, 3 Sep 2025 10:25:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756887953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=q6W3Ru1JXhIpUoJRsko0KvFPGyHDIfVMcC+Klq2rPyM=;
	b=i7c981sxQW6U/PH0/jounbTYXD4+sTK6j7rCd9iHiYSS6sFin+EYk0K7McjAzNZo5e/193
	zU3UnWvKo94VE7pt1eHZRpd5NVkTFrua8jlb961sV7XNulbrcoyUbQNTqVjVQ7N/GQfhL0
	pqSJONsQ00CFnoOzUUi1xM5zn2ZNSN2ZqypxjoeHKQ0mcodAmTAMErB7e+PKXNfF6iwSiy
	Cj+HgzRPgpllyaZTlKeKIUdFfJ3lsGAD+jDMHvjZiMUGGwUNJFSZjtyhtP6fvi5GBKUqmN
	1+YiFVjmFVvBZO4lAtZx8ROgfS0mEIO09s8MIeaGDmsYgcF/sAqILdJDenWRmg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756887953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=q6W3Ru1JXhIpUoJRsko0KvFPGyHDIfVMcC+Klq2rPyM=;
	b=P4jdG4DiFeAbX6LbAFlbXmxcV3f7mzwl0OeF/f8QHJ87p7od9ghDxYz//wJ4RVFwKSYlES
	Whdt8Xe46ka/l5AA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>, linux-rt-devel@lists.linux.dev
Cc: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v6.17-rc4-rt3
Message-ID: <20250903082550.58S76eQl@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Dear RT folks!

I'm pleased to announce the v6.17-rc4-rt3 patch set. 

Changes since v6.17-rc4-rt2:

    - Allow to drop the lock synchronisation local_bh_disable(). It is
      not effective immediately but with CONFIG_PREEMPT_RT_NEEDS_BH_LOCK=n.
      This required to backport a netfilter change and make changes to
      tasklets and workqueue (for BH worker).
  
    - Backport a futex patch from -tip to address a warning during
      mmdrop().

Known issues
    - Yoann Congal reported a bit spinlock in dm_exception_table_lock().
        https://lore.kernel.org/all/Z8GTjqgDe_5EkE3t@P-ASN-ECS-830T8C3.local

The delta patch against v6.17-rc4-rt2 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.17/incr/patch-6.17-rc4-rt2-rt3.patch.xz

You can get this release via the git tree at:

    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.17-rc4-rt3

The RT patch against v6.17-rc4 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.17/older/patch-6.17-rc4-rt3.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.17/older/patches-6.17-rc4-rt3.tar.xz

Sebastian

diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index 54ea59ff8fbeb..da326800c1c9b 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -103,6 +103,19 @@ config PREEMPT_RT
 	  Select this if you are building a kernel for systems which
 	  require real-time guarantees.
 
+config PREEMPT_RT_NEEDS_BH_LOCK
+	bool "Enforce softirq synchronisation on PREEMPT_RT"
+	depends on PREEMPT_RT
+	help
+	  Enforce synchronisation across the softirqs context. On PREEMPT_RT
+	  the softirq is preemptible. This enforces the same per-CPU BLK
+	  semantic non-PREEMPT_RT builds have. This should not be needed
+	  because per-CPU locks were added to avoid the per-CPU BKL.
+
+	  This switch provides the old behaviour for testing reasons. Select
+	  this if you suspect an error with preemptible softirq and want test
+	  the old synchronized behaviour.
+
 config PREEMPT_COUNT
        bool
 
diff --git a/kernel/fork.c b/kernel/fork.c
index af673856499dc..c4ada32598bd5 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -689,7 +689,6 @@ void __mmdrop(struct mm_struct *mm)
 	mm_pasid_drop(mm);
 	mm_destroy_cid(mm);
 	percpu_counter_destroy_many(mm->rss_stat, NR_MM_COUNTERS);
-	futex_hash_free(mm);
 
 	free_mm(mm);
 }
@@ -1138,6 +1137,7 @@ static inline void __mmput(struct mm_struct *mm)
 	if (mm->binfmt)
 		module_put(mm->binfmt->module);
 	lru_gen_del_mm(mm);
+	futex_hash_free(mm);
 	mmdrop(mm);
 }
 
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index d9bb5567af0c5..125804fbb5cb1 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -1722,12 +1722,9 @@ int futex_mm_init(struct mm_struct *mm)
 	RCU_INIT_POINTER(mm->futex_phash, NULL);
 	mm->futex_phash_new = NULL;
 	/* futex-ref */
+	mm->futex_ref = NULL;
 	atomic_long_set(&mm->futex_atomic, 0);
 	mm->futex_batches = get_state_synchronize_rcu();
-	mm->futex_ref = alloc_percpu(unsigned int);
-	if (!mm->futex_ref)
-		return -ENOMEM;
-	this_cpu_inc(*mm->futex_ref); /* 0 -> 1 */
 	return 0;
 }
 
@@ -1801,6 +1798,17 @@ static int futex_hash_allocate(unsigned int hash_slots, unsigned int flags)
 		}
 	}
 
+	if (!mm->futex_ref) {
+		/*
+		 * This will always be allocated by the first thread and
+		 * therefore requires no locking.
+		 */
+		mm->futex_ref = alloc_percpu(unsigned int);
+		if (!mm->futex_ref)
+			return -ENOMEM;
+		this_cpu_inc(*mm->futex_ref); /* 0 -> 1 */
+	}
+
 	fph = kvzalloc(struct_size(fph, queues, hash_slots),
 		       GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
 	if (!fph)
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 513b1945987cc..77198911b8dd4 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -165,7 +165,11 @@ void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
 	/* First entry of a task into a BH disabled section? */
 	if (!current->softirq_disable_cnt) {
 		if (preemptible()) {
-			local_lock(&softirq_ctrl.lock);
+			if (IS_ENABLED(CONFIG_PREEMPT_RT_NEEDS_BH_LOCK))
+				local_lock(&softirq_ctrl.lock);
+			else
+				migrate_disable();
+
 			/* Required to meet the RCU bottomhalf requirements. */
 			rcu_read_lock();
 		} else {
@@ -177,17 +181,34 @@ void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
 	 * Track the per CPU softirq disabled state. On RT this is per CPU
 	 * state to allow preemption of bottom half disabled sections.
 	 */
-	newcnt = __this_cpu_add_return(softirq_ctrl.cnt, cnt);
-	/*
-	 * Reflect the result in the task state to prevent recursion on the
-	 * local lock and to make softirq_count() & al work.
-	 */
-	current->softirq_disable_cnt = newcnt;
+	if (IS_ENABLED(CONFIG_PREEMPT_RT_NEEDS_BH_LOCK)) {
+		newcnt = this_cpu_add_return(softirq_ctrl.cnt, cnt);
+		/*
+		 * Reflect the result in the task state to prevent recursion on the
+		 * local lock and to make softirq_count() & al work.
+		 */
+		current->softirq_disable_cnt = newcnt;
 
-	if (IS_ENABLED(CONFIG_TRACE_IRQFLAGS) && newcnt == cnt) {
-		raw_local_irq_save(flags);
-		lockdep_softirqs_off(ip);
-		raw_local_irq_restore(flags);
+		if (IS_ENABLED(CONFIG_TRACE_IRQFLAGS) && newcnt == cnt) {
+			raw_local_irq_save(flags);
+			lockdep_softirqs_off(ip);
+			raw_local_irq_restore(flags);
+		}
+	} else {
+		bool sirq_dis = false;
+
+		if (!current->softirq_disable_cnt)
+			sirq_dis = true;
+
+		this_cpu_add(softirq_ctrl.cnt, cnt);
+		current->softirq_disable_cnt += cnt;
+		WARN_ON_ONCE(current->softirq_disable_cnt < 0);
+
+		if (IS_ENABLED(CONFIG_TRACE_IRQFLAGS) && sirq_dis) {
+			raw_local_irq_save(flags);
+			lockdep_softirqs_off(ip);
+			raw_local_irq_restore(flags);
+		}
 	}
 }
 EXPORT_SYMBOL(__local_bh_disable_ip);
@@ -195,23 +216,42 @@ EXPORT_SYMBOL(__local_bh_disable_ip);
 static void __local_bh_enable(unsigned int cnt, bool unlock)
 {
 	unsigned long flags;
+	bool sirq_en = false;
 	int newcnt;
 
-	DEBUG_LOCKS_WARN_ON(current->softirq_disable_cnt !=
-			    this_cpu_read(softirq_ctrl.cnt));
+	if (IS_ENABLED(CONFIG_PREEMPT_RT_NEEDS_BH_LOCK)) {
+		DEBUG_LOCKS_WARN_ON(current->softirq_disable_cnt !=
+				    this_cpu_read(softirq_ctrl.cnt));
+		if (softirq_count() == cnt)
+			sirq_en = true;
+	} else {
+		if (current->softirq_disable_cnt == cnt)
+			sirq_en = true;
+	}
 
-	if (IS_ENABLED(CONFIG_TRACE_IRQFLAGS) && softirq_count() == cnt) {
+	if (IS_ENABLED(CONFIG_TRACE_IRQFLAGS) && sirq_en) {
 		raw_local_irq_save(flags);
 		lockdep_softirqs_on(_RET_IP_);
 		raw_local_irq_restore(flags);
 	}
 
-	newcnt = __this_cpu_sub_return(softirq_ctrl.cnt, cnt);
-	current->softirq_disable_cnt = newcnt;
+	if (IS_ENABLED(CONFIG_PREEMPT_RT_NEEDS_BH_LOCK)) {
+		newcnt = this_cpu_sub_return(softirq_ctrl.cnt, cnt);
+		current->softirq_disable_cnt = newcnt;
 
-	if (!newcnt && unlock) {
-		rcu_read_unlock();
-		local_unlock(&softirq_ctrl.lock);
+		if (!newcnt && unlock) {
+			rcu_read_unlock();
+			local_unlock(&softirq_ctrl.lock);
+		}
+	} else {
+		current->softirq_disable_cnt -= cnt;
+		this_cpu_sub(softirq_ctrl.cnt, cnt);
+		if (unlock && !current->softirq_disable_cnt) {
+			migrate_enable();
+			rcu_read_unlock();
+		} else {
+			WARN_ON_ONCE(current->softirq_disable_cnt < 0);
+		}
 	}
 }
 
@@ -228,7 +268,10 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
 	lock_map_release(&bh_lock_map);
 
 	local_irq_save(flags);
-	curcnt = __this_cpu_read(softirq_ctrl.cnt);
+	if (IS_ENABLED(CONFIG_PREEMPT_RT_NEEDS_BH_LOCK))
+		curcnt = this_cpu_read(softirq_ctrl.cnt);
+	else
+		curcnt = current->softirq_disable_cnt;
 
 	/*
 	 * If this is not reenabling soft interrupts, no point in trying to
@@ -805,6 +848,58 @@ static bool tasklet_clear_sched(struct tasklet_struct *t)
 	return false;
 }
 
+#ifdef CONFIG_PREEMPT_RT
+struct tasklet_sync_callback {
+	spinlock_t	cb_lock;
+	atomic_t	cb_waiters;
+};
+
+static DEFINE_PER_CPU(struct tasklet_sync_callback, tasklet_sync_callback) = {
+	.cb_lock	= __SPIN_LOCK_UNLOCKED(tasklet_sync_callback.cb_lock),
+	.cb_waiters	= ATOMIC_INIT(0),
+};
+
+static void tasklet_lock_callback(void)
+{
+	spin_lock(this_cpu_ptr(&tasklet_sync_callback.cb_lock));
+}
+
+static void tasklet_unlock_callback(void)
+{
+	spin_unlock(this_cpu_ptr(&tasklet_sync_callback.cb_lock));
+}
+
+static void tasklet_callback_cancel_wait_running(void)
+{
+	struct tasklet_sync_callback *sync_cb = this_cpu_ptr(&tasklet_sync_callback);
+
+	atomic_inc(&sync_cb->cb_waiters);
+	spin_lock(&sync_cb->cb_lock);
+	atomic_dec(&sync_cb->cb_waiters);
+	spin_unlock(&sync_cb->cb_lock);
+}
+
+static void tasklet_callback_sync_wait_running(void)
+{
+	struct tasklet_sync_callback *sync_cb = this_cpu_ptr(&tasklet_sync_callback);
+
+	if (atomic_read(&sync_cb->cb_waiters)) {
+		spin_unlock(&sync_cb->cb_lock);
+		spin_lock(&sync_cb->cb_lock);
+	}
+}
+
+#else /* !CONFIG_PREEMPT_RT: */
+
+static void tasklet_lock_callback(void) { }
+static void tasklet_unlock_callback(void) { }
+static void tasklet_callback_sync_wait_running(void) { }
+
+#ifdef CONFIG_SMP
+static void tasklet_callback_cancel_wait_running(void) { }
+#endif
+#endif /* !CONFIG_PREEMPT_RT */
+
 static void tasklet_action_common(struct tasklet_head *tl_head,
 				  unsigned int softirq_nr)
 {
@@ -816,6 +911,7 @@ static void tasklet_action_common(struct tasklet_head *tl_head,
 	tl_head->tail = &tl_head->head;
 	local_irq_enable();
 
+	tasklet_lock_callback();
 	while (list) {
 		struct tasklet_struct *t = list;
 
@@ -835,6 +931,7 @@ static void tasklet_action_common(struct tasklet_head *tl_head,
 					}
 				}
 				tasklet_unlock(t);
+				tasklet_callback_sync_wait_running();
 				continue;
 			}
 			tasklet_unlock(t);
@@ -847,6 +944,7 @@ static void tasklet_action_common(struct tasklet_head *tl_head,
 		__raise_softirq_irqoff(softirq_nr);
 		local_irq_enable();
 	}
+	tasklet_unlock_callback();
 }
 
 static __latent_entropy void tasklet_action(void)
@@ -897,12 +995,9 @@ void tasklet_unlock_spin_wait(struct tasklet_struct *t)
 			/*
 			 * Prevent a live lock when current preempted soft
 			 * interrupt processing or prevents ksoftirqd from
-			 * running. If the tasklet runs on a different CPU
-			 * then this has no effect other than doing the BH
-			 * disable/enable dance for nothing.
+			 * running.
 			 */
-			local_bh_disable();
-			local_bh_enable();
+			tasklet_callback_cancel_wait_running();
 		} else {
 			cpu_relax();
 		}
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index c6b79b3675c31..94e226f637992 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -222,7 +222,9 @@ struct worker_pool {
 	struct workqueue_attrs	*attrs;		/* I: worker attributes */
 	struct hlist_node	hash_node;	/* PL: unbound_pool_hash node */
 	int			refcnt;		/* PL: refcnt for unbound pools */
-
+#ifdef CONFIG_PREEMPT_RT
+	spinlock_t		cb_lock;	/* BH worker cancel lock */
+#endif
 	/*
 	 * Destruction of pool is RCU protected to allow dereferences
 	 * from get_work_pool().
@@ -3078,6 +3080,31 @@ __acquires(&pool->lock)
 		goto restart;
 }
 
+#ifdef CONFIG_PREEMPT_RT
+static void worker_lock_callback(struct worker_pool *pool)
+{
+	spin_lock(&pool->cb_lock);
+}
+
+static void worker_unlock_callback(struct worker_pool *pool)
+{
+	spin_unlock(&pool->cb_lock);
+}
+
+static void workqueue_callback_cancel_wait_running(struct worker_pool *pool)
+{
+	spin_lock(&pool->cb_lock);
+	spin_unlock(&pool->cb_lock);
+}
+
+#else
+
+static void worker_lock_callback(struct worker_pool *pool) { }
+static void worker_unlock_callback(struct worker_pool *pool) { }
+static void workqueue_callback_cancel_wait_running(struct worker_pool *pool) { }
+
+#endif
+
 /**
  * manage_workers - manage worker pool
  * @worker: self
@@ -3557,6 +3584,7 @@ static void bh_worker(struct worker *worker)
 	int nr_restarts = BH_WORKER_RESTARTS;
 	unsigned long end = jiffies + BH_WORKER_JIFFIES;
 
+	worker_lock_callback(pool);
 	raw_spin_lock_irq(&pool->lock);
 	worker_leave_idle(worker);
 
@@ -3585,6 +3613,7 @@ static void bh_worker(struct worker *worker)
 	worker_enter_idle(worker);
 	kick_pool(pool);
 	raw_spin_unlock_irq(&pool->lock);
+	worker_unlock_callback(pool);
 }
 
 /*
@@ -4222,17 +4251,18 @@ static bool __flush_work(struct work_struct *work, bool from_cancel)
 		    (data & WORK_OFFQ_BH)) {
 			/*
 			 * On RT, prevent a live lock when %current preempted
-			 * soft interrupt processing or prevents ksoftirqd from
-			 * running by keeping flipping BH. If the BH work item
-			 * runs on a different CPU then this has no effect other
-			 * than doing the BH disable/enable dance for nothing.
-			 * This is copied from
-			 * kernel/softirq.c::tasklet_unlock_spin_wait().
+			 * soft interrupt processing by blocking on lock which
+			 * is owned by the thread invoking the callback.
 			 */
 			while (!try_wait_for_completion(&barr.done)) {
 				if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
-					local_bh_disable();
-					local_bh_enable();
+					struct worker_pool *pool;
+
+					mutex_lock(&wq_pool_mutex);
+					pool = get_work_pool(work);
+					if (pool)
+						workqueue_callback_cancel_wait_running(pool);
+					mutex_unlock(&wq_pool_mutex);
 				} else {
 					cpu_relax();
 				}
@@ -4782,6 +4812,9 @@ static int init_worker_pool(struct worker_pool *pool)
 	ida_init(&pool->worker_ida);
 	INIT_HLIST_NODE(&pool->hash_node);
 	pool->refcnt = 1;
+#ifdef CONFIG_PREEMPT_RT
+	spin_lock_init(&pool->cb_lock);
+#endif
 
 	/* shouldn't fail above this point */
 	pool->attrs = alloc_workqueue_attrs();
diff --git a/localversion-rt b/localversion-rt
index c3054d08a1129..1445cd65885cd 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt2
+-rt3
diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index 50fd6809380fa..3a04665adf992 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -60,7 +60,7 @@ MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("List and change connection tracking table");
 
 struct ctnetlink_list_dump_ctx {
-	struct nf_conn *last;
+	unsigned long last_id;
 	unsigned int cpu;
 	bool done;
 };
@@ -1733,16 +1733,6 @@ static int ctnetlink_get_conntrack(struct sk_buff *skb,
 	return nfnetlink_unicast(skb2, info->net, NETLINK_CB(skb).portid);
 }
 
-static int ctnetlink_done_list(struct netlink_callback *cb)
-{
-	struct ctnetlink_list_dump_ctx *ctx = (void *)cb->ctx;
-
-	if (ctx->last)
-		nf_ct_put(ctx->last);
-
-	return 0;
-}
-
 #ifdef CONFIG_NF_CONNTRACK_EVENTS
 static int ctnetlink_dump_one_entry(struct sk_buff *skb,
 				    struct netlink_callback *cb,
@@ -1757,11 +1747,11 @@ static int ctnetlink_dump_one_entry(struct sk_buff *skb,
 	if (l3proto && nf_ct_l3num(ct) != l3proto)
 		return 0;
 
-	if (ctx->last) {
-		if (ct != ctx->last)
+	if (ctx->last_id) {
+		if (ctnetlink_get_id(ct) != ctx->last_id)
 			return 0;
 
-		ctx->last = NULL;
+		ctx->last_id = 0;
 	}
 
 	/* We can't dump extension info for the unconfirmed
@@ -1775,12 +1765,8 @@ static int ctnetlink_dump_one_entry(struct sk_buff *skb,
 				  cb->nlh->nlmsg_seq,
 				  NFNL_MSG_TYPE(cb->nlh->nlmsg_type),
 				  ct, dying, 0);
-	if (res < 0) {
-		if (!refcount_inc_not_zero(&ct->ct_general.use))
-			return 0;
-
-		ctx->last = ct;
-	}
+	if (res < 0)
+		ctx->last_id = ctnetlink_get_id(ct);
 
 	return res;
 }
@@ -1796,10 +1782,10 @@ static int
 ctnetlink_dump_dying(struct sk_buff *skb, struct netlink_callback *cb)
 {
 	struct ctnetlink_list_dump_ctx *ctx = (void *)cb->ctx;
-	struct nf_conn *last = ctx->last;
 #ifdef CONFIG_NF_CONNTRACK_EVENTS
 	const struct net *net = sock_net(skb->sk);
 	struct nf_conntrack_net_ecache *ecache_net;
+	unsigned long last_id = ctx->last_id;
 	struct nf_conntrack_tuple_hash *h;
 	struct hlist_nulls_node *n;
 #endif
@@ -1807,7 +1793,7 @@ ctnetlink_dump_dying(struct sk_buff *skb, struct netlink_callback *cb)
 	if (ctx->done)
 		return 0;
 
-	ctx->last = NULL;
+	ctx->last_id = 0;
 
 #ifdef CONFIG_NF_CONNTRACK_EVENTS
 	ecache_net = nf_conn_pernet_ecache(net);
@@ -1818,24 +1804,21 @@ ctnetlink_dump_dying(struct sk_buff *skb, struct netlink_callback *cb)
 		int res;
 
 		ct = nf_ct_tuplehash_to_ctrack(h);
-		if (last && last != ct)
+		if (last_id && last_id != ctnetlink_get_id(ct))
 			continue;
 
 		res = ctnetlink_dump_one_entry(skb, cb, ct, true);
 		if (res < 0) {
 			spin_unlock_bh(&ecache_net->dying_lock);
-			nf_ct_put(last);
 			return skb->len;
 		}
 
-		nf_ct_put(last);
-		last = NULL;
+		last_id = 0;
 	}
 
 	spin_unlock_bh(&ecache_net->dying_lock);
 #endif
 	ctx->done = true;
-	nf_ct_put(last);
 
 	return skb->len;
 }
@@ -1847,7 +1830,6 @@ static int ctnetlink_get_ct_dying(struct sk_buff *skb,
 	if (info->nlh->nlmsg_flags & NLM_F_DUMP) {
 		struct netlink_dump_control c = {
 			.dump = ctnetlink_dump_dying,
-			.done = ctnetlink_done_list,
 		};
 		return netlink_dump_start(info->sk, skb, info->nlh, &c);
 	}
@@ -1862,7 +1844,6 @@ static int ctnetlink_get_ct_unconfirmed(struct sk_buff *skb,
 	if (info->nlh->nlmsg_flags & NLM_F_DUMP) {
 		struct netlink_dump_control c = {
 			.dump = ctnetlink_dump_unconfirmed,
-			.done = ctnetlink_done_list,
 		};
 		return netlink_dump_start(info->sk, skb, info->nlh, &c);
 	}
diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index 9a10251228fd5..b385cfcf886f9 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -397,7 +397,7 @@ int pipapo_refill(unsigned long *map, unsigned int len, unsigned int rules,
 }
 
 /**
- * pipapo_get() - Get matching element reference given key data
+ * pipapo_get_slow() - Get matching element reference given key data
  * @m:		storage containing the set elements
  * @data:	Key data to be matched against existing elements
  * @genmask:	If set, check that element is active in given genmask
@@ -414,12 +414,12 @@ int pipapo_refill(unsigned long *map, unsigned int len, unsigned int rules,
  *
  * Return: pointer to &struct nft_pipapo_elem on match, NULL otherwise.
  */
-static struct nft_pipapo_elem *pipapo_get(const struct nft_pipapo_match *m,
-					  const u8 *data, u8 genmask,
-					  u64 tstamp)
+static struct nft_pipapo_elem *pipapo_get_slow(const struct nft_pipapo_match *m,
+					       const u8 *data, u8 genmask,
+					       u64 tstamp)
 {
+	unsigned long *res_map, *fill_map, *map;
 	struct nft_pipapo_scratch *scratch;
-	unsigned long *res_map, *fill_map;
 	const struct nft_pipapo_field *f;
 	bool map_index;
 	int i;
@@ -429,11 +429,13 @@ static struct nft_pipapo_elem *pipapo_get(const struct nft_pipapo_match *m,
 	scratch = *raw_cpu_ptr(m->scratch);
 	if (unlikely(!scratch))
 		goto out;
+	__local_lock_nested_bh(&scratch->bh_lock);
 
 	map_index = scratch->map_index;
 
-	res_map  = scratch->map + (map_index ? m->bsize_max : 0);
-	fill_map = scratch->map + (map_index ? 0 : m->bsize_max);
+	map = NFT_PIPAPO_LT_ALIGN(&scratch->__map[0]);
+	res_map  = map + (map_index ? m->bsize_max : 0);
+	fill_map = map + (map_index ? 0 : m->bsize_max);
 
 	pipapo_resmap_init(m, res_map);
 
@@ -464,6 +466,7 @@ static struct nft_pipapo_elem *pipapo_get(const struct nft_pipapo_match *m,
 				  last);
 		if (b < 0) {
 			scratch->map_index = map_index;
+			__local_unlock_nested_bh(&scratch->bh_lock);
 			local_bh_enable();
 
 			return NULL;
@@ -483,6 +486,7 @@ static struct nft_pipapo_elem *pipapo_get(const struct nft_pipapo_match *m,
 			 * *next* bitmap (not initial) for the next packet.
 			 */
 			scratch->map_index = map_index;
+			__local_unlock_nested_bh(&scratch->bh_lock);
 			local_bh_enable();
 			return e;
 		}
@@ -497,11 +501,47 @@ static struct nft_pipapo_elem *pipapo_get(const struct nft_pipapo_match *m,
 		data += NFT_PIPAPO_GROUPS_PADDING(f);
 	}
 
+	__local_unlock_nested_bh(&scratch->bh_lock);
 out:
 	local_bh_enable();
 	return NULL;
 }
 
+/**
+ * pipapo_get() - Get matching element reference given key data
+ * @m:		Storage containing the set elements
+ * @data:	Key data to be matched against existing elements
+ * @genmask:	If set, check that element is active in given genmask
+ * @tstamp:	Timestamp to check for expired elements
+ *
+ * This is a dispatcher function, either calling out the generic C
+ * implementation or, if available, the AVX2 one.
+ * This helper is only called from the control plane, with either RCU
+ * read lock or transaction mutex held.
+ *
+ * Return: pointer to &struct nft_pipapo_elem on match, NULL otherwise.
+ */
+static struct nft_pipapo_elem *pipapo_get(const struct nft_pipapo_match *m,
+					  const u8 *data, u8 genmask,
+					  u64 tstamp)
+{
+	struct nft_pipapo_elem *e;
+
+	local_bh_disable();
+
+#if defined(CONFIG_X86_64) && !defined(CONFIG_UML)
+	if (boot_cpu_has(X86_FEATURE_AVX2) && boot_cpu_has(X86_FEATURE_AVX) &&
+	    irq_fpu_usable()) {
+		e = pipapo_get_avx2(m, data, genmask, tstamp);
+		local_bh_enable();
+		return e;
+	}
+#endif
+	e = pipapo_get_slow(m, data, genmask, tstamp);
+	local_bh_enable();
+	return e;
+}
+
 /**
  * nft_pipapo_lookup() - Dataplane fronted for main lookup function
  * @net:	Network namespace
@@ -523,7 +563,7 @@ nft_pipapo_lookup(const struct net *net, const struct nft_set *set,
 	const struct nft_pipapo_elem *e;
 
 	m = rcu_dereference(priv->match);
-	e = pipapo_get(m, (const u8 *)key, genmask, get_jiffies_64());
+	e = pipapo_get_slow(m, (const u8 *)key, genmask, get_jiffies_64());
 
 	return e ? &e->ext : NULL;
 }
@@ -1136,22 +1176,17 @@ static void pipapo_map(struct nft_pipapo_match *m,
 }
 
 /**
- * pipapo_free_scratch() - Free per-CPU map at original (not aligned) address
+ * pipapo_free_scratch() - Free per-CPU map at original address
  * @m:		Matching data
  * @cpu:	CPU number
  */
 static void pipapo_free_scratch(const struct nft_pipapo_match *m, unsigned int cpu)
 {
 	struct nft_pipapo_scratch *s;
-	void *mem;
 
 	s = *per_cpu_ptr(m->scratch, cpu);
-	if (!s)
-		return;
 
-	mem = s;
-	mem -= s->align_off;
-	kvfree(mem);
+	kvfree(s);
 }
 
 /**
@@ -1168,11 +1203,8 @@ static int pipapo_realloc_scratch(struct nft_pipapo_match *clone,
 
 	for_each_possible_cpu(i) {
 		struct nft_pipapo_scratch *scratch;
-#ifdef NFT_PIPAPO_ALIGN
-		void *scratch_aligned;
-		u32 align_off;
-#endif
-		scratch = kvzalloc_node(struct_size(scratch, map, bsize_max * 2) +
+
+		scratch = kvzalloc_node(struct_size(scratch, __map, bsize_max * 2) +
 					NFT_PIPAPO_ALIGN_HEADROOM,
 					GFP_KERNEL_ACCOUNT, cpu_to_node(i));
 		if (!scratch) {
@@ -1187,23 +1219,7 @@ static int pipapo_realloc_scratch(struct nft_pipapo_match *clone,
 		}
 
 		pipapo_free_scratch(clone, i);
-
-#ifdef NFT_PIPAPO_ALIGN
-		/* Align &scratch->map (not the struct itself): the extra
-		 * %NFT_PIPAPO_ALIGN_HEADROOM bytes passed to kzalloc_node()
-		 * above guarantee we can waste up to those bytes in order
-		 * to align the map field regardless of its offset within
-		 * the struct.
-		 */
-		BUILD_BUG_ON(offsetof(struct nft_pipapo_scratch, map) > NFT_PIPAPO_ALIGN_HEADROOM);
-
-		scratch_aligned = NFT_PIPAPO_LT_ALIGN(&scratch->map);
-		scratch_aligned -= offsetof(struct nft_pipapo_scratch, map);
-		align_off = scratch_aligned - (void *)scratch;
-
-		scratch = scratch_aligned;
-		scratch->align_off = align_off;
-#endif
+		local_lock_init(&scratch->bh_lock);
 		*per_cpu_ptr(clone->scratch, i) = scratch;
 	}
 
diff --git a/net/netfilter/nft_set_pipapo.h b/net/netfilter/nft_set_pipapo.h
index 4a2ff85ce1c43..eaab422aa56ab 100644
--- a/net/netfilter/nft_set_pipapo.h
+++ b/net/netfilter/nft_set_pipapo.h
@@ -124,14 +124,14 @@ struct nft_pipapo_field {
 
 /**
  * struct nft_pipapo_scratch - percpu data used for lookup and matching
+ * @bh_lock:    PREEMPT_RT local spinlock
  * @map_index:	Current working bitmap index, toggled between field matches
- * @align_off:	Offset to get the originally allocated address
- * @map:	store partial matching results during lookup
+ * @__map:	store partial matching results during lookup
  */
 struct nft_pipapo_scratch {
+	local_lock_t bh_lock;
 	u8 map_index;
-	u32 align_off;
-	unsigned long map[];
+	unsigned long __map[];
 };
 
 /**
diff --git a/net/netfilter/nft_set_pipapo_avx2.c b/net/netfilter/nft_set_pipapo_avx2.c
index 2f090e253caf7..29326f3fcaf3f 100644
--- a/net/netfilter/nft_set_pipapo_avx2.c
+++ b/net/netfilter/nft_set_pipapo_avx2.c
@@ -1133,66 +1133,50 @@ static inline void pipapo_resmap_init_avx2(const struct nft_pipapo_match *m, uns
 }
 
 /**
- * nft_pipapo_avx2_lookup() - Lookup function for AVX2 implementation
- * @net:	Network namespace
- * @set:	nftables API set representation
- * @key:	nftables API element representation containing key data
+ * pipapo_get_avx2() - Lookup function for AVX2 implementation
+ * @m:		Storage containing the set elements
+ * @data:	Key data to be matched against existing elements
+ * @genmask:	If set, check that element is active in given genmask
+ * @tstamp:	Timestamp to check for expired elements
  *
  * For more details, see DOC: Theory of Operation in nft_set_pipapo.c.
  *
  * This implementation exploits the repetitive characteristic of the algorithm
  * to provide a fast, vectorised version using the AVX2 SIMD instruction set.
  *
- * Return: true on match, false otherwise.
+ * The caller must check that the FPU is usable.
+ * This function must be called with BH disabled.
+ *
+ * Return: pointer to &struct nft_pipapo_elem on match, NULL otherwise.
  */
-const struct nft_set_ext *
-nft_pipapo_avx2_lookup(const struct net *net, const struct nft_set *set,
-		       const u32 *key)
+struct nft_pipapo_elem *pipapo_get_avx2(const struct nft_pipapo_match *m,
+					const u8 *data, u8 genmask,
+					u64 tstamp)
 {
-	struct nft_pipapo *priv = nft_set_priv(set);
-	const struct nft_set_ext *ext = NULL;
 	struct nft_pipapo_scratch *scratch;
-	u8 genmask = nft_genmask_cur(net);
-	const struct nft_pipapo_match *m;
 	const struct nft_pipapo_field *f;
-	const u8 *rp = (const u8 *)key;
-	unsigned long *res, *fill;
+	unsigned long *res, *fill, *map;
 	bool map_index;
 	int i;
 
-	local_bh_disable();
+	scratch = *raw_cpu_ptr(m->scratch);
+	if (unlikely(!scratch))
+		return NULL;
 
-	if (unlikely(!irq_fpu_usable())) {
-		ext = nft_pipapo_lookup(net, set, key);
+	__local_lock_nested_bh(&scratch->bh_lock);
+	map_index = scratch->map_index;
+	map = NFT_PIPAPO_LT_ALIGN(&scratch->__map[0]);
+	res  = map + (map_index ? m->bsize_max : 0);
+	fill = map + (map_index ? 0 : m->bsize_max);
 
-		local_bh_enable();
-		return ext;
-	}
+	pipapo_resmap_init_avx2(m, res);
 
-	m = rcu_dereference(priv->match);
-
-	/* This also protects access to all data related to scratch maps.
-	 *
-	 * Note that we don't need a valid MXCSR state for any of the
+	/* Note that we don't need a valid MXCSR state for any of the
 	 * operations we use here, so pass 0 as mask and spare a LDMXCSR
 	 * instruction.
 	 */
 	kernel_fpu_begin_mask(0);
 
-	scratch = *raw_cpu_ptr(m->scratch);
-	if (unlikely(!scratch)) {
-		kernel_fpu_end();
-		local_bh_enable();
-		return NULL;
-	}
-
-	map_index = scratch->map_index;
-
-	res  = scratch->map + (map_index ? m->bsize_max : 0);
-	fill = scratch->map + (map_index ? 0 : m->bsize_max);
-
-	pipapo_resmap_init_avx2(m, res);
-
 	nft_pipapo_avx2_prepare();
 
 next_match:
@@ -1202,7 +1186,7 @@ nft_pipapo_avx2_lookup(const struct net *net, const struct nft_set *set,
 
 #define NFT_SET_PIPAPO_AVX2_LOOKUP(b, n)				\
 		(ret = nft_pipapo_avx2_lookup_##b##b_##n(res, fill, f,	\
-							 ret, rp,	\
+							 ret, data,	\
 							 first, last))
 
 		if (likely(f->bb == 8)) {
@@ -1218,7 +1202,7 @@ nft_pipapo_avx2_lookup(const struct net *net, const struct nft_set *set,
 				NFT_SET_PIPAPO_AVX2_LOOKUP(8, 16);
 			} else {
 				ret = nft_pipapo_avx2_lookup_slow(m, res, fill, f,
-								  ret, rp,
+								  ret, data,
 								  first, last);
 			}
 		} else {
@@ -1234,7 +1218,7 @@ nft_pipapo_avx2_lookup(const struct net *net, const struct nft_set *set,
 				NFT_SET_PIPAPO_AVX2_LOOKUP(4, 32);
 			} else {
 				ret = nft_pipapo_avx2_lookup_slow(m, res, fill, f,
-								  ret, rp,
+								  ret, data,
 								  first, last);
 			}
 		}
@@ -1242,29 +1226,75 @@ nft_pipapo_avx2_lookup(const struct net *net, const struct nft_set *set,
 
 #undef NFT_SET_PIPAPO_AVX2_LOOKUP
 
-		if (ret < 0)
-			goto out;
-
-		if (last) {
-			const struct nft_set_ext *e = &f->mt[ret].e->ext;
-
-			if (unlikely(nft_set_elem_expired(e) ||
-				     !nft_set_elem_active(e, genmask)))
-				goto next_match;
-
-			ext = e;
-			goto out;
+		if (ret < 0) {
+			scratch->map_index = map_index;
+			kernel_fpu_end();
+			__local_unlock_nested_bh(&scratch->bh_lock);
+			return NULL;
 		}
 
+		if (last) {
+			struct nft_pipapo_elem *e;
+
+			e = f->mt[ret].e;
+			if (unlikely(__nft_set_elem_expired(&e->ext, tstamp) ||
+				     !nft_set_elem_active(&e->ext, genmask)))
+				goto next_match;
+
+			scratch->map_index = map_index;
+			kernel_fpu_end();
+			__local_unlock_nested_bh(&scratch->bh_lock);
+			return e;
+		}
+
+		map_index = !map_index;
 		swap(res, fill);
-		rp += NFT_PIPAPO_GROUPS_PADDED_SIZE(f);
+		data += NFT_PIPAPO_GROUPS_PADDED_SIZE(f);
 	}
 
-out:
-	if (i % 2)
-		scratch->map_index = !map_index;
 	kernel_fpu_end();
+	__local_unlock_nested_bh(&scratch->bh_lock);
+	return NULL;
+}
+
+/**
+ * nft_pipapo_avx2_lookup() - Dataplane frontend for AVX2 implementation
+ * @net:	Network namespace
+ * @set:	nftables API set representation
+ * @key:	nftables API element representation containing key data
+ *
+ * This function is called from the data path.  It will search for
+ * an element matching the given key in the current active copy using
+ * the AVX2 routines if the FPU is usable or fall back to the generic
+ * implementation of the algorithm otherwise.
+ *
+ * Return: nftables API extension pointer or NULL if no match.
+ */
+const struct nft_set_ext *
+nft_pipapo_avx2_lookup(const struct net *net, const struct nft_set *set,
+		       const u32 *key)
+{
+	struct nft_pipapo *priv = nft_set_priv(set);
+	u8 genmask = nft_genmask_cur(net);
+	const struct nft_pipapo_match *m;
+	const u8 *rp = (const u8 *)key;
+	const struct nft_pipapo_elem *e;
+
+	local_bh_disable();
+
+	if (unlikely(!irq_fpu_usable())) {
+		const struct nft_set_ext *ext;
+
+		ext = nft_pipapo_lookup(net, set, key);
+
+		local_bh_enable();
+		return ext;
+	}
+
+	m = rcu_dereference(priv->match);
+
+	e = pipapo_get_avx2(m, rp, genmask, get_jiffies_64());
 	local_bh_enable();
 
-	return ext;
+	return e ? &e->ext : NULL;
 }
diff --git a/net/netfilter/nft_set_pipapo_avx2.h b/net/netfilter/nft_set_pipapo_avx2.h
index dbb6aaca8a7ad..c2999b63da3f3 100644
--- a/net/netfilter/nft_set_pipapo_avx2.h
+++ b/net/netfilter/nft_set_pipapo_avx2.h
@@ -5,8 +5,12 @@
 #include <asm/fpu/xstate.h>
 #define NFT_PIPAPO_ALIGN	(XSAVE_YMM_SIZE / BITS_PER_BYTE)
 
+struct nft_pipapo_match;
 bool nft_pipapo_avx2_estimate(const struct nft_set_desc *desc, u32 features,
 			      struct nft_set_estimate *est);
+struct nft_pipapo_elem *pipapo_get_avx2(const struct nft_pipapo_match *m,
+					const u8 *data, u8 genmask,
+					u64 tstamp);
 #endif /* defined(CONFIG_X86_64) && !defined(CONFIG_UML) */
 
 #endif /* _NFT_SET_PIPAPO_AVX2_H */
