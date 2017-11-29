From: Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] 4.4.97-rt111
Date: Wed, 29 Nov 2017 11:52:59 -0500
Message-ID: <20171129115259.170bb9a8@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com, Alex Shi <alex.shi@linaro.org>
To: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


Dear RT Folks,

I'm pleased to announce the 4.4.97-rt111 stable release.


You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.4-rt
  Head SHA1: 8a76c8160f17b98621e66686d042afdd7a981ece


Or to build 4.4.97-rt111 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.4.tar.xz

  http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.4.97.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.4/patch-4.4.97-rt111.patch.xz



You can also build from 4.4.97-rt110 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.4/incr/patch-4.4.97-rt110-rt111.patch.xz



Enjoy,

-- Steve


Changes from v4.4.97-rt110:

---

Peter Zijlstra (1):
      sched: Remove TASK_ALL

Sebastian Andrzej Siewior (6):
      timer/hrtimer: check properly for a running timer
      random: avoid preempt_disable()ed section
      sched/migrate disable: handle updated task-mask mg-dis section
      kernel/locking: use an exclusive wait_q for sleepers
      fs: convert two more BH_Uptodate_Lock related bitspinlocks
      md/raid5: do not disable interrupts

Steven Rostedt (VMware) (1):
      Linux 4.4.97-rt111

Thomas Gleixner (2):
      rtmutex: Make lock_killable work
      sched: Prevent task state corruption by spurious lock wakeup

----
 drivers/char/random.c    | 10 +++---
 drivers/md/raid5.c       |  4 +--
 fs/ext4/page-io.c        |  6 ++--
 include/linux/hrtimer.h  |  8 ++++-
 include/linux/sched.h    | 19 ++++++++++--
 kernel/fork.c            |  1 +
 kernel/locking/rtmutex.c | 21 +++++--------
 kernel/sched/core.c      | 81 +++++++++++++++++++++++++++++++++++++++++-------
 localversion-rt          |  2 +-
 9 files changed, 113 insertions(+), 39 deletions(-)
---------------------------
diff --git a/drivers/char/random.c b/drivers/char/random.c
index fecc40a69df8..46c0e27cf27f 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -260,6 +260,7 @@
 #include <linux/irq.h>
 #include <linux/syscalls.h>
 #include <linux/completion.h>
+#include <linux/locallock.h>
 
 #include <asm/processor.h>
 #include <asm/uaccess.h>
@@ -1796,6 +1797,7 @@ int random_int_secret_init(void)
 
 static DEFINE_PER_CPU(__u32 [MD5_DIGEST_WORDS], get_random_int_hash)
 		__aligned(sizeof(unsigned long));
+static DEFINE_LOCAL_IRQ_LOCK(hash_entropy_int_lock);
 
 /*
  * Get a random word for internal kernel use only. Similar to urandom but
@@ -1811,12 +1813,12 @@ unsigned int get_random_int(void)
 	if (arch_get_random_int(&ret))
 		return ret;
 
-	hash = get_cpu_var(get_random_int_hash);
+	hash = get_locked_var(hash_entropy_int_lock, get_random_int_hash);
 
 	hash[0] += current->pid + jiffies + random_get_entropy();
 	md5_transform(hash, random_int_secret);
 	ret = hash[0];
-	put_cpu_var(get_random_int_hash);
+	put_locked_var(hash_entropy_int_lock, get_random_int_hash);
 
 	return ret;
 }
@@ -1833,12 +1835,12 @@ unsigned long get_random_long(void)
 	if (arch_get_random_long(&ret))
 		return ret;
 
-	hash = get_cpu_var(get_random_int_hash);
+	hash = get_locked_var(hash_entropy_int_lock, get_random_int_hash);
 
 	hash[0] += current->pid + jiffies + random_get_entropy();
 	md5_transform(hash, random_int_secret);
 	ret = *(unsigned long *)hash;
-	put_cpu_var(get_random_int_hash);
+	put_locked_var(hash_entropy_int_lock, get_random_int_hash);
 
 	return ret;
 }
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 9b1aedb8e5df..8b236d622889 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -429,7 +429,7 @@ void raid5_release_stripe(struct stripe_head *sh)
 		md_wakeup_thread(conf->mddev->thread);
 	return;
 slow_path:
-	local_irq_save(flags);
+	local_irq_save_nort(flags);
 	/* we are ok here if STRIPE_ON_RELEASE_LIST is set or not */
 	if (atomic_dec_and_lock(&sh->count, &conf->device_lock)) {
 		INIT_LIST_HEAD(&list);
@@ -438,7 +438,7 @@ slow_path:
 		spin_unlock(&conf->device_lock);
 		release_inactive_stripe_list(conf, &list, hash);
 	}
-	local_irq_restore(flags);
+	local_irq_restore_nort(flags);
 }
 
 static inline void remove_hash(struct stripe_head *sh)
diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index 6ca56f5f72b5..9e145fe7cae0 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -97,8 +97,7 @@ static void ext4_finish_bio(struct bio *bio)
 		 * We check all buffers in the page under BH_Uptodate_Lock
 		 * to avoid races with other end io clearing async_write flags
 		 */
-		local_irq_save(flags);
-		bit_spin_lock(BH_Uptodate_Lock, &head->b_state);
+		flags = bh_uptodate_lock_irqsave(head);
 		do {
 			if (bh_offset(bh) < bio_start ||
 			    bh_offset(bh) + bh->b_size > bio_end) {
@@ -110,8 +109,7 @@ static void ext4_finish_bio(struct bio *bio)
 			if (bio->bi_error)
 				buffer_io_error(bh);
 		} while ((bh = bh->b_this_page) != head);
-		bit_spin_unlock(BH_Uptodate_Lock, &head->b_state);
-		local_irq_restore(flags);
+		bh_uptodate_unlock_irqrestore(head, flags);
 		if (!under_io) {
 #ifdef CONFIG_EXT4_FS_ENCRYPTION
 			if (ctx)
diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 8fbcdfa5dc77..ff317006d3e8 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -455,7 +455,13 @@ static inline int hrtimer_is_queued(struct hrtimer *timer)
  */
 static inline int hrtimer_callback_running(const struct hrtimer *timer)
 {
-	return timer->base->cpu_base->running == timer;
+	if (timer->base->cpu_base->running == timer)
+		return 1;
+#ifdef CONFIG_PREEMPT_RT_BASE
+	if (timer->base->cpu_base->running_soft == timer)
+		return 1;
+#endif
+	return 0;
 }
 
 /* Forward a hrtimer so it expires after now: */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index b7b001e26509..f37654adf12a 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -234,7 +234,6 @@ extern char ___assert_task_state[1 - 2*!!(
 
 /* Convenience macros for the sake of wake_up */
 #define TASK_NORMAL		(TASK_INTERRUPTIBLE | TASK_UNINTERRUPTIBLE)
-#define TASK_ALL		(TASK_NORMAL | __TASK_STOPPED | __TASK_TRACED)
 
 /* get_task_state() */
 #define TASK_REPORT		(TASK_RUNNING | TASK_INTERRUPTIBLE | \
@@ -980,8 +979,20 @@ struct wake_q_head {
 #define WAKE_Q(name)					\
 	struct wake_q_head name = { WAKE_Q_TAIL, &name.first }
 
-extern void wake_q_add(struct wake_q_head *head,
-			      struct task_struct *task);
+extern void __wake_q_add(struct wake_q_head *head,
+			 struct task_struct *task, bool sleeper);
+static inline void wake_q_add(struct wake_q_head *head,
+			      struct task_struct *task)
+{
+	__wake_q_add(head, task, false);
+}
+
+static inline void wake_q_add_sleeper(struct wake_q_head *head,
+				      struct task_struct *task)
+{
+	__wake_q_add(head, task, true);
+}
+
 extern void __wake_up_q(struct wake_q_head *head, bool sleeper);
 
 static inline void wake_up_q(struct wake_q_head *head)
@@ -1439,6 +1450,7 @@ struct task_struct {
 	unsigned int policy;
 #ifdef CONFIG_PREEMPT_RT_FULL
 	int migrate_disable;
+	int migrate_disable_update;
 # ifdef CONFIG_SCHED_DEBUG
 	int migrate_disable_atomic;
 # endif
@@ -1640,6 +1652,7 @@ struct task_struct {
 	raw_spinlock_t pi_lock;
 
 	struct wake_q_node wake_q;
+	struct wake_q_node wake_q_sleeper;
 
 #ifdef CONFIG_RT_MUTEXES
 	/* PI waiters blocked on a rt_mutex held by this task */
diff --git a/kernel/fork.c b/kernel/fork.c
index 0a873f52999f..368e770abee6 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -395,6 +395,7 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 	tsk->splice_pipe = NULL;
 	tsk->task_frag.page = NULL;
 	tsk->wake_q.next = NULL;
+	tsk->wake_q_sleeper.next = NULL;
 
 	account_kernel_stack(ti, 1);
 
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 0e9a6260441d..b5b89c51f27e 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1557,7 +1557,7 @@ static void mark_wakeup_next_waiter(struct wake_q_head *wake_q,
 	raw_spin_unlock(&current->pi_lock);
 
 	if (waiter->savestate)
-		wake_q_add(wake_sleeper_q, waiter->task);
+		wake_q_add_sleeper(wake_sleeper_q, waiter->task);
 	else
 		wake_q_add(wake_q, waiter->task);
 }
@@ -1672,18 +1672,13 @@ __rt_mutex_slowlock(struct rt_mutex *lock, int state,
 		if (try_to_take_rt_mutex(lock, current, waiter))
 			break;
 
-		/*
-		 * TASK_INTERRUPTIBLE checks for signals and
-		 * timeout. Ignored otherwise.
-		 */
-		if (unlikely(state == TASK_INTERRUPTIBLE)) {
-			/* Signal pending? */
-			if (signal_pending(current))
-				ret = -EINTR;
-			if (timeout && !timeout->task)
-				ret = -ETIMEDOUT;
-			if (ret)
-				break;
+		if (timeout && !timeout->task) {
+			ret = -ETIMEDOUT;
+			break;
+		}
+		if (signal_pending_state(state, current)) {
+			ret = -EINTR;
+			break;
 		}
 
 		if (ww_ctx && ww_ctx->acquired > 0) {
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ed9550c87f66..ed0f841d4d5c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -523,9 +523,15 @@ static bool set_nr_if_polling(struct task_struct *p)
 #endif
 #endif
 
-void wake_q_add(struct wake_q_head *head, struct task_struct *task)
+void __wake_q_add(struct wake_q_head *head, struct task_struct *task,
+		  bool sleeper)
 {
-	struct wake_q_node *node = &task->wake_q;
+	struct wake_q_node *node;
+
+	if (sleeper)
+		node = &task->wake_q_sleeper;
+	else
+		node = &task->wake_q;
 
 	/*
 	 * Atomically grab the task, if ->wake_q is !nil already it means
@@ -554,11 +560,17 @@ void __wake_up_q(struct wake_q_head *head, bool sleeper)
 	while (node != WAKE_Q_TAIL) {
 		struct task_struct *task;
 
-		task = container_of(node, struct task_struct, wake_q);
+		if (sleeper)
+			task = container_of(node, struct task_struct, wake_q_sleeper);
+		else
+			task = container_of(node, struct task_struct, wake_q);
 		BUG_ON(!task);
 		/* task can safely be re-inserted now */
 		node = node->next;
-		task->wake_q.next = NULL;
+		if (sleeper)
+			task->wake_q_sleeper.next = NULL;
+		else
+			task->wake_q.next = NULL;
 
 		/*
 		 * wake_up_process() implies a wmb() to pair with the queueing
@@ -1212,18 +1224,14 @@ void set_cpus_allowed_common(struct task_struct *p, const struct cpumask *new_ma
 	p->nr_cpus_allowed = cpumask_weight(new_mask);
 }
 
-void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
+static void __do_set_cpus_allowed_tail(struct task_struct *p,
+				       const struct cpumask *new_mask)
 {
 	struct rq *rq = task_rq(p);
 	bool queued, running;
 
 	lockdep_assert_held(&p->pi_lock);
 
-	if (__migrate_disabled(p)) {
-		cpumask_copy(&p->cpus_allowed, new_mask);
-		return;
-	}
-
 	queued = task_on_rq_queued(p);
 	running = task_current(rq, p);
 
@@ -1246,6 +1254,20 @@ void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
 		enqueue_task(rq, p, ENQUEUE_RESTORE);
 }
 
+void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
+{
+	if (__migrate_disabled(p)) {
+		lockdep_assert_held(&p->pi_lock);
+
+		cpumask_copy(&p->cpus_allowed, new_mask);
+#if defined(CONFIG_PREEMPT_RT_FULL) && defined(CONFIG_SMP)
+		p->migrate_disable_update = 1;
+#endif
+		return;
+	}
+	__do_set_cpus_allowed_tail(p, new_mask);
+}
+
 static DEFINE_PER_CPU(struct cpumask, sched_cpumasks);
 static DEFINE_MUTEX(sched_down_mutex);
 static cpumask_t sched_down_cpumask;
@@ -2212,7 +2234,7 @@ EXPORT_SYMBOL(wake_up_process);
  */
 int wake_up_lock_sleeper(struct task_struct *p)
 {
-	return try_to_wake_up(p, TASK_ALL, WF_LOCK_SLEEPER);
+	return try_to_wake_up(p, TASK_UNINTERRUPTIBLE, WF_LOCK_SLEEPER);
 }
 
 int wake_up_state(struct task_struct *p, unsigned int state)
@@ -3231,6 +3253,43 @@ void migrate_enable(void)
 	 */
 	p->migrate_disable = 0;
 
+	if (p->migrate_disable_update) {
+		unsigned long flags;
+		struct rq *rq;
+
+		rq = task_rq_lock(p, &flags);
+		update_rq_clock(rq);
+
+		__do_set_cpus_allowed_tail(p, &p->cpus_allowed);
+		task_rq_unlock(rq, p, &flags);
+
+		p->migrate_disable_update = 0;
+
+		WARN_ON(smp_processor_id() != task_cpu(p));
+		if (!cpumask_test_cpu(task_cpu(p), &p->cpus_allowed)) {
+			const struct cpumask *cpu_valid_mask = cpu_active_mask;
+			struct migration_arg arg;
+			unsigned int dest_cpu;
+
+			if (p->flags & PF_KTHREAD) {
+				/*
+				 * Kernel threads are allowed on online && !active CPUs
+				 */
+				cpu_valid_mask = cpu_online_mask;
+			}
+			dest_cpu = cpumask_any_and(cpu_valid_mask, &p->cpus_allowed);
+			arg.task = p;
+			arg.dest_cpu = dest_cpu;
+
+			unpin_current_cpu();
+			preempt_lazy_enable();
+			preempt_enable();
+			stop_one_cpu(task_cpu(p), migration_cpu_stop, &arg);
+			tlb_migrate_finish(p->mm);
+			return;
+		}
+	}
+
 	unpin_current_cpu();
 	preempt_enable();
 	preempt_lazy_enable();
diff --git a/localversion-rt b/localversion-rt
index b3e668a8fb94..9969a4b69fad 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt110
+-rt111
