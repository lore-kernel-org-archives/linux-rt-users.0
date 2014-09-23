From: Chris.Pringle@grassvalley.com
Subject: Workqueue "scheduling while atomic" issues in v3.12.19-rt30
Date: Tue, 23 Sep 2014 11:55:53 +0100
Message-ID: <OF7A166039.4A11D04A-ON80257D5C.00394E82-80257D5C.003C09F4@belden.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.belden.com ([12.161.118.91]:60512 "EHLO mx2.belden.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755566AbaIWLLQ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 23 Sep 2014 07:11:16 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Dear All,

We've come across a number of "scheduling while atomic" BUGs after 
upgrading from v3.0 (Freescale SDK v1.2.1) to v3.12.19-rt30 (Freescale SDK 
v1.6) on a P2041 (e500mc core).

2014 Sep 22 17:20:07.984 (none) kernel: BUG: scheduling while atomic: 
rcuc/3/31/0x00000002 
2014 Sep 22 17:20:07.984 (none) kernel: Modules linked in: cryptodev(O) 
ssp(O) 
2014 Sep 22 17:20:07.984 (none) kernel: Preemption disabled at:[< (null)>] 
  (null)
2014 Sep 22 17:20:07.984 (none) kernel:  
2014 Sep 22 17:20:07.984 (none) kernel: CPU: 3 PID: 31 Comm: rcuc/3 
Tainted: G           O 3.12.19-rt30 #1
2014 Sep 22 17:20:07.984 (none) kernel: Call Trace:  
2014 Sep 22 17:20:07.984 (none) kernel: [ea0e3bc0] [80006d24] 
show_stack+0x44/0x150 (unreliable)
2014 Sep 22 17:20:07.984 (none) kernel: [ea0e3c00] [80677eb4] 
dump_stack+0x7c/0xdc 
2014 Sep 22 17:20:07.984 (none) kernel: [ea0e3c20] [80675490] 
__schedule_bug+0x84/0xa0 
2014 Sep 22 17:20:07.984 (none) kernel: [ea0e3c30] [806725b8] 
__schedule+0x458/0x4e0 
2014 Sep 22 17:20:07.985 (none) kernel: [ea0e3d30] [80672710] 
schedule+0x30/0xd0 
2014 Sep 22 17:20:07.985 (none) kernel: [ea0e3d40] [80673338] 
rt_spin_lock_slowlock+0x140/0x288
2014 Sep 22 17:20:07.985 (none) kernel: [ea0e3db0] [8003f43c] 
__queue_work+0x18c/0x280
2014 Sep 22 17:20:07.985 (none) kernel: [ea0e3de0] [8003f684] 
queue_work_on+0x144/0x150
2014 Sep 22 17:20:07.985 (none) kernel: [ea0e3e10] [802ee29c] 
percpu_ref_kill_rcu+0x16c/0x170 
2014 Sep 22 17:20:07.985 (none) kernel: [ea0e3e40] [80093010] 
rcu_cpu_kthread+0x2f0/0x640
2014 Sep 22 17:20:07.985 (none) kernel: [ea0e3eb0] [800528c8] 
smpboot_thread_fn+0x268/0x2e0
2014 Sep 22 17:20:07.985 (none) kernel: [ea0e3ee0] [80047fb8] 
kthread+0x98/0xa0 
2014 Sep 22 17:20:07.985 (none) kernel: [ea0e3f40] [8000f5a4] 
ret_from_kernel_thread+0x5c/0x64

We are using asynchronous I/O in our applications and rapid calls to 
io_queue_release appear to make this happen more frequently. This appears 
to be related to this thread: https://lkml.org/lkml/2014/6/8/10

The thread suggests that the fix should be made in schedule_work rather 
than the in the aio implementation:
"I think you should fix schedule_work(), because that should be callable 
from any context"

Looking at the schedule_work function and following it through to 
__queue_work, it's calling spin_lock (which can sleep in RT) within 
rcu_read_lock (which I believe will also disable preemption requiring 
anything in between the rcu read lock to be atomic and not sleep). I 
believe this then results in the messages above.

I tried changing the spin lock for a raw spin lock and it seems to fix the 
problem for me and so far hasn't caused any adverse effects for our 
application. Despite this working, it doesn't feel like the right fix and 
I'm wondering whether anyone else has any thoughts on this? Is there a 
kinder way to fix this problem? Have I perhaps misunderstood what this 
code is actually doing?

I've attached the patch for reference.

Cheers,
Chris

--- linux-fsl-sdk-v1.6/kernel/workqueue.c       2014-09-23 
09:18:09.000000000 +0100
+++ linux-fsl-sdk-v1.6/kernel/workqueue.c       2014-09-23 
09:27:39.000000000 +0100
@@ -143,7 +143,7 @@
 /* struct worker is defined in workqueue_internal.h */
 
 struct worker_pool {
-       spinlock_t              lock;           /* the pool lock */
+       raw_spinlock_t          lock;           /* the pool lock */
        int                     cpu;            /* I: the associated cpu 
*/
        int                     node;           /* I: the associated node 
ID */
        int                     id;             /* I: pool ID */
@@ -797,7 +797,7 @@
  * Wake up the first idle worker of @pool.
  *
  * CONTEXT:
- * spin_lock_irq(pool->lock).
+ * raw_spin_lock_irq(pool->lock).
  */
 static void wake_up_worker(struct worker_pool *pool)
 {
@@ -849,7 +849,7 @@
                return;
 
        worker->sleeping = 1;
-       spin_lock_irq(&pool->lock);
+       raw_spin_lock_irq(&pool->lock);
        /*
         * The counterpart of the following dec_and_test, implied mb,
         * worklist not empty test sequence is in insert_work().
@@ -867,7 +867,7 @@
                if (next)
                        wake_up_process(next->task);
        }
-       spin_unlock_irq(&pool->lock);
+       raw_spin_unlock_irq(&pool->lock);
 }
 
 /**
@@ -881,7 +881,7 @@
  * woken up.
  *
  * CONTEXT:
- * spin_lock_irq(pool->lock)
+ * raw_spin_lock_irq(pool->lock)
  */
 static inline void worker_set_flags(struct worker *worker, unsigned int 
flags,
                                    bool wakeup)
@@ -916,7 +916,7 @@
  * Clear @flags in @worker->flags and adjust nr_running accordingly.
  *
  * CONTEXT:
- * spin_lock_irq(pool->lock)
+ * raw_spin_lock_irq(pool->lock)
  */
 static inline void worker_clr_flags(struct worker *worker, unsigned int 
flags)
 {
@@ -964,7 +964,7 @@
  * actually occurs, it should be easy to locate the culprit work 
function.
  *
  * CONTEXT:
- * spin_lock_irq(pool->lock).
+ * raw_spin_lock_irq(pool->lock).
  *
  * Return:
  * Pointer to worker which is executing @work if found, %NULL
@@ -999,7 +999,7 @@
  * nested inside outer list_for_each_entry_safe().
  *
  * CONTEXT:
- * spin_lock_irq(pool->lock).
+ * raw_spin_lock_irq(pool->lock).
  */
 static void move_linked_works(struct work_struct *work, struct list_head 
*head,
                              struct work_struct **nextp)
@@ -1077,9 +1077,9 @@
                 * As both pwqs and pools are RCU protected, the
                 * following lock operations are safe.
                 */
-               local_spin_lock_irq(pendingb_lock, &pwq->pool->lock);
+               raw_spin_lock_irq(&pwq->pool->lock);
                put_pwq(pwq);
-               local_spin_unlock_irq(pendingb_lock, &pwq->pool->lock);
+               raw_spin_unlock_irq(&pwq->pool->lock);
        }
 }
 
@@ -1110,7 +1110,7 @@
  * decrement nr_in_flight of its pwq and handle workqueue flushing.
  *
  * CONTEXT:
- * spin_lock_irq(pool->lock).
+ * raw_spin_lock_irq(pool->lock).
  */
 static void pwq_dec_nr_in_flight(struct pool_workqueue *pwq, int color)
 {
@@ -1209,7 +1209,7 @@
        if (!pool)
                goto fail;
 
-       spin_lock(&pool->lock);
+       raw_spin_lock(&pool->lock);
        /*
         * work->data is guaranteed to point to pwq only while the work
         * item is queued on pwq->wq, and both updating work->data to 
point
@@ -1238,11 +1238,11 @@
                /* work->data points to pwq iff queued, point to pool */
                set_work_pool_and_keep_pending(work, pool->id);
 
-               spin_unlock(&pool->lock);
+               raw_spin_unlock(&pool->lock);
                rcu_read_unlock();
                return 1;
        }
-       spin_unlock(&pool->lock);
+       raw_spin_unlock(&pool->lock);
 fail:
        rcu_read_unlock();
        local_unlock_irqrestore(pendingb_lock, *flags);
@@ -1263,7 +1263,7 @@
  * work_struct flags.
  *
  * CONTEXT:
- * spin_lock_irq(pool->lock).
+ * raw_spin_lock_irq(pool->lock).
  */
 static void insert_work(struct pool_workqueue *pwq, struct work_struct 
*work,
                        struct list_head *head, unsigned int extra_flags)
@@ -1346,7 +1346,7 @@
        if (last_pool && last_pool != pwq->pool) {
                struct worker *worker;
 
-               spin_lock(&last_pool->lock);
+               raw_spin_lock(&last_pool->lock);
 
                worker = find_worker_executing_work(last_pool, work);
 
@@ -1354,11 +1354,11 @@
                        pwq = worker->current_pwq;
                } else {
                        /* meh... not running there, queue here */
-                       spin_unlock(&last_pool->lock);
-                       spin_lock(&pwq->pool->lock);
+                       raw_spin_unlock(&last_pool->lock);
+                       raw_spin_lock(&pwq->pool->lock);
                }
        } else {
-               spin_lock(&pwq->pool->lock);
+               raw_spin_lock(&pwq->pool->lock);
        }
 
        /*
@@ -1371,7 +1371,7 @@
         */
        if (unlikely(!pwq->refcnt)) {
                if (wq->flags & WQ_UNBOUND) {
-                       spin_unlock(&pwq->pool->lock);
+                       raw_spin_unlock(&pwq->pool->lock);
                        cpu_relax();
                        goto retry;
                }
@@ -1401,7 +1401,7 @@
        insert_work(pwq, work, worklist, work_flags);
 
 out:
-       spin_unlock(&pwq->pool->lock);
+       raw_spin_unlock(&pwq->pool->lock);
        rcu_read_unlock();
 }
 
@@ -1554,7 +1554,7 @@
  * necessary.
  *
  * LOCKING:
- * spin_lock_irq(pool->lock).
+ * raw_spin_lock_irq(pool->lock).
  */
 static void worker_enter_idle(struct worker *worker)
 {
@@ -1594,7 +1594,7 @@
  * @worker is leaving idle state.  Update stats.
  *
  * LOCKING:
- * spin_lock_irq(pool->lock).
+ * raw_spin_lock_irq(pool->lock).
  */
 static void worker_leave_idle(struct worker *worker)
 {
@@ -1652,13 +1652,13 @@
                if (!(pool->flags & POOL_DISASSOCIATED))
                        set_cpus_allowed_ptr(current, 
pool->attrs->cpumask);
 
-               spin_lock_irq(&pool->lock);
+               raw_spin_lock_irq(&pool->lock);
                if (pool->flags & POOL_DISASSOCIATED)
                        return false;
                if (task_cpu(current) == pool->cpu &&
                    cpumask_equal(&current->cpus_allowed, 
pool->attrs->cpumask))
                        return true;
-               spin_unlock_irq(&pool->lock);
+               raw_spin_unlock_irq(&pool->lock);
 
                /*
                 * We've raced with CPU hot[un]plug.  Give it a breather
@@ -1712,11 +1712,11 @@
         * without installing the pointer.
         */
        idr_preload(GFP_KERNEL);
-       spin_lock_irq(&pool->lock);
+       raw_spin_lock_irq(&pool->lock);
 
        id = idr_alloc(&pool->worker_idr, NULL, 0, 0, GFP_NOWAIT);
 
-       spin_unlock_irq(&pool->lock);
+       raw_spin_unlock_irq(&pool->lock);
        idr_preload_end();
        if (id < 0)
                goto fail;
@@ -1758,17 +1758,17 @@
                worker->flags |= WORKER_UNBOUND;
 
        /* successful, commit the pointer to idr */
-       spin_lock_irq(&pool->lock);
+       raw_spin_lock_irq(&pool->lock);
        idr_replace(&pool->worker_idr, worker, worker->id);
-       spin_unlock_irq(&pool->lock);
+       raw_spin_unlock_irq(&pool->lock);
 
        return worker;
 
 fail:
        if (id >= 0) {
-               spin_lock_irq(&pool->lock);
+               raw_spin_lock_irq(&pool->lock);
                idr_remove(&pool->worker_idr, id);
-               spin_unlock_irq(&pool->lock);
+               raw_spin_unlock_irq(&pool->lock);
        }
        kfree(worker);
        return NULL;
@@ -1781,7 +1781,7 @@
  * Make the pool aware of @worker and start it.
  *
  * CONTEXT:
- * spin_lock_irq(pool->lock).
+ * raw_spin_lock_irq(pool->lock).
  */
 static void start_worker(struct worker *worker)
 {
@@ -1807,9 +1807,9 @@
 
        worker = create_worker(pool);
        if (worker) {
-               spin_lock_irq(&pool->lock);
+               raw_spin_lock_irq(&pool->lock);
                start_worker(worker);
-               spin_unlock_irq(&pool->lock);
+               raw_spin_unlock_irq(&pool->lock);
        }
 
        mutex_unlock(&pool->manager_mutex);
@@ -1824,7 +1824,7 @@
  * Destroy @worker and adjust @pool stats accordingly.
  *
  * CONTEXT:
- * spin_lock_irq(pool->lock) which is released and regrabbed.
+ * raw_spin_lock_irq(pool->lock) which is released and regrabbed.
  */
 static void destroy_worker(struct worker *worker)
 {
@@ -1854,20 +1854,20 @@
 
        idr_remove(&pool->worker_idr, worker->id);
 
-       spin_unlock_irq(&pool->lock);
+       raw_spin_unlock_irq(&pool->lock);
 
        kthread_stop(worker->task);
        put_task_struct(worker->task);
        kfree(worker);
 
-       spin_lock_irq(&pool->lock);
+       raw_spin_lock_irq(&pool->lock);
 }
 
 static void idle_worker_timeout(unsigned long __pool)
 {
        struct worker_pool *pool = (void *)__pool;
 
-       spin_lock_irq(&pool->lock);
+       raw_spin_lock_irq(&pool->lock);
 
        if (too_many_workers(pool)) {
                struct worker *worker;
@@ -1886,7 +1886,7 @@
                }
        }
 
-       spin_unlock_irq(&pool->lock);
+       raw_spin_unlock_irq(&pool->lock);
 }
 
 static void send_mayday(struct work_struct *work)
@@ -1912,7 +1912,7 @@
        struct work_struct *work;
 
        spin_lock_irq(&wq_mayday_lock);         /* for wq->maydays */
-       spin_lock(&pool->lock);
+       raw_spin_lock(&pool->lock);
 
        if (need_to_create_worker(pool)) {
                /*
@@ -1925,7 +1925,7 @@
                        send_mayday(work);
        }
 
-       spin_unlock(&pool->lock);
+       raw_spin_unlock(&pool->lock);
        spin_unlock_irq(&wq_mayday_lock);
 
        mod_timer(&pool->mayday_timer, jiffies + MAYDAY_INTERVAL);
@@ -1945,7 +1945,7 @@
  * may_start_working() %true.
  *
  * LOCKING:
- * spin_lock_irq(pool->lock) which may be released and regrabbed
+ * raw_spin_lock_irq(pool->lock) which may be released and regrabbed
  * multiple times.  Does GFP_KERNEL allocations.  Called only from
  * manager.
  *
@@ -1960,7 +1960,7 @@
        if (!need_to_create_worker(pool))
                return false;
 restart:
-       spin_unlock_irq(&pool->lock);
+       raw_spin_unlock_irq(&pool->lock);
 
        /* if we don't make progress in MAYDAY_INITIAL_TIMEOUT, call for 
help */
        mod_timer(&pool->mayday_timer, jiffies + MAYDAY_INITIAL_TIMEOUT);
@@ -1971,7 +1971,7 @@
                worker = create_worker(pool);
                if (worker) {
                        del_timer_sync(&pool->mayday_timer);
-                       spin_lock_irq(&pool->lock);
+                       raw_spin_lock_irq(&pool->lock);
                        start_worker(worker);
                        if (WARN_ON_ONCE(need_to_create_worker(pool)))
                                goto restart;
@@ -1989,7 +1989,7 @@
        }
 
        del_timer_sync(&pool->mayday_timer);
-       spin_lock_irq(&pool->lock);
+       raw_spin_lock_irq(&pool->lock);
        if (need_to_create_worker(pool))
                goto restart;
        return true;
@@ -2003,7 +2003,7 @@
  * IDLE_WORKER_TIMEOUT.
  *
  * LOCKING:
- * spin_lock_irq(pool->lock) which may be released and regrabbed
+ * raw_spin_lock_irq(pool->lock) which may be released and regrabbed
  * multiple times.  Called only from manager.
  *
  * Return:
@@ -2046,7 +2046,7 @@
  * and may_start_working() is true.
  *
  * CONTEXT:
- * spin_lock_irq(pool->lock) which may be released and regrabbed
+ * raw_spin_lock_irq(pool->lock) which may be released and regrabbed
  * multiple times.  Does GFP_KERNEL allocations.
  *
  * Return:
@@ -2090,9 +2090,9 @@
         * most cases.  trylock first without dropping @pool->lock.
         */
        if (unlikely(!mutex_trylock(&pool->manager_mutex))) {
-               spin_unlock_irq(&pool->lock);
+               raw_spin_unlock_irq(&pool->lock);
                mutex_lock(&pool->manager_mutex);
-               spin_lock_irq(&pool->lock);
+               raw_spin_lock_irq(&pool->lock);
                ret = true;
        }
 
@@ -2122,7 +2122,7 @@
  * call this function to process a work.
  *
  * CONTEXT:
- * spin_lock_irq(pool->lock) which is released and regrabbed.
+ * raw_spin_lock_irq(pool->lock) which is released and regrabbed.
  */
 static void process_one_work(struct worker *worker, struct work_struct 
*work)
 __releases(&pool->lock)
@@ -2198,7 +2198,7 @@
         */
        set_work_pool_and_clear_pending(work, pool->id);
 
-       spin_unlock_irq(&pool->lock);
+       raw_spin_unlock_irq(&pool->lock);
 
        lock_map_acquire_read(&pwq->wq->lockdep_map);
        lock_map_acquire(&lockdep_map);
@@ -2230,7 +2230,7 @@
         */
        cond_resched();
 
-       spin_lock_irq(&pool->lock);
+       raw_spin_lock_irq(&pool->lock);
 
        /* clear cpu intensive status */
        if (unlikely(cpu_intensive))
@@ -2254,7 +2254,7 @@
  * fetches a work from the top and executes it.
  *
  * CONTEXT:
- * spin_lock_irq(pool->lock) which may be released and regrabbed
+ * raw_spin_lock_irq(pool->lock) which may be released and regrabbed
  * multiple times.
  */
 static void process_scheduled_works(struct worker *worker)
@@ -2286,11 +2286,11 @@
        /* tell the scheduler that this is a workqueue worker */
        worker->task->flags |= PF_WQ_WORKER;
 woke_up:
-       spin_lock_irq(&pool->lock);
+       raw_spin_lock_irq(&pool->lock);
 
        /* am I supposed to die? */
        if (unlikely(worker->flags & WORKER_DIE)) {
-               spin_unlock_irq(&pool->lock);
+               raw_spin_unlock_irq(&pool->lock);
                WARN_ON_ONCE(!list_empty(&worker->entry));
                worker->task->flags &= ~PF_WQ_WORKER;
                return 0;
@@ -2352,7 +2352,7 @@
         */
        worker_enter_idle(worker);
        __set_current_state(TASK_INTERRUPTIBLE);
-       spin_unlock_irq(&pool->lock);
+       raw_spin_unlock_irq(&pool->lock);
        schedule();
        goto woke_up;
 }
@@ -2438,7 +2438,7 @@
                        wake_up_worker(pool);
 
                rescuer->pool = NULL;
-               spin_unlock(&pool->lock);
+               raw_spin_unlock(&pool->lock);
                spin_lock(&wq_mayday_lock);
        }
 
@@ -2483,7 +2483,7 @@
  * underneath us, so we can't reliably determine pwq from @target.
  *
  * CONTEXT:
- * spin_lock_irq(pool->lock).
+ * raw_spin_lock_irq(pool->lock).
  */
 static void insert_wq_barrier(struct pool_workqueue *pwq,
                              struct wq_barrier *barr,
@@ -2567,7 +2567,7 @@
        for_each_pwq(pwq, wq) {
                struct worker_pool *pool = pwq->pool;
 
-               spin_lock_irq(&pool->lock);
+               raw_spin_lock_irq(&pool->lock);
 
                if (flush_color >= 0) {
                        WARN_ON_ONCE(pwq->flush_color != -1);
@@ -2584,7 +2584,7 @@
                        pwq->work_color = work_color;
                }
 
-               spin_unlock_irq(&pool->lock);
+               raw_spin_unlock_irq(&pool->lock);
        }
 
        if (flush_color >= 0 && 
atomic_dec_and_test(&wq->nr_pwqs_to_flush))
@@ -2779,9 +2779,9 @@
        for_each_pwq(pwq, wq) {
                bool drained;
 
-               spin_lock_irq(&pwq->pool->lock);
+               raw_spin_lock_irq(&pwq->pool->lock);
                drained = !pwq->nr_active && 
list_empty(&pwq->delayed_works);
-               spin_unlock_irq(&pwq->pool->lock);
+               raw_spin_unlock_irq(&pwq->pool->lock);
 
                if (drained)
                        continue;
@@ -2816,7 +2816,7 @@
                return false;
        }
 
-       spin_lock_irq(&pool->lock);
+       raw_spin_lock_irq(&pool->lock);
        /* see the comment in try_to_grab_pending() with the same code */
        pwq = get_work_pwq(work);
        if (pwq) {
@@ -2830,7 +2830,7 @@
        }
 
        insert_wq_barrier(pwq, barr, work, worker);
-       spin_unlock_irq(&pool->lock);
+       raw_spin_unlock_irq(&pool->lock);
 
        /*
         * If @max_active is 1 or rescuer is in use, flushing another work
@@ -2846,7 +2846,7 @@
        rcu_read_unlock();
        return true;
 already_gone:
-       spin_unlock_irq(&pool->lock);
+       raw_spin_unlock_irq(&pool->lock);
        rcu_read_unlock();
        return false;
 }
@@ -3503,7 +3503,7 @@
  */
 static int init_worker_pool(struct worker_pool *pool)
 {
-       spin_lock_init(&pool->lock);
+       raw_spin_lock_init(&pool->lock);
        pool->id = -1;
        pool->cpu = -1;
        pool->node = NUMA_NO_NODE;
@@ -3579,13 +3579,13 @@
         */
        mutex_lock(&pool->manager_arb);
        mutex_lock(&pool->manager_mutex);
-       spin_lock_irq(&pool->lock);
+       raw_spin_lock_irq(&pool->lock);
 
        while ((worker = first_worker(pool)))
                destroy_worker(worker);
        WARN_ON(pool->nr_workers || pool->nr_idle);
 
-       spin_unlock_irq(&pool->lock);
+       raw_spin_unlock_irq(&pool->lock);
        mutex_unlock(&pool->manager_mutex);
        mutex_unlock(&pool->manager_arb);
 
@@ -3739,7 +3739,7 @@
        if (!freezable && pwq->max_active == wq->saved_max_active)
                return;
 
-       spin_lock_irq(&pwq->pool->lock);
+       raw_spin_lock_irq(&pwq->pool->lock);
 
        if (!freezable || !(pwq->pool->flags & POOL_FREEZING)) {
                pwq->max_active = wq->saved_max_active;
@@ -3757,7 +3757,7 @@
                pwq->max_active = 0;
        }
 
-       spin_unlock_irq(&pwq->pool->lock);
+       raw_spin_unlock_irq(&pwq->pool->lock);
 }
 
 /* initialize newly alloced @pwq which is associated with @wq and @pool 
*/
@@ -4107,9 +4107,9 @@
        goto out_unlock;
 
 use_dfl_pwq:
-       spin_lock_irq(&wq->dfl_pwq->pool->lock);
+       raw_spin_lock_irq(&wq->dfl_pwq->pool->lock);
        get_pwq(wq->dfl_pwq);
-       spin_unlock_irq(&wq->dfl_pwq->pool->lock);
+       raw_spin_unlock_irq(&wq->dfl_pwq->pool->lock);
        old_pwq = numa_pwq_tbl_install(wq, node, wq->dfl_pwq);
 out_unlock:
        mutex_unlock(&wq->mutex);
@@ -4462,10 +4462,10 @@
        rcu_read_lock();
        pool = get_work_pool(work);
        if (pool) {
-               spin_lock_irqsave(&pool->lock, flags);
+               raw_spin_lock_irqsave(&pool->lock, flags);
                if (find_worker_executing_work(pool, work))
                        ret |= WORK_BUSY_RUNNING;
-               spin_unlock_irqrestore(&pool->lock, flags);
+               raw_spin_unlock_irqrestore(&pool->lock, flags);
        }
        rcu_read_unlock();
        return ret;
@@ -4575,7 +4575,7 @@
                WARN_ON_ONCE(cpu != smp_processor_id());
 
                mutex_lock(&pool->manager_mutex);
-               spin_lock_irq(&pool->lock);
+               raw_spin_lock_irq(&pool->lock);
 
                /*
                 * We've blocked all manager operations.  Make all workers
@@ -4589,7 +4589,7 @@
 
                pool->flags |= POOL_DISASSOCIATED;
 
-               spin_unlock_irq(&pool->lock);
+               raw_spin_unlock_irq(&pool->lock);
                mutex_unlock(&pool->manager_mutex);
 
                /*
@@ -4615,9 +4615,9 @@
                 * worker blocking could lead to lengthy stalls.  Kick off
                 * unbound chain execution of currently pending work 
items.
                 */
-               spin_lock_irq(&pool->lock);
+               raw_spin_lock_irq(&pool->lock);
                wake_up_worker(pool);
-               spin_unlock_irq(&pool->lock);
+               raw_spin_unlock_irq(&pool->lock);
        }
 }
 
@@ -4645,7 +4645,7 @@
                WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task,
                                                  pool->attrs->cpumask) < 
0);
 
-       spin_lock_irq(&pool->lock);
+       raw_spin_lock_irq(&pool->lock);
 
        for_each_pool_worker(worker, wi, pool) {
                unsigned int worker_flags = worker->flags;
@@ -4682,7 +4682,7 @@
                ACCESS_ONCE(worker->flags) = worker_flags;
        }
 
-       spin_unlock_irq(&pool->lock);
+       raw_spin_unlock_irq(&pool->lock);
 }
 
 /**
@@ -4749,9 +4749,9 @@
                        mutex_lock(&pool->manager_mutex);
 
                        if (pool->cpu == cpu) {
-                               spin_lock_irq(&pool->lock);
+                               raw_spin_lock_irq(&pool->lock);
                                pool->flags &= ~POOL_DISASSOCIATED;
-                               spin_unlock_irq(&pool->lock);
+                               raw_spin_unlock_irq(&pool->lock);
 
                                rebind_workers(pool);
                        } else if (pool->cpu < 0) {
@@ -4874,10 +4874,10 @@
 
        /* set FREEZING */
        for_each_pool(pool, pi) {
-               spin_lock_irq(&pool->lock);
+               raw_spin_lock_irq(&pool->lock);
                WARN_ON_ONCE(pool->flags & POOL_FREEZING);
                pool->flags |= POOL_FREEZING;
-               spin_unlock_irq(&pool->lock);
+               raw_spin_unlock_irq(&pool->lock);
        }
 
        list_for_each_entry(wq, &workqueues, list) {
@@ -4959,10 +4959,10 @@
 
        /* clear FREEZING */
        for_each_pool(pool, pi) {
-               spin_lock_irq(&pool->lock);
+               raw_spin_lock_irq(&pool->lock);
                WARN_ON_ONCE(!(pool->flags & POOL_FREEZING));
                pool->flags &= ~POOL_FREEZING;
-               spin_unlock_irq(&pool->lock);
+               raw_spin_unlock_irq(&pool->lock);
        }
 
        /* restore max_active and repopulate worklist */

DISCLAIMER:
Privileged and/or Confidential information may be contained in this
message. If you are not the addressee of this message, you may not
copy, use or deliver this message to anyone. In such event, you
should destroy the message and kindly notify the sender by reply
e-mail. It is understood that opinions or conclusions that do not
relate to the official business of the company are neither given
nor endorsed by the company.
Thank You.
