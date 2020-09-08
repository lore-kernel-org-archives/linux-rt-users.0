Return-Path: <SRS0=F8C2=CR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB636C43461
	for <linux-rt-users@archiver.kernel.org>; Tue,  8 Sep 2020 18:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DB2F2078E
	for <linux-rt-users@archiver.kernel.org>; Tue,  8 Sep 2020 18:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zHNLpQss";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0K0mvgMl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbgIHSNu (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 8 Sep 2020 14:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732272AbgIHSNs (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 8 Sep 2020 14:13:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0892DC061573;
        Tue,  8 Sep 2020 11:13:47 -0700 (PDT)
Date:   Tue, 8 Sep 2020 20:13:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599588825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=AZzYnN9/QtRZiqx11rryVRTk4WJFX5kkgNISLws9vZo=;
        b=zHNLpQssBLNr0yqEuPvn6fjb6M39NKxypTZzU4TT5aGGpyLOabyRT0Jt3rKzXEVOwGlMtS
        aA2YxL1JeQfkQDDYVpRAWLt5EoFz3IiZEjApFUDA0ojEzRvgTzfG0uBvLhwN13Vsvd/JI8
        BaDVYl4ewvaDcRBPPC65teDBrI8McNtye6p7Ama3tG4DqqQG9fSmq82oczhk4UzhFGaUvt
        q6o3g8R2v+exKAbYfPc9M3WsExJJlNvVlLYiPt01uvfkX1mrIG1IIhD/u8eVfN9KEvmPcb
        WNyKNkm2ESN+wF55WZ+AWk6r0xtPeu8fLDi6Udmr09UwvZGlLPxXyC35Nfdm6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599588825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=AZzYnN9/QtRZiqx11rryVRTk4WJFX5kkgNISLws9vZo=;
        b=0K0mvgMlq3JBzrdVahJnBbaw8BpEBwPUheC6DViynzZynnEeYEVn9x2sMu5BGvz7yPPyga
        wb/w80DdrTpWSwBQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.9-rc4-rt5
Message-ID: <20200908181344.63orbdw3zom7xpp3@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.9-rc4-rt5 patch set. 

Changes since v5.9-rc4-rt4:

  - A queuing discipline other than pfifo_fast led to a lockdep splat.
    Reported by Mike Galbraith.

  - The series "seqlock: Introduce PREEMPT_RT support" by Ahmed S.
    Darwis has been updated to v2.

  - Added the series "seqlock: Introduce seqcount_latch_t" by Ahmed S.
    Darwis.

Known issues
     - It has been pointed out that due to changes to the printk code the
       internal buffer representation changed. This is only an issue if tools
       like `crash' are used to extract the printk buffer from a kernel memory
       image.

The delta patch against v5.9-rc4-rt4 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.9/incr/patch-5.9-rc4-rt4-rt5.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.9-rc4-rt5

The RT patch against v5.9-rc4 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.9/older/patch-5.9-rc4-rt5.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.9/older/patches-5.9-rc4-rt5.tar.xz

Sebastian

diff --git a/Documentation/locking/seqlock.rst b/Documentation/locking/seqlock.rst
index 62c5ad98c11ca..a334b584f2b34 100644
--- a/Documentation/locking/seqlock.rst
+++ b/Documentation/locking/seqlock.rst
@@ -139,6 +139,24 @@ with the associated LOCKTYPE lock acquired.
 
 Read path: same as in :ref:`seqcount_t`.
 
+
+.. _seqcount_latch_t:
+
+Latch sequence counters (``seqcount_latch_t``)
+----------------------------------------------
+
+Latch sequence counters are a multiversion concurrency control mechanism
+where the embedded seqcount_t counter even/odd value is used to switch
+between two copies of protected data. This allows the sequence counter
+read path to safely interrupt its own write side critical section.
+
+Use seqcount_latch_t when the write side sections cannot be protected
+from interruption by readers. This is typically the case when the read
+side can be invoked from NMI handlers.
+
+Check `raw_write_seqcount_latch()` for more information.
+
+
 .. _seqlock_t:
 
 Sequential locks (``seqlock_t``)
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 49d925043171a..f70dffc2771f5 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -54,7 +54,7 @@ struct clocksource *art_related_clocksource;
 
 struct cyc2ns {
 	struct cyc2ns_data data[2];	/*  0 + 2*16 = 32 */
-	seqcount_t	   seq;		/* 32 + 4    = 36 */
+	seqcount_latch_t   seq;		/* 32 + 4    = 36 */
 
 }; /* fits one cacheline */
 
@@ -73,14 +73,14 @@ __always_inline void cyc2ns_read_begin(struct cyc2ns_data *data)
 	preempt_disable_notrace();
 
 	do {
-		seq = this_cpu_read(cyc2ns.seq.sequence);
+		seq = this_cpu_read(cyc2ns.seq.seqcount.sequence);
 		idx = seq & 1;
 
 		data->cyc2ns_offset = this_cpu_read(cyc2ns.data[idx].cyc2ns_offset);
 		data->cyc2ns_mul    = this_cpu_read(cyc2ns.data[idx].cyc2ns_mul);
 		data->cyc2ns_shift  = this_cpu_read(cyc2ns.data[idx].cyc2ns_shift);
 
-	} while (unlikely(seq != this_cpu_read(cyc2ns.seq.sequence)));
+	} while (unlikely(seq != this_cpu_read(cyc2ns.seq.seqcount.sequence)));
 }
 
 __always_inline void cyc2ns_read_end(void)
@@ -186,7 +186,7 @@ static void __init cyc2ns_init_boot_cpu(void)
 {
 	struct cyc2ns *c2n = this_cpu_ptr(&cyc2ns);
 
-	seqcount_init(&c2n->seq);
+	seqcount_latch_init(&c2n->seq);
 	__set_cyc2ns_scale(tsc_khz, smp_processor_id(), rdtsc());
 }
 
@@ -203,7 +203,7 @@ static void __init cyc2ns_init_secondary_cpus(void)
 
 	for_each_possible_cpu(cpu) {
 		if (cpu != this_cpu) {
-			seqcount_init(&c2n->seq);
+			seqcount_latch_init(&c2n->seq);
 			c2n = per_cpu_ptr(&cyc2ns, cpu);
 			c2n->data[0] = data[0];
 			c2n->data[1] = data[1];
diff --git a/include/linux/rbtree_latch.h b/include/linux/rbtree_latch.h
index 7d012faa509a4..3d1a9e716b803 100644
--- a/include/linux/rbtree_latch.h
+++ b/include/linux/rbtree_latch.h
@@ -42,8 +42,8 @@ struct latch_tree_node {
 };
 
 struct latch_tree_root {
-	seqcount_t	seq;
-	struct rb_root	tree[2];
+	seqcount_latch_t	seq;
+	struct rb_root		tree[2];
 };
 
 /**
@@ -206,7 +206,7 @@ latch_tree_find(void *key, struct latch_tree_root *root,
 	do {
 		seq = raw_read_seqcount_latch(&root->seq);
 		node = __lt_find(key, root, seq & 1, ops->comp);
-	} while (read_seqcount_retry(&root->seq, seq));
+	} while (read_seqcount_latch_retry(&root->seq, seq));
 
 	return node;
 }
diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 75e3a73e27567..f73c7eb68f27c 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -54,7 +54,7 @@
  *
  * If the write serialization mechanism is one of the common kernel
  * locking primitives, use a sequence counter with associated lock
- * (seqcount_LOCKTYPE_t) instead.
+ * (seqcount_LOCKNAME_t) instead.
  *
  * If it's desired to automatically handle the sequence counter writer
  * serialization and non-preemptibility requirements, use a sequential
@@ -118,7 +118,7 @@ static inline void seqcount_lockdep_reader_access(const seqcount_t *s)
 #define SEQCNT_ZERO(name) { .sequence = 0, SEQCOUNT_DEP_MAP_INIT(name) }
 
 /*
- * Sequence counters with associated locks (seqcount_LOCKTYPE_t)
+ * Sequence counters with associated locks (seqcount_LOCKNAME_t)
  *
  * A sequence counter which associates the lock used for writer
  * serialization at initialization time. This enables lockdep to validate
@@ -133,19 +133,19 @@ static inline void seqcount_lockdep_reader_access(const seqcount_t *s)
  */
 
 /*
- * For PREEMPT_RT, seqcount_LOCKTYPE_t write side critical sections cannot
- * disable preemption. It can lead to higher latencies and the write side
+ * For PREEMPT_RT, seqcount_LOCKNAME_t write side critical sections cannot
+ * disable preemption. It can lead to higher latencies, and the write side
  * sections will not be able to acquire locks which become sleeping locks
- * in RT (e.g. spinlock_t).
+ * (e.g. spinlock_t).
  *
- * To remain preemptible while avoiding a possible livelock caused by a
- * reader preempting the write section, use a different technique: detect
- * if a seqcount_LOCKTYPE_t writer is in progress. If that is the case,
- * acquire then release the associated LOCKTYPE writer serialization
- * lock. This will force any possibly preempted writer to make progress
+ * To remain preemptible while avoiding a possible livelock caused by the
+ * reader preempting the writer, use a different technique: let the reader
+ * detect if a seqcount_LOCKNAME_t writer is in progress. If that is the
+ * case, acquire then release the associated LOCKNAME writer serialization
+ * lock. This will allow any possibly-preempted writer to make progress
  * until the end of its writer serialization lock critical section.
  *
- * This lock-unlock technique must be implemented for all PREEMPT_RT
+ * This lock-unlock technique must be implemented for all of PREEMPT_RT
  * sleeping locks.  See Documentation/locking/locktypes.rst
  */
 #if defined(CONFIG_LOCKDEP) || defined(CONFIG_PREEMPT_RT)
@@ -155,54 +155,56 @@ static inline void seqcount_lockdep_reader_access(const seqcount_t *s)
 #endif
 
 /**
- * typedef seqcount_LOCKTYPE_t - sequence counter with associated lock
+ * typedef seqcount_LOCKNAME_t - sequence counter with LOCKNAME associated
  * @seqcount:	The real sequence counter
- * @lock:	Pointer to the associated spinlock
+ * @lock:	Pointer to the associated lock
  *
  * A plain sequence counter with external writer synchronization by
- * LOCKTYPE @lock. The lock is associated to the sequence counter in the
+ * LOCKNAME @lock. The lock is associated to the sequence counter in the
  * static initializer or init function. This enables lockdep to validate
  * that the write side critical section is properly serialized.
  *
- * LOCKTYPE:	raw_spinlock, spinlock, rwlock, mutex, or ww_mutex.
- */
-
-/**
- * seqcount_LOCKTYPE_init() - runtime initializer for seqcount_LOCKTYPE_t
- * @s:		Pointer to the seqcount_LOCKTYPE_t instance
- * @lock:	Pointer to the associated LOCKTYPE
+ * LOCKNAME:	raw_spinlock, spinlock, rwlock, mutex, or ww_mutex.
  */
 
 /*
- * SEQCOUNT_LOCKTYPE() - Instantiate seqcount_LOCKTYPE_t and helpers
- * @locktype:		"LOCKTYPE" part of seqcount_LOCKTYPE_t
- * @locktype_t:		canonical/full LOCKTYPE C data type
+ * seqcount_LOCKNAME_init() - runtime initializer for seqcount_LOCKNAME_t
+ * @s:		Pointer to the seqcount_LOCKNAME_t instance
+ * @lock:	Pointer to the associated lock
+ */
+
+/*
+ * SEQCOUNT_LOCKNAME()	- Instantiate seqcount_LOCKNAME_t and helpers
+ * seqprop_LOCKNAME_*()	- Property accessors for seqcount_LOCKNAME_t
+ *
+ * @lockname:		"LOCKNAME" part of seqcount_LOCKNAME_t
+ * @locktype:		LOCKNAME canonical C data type
  * @preemptible:	preemptibility of above locktype
  * @lockmember:		argument for lockdep_assert_held()
  * @lockbase:		associated lock release function (prefix only)
  * @lock_acquire:	associated lock acquisition function (full call)
  */
-#define SEQCOUNT_LOCKTYPE(locktype, locktype_t, preemptible, lockmember, lockbase, lock_acquire) \
-typedef struct seqcount_##locktype {					\
+#define SEQCOUNT_LOCKNAME(lockname, locktype, preemptible, lockmember, lockbase, lock_acquire) \
+typedef struct seqcount_##lockname {					\
 	seqcount_t		seqcount;				\
-	__SEQ_LOCK(locktype_t	*lock);					\
-} seqcount_##locktype##_t;						\
+	__SEQ_LOCK(locktype	*lock);					\
+} seqcount_##lockname##_t;						\
 									\
 static __always_inline void						\
-seqcount_##locktype##_init(seqcount_##locktype##_t *s, locktype_t *lock)\
+seqcount_##lockname##_init(seqcount_##lockname##_t *s, locktype *lock)	\
 {									\
 	seqcount_init(&s->seqcount);					\
 	__SEQ_LOCK(s->lock = lock);					\
 }									\
 									\
 static __always_inline seqcount_t *					\
-__seqcount_##locktype##_ptr(seqcount_##locktype##_t *s)			\
+__seqprop_##lockname##_ptr(seqcount_##lockname##_t *s)			\
 {									\
 	return &s->seqcount;						\
 }									\
 									\
 static __always_inline unsigned						\
-__seqcount_##locktype##_sequence(const seqcount_##locktype##_t *s)	\
+__seqprop_##lockname##_sequence(const seqcount_##lockname##_t *s)	\
 {									\
 	unsigned seq = READ_ONCE(s->seqcount.sequence);			\
 									\
@@ -211,7 +213,7 @@ __seqcount_##locktype##_sequence(const seqcount_##locktype##_t *s)	\
 									\
 	if (preemptible && unlikely(seq & 1)) {				\
 		__SEQ_LOCK(lock_acquire);				\
-		__SEQ_LOCK(lockbase##_unlock((void *) s->lock));	\
+		__SEQ_LOCK(lockbase##_unlock(s->lock));			\
 									\
 		/*							\
 		 * Re-read the sequence counter since the (possibly	\
@@ -224,13 +226,17 @@ __seqcount_##locktype##_sequence(const seqcount_##locktype##_t *s)	\
 }									\
 									\
 static __always_inline bool						\
-__seqcount_##locktype##_preemptible(seqcount_##locktype##_t *s)		\
+__seqprop_##lockname##_preemptible(const seqcount_##lockname##_t *s)	\
 {									\
-	return preemptible;						\
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))				\
+		return preemptible;					\
+									\
+	/* PREEMPT_RT relies on the above LOCK+UNLOCK */		\
+	return false;							\
 }									\
 									\
 static __always_inline void						\
-__seqcount_##locktype##_assert(seqcount_##locktype##_t *s)		\
+__seqprop_##lockname##_assert(const seqcount_##lockname##_t *s)		\
 {									\
 	__SEQ_LOCK(lockdep_assert_held(lockmember));			\
 }
@@ -239,56 +245,56 @@ __seqcount_##locktype##_assert(seqcount_##locktype##_t *s)		\
  * __seqprop() for seqcount_t
  */
 
-static inline seqcount_t *__seqcount_t_ptr(seqcount_t *s)
+static inline seqcount_t *__seqprop_ptr(seqcount_t *s)
 {
 	return s;
 }
 
-static inline unsigned __seqcount_t_sequence(seqcount_t *s)
+static inline unsigned __seqprop_sequence(const seqcount_t *s)
 {
 	return READ_ONCE(s->sequence);
 }
 
-static inline bool __seqcount_t_preemptible(seqcount_t *s)
+static inline bool __seqprop_preemptible(const seqcount_t *s)
 {
 	return false;
 }
 
-static inline void __seqcount_t_assert(seqcount_t *s)
+static inline void __seqprop_assert(const seqcount_t *s)
 {
 	lockdep_assert_preemption_disabled();
 }
 
 #define __SEQ_RT	IS_ENABLED(CONFIG_PREEMPT_RT)
 
-SEQCOUNT_LOCKTYPE(raw_spinlock, raw_spinlock_t,  false,    s->lock,        raw_spin, raw_spin_lock(s->lock))
-SEQCOUNT_LOCKTYPE(spinlock,     spinlock_t,      __SEQ_RT, s->lock,        spin,     spin_lock(s->lock))
-SEQCOUNT_LOCKTYPE(rwlock,       rwlock_t,        __SEQ_RT, s->lock,        read,     read_lock(s->lock))
-SEQCOUNT_LOCKTYPE(mutex,        struct mutex,    true,     s->lock,        mutex,    mutex_lock(s->lock))
-SEQCOUNT_LOCKTYPE(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mutex, ww_mutex_lock(s->lock, NULL))
+SEQCOUNT_LOCKNAME(raw_spinlock, raw_spinlock_t,  false,    s->lock,        raw_spin, raw_spin_lock(s->lock))
+SEQCOUNT_LOCKNAME(spinlock,     spinlock_t,      __SEQ_RT, s->lock,        spin,     spin_lock(s->lock))
+SEQCOUNT_LOCKNAME(rwlock,       rwlock_t,        __SEQ_RT, s->lock,        read,     read_lock(s->lock))
+SEQCOUNT_LOCKNAME(mutex,        struct mutex,    true,     s->lock,        mutex,    mutex_lock(s->lock))
+SEQCOUNT_LOCKNAME(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mutex, ww_mutex_lock(s->lock, NULL))
 
-/**
- * SEQCNT_LOCKTYPE_ZERO - static initializer for seqcount_LOCKTYPE_t
- * @name:	Name of the seqcount_LOCKTYPE_t instance
- * @lock:	Pointer to the associated LOCKTYPE
+/*
+ * SEQCNT_LOCKNAME_ZERO - static initializer for seqcount_LOCKNAME_t
+ * @name:	Name of the seqcount_LOCKNAME_t instance
+ * @lock:	Pointer to the associated LOCKNAME
  */
 
-#define SEQCOUNT_LOCKTYPE_ZERO(seq_name, assoc_lock) {			\
+#define SEQCOUNT_LOCKNAME_ZERO(seq_name, assoc_lock) {			\
 	.seqcount		= SEQCNT_ZERO(seq_name.seqcount),	\
 	__SEQ_LOCK(.lock	= (assoc_lock))				\
 }
 
-#define SEQCNT_SPINLOCK_ZERO(name, lock)	SEQCOUNT_LOCKTYPE_ZERO(name, lock)
-#define SEQCNT_RAW_SPINLOCK_ZERO(name, lock)	SEQCOUNT_LOCKTYPE_ZERO(name, lock)
-#define SEQCNT_RWLOCK_ZERO(name, lock)		SEQCOUNT_LOCKTYPE_ZERO(name, lock)
-#define SEQCNT_MUTEX_ZERO(name, lock)		SEQCOUNT_LOCKTYPE_ZERO(name, lock)
-#define SEQCNT_WW_MUTEX_ZERO(name, lock) 	SEQCOUNT_LOCKTYPE_ZERO(name, lock)
+#define SEQCNT_SPINLOCK_ZERO(name, lock)	SEQCOUNT_LOCKNAME_ZERO(name, lock)
+#define SEQCNT_RAW_SPINLOCK_ZERO(name, lock)	SEQCOUNT_LOCKNAME_ZERO(name, lock)
+#define SEQCNT_RWLOCK_ZERO(name, lock)		SEQCOUNT_LOCKNAME_ZERO(name, lock)
+#define SEQCNT_MUTEX_ZERO(name, lock)		SEQCOUNT_LOCKNAME_ZERO(name, lock)
+#define SEQCNT_WW_MUTEX_ZERO(name, lock) 	SEQCOUNT_LOCKNAME_ZERO(name, lock)
 
-#define __seqprop_case(s, locktype, prop)				\
-	seqcount_##locktype##_t: __seqcount_##locktype##_##prop((void *)(s))
+#define __seqprop_case(s, lockname, prop)				\
+	seqcount_##lockname##_t: __seqprop_##lockname##_##prop((void *)(s))
 
 #define __seqprop(s, prop) _Generic(*(s),				\
-	seqcount_t:		__seqcount_t_##prop((void *)(s)),	\
+	seqcount_t:		__seqprop_##prop((void *)(s)),		\
 	__seqprop_case((s),	raw_spinlock,	prop),			\
 	__seqprop_case((s),	spinlock,	prop),			\
 	__seqprop_case((s),	rwlock,		prop),			\
@@ -302,7 +308,7 @@ SEQCOUNT_LOCKTYPE(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mu
 
 /**
  * __read_seqcount_begin() - begin a seqcount_t read section w/o barrier
- * @s: Pointer to seqcount_t or any of the seqcount_LOCKTYPE_t variants
+ * @s: Pointer to seqcount_t or any of the seqcount_LOCKNAME_t variants
  *
  * __read_seqcount_begin is like read_seqcount_begin, but has no smp_rmb()
  * barrier. Callers should ensure that smp_rmb() or equivalent ordering is
@@ -316,36 +322,32 @@ SEQCOUNT_LOCKTYPE(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mu
  */
 #define __read_seqcount_begin(s)					\
 ({									\
-	unsigned ret;							\
+	unsigned seq;							\
 									\
-	while (true) {							\
-		ret = __seqcount_sequence(s);				\
-		if (likely(! (ret & 1)))				\
-			break;						\
+	while ((seq = __seqcount_sequence(s)) & 1)			\
 		cpu_relax();						\
-	}								\
 									\
 	kcsan_atomic_next(KCSAN_SEQLOCK_REGION_MAX);			\
-	ret;								\
+	seq;								\
 })
 
 /**
  * raw_read_seqcount_begin() - begin a seqcount_t read section w/o lockdep
- * @s: Pointer to seqcount_t or any of the seqcount_LOCKTYPE_t variants
+ * @s: Pointer to seqcount_t or any of the seqcount_LOCKNAME_t variants
  *
  * Return: count to be passed to read_seqcount_retry()
  */
 #define raw_read_seqcount_begin(s)					\
 ({									\
-	unsigned ret = __read_seqcount_begin(s);			\
+	unsigned seq = __read_seqcount_begin(s);			\
 									\
 	smp_rmb();							\
-	ret;								\
+	seq;								\
 })
 
 /**
  * read_seqcount_begin() - begin a seqcount_t read critical section
- * @s: Pointer to seqcount_t or any of the seqcount_LOCKTYPE_t variants
+ * @s: Pointer to seqcount_t or any of the seqcount_LOCKNAME_t variants
  *
  * Return: count to be passed to read_seqcount_retry()
  */
@@ -357,7 +359,7 @@ SEQCOUNT_LOCKTYPE(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mu
 
 /**
  * raw_read_seqcount() - read the raw seqcount_t counter value
- * @s: Pointer to seqcount_t or any of the seqcount_LOCKTYPE_t variants
+ * @s: Pointer to seqcount_t or any of the seqcount_LOCKNAME_t variants
  *
  * raw_read_seqcount opens a read critical section of the given
  * seqcount_t, without any lockdep checking, and without checking or
@@ -368,17 +370,17 @@ SEQCOUNT_LOCKTYPE(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mu
  */
 #define raw_read_seqcount(s)						\
 ({									\
-	unsigned ret = __seqcount_sequence(s);				\
+	unsigned seq = __seqcount_sequence(s);				\
 									\
 	smp_rmb();							\
 	kcsan_atomic_next(KCSAN_SEQLOCK_REGION_MAX);			\
-	ret;								\
+	seq;								\
 })
 
 /**
  * raw_seqcount_begin() - begin a seqcount_t read critical section w/o
  *                        lockdep and w/o counter stabilization
- * @s: Pointer to seqcount_t or any of the seqcount_LOCKTYPE_t variants
+ * @s: Pointer to seqcount_t or any of the seqcount_LOCKNAME_t variants
  *
  * raw_seqcount_begin opens a read critical section of the given
  * seqcount_t. Unlike read_seqcount_begin(), this function will not wait
@@ -403,7 +405,7 @@ SEQCOUNT_LOCKTYPE(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mu
 
 /**
  * __read_seqcount_retry() - end a seqcount_t read section w/o barrier
- * @s: Pointer to seqcount_t or any of the seqcount_LOCKTYPE_t variants
+ * @s: Pointer to seqcount_t or any of the seqcount_LOCKNAME_t variants
  * @start: count, from read_seqcount_begin()
  *
  * __read_seqcount_retry is like read_seqcount_retry, but has no smp_rmb()
@@ -427,7 +429,7 @@ static inline int __read_seqcount_t_retry(const seqcount_t *s, unsigned start)
 
 /**
  * read_seqcount_retry() - end a seqcount_t read critical section
- * @s: Pointer to seqcount_t or any of the seqcount_LOCKTYPE_t variants
+ * @s: Pointer to seqcount_t or any of the seqcount_LOCKNAME_t variants
  * @start: count, from read_seqcount_begin()
  *
  * read_seqcount_retry closes the read critical section of given
@@ -445,22 +447,13 @@ static inline int read_seqcount_t_retry(const seqcount_t *s, unsigned start)
 	return __read_seqcount_t_retry(s, start);
 }
 
-/*
- * Automatically disable preemption for seqcount_LOCKTYPE_t writers, if the
- * associated lock does not implicitly disable preemption.
- *
- * Don't do it for PREEMPT_RT. Check __SEQ_LOCK() for rationale.
- */
-#define __seq_enforce_preemption_protection(s)				\
-	(!IS_ENABLED(CONFIG_PREEMPT_RT) && __seqcount_lock_preemptible(s))
-
 /**
  * raw_write_seqcount_begin() - start a seqcount_t write section w/o lockdep
- * @s: Pointer to seqcount_t or any of the seqcount_LOCKTYPE_t variants
+ * @s: Pointer to seqcount_t or any of the seqcount_LOCKNAME_t variants
  */
 #define raw_write_seqcount_begin(s)					\
 do {									\
-	if (__seq_enforce_preemption_protection(s))			\
+	if (__seqcount_lock_preemptible(s))				\
 		preempt_disable();					\
 									\
 	raw_write_seqcount_t_begin(__seqcount_ptr(s));			\
@@ -475,13 +468,13 @@ static inline void raw_write_seqcount_t_begin(seqcount_t *s)
 
 /**
  * raw_write_seqcount_end() - end a seqcount_t write section w/o lockdep
- * @s: Pointer to seqcount_t or any of the seqcount_LOCKTYPE_t variants
+ * @s: Pointer to seqcount_t or any of the seqcount_LOCKNAME_t variants
  */
 #define raw_write_seqcount_end(s)					\
 do {									\
 	raw_write_seqcount_t_end(__seqcount_ptr(s));			\
 									\
-	if (__seq_enforce_preemption_protection(s))			\
+	if (__seqcount_lock_preemptible(s))				\
 		preempt_enable();					\
 } while (0)
 
@@ -495,7 +488,7 @@ static inline void raw_write_seqcount_t_end(seqcount_t *s)
 /**
  * write_seqcount_begin_nested() - start a seqcount_t write section with
  *                                 custom lockdep nesting level
- * @s: Pointer to seqcount_t or any of the seqcount_LOCKTYPE_t variants
+ * @s: Pointer to seqcount_t or any of the seqcount_LOCKNAME_t variants
  * @subclass: lockdep nesting level
  *
  * See Documentation/locking/lockdep-design.rst
@@ -504,7 +497,7 @@ static inline void raw_write_seqcount_t_end(seqcount_t *s)
 do {									\
 	__seqcount_assert_lock_held(s);					\
 									\
-	if (__seq_enforce_preemption_protection(s))			\
+	if (__seqcount_lock_preemptible(s))				\
 		preempt_disable();					\
 									\
 	write_seqcount_t_begin_nested(__seqcount_ptr(s), subclass);	\
@@ -518,7 +511,7 @@ static inline void write_seqcount_t_begin_nested(seqcount_t *s, int subclass)
 
 /**
  * write_seqcount_begin() - start a seqcount_t write side critical section
- * @s: Pointer to seqcount_t or any of the seqcount_LOCKTYPE_t variants
+ * @s: Pointer to seqcount_t or any of the seqcount_LOCKNAME_t variants
  *
  * write_seqcount_begin opens a write side critical section of the given
  * seqcount_t.
@@ -531,7 +524,7 @@ static inline void write_seqcount_t_begin_nested(seqcount_t *s, int subclass)
 do {									\
 	__seqcount_assert_lock_held(s);					\
 									\
-	if (__seq_enforce_preemption_protection(s))			\
+	if (__seqcount_lock_preemptible(s))				\
 		preempt_disable();					\
 									\
 	write_seqcount_t_begin(__seqcount_ptr(s));			\
@@ -544,7 +537,7 @@ static inline void write_seqcount_t_begin(seqcount_t *s)
 
 /**
  * write_seqcount_end() - end a seqcount_t write side critical section
- * @s: Pointer to seqcount_t or any of the seqcount_LOCKTYPE_t variants
+ * @s: Pointer to seqcount_t or any of the seqcount_LOCKNAME_t variants
  *
  * The write section must've been opened with write_seqcount_begin().
  */
@@ -552,7 +545,7 @@ static inline void write_seqcount_t_begin(seqcount_t *s)
 do {									\
 	write_seqcount_t_end(__seqcount_ptr(s));			\
 									\
-	if (__seq_enforce_preemption_protection(s))			\
+	if (__seqcount_lock_preemptible(s))				\
 		preempt_enable();					\
 } while (0)
 
@@ -564,7 +557,7 @@ static inline void write_seqcount_t_end(seqcount_t *s)
 
 /**
  * raw_write_seqcount_barrier() - do a seqcount_t write barrier
- * @s: Pointer to seqcount_t or any of the seqcount_LOCKTYPE_t variants
+ * @s: Pointer to seqcount_t or any of the seqcount_LOCKNAME_t variants
  *
  * This can be used to provide an ordering guarantee instead of the usual
  * consistency guarantee. It is one wmb cheaper, because it can collapse
@@ -618,7 +611,7 @@ static inline void raw_write_seqcount_t_barrier(seqcount_t *s)
 /**
  * write_seqcount_invalidate() - invalidate in-progress seqcount_t read
  *                               side operations
- * @s: Pointer to seqcount_t or any of the seqcount_LOCKTYPE_t variants
+ * @s: Pointer to seqcount_t or any of the seqcount_LOCKNAME_t variants
  *
  * After write_seqcount_invalidate, no seqcount_t read side operations
  * will complete successfully and see data older than this.
@@ -634,34 +627,73 @@ static inline void write_seqcount_t_invalidate(seqcount_t *s)
 	kcsan_nestable_atomic_end();
 }
 
-/**
- * raw_read_seqcount_latch() - pick even/odd seqcount_t latch data copy
- * @s: Pointer to seqcount_t or any of the seqcount_LOCKTYPE_t variants
+/*
+ * Latch sequence counters (seqcount_latch_t)
  *
- * Use seqcount_t latching to switch between two storage places protected
- * by a sequence counter. Doing so allows having interruptible, preemptible,
- * seqcount_t write side critical sections.
+ * A sequence counter variant where the counter even/odd value is used to
+ * switch between two copies of protected data. This allows the read path,
+ * typically NMIs, to safely interrupt the write side critical section.
  *
- * Check raw_write_seqcount_latch() for more details and a full reader and
- * writer usage example.
- *
- * Return: sequence counter raw value. Use the lowest bit as an index for
- * picking which data copy to read. The full counter value must then be
- * checked with read_seqcount_retry().
+ * As the write sections are fully preemptible, no special handling for
+ * PREEMPT_RT is needed.
  */
-#define raw_read_seqcount_latch(s)					\
-	raw_read_seqcount_t_latch(__seqcount_ptr(s))
+typedef struct {
+	seqcount_t seqcount;
+} seqcount_latch_t;
 
-static inline int raw_read_seqcount_t_latch(seqcount_t *s)
-{
-	/* Pairs with the first smp_wmb() in raw_write_seqcount_latch() */
-	int seq = READ_ONCE(s->sequence); /* ^^^ */
-	return seq;
+/**
+ * SEQCNT_LATCH_ZERO() - static initializer for seqcount_latch_t
+ * @seq_name: Name of the seqcount_latch_t instance
+ */
+#define SEQCNT_LATCH_ZERO(seq_name) {					\
+	.seqcount		= SEQCNT_ZERO(seq_name.seqcount),	\
 }
 
 /**
- * raw_write_seqcount_latch() - redirect readers to even/odd copy
- * @s: Pointer to seqcount_t or any of the seqcount_LOCKTYPE_t variants
+ * seqcount_latch_init() - runtime initializer for seqcount_latch_t
+ * @s: Pointer to the seqcount_latch_t instance
+ */
+static inline void seqcount_latch_init(seqcount_latch_t *s)
+{
+	seqcount_init(&s->seqcount);
+}
+
+/**
+ * raw_read_seqcount_latch() - pick even/odd latch data copy
+ * @s: Pointer to seqcount_latch_t
+ *
+ * See raw_write_seqcount_latch() for details and a full reader/writer
+ * usage example.
+ *
+ * Return: sequence counter raw value. Use the lowest bit as an index for
+ * picking which data copy to read. The full counter must then be checked
+ * with read_seqcount_latch_retry().
+ */
+static inline unsigned raw_read_seqcount_latch(const seqcount_latch_t *s)
+{
+	/*
+	 * Pairs with the first smp_wmb() in raw_write_seqcount_latch().
+	 * Due to the dependent load, a full smp_rmb() is not needed.
+	 */
+	return READ_ONCE(s->seqcount.sequence);
+}
+
+/**
+ * read_seqcount_latch_retry() - end a seqcount_latch_t read section
+ * @s:		Pointer to seqcount_latch_t
+ * @start:	count, from raw_read_seqcount_latch()
+ *
+ * Return: true if a read section retry is required, else false
+ */
+static inline int
+read_seqcount_latch_retry(const seqcount_latch_t *s, unsigned start)
+{
+	return read_seqcount_retry(&s->seqcount, start);
+}
+
+/**
+ * raw_write_seqcount_latch() - redirect latch readers to even/odd copy
+ * @s: Pointer to seqcount_latch_t
  *
  * The latch technique is a multiversion concurrency control method that allows
  * queries during non-atomic modifications. If you can guarantee queries never
@@ -680,7 +712,7 @@ static inline int raw_read_seqcount_t_latch(seqcount_t *s)
  * The basic form is a data structure like::
  *
  *	struct latch_struct {
- *		seqcount_t		seq;
+ *		seqcount_latch_t	seq;
  *		struct data_struct	data[2];
  *	};
  *
@@ -690,13 +722,13 @@ static inline int raw_read_seqcount_t_latch(seqcount_t *s)
  *	void latch_modify(struct latch_struct *latch, ...)
  *	{
  *		smp_wmb();	// Ensure that the last data[1] update is visible
- *		latch->seq++;
+ *		latch->seq.sequence++;
  *		smp_wmb();	// Ensure that the seqcount update is visible
  *
  *		modify(latch->data[0], ...);
  *
  *		smp_wmb();	// Ensure that the data[0] update is visible
- *		latch->seq++;
+ *		latch->seq.sequence++;
  *		smp_wmb();	// Ensure that the seqcount update is visible
  *
  *		modify(latch->data[1], ...);
@@ -715,8 +747,8 @@ static inline int raw_read_seqcount_t_latch(seqcount_t *s)
  *			idx = seq & 0x01;
  *			entry = data_query(latch->data[idx], ...);
  *
- *		// read_seqcount_retry() includes needed smp_rmb()
- *		} while (read_seqcount_retry(&latch->seq, seq));
+ *		// This includes needed smp_rmb()
+ *		} while (read_seqcount_latch_retry(&latch->seq, seq));
  *
  *		return entry;
  *	}
@@ -735,19 +767,16 @@ static inline int raw_read_seqcount_t_latch(seqcount_t *s)
  *	to miss an entire modification sequence, once it resumes it might
  *	observe the new entry.
  *
- * NOTE:
+ * NOTE2:
  *
  *	When data is a dynamic data structure; one should use regular RCU
  *	patterns to manage the lifetimes of the objects within.
  */
-#define raw_write_seqcount_latch(s)					\
-	raw_write_seqcount_t_latch(__seqcount_ptr(s))
-
-static inline void raw_write_seqcount_t_latch(seqcount_t *s)
+static inline void raw_write_seqcount_latch(seqcount_latch_t *s)
 {
-       smp_wmb();      /* prior stores before incrementing "sequence" */
-       s->sequence++;
-       smp_wmb();      /* increment "sequence" before following stores */
+	smp_wmb();	/* prior stores before incrementing "sequence" */
+	s->seqcount.sequence++;
+	smp_wmb();      /* increment "sequence" before following stores */
 }
 
 /*
diff --git a/include/net/net_seq_lock.h b/include/net/net_seq_lock.h
index 95a497a72e511..67710bace7418 100644
--- a/include/net/net_seq_lock.h
+++ b/include/net/net_seq_lock.h
@@ -6,15 +6,6 @@
 # define net_seq_begin(__r)		read_seqbegin(__r)
 # define net_seq_retry(__r, __s)	read_seqretry(__r, __s)
 
-static inline int try_write_seqlock(seqlock_t *sl)
-{
-	if (spin_trylock(&sl->lock)) {
-		write_seqcount_begin(&sl->seqcount);
-		return 1;
-	}
-	return 0;
-}
-
 #else
 # define net_seqlock_t			seqcount_t
 # define net_seq_begin(__r)		read_seqcount_begin(__r)
diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 796ac453d9519..40be4443b6bdb 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -168,8 +168,16 @@ static inline bool qdisc_run_begin(struct Qdisc *qdisc)
 		return false;
 	}
 #ifdef CONFIG_PREEMPT_RT
-	if (try_write_seqlock(&qdisc->running))
+	if (spin_trylock(&qdisc->running.lock)) {
+		seqcount_t *s = &qdisc->running.seqcount.seqcount;
+		/*
+		 * Variant of write_seqcount_t_begin() telling lockdep that a
+		 * trylock was attempted.
+		 */
+		raw_write_seqcount_t_begin(s);
+		seqcount_acquire(&s->dep_map, 0, 1, _RET_IP_);
 		return true;
+	}
 	return false;
 #else
 	/* Variant of write_seqcount_begin() telling lockdep a trylock
diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
index 1c03eec6ca9b9..0642013dace49 100644
--- a/kernel/time/sched_clock.c
+++ b/kernel/time/sched_clock.c
@@ -35,7 +35,7 @@
  * into a single 64-byte cache line.
  */
 struct clock_data {
-	seqcount_t		seq;
+	seqcount_latch_t	seq;
 	struct clock_read_data	read_data[2];
 	ktime_t			wrap_kt;
 	unsigned long		rate;
@@ -76,7 +76,7 @@ struct clock_read_data *sched_clock_read_begin(unsigned int *seq)
 
 int sched_clock_read_retry(unsigned int seq)
 {
-	return read_seqcount_retry(&cd.seq, seq);
+	return read_seqcount_latch_retry(&cd.seq, seq);
 }
 
 unsigned long long notrace sched_clock(void)
@@ -258,7 +258,7 @@ void __init generic_sched_clock_init(void)
  */
 static u64 notrace suspended_sched_clock_read(void)
 {
-	unsigned int seq = raw_read_seqcount(&cd.seq);
+	unsigned int seq = raw_read_seqcount_latch(&cd.seq);
 
 	return cd.read_data[seq & 1].epoch_cyc;
 }
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 4c47f388a83f1..999c981ae766f 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -64,7 +64,7 @@ static struct timekeeper shadow_timekeeper;
  * See @update_fast_timekeeper() below.
  */
 struct tk_fast {
-	seqcount_raw_spinlock_t	seq;
+	seqcount_latch_t	seq;
 	struct tk_read_base	base[2];
 };
 
@@ -81,13 +81,13 @@ static struct clocksource dummy_clock = {
 };
 
 static struct tk_fast tk_fast_mono ____cacheline_aligned = {
-	.seq     = SEQCNT_RAW_SPINLOCK_ZERO(tk_fast_mono.seq, &timekeeper_lock),
+	.seq     = SEQCNT_LATCH_ZERO(tk_fast_mono.seq),
 	.base[0] = { .clock = &dummy_clock, },
 	.base[1] = { .clock = &dummy_clock, },
 };
 
 static struct tk_fast tk_fast_raw  ____cacheline_aligned = {
-	.seq     = SEQCNT_RAW_SPINLOCK_ZERO(tk_fast_raw.seq, &timekeeper_lock),
+	.seq     = SEQCNT_LATCH_ZERO(tk_fast_raw.seq),
 	.base[0] = { .clock = &dummy_clock, },
 	.base[1] = { .clock = &dummy_clock, },
 };
@@ -467,7 +467,7 @@ static __always_inline u64 __ktime_get_fast_ns(struct tk_fast *tkf)
 					tk_clock_read(tkr),
 					tkr->cycle_last,
 					tkr->mask));
-	} while (read_seqcount_retry(&tkf->seq, seq));
+	} while (read_seqcount_latch_retry(&tkf->seq, seq));
 
 	return now;
 }
@@ -533,7 +533,7 @@ static __always_inline u64 __ktime_get_real_fast_ns(struct tk_fast *tkf)
 					tk_clock_read(tkr),
 					tkr->cycle_last,
 					tkr->mask));
-	} while (read_seqcount_retry(&tkf->seq, seq));
+	} while (read_seqcount_latch_retry(&tkf->seq, seq));
 
 	return now;
 }
diff --git a/localversion-rt b/localversion-rt
index ad3da1bcab7e8..0efe7ba1930e1 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt4
+-rt5
diff --git a/mm/swap.c b/mm/swap.c
index d16d65d9b4e09..a1ec807e325d1 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -763,10 +763,20 @@ static void lru_add_drain_per_cpu(struct work_struct *dummy)
  */
 void lru_add_drain_all(void)
 {
-	static seqcount_t seqcount = SEQCNT_ZERO(seqcount);
-	static DEFINE_MUTEX(lock);
+	/*
+	 * lru_drain_gen - Global pages generation number
+	 *
+	 * (A) Definition: global lru_drain_gen = x implies that all generations
+	 *     0 < n <= x are already *scheduled* for draining.
+	 *
+	 * This is an optimization for the highly-contended use case where a
+	 * user space workload keeps constantly generating a flow of pages for
+	 * each CPU.
+	 */
+	static unsigned int lru_drain_gen;
 	static struct cpumask has_work;
-	int cpu, seq;
+	static DEFINE_MUTEX(lock);
+	unsigned cpu, this_gen;
 
 	/*
 	 * Make sure nobody triggers this path before mm_percpu_wq is fully
@@ -775,21 +785,54 @@ void lru_add_drain_all(void)
 	if (WARN_ON(!mm_percpu_wq))
 		return;
 
-	seq = raw_read_seqcount_latch(&seqcount);
+	/*
+	 * Guarantee pagevec counter stores visible by this CPU are visible to
+	 * other CPUs before loading the current drain generation.
+	 */
+	smp_mb();
+
+	/*
+	 * (B) Locally cache global LRU draining generation number
+	 *
+	 * The read barrier ensures that the counter is loaded before the mutex
+	 * is taken. It pairs with smp_mb() inside the mutex critical section
+	 * at (D).
+	 */
+	this_gen = smp_load_acquire(&lru_drain_gen);
 
 	mutex_lock(&lock);
 
 	/*
-	 * Piggyback on drain started and finished while we waited for lock:
-	 * all pages pended at the time of our enter were drained from vectors.
+	 * (C) Exit the draining operation if a newer generation, from another
+	 * lru_add_drain_all(), was already scheduled for draining. Check (A).
 	 */
-	if (__read_seqcount_retry(&seqcount, seq))
+	if (unlikely(this_gen != lru_drain_gen))
 		goto done;
 
-	raw_write_seqcount_latch(&seqcount);
+	/*
+	 * (D) Increment global generation number
+	 *
+	 * Pairs with smp_load_acquire() at (B), outside of the critical
+	 * section. Use a full memory barrier to guarantee that the new global
+	 * drain generation number is stored before loading pagevec counters.
+	 *
+	 * This pairing must be done here, before the for_each_online_cpu loop
+	 * below which drains the page vectors.
+	 *
+	 * Let x, y, and z represent some system CPU numbers, where x < y < z.
+	 * Assume CPU #z is is in the middle of the for_each_online_cpu loop
+	 * below and has already reached CPU #y's per-cpu data. CPU #x comes
+	 * along, adds some pages to its per-cpu vectors, then calls
+	 * lru_add_drain_all().
+	 *
+	 * If the paired barrier is done at any later step, e.g. after the
+	 * loop, CPU #x will just exit at (C) and miss flushing out all of its
+	 * added pages.
+	 */
+	WRITE_ONCE(lru_drain_gen, lru_drain_gen + 1);
+	smp_mb();
 
 	cpumask_clear(&has_work);
-
 	for_each_online_cpu(cpu) {
 		struct work_struct *work = &per_cpu(lru_add_drain_work, cpu);
 
@@ -801,7 +844,7 @@ void lru_add_drain_all(void)
 		    need_activate_page_drain(cpu)) {
 			INIT_WORK(work, lru_add_drain_per_cpu);
 			queue_work_on(cpu, mm_percpu_wq, work);
-			cpumask_set_cpu(cpu, &has_work);
+			__cpumask_set_cpu(cpu, &has_work);
 		}
 	}
 
@@ -816,7 +859,7 @@ void lru_add_drain_all(void)
 {
 	lru_add_drain();
 }
-#endif
+#endif /* CONFIG_SMP */
 
 /**
  * release_pages - batched put_page()
