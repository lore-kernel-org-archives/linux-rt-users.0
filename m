From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: [rfc patch 1/2]  rt/locking/hotplug: Kill
 hotplug_lock()/hotplug_unlock()
Date: Tue, 05 Apr 2016 14:49:47 +0200
Message-ID: <1459860587.7776.1.camel@gmail.com>
References: <1455318168-7125-1-git-send-email-bigeasy@linutronix.de>
	 <1455318168-7125-4-git-send-email-bigeasy@linutronix.de>
	 <1458463425.3908.5.camel@gmail.com> <1458814024.23732.35.camel@gmail.com>
	 <alpine.DEB.2.11.1603241140510.3978@nanos>
	 <1459405903.14336.64.camel@gmail.com>
	 <20160401211105.GE29603@linutronix.de> <1459566735.3779.36.camel@gmail.com>
	 <1459837988.26938.16.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459837988.26938.16.camel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


This lock is itself a source of hotplug deadlocks for RT:

1. kernfs_mutex is taken during hotplug, so any path other than hotplug
meeting hotplug_lock() thus deadlocks us.

2. notifier dependency upon RCU GP threads, same meeting hotplug_lock()
deadlocks us.

Removing it. Start migration immediately, do not stop migrating until the
cpu is down.  Have caller poll ->refcount before actually taking it down.
If someone manages to sneak in before we wake the migration thread, it
returns -EBUSY, and caller tries polling one more time.

Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>
---
 kernel/cpu.c |  267 ++++++++++-------------------------------------------------
 1 file changed, 47 insertions(+), 220 deletions(-)

--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -23,6 +23,7 @@
 #include <linux/tick.h>
 #include <linux/irq.h>
 #include <linux/smpboot.h>
+#include <linux/delay.h>
 
 #include <trace/events/power.h>
 #define CREATE_TRACE_POINTS
@@ -166,49 +167,14 @@ static struct {
 
 /**
  * hotplug_pcp	- per cpu hotplug descriptor
- * @unplug:	set when pin_current_cpu() needs to sync tasks
- * @sync_tsk:	the task that waits for tasks to finish pinned sections
  * @refcount:	counter of tasks in pinned sections
- * @grab_lock:	set when the tasks entering pinned sections should wait
- * @synced:	notifier for @sync_tsk to tell cpu_down it's finished
- * @mutex:	the mutex to make tasks wait (used when @grab_lock is true)
- * @mutex_init:	zero if the mutex hasn't been initialized yet.
- *
- * Although @unplug and @sync_tsk may point to the same task, the @unplug
- * is used as a flag and still exists after @sync_tsk has exited and
- * @sync_tsk set to NULL.
+ * @migrate:	set when the tasks entering/leaving pinned sections should migrate
  */
 struct hotplug_pcp {
-	struct task_struct *unplug;
-	struct task_struct *sync_tsk;
 	int refcount;
-	int grab_lock;
-	struct completion synced;
-	struct completion unplug_wait;
-#ifdef CONFIG_PREEMPT_RT_FULL
-	/*
-	 * Note, on PREEMPT_RT, the hotplug lock must save the state of
-	 * the task, otherwise the mutex will cause the task to fail
-	 * to sleep when required. (Because it's called from migrate_disable())
-	 *
-	 * The spinlock_t on PREEMPT_RT is a mutex that saves the task's
-	 * state.
-	 */
-	spinlock_t lock;
-#else
-	struct mutex mutex;
-#endif
-	int mutex_init;
+	int migrate;
 };
 
-#ifdef CONFIG_PREEMPT_RT_FULL
-# define hotplug_lock(hp) rt_spin_lock__no_mg(&(hp)->lock)
-# define hotplug_unlock(hp) rt_spin_unlock__no_mg(&(hp)->lock)
-#else
-# define hotplug_lock(hp) mutex_lock(&(hp)->mutex)
-# define hotplug_unlock(hp) mutex_unlock(&(hp)->mutex)
-#endif
-
 static DEFINE_PER_CPU(struct hotplug_pcp, hotplug_pcp);
 
 /**
@@ -221,42 +187,20 @@ static DEFINE_PER_CPU(struct hotplug_pcp
  */
 void pin_current_cpu(void)
 {
-	struct hotplug_pcp *hp;
-	int force = 0;
-
-retry:
-	hp = this_cpu_ptr(&hotplug_pcp);
+	struct hotplug_pcp *hp = this_cpu_ptr(&hotplug_pcp);
 
-	if (!hp->unplug || hp->refcount || force || preempt_count() > 1 ||
-	    hp->unplug == current) {
+	if (!hp->migrate) {
 		hp->refcount++;
 		return;
 	}
-	if (hp->grab_lock) {
-		preempt_enable();
-		hotplug_lock(hp);
-		hotplug_unlock(hp);
-	} else {
-		preempt_enable();
-		/*
-		 * Try to push this task off of this CPU.
-		 */
-		if (!migrate_me()) {
-			preempt_disable();
-			hp = this_cpu_ptr(&hotplug_pcp);
-			if (!hp->grab_lock) {
-				/*
-				 * Just let it continue it's already pinned
-				 * or about to sleep.
-				 */
-				force = 1;
-				goto retry;
-			}
-			preempt_enable();
-		}
-	}
+
+	/*
+	 * Try to push this task off of this CPU.
+	 */
+	preempt_enable_no_resched();
+	migrate_me();
 	preempt_disable();
-	goto retry;
+	this_cpu_ptr(&hotplug_pcp)->refcount++;
 }
 
 /**
@@ -268,182 +212,54 @@ void unpin_current_cpu(void)
 {
 	struct hotplug_pcp *hp = this_cpu_ptr(&hotplug_pcp);
 
-	WARN_ON(hp->refcount <= 0);
-
-	/* This is safe. sync_unplug_thread is pinned to this cpu */
-	if (!--hp->refcount && hp->unplug && hp->unplug != current)
-		wake_up_process(hp->unplug);
-}
-
-static void wait_for_pinned_cpus(struct hotplug_pcp *hp)
-{
-	set_current_state(TASK_UNINTERRUPTIBLE);
-	while (hp->refcount) {
-		schedule_preempt_disabled();
-		set_current_state(TASK_UNINTERRUPTIBLE);
-	}
-}
-
-static int sync_unplug_thread(void *data)
-{
-	struct hotplug_pcp *hp = data;
-
-	wait_for_completion(&hp->unplug_wait);
-	preempt_disable();
-	hp->unplug = current;
-	wait_for_pinned_cpus(hp);
-
-	/*
-	 * This thread will synchronize the cpu_down() with threads
-	 * that have pinned the CPU. When the pinned CPU count reaches
-	 * zero, we inform the cpu_down code to continue to the next step.
-	 */
-	set_current_state(TASK_UNINTERRUPTIBLE);
-	preempt_enable();
-	complete(&hp->synced);
-
-	/*
-	 * If all succeeds, the next step will need tasks to wait till
-	 * the CPU is offline before continuing. To do this, the grab_lock
-	 * is set and tasks going into pin_current_cpu() will block on the
-	 * mutex. But we still need to wait for those that are already in
-	 * pinned CPU sections. If the cpu_down() failed, the kthread_should_stop()
-	 * will kick this thread out.
-	 */
-	while (!hp->grab_lock && !kthread_should_stop()) {
-		schedule();
-		set_current_state(TASK_UNINTERRUPTIBLE);
-	}
-
-	/* Make sure grab_lock is seen before we see a stale completion */
-	smp_mb();
-
-	/*
-	 * Now just before cpu_down() enters stop machine, we need to make
-	 * sure all tasks that are in pinned CPU sections are out, and new
-	 * tasks will now grab the lock, keeping them from entering pinned
-	 * CPU sections.
-	 */
-	if (!kthread_should_stop()) {
-		preempt_disable();
-		wait_for_pinned_cpus(hp);
-		preempt_enable();
-		complete(&hp->synced);
-	}
+	WARN_ON(hp->refcount-- <= 0);
 
-	set_current_state(TASK_UNINTERRUPTIBLE);
-	while (!kthread_should_stop()) {
-		schedule();
-		set_current_state(TASK_UNINTERRUPTIBLE);
-	}
-	set_current_state(TASK_RUNNING);
+	if (!hp->migrate)
+		return;
 
 	/*
-	 * Force this thread off this CPU as it's going down and
-	 * we don't want any more work on this CPU.
+	 * Try to push this task off of this CPU.
 	 */
-	current->flags &= ~PF_NO_SETAFFINITY;
-	set_cpus_allowed_ptr(current, cpu_present_mask);
+	preempt_enable_no_resched();
 	migrate_me();
-	return 0;
-}
-
-static void __cpu_unplug_sync(struct hotplug_pcp *hp)
-{
-	wake_up_process(hp->sync_tsk);
-	wait_for_completion(&hp->synced);
+	preempt_disable();
 }
 
-static void __cpu_unplug_wait(unsigned int cpu)
+static void wait_for_pinned_cpus(struct hotplug_pcp *hp)
 {
-	struct hotplug_pcp *hp = &per_cpu(hotplug_pcp, cpu);
-
-	complete(&hp->unplug_wait);
-	wait_for_completion(&hp->synced);
+	while (hp->refcount) {
+		trace_printk("CHILL\n");
+		cpu_chill();
+	}
 }
 
 /*
- * Start the sync_unplug_thread on the target cpu and wait for it to
- * complete.
+ * Start migration of pinned tasks on the target cpu.
  */
 static int cpu_unplug_begin(unsigned int cpu)
 {
 	struct hotplug_pcp *hp = &per_cpu(hotplug_pcp, cpu);
-	int err;
-
-	/* Protected by cpu_hotplug.lock */
-	if (!hp->mutex_init) {
-#ifdef CONFIG_PREEMPT_RT_FULL
-		spin_lock_init(&hp->lock);
-#else
-		mutex_init(&hp->mutex);
-#endif
-		hp->mutex_init = 1;
-	}
 
 	/* Inform the scheduler to migrate tasks off this CPU */
 	tell_sched_cpu_down_begin(cpu);
+	hp->migrate = 1;
 
-	init_completion(&hp->synced);
-	init_completion(&hp->unplug_wait);
-
-	hp->sync_tsk = kthread_create(sync_unplug_thread, hp, "sync_unplug/%d", cpu);
-	if (IS_ERR(hp->sync_tsk)) {
-		err = PTR_ERR(hp->sync_tsk);
-		hp->sync_tsk = NULL;
-		return err;
-	}
-	kthread_bind(hp->sync_tsk, cpu);
+	/* Let all tasks know cpu unplug is starting */
+	smp_rmb();
 
-	/*
-	 * Wait for tasks to get out of the pinned sections,
-	 * it's still OK if new tasks enter. Some CPU notifiers will
-	 * wait for tasks that are going to enter these sections and
-	 * we must not have them block.
-	 */
-	wake_up_process(hp->sync_tsk);
 	return 0;
 }
 
-static void cpu_unplug_sync(unsigned int cpu)
-{
-	struct hotplug_pcp *hp = &per_cpu(hotplug_pcp, cpu);
-
-	init_completion(&hp->synced);
-	/* The completion needs to be initialzied before setting grab_lock */
-	smp_wmb();
-
-	/* Grab the mutex before setting grab_lock */
-	hotplug_lock(hp);
-	hp->grab_lock = 1;
-
-	/*
-	 * The CPU notifiers have been completed.
-	 * Wait for tasks to get out of pinned CPU sections and have new
-	 * tasks block until the CPU is completely down.
-	 */
-	__cpu_unplug_sync(hp);
-
-	/* All done with the sync thread */
-	kthread_stop(hp->sync_tsk);
-	hp->sync_tsk = NULL;
-}
-
 static void cpu_unplug_done(unsigned int cpu)
 {
 	struct hotplug_pcp *hp = &per_cpu(hotplug_pcp, cpu);
 
-	hp->unplug = NULL;
-	/* Let all tasks know cpu unplug is finished before cleaning up */
+	/* Let all tasks know cpu unplug is finished */
 	smp_wmb();
 
-	if (hp->sync_tsk)
-		kthread_stop(hp->sync_tsk);
-
-	if (hp->grab_lock) {
-		hotplug_unlock(hp);
+	if (hp->migrate) {
 		/* protected by cpu_hotplug.lock */
-		hp->grab_lock = 0;
+		hp->migrate = 0;
 	}
 	tell_sched_cpu_down_done(cpu);
 }
@@ -951,6 +767,10 @@ static int take_cpu_down(void *_param)
 	enum cpuhp_state target = max((int)st->target, CPUHP_AP_OFFLINE);
 	int err, cpu = smp_processor_id();
 
+	/* RT: too bad, some task snuck in on the way here */
+	if (this_cpu_ptr(&hotplug_pcp)->refcount)
+		return -EBUSY;
+
 	/* Ensure this CPU doesn't handle any more interrupts. */
 	err = __cpu_disable();
 	if (err < 0)
@@ -972,7 +792,7 @@ static int take_cpu_down(void *_param)
 static int takedown_cpu(unsigned int cpu)
 {
 	struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, cpu);
-	int err;
+	int err, once = 0;
 
 	/*
 	 * By now we've cleared cpu_active_mask, wait for all preempt-disabled
@@ -989,25 +809,32 @@ static int takedown_cpu(unsigned int cpu
 	else
 		synchronize_rcu();
 
-	__cpu_unplug_wait(cpu);
-
 	/* Park the smpboot threads */
 	kthread_park(per_cpu_ptr(&cpuhp_state, cpu)->thread);
 	smpboot_park_threads(cpu);
 
-	/* Notifiers are done. Don't let any more tasks pin this CPU. */
-	cpu_unplug_sync(cpu);
-
 	/*
 	 * Prevent irq alloc/free while the dying cpu reorganizes the
 	 * interrupt affinities.
 	 */
 	irq_lock_sparse();
 
+again:
+	/* Notifiers are done.  Check for late references */
+	wait_for_pinned_cpus(&per_cpu(hotplug_pcp, cpu));
+
 	/*
 	 * So now all preempt/rcu users must observe !cpu_active().
 	 */
 	err = stop_machine(take_cpu_down, NULL, cpumask_of(cpu));
+	if (err == -EBUSY) {
+		if (!once) {
+			trace_printk("BUSY, trying again\n");
+			once++;
+			goto again;
+		}
+		trace_printk("CRAP, still busy.  Deal with it caller\n");
+	}
 	if (err) {
 		/* CPU didn't die: tell everyone.  Can't complain. */
 		cpu_notify_nofail(CPU_DOWN_FAILED, cpu);
