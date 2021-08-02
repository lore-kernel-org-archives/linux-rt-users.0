Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210FAC432BE
	for <linux-rt-users@archiver.kernel.org>; Mon,  2 Aug 2021 16:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 090D360FC0
	for <linux-rt-users@archiver.kernel.org>; Mon,  2 Aug 2021 16:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbhHBQ2C (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 2 Aug 2021 12:28:02 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50062 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232909AbhHBQ2C (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 2 Aug 2021 12:28:02 -0400
Date:   Mon, 2 Aug 2021 18:27:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627921671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=dP/4JDrWmbKNU9mGvxLTctrDPg89NI92Bo0txDpKp6A=;
        b=vp5+T+Pnfp8fdKNPl4fjMm8sBYMat52aJeynR0T+Oyy85Fs7ebsDtcX5dceeNPQex5/HDz
        jBvQjsBj/QYNuK7dJcs+0ThlQ5O9YE8RJCa4kF6FOc8emwO80p7PG3tR/+8Era1WWF5zhg
        woEd10DNPa5a9ndckVI6LwzKu+iQSpGfco7vXwsq9pLfnBqZT36uOuNbSe4uV6KhcDw61O
        9+LYZu5oJQiT7hMVPr7bUUHD3IXAHioY3b8kuqnWCXDLB9lhJtoXLEnjmplZd47gV/uXtn
        w4ZhAxwZ4WdSwMWF+REVyu6BM5J8X2b9Y2TxRz2Fd9v27F9agntrrIvRgI7QQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627921671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=dP/4JDrWmbKNU9mGvxLTctrDPg89NI92Bo0txDpKp6A=;
        b=aEtAsKco02MLWIMnZXefB4bWAX5x30I66XnqA/DyuVYtaXe4MoDtg9WzfZ7MUkj5atc2Ir
        t2pjxx1d3Apv23Dw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.14-rc4-rt4
Message-ID: <20210802162750.santic4y6lzcet5c@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.14-rc4-rt4 patch set. 

Changes since v5.14-rc4-rt3:

  - Updating the locking bits:

    - Use proper task state in ww_mutex_lock_interruptible(), reported
      by Mike Galbraith.

    - Fix the wake_q handling for a task which blocks simultaneously as
      a regular task and additionally as a sleeper on a sleeping lock.
      Regression introduced in the v5.14 cycle, reported by Mike
      Galbraith, patched by Thomas Gleixner.

    - Address the futex related review comments by Peter Zijlstra.

Known issues
     - netconsole triggers WARN.

     - The "Memory controller" (CONFIG_MEMCG) has been disabled.

     - A RCU and ARM64 warning has been fixed by Valentin Schneider. It is
       still not clear if the RCU related change is correct.

The delta patch against v5.14-rc4-rt3 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.14/incr/patch-5.14-rc4-rt3-rt4.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.14-rc4-rt4

The RT patch against v5.14-rc4 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.14/older/patch-5.14-rc4-rt4.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.14/older/patches-5.14-rc4-rt4.tar.xz

Sebastian

diff --git a/include/linux/sched/wake_q.h b/include/linux/sched/wake_q.h
index cdd98d57c0e6a..8e57a6660aad1 100644
--- a/include/linux/sched/wake_q.h
+++ b/include/linux/sched/wake_q.h
@@ -61,11 +61,5 @@ static inline bool wake_q_empty(struct wake_q_head *head)
 
 extern void wake_q_add(struct wake_q_head *head, struct task_struct *task);
 extern void wake_q_add_safe(struct wake_q_head *head, struct task_struct *task);
-extern void __wake_up_q(struct wake_q_head *head, unsigned int state);
-
-static inline void wake_up_q(struct wake_q_head *head)
-{
-	__wake_up_q(head, TASK_NORMAL);
-}
-
+extern void wake_up_q(struct wake_q_head *head);
 #endif /* _LINUX_SCHED_WAKE_Q_H */
diff --git a/kernel/futex.c b/kernel/futex.c
index 7fc061ee5f2d4..c4e28bd37abcb 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1853,15 +1853,16 @@ enum {
 static inline bool futex_requeue_pi_prepare(struct futex_q *q,
 					    struct futex_pi_state *pi_state)
 {
-	int cur, res, new;
+	int old, new;
 
 	/*
 	 * Set state to Q_REQUEUE_PI_IN_PROGRESS unless an early wakeup has
 	 * already set Q_REQUEUE_PI_IGNORE to signal that requeue should
 	 * ignore the waiter.
 	 */
-	for (cur = atomic_read(&q->requeue_state);; cur = res) {
-		if (cur == Q_REQUEUE_PI_IGNORE)
+	old = atomic_read_acquire(&q->requeue_state);
+	do {
+		if (old == Q_REQUEUE_PI_IGNORE)
 			return false;
 
 		/*
@@ -1872,74 +1873,68 @@ static inline bool futex_requeue_pi_prepare(struct futex_q *q,
 		 * trylock, but that would just add more conditionals
 		 * all over the place for a dubious value.
 		 */
-		if (cur != Q_REQUEUE_PI_NONE)
+		if (old != Q_REQUEUE_PI_NONE)
 			break;
 
 		new = Q_REQUEUE_PI_IN_PROGRESS;
-		res = atomic_cmpxchg(&q->requeue_state, cur, new);
-		if (likely(cur == res))
-			break;
-	}
+	} while (!atomic_try_cmpxchg(&q->requeue_state, &old, new));
+
 	q->pi_state = pi_state;
 	return true;
 }
 
 static inline void futex_requeue_pi_complete(struct futex_q *q, int locked)
 {
-	int cur, res, new;
+	int old, new;
 
-	for (cur = atomic_read(&q->requeue_state);; cur = res) {
+	old = atomic_read_acquire(&q->requeue_state);
+	do {
 		if (locked >= 0) {
 			/* Requeue succeeded. Set DONE or LOCKED */
 			new = Q_REQUEUE_PI_DONE + locked;
-		} else if (cur == Q_REQUEUE_PI_IN_PROGRESS) {
+		} else if (old == Q_REQUEUE_PI_IN_PROGRESS) {
 			/* Deadlock, no early wakeup interleave */
 			new = Q_REQUEUE_PI_NONE;
 		} else {
 			/* Deadlock, early wakeup interleave. */
 			new = Q_REQUEUE_PI_IGNORE;
 		}
-
-		res = atomic_cmpxchg(&q->requeue_state, cur, new);
-		if (likely(cur == res))
-			break;
-	}
+	} while (!atomic_try_cmpxchg(&q->requeue_state, &old, new));
 
 #ifdef CONFIG_PREEMPT_RT
 	/* If the waiter interleaved with the requeue let it know */
-	if (unlikely(cur == Q_REQUEUE_PI_WAIT))
+	if (unlikely(old == Q_REQUEUE_PI_WAIT))
 		rcuwait_wake_up(&q->requeue_wait);
 #endif
 }
 
 static inline int futex_requeue_pi_wakeup_sync(struct futex_q *q)
 {
-	int cur, new, res;
+	int old, new;
 
-	for (cur = atomic_read(&q->requeue_state);; cur = res) {
+	old = atomic_read_acquire(&q->requeue_state);
+	do {
 		/* Is requeue done already? */
-		if (cur >= Q_REQUEUE_PI_DONE)
-			break;
+		if (old >= Q_REQUEUE_PI_DONE)
+			return old;
 
 		/*
 		 * If not done, then tell the requeue code to either ignore
 		 * the waiter or to wake it up once the requeue is done.
 		 */
-		new = !cur ? Q_REQUEUE_PI_IGNORE : Q_REQUEUE_PI_WAIT;
-		res = atomic_cmpxchg(&q->requeue_state, cur, new);
-		if (likely(cur == res))
-			break;
-	}
+		new = Q_REQUEUE_PI_WAIT;
+		if (old == Q_REQUEUE_PI_NONE)
+			new = Q_REQUEUE_PI_IGNORE;
+	} while (!atomic_try_cmpxchg(&q->requeue_state, &old, new));
 
 	/* If the requeue was in progress, wait for it to complete */
-	if (cur == Q_REQUEUE_PI_IN_PROGRESS) {
+	if (old == Q_REQUEUE_PI_IN_PROGRESS) {
 #ifdef CONFIG_PREEMPT_RT
 		rcuwait_wait_event(&q->requeue_wait,
 				   atomic_read(&q->requeue_state) != Q_REQUEUE_PI_WAIT,
 				   TASK_UNINTERRUPTIBLE);
 #else
-		while (atomic_read(&q->requeue_state) == Q_REQUEUE_PI_WAIT)
-			cpu_relax();
+		(void)atomic_cond_read_relaxed(&q->requeue_state, VAL != Q_REQUEUE_PI_WAIT);
 #endif
 	}
 
@@ -2039,7 +2034,10 @@ futex_proxy_trylock_atomic(u32 __user *pifutex, struct futex_hash_bucket *hb1,
 	if (!top_waiter)
 		return 0;
 
-	/* Ensure that this is a waiter sitting in futex_wait_requeue_pi() */
+	/*
+	 * Ensure that this is a waiter sitting in futex_wait_requeue_pi()
+	 * and waiting on the 'waitqueue' futex which is always !PI.
+	 */
 	if (!top_waiter->rt_waiter || top_waiter->pi_state)
 		ret = -EINVAL;
 
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index e347bbc12641d..eadaface1fd29 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -429,7 +429,10 @@ static __always_inline void rt_mutex_wake_q_add(struct rt_wake_q_head *wqh,
 						struct rt_mutex_waiter *w)
 {
 	if (IS_ENABLED(CONFIG_PREEMPT_RT) && w->wake_state != TASK_NORMAL) {
-		wake_q_add(&wqh->rt_head, w->task);
+		if (IS_ENABLED(CONFIG_PROVE_LOCKING))
+			WARN_ON_ONCE(wqh->rtlock_task);
+		get_task_struct(w->task);
+		wqh->rtlock_task = w->task;
 	} else {
 		wake_q_add(&wqh->head, w->task);
 	}
@@ -437,8 +440,11 @@ static __always_inline void rt_mutex_wake_q_add(struct rt_wake_q_head *wqh,
 
 static __always_inline void rt_mutex_wake_up_q(struct rt_wake_q_head *wqh)
 {
-	if (IS_ENABLED(CONFIG_PREEMPT_RT) && !wake_q_empty(&wqh->rt_head))
-		__wake_up_q(&wqh->rt_head, TASK_RTLOCK_WAIT);
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && wqh->rtlock_task) {
+		wake_up_state(wqh->rtlock_task, TASK_RTLOCK_WAIT);
+		put_task_struct(wqh->rtlock_task);
+		wqh->rtlock_task = NULL;
+	}
 
 	if (!wake_q_empty(&wqh->head))
 		wake_up_q(&wqh->head);
diff --git a/kernel/locking/rtmutex_common.h b/kernel/locking/rtmutex_common.h
index 9697b04c40e68..61256de5bd66a 100644
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -44,18 +44,18 @@ struct rt_mutex_waiter {
 /**
  * rt_wake_q_head - Wrapper around regular wake_q_head to support
  *		    "sleeping" spinlocks on RT
- * @head:	The regular wake_q_head for sleeping lock variants
- * @rt_head:	The wake_q_head for RT lock (spin/rwlock) variants
+ * @head:		The regular wake_q_head for sleeping lock variants
+ * @rtlock_task:	Task pointer for RT lock (spin/rwlock) wakeups
  */
 struct rt_wake_q_head {
 	struct wake_q_head	head;
-	struct wake_q_head	rt_head;
+	struct task_struct	*rtlock_task;
 };
 
 #define DEFINE_RT_WAKE_Q(name)						\
 	struct rt_wake_q_head name = {					\
 		.head		= WAKE_Q_HEAD_INITIALIZER(name.head),	\
-		.rt_head	= WAKE_Q_HEAD_INITIALIZER(name.rt_head),\
+		.rtlock_task	= NULL,					\
 	}
 
 /*
diff --git a/kernel/locking/ww_rt_mutex.c b/kernel/locking/ww_rt_mutex.c
index 9b7e3f413a828..519092ee5e88e 100644
--- a/kernel/locking/ww_rt_mutex.c
+++ b/kernel/locking/ww_rt_mutex.c
@@ -60,7 +60,7 @@ EXPORT_SYMBOL(ww_mutex_lock);
 int __sched
 ww_mutex_lock_interruptible(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
 {
-	return __ww_rt_mutex_lock(lock, ctx, TASK_UNINTERRUPTIBLE, _RET_IP_);
+	return __ww_rt_mutex_lock(lock, ctx, TASK_INTERRUPTIBLE, _RET_IP_);
 }
 EXPORT_SYMBOL(ww_mutex_lock_interruptible);
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 87e0ad6665260..a742e9dc9a7cb 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -920,7 +920,7 @@ void wake_q_add_safe(struct wake_q_head *head, struct task_struct *task)
 		put_task_struct(task);
 }
 
-void __wake_up_q(struct wake_q_head *head, unsigned int state)
+void wake_up_q(struct wake_q_head *head)
 {
 	struct wake_q_node *node = head->first;
 
@@ -936,7 +936,7 @@ void __wake_up_q(struct wake_q_head *head, unsigned int state)
 		 * wake_up_process() executes a full barrier, which pairs with
 		 * the queueing in wake_q_add() so as not to miss wakeups.
 		 */
-		wake_up_state(task, state);
+		wake_up_process(task);
 		put_task_struct(task);
 	}
 }
diff --git a/localversion-rt b/localversion-rt
index 1445cd65885cd..ad3da1bcab7e8 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt3
+-rt4
