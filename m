Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE8CFC4338F
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Aug 2021 16:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D4CC60FC3
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Aug 2021 16:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239550AbhHDQue (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 4 Aug 2021 12:50:34 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37082 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbhHDQuc (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 4 Aug 2021 12:50:32 -0400
Date:   Wed, 4 Aug 2021 18:50:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628095818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=tVd70eF6NLba+68AmdFY6c+xF7prcEQdaIe7+uZfyXA=;
        b=iOO2k1UKRISm+IoYZ3nvpo7sxvQMKzJzZBqx6IJu4xJURFcDGVlrad79+ZaieWH8tEy7vU
        OVK0xwCUP619f1nrPt80HSw86Rhh5d66z/vGRBrXF2+87RT9BDn1D9W4gd0wUw+3x26zQ9
        49nBsCueWE7VbUdP3i9cnWyLo6uMG+2q4qwBJwV+WEy3jpassWQboYPTNrNEuwsKZySzN+
        NAC4f0FcXFdLciM4t2c3GnBGxPfe23Nk+1rXUk5SybynwfcvAfw9Kr7uLqvLRbjeXxr/1Y
        7NqziWrgeq9RKkUFZnk0atSKqZhRP7jcAy1GoHQhmSIIYMHLqsHG7IDkEr/JVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628095818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=tVd70eF6NLba+68AmdFY6c+xF7prcEQdaIe7+uZfyXA=;
        b=v+VIvASqgBO6kE6aNAwTM7HmmSp+v+Qdni+qAa6HV6e9nQKgUq6cYgEjRRxBhV4oIkt9qQ
        wb4UjeIQ0YJpLvBg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.14-rc4-rt5
Message-ID: <20210804165017.nizmbj3m7hkqzqop@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.14-rc4-rt5 patch set. 

Changes since v5.14-rc4-rt4:

  - The locking bits haven been updated (Thomas Gleixner addressed Peter
    Zijlstra's review comments).

  - Daniel Wagner reported a warning in the block/fs-wq code. Patch by
    Jens Axboe.

Known issues
     - netconsole triggers WARN.

     - The "Memory controller" (CONFIG_MEMCG) has been disabled.

     - A RCU and ARM64 warning has been fixed by Valentin Schneider. It is
       still not clear if the RCU related change is correct.

The delta patch against v5.14-rc4-rt4 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.14/incr/patch-5.14-rc4-rt4-rt5.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.14-rc4-rt5

The RT patch against v5.14-rc4 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.14/older/patch-5.14-rc4-rt5.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.14/older/patches-5.14-rc4-rt5.tar.xz

Sebastian

diff --git a/fs/io-wq.c b/fs/io-wq.c
index cf086b01c6c67..0b931ac3c83e6 100644
--- a/fs/io-wq.c
+++ b/fs/io-wq.c
@@ -51,6 +51,10 @@ struct io_worker {
 
 	struct completion ref_done;
 
+	unsigned long create_state;
+	struct callback_head create_work;
+	int create_index;
+
 	struct rcu_head rcu;
 };
 
@@ -261,42 +265,46 @@ static void io_wqe_inc_running(struct io_worker *worker)
 	atomic_inc(&acct->nr_running);
 }
 
-struct create_worker_data {
-	struct callback_head work;
-	struct io_wqe *wqe;
-	int index;
-};
-
 static void create_worker_cb(struct callback_head *cb)
 {
-	struct create_worker_data *cwd;
+	struct io_worker *worker;
 	struct io_wq *wq;
 
-	cwd = container_of(cb, struct create_worker_data, work);
-	wq = cwd->wqe->wq;
-	create_io_worker(wq, cwd->wqe, cwd->index);
-	kfree(cwd);
+	worker = container_of(cb, struct io_worker, create_work);
+	wq = worker->wqe->wq;
+	create_io_worker(wq, worker->wqe, worker->create_index);
+	clear_bit_unlock(0, &worker->create_state);
+	io_worker_release(worker);
 }
 
-static void io_queue_worker_create(struct io_wqe *wqe, struct io_wqe_acct *acct)
+static void io_queue_worker_create(struct io_wqe *wqe, struct io_worker *worker,
+				   struct io_wqe_acct *acct)
 {
-	struct create_worker_data *cwd;
 	struct io_wq *wq = wqe->wq;
 
 	/* raced with exit, just ignore create call */
 	if (test_bit(IO_WQ_BIT_EXIT, &wq->state))
 		goto fail;
+	if (!io_worker_get(worker))
+		goto fail;
+	/*
+	 * create_state manages ownership of create_work/index. We should
+	 * only need one entry per worker, as the worker going to sleep
+	 * will trigger the condition, and waking will clear it once it
+	 * runs the task_work.
+	 */
+	if (test_bit(0, &worker->create_state) ||
+	    test_and_set_bit_lock(0, &worker->create_state))
+		goto fail_release;
 
-	cwd = kmalloc(sizeof(*cwd), GFP_ATOMIC);
-	if (cwd) {
-		init_task_work(&cwd->work, create_worker_cb);
-		cwd->wqe = wqe;
-		cwd->index = acct->index;
-		if (!task_work_add(wq->task, &cwd->work, TWA_SIGNAL))
-			return;
+	init_task_work(&worker->create_work, create_worker_cb);
+	worker->create_index = acct->index;
+	if (!task_work_add(wq->task, &worker->create_work, TWA_SIGNAL))
+		return;
 
-		kfree(cwd);
-	}
+	clear_bit_unlock(0, &worker->create_state);
+fail_release:
+	io_worker_release(worker);
 fail:
 	atomic_dec(&acct->nr_running);
 	io_worker_ref_put(wq);
@@ -314,7 +322,7 @@ static void io_wqe_dec_running(struct io_worker *worker)
 	if (atomic_dec_and_test(&acct->nr_running) && io_wqe_run_queue(wqe)) {
 		atomic_inc(&acct->nr_running);
 		atomic_inc(&wqe->wq->worker_refs);
-		io_queue_worker_create(wqe, acct);
+		io_queue_worker_create(wqe, worker, acct);
 	}
 }
 
@@ -376,7 +384,7 @@ static void io_wait_on_hash(struct io_wqe *wqe, unsigned int hash)
 {
 	struct io_wq *wq = wqe->wq;
 
-	spin_lock(&wq->hash->wait.lock);
+	spin_lock_irq(&wq->hash->wait.lock);
 	if (list_empty(&wqe->wait.entry)) {
 		__add_wait_queue(&wq->hash->wait, &wqe->wait);
 		if (!test_bit(hash, &wq->hash->map)) {
@@ -384,7 +392,7 @@ static void io_wait_on_hash(struct io_wqe *wqe, unsigned int hash)
 			list_del_init(&wqe->wait.entry);
 		}
 	}
-	spin_unlock(&wq->hash->wait.lock);
+	spin_unlock_irq(&wq->hash->wait.lock);
 }
 
 static struct io_wq_work *io_get_next_work(struct io_wqe *wqe)
@@ -422,9 +430,9 @@ static struct io_wq_work *io_get_next_work(struct io_wqe *wqe)
 	}
 
 	if (stall_hash != -1U) {
-		raw_spin_unlock(&wqe->lock);
+		raw_spin_unlock_irq(&wqe->lock);
 		io_wait_on_hash(wqe, stall_hash);
-		raw_spin_lock(&wqe->lock);
+		raw_spin_lock_irq(&wqe->lock);
 	}
 
 	return NULL;
@@ -973,12 +981,12 @@ struct io_wq *io_wq_create(unsigned bounded, struct io_wq_data *data)
 
 static bool io_task_work_match(struct callback_head *cb, void *data)
 {
-	struct create_worker_data *cwd;
+	struct io_worker *worker;
 
 	if (cb->func != create_worker_cb)
 		return false;
-	cwd = container_of(cb, struct create_worker_data, work);
-	return cwd->wqe->wq == data;
+	worker = container_of(cb, struct io_worker, create_work);
+	return worker->wqe->wq == data;
 }
 
 void io_wq_exit_start(struct io_wq *wq)
@@ -995,12 +1003,13 @@ static void io_wq_exit_workers(struct io_wq *wq)
 		return;
 
 	while ((cb = task_work_cancel_match(wq->task, io_task_work_match, wq)) != NULL) {
-		struct create_worker_data *cwd;
+		struct io_worker *worker;
 
-		cwd = container_of(cb, struct create_worker_data, work);
-		atomic_dec(&cwd->wqe->acct[cwd->index].nr_running);
+		worker = container_of(cb, struct io_worker, create_work);
+		atomic_dec(&worker->wqe->acct[worker->create_index].nr_running);
 		io_worker_ref_put(wq);
-		kfree(cwd);
+		clear_bit_unlock(0, &worker->create_state);
+		io_worker_release(worker);
 	}
 
 	rcu_read_lock();
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 95ece02529e29..d3daccb0097ea 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -119,8 +119,6 @@ struct task_group;
 
 #define task_is_stopped(task)		((READ_ONCE(task->__state) & __TASK_STOPPED) != 0)
 
-#ifdef CONFIG_DEBUG_ATOMIC_SLEEP
-
 /*
  * Special states are those that do not use the normal wait-loop pattern. See
  * the comment with set_special_state().
@@ -128,51 +126,36 @@ struct task_group;
 #define is_special_task_state(state)				\
 	((state) & (__TASK_STOPPED | __TASK_TRACED | TASK_PARKED | TASK_DEAD))
 
-#define __set_current_state(state_value)			\
-	do {							\
-		WARN_ON_ONCE(is_special_task_state(state_value));\
-		current->task_state_change = _THIS_IP_;		\
-		WRITE_ONCE(current->__state, (state_value));	\
-	} while (0)
-
-#define set_current_state(state_value)				\
-	do {							\
-		WARN_ON_ONCE(is_special_task_state(state_value));\
-		current->task_state_change = _THIS_IP_;		\
-		smp_store_mb(current->__state, (state_value));	\
-	} while (0)
-
-#define set_special_state(state_value)					\
+#ifdef CONFIG_DEBUG_ATOMIC_SLEEP
+# debug_normal_state_change(state_value)				\
+	do {								\
+		WARN_ON_ONCE(is_special_task_state(state_value));	\
+		current->task_state_change = _THIS_IP_;			\
+	} while (0)
+
+# debug_special_state_change(state_value)				\
 	do {								\
-		unsigned long flags; /* may shadow */			\
 		WARN_ON_ONCE(!is_special_task_state(state_value));	\
-		raw_spin_lock_irqsave(&current->pi_lock, flags);	\
 		current->task_state_change = _THIS_IP_;			\
-		WRITE_ONCE(current->__state, (state_value));		\
-		raw_spin_unlock_irqrestore(&current->pi_lock, flags);	\
 	} while (0)
 
-
-#define current_save_and_set_rtlock_wait_state()			\
-	do {								\
-		raw_spin_lock(&current->pi_lock);			\
-		current->saved_state = current->__state;		\
+# debug_rtlock_wait_set_state()						 \
+	do {								 \
 		current->saved_state_change = current->task_state_change;\
-		current->task_state_change = _THIS_IP_;			\
-		WRITE_ONCE(current->__state, TASK_RTLOCK_WAIT);		\
-		raw_spin_unlock(&current->pi_lock);			\
-	} while (0);
+		current->task_state_change = _THIS_IP_;			 \
+	} while (0)
 
-#define current_restore_rtlock_saved_state()				\
-	do {								\
-		raw_spin_lock(&current->pi_lock);			\
+# debug_rtlock_wait_restore_state()					 \
+	do {								 \
 		current->task_state_change = current->saved_state_change;\
-		WRITE_ONCE(current->__state, current->saved_state);	\
-		current->saved_state = TASK_RUNNING;			\
-		raw_spin_unlock(&current->pi_lock);			\
-	} while (0);
-
+	} while (0)
 #else
+# debug_normal_state_change(cond)	do { } while (0)
+# debug_special_state_change(cond)	do { } while (0)
+# debug_rtlock_wait_set_state()		do { } while (0)
+# debug_rtlock_wait_restore_state()	do { } while (0)
+#endif
+
 /*
  * set_current_state() includes a barrier so that the write of current->state
  * is correctly serialised wrt the caller's subsequent test of whether to
@@ -211,21 +194,29 @@ struct task_group;
  * Also see the comments of try_to_wake_up().
  */
 #define __set_current_state(state_value)				\
-	WRITE_ONCE(current->__state, (state_value))
+	do {								\
+		debug_normal_state_change((state_value));		\
+		WRITE_ONCE(current->__state, (state_value));		\
+	} while (0)
 
 #define set_current_state(state_value)					\
-	smp_store_mb(current->__state, (state_value))
+	do {								\
+		debug_normal_state_change((state_value));		\
+		smp_store_mb(current->__state, (state_value));		\
+	} while (0)
 
 /*
  * set_special_state() should be used for those states when the blocking task
  * can not use the regular condition based wait-loop. In that case we must
- * serialize against wakeups such that any possible in-flight TASK_RUNNING stores
- * will not collide with our state change.
+ * serialize against wakeups such that any possible in-flight TASK_RUNNING
+ * stores will not collide with our state change.
  */
 #define set_special_state(state_value)					\
 	do {								\
 		unsigned long flags; /* may shadow */			\
+									\
 		raw_spin_lock_irqsave(&current->pi_lock, flags);	\
+		debug_special_state_change((state_value));		\
 		WRITE_ONCE(current->__state, (state_value));		\
 		raw_spin_unlock_irqrestore(&current->pi_lock, flags);	\
 	} while (0)
@@ -257,22 +248,24 @@ struct task_group;
  */
 #define current_save_and_set_rtlock_wait_state()			\
 	do {								\
+		lockdep_assert_irqs_disabled();				\
 		raw_spin_lock(&current->pi_lock);			\
 		current->saved_state = current->__state;		\
+		debug_rtlock_wait_set_state();				\
 		WRITE_ONCE(current->__state, TASK_RTLOCK_WAIT);		\
 		raw_spin_unlock(&current->pi_lock);			\
 	} while (0);
 
 #define current_restore_rtlock_saved_state()				\
 	do {								\
+		lockdep_assert_irqs_disabled();				\
 		raw_spin_lock(&current->pi_lock);			\
+		debug_rtlock_wait_restore_state();			\
 		WRITE_ONCE(current->__state, current->saved_state);	\
 		current->saved_state = TASK_RUNNING;			\
 		raw_spin_unlock(&current->pi_lock);			\
 	} while (0);
 
-#endif
-
 #define get_current_state()	READ_ONCE(current->__state)
 
 /* Task command name length: */
diff --git a/kernel/futex.c b/kernel/futex.c
index c4e28bd37abcb..c05a33a2f865c 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -227,10 +227,62 @@ struct futex_q {
 #endif
 } __randomize_layout;
 
+/*
+ * On PREEMPT_RT, the hash bucket lock is a 'sleeping' spinlock with an
+ * underlying rtmutex. The task which is about to be requeued could have
+ * just woken up (timeout, signal). After the wake up the task has to
+ * acquire hash bucket lock, which is held by the requeue code.  As a task
+ * can only be blocked on _ONE_ rtmutex at a time, the proxy lock blocking
+ * and the hash bucket lock blocking would collide and corrupt state.
+ *
+ * On !PREEMPT_RT this is not a problem and everything could be serialized
+ * on hash bucket lock, but aside of having the benefit of common code,
+ * this allows to avoid doing the requeue when the task is already on the
+ * way out and taking the hash bucket lock of the original uaddr1 when the
+ * requeue has been completed.
+ *
+ * The following state transitions are valid:
+ *
+ * On the waiter side:
+ *   Q_REQUEUE_PI_NONE		-> Q_REQUEUE_PI_IGNORE
+ *   Q_REQUEUE_PI_IN_PROGRESS	-> Q_REQUEUE_PI_WAIT
+ *
+ * On the requeue side:
+ *   Q_REQUEUE_PI_NONE		-> Q_REQUEUE_PI_INPROGRESS
+ *   Q_REQUEUE_PI_IN_PROGRESS	-> Q_REQUEUE_PI_DONE/LOCKED
+ *   Q_REQUEUE_PI_IN_PROGRESS	-> Q_REQUEUE_PI_NONE (requeue failed)
+ *   Q_REQUEUE_PI_WAIT		-> Q_REQUEUE_PI_DONE/LOCKED
+ *   Q_REQUEUE_PI_WAIT		-> Q_REQUEUE_PI_IGNORE (requeue failed)
+ *
+ * The requeue side ignores a waiter with state Q_REQUEUE_PI_IGNORE as this
+ * signals that the waiter is already on the way out. It also means that
+ * the waiter is still on the 'wait' futex, i.e. uaddr1.
+ *
+ * The waiter side signals early wakeup to the requeue side either through
+ * setting state to Q_REQUEUE_PI_IGNORE or to Q_REQUEUE_PI_WAIT depending
+ * on the current state. In case of Q_REQUEUE_PI_IGNORE it can immediately
+ * proceed to take the hash bucket lock of uaddr1. If it set state to WAIT,
+ * which means the wakeup is interleaving with a requeue in progress it has
+ * to wait for the requeue side to change the state. Either to DONE/LOCKED
+ * or to IGNORE. DONE/LOCKED means the waiter q is now on the uaddr2 futex
+ * and either blocked (DONE) or has acquired it (LOCKED). IGNORE is set by
+ * the requeue side when the requeue attempt failed via deadlock detection
+ * and therefore the waiter q is still on the uaddr1 futex.
+ */
+enum {
+	Q_REQUEUE_PI_NONE		=  0,
+	Q_REQUEUE_PI_IGNORE,
+	Q_REQUEUE_PI_IN_PROGRESS,
+	Q_REQUEUE_PI_WAIT,
+	Q_REQUEUE_PI_DONE,
+	Q_REQUEUE_PI_LOCKED,
+};
+
 static const struct futex_q futex_q_init = {
 	/* list gets initialized in queue_me()*/
-	.key = FUTEX_KEY_INIT,
-	.bitset = FUTEX_BITSET_MATCH_ANY
+	.key		= FUTEX_KEY_INIT,
+	.bitset		= FUTEX_BITSET_MATCH_ANY,
+	.requeue_state	= ATOMIC_INIT(Q_REQUEUE_PI_NONE),
 };
 
 /*
@@ -1799,57 +1851,6 @@ void requeue_futex(struct futex_q *q, struct futex_hash_bucket *hb1,
 	q->key = *key2;
 }
 
-/*
- * On PREEMPT_RT, the hash bucket lock is a 'sleeping' spinlock with an
- * underlying rtmutex. The task which is about to be requeued could have
- * just woken up (timeout, signal). After the wake up the task has to
- * acquire hash bucket lock, which is held by the requeue code.  As a task
- * can only be blocked on _ONE_ rtmutex at a time, the proxy lock blocking
- * and the hash bucket lock blocking would collide and corrupt state.
- *
- * On !PREEMPT_RT this is not a problem and everything could be serialized
- * on hash bucket lock, but aside of having the benefit of common code,
- * this allows to avoid doing the requeue when the task is already on the
- * way out and taking the hash bucket lock of the original uaddr1 when the
- * requeue has been completed.
- *
- * The following state transitions are valid:
- *
- * On the waiter side:
- *   Q_REQUEUE_PI_NONE		-> Q_REQUEUE_PI_IGNORE
- *   Q_REQUEUE_PI_IN_PROGRESS	-> Q_REQUEUE_PI_WAIT
- *
- * On the requeue side:
- *   Q_REQUEUE_PI_NONE		-> Q_REQUEUE_PI_INPROGRESS
- *   Q_REQUEUE_PI_IN_PROGRESS	-> Q_REQUEUE_PI_DONE/LOCKED
- *   Q_REQUEUE_PI_IN_PROGRESS	-> Q_REQUEUE_PI_NONE (requeue failed)
- *   Q_REQUEUE_PI_WAIT		-> Q_REQUEUE_PI_DONE/LOCKED
- *   Q_REQUEUE_PI_WAIT		-> Q_REQUEUE_PI_IGNORE (requeue failed)
- *
- * The requeue side ignores a waiter with state Q_REQUEUE_PI_IGNORE as this
- * signals that the waiter is already on the way out. It also means that
- * the waiter is still on the 'wait' futex, i.e. uaddr1.
- *
- * The waiter side signals early wakeup to the requeue side either through
- * setting state to Q_REQUEUE_PI_IGNORE or to Q_REQUEUE_PI_WAIT depending
- * on the current state. In case of Q_REQUEUE_PI_IGNORE it can immediately
- * proceed to take the hash bucket lock of uaddr1. If it set state to WAIT,
- * which means the wakeup is interleaving with a requeue in progress it has
- * to wait for the requeue side to change the state. Either to DONE/LOCKED
- * or to IGNORE. DONE/LOCKED means the waiter q is now on the uaddr2 futex
- * and either blocked (DONE) or has acquired it (LOCKED). IGNORE is set by
- * the requeue side when the requeue attempt failed via deadlock detection
- * and therefore the waiter q is still on the uaddr1 futex.
- */
-enum {
-	Q_REQUEUE_PI_NONE		=  0,
-	Q_REQUEUE_PI_IGNORE,
-	Q_REQUEUE_PI_IN_PROGRESS,
-	Q_REQUEUE_PI_WAIT,
-	Q_REQUEUE_PI_DONE,
-	Q_REQUEUE_PI_LOCKED,
-};
-
 static inline bool futex_requeue_pi_prepare(struct futex_q *q,
 					    struct futex_pi_state *pi_state)
 {
@@ -1889,14 +1890,20 @@ static inline void futex_requeue_pi_complete(struct futex_q *q, int locked)
 
 	old = atomic_read_acquire(&q->requeue_state);
 	do {
+		if (old == Q_REQUEUE_PI_IGNORE)
+			return;
+
 		if (locked >= 0) {
 			/* Requeue succeeded. Set DONE or LOCKED */
+			WARN_ON_ONCE(old != Q_REQUEUE_PI_IN_PROGRESS &&
+				     old != Q_REQUEUE_PI_WAIT)
 			new = Q_REQUEUE_PI_DONE + locked;
 		} else if (old == Q_REQUEUE_PI_IN_PROGRESS) {
 			/* Deadlock, no early wakeup interleave */
 			new = Q_REQUEUE_PI_NONE;
 		} else {
 			/* Deadlock, early wakeup interleave. */
+			WARN_ON_ONCE(old != Q_REQUEUE_PI_IN_WAIT);
 			new = Q_REQUEUE_PI_IGNORE;
 		}
 	} while (!atomic_try_cmpxchg(&q->requeue_state, &old, new));
diff --git a/kernel/locking/rtmutex_api.c b/kernel/locking/rtmutex_api.c
index c1ee78691057c..6875d9ee04704 100644
--- a/kernel/locking/rtmutex_api.c
+++ b/kernel/locking/rtmutex_api.c
@@ -224,7 +224,7 @@ void __sched rt_mutex_init_proxy_locked(struct rt_mutex_base *lock,
 	 * the wait_lock of the rtmutex associated to the pi_futex held.
 	 * spin_unlock() in turn takes wait_lock of the rtmutex on which
 	 * the spinlock is based which makes lockdep notice a lock
-	 * recursion. Give the futex/rtmutex wait_lock a seperate key.
+	 * recursion. Give the futex/rtmutex wait_lock a separate key.
 	 */
 	lockdep_set_class(&lock->wait_lock, &pi_futex_key);
 	rt_mutex_set_owner(lock, proxy_owner);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a742e9dc9a7cb..f501d5ac9c9b9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3638,7 +3638,7 @@ bool ttwu_state_match(struct task_struct *p, unsigned int state, int *success)
 
 #ifdef CONFIG_PREEMPT_RT
 	/*
-	 * Saved state preserves the task state accross blocking on
+	 * Saved state preserves the task state across blocking on
 	 * a RT lock.  If the state matches, set p::saved_state to
 	 * TASK_RUNNING, but do not wake the task because it waits
 	 * for a lock wakeup. Also indicate success because from
diff --git a/localversion-rt b/localversion-rt
index ad3da1bcab7e8..0efe7ba1930e1 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt4
+-rt5
