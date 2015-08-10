From: Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] 3.18.18-rt16
Date: Mon, 10 Aug 2015 10:34:26 -0400
Message-ID: <20150810103426.097ef860@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0089.hostedemail.com ([216.40.44.89]:41106 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752892AbbHJOea (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 10 Aug 2015 10:34:30 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Dear RT Folks,

I'm pleased to announce the 3.18.18-rt16 stable release.


You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v3.18-rt
  Head SHA1: b628ab744a38ced6fbb48d6d3d32303782daf141


Or to build 3.18.18-rt16 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.18.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.18.18.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.18/patch-3.18.18-rt16.patch.xz



You can also build from 3.18.18-rt15 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.18/incr/patch-3.18.18-rt15-rt16.patch.xz



Enjoy,

-- Steve


Changes from v3.18.18-rt15:

---

Davidlohr Bueso (2):
      futex: Implement lockless wakeups
      ipc/mqueue: Implement lockless pipelined wakeups

Peter Zijlstra (1):
      sched: Implement lockless wake-queues

Sebastian Andrzej Siewior (2):
      Revert "slub: delay ctor until the object is requested"
      kernel/irq_work: fix non RT case

Steven Rostedt (Red Hat) (1):
      Linux 3.18.18-rt16

Thomas Gleixner (1):
      mm/slub: move slab initialization into irq enabled region

----
 include/linux/sched.h | 46 ++++++++++++++++++++++++++++
 ipc/mqueue.c          | 53 +++++++++++++++++++-------------
 kernel/futex.c        | 33 ++++++++++----------
 kernel/sched/core.c   | 46 ++++++++++++++++++++++++++++
 kernel/time/timer.c   |  3 +-
 localversion-rt       |  2 +-
 mm/slub.c             | 85 +++++++++++++++++++++++----------------------------
 7 files changed, 182 insertions(+), 86 deletions(-)
---------------------------
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 05353a40a462..97056d557b06 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -855,6 +855,50 @@ enum cpu_idle_type {
 #define SCHED_CAPACITY_SCALE	(1L << SCHED_CAPACITY_SHIFT)
 
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
+ * One per task suffices, because there's never a need for a task to be
+ * in two wake queues simultaneously; it is forbidden to abandon a task
+ * in a wake queue (a call to wake_up_q() _must_ follow), so if a task is
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
+	struct wake_q_head name = { WAKE_Q_TAIL, &name.first }
+
+extern void wake_q_add(struct wake_q_head *head,
+		       struct task_struct *task);
+extern void wake_up_q(struct wake_q_head *head);
+
+/*
  * sched-domains (multiprocessor balancing) declarations:
  */
 #ifdef CONFIG_SMP
@@ -1463,6 +1507,8 @@ struct task_struct {
 	/* Protection of the PI data structures: */
 	raw_spinlock_t pi_lock;
 
+	struct wake_q_node wake_q;
+
 #ifdef CONFIG_RT_MUTEXES
 	/* PI waiters blocked on a rt_mutex held by this task */
 	struct rb_root pi_waiters;
diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 516902313dc3..79351b5dd0a1 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -47,8 +47,7 @@
 #define RECV		1
 
 #define STATE_NONE	0
-#define STATE_PENDING	1
-#define STATE_READY	2
+#define STATE_READY	1
 
 struct posix_msg_tree_node {
 	struct rb_node		rb_node;
@@ -571,15 +570,12 @@ static int wq_sleep(struct mqueue_inode_info *info, int sr,
 	wq_add(info, sr, ewp);
 
 	for (;;) {
-		set_current_state(TASK_INTERRUPTIBLE);
+		__set_current_state(TASK_INTERRUPTIBLE);
 
 		spin_unlock(&info->lock);
 		time = schedule_hrtimeout_range_clock(timeout, 0,
 			HRTIMER_MODE_ABS, CLOCK_REALTIME);
 
-		while (ewp->state == STATE_PENDING)
-			cpu_relax();
-
 		if (ewp->state == STATE_READY) {
 			retval = 0;
 			goto out;
@@ -907,11 +903,15 @@ out_name:
  * list of waiting receivers. A sender checks that list before adding the new
  * message into the message array. If there is a waiting receiver, then it
  * bypasses the message array and directly hands the message over to the
- * receiver.
- * The receiver accepts the message and returns without grabbing the queue
- * spinlock. Therefore an intermediate STATE_PENDING state and memory barriers
- * are necessary. The same algorithm is used for sysv semaphores, see
- * ipc/sem.c for more details.
+ * receiver. The receiver accepts the message and returns without grabbing the
+ * queue spinlock:
+ *
+ * - Set pointer to message.
+ * - Queue the receiver task for later wakeup (without the info->lock).
+ * - Update its state to STATE_READY. Now the receiver can continue.
+ * - Wake up the process after the lock is dropped. Should the process wake up
+ *   before this wakeup (due to a timeout or a signal) it will either see
+ *   STATE_READY and continue or acquire the lock to check the state again.
  *
  * The same algorithm is used for senders.
  */
@@ -919,7 +919,8 @@ out_name:
 /* pipelined_send() - send a message directly to the task waiting in
  * sys_mq_timedreceive() (without inserting message into a queue).
  */
-static inline void pipelined_send(struct mqueue_inode_info *info,
+static inline void pipelined_send(struct wake_q_head *wake_q,
+				  struct mqueue_inode_info *info,
 				  struct msg_msg *message,
 				  struct ext_wait_queue *receiver)
 {
@@ -929,16 +930,23 @@ static inline void pipelined_send(struct mqueue_inode_info *info,
 	preempt_disable_rt();
 	receiver->msg = message;
 	list_del(&receiver->list);
-	receiver->state = STATE_PENDING;
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
 	receiver->state = STATE_READY;
 	preempt_enable_rt();
 }
 
 /* pipelined_receive() - if there is task waiting in sys_mq_timedsend()
  * gets its message and put to the queue (we have one free place for sure). */
-static inline void pipelined_receive(struct mqueue_inode_info *info)
+static inline void pipelined_receive(struct wake_q_head *wake_q,
+				     struct mqueue_inode_info *info)
 {
 	struct ext_wait_queue *sender = wq_get_first_waiter(info, SEND);
 
@@ -953,9 +961,7 @@ static inline void pipelined_receive(struct mqueue_inode_info *info)
 	preempt_disable_rt();
 	if (!msg_insert(sender->msg, info)) {
 		list_del(&sender->list);
-		sender->state = STATE_PENDING;
-		wake_up_process(sender->task);
-		smp_wmb();
+		wake_q_add(wake_q, sender->task);
 		sender->state = STATE_READY;
 	}
 	preempt_enable_rt();
@@ -975,6 +981,7 @@ SYSCALL_DEFINE5(mq_timedsend, mqd_t, mqdes, const char __user *, u_msg_ptr,
 	struct timespec ts;
 	struct posix_msg_tree_node *new_leaf = NULL;
 	int ret = 0;
+	WAKE_Q(wake_q);
 
 	if (u_abs_timeout) {
 		int res = prepare_timeout(u_abs_timeout, &expires, &ts);
@@ -1059,7 +1066,7 @@ SYSCALL_DEFINE5(mq_timedsend, mqd_t, mqdes, const char __user *, u_msg_ptr,
 	} else {
 		receiver = wq_get_first_waiter(info, RECV);
 		if (receiver) {
-			pipelined_send(info, msg_ptr, receiver);
+			pipelined_send(&wake_q, info, msg_ptr, receiver);
 		} else {
 			/* adds message to the queue */
 			ret = msg_insert(msg_ptr, info);
@@ -1072,6 +1079,7 @@ SYSCALL_DEFINE5(mq_timedsend, mqd_t, mqdes, const char __user *, u_msg_ptr,
 	}
 out_unlock:
 	spin_unlock(&info->lock);
+	wake_up_q(&wake_q);
 out_free:
 	if (ret)
 		free_msg(msg_ptr);
@@ -1159,14 +1167,17 @@ SYSCALL_DEFINE5(mq_timedreceive, mqd_t, mqdes, char __user *, u_msg_ptr,
 			msg_ptr = wait.msg;
 		}
 	} else {
+		WAKE_Q(wake_q);
+
 		msg_ptr = msg_get(info);
 
 		inode->i_atime = inode->i_mtime = inode->i_ctime =
 				CURRENT_TIME;
 
 		/* There is now free space in queue. */
-		pipelined_receive(info);
+		pipelined_receive(&wake_q, info);
 		spin_unlock(&info->lock);
+		wake_up_q(&wake_q);
 		ret = 0;
 	}
 	if (ret == 0) {
diff --git a/kernel/futex.c b/kernel/futex.c
index 647ff4b3a150..f9172a5ee332 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1092,9 +1092,11 @@ static void __unqueue_futex(struct futex_q *q)
 
 /*
  * The hash bucket lock must be held when this is called.
- * Afterwards, the futex_q must not be accessed.
+ * Afterwards, the futex_q must not be accessed. Callers
+ * must ensure to later call wake_up_q() for the actual
+ * wakeups to occur.
  */
-static void wake_futex(struct futex_q *q)
+static void mark_wake_futex(struct wake_q_head *wake_q, struct futex_q *q)
 {
 	struct task_struct *p = q->task;
 
@@ -1102,14 +1104,10 @@ static void wake_futex(struct futex_q *q)
 		return;
 
 	/*
-	 * We set q->lock_ptr = NULL _before_ we wake up the task. If
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
@@ -1119,9 +1117,6 @@ static void wake_futex(struct futex_q *q)
 	 */
 	smp_wmb();
 	q->lock_ptr = NULL;
-
-	wake_up_state(p, TASK_NORMAL);
-	put_task_struct(p);
 }
 
 static int wake_futex_pi(u32 __user *uaddr, u32 uval, struct futex_q *this)
@@ -1219,6 +1214,7 @@ futex_wake(u32 __user *uaddr, unsigned int flags, int nr_wake, u32 bitset)
 	struct futex_q *this, *next;
 	union futex_key key = FUTEX_KEY_INIT;
 	int ret;
+	WAKE_Q(wake_q);
 
 	if (!bitset)
 		return -EINVAL;
@@ -1246,13 +1242,14 @@ futex_wake(u32 __user *uaddr, unsigned int flags, int nr_wake, u32 bitset)
 			if (!(this->bitset & bitset))
 				continue;
 
-			wake_futex(this);
+			mark_wake_futex(&wake_q, this);
 			if (++ret >= nr_wake)
 				break;
 		}
 	}
 
 	spin_unlock(&hb->lock);
+	wake_up_q(&wake_q);
 out_put_key:
 	put_futex_key(&key);
 out:
@@ -1271,6 +1268,7 @@ futex_wake_op(u32 __user *uaddr1, unsigned int flags, u32 __user *uaddr2,
 	struct futex_hash_bucket *hb1, *hb2;
 	struct futex_q *this, *next;
 	int ret, op_ret;
+	WAKE_Q(wake_q);
 
 retry:
 	ret = get_futex_key(uaddr1, flags & FLAGS_SHARED, &key1, VERIFY_READ);
@@ -1322,7 +1320,7 @@ retry_private:
 				ret = -EINVAL;
 				goto out_unlock;
 			}
-			wake_futex(this);
+			mark_wake_futex(&wake_q, this);
 			if (++ret >= nr_wake)
 				break;
 		}
@@ -1336,7 +1334,7 @@ retry_private:
 					ret = -EINVAL;
 					goto out_unlock;
 				}
-				wake_futex(this);
+				mark_wake_futex(&wake_q, this);
 				if (++op_ret >= nr_wake2)
 					break;
 			}
@@ -1346,6 +1344,7 @@ retry_private:
 
 out_unlock:
 	double_unlock_hb(hb1, hb2);
+	wake_up_q(&wake_q);
 out_put_keys:
 	put_futex_key(&key2);
 out_put_key1:
@@ -1505,6 +1504,7 @@ static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
 	struct futex_pi_state *pi_state = NULL;
 	struct futex_hash_bucket *hb1, *hb2;
 	struct futex_q *this, *next;
+	WAKE_Q(wake_q);
 
 	if (requeue_pi) {
 		/*
@@ -1681,7 +1681,7 @@ retry_private:
 		 * woken by futex_unlock_pi().
 		 */
 		if (++task_count <= nr_wake && !requeue_pi) {
-			wake_futex(this);
+			mark_wake_futex(&wake_q, this);
 			continue;
 		}
 
@@ -1731,6 +1731,7 @@ retry_private:
 out_unlock:
 	free_pi_state(pi_state);
 	double_unlock_hb(hb1, hb2);
+	wake_up_q(&wake_q);
 	hb_waiters_dec(hb2);
 
 	/*
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8ad9dcc8270e..cd25ced2208e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -601,6 +601,52 @@ static bool set_nr_if_polling(struct task_struct *p)
 #endif
 #endif
 
+void wake_q_add(struct wake_q_head *head, struct task_struct *task)
+{
+	struct wake_q_node *node = &task->wake_q;
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
+	*head->lastp = node;
+	head->lastp = &node->next;
+}
+
+void wake_up_q(struct wake_q_head *head)
+{
+	struct wake_q_node *node = head->first;
+
+	while (node != WAKE_Q_TAIL) {
+		struct task_struct *task;
+
+		task = container_of(node, struct task_struct, wake_q);
+		BUG_ON(!task);
+		/* task can safely be re-inserted now */
+		node = node->next;
+		task->wake_q.next = NULL;
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
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index a29ab1a17023..3a978d000fce 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1452,7 +1452,8 @@ void update_process_times(int user_tick)
 	rcu_check_callbacks(cpu, user_tick);
 
 #if defined(CONFIG_IRQ_WORK) && !defined(CONFIG_PREEMPT_RT_FULL)
-	irq_work_tick();
+	if (in_irq())
+		irq_work_tick();
 #endif
 	run_posix_cpu_timers(p);
 }
diff --git a/localversion-rt b/localversion-rt
index 18777ec0c27d..1199ebade17b 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt15
+-rt16
diff --git a/mm/slub.c b/mm/slub.c
index 72bb06beaabc..e48bca049f21 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1279,6 +1279,13 @@ static inline void slab_free_hook(struct kmem_cache *s, void *x)
 		debug_check_no_obj_freed(x, s->object_size);
 }
 
+static void setup_object(struct kmem_cache *s, struct page *page,
+				void *object)
+{
+	setup_object_debug(s, page, object);
+	if (unlikely(s->ctor))
+		s->ctor(object);
+}
 /*
  * Slab allocation and freeing
  */
@@ -1310,6 +1317,8 @@ static struct page *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 	struct kmem_cache_order_objects oo = s->oo;
 	gfp_t alloc_gfp;
 	bool enableirqs;
+	void *start, *p;
+	int idx, order;
 
 	flags &= gfp_allowed_mask;
 
@@ -1337,13 +1346,13 @@ static struct page *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 		 * Try a lower order alloc if possible
 		 */
 		page = alloc_slab_page(s, alloc_gfp, node, oo);
-
-		if (page)
-			stat(s, ORDER_FALLBACK);
+		if (unlikely(!page))
+			goto out;
+		stat(s, ORDER_FALLBACK);
 	}
 
-	if (kmemcheck_enabled && page
-		&& !(s->flags & (SLAB_NOTRACK | DEBUG_DEFAULT_FLAGS))) {
+	if (kmemcheck_enabled &&
+	    !(s->flags & (SLAB_NOTRACK | DEBUG_DEFAULT_FLAGS))) {
 		int pages = 1 << oo_order(oo);
 
 		kmemcheck_alloc_shadow(page, oo_order(oo), alloc_gfp, node);
@@ -1358,47 +1367,9 @@ static struct page *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 			kmemcheck_mark_unallocated_pages(page, pages);
 	}
 
-	if (enableirqs)
-		local_irq_disable();
-	if (!page)
-		return NULL;
-
 	page->objects = oo_objects(oo);
-	mod_zone_page_state(page_zone(page),
-		(s->flags & SLAB_RECLAIM_ACCOUNT) ?
-		NR_SLAB_RECLAIMABLE : NR_SLAB_UNRECLAIMABLE,
-		1 << oo_order(oo));
-
-	return page;
-}
-
-static void setup_object(struct kmem_cache *s, struct page *page,
-				void *object)
-{
-	setup_object_debug(s, page, object);
-#ifndef CONFIG_PREEMPT_RT_FULL
-	if (unlikely(s->ctor))
-		s->ctor(object);
-#endif
-}
-
-static struct page *new_slab(struct kmem_cache *s, gfp_t flags, int node)
-{
-	struct page *page;
-	void *start;
-	void *p;
-	int order;
-	int idx;
-
-	BUG_ON(flags & GFP_SLAB_BUG_MASK);
-
-	page = allocate_slab(s,
-		flags & (GFP_RECLAIM_MASK | GFP_CONSTRAINT_MASK), node);
-	if (!page)
-		goto out;
 
 	order = compound_order(page);
-	inc_slabs_node(s, page_to_nid(page), page->objects);
 	page->slab_cache = s;
 	__SetPageSlab(page);
 	if (page->pfmemalloc)
@@ -1420,10 +1391,34 @@ static struct page *new_slab(struct kmem_cache *s, gfp_t flags, int node)
 	page->freelist = start;
 	page->inuse = page->objects;
 	page->frozen = 1;
+
 out:
+	if (enableirqs)
+		local_irq_disable();
+	if (!page)
+		return NULL;
+
+	mod_zone_page_state(page_zone(page),
+		(s->flags & SLAB_RECLAIM_ACCOUNT) ?
+		NR_SLAB_RECLAIMABLE : NR_SLAB_UNRECLAIMABLE,
+		1 << oo_order(oo));
+
+	inc_slabs_node(s, page_to_nid(page), page->objects);
+
 	return page;
 }
 
+static struct page *new_slab(struct kmem_cache *s, gfp_t flags, int node)
+{
+	if (unlikely(flags & GFP_SLAB_BUG_MASK)) {
+		pr_emerg("gfp: %u\n", flags & GFP_SLAB_BUG_MASK);
+		BUG();
+	}
+
+	return allocate_slab(s,
+		flags & (GFP_RECLAIM_MASK | GFP_CONSTRAINT_MASK), node);
+}
+
 static void __free_slab(struct kmem_cache *s, struct page *page)
 {
 	int order = compound_order(page);
@@ -2501,10 +2496,6 @@ redo:
 
 	if (unlikely(gfpflags & __GFP_ZERO) && object)
 		memset(object, 0, s->object_size);
-#ifdef CONFIG_PREEMPT_RT_FULL
-	if (unlikely(s->ctor) && object)
-		s->ctor(object);
-#endif
 
 	slab_post_alloc_hook(s, gfpflags, object);
 
