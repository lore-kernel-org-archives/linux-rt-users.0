From: Mike Galbraith <bitbucket@online.de>
Subject: Re: [PATCH RT]  rt,ipc,sem: fix -rt livelock
Date: Tue, 10 Sep 2013 08:30:14 +0200
Message-ID: <1378794614.6046.37.camel@marge.simpson.net>
References: <20130819213324.405942342@goodmis.org>
	 <1377842245.5422.7.camel@marge.simpson.net>
	 <1377873580.5422.25.camel@marge.simpson.net>
	 <1377926850.6234.22.camel@marge.simpson.net>
	 <1378451338.5434.91.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Manfred Spraul <manfred@colorfullife.com>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:65024 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753353Ab3IJGaT (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 10 Sep 2013 02:30:19 -0400
In-Reply-To: <1378451338.5434.91.camel@marge.simpson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2013-09-06 at 09:08 +0200, Mike Galbraith wrote:
> On Sat, 2013-08-31 at 07:27 +0200, Mike Galbraith wrote: 
> > The attached proggy (Manfred Spraul) is one reproducer. 
> 
> Just in case it's not obvious, the cause is spin_unlock_wait() usage.  

(readers are encouraged to skip this bit, go straight to second diff)

The below will prevent livelock without the unpleasant down-sides of /me
trying to let PI see any thumb twiddling going on (also induces thumb
twiddling, just not the endless variety), but surely won't fly, and...

---
 ipc/sem.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -232,7 +232,8 @@ static inline int sem_lock(struct sem_ar
 		 */
 		if (unlikely(spin_is_locked(&sma->sem_perm.lock))) {
 			spin_unlock(&sem->lock);
-			spin_unlock_wait(&sma->sem_perm.lock);
+			while(spin_is_locked(&sma->sem_perm.lock))
+				cpu_relax();
 			goto again;
 		}
 
@@ -249,7 +250,8 @@ static inline int sem_lock(struct sem_ar
 		spin_lock(&sma->sem_perm.lock);
 		for (i = 0; i < sma->sem_nsems; i++) {
 			struct sem *sem = sma->sem_base + i;
-			spin_unlock_wait(&sem->lock);
+			while(spin_is_locked(&sem->lock))
+				cpu_relax();
 		}
 		locknum = -1;
 	}


You can kill this particular (osim induced) livelock by using Manfred's
completion wakeup scheme.  It may not make it all better, but it does
eliminate this trigger, despite that not being what the patch is about.

Beware, contains 3.10.10-rt7 hammer marks made by /me to test.

>From 7fdbcc018b85d5804ea51323f3cefd5fe3032f82 Mon Sep 17 00:00:00 2001
From: Manfred Spraul <manfred@colorfullife.com>
Date: Sat, 28 Jan 2012 18:42:58 +0100
Subject: [PATCH] ipc/sem.c: Add -RT compatible wakeup scheme.

ipc/sem.c uses a custom wakeup scheme that relies on preempt_disable() to
prevent livelocks.
On -RT, this causes increased latencies and debug warnings.

The patch:
- separates the wakeup scheme into helper functions
- adds a scheme built around a completion.

The preferred solution (use a spinlock instead of the completion) does not
work, because there is a limit of at most 256 concurrent spinlocks.

--
        Manfred

Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
---
 ipc/sem.c |  210 +++++++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 127 insertions(+), 83 deletions(-)

--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -61,8 +61,8 @@
  * - A woken up task may not even touch the semaphore array anymore, it may
  *   have been destroyed already by a semctl(RMID).
  * - The synchronizations between wake-ups due to a timeout/signal and a
- *   wake-up due to a completed semaphore operation is achieved by using an
- *   intermediate state (IN_WAKEUP).
+ *   wake-up due to a completed semaphore operation is achieved by using a
+ *   special wakeup scheme (queuewakeup_wait and support functions)
  * - UNDO values are stored in an array (one per process and per
  *   semaphore array, lazily allocated). For backwards compatibility, multiple
  *   modes for the UNDO variables are supported (per process, per thread)
@@ -90,6 +90,85 @@
 #include <asm/uaccess.h>
 #include "util.h"
 
+
+#ifdef CONFIG_PREEMPT_RT_BASE
+	#define SYSVSEM_COMPLETION 1
+#else
+	#define SYSVSEM_CUSTOM 1
+#endif
+
+#ifdef SYSVSEM_COMPLETION
+	/* Using a completion causes some overhead, but avoids a busy loop
+	 * that increases the worst case latency.
+	 */
+	struct queue_done {
+		struct completion done;
+	};
+
+	static void queuewakeup_prepare(void)
+	{
+		/* no preparation necessary */
+	}
+
+	static void queuewakeup_completed(void)
+	{
+		/* empty */
+	}
+
+	static void queuewakeup_handsoff(struct queue_done *qd)
+	{
+		complete_all(&qd->done);
+	}
+
+	static void queuewakeup_init(struct queue_done *qd)
+	{
+		init_completion(&qd->done);
+	}
+
+	static void queuewakeup_wait(struct queue_done *qd)
+	{
+		wait_for_completion(&qd->done);
+	}
+
+#elif defined(SYSVSEM_CUSTOM)
+	struct queue_done {
+		atomic_t done;
+	};
+
+	static void queuewakeup_prepare(void)
+	{
+		preempt_disable();
+	}
+
+	static void queuewakeup_completed(void)
+	{
+		preempt_enable();
+	}
+
+	static void queuewakeup_handsoff(struct queue_done *qd)
+	{
+		BUG_ON(atomic_read(&qd->done) != 2);
+		smp_mb();
+		atomic_set(&qd->done, 1);
+	}
+
+	static void queuewakeup_init(struct queue_done *qd)
+	{
+		atomic_set(&qd->done, 2);
+	}
+
+	static void queuewakeup_wait(struct queue_done *qd)
+	{
+		while (atomic_read(&qd->done) != 1)
+			cpu_relax();
+
+		smp_mb();
+	}
+#else
+#error Unknown locking primitive
+#endif
+
+
 /* One semaphore structure for each semaphore in the system. */
 struct sem {
 	int	semval;		/* current value */
@@ -108,6 +187,7 @@ struct sem_queue {
 	struct sembuf		*sops;	 /* array of pending operations */
 	int			nsops;	 /* number of operations */
 	int			alter;	 /* does *sops alter the array? */
+	struct queue_done	done;	 /* completion synchronization */
 };
 
 /* Each task has a list of undo requests. They are executed automatically
@@ -334,27 +414,34 @@ static inline void sem_rmid(struct ipc_n
 
 /*
  * Lockless wakeup algorithm:
- * Without the check/retry algorithm a lockless wakeup is possible:
+ * The whole task of choosing tasks to wake up is done by the thread that
+ * does the wakeup. For the woken up thread, this makes the following
+ * lockless wakeup possible:
  * - queue.status is initialized to -EINTR before blocking.
  * - wakeup is performed by
- *	* unlinking the queue entry from sma->sem_pending
- *	* setting queue.status to IN_WAKEUP
- *	  This is the notification for the blocked thread that a
- *	  result value is imminent.
+ * 	* call queuewakeup_prepare() once. This is necessary to prevent
+ *	  livelocks.
+ *	* setting queue.status to the actual result code
  *	* call wake_up_process
- *	* set queue.status to the final value.
+ *	* queuewakeup_handsoff(&q->done);
+ *	* call queuewakeup_completed() once.
  * - the previously blocked thread checks queue.status:
- *   	* if it's IN_WAKEUP, then it must wait until the value changes
- *   	* if it's not -EINTR, then the operation was completed by
- *   	  update_queue. semtimedop can return queue.status without
- *   	  performing any operation on the sem array.
- *   	* otherwise it must acquire the spinlock and check what's up.
+ *	* if it's not -EINTR, then someone completed the operation.
+ *	  First, queuewakeup_wait() must be called. Afterwards,
+ *	  semtimedop must return queue.status without performing any
+ *	  operation on the sem array.
+ *	* otherwise it must acquire the spinlock and repeat the test
+ *	    (including: call queuewakeup_wait() if there is a return code)
+ *	* If it is still -EINTR, then no update_queue() completed the
+ *	    operation, thus semtimedop() can proceed normally.
  *
- * The two-stage algorithm is necessary to protect against the following
+ * queuewakeup_wait() is necessary to protect against the following
  * races:
  * - if queue.status is set after wake_up_process, then the woken up idle
  *   thread could race forward and try (and fail) to acquire sma->lock
- *   before update_queue had a chance to set queue.status
+ *   before update_queue had a chance to set queue.status.
+ *   More importantly, it would mean that wake_up_process must be done
+ *   while holding sma->lock, i.e. this would reduce the scalability.
  * - if queue.status is written before wake_up_process and if the
  *   blocked process is woken up by a signal between writing
  *   queue.status and the wake_up_process, then the woken up
@@ -364,7 +451,6 @@ static inline void sem_rmid(struct ipc_n
  *   (yes, this happened on s390 with sysv msg).
  *
  */
-#define IN_WAKEUP	1
 
 /**
  * newary - Create a new semaphore set
@@ -557,22 +643,17 @@ static int try_atomic_semop (struct sem_
 static void wake_up_sem_queue_prepare(struct list_head *pt,
 				struct sem_queue *q, int error)
 {
-#ifdef CONFIG_PREEMPT_RT_BASE
+#ifdef CONFIG_PREEMPT_RT_BASE_MIKE
 	struct task_struct *p = q->sleeper;
 	get_task_struct(p);
 	q->status = error;
 	wake_up_process(p);
 	put_task_struct(p);
 #else
-	if (list_empty(pt)) {
-		/*
-		 * Hold preempt off so that we don't get preempted and have the
-		 * wakee busy-wait until we're scheduled back on.
-		 */
-		preempt_disable();
-	}
-	q->status = IN_WAKEUP;
-	q->pid = error;
+	if (list_empty(pt))
+		queuewakeup_prepare();
+
+	q->status = error;
 
 	list_add_tail(&q->list, pt);
 #endif
@@ -584,24 +665,23 @@ static void wake_up_sem_queue_prepare(st
  *
  * Do the actual wake-up.
  * The function is called without any locks held, thus the semaphore array
- * could be destroyed already and the tasks can disappear as soon as the
- * status is set to the actual return code.
+ * could be destroyed already and the tasks can disappear as soon as
+ * queuewakeup_handsoff() is called.
  */
 static void wake_up_sem_queue_do(struct list_head *pt)
 {
-#ifndef CONFIG_PREEMPT_RT_BASE
+#ifndef CONFIG_PREEMPT_RT_BASE_MIKE
 	struct sem_queue *q, *t;
 	int did_something;
 
 	did_something = !list_empty(pt);
 	list_for_each_entry_safe(q, t, pt, list) {
 		wake_up_process(q->sleeper);
-		/* q can disappear immediately after writing q->status. */
-		smp_wmb();
-		q->status = q->pid;
+		/* q can disappear immediately after completing q->done */
+		queuewakeup_handsoff(&q->done);
 	}
 	if (did_something)
-		preempt_enable();
+		queuewakeup_completed();
 #endif
 }
 
@@ -1517,33 +1597,6 @@ static struct sem_undo *find_alloc_undo(
 	return un;
 }
 
-
-/**
- * get_queue_result - Retrieve the result code from sem_queue
- * @q: Pointer to queue structure
- *
- * Retrieve the return code from the pending queue. If IN_WAKEUP is found in
- * q->status, then we must loop until the value is replaced with the final
- * value: This may happen if a task is woken up by an unrelated event (e.g.
- * signal) and in parallel the task is woken up by another task because it got
- * the requested semaphores.
- *
- * The function can be called with or without holding the semaphore spinlock.
- */
-static int get_queue_result(struct sem_queue *q)
-{
-	int error;
-
-	error = q->status;
-	while (unlikely(error == IN_WAKEUP)) {
-		cpu_relax();
-		error = q->status;
-	}
-
-	return error;
-}
-
-
 SYSCALL_DEFINE4(semtimedop, int, semid, struct sembuf __user *, tsops,
 		unsigned, nsops, const struct timespec __user *, timeout)
 {
@@ -1677,6 +1730,7 @@ SYSCALL_DEFINE4(semtimedop, int, semid,
 
 	queue.status = -EINTR;
 	queue.sleeper = current;
+	queuewakeup_init(&queue.done);
 
 sleep_again:
 	current->state = TASK_INTERRUPTIBLE;
@@ -1688,17 +1742,14 @@ SYSCALL_DEFINE4(semtimedop, int, semid,
 	else
 		schedule();
 
-	error = get_queue_result(&queue);
+	error = queue.status;
 
 	if (error != -EINTR) {
 		/* fast path: update_queue already obtained all requested
-		 * resources.
-		 * Perform a smp_mb(): User space could assume that semop()
-		 * is a memory barrier: Without the mb(), the cpu could
-		 * speculatively read in user space stale data that was
-		 * overwritten by the previous owner of the semaphore.
+		 * resources. Just ensure that update_queue completed
+		 * it's access to &queue.
 		 */
-		smp_mb();
+		queuewakeup_wait(&queue.done);
 
 		goto out_free;
 	}
@@ -1709,26 +1760,19 @@ SYSCALL_DEFINE4(semtimedop, int, semid,
 	/*
 	 * Wait until it's guaranteed that no wakeup_sem_queue_do() is ongoing.
 	 */
-	error = get_queue_result(&queue);
-
-	/*
-	 * Array removed? If yes, leave without sem_unlock().
-	 */
-	if (IS_ERR(sma)) {
+	error = queue.status;
+	if (error != -EINTR) {
+		/* If there is a return code, then we can leave immediately. */
+		if (!IS_ERR(sma)) {
+			/* sem_lock() succeeded - then unlock */
+			sem_unlock(sma, locknum);
+		}
 		rcu_read_unlock();
+		/* Except that we must wait for the hands-off */
+		queuewakeup_wait(&queue.done);
 		goto out_free;
 	}
 
-
-	/*
-	 * If queue.status != -EINTR we are woken up by another process.
-	 * Leave without unlink_queue(), but with sem_unlock().
-	 */
-
-	if (error != -EINTR) {
-		goto out_unlock_free;
-	}
