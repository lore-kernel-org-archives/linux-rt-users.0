From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [ANNOUNCE] 4.0.5-rt4
Date: Tue, 16 Jun 2015 19:10:13 +0200
Message-ID: <20150616171013.GA15784@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:46001 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752581AbbFPRKQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 16 Jun 2015 13:10:16 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Dear RT folks!

I'm pleased to announce the v4.0.5-rt4 patch set.

Changes since v4.0.5-rt3

- backported "futex: Implement lockless wakeups" from -tip. This patch
  avoids needless PI boosting (and context switch) on -RT with
  FUTEX_WAIT + FUTEX_WAKE.

- backported "ipc/mqueue: Implement lockless pipelined wakeups" from
  -tip. With this patch I was able to drop some hacks we have in -RT to
  work around locks up.

- grabbed "futex: avoid double wake up in PI futex wait / wake on -RT"
  from the mailing list. This avoids double wake ups on -RT while using
  FUTEX_LOCK_PI + FUTEX_UNLOCK_PI.

While doing the v4.0 I stumbled upon a few things. Therefore I plan to
reorder the -RT queue and merge patches where possible. Also I intend t=
o
drop PREEMPT_RTB and PREEMPT_RT_BASE unless there is need for it=E2=80=A6

Known issues:

      - My AMD box throws a lot of "cpufreq_stat_notifier_trans: No
        policy found" warnings after boot. It is gone after manually
        setting the policy (to something else than reported).

      - bcache is disabled.

      - CPU hotplug works in general. Steven's test script however
        deadlocks usually on the second invocation.

      - xor / raid_pq
        I had max latency jumping up to 67563us on one CPU while the ne=
xt
        lower max was 58us. I tracked it down to module's init code of
        xor and raid_pq. Both disable preemption while measuring the
        performance of the individual implementation.

The delta patch against 4.0.5-rt3 is appended below and can be found he=
re:

   https://www.kernel.org/pub/linux/kernel/projects/rt/4.0/incr/patch-4=
=2E0.5-rt3-rt4.patch.xz  =20

The RT patch against 4.0.5 can be found here:

   https://www.kernel.org/pub/linux/kernel/projects/rt/4.0/patch-4.0.5-=
rt4.patch.xz

The split quilt queue is available at:

   https://www.kernel.org/pub/linux/kernel/projects/rt/4.0/patches-4.0.=
5-rt4.tar.xz

Sebastian

diff --git a/include/linux/sched.h b/include/linux/sched.h
index acf20e9a591d..6d943d62f93c 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -910,6 +910,50 @@ enum cpu_idle_type {
 #define SCHED_CAPACITY_SCALE	(1L << SCHED_CAPACITY_SHIFT)
=20
 /*
+ * Wake-queues are lists of tasks with a pending wakeup, whose
+ * callers have already marked the task as woken internally,
+ * and can thus carry on. A common use case is being able to
+ * do the wakeups once the corresponding user lock as been
+ * released.
+ *
+ * We hold reference to each task in the list across the wakeup,
+ * thus guaranteeing that the memory is still valid by the time
+ * the actual wakeups are performed in wake_up_q().
+ *
+ * One per task suffices, because there's never a need for a task to b=
e
+ * in two wake queues simultaneously; it is forbidden to abandon a tas=
k
+ * in a wake queue (a call to wake_up_q() _must_ follow), so if a task=
 is
+ * already in a wake queue, the wakeup will happen soon and the second
+ * waker can just skip it.
+ *
+ * The WAKE_Q macro declares and initializes the list head.
+ * wake_up_q() does NOT reinitialize the list; it's expected to be
+ * called near the end of a function, where the fact that the queue is
+ * not used again will be easy to see by inspection.
+ *
+ * Note that this can cause spurious wakeups. schedule() callers
+ * must ensure the call is done inside a loop, confirming that the
+ * wakeup condition has in fact occurred.
+ */
+struct wake_q_node {
+	struct wake_q_node *next;
+};
+
+struct wake_q_head {
+	struct wake_q_node *first;
+	struct wake_q_node **lastp;
+};
+
+#define WAKE_Q_TAIL ((struct wake_q_node *) 0x01)
+
+#define WAKE_Q(name)					\
+	struct wake_q_head name =3D { WAKE_Q_TAIL, &name.first }
+
+extern void wake_q_add(struct wake_q_head *head,
+		       struct task_struct *task);
+extern void wake_up_q(struct wake_q_head *head);
+
+/*
  * sched-domains (multiprocessor balancing) declarations:
  */
 #ifdef CONFIG_SMP
@@ -1524,6 +1568,8 @@ struct task_struct {
 	/* Protection of the PI data structures: */
 	raw_spinlock_t pi_lock;
=20
+	struct wake_q_node wake_q;
+
 #ifdef CONFIG_RT_MUTEXES
 	/* PI waiters blocked on a rt_mutex held by this task */
 	struct rb_root pi_waiters;
diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 17f77a171181..f8ab4f16d400 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -47,8 +47,7 @@
 #define RECV		1
=20
 #define STATE_NONE	0
-#define STATE_PENDING	1
-#define STATE_READY	2
+#define STATE_READY	1
=20
 struct posix_msg_tree_node {
 	struct rb_node		rb_node;
@@ -571,15 +570,12 @@ static int wq_sleep(struct mqueue_inode_info *inf=
o, int sr,
 	wq_add(info, sr, ewp);
=20
 	for (;;) {
-		set_current_state(TASK_INTERRUPTIBLE);
+		__set_current_state(TASK_INTERRUPTIBLE);
=20
 		spin_unlock(&info->lock);
 		time =3D schedule_hrtimeout_range_clock(timeout, 0,
 			HRTIMER_MODE_ABS, CLOCK_REALTIME);
=20
-		while (ewp->state =3D=3D STATE_PENDING)
-			cpu_relax();
-
 		if (ewp->state =3D=3D STATE_READY) {
 			retval =3D 0;
 			goto out;
@@ -907,11 +903,15 @@ SYSCALL_DEFINE1(mq_unlink, const char __user *, u=
_name)
  * list of waiting receivers. A sender checks that list before adding =
the new
  * message into the message array. If there is a waiting receiver, the=
n it
  * bypasses the message array and directly hands the message over to t=
he
- * receiver.
- * The receiver accepts the message and returns without grabbing the q=
ueue
- * spinlock. Therefore an intermediate STATE_PENDING state and memory =
barriers
- * are necessary. The same algorithm is used for sysv semaphores, see
- * ipc/sem.c for more details.
+ * receiver. The receiver accepts the message and returns without grab=
bing the
+ * queue spinlock:
+ *
+ * - Set pointer to message.
+ * - Queue the receiver task for later wakeup (without the info->lock)=
=2E
+ * - Update its state to STATE_READY. Now the receiver can continue.
+ * - Wake up the process after the lock is dropped. Should the process=
 wake up
+ *   before this wakeup (due to a timeout or a signal) it will either =
see
+ *   STATE_READY and continue or acquire the lock to check the state a=
gain.
  *
  * The same algorithm is used for senders.
  */
@@ -919,26 +919,29 @@ SYSCALL_DEFINE1(mq_unlink, const char __user *, u=
_name)
 /* pipelined_send() - send a message directly to the task waiting in
  * sys_mq_timedreceive() (without inserting message into a queue).
  */
-static inline void pipelined_send(struct mqueue_inode_info *info,
+static inline void pipelined_send(struct wake_q_head *wake_q,
+				  struct mqueue_inode_info *info,
 				  struct msg_msg *message,
 				  struct ext_wait_queue *receiver)
 {
-	/*
-	 * Keep them in one critical section for PREEMPT_RT:
-	 */
-	preempt_disable_rt();
 	receiver->msg =3D message;
 	list_del(&receiver->list);
-	receiver->state =3D STATE_PENDING;
-	wake_up_process(receiver->task);
-	smp_wmb();
+	wake_q_add(wake_q, receiver->task);
+	/*
+	 * Rely on the implicit cmpxchg barrier from wake_q_add such
+	 * that we can ensure that updating receiver->state is the last
+	 * write operation: As once set, the receiver can continue,
+	 * and if we don't have the reference count from the wake_q,
+	 * yet, at that point we can later have a use-after-free
+	 * condition and bogus wakeup.
+	 */
 	receiver->state =3D STATE_READY;
-	preempt_enable_rt();
 }
=20
 /* pipelined_receive() - if there is task waiting in sys_mq_timedsend(=
)
  * gets its message and put to the queue (we have one free place for s=
ure). */
-static inline void pipelined_receive(struct mqueue_inode_info *info)
+static inline void pipelined_receive(struct wake_q_head *wake_q,
+				     struct mqueue_inode_info *info)
 {
 	struct ext_wait_queue *sender =3D wq_get_first_waiter(info, SEND);
=20
@@ -947,18 +950,12 @@ static inline void pipelined_receive(struct mqueu=
e_inode_info *info)
 		wake_up_interruptible(&info->wait_q);
 		return;
 	}
-	/*
-	 * Keep them in one critical section for PREEMPT_RT:
-	 */
-	preempt_disable_rt();
-	if (!msg_insert(sender->msg, info)) {
-		list_del(&sender->list);
-		sender->state =3D STATE_PENDING;
-		wake_up_process(sender->task);
-		smp_wmb();
-		sender->state =3D STATE_READY;
-	}
-	preempt_enable_rt();
+	if (msg_insert(sender->msg, info))
+		return;
+
+	list_del(&sender->list);
+	wake_q_add(wake_q, sender->task);
+	sender->state =3D STATE_READY;
 }
=20
 SYSCALL_DEFINE5(mq_timedsend, mqd_t, mqdes, const char __user *, u_msg=
_ptr,
@@ -975,6 +972,7 @@ SYSCALL_DEFINE5(mq_timedsend, mqd_t, mqdes, const c=
har __user *, u_msg_ptr,
 	struct timespec ts;
 	struct posix_msg_tree_node *new_leaf =3D NULL;
 	int ret =3D 0;
+	WAKE_Q(wake_q);
=20
 	if (u_abs_timeout) {
 		int res =3D prepare_timeout(u_abs_timeout, &expires, &ts);
@@ -1059,7 +1057,7 @@ SYSCALL_DEFINE5(mq_timedsend, mqd_t, mqdes, const=
 char __user *, u_msg_ptr,
 	} else {
 		receiver =3D wq_get_first_waiter(info, RECV);
 		if (receiver) {
-			pipelined_send(info, msg_ptr, receiver);
+			pipelined_send(&wake_q, info, msg_ptr, receiver);
 		} else {
 			/* adds message to the queue */
 			ret =3D msg_insert(msg_ptr, info);
@@ -1072,6 +1070,7 @@ SYSCALL_DEFINE5(mq_timedsend, mqd_t, mqdes, const=
 char __user *, u_msg_ptr,
 	}
 out_unlock:
 	spin_unlock(&info->lock);
+	wake_up_q(&wake_q);
 out_free:
 	if (ret)
 		free_msg(msg_ptr);
@@ -1159,14 +1158,17 @@ SYSCALL_DEFINE5(mq_timedreceive, mqd_t, mqdes, =
char __user *, u_msg_ptr,
 			msg_ptr =3D wait.msg;
 		}
 	} else {
+		WAKE_Q(wake_q);
+
 		msg_ptr =3D msg_get(info);
=20
 		inode->i_atime =3D inode->i_mtime =3D inode->i_ctime =3D
 				CURRENT_TIME;
=20
 		/* There is now free space in queue. */
-		pipelined_receive(info);
+		pipelined_receive(&wake_q, info);
 		spin_unlock(&info->lock);
+		wake_up_q(&wake_q);
 		ret =3D 0;
 	}
 	if (ret =3D=3D 0) {
diff --git a/kernel/futex.c b/kernel/futex.c
index 6a06666ad6a1..a353a594f8fd 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1092,9 +1092,11 @@ static void __unqueue_futex(struct futex_q *q)
=20
 /*
  * The hash bucket lock must be held when this is called.
- * Afterwards, the futex_q must not be accessed.
+ * Afterwards, the futex_q must not be accessed. Callers
+ * must ensure to later call wake_up_q() for the actual
+ * wakeups to occur.
  */
-static void wake_futex(struct futex_q *q)
+static void mark_wake_futex(struct wake_q_head *wake_q, struct futex_q=
 *q)
 {
 	struct task_struct *p =3D q->task;
=20
@@ -1102,14 +1104,10 @@ static void wake_futex(struct futex_q *q)
 		return;
=20
 	/*
-	 * We set q->lock_ptr =3D NULL _before_ we wake up the task. If
-	 * a non-futex wake up happens on another CPU then the task
-	 * might exit and p would dereference a non-existing task
-	 * struct. Prevent this by holding a reference on p across the
-	 * wake up.
+	 * Queue the task for later wakeup for after we've released
+	 * the hb->lock. wake_q_add() grabs reference to p.
 	 */
-	get_task_struct(p);
-
+	wake_q_add(wake_q, p);
 	__unqueue_futex(q);
 	/*
 	 * The waiting task can free the futex_q as soon as
@@ -1119,16 +1117,15 @@ static void wake_futex(struct futex_q *q)
 	 */
 	smp_wmb();
 	q->lock_ptr =3D NULL;
-
-	wake_up_state(p, TASK_NORMAL);
-	put_task_struct(p);
 }
=20
-static int wake_futex_pi(u32 __user *uaddr, u32 uval, struct futex_q *=
this)
+static int wake_futex_pi(u32 __user *uaddr, u32 uval, struct futex_q *=
this,
+			 struct futex_hash_bucket *hb)
 {
 	struct task_struct *new_owner;
 	struct futex_pi_state *pi_state =3D this->pi_state;
 	u32 uninitialized_var(curval), newval;
+	bool deboost;
 	int ret =3D 0;
=20
 	if (!pi_state)
@@ -1180,7 +1177,17 @@ static int wake_futex_pi(u32 __user *uaddr, u32 =
uval, struct futex_q *this)
 	raw_spin_unlock_irq(&new_owner->pi_lock);
=20
 	raw_spin_unlock(&pi_state->pi_mutex.wait_lock);
-	rt_mutex_unlock(&pi_state->pi_mutex);
+
+	deboost =3D rt_mutex_futex_unlock(&pi_state->pi_mutex);
+
+	/*
+	 * We deboost after dropping hb->lock. That prevents a double
+	 * wakeup on RT.
+	 */
+	spin_unlock(&hb->lock);
+
+	if (deboost)
+		rt_mutex_adjust_prio(current);
=20
 	return 0;
 }
@@ -1219,6 +1226,7 @@ futex_wake(u32 __user *uaddr, unsigned int flags,=
 int nr_wake, u32 bitset)
 	struct futex_q *this, *next;
 	union futex_key key =3D FUTEX_KEY_INIT;
 	int ret;
+	WAKE_Q(wake_q);
=20
 	if (!bitset)
 		return -EINVAL;
@@ -1246,13 +1254,14 @@ futex_wake(u32 __user *uaddr, unsigned int flag=
s, int nr_wake, u32 bitset)
 			if (!(this->bitset & bitset))
 				continue;
=20
-			wake_futex(this);
+			mark_wake_futex(&wake_q, this);
 			if (++ret >=3D nr_wake)
 				break;
 		}
 	}
=20
 	spin_unlock(&hb->lock);
+	wake_up_q(&wake_q);
 out_put_key:
 	put_futex_key(&key);
 out:
@@ -1271,6 +1280,7 @@ futex_wake_op(u32 __user *uaddr1, unsigned int fl=
ags, u32 __user *uaddr2,
 	struct futex_hash_bucket *hb1, *hb2;
 	struct futex_q *this, *next;
 	int ret, op_ret;
+	WAKE_Q(wake_q);
=20
 retry:
 	ret =3D get_futex_key(uaddr1, flags & FLAGS_SHARED, &key1, VERIFY_REA=
D);
@@ -1322,7 +1332,7 @@ futex_wake_op(u32 __user *uaddr1, unsigned int fl=
ags, u32 __user *uaddr2,
 				ret =3D -EINVAL;
 				goto out_unlock;
 			}
-			wake_futex(this);
+			mark_wake_futex(&wake_q, this);
 			if (++ret >=3D nr_wake)
 				break;
 		}
@@ -1336,7 +1346,7 @@ futex_wake_op(u32 __user *uaddr1, unsigned int fl=
ags, u32 __user *uaddr2,
 					ret =3D -EINVAL;
 					goto out_unlock;
 				}
-				wake_futex(this);
+				mark_wake_futex(&wake_q, this);
 				if (++op_ret >=3D nr_wake2)
 					break;
 			}
@@ -1346,6 +1356,7 @@ futex_wake_op(u32 __user *uaddr1, unsigned int fl=
ags, u32 __user *uaddr2,
=20
 out_unlock:
 	double_unlock_hb(hb1, hb2);
+	wake_up_q(&wake_q);
 out_put_keys:
 	put_futex_key(&key2);
 out_put_key1:
@@ -1505,6 +1516,7 @@ static int futex_requeue(u32 __user *uaddr1, unsi=
gned int flags,
 	struct futex_pi_state *pi_state =3D NULL;
 	struct futex_hash_bucket *hb1, *hb2;
 	struct futex_q *this, *next;
+	WAKE_Q(wake_q);
=20
 	if (requeue_pi) {
 		/*
@@ -1681,7 +1693,7 @@ static int futex_requeue(u32 __user *uaddr1, unsi=
gned int flags,
 		 * woken by futex_unlock_pi().
 		 */
 		if (++task_count <=3D nr_wake && !requeue_pi) {
-			wake_futex(this);
+			mark_wake_futex(&wake_q, this);
 			continue;
 		}
=20
@@ -1731,6 +1743,7 @@ static int futex_requeue(u32 __user *uaddr1, unsi=
gned int flags,
 out_unlock:
 	free_pi_state(pi_state);
 	double_unlock_hb(hb1, hb2);
+	wake_up_q(&wake_q);
 	hb_waiters_dec(hb2);
=20
 	/*
@@ -2424,13 +2437,26 @@ static int futex_unlock_pi(u32 __user *uaddr, u=
nsigned int flags)
 	 */
 	match =3D futex_top_waiter(hb, &key);
 	if (match) {
-		ret =3D wake_futex_pi(uaddr, uval, match);
+		ret =3D wake_futex_pi(uaddr, uval, match, hb);
+
+		/*
+		 * In case of success wake_futex_pi dropped the hash
+		 * bucket lock.
+		 */
+		if (!ret)
+			goto out_putkey;
+
 		/*
 		 * The atomic access to the futex value generated a
 		 * pagefault, so retry the user-access and the wakeup:
 		 */
 		if (ret =3D=3D -EFAULT)
 			goto pi_faulted;
+
+		/*
+		 * wake_futex_pi has detected invalid state. Tell user
+		 * space.
+		 */
 		goto out_unlock;
 	}
=20
@@ -2451,6 +2477,7 @@ static int futex_unlock_pi(u32 __user *uaddr, uns=
igned int flags)
=20
 out_unlock:
 	spin_unlock(&hb->lock);
+out_putkey:
 	put_futex_key(&key);
 	return ret;
=20
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index c0eb5856d3c9..d6ecc9f50544 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -312,7 +312,7 @@ static void __rt_mutex_adjust_prio(struct task_stru=
ct *task)
  * of task. We do not use the spin_xx_mutex() variants here as we are
  * outside of the debug path.)
  */
-static void rt_mutex_adjust_prio(struct task_struct *task)
+void rt_mutex_adjust_prio(struct task_struct *task)
 {
 	unsigned long flags;
=20
@@ -1379,8 +1379,9 @@ static int task_blocks_on_rt_mutex(struct rt_mute=
x *lock,
 /*
  * Wake up the next waiter on the lock.
  *
- * Remove the top waiter from the current tasks pi waiter list and
- * wake it up.
+ * Remove the top waiter from the current tasks pi waiter list,
+ * wake it up and return whether the current task needs to undo
+ * a potential priority boosting.
  *
  * Called with lock->wait_lock held.
  */
@@ -1773,7 +1774,7 @@ static inline int rt_mutex_slowtrylock(struct rt_=
mutex *lock)
 /*
  * Slow path to release a rt-mutex:
  */
-static void __sched
+static bool __sched
 rt_mutex_slowunlock(struct rt_mutex *lock)
 {
 	raw_spin_lock(&lock->wait_lock);
@@ -1816,7 +1817,7 @@ rt_mutex_slowunlock(struct rt_mutex *lock)
 	while (!rt_mutex_has_waiters(lock)) {
 		/* Drops lock->wait_lock ! */
 		if (unlock_rt_mutex_safe(lock) =3D=3D true)
-			return;
+			return false;
 		/* Relock the rtmutex and try again */
 		raw_spin_lock(&lock->wait_lock);
 	}
@@ -1829,8 +1830,7 @@ rt_mutex_slowunlock(struct rt_mutex *lock)
=20
 	raw_spin_unlock(&lock->wait_lock);
=20
-	/* Undo pi boosting if necessary: */
-	rt_mutex_adjust_prio(current);
+	return true;
 }
=20
 /*
@@ -1886,12 +1886,14 @@ rt_mutex_fasttrylock(struct rt_mutex *lock,
=20
 static inline void
 rt_mutex_fastunlock(struct rt_mutex *lock,
-		    void (*slowfn)(struct rt_mutex *lock))
+		    bool (*slowfn)(struct rt_mutex *lock))
 {
-	if (likely(rt_mutex_cmpxchg(lock, current, NULL)))
+	if (likely(rt_mutex_cmpxchg(lock, current, NULL))) {
 		rt_mutex_deadlock_account_unlock(current);
-	else
-		slowfn(lock);
+	} else if (slowfn(lock)) {
+		/* Undo pi boosting if necessary: */
+		rt_mutex_adjust_prio(current);
+	}
 }
=20
 /**
@@ -2006,6 +2008,22 @@ void __sched rt_mutex_unlock(struct rt_mutex *lo=
ck)
 EXPORT_SYMBOL_GPL(rt_mutex_unlock);
=20
 /**
+ * rt_mutex_futex_unlock - Futex variant of rt_mutex_unlock
+ * @lock: the rt_mutex to be unlocked
+ *
+ * Returns: true/false indicating whether priority adjustment is
+ * required or not.
+ */
+bool __sched rt_mutex_futex_unlock(struct rt_mutex *lock)
+{
+	if (likely(rt_mutex_cmpxchg(lock, current, NULL))) {
+		rt_mutex_deadlock_account_unlock(current);
+		return false;
+	}
+	return rt_mutex_slowunlock(lock);
+}
+
+/**
  * rt_mutex_destroy - mark a mutex unusable
  * @lock: the mutex to be destroyed
  *
diff --git a/kernel/locking/rtmutex_common.h b/kernel/locking/rtmutex_c=
ommon.h
index c6dcda5e53af..4d317e9a5d0f 100644
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -136,6 +136,10 @@ extern int rt_mutex_finish_proxy_lock(struct rt_mu=
tex *lock,
 				      struct rt_mutex_waiter *waiter);
 extern int rt_mutex_timed_futex_lock(struct rt_mutex *l, struct hrtime=
r_sleeper *to);
=20
+extern bool rt_mutex_futex_unlock(struct rt_mutex *lock);
+
+extern void rt_mutex_adjust_prio(struct task_struct *task);
+
 #ifdef CONFIG_DEBUG_RT_MUTEXES
 # include "rtmutex-debug.h"
 #else
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0cc288c01e3c..c7f32d72627c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -543,6 +543,52 @@ static bool set_nr_if_polling(struct task_struct *=
p)
 #endif
 #endif
=20
+void wake_q_add(struct wake_q_head *head, struct task_struct *task)
+{
+	struct wake_q_node *node =3D &task->wake_q;
+
+	/*
+	 * Atomically grab the task, if ->wake_q is !nil already it means
+	 * its already queued (either by us or someone else) and will get the
+	 * wakeup due to that.
+	 *
+	 * This cmpxchg() implies a full barrier, which pairs with the write
+	 * barrier implied by the wakeup in wake_up_list().
+	 */
+	if (cmpxchg(&node->next, NULL, WAKE_Q_TAIL))
+		return;
+
+	get_task_struct(task);
+
+	/*
+	 * The head is context local, there can be no concurrency.
+	 */
+	*head->lastp =3D node;
+	head->lastp =3D &node->next;
+}
+
+void wake_up_q(struct wake_q_head *head)
+{
+	struct wake_q_node *node =3D head->first;
+
+	while (node !=3D WAKE_Q_TAIL) {
+		struct task_struct *task;
+
+		task =3D container_of(node, struct task_struct, wake_q);
+		BUG_ON(!task);
+		/* task can safely be re-inserted now */
+		node =3D node->next;
+		task->wake_q.next =3D NULL;
+
+		/*
+		 * wake_up_process() implies a wmb() to pair with the queueing
+		 * in wake_q_add() so as not to miss wakeups.
+		 */
+		wake_up_process(task);
+		put_task_struct(task);
+	}
+}
+
 /*
  * resched_curr - mark rq's current task 'to be rescheduled now'.
  *
diff --git a/localversion-rt b/localversion-rt
index 1445cd65885c..ad3da1bcab7e 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt3
+-rt4
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
