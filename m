Return-Path: <SRS0=/68O=4C=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B38C3B1BD
	for <linux-rt-users@archiver.kernel.org>; Fri, 14 Feb 2020 19:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59F5722314
	for <linux-rt-users@archiver.kernel.org>; Fri, 14 Feb 2020 19:33:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729617AbgBNTdn (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 14 Feb 2020 14:33:43 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56097 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729075AbgBNTdn (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 14 Feb 2020 14:33:43 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1j2giV-0005r6-D3; Fri, 14 Feb 2020 20:33:35 +0100
Date:   Fri, 14 Feb 2020 20:33:35 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.4.19-rt11
Message-ID: <20200214193335.h2252qfksprxcxl2@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.4.19-rt11 patch set. 

Changes since v5.4.19-rt10:

  - Interrupts were disabled in the i915 with lockdep-enabled leading to
    warnings. Reported by Fernando Lopez-Lezcano, patch by Mike Galbraith.

  - BPF series by Thomas Gleixner. The series reworks the locking by and
    within BPF which enables its usage on RT.

Known issues
     - None

The delta patch against v5.4.19-rt10 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.4/incr/patch-5.4.19-rt10-rt11.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.4.19-rt11

The RT patch against v5.4.19 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.4/older/patch-5.4.19-rt11.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.4/older/patches-5.4.19-rt11.tar.xz

Sebastian
diff --git a/drivers/gpu/drm/i915/gt/intel_engine_pm.c b/drivers/gpu/drm/i915/gt/intel_engine_pm.c
index 65b5ca74b3947..0e48a3d8ea22c 100644
--- a/drivers/gpu/drm/i915/gt/intel_engine_pm.c
+++ b/drivers/gpu/drm/i915/gt/intel_engine_pm.c
@@ -38,12 +38,15 @@ static int __engine_unpark(struct intel_wakeref *wf)
 }
 
 #if IS_ENABLED(CONFIG_LOCKDEP)
+#include <linux/locallock.h>
+
+static DEFINE_LOCAL_IRQ_LOCK(timeline_lock);
 
 static inline unsigned long __timeline_mark_lock(struct intel_context *ce)
 {
 	unsigned long flags;
 
-	local_irq_save(flags);
+	local_lock_irqsave(timeline_lock, flags);
 	mutex_acquire(&ce->timeline->mutex.dep_map, 2, 0, _THIS_IP_);
 
 	return flags;
@@ -53,7 +56,7 @@ static inline void __timeline_mark_unlock(struct intel_context *ce,
 					  unsigned long flags)
 {
 	mutex_release(&ce->timeline->mutex.dep_map, 0, _THIS_IP_);
-	local_irq_restore(flags);
+	local_unlock_irqrestore(timeline_lock, flags);
 }
 
 #else
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 3bf3835d0e866..3e6744c7122d6 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -541,7 +541,7 @@ int bpf_prog_array_copy(struct bpf_prog_array *old_array,
 		struct bpf_prog *_prog;			\
 		struct bpf_prog_array *_array;		\
 		u32 _ret = 1;				\
-		preempt_disable();			\
+		migrate_disable();			\
 		rcu_read_lock();			\
 		_array = rcu_dereference(array);	\
 		if (unlikely(check_non_null && !_array))\
@@ -554,7 +554,7 @@ int bpf_prog_array_copy(struct bpf_prog_array *old_array,
 		}					\
 _out:							\
 		rcu_read_unlock();			\
-		preempt_enable();			\
+		migrate_enable();			\
 		_ret;					\
 	 })
 
@@ -588,7 +588,7 @@ _out:							\
 		u32 ret;				\
 		u32 _ret = 1;				\
 		u32 _cn = 0;				\
-		preempt_disable();			\
+		migrate_disable();			\
 		rcu_read_lock();			\
 		_array = rcu_dereference(array);	\
 		_item = &_array->items[0];		\
@@ -600,7 +600,7 @@ _out:							\
 			_item++;			\
 		}					\
 		rcu_read_unlock();			\
-		preempt_enable();			\
+		migrate_enable();			\
 		if (_ret)				\
 			_ret = (_cn ? NET_XMIT_CN : NET_XMIT_SUCCESS);	\
 		else					\
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 0367a75f873b6..76ce2dcb52cba 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -555,7 +555,7 @@ DECLARE_STATIC_KEY_FALSE(bpf_stats_enabled_key);
 
 #define BPF_PROG_RUN(prog, ctx)	({				\
 	u32 ret;						\
-	cant_sleep();						\
+	cant_migrate();						\
 	if (static_branch_unlikely(&bpf_stats_enabled_key)) {	\
 		struct bpf_prog_stats *stats;			\
 		u64 start = sched_clock();			\
@@ -570,6 +570,24 @@ DECLARE_STATIC_KEY_FALSE(bpf_stats_enabled_key);
 	}							\
 	ret; })
 
+/*
+ * Use in preemptible and therefore /migratable context to make sure that
+ * the execution of the BPF program runs on one CPU.
+ *
+ * This uses migrate_disable/enable() explicitely to document that the
+ * invocation of a BPF program does not require reentrancy protection
+ * against a BPF program which is invoked from a preempting task.
+ *
+ * For non enabled RT kernels migrate_disable/enable() maps to
+ * preempt_disable/enable(), i.e. it disables also preemption.
+ */
+#define BPF_PROG_RUN_PIN_ON_CPU(prog, ctx) ({				\
+	u32 ret;							\
+	migrate_disable();						\
+	ret = BPF_PROG_RUN(prog, ctx);					\
+	migrate_enable();						\
+	ret; })
+
 #define BPF_SKB_CB_LEN QDISC_CB_PRIV_LEN
 
 struct bpf_skb_data_end {
@@ -647,6 +665,7 @@ static inline u8 *bpf_skb_cb(struct sk_buff *skb)
 	return qdisc_skb_cb(skb)->data;
 }
 
+/* Must be invoked with migration disabled */
 static inline u32 __bpf_prog_run_save_cb(const struct bpf_prog *prog,
 					 struct sk_buff *skb)
 {
@@ -672,9 +691,9 @@ static inline u32 bpf_prog_run_save_cb(const struct bpf_prog *prog,
 {
 	u32 res;
 
-	preempt_disable();
+	migrate_disable();
 	res = __bpf_prog_run_save_cb(prog, skb);
-	preempt_enable();
+	migrate_enable();
 	return res;
 }
 
@@ -687,9 +706,7 @@ static inline u32 bpf_prog_run_clear_cb(const struct bpf_prog *prog,
 	if (unlikely(prog->cb_access))
 		memset(cb_data, 0, BPF_SKB_CB_LEN);
 
-	preempt_disable();
-	res = BPF_PROG_RUN(prog, skb);
-	preempt_enable();
+	res = BPF_PROG_RUN_PIN_ON_CPU(prog, skb);
 	return res;
 }
 
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 2f9abc6aab0be..f5ec1ddbfe070 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -271,6 +271,13 @@ extern void __cant_sleep(const char *file, int line, int preempt_offset);
 
 #define might_sleep_if(cond) do { if (cond) might_sleep(); } while (0)
 
+#ifndef CONFIG_PREEMPT_RT
+# define cant_migrate()		cant_sleep()
+#else
+  /* Placeholder for now */
+# define cant_migrate()		do { } while (0)
+#endif
+
 /**
  * abs - return absolute value of an argument
  * @x: the value.  If it is unsigned type, it is converted to signed type first.
diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index adb085fe31e43..e1aab77564eeb 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -238,8 +238,30 @@ static inline int __migrate_disabled(struct task_struct *p)
 }
 
 #else
-#define migrate_disable()		preempt_disable()
-#define migrate_enable()		preempt_enable()
+/**
+ * migrate_disable - Prevent migration of the current task
+ *
+ * Maps to preempt_disable() which also disables preemption. Use
+ * migrate_disable() to annotate that the intent is to prevent migration
+ * but not necessarily preemption.
+ *
+ * Can be invoked nested like preempt_disable() and needs the corresponding
+ * number of migrate_enable() invocations.
+ */
+#define migrate_disable()	preempt_disable()
+
+/**
+ * migrate_enable - Allow migration of the current task
+ *
+ * Counterpart to migrate_disable().
+ *
+ * As migrate_disable() can be invoked nested only the uttermost invocation
+ * reenables migration.
+ *
+ * Currently mapped to preempt_enable().
+ */
+#define migrate_enable()	preempt_enable()
+
 static inline int __migrate_disabled(struct task_struct *p)
 {
 	return 0;
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 22066a62c8c97..c91ec298decad 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -17,9 +17,62 @@
 	(BPF_F_NO_PREALLOC | BPF_F_NO_COMMON_LRU | BPF_F_NUMA_NODE |	\
 	 BPF_F_ACCESS_MASK | BPF_F_ZERO_SEED)
 
+/*
+ * The bucket lock has two protection scopes:
+ *
+ * 1) Serializing concurrent operations from BPF programs on differrent
+ *    CPUs
+ *
+ * 2) Serializing concurrent operations from BPF programs and sys_bpf()
+ *
+ * BPF programs can execute in any context including perf, kprobes and
+ * tracing. As there are almost no limits where perf, kprobes and tracing
+ * can be invoked from the lock operations need to be protected against
+ * deadlocks. Deadlocks can be caused by recursion and by an invocation in
+ * the lock held section when functions which acquire this lock are invoked
+ * from sys_bpf(). BPF recursion is prevented by incrementing the per CPU
+ * variable bpf_prog_active, which prevents BPF programs attached to perf
+ * events, kprobes and tracing to be invoked before the prior invocation
+ * from one of these contexts completed. sys_bpf() uses the same mechanism
+ * by pinning the task to the current CPU and incrementing the recursion
+ * protection accross the map operation.
+ *
+ * This has subtle implications on PREEMPT_RT. PREEMPT_RT forbids certain
+ * operations like memory allocations (even with GFP_ATOMIC) from atomic
+ * contexts. This is required because even with GFP_ATOMIC the memory
+ * allocator calls into code pathes which acquire locks with long held lock
+ * sections. To ensure the deterministic behaviour these locks are regular
+ * spinlocks, which are converted to 'sleepable' spinlocks on RT. The only
+ * true atomic contexts on an RT kernel are the low level hardware
+ * handling, scheduling, low level interrupt handling, NMIs etc. None of
+ * these contexts should ever do memory allocations.
+ *
+ * As regular device interrupt handlers and soft interrupts are forced into
+ * thread context, the existing code which does
+ *   spin_lock*(); alloc(GPF_ATOMIC); spin_unlock*();
+ * just works.
+ *
+ * In theory the BPF locks could be converted to regular spinlocks as well,
+ * but the bucket locks and percpu_freelist locks can be taken from
+ * arbitrary contexts (perf, kprobes, tracepoints) which are required to be
+ * atomic contexts even on RT. These mechanisms require preallocated maps,
+ * so there is no need to invoke memory allocations within the lock held
+ * sections.
+ *
+ * BPF maps which need dynamic allocation are only used from (forced)
+ * thread context on RT and can therefore use regular spinlocks which in
+ * turn allows to invoke memory allocations from the lock held section.
+ *
+ * On a non RT kernel this distinction is neither possible nor required.
+ * spinlock maps to raw_spinlock and the extra code is optimized out by the
+ * compiler.
+ */
 struct bucket {
 	struct hlist_nulls_head head;
-	raw_spinlock_t lock;
+	union {
+		raw_spinlock_t raw_lock;
+		spinlock_t     lock;
+	};
 };
 
 struct bpf_htab {
@@ -57,6 +110,51 @@ struct htab_elem {
 	char key[0] __aligned(8);
 };
 
+static inline bool htab_is_prealloc(const struct bpf_htab *htab)
+{
+	return !(htab->map.map_flags & BPF_F_NO_PREALLOC);
+}
+
+static inline bool htab_use_raw_lock(const struct bpf_htab *htab)
+{
+	return (!IS_ENABLED(CONFIG_PREEMPT_RT) || htab_is_prealloc(htab));
+}
+
+static void htab_init_buckets(struct bpf_htab *htab)
+{
+	unsigned i;
+
+	for (i = 0; i < htab->n_buckets; i++) {
+		INIT_HLIST_NULLS_HEAD(&htab->buckets[i].head, i);
+		if (htab_use_raw_lock(htab))
+			raw_spin_lock_init(&htab->buckets[i].raw_lock);
+		else
+			spin_lock_init(&htab->buckets[i].lock);
+	}
+}
+
+static inline unsigned long htab_lock_bucket(const struct bpf_htab *htab,
+					     struct bucket *b)
+{
+	unsigned long flags;
+
+	if (htab_use_raw_lock(htab))
+		raw_spin_lock_irqsave(&b->raw_lock, flags);
+	else
+		spin_lock_irqsave(&b->lock, flags);
+	return flags;
+}
+
+static inline void htab_unlock_bucket(const struct bpf_htab *htab,
+				      struct bucket *b,
+				      unsigned long flags)
+{
+	if (htab_use_raw_lock(htab))
+		raw_spin_unlock_irqrestore(&b->raw_lock, flags);
+	else
+		spin_unlock_irqrestore(&b->lock, flags);
+}
+
 static bool htab_lru_map_delete_node(void *arg, struct bpf_lru_node *node);
 
 static bool htab_is_lru(const struct bpf_htab *htab)
@@ -71,11 +169,6 @@ static bool htab_is_percpu(const struct bpf_htab *htab)
 		htab->map.map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH;
 }
 
-static bool htab_is_prealloc(const struct bpf_htab *htab)
-{
-	return !(htab->map.map_flags & BPF_F_NO_PREALLOC);
-}
-
 static inline void htab_elem_set_ptr(struct htab_elem *l, u32 key_size,
 				     void __percpu *pptr)
 {
@@ -306,8 +399,8 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 	bool percpu_lru = (attr->map_flags & BPF_F_NO_COMMON_LRU);
 	bool prealloc = !(attr->map_flags & BPF_F_NO_PREALLOC);
 	struct bpf_htab *htab;
-	int err, i;
 	u64 cost;
+	int err;
 
 	htab = kzalloc(sizeof(*htab), GFP_USER);
 	if (!htab)
@@ -369,10 +462,7 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 	else
 		htab->hashrnd = get_random_int();
 
-	for (i = 0; i < htab->n_buckets; i++) {
-		INIT_HLIST_NULLS_HEAD(&htab->buckets[i].head, i);
-		raw_spin_lock_init(&htab->buckets[i].lock);
-	}
+	htab_init_buckets(htab);
 
 	if (prealloc) {
 		err = prealloc_init(htab);
@@ -580,7 +670,7 @@ static bool htab_lru_map_delete_node(void *arg, struct bpf_lru_node *node)
 	b = __select_bucket(htab, tgt_l->hash);
 	head = &b->head;
 
-	raw_spin_lock_irqsave(&b->lock, flags);
+	flags = htab_lock_bucket(htab, b);
 
 	hlist_nulls_for_each_entry_rcu(l, n, head, hash_node)
 		if (l == tgt_l) {
@@ -588,7 +678,7 @@ static bool htab_lru_map_delete_node(void *arg, struct bpf_lru_node *node)
 			break;
 		}
 
-	raw_spin_unlock_irqrestore(&b->lock, flags);
+	htab_unlock_bucket(htab, b, flags);
 
 	return l == tgt_l;
 }
@@ -668,11 +758,11 @@ static void htab_elem_free_rcu(struct rcu_head *head)
 	 * we're calling kfree, otherwise deadlock is possible if kprobes
 	 * are placed somewhere inside of slub
 	 */
-	preempt_disable();
+	migrate_disable();
 	__this_cpu_inc(bpf_prog_active);
 	htab_elem_free(htab, l);
 	__this_cpu_dec(bpf_prog_active);
-	preempt_enable();
+	migrate_enable();
 }
 
 static void free_htab_elem(struct bpf_htab *htab, struct htab_elem *l)
@@ -862,8 +952,7 @@ static int htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 		 */
 	}
 
-	/* bpf_map_update_elem() can be called in_irq() */
-	raw_spin_lock_irqsave(&b->lock, flags);
+	flags = htab_lock_bucket(htab, b);
 
 	l_old = lookup_elem_raw(head, hash, key, key_size);
 
@@ -904,7 +993,7 @@ static int htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 	}
 	ret = 0;
 err:
-	raw_spin_unlock_irqrestore(&b->lock, flags);
+	htab_unlock_bucket(htab, b, flags);
 	return ret;
 }
 
@@ -942,8 +1031,7 @@ static int htab_lru_map_update_elem(struct bpf_map *map, void *key, void *value,
 		return -ENOMEM;
 	memcpy(l_new->key + round_up(map->key_size, 8), value, map->value_size);
 
-	/* bpf_map_update_elem() can be called in_irq() */
-	raw_spin_lock_irqsave(&b->lock, flags);
+	flags = htab_lock_bucket(htab, b);
 
 	l_old = lookup_elem_raw(head, hash, key, key_size);
 
@@ -962,7 +1050,7 @@ static int htab_lru_map_update_elem(struct bpf_map *map, void *key, void *value,
 	ret = 0;
 
 err:
-	raw_spin_unlock_irqrestore(&b->lock, flags);
+	htab_unlock_bucket(htab, b, flags);
 
 	if (ret)
 		bpf_lru_push_free(&htab->lru, &l_new->lru_node);
@@ -997,8 +1085,7 @@ static int __htab_percpu_map_update_elem(struct bpf_map *map, void *key,
 	b = __select_bucket(htab, hash);
 	head = &b->head;
 
-	/* bpf_map_update_elem() can be called in_irq() */
-	raw_spin_lock_irqsave(&b->lock, flags);
+	flags = htab_lock_bucket(htab, b);
 
 	l_old = lookup_elem_raw(head, hash, key, key_size);
 
@@ -1021,7 +1108,7 @@ static int __htab_percpu_map_update_elem(struct bpf_map *map, void *key,
 	}
 	ret = 0;
 err:
-	raw_spin_unlock_irqrestore(&b->lock, flags);
+	htab_unlock_bucket(htab, b, flags);
 	return ret;
 }
 
@@ -1061,8 +1148,7 @@ static int __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
 			return -ENOMEM;
 	}
 
-	/* bpf_map_update_elem() can be called in_irq() */
-	raw_spin_lock_irqsave(&b->lock, flags);
+	flags = htab_lock_bucket(htab, b);
 
 	l_old = lookup_elem_raw(head, hash, key, key_size);
 
@@ -1084,7 +1170,7 @@ static int __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
 	}
 	ret = 0;
 err:
-	raw_spin_unlock_irqrestore(&b->lock, flags);
+	htab_unlock_bucket(htab, b, flags);
 	if (l_new)
 		bpf_lru_push_free(&htab->lru, &l_new->lru_node);
 	return ret;
@@ -1122,7 +1208,7 @@ static int htab_map_delete_elem(struct bpf_map *map, void *key)
 	b = __select_bucket(htab, hash);
 	head = &b->head;
 
-	raw_spin_lock_irqsave(&b->lock, flags);
+	flags = htab_lock_bucket(htab, b);
 
 	l = lookup_elem_raw(head, hash, key, key_size);
 
@@ -1132,7 +1218,7 @@ static int htab_map_delete_elem(struct bpf_map *map, void *key)
 		ret = 0;
 	}
 
-	raw_spin_unlock_irqrestore(&b->lock, flags);
+	htab_unlock_bucket(htab, b, flags);
 	return ret;
 }
 
@@ -1154,7 +1240,7 @@ static int htab_lru_map_delete_elem(struct bpf_map *map, void *key)
 	b = __select_bucket(htab, hash);
 	head = &b->head;
 
-	raw_spin_lock_irqsave(&b->lock, flags);
+	flags = htab_lock_bucket(htab, b);
 
 	l = lookup_elem_raw(head, hash, key, key_size);
 
@@ -1163,7 +1249,7 @@ static int htab_lru_map_delete_elem(struct bpf_map *map, void *key)
 		ret = 0;
 	}
 
-	raw_spin_unlock_irqrestore(&b->lock, flags);
+	htab_unlock_bucket(htab, b, flags);
 	if (l)
 		bpf_lru_push_free(&htab->lru, &l->lru_node);
 	return ret;
diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
index 56e6c75d354d9..3b3c420bc8ed8 100644
--- a/kernel/bpf/lpm_trie.c
+++ b/kernel/bpf/lpm_trie.c
@@ -34,7 +34,7 @@ struct lpm_trie {
 	size_t				n_entries;
 	size_t				max_prefixlen;
 	size_t				data_size;
-	raw_spinlock_t			lock;
+	spinlock_t			lock;
 };
 
 /* This trie implements a longest prefix match algorithm that can be used to
@@ -315,7 +315,7 @@ static int trie_update_elem(struct bpf_map *map,
 	if (key->prefixlen > trie->max_prefixlen)
 		return -EINVAL;
 
-	raw_spin_lock_irqsave(&trie->lock, irq_flags);
+	spin_lock_irqsave(&trie->lock, irq_flags);
 
 	/* Allocate and fill a new node */
 
@@ -422,7 +422,7 @@ static int trie_update_elem(struct bpf_map *map,
 		kfree(im_node);
 	}
 
-	raw_spin_unlock_irqrestore(&trie->lock, irq_flags);
+	spin_unlock_irqrestore(&trie->lock, irq_flags);
 
 	return ret;
 }
@@ -442,7 +442,7 @@ static int trie_delete_elem(struct bpf_map *map, void *_key)
 	if (key->prefixlen > trie->max_prefixlen)
 		return -EINVAL;
 
-	raw_spin_lock_irqsave(&trie->lock, irq_flags);
+	spin_lock_irqsave(&trie->lock, irq_flags);
 
 	/* Walk the tree looking for an exact key/length match and keeping
 	 * track of the path we traverse.  We will need to know the node
@@ -518,7 +518,7 @@ static int trie_delete_elem(struct bpf_map *map, void *_key)
 	kfree_rcu(node, rcu);
 
 out:
-	raw_spin_unlock_irqrestore(&trie->lock, irq_flags);
+	spin_unlock_irqrestore(&trie->lock, irq_flags);
 
 	return ret;
 }
@@ -575,7 +575,7 @@ static struct bpf_map *trie_alloc(union bpf_attr *attr)
 	if (ret)
 		goto out_err;
 
-	raw_spin_lock_init(&trie->lock);
+	spin_lock_init(&trie->lock);
 
 	return &trie->map;
 out_err:
diff --git a/kernel/bpf/percpu_freelist.c b/kernel/bpf/percpu_freelist.c
index 6e090140b9240..b367430e611c7 100644
--- a/kernel/bpf/percpu_freelist.c
+++ b/kernel/bpf/percpu_freelist.c
@@ -25,12 +25,18 @@ void pcpu_freelist_destroy(struct pcpu_freelist *s)
 	free_percpu(s->freelist);
 }
 
+static inline void pcpu_freelist_push_node(struct pcpu_freelist_head *head,
+					   struct pcpu_freelist_node *node)
+{
+	node->next = head->first;
+	head->first = node;
+}
+
 static inline void ___pcpu_freelist_push(struct pcpu_freelist_head *head,
 					 struct pcpu_freelist_node *node)
 {
 	raw_spin_lock(&head->lock);
-	node->next = head->first;
-	head->first = node;
+	pcpu_freelist_push_node(head, node);
 	raw_spin_unlock(&head->lock);
 }
 
@@ -56,21 +62,16 @@ void pcpu_freelist_populate(struct pcpu_freelist *s, void *buf, u32 elem_size,
 			    u32 nr_elems)
 {
 	struct pcpu_freelist_head *head;
-	unsigned long flags;
 	int i, cpu, pcpu_entries;
 
 	pcpu_entries = nr_elems / num_possible_cpus() + 1;
 	i = 0;
 
-	/* disable irq to workaround lockdep false positive
-	 * in bpf usage pcpu_freelist_populate() will never race
-	 * with pcpu_freelist_push()
-	 */
-	local_irq_save(flags);
 	for_each_possible_cpu(cpu) {
 again:
 		head = per_cpu_ptr(s->freelist, cpu);
-		___pcpu_freelist_push(head, buf);
+		/* No locking required as this is not visible yet. */
+		pcpu_freelist_push_node(head, buf);
 		i++;
 		buf += elem_size;
 		if (i == nr_elems)
@@ -78,7 +79,6 @@ void pcpu_freelist_populate(struct pcpu_freelist *s, void *buf, u32 elem_size,
 		if (i % pcpu_entries)
 			goto again;
 	}
-	local_irq_restore(flags);
 }
 
 struct pcpu_freelist_node *__pcpu_freelist_pop(struct pcpu_freelist *s)
diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 173e983619d77..e753900ff137a 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -40,6 +40,9 @@ static void do_up_read(struct irq_work *entry)
 {
 	struct stack_map_irq_work *work;
 
+	if (WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_RT)))
+		return;
+
 	work = container_of(entry, struct stack_map_irq_work, irq_work);
 	up_read_non_owner(work->sem);
 	work->sem = NULL;
@@ -288,10 +291,18 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
 	struct stack_map_irq_work *work = NULL;
 
 	if (irqs_disabled()) {
-		work = this_cpu_ptr(&up_read_work);
-		if (work->irq_work.flags & IRQ_WORK_BUSY)
-			/* cannot queue more up_read, fallback */
+		if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
+			work = this_cpu_ptr(&up_read_work);
+			if (work->irq_work.flags & IRQ_WORK_BUSY)
+				/* cannot queue more up_read, fallback */
+				irq_work_busy = true;
+		} else {
+			/*
+			 * PREEMPT_RT does not allow to trylock mmap sem in
+			 * interrupt disabled context. Force the fallback code.
+			 */
 			irq_work_busy = true;
+		}
 	}
 
 	/*
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index ace1cfaa24b6b..e773c23b10a4b 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -794,7 +794,7 @@ static int map_lookup_elem(union bpf_attr *attr)
 		goto done;
 	}
 
-	preempt_disable();
+	migrate_disable();
 	this_cpu_inc(bpf_prog_active);
 	if (map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
 	    map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH) {
@@ -837,7 +837,7 @@ static int map_lookup_elem(union bpf_attr *attr)
 		rcu_read_unlock();
 	}
 	this_cpu_dec(bpf_prog_active);
-	preempt_enable();
+	migrate_enable();
 
 done:
 	if (err)
@@ -937,7 +937,7 @@ static int map_update_elem(union bpf_attr *attr)
 	/* must increment bpf_prog_active to avoid kprobe+bpf triggering from
 	 * inside bpf map update or delete otherwise deadlocks are possible
 	 */
-	preempt_disable();
+	migrate_disable();
 	__this_cpu_inc(bpf_prog_active);
 	if (map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
 	    map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH) {
@@ -970,7 +970,7 @@ static int map_update_elem(union bpf_attr *attr)
 		rcu_read_unlock();
 	}
 	__this_cpu_dec(bpf_prog_active);
-	preempt_enable();
+	migrate_enable();
 	maybe_wait_bpf_programs(map);
 out:
 free_value:
@@ -1016,13 +1016,13 @@ static int map_delete_elem(union bpf_attr *attr)
 		goto out;
 	}
 
-	preempt_disable();
+	migrate_disable();
 	__this_cpu_inc(bpf_prog_active);
 	rcu_read_lock();
 	err = map->ops->map_delete_elem(map, key);
 	rcu_read_unlock();
 	__this_cpu_dec(bpf_prog_active);
-	preempt_enable();
+	migrate_enable();
 	maybe_wait_bpf_programs(map);
 out:
 	kfree(key);
diff --git a/kernel/events/core.c b/kernel/events/core.c
index a4ad23064f15e..253bdc106cb8c 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8966,7 +8966,6 @@ static void bpf_overflow_handler(struct perf_event *event,
 	int ret = 0;
 
 	ctx.regs = perf_arch_bpf_user_pt_regs(regs);
-	preempt_disable();
 	if (unlikely(__this_cpu_inc_return(bpf_prog_active) != 1))
 		goto out;
 	rcu_read_lock();
@@ -8974,7 +8973,6 @@ static void bpf_overflow_handler(struct perf_event *event,
 	rcu_read_unlock();
 out:
 	__this_cpu_dec(bpf_prog_active);
-	preempt_enable();
 	if (!ret)
 		return;
 
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 614a557a0814b..25f9e00df9d44 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -267,16 +267,14 @@ static u32 seccomp_run_filters(const struct seccomp_data *sd,
 	 * All filters in the list are evaluated and the lowest BPF return
 	 * value always takes priority (ignoring the DATA).
 	 */
-	preempt_disable();
 	for (; f; f = f->prev) {
-		u32 cur_ret = BPF_PROG_RUN(f->prog, sd);
+		u32 cur_ret = BPF_PROG_RUN_PIN_ON_CPU(f->prog, sd);
 
 		if (ACTION_ONLY(cur_ret) < ACTION_ONLY(ret)) {
 			ret = cur_ret;
 			*match = f;
 		}
 	}
-	preempt_enable();
 	return ret;
 }
 #endif /* CONFIG_SECCOMP_FILTER */
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 89bdac61233db..e80abded7b7af 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -83,7 +83,7 @@ unsigned int trace_call_bpf(struct trace_event_call *call, void *ctx)
 	if (in_nmi()) /* not supported yet */
 		return 1;
 
-	preempt_disable();
+	migrate_disable();
 
 	if (unlikely(__this_cpu_inc_return(bpf_prog_active) != 1)) {
 		/*
@@ -115,7 +115,7 @@ unsigned int trace_call_bpf(struct trace_event_call *call, void *ctx)
 
  out:
 	__this_cpu_dec(bpf_prog_active);
-	preempt_enable();
+	migrate_enable();
 
 	return ret;
 }
@@ -1330,9 +1330,7 @@ static __always_inline
 void __bpf_trace_run(struct bpf_prog *prog, u64 *args)
 {
 	rcu_read_lock();
-	preempt_disable();
 	(void) BPF_PROG_RUN(prog, args);
-	preempt_enable();
 	rcu_read_unlock();
 }
 
diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index 5ef3eccee27cb..07b37fea141d9 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -6660,14 +6660,14 @@ static int __run_one(const struct bpf_prog *fp, const void *data,
 	u64 start, finish;
 	int ret = 0, i;
 
-	preempt_disable();
+	migrate_disable();
 	start = ktime_get_ns();
 
 	for (i = 0; i < runs; i++)
 		ret = BPF_PROG_RUN(fp, data);
 
 	finish = ktime_get_ns();
-	preempt_enable();
+	migrate_enable();
 
 	*duration = finish - start;
 	do_div(*duration, runs);
diff --git a/localversion-rt b/localversion-rt
index d79dde624aaac..05c35cb580779 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt10
+-rt11
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 1153bbcdff721..cccd66cac3c1e 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -37,7 +37,7 @@ static int bpf_test_run(struct bpf_prog *prog, void *ctx, u32 repeat,
 		repeat = 1;
 
 	rcu_read_lock();
-	preempt_disable();
+	migrate_disable();
 	time_start = ktime_get_ns();
 	for (i = 0; i < repeat; i++) {
 		bpf_cgroup_storage_set(storage);
@@ -50,18 +50,18 @@ static int bpf_test_run(struct bpf_prog *prog, void *ctx, u32 repeat,
 
 		if (need_resched()) {
 			time_spent += ktime_get_ns() - time_start;
-			preempt_enable();
+			migrate_enable();
 			rcu_read_unlock();
 
 			cond_resched();
 
 			rcu_read_lock();
-			preempt_disable();
+			migrate_disable();
 			time_start = ktime_get_ns();
 		}
 	}
 	time_spent += ktime_get_ns() - time_start;
-	preempt_enable();
+	migrate_enable();
 	rcu_read_unlock();
 
 	do_div(time_spent, repeat);
diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 96b2566c298dd..7e2ae105d3b9d 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -844,9 +844,7 @@ bool bpf_flow_dissect(struct bpf_prog *prog, struct bpf_flow_dissector *ctx,
 		     (int)FLOW_DISSECTOR_F_STOP_AT_ENCAP);
 	flow_keys->flags = flags;
 
-	preempt_disable();
-	result = BPF_PROG_RUN(prog, ctx);
-	preempt_enable();
+	result = BPF_PROG_RUN_PIN_ON_CPU(prog, ctx);
 
 	flow_keys->nhoff = clamp_t(u16, flow_keys->nhoff, nhoff, hlen);
 	flow_keys->thoff = clamp_t(u16, flow_keys->thoff,
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index ded2d52276786..47e6af669d592 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -628,7 +628,6 @@ int sk_psock_msg_verdict(struct sock *sk, struct sk_psock *psock,
 	struct bpf_prog *prog;
 	int ret;
 
-	preempt_disable();
 	rcu_read_lock();
 	prog = READ_ONCE(psock->progs.msg_parser);
 	if (unlikely(!prog)) {
@@ -638,7 +637,7 @@ int sk_psock_msg_verdict(struct sock *sk, struct sk_psock *psock,
 
 	sk_msg_compute_data_pointers(msg);
 	msg->sk = sk;
-	ret = BPF_PROG_RUN(prog, msg);
+	ret = BPF_PROG_RUN_PIN_ON_CPU(prog, msg);
 	ret = sk_psock_map_verd(ret, msg->sk_redir);
 	psock->apply_bytes = msg->apply_bytes;
 	if (ret == __SK_REDIRECT) {
@@ -653,7 +652,6 @@ int sk_psock_msg_verdict(struct sock *sk, struct sk_psock *psock,
 	}
 out:
 	rcu_read_unlock();
-	preempt_enable();
 	return ret;
 }
 EXPORT_SYMBOL_GPL(sk_psock_msg_verdict);
@@ -665,9 +663,7 @@ static int sk_psock_bpf_run(struct sk_psock *psock, struct bpf_prog *prog,
 
 	skb->sk = psock->sk;
 	bpf_compute_data_end_sk_skb(skb);
-	preempt_disable();
-	ret = BPF_PROG_RUN(prog, skb);
-	preempt_enable();
+	ret = BPF_PROG_RUN_PIN_ON_CPU(prog, skb);
 	/* strparser clones the skb before handing it to a upper layer,
 	 * meaning skb_orphan has been called. We NULL sk on the way out
 	 * to ensure we don't trigger a BUG_ON() in skb/sk operations
diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index ea9e73428ed9c..4906c8f043afb 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -380,9 +380,7 @@ static int kcm_parse_func_strparser(struct strparser *strp, struct sk_buff *skb)
 	struct bpf_prog *prog = psock->bpf_prog;
 	int res;
 
-	preempt_disable();
-	res = BPF_PROG_RUN(prog, skb);
-	preempt_enable();
+	res = BPF_PROG_RUN_PIN_ON_CPU(prog, skb);
 	return res;
 }
 
