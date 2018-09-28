From: Julia Cartwright <julia@ni.com>
Subject: [PATCH 1/2] kthread: convert worker lock to raw spinlock
Date: Fri, 28 Sep 2018 21:03:51 +0000
Message-ID: <da33d7d7aa32d08f9cbf5016fb04426f90645cb0.1538089180.git.julia@ni.com>
References: <cover.1538089179.git.julia@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Tim Sander <tim@krieglstein.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Guenter Roeck <linux@roeck-us.net>
To: Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1538089179.git.julia@ni.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

In order to enable the queuing of kthread work items from hardirq
context even when PREEMPT_RT_FULL is enabled, convert the worker
spin_lock to a raw_spin_lock.

This is only acceptable to do because the work performed under the lock
is well-bounded and minimal.

Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Guenter Roeck <linux@roeck-us.net>
Reported-and-tested-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Reported-by: Tim Sander <tim@krieglstein.org>
Signed-off-by: Julia Cartwright <julia@ni.com>
---
 include/linux/kthread.h |  2 +-
 kernel/kthread.c        | 42 ++++++++++++++++++++---------------------
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index c1961761311d..ad292898f7f2 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -85,7 +85,7 @@ enum {
=20
 struct kthread_worker {
 	unsigned int		flags;
-	spinlock_t		lock;
+	raw_spinlock_t		lock;
 	struct list_head	work_list;
 	struct list_head	delayed_work_list;
 	struct task_struct	*task;
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 486dedbd9af5..c1d9ee6671c6 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -597,7 +597,7 @@ void __kthread_init_worker(struct kthread_worker *worke=
r,
 				struct lock_class_key *key)
 {
 	memset(worker, 0, sizeof(struct kthread_worker));
-	spin_lock_init(&worker->lock);
+	raw_spin_lock_init(&worker->lock);
 	lockdep_set_class_and_name(&worker->lock, key, name);
 	INIT_LIST_HEAD(&worker->work_list);
 	INIT_LIST_HEAD(&worker->delayed_work_list);
@@ -639,21 +639,21 @@ int kthread_worker_fn(void *worker_ptr)
=20
 	if (kthread_should_stop()) {
 		__set_current_state(TASK_RUNNING);
-		spin_lock_irq(&worker->lock);
+		raw_spin_lock_irq(&worker->lock);
 		worker->task =3D NULL;
-		spin_unlock_irq(&worker->lock);
+		raw_spin_unlock_irq(&worker->lock);
 		return 0;
 	}
=20
 	work =3D NULL;
-	spin_lock_irq(&worker->lock);
+	raw_spin_lock_irq(&worker->lock);
 	if (!list_empty(&worker->work_list)) {
 		work =3D list_first_entry(&worker->work_list,
 					struct kthread_work, node);
 		list_del_init(&work->node);
 	}
 	worker->current_work =3D work;
-	spin_unlock_irq(&worker->lock);
+	raw_spin_unlock_irq(&worker->lock);
=20
 	if (work) {
 		__set_current_state(TASK_RUNNING);
@@ -810,12 +810,12 @@ bool kthread_queue_work(struct kthread_worker *worker=
,
 	bool ret =3D false;
 	unsigned long flags;
=20
-	spin_lock_irqsave(&worker->lock, flags);
+	raw_spin_lock_irqsave(&worker->lock, flags);
 	if (!queuing_blocked(worker, work)) {
 		kthread_insert_work(worker, work, &worker->work_list);
 		ret =3D true;
 	}
-	spin_unlock_irqrestore(&worker->lock, flags);
+	raw_spin_unlock_irqrestore(&worker->lock, flags);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(kthread_queue_work);
@@ -841,7 +841,7 @@ void kthread_delayed_work_timer_fn(struct timer_list *t=
)
 	if (WARN_ON_ONCE(!worker))
 		return;
=20
-	spin_lock(&worker->lock);
+	raw_spin_lock(&worker->lock);
 	/* Work must not be used with >1 worker, see kthread_queue_work(). */
 	WARN_ON_ONCE(work->worker !=3D worker);
=20
@@ -850,7 +850,7 @@ void kthread_delayed_work_timer_fn(struct timer_list *t=
)
 	list_del_init(&work->node);
 	kthread_insert_work(worker, work, &worker->work_list);
=20
-	spin_unlock(&worker->lock);
+	raw_spin_unlock(&worker->lock);
 }
 EXPORT_SYMBOL(kthread_delayed_work_timer_fn);
=20
@@ -906,14 +906,14 @@ bool kthread_queue_delayed_work(struct kthread_worker=
 *worker,
 	unsigned long flags;
 	bool ret =3D false;
=20
-	spin_lock_irqsave(&worker->lock, flags);
+	raw_spin_lock_irqsave(&worker->lock, flags);
=20
 	if (!queuing_blocked(worker, work)) {
 		__kthread_queue_delayed_work(worker, dwork, delay);
 		ret =3D true;
 	}
=20
-	spin_unlock_irqrestore(&worker->lock, flags);
+	raw_spin_unlock_irqrestore(&worker->lock, flags);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(kthread_queue_delayed_work);
@@ -949,7 +949,7 @@ void kthread_flush_work(struct kthread_work *work)
 	if (!worker)
 		return;
=20
-	spin_lock_irq(&worker->lock);
+	raw_spin_lock_irq(&worker->lock);
 	/* Work must not be used with >1 worker, see kthread_queue_work(). */
 	WARN_ON_ONCE(work->worker !=3D worker);
=20
@@ -961,7 +961,7 @@ void kthread_flush_work(struct kthread_work *work)
 	else
 		noop =3D true;
=20
-	spin_unlock_irq(&worker->lock);
+	raw_spin_unlock_irq(&worker->lock);
=20
 	if (!noop)
 		wait_for_completion(&fwork.done);
@@ -994,9 +994,9 @@ static bool __kthread_cancel_work(struct kthread_work *=
work, bool is_dwork,
 		 * any queuing is blocked by setting the canceling counter.
 		 */
 		work->canceling++;
-		spin_unlock_irqrestore(&worker->lock, *flags);
+		raw_spin_unlock_irqrestore(&worker->lock, *flags);
 		del_timer_sync(&dwork->timer);
-		spin_lock_irqsave(&worker->lock, *flags);
+		raw_spin_lock_irqsave(&worker->lock, *flags);
 		work->canceling--;
 	}
=20
@@ -1043,7 +1043,7 @@ bool kthread_mod_delayed_work(struct kthread_worker *=
worker,
 	unsigned long flags;
 	int ret =3D false;
=20
-	spin_lock_irqsave(&worker->lock, flags);
+	raw_spin_lock_irqsave(&worker->lock, flags);
=20
 	/* Do not bother with canceling when never queued. */
 	if (!work->worker)
@@ -1060,7 +1060,7 @@ bool kthread_mod_delayed_work(struct kthread_worker *=
worker,
 fast_queue:
 	__kthread_queue_delayed_work(worker, dwork, delay);
 out:
-	spin_unlock_irqrestore(&worker->lock, flags);
+	raw_spin_unlock_irqrestore(&worker->lock, flags);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(kthread_mod_delayed_work);
@@ -1074,7 +1074,7 @@ static bool __kthread_cancel_work_sync(struct kthread=
_work *work, bool is_dwork)
 	if (!worker)
 		goto out;
=20
-	spin_lock_irqsave(&worker->lock, flags);
+	raw_spin_lock_irqsave(&worker->lock, flags);
 	/* Work must not be used with >1 worker, see kthread_queue_work(). */
 	WARN_ON_ONCE(work->worker !=3D worker);
=20
@@ -1088,13 +1088,13 @@ static bool __kthread_cancel_work_sync(struct kthre=
ad_work *work, bool is_dwork)
 	 * In the meantime, block any queuing by setting the canceling counter.
 	 */
 	work->canceling++;
-	spin_unlock_irqrestore(&worker->lock, flags);
+	raw_spin_unlock_irqrestore(&worker->lock, flags);
 	kthread_flush_work(work);
-	spin_lock_irqsave(&worker->lock, flags);
+	raw_spin_lock_irqsave(&worker->lock, flags);
 	work->canceling--;
=20
 out_fast:
-	spin_unlock_irqrestore(&worker->lock, flags);
+	raw_spin_unlock_irqrestore(&worker->lock, flags);
 out:
 	return ret;
 }
--=20
2.18.0
