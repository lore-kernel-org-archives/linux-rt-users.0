Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A86AC32773
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Aug 2022 09:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348148AbiHSJZG (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 19 Aug 2022 05:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348144AbiHSJZB (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 19 Aug 2022 05:25:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A31F2D44;
        Fri, 19 Aug 2022 02:24:58 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1660901093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n7vPRRQD40qWBiYzMCCE8LW8g4JIIFXOAEGftn7e42w=;
        b=zkHeornqqt9byf7TiKVOLhFsMttIzWyCCBlVCIqn/mUOIJ/fE5QVuT/ur1iuhm/EVZdl71
        Np7VyCgfuATG5bWOTdfXtN8H7K2+n1WqTqEjkpUi/cf+XeD47kX5YeEkLf8Zoh08M/PsBf
        QE0B5wT2iB9n3LAaGK8JMv1nwdm5RkWqm1b2g7QerjbgQsDenR9zDOZNhotjNgsWOhSTa/
        Gr2FS/F56ZSa64YMISH7Y1n78KWzjA8C0fmzUL8PRaJTpgjRv6s9qLReKBC1XqwCJffcrt
        RYjWHyAGckboHrhyV+oZaxRa04SwuddsN/D+ZS1ddljXu9a0ShIG8SM2+Sb1uA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1660901093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n7vPRRQD40qWBiYzMCCE8LW8g4JIIFXOAEGftn7e42w=;
        b=p60w1FwVfbr35cptZC11g6qqJZZkNUPVStdaNFrzMEkILJqVqBOfBsQONw3E4xgfXq7PPC
        fzj1YE93JQPGD2AQ==
To:     Mark Gross <markgross@kernel.org>
Cc:     linux-rt-users@vger.kernel.org, stable-rt@vger.kernel.org,
        Salvatore Bonaccorso <carnil@debian.org>
Subject: [PATCH 9/9] workqueue: Convert the pool::lock and wq_mayday_lock to raw_spinlock_t
Date:   Fri, 19 Aug 2022 11:24:46 +0200
Message-Id: <20220819092446.980320-10-bigeasy@linutronix.de>
In-Reply-To: <20220819092446.980320-1-bigeasy@linutronix.de>
References: <20220819092446.980320-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Upstream commit a9b8a985294debae00f6c087dfec8c384d30a3b9

The workqueue code has it's internal spinlocks (pool::lock), which
are acquired on most workqueue operations. These spinlocks are
converted to 'sleeping' spinlocks on a RT-kernel.

Workqueue functions can be invoked from contexts which are truly atomic
even on a PREEMPT_RT enabled kernel. Taking sleeping locks from such
contexts is forbidden.

The pool::lock hold times are bound and the code sections are
relatively short, which allows to convert pool::lock and as a
consequence wq_mayday_lock to raw spinlocks which are truly spinning
locks even on a PREEMPT_RT kernel.

With the previous conversion of the manager waitqueue to a simple
waitqueue workqueues are now fully RT compliant.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/workqueue.c | 166 ++++++++++++++++++++++-----------------------
 1 file changed, 83 insertions(+), 83 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index f494ffe3551fe..5677417f449f9 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -146,7 +146,7 @@ enum {
 /* struct worker is defined in workqueue_internal.h */
=20
 struct worker_pool {
-	spinlock_t		lock;		/* the pool lock */
+	raw_spinlock_t		lock;		/* the pool lock */
 	int			cpu;		/* I: the associated cpu */
 	int			node;		/* I: the associated node ID */
 	int			id;		/* I: pool ID */
@@ -301,7 +301,7 @@ static bool wq_numa_enabled;		/* unbound NUMA affinity =
enabled */
 static struct workqueue_attrs *wq_update_unbound_numa_attrs_buf;
=20
 static DEFINE_MUTEX(wq_pool_mutex);	/* protects pools and workqueues list =
*/
-static DEFINE_SPINLOCK(wq_mayday_lock);	/* protects wq->maydays list */
+static DEFINE_RAW_SPINLOCK(wq_mayday_lock);	/* protects wq->maydays list */
 /* wait for manager to go away */
 static struct rcuwait manager_wait =3D __RCUWAIT_INITIALIZER(manager_wait);
=20
@@ -833,7 +833,7 @@ static struct worker *first_idle_worker(struct worker_p=
ool *pool)
  * Wake up the first idle worker of @pool.
  *
  * CONTEXT:
- * spin_lock_irq(pool->lock).
+ * raw_spin_lock_irq(pool->lock).
  */
 static void wake_up_worker(struct worker_pool *pool)
 {
@@ -886,7 +886,7 @@ void wq_worker_sleeping(struct task_struct *task)
 		return;
=20
 	worker->sleeping =3D 1;
-	spin_lock_irq(&pool->lock);
+	raw_spin_lock_irq(&pool->lock);
=20
 	/*
 	 * The counterpart of the following dec_and_test, implied mb,
@@ -905,7 +905,7 @@ void wq_worker_sleeping(struct task_struct *task)
 		if (next)
 			wake_up_process(next->task);
 	}
-	spin_unlock_irq(&pool->lock);
+	raw_spin_unlock_irq(&pool->lock);
 }
=20
 /**
@@ -916,7 +916,7 @@ void wq_worker_sleeping(struct task_struct *task)
  * Set @flags in @worker->flags and adjust nr_running accordingly.
  *
  * CONTEXT:
- * spin_lock_irq(pool->lock)
+ * raw_spin_lock_irq(pool->lock)
  */
 static inline void worker_set_flags(struct worker *worker, unsigned int fl=
ags)
 {
@@ -941,7 +941,7 @@ static inline void worker_set_flags(struct worker *work=
er, unsigned int flags)
  * Clear @flags in @worker->flags and adjust nr_running accordingly.
  *
  * CONTEXT:
- * spin_lock_irq(pool->lock)
+ * raw_spin_lock_irq(pool->lock)
  */
 static inline void worker_clr_flags(struct worker *worker, unsigned int fl=
ags)
 {
@@ -989,7 +989,7 @@ static inline void worker_clr_flags(struct worker *work=
er, unsigned int flags)
  * actually occurs, it should be easy to locate the culprit work function.
  *
  * CONTEXT:
- * spin_lock_irq(pool->lock).
+ * raw_spin_lock_irq(pool->lock).
  *
  * Return:
  * Pointer to worker which is executing @work if found, %NULL
@@ -1024,7 +1024,7 @@ static struct worker *find_worker_executing_work(stru=
ct worker_pool *pool,
  * nested inside outer list_for_each_entry_safe().
  *
  * CONTEXT:
- * spin_lock_irq(pool->lock).
+ * raw_spin_lock_irq(pool->lock).
  */
 static void move_linked_works(struct work_struct *work, struct list_head *=
head,
 			      struct work_struct **nextp)
@@ -1102,9 +1102,9 @@ static void put_pwq_unlocked(struct pool_workqueue *p=
wq)
 		 * As both pwqs and pools are RCU protected, the
 		 * following lock operations are safe.
 		 */
-		spin_lock_irq(&pwq->pool->lock);
+		raw_spin_lock_irq(&pwq->pool->lock);
 		put_pwq(pwq);
-		spin_unlock_irq(&pwq->pool->lock);
+		raw_spin_unlock_irq(&pwq->pool->lock);
 	}
 }
=20
@@ -1137,7 +1137,7 @@ static void pwq_activate_first_delayed(struct pool_wo=
rkqueue *pwq)
  * decrement nr_in_flight of its pwq and handle workqueue flushing.
  *
  * CONTEXT:
- * spin_lock_irq(pool->lock).
+ * raw_spin_lock_irq(pool->lock).
  */
 static void pwq_dec_nr_in_flight(struct pool_workqueue *pwq, int color)
 {
@@ -1236,7 +1236,7 @@ static int try_to_grab_pending(struct work_struct *wo=
rk, bool is_dwork,
 	if (!pool)
 		goto fail;
=20
-	spin_lock(&pool->lock);
+	raw_spin_lock(&pool->lock);
 	/*
 	 * work->data is guaranteed to point to pwq only while the work
 	 * item is queued on pwq->wq, and both updating work->data to point
@@ -1265,11 +1265,11 @@ static int try_to_grab_pending(struct work_struct *=
work, bool is_dwork,
 		/* work->data points to pwq iff queued, point to pool */
 		set_work_pool_and_keep_pending(work, pool->id);
=20
-		spin_unlock(&pool->lock);
+		raw_spin_unlock(&pool->lock);
 		rcu_read_unlock();
 		return 1;
 	}
-	spin_unlock(&pool->lock);
+	raw_spin_unlock(&pool->lock);
 fail:
 	rcu_read_unlock();
 	local_irq_restore(*flags);
@@ -1290,7 +1290,7 @@ static int try_to_grab_pending(struct work_struct *wo=
rk, bool is_dwork,
  * work_struct flags.
  *
  * CONTEXT:
- * spin_lock_irq(pool->lock).
+ * raw_spin_lock_irq(pool->lock).
  */
 static void insert_work(struct pool_workqueue *pwq, struct work_struct *wo=
rk,
 			struct list_head *head, unsigned int extra_flags)
@@ -1406,7 +1406,7 @@ static void __queue_work(int cpu, struct workqueue_st=
ruct *wq,
 	if (last_pool && last_pool !=3D pwq->pool) {
 		struct worker *worker;
=20
-		spin_lock(&last_pool->lock);
+		raw_spin_lock(&last_pool->lock);
=20
 		worker =3D find_worker_executing_work(last_pool, work);
=20
@@ -1414,11 +1414,11 @@ static void __queue_work(int cpu, struct workqueue_=
struct *wq,
 			pwq =3D worker->current_pwq;
 		} else {
 			/* meh... not running there, queue here */
-			spin_unlock(&last_pool->lock);
-			spin_lock(&pwq->pool->lock);
+			raw_spin_unlock(&last_pool->lock);
+			raw_spin_lock(&pwq->pool->lock);
 		}
 	} else {
-		spin_lock(&pwq->pool->lock);
+		raw_spin_lock(&pwq->pool->lock);
 	}
=20
 	/*
@@ -1431,7 +1431,7 @@ static void __queue_work(int cpu, struct workqueue_st=
ruct *wq,
 	 */
 	if (unlikely(!pwq->refcnt)) {
 		if (wq->flags & WQ_UNBOUND) {
-			spin_unlock(&pwq->pool->lock);
+			raw_spin_unlock(&pwq->pool->lock);
 			cpu_relax();
 			goto retry;
 		}
@@ -1464,7 +1464,7 @@ static void __queue_work(int cpu, struct workqueue_st=
ruct *wq,
 	insert_work(pwq, work, worklist, work_flags);
=20
 out:
-	spin_unlock(&pwq->pool->lock);
+	raw_spin_unlock(&pwq->pool->lock);
 	rcu_read_unlock();
 }
=20
@@ -1618,7 +1618,7 @@ EXPORT_SYMBOL_GPL(mod_delayed_work_on);
  * necessary.
  *
  * LOCKING:
- * spin_lock_irq(pool->lock).
+ * raw_spin_lock_irq(pool->lock).
  */
 static void worker_enter_idle(struct worker *worker)
 {
@@ -1658,7 +1658,7 @@ static void worker_enter_idle(struct worker *worker)
  * @worker is leaving idle state.  Update stats.
  *
  * LOCKING:
- * spin_lock_irq(pool->lock).
+ * raw_spin_lock_irq(pool->lock).
  */
 static void worker_leave_idle(struct worker *worker)
 {
@@ -1794,11 +1794,11 @@ static struct worker *create_worker(struct worker_p=
ool *pool)
 	worker_attach_to_pool(worker, pool);
=20
 	/* start the newly created worker */
-	spin_lock_irq(&pool->lock);
+	raw_spin_lock_irq(&pool->lock);
 	worker->pool->nr_workers++;
 	worker_enter_idle(worker);
 	wake_up_process(worker->task);
-	spin_unlock_irq(&pool->lock);
+	raw_spin_unlock_irq(&pool->lock);
=20
 	return worker;
=20
@@ -1817,7 +1817,7 @@ static struct worker *create_worker(struct worker_poo=
l *pool)
  * be idle.
  *
  * CONTEXT:
- * spin_lock_irq(pool->lock).
+ * raw_spin_lock_irq(pool->lock).
  */
 static void destroy_worker(struct worker *worker)
 {
@@ -1843,7 +1843,7 @@ static void idle_worker_timeout(unsigned long __pool)
 {
 	struct worker_pool *pool =3D (void *)__pool;
=20
-	spin_lock_irq(&pool->lock);
+	raw_spin_lock_irq(&pool->lock);
=20
 	while (too_many_workers(pool)) {
 		struct worker *worker;
@@ -1861,7 +1861,7 @@ static void idle_worker_timeout(unsigned long __pool)
 		destroy_worker(worker);
 	}
=20
-	spin_unlock_irq(&pool->lock);
+	raw_spin_unlock_irq(&pool->lock);
 }
=20
 static void send_mayday(struct work_struct *work)
@@ -1892,8 +1892,8 @@ static void pool_mayday_timeout(unsigned long __pool)
 	struct worker_pool *pool =3D (void *)__pool;
 	struct work_struct *work;
=20
-	spin_lock_irq(&pool->lock);
-	spin_lock(&wq_mayday_lock);		/* for wq->maydays */
+	raw_spin_lock_irq(&pool->lock);
+	raw_spin_lock(&wq_mayday_lock);		/* for wq->maydays */
=20
 	if (need_to_create_worker(pool)) {
 		/*
@@ -1906,8 +1906,8 @@ static void pool_mayday_timeout(unsigned long __pool)
 			send_mayday(work);
 	}
=20
-	spin_unlock(&wq_mayday_lock);
-	spin_unlock_irq(&pool->lock);
+	raw_spin_unlock(&wq_mayday_lock);
+	raw_spin_unlock_irq(&pool->lock);
=20
 	mod_timer(&pool->mayday_timer, jiffies + MAYDAY_INTERVAL);
 }
@@ -1926,7 +1926,7 @@ static void pool_mayday_timeout(unsigned long __pool)
  * may_start_working() %true.
  *
  * LOCKING:
- * spin_lock_irq(pool->lock) which may be released and regrabbed
+ * raw_spin_lock_irq(pool->lock) which may be released and regrabbed
  * multiple times.  Does GFP_KERNEL allocations.  Called only from
  * manager.
  */
@@ -1935,7 +1935,7 @@ __releases(&pool->lock)
 __acquires(&pool->lock)
 {
 restart:
-	spin_unlock_irq(&pool->lock);
+	raw_spin_unlock_irq(&pool->lock);
=20
 	/* if we don't make progress in MAYDAY_INITIAL_TIMEOUT, call for help */
 	mod_timer(&pool->mayday_timer, jiffies + MAYDAY_INITIAL_TIMEOUT);
@@ -1951,7 +1951,7 @@ __acquires(&pool->lock)
 	}
=20
 	del_timer_sync(&pool->mayday_timer);
-	spin_lock_irq(&pool->lock);
+	raw_spin_lock_irq(&pool->lock);
 	/*
 	 * This is necessary even after a new worker was just successfully
 	 * created as @pool->lock was dropped and the new worker might have
@@ -1974,7 +1974,7 @@ __acquires(&pool->lock)
  * and may_start_working() is true.
  *
  * CONTEXT:
- * spin_lock_irq(pool->lock) which may be released and regrabbed
+ * raw_spin_lock_irq(pool->lock) which may be released and regrabbed
  * multiple times.  Does GFP_KERNEL allocations.
  *
  * Return:
@@ -2013,7 +2013,7 @@ static bool manage_workers(struct worker *worker)
  * call this function to process a work.
  *
  * CONTEXT:
- * spin_lock_irq(pool->lock) which is released and regrabbed.
+ * raw_spin_lock_irq(pool->lock) which is released and regrabbed.
  */
 static void process_one_work(struct worker *worker, struct work_struct *wo=
rk)
 __releases(&pool->lock)
@@ -2089,7 +2089,7 @@ __acquires(&pool->lock)
 	 */
 	set_work_pool_and_clear_pending(work, pool->id);
=20
-	spin_unlock_irq(&pool->lock);
+	raw_spin_unlock_irq(&pool->lock);
=20
 	lock_map_acquire_read(&pwq->wq->lockdep_map);
 	lock_map_acquire(&lockdep_map);
@@ -2122,7 +2122,7 @@ __acquires(&pool->lock)
 	 */
 	cond_resched_rcu_qs();
=20
-	spin_lock_irq(&pool->lock);
+	raw_spin_lock_irq(&pool->lock);
=20
 	/* clear cpu intensive status */
 	if (unlikely(cpu_intensive))
@@ -2146,7 +2146,7 @@ __acquires(&pool->lock)
  * fetches a work from the top and executes it.
  *
  * CONTEXT:
- * spin_lock_irq(pool->lock) which may be released and regrabbed
+ * raw_spin_lock_irq(pool->lock) which may be released and regrabbed
  * multiple times.
  */
 static void process_scheduled_works(struct worker *worker)
@@ -2178,11 +2178,11 @@ static int worker_thread(void *__worker)
 	/* tell the scheduler that this is a workqueue worker */
 	worker->task->flags |=3D PF_WQ_WORKER;
 woke_up:
-	spin_lock_irq(&pool->lock);
+	raw_spin_lock_irq(&pool->lock);
=20
 	/* am I supposed to die? */
 	if (unlikely(worker->flags & WORKER_DIE)) {
-		spin_unlock_irq(&pool->lock);
+		raw_spin_unlock_irq(&pool->lock);
 		WARN_ON_ONCE(!list_empty(&worker->entry));
 		worker->task->flags &=3D ~PF_WQ_WORKER;
=20
@@ -2248,7 +2248,7 @@ static int worker_thread(void *__worker)
 	 */
 	worker_enter_idle(worker);
 	__set_current_state(TASK_INTERRUPTIBLE);
-	spin_unlock_irq(&pool->lock);
+	raw_spin_unlock_irq(&pool->lock);
 	schedule();
 	goto woke_up;
 }
@@ -2302,7 +2302,7 @@ static int rescuer_thread(void *__rescuer)
 	should_stop =3D kthread_should_stop();
=20
 	/* see whether any pwq is asking for help */
-	spin_lock_irq(&wq_mayday_lock);
+	raw_spin_lock_irq(&wq_mayday_lock);
=20
 	while (!list_empty(&wq->maydays)) {
 		struct pool_workqueue *pwq =3D list_first_entry(&wq->maydays,
@@ -2314,11 +2314,11 @@ static int rescuer_thread(void *__rescuer)
 		__set_current_state(TASK_RUNNING);
 		list_del_init(&pwq->mayday_node);
=20
-		spin_unlock_irq(&wq_mayday_lock);
+		raw_spin_unlock_irq(&wq_mayday_lock);
=20
 		worker_attach_to_pool(rescuer, pool);
=20
-		spin_lock_irq(&pool->lock);
+		raw_spin_lock_irq(&pool->lock);
 		rescuer->pool =3D pool;
=20
 		/*
@@ -2348,7 +2348,7 @@ static int rescuer_thread(void *__rescuer)
 			 * incur MAYDAY_INTERVAL delay inbetween.
 			 */
 			if (need_to_create_worker(pool)) {
-				spin_lock(&wq_mayday_lock);
+				raw_spin_lock(&wq_mayday_lock);
 				/*
 				 * Queue iff we aren't racing destruction
 				 * and somebody else hasn't queued it already.
@@ -2357,7 +2357,7 @@ static int rescuer_thread(void *__rescuer)
 					get_pwq(pwq);
 					list_add_tail(&pwq->mayday_node, &wq->maydays);
 				}
-				spin_unlock(&wq_mayday_lock);
+				raw_spin_unlock(&wq_mayday_lock);
 			}
 		}
=20
@@ -2376,14 +2376,14 @@ static int rescuer_thread(void *__rescuer)
 			wake_up_worker(pool);
=20
 		rescuer->pool =3D NULL;
-		spin_unlock_irq(&pool->lock);
+		raw_spin_unlock_irq(&pool->lock);
=20
 		worker_detach_from_pool(rescuer, pool);
=20
-		spin_lock_irq(&wq_mayday_lock);
+		raw_spin_lock_irq(&wq_mayday_lock);
 	}
=20
-	spin_unlock_irq(&wq_mayday_lock);
+	raw_spin_unlock_irq(&wq_mayday_lock);
=20
 	if (should_stop) {
 		__set_current_state(TASK_RUNNING);
@@ -2463,7 +2463,7 @@ static void wq_barrier_func(struct work_struct *work)
  * underneath us, so we can't reliably determine pwq from @target.
  *
  * CONTEXT:
- * spin_lock_irq(pool->lock).
+ * raw_spin_lock_irq(pool->lock).
  */
 static void insert_wq_barrier(struct pool_workqueue *pwq,
 			      struct wq_barrier *barr,
@@ -2548,7 +2548,7 @@ static bool flush_workqueue_prep_pwqs(struct workqueu=
e_struct *wq,
 	for_each_pwq(pwq, wq) {
 		struct worker_pool *pool =3D pwq->pool;
=20
-		spin_lock_irq(&pool->lock);
+		raw_spin_lock_irq(&pool->lock);
=20
 		if (flush_color >=3D 0) {
 			WARN_ON_ONCE(pwq->flush_color !=3D -1);
@@ -2565,7 +2565,7 @@ static bool flush_workqueue_prep_pwqs(struct workqueu=
e_struct *wq,
 			pwq->work_color =3D work_color;
 		}
=20
-		spin_unlock_irq(&pool->lock);
+		raw_spin_unlock_irq(&pool->lock);
 	}
=20
 	if (flush_color >=3D 0 && atomic_dec_and_test(&wq->nr_pwqs_to_flush))
@@ -2765,9 +2765,9 @@ void drain_workqueue(struct workqueue_struct *wq)
 	for_each_pwq(pwq, wq) {
 		bool drained;
=20
-		spin_lock_irq(&pwq->pool->lock);
+		raw_spin_lock_irq(&pwq->pool->lock);
 		drained =3D !pwq->nr_active && list_empty(&pwq->delayed_works);
-		spin_unlock_irq(&pwq->pool->lock);
+		raw_spin_unlock_irq(&pwq->pool->lock);
=20
 		if (drained)
 			continue;
@@ -2802,7 +2802,7 @@ static bool start_flush_work(struct work_struct *work=
, struct wq_barrier *barr)
 		return false;
 	}
=20
-	spin_lock_irq(&pool->lock);
+	raw_spin_lock_irq(&pool->lock);
 	/* see the comment in try_to_grab_pending() with the same code */
 	pwq =3D get_work_pwq(work);
 	if (pwq) {
@@ -2818,7 +2818,7 @@ static bool start_flush_work(struct work_struct *work=
, struct wq_barrier *barr)
 	check_flush_dependency(pwq->wq, work);
=20
 	insert_wq_barrier(pwq, barr, work, worker);
-	spin_unlock_irq(&pool->lock);
+	raw_spin_unlock_irq(&pool->lock);
=20
 	/*
 	 * If @max_active is 1 or rescuer is in use, flushing another work
@@ -2834,7 +2834,7 @@ static bool start_flush_work(struct work_struct *work=
, struct wq_barrier *barr)
 	rcu_read_unlock();
 	return true;
 already_gone:
-	spin_unlock_irq(&pool->lock);
+	raw_spin_unlock_irq(&pool->lock);
 	rcu_read_unlock();
 	return false;
 }
@@ -3206,7 +3206,7 @@ static bool wqattrs_equal(const struct workqueue_attr=
s *a,
  */
 static int init_worker_pool(struct worker_pool *pool)
 {
-	spin_lock_init(&pool->lock);
+	raw_spin_lock_init(&pool->lock);
 	pool->id =3D -1;
 	pool->cpu =3D -1;
 	pool->node =3D NUMA_NO_NODE;
@@ -3263,10 +3263,10 @@ static void rcu_free_pool(struct rcu_head *rcu)
 /* This returns with the lock held on success (pool manager is inactive). =
*/
 static bool wq_manager_inactive(struct worker_pool *pool)
 {
-	spin_lock_irq(&pool->lock);
+	raw_spin_lock_irq(&pool->lock);
=20
 	if (pool->flags & POOL_MANAGER_ACTIVE) {
-		spin_unlock_irq(&pool->lock);
+		raw_spin_unlock_irq(&pool->lock);
 		return false;
 	}
 	return true;
@@ -3317,7 +3317,7 @@ static void put_unbound_pool(struct worker_pool *pool)
 	while ((worker =3D first_idle_worker(pool)))
 		destroy_worker(worker);
 	WARN_ON(pool->nr_workers || pool->nr_idle);
-	spin_unlock_irq(&pool->lock);
+	raw_spin_unlock_irq(&pool->lock);
=20
 	mutex_lock(&pool->attach_mutex);
 	if (!list_empty(&pool->workers))
@@ -3477,7 +3477,7 @@ static void pwq_adjust_max_active(struct pool_workque=
ue *pwq)
 		return;
=20
 	/* this function can be called during early boot w/ irq disabled */
-	spin_lock_irqsave(&pwq->pool->lock, flags);
+	raw_spin_lock_irqsave(&pwq->pool->lock, flags);
=20
 	/*
 	 * During [un]freezing, the caller is responsible for ensuring that
@@ -3507,7 +3507,7 @@ static void pwq_adjust_max_active(struct pool_workque=
ue *pwq)
 		pwq->max_active =3D 0;
 	}
=20
-	spin_unlock_irqrestore(&pwq->pool->lock, flags);
+	raw_spin_unlock_irqrestore(&pwq->pool->lock, flags);
 }
=20
 /* initialize newly alloced @pwq which is associated with @wq and @pool */
@@ -3899,9 +3899,9 @@ static void wq_update_unbound_numa(struct workqueue_s=
truct *wq, int cpu,
=20
 use_dfl_pwq:
 	mutex_lock(&wq->mutex);
-	spin_lock_irq(&wq->dfl_pwq->pool->lock);
+	raw_spin_lock_irq(&wq->dfl_pwq->pool->lock);
 	get_pwq(wq->dfl_pwq);
-	spin_unlock_irq(&wq->dfl_pwq->pool->lock);
+	raw_spin_unlock_irq(&wq->dfl_pwq->pool->lock);
 	old_pwq =3D numa_pwq_tbl_install(wq, node, wq->dfl_pwq);
 out_unlock:
 	mutex_unlock(&wq->mutex);
@@ -4097,9 +4097,9 @@ void destroy_workqueue(struct workqueue_struct *wq)
 		struct worker *rescuer =3D wq->rescuer;
=20
 		/* this prevents new queueing */
-		spin_lock_irq(&wq_mayday_lock);
+		raw_spin_lock_irq(&wq_mayday_lock);
 		wq->rescuer =3D NULL;
-		spin_unlock_irq(&wq_mayday_lock);
+		raw_spin_unlock_irq(&wq_mayday_lock);
=20
 		/* rescuer will empty maydays list before exiting */
 		kthread_stop(rescuer->task);
@@ -4292,10 +4292,10 @@ unsigned int work_busy(struct work_struct *work)
 	rcu_read_lock();
 	pool =3D get_work_pool(work);
 	if (pool) {
-		spin_lock_irqsave(&pool->lock, flags);
+		raw_spin_lock_irqsave(&pool->lock, flags);
 		if (find_worker_executing_work(pool, work))
 			ret |=3D WORK_BUSY_RUNNING;
-		spin_unlock_irqrestore(&pool->lock, flags);
+		raw_spin_unlock_irqrestore(&pool->lock, flags);
 	}
 	rcu_read_unlock();
=20
@@ -4507,10 +4507,10 @@ void show_workqueue_state(void)
 		pr_info("workqueue %s: flags=3D0x%x\n", wq->name, wq->flags);
=20
 		for_each_pwq(pwq, wq) {
-			spin_lock_irqsave(&pwq->pool->lock, flags);
+			raw_spin_lock_irqsave(&pwq->pool->lock, flags);
 			if (pwq->nr_active || !list_empty(&pwq->delayed_works))
 				show_pwq(pwq);
-			spin_unlock_irqrestore(&pwq->pool->lock, flags);
+			raw_spin_unlock_irqrestore(&pwq->pool->lock, flags);
 			/*
 			 * We could be printing a lot from atomic context, e.g.
 			 * sysrq-t -> show_workqueue_state(). Avoid triggering
@@ -4524,7 +4524,7 @@ void show_workqueue_state(void)
 		struct worker *worker;
 		bool first =3D true;
=20
-		spin_lock_irqsave(&pool->lock, flags);
+		raw_spin_lock_irqsave(&pool->lock, flags);
 		if (pool->nr_workers =3D=3D pool->nr_idle)
 			goto next_pool;
=20
@@ -4543,7 +4543,7 @@ void show_workqueue_state(void)
 		}
 		pr_cont("\n");
 	next_pool:
-		spin_unlock_irqrestore(&pool->lock, flags);
+		raw_spin_unlock_irqrestore(&pool->lock, flags);
 		/*
 		 * We could be printing a lot from atomic context, e.g.
 		 * sysrq-t -> show_workqueue_state(). Avoid triggering
@@ -4578,7 +4578,7 @@ static void wq_unbind_fn(struct work_struct *work)
=20
 	for_each_cpu_worker_pool(pool, cpu) {
 		mutex_lock(&pool->attach_mutex);
-		spin_lock_irq(&pool->lock);
+		raw_spin_lock_irq(&pool->lock);
=20
 		/*
 		 * We've blocked all attach/detach operations. Make all workers
@@ -4592,7 +4592,7 @@ static void wq_unbind_fn(struct work_struct *work)
=20
 		pool->flags |=3D POOL_DISASSOCIATED;
=20
-		spin_unlock_irq(&pool->lock);
+		raw_spin_unlock_irq(&pool->lock);
 		mutex_unlock(&pool->attach_mutex);
=20
 		/*
@@ -4618,9 +4618,9 @@ static void wq_unbind_fn(struct work_struct *work)
 		 * worker blocking could lead to lengthy stalls.  Kick off
 		 * unbound chain execution of currently pending work items.
 		 */
-		spin_lock_irq(&pool->lock);
+		raw_spin_lock_irq(&pool->lock);
 		wake_up_worker(pool);
-		spin_unlock_irq(&pool->lock);
+		raw_spin_unlock_irq(&pool->lock);
 	}
 }
=20
@@ -4647,7 +4647,7 @@ static void rebind_workers(struct worker_pool *pool)
 		WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task,
 						  pool->attrs->cpumask) < 0);
=20
-	spin_lock_irq(&pool->lock);
+	raw_spin_lock_irq(&pool->lock);
=20
 	/*
 	 * XXX: CPU hotplug notifiers are weird and can call DOWN_FAILED
@@ -4655,7 +4655,7 @@ static void rebind_workers(struct worker_pool *pool)
 	 * being reworked and this can go away in time.
 	 */
 	if (!(pool->flags & POOL_DISASSOCIATED)) {
-		spin_unlock_irq(&pool->lock);
+		raw_spin_unlock_irq(&pool->lock);
 		return;
 	}
=20
@@ -4696,7 +4696,7 @@ static void rebind_workers(struct worker_pool *pool)
 		ACCESS_ONCE(worker->flags) =3D worker_flags;
 	}
=20
-	spin_unlock_irq(&pool->lock);
+	raw_spin_unlock_irq(&pool->lock);
 }
=20
 /**
--=20
2.37.2

