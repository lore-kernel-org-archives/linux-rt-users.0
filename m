From: Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] 4.4.12-rt20
Date: Thu, 14 Jul 2016 10:56:54 -0400
Message-ID: <20160714105654.3c6eb355@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


Dear RT Folks,

I'm pleased to announce the 4.4.12-rt20 stable release.


You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.4-rt
  Head SHA1: b4059f165a21ace3e150cf8e14752bb05f27137b


Or to build 4.4.12-rt20 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-4.4.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-4.4.12.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.4/patch-4.4.12-rt20.patch.xz



You can also build from 4.4.12-rt19 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.4/incr/patch-4.4.12-rt19-rt20.patch.xz



Enjoy,

-- Steve


Changes from v4.4.12-rt19:

---

Luiz Capitulino (1):
      mm: perform lru_add_drain_all() remotely

Mike Galbraith (1):
      work-simple: Rename work-simple.[ch] to swork.[ch] for consistency

Sebastian Andrzej Siewior (2):
      locallock: add local_lock_on()
      trace: correct off by one while recording the trace-event

Steven Rostedt (Red Hat) (1):
      Linux 4.4.12-rt20

----
 arch/x86/kernel/cpu/mcheck/mce.c       |   2 +-
 drivers/thermal/x86_pkg_temp_thermal.c |   2 +-
 fs/aio.c                               |   2 +-
 include/linux/cgroup-defs.h            |   2 +-
 include/linux/locallock.h              |   6 ++
 include/linux/swork.h                  |  24 +++++
 include/linux/work-simple.h            |  24 -----
 kernel/sched/Makefile                  |   2 +-
 kernel/sched/swork.c                   | 173 +++++++++++++++++++++++++++++++++
 kernel/sched/work-simple.c             | 173 ---------------------------------
 kernel/trace/trace_events.c            |   8 ++
 localversion-rt                        |   2 +-
 mm/swap.c                              |  37 +++++--
 13 files changed, 247 insertions(+), 210 deletions(-)
---------------------------
diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index a080b4939019..430a4ec07811 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -42,7 +42,7 @@
 #include <linux/irq_work.h>
 #include <linux/export.h>
 #include <linux/jiffies.h>
-#include <linux/work-simple.h>
+#include <linux/swork.h>
 
 #include <asm/processor.h>
 #include <asm/traps.h>
diff --git a/drivers/thermal/x86_pkg_temp_thermal.c b/drivers/thermal/x86_pkg_temp_thermal.c
index a774f0c8d22b..e03fa17b8670 100644
--- a/drivers/thermal/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/x86_pkg_temp_thermal.c
@@ -29,7 +29,7 @@
 #include <linux/pm.h>
 #include <linux/thermal.h>
 #include <linux/debugfs.h>
-#include <linux/work-simple.h>
+#include <linux/swork.h>
 #include <asm/cpu_device_id.h>
 #include <asm/mce.h>
 
diff --git a/fs/aio.c b/fs/aio.c
index 14af01540288..dd8d6f234a0b 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -40,7 +40,7 @@
 #include <linux/ramfs.h>
 #include <linux/percpu-refcount.h>
 #include <linux/mount.h>
-#include <linux/work-simple.h>
+#include <linux/swork.h>
 
 #include <asm/kmap_types.h>
 #include <asm/uaccess.h>
diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 1c12de3bedbe..0cc474291e08 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -16,7 +16,7 @@
 #include <linux/percpu-refcount.h>
 #include <linux/percpu-rwsem.h>
 #include <linux/workqueue.h>
-#include <linux/work-simple.h>
+#include <linux/swork.h>
 
 #ifdef CONFIG_CGROUPS
 
diff --git a/include/linux/locallock.h b/include/linux/locallock.h
index 6fe5928fc2ab..e572a3971631 100644
--- a/include/linux/locallock.h
+++ b/include/linux/locallock.h
@@ -66,6 +66,9 @@ static inline void __local_lock(struct local_irq_lock *lv)
 #define local_lock(lvar)					\
 	do { __local_lock(&get_local_var(lvar)); } while (0)
 
+#define local_lock_on(lvar, cpu)				\
+	do { __local_lock(&per_cpu(lvar, cpu)); } while (0)
+
 static inline int __local_trylock(struct local_irq_lock *lv)
 {
 	if (lv->owner != current && spin_trylock_local(&lv->lock)) {
@@ -104,6 +107,9 @@ static inline void __local_unlock(struct local_irq_lock *lv)
 		put_local_var(lvar);				\
 	} while (0)
 
+#define local_unlock_on(lvar, cpu)                       \
+	do { __local_unlock(&per_cpu(lvar, cpu)); } while (0)
+
 static inline void __local_lock_irq(struct local_irq_lock *lv)
 {
 	spin_lock_irqsave(&lv->lock, lv->flags);
diff --git a/include/linux/swork.h b/include/linux/swork.h
new file mode 100644
index 000000000000..f175fa9a6016
--- /dev/null
+++ b/include/linux/swork.h
@@ -0,0 +1,24 @@
+#ifndef _LINUX_SWORK_H
+#define _LINUX_SWORK_H
+
+#include <linux/list.h>
+
+struct swork_event {
+	struct list_head item;
+	unsigned long flags;
+	void (*func)(struct swork_event *);
+};
+
+static inline void INIT_SWORK(struct swork_event *event,
+			      void (*func)(struct swork_event *))
+{
+	event->flags = 0;
+	event->func = func;
+}
+
+bool swork_queue(struct swork_event *sev);
+
+int swork_get(void);
+void swork_put(void);
+
+#endif /* _LINUX_SWORK_H */
diff --git a/include/linux/work-simple.h b/include/linux/work-simple.h
deleted file mode 100644
index f175fa9a6016..000000000000
--- a/include/linux/work-simple.h
+++ /dev/null
@@ -1,24 +0,0 @@
-#ifndef _LINUX_SWORK_H
-#define _LINUX_SWORK_H
-
-#include <linux/list.h>
-
-struct swork_event {
-	struct list_head item;
-	unsigned long flags;
-	void (*func)(struct swork_event *);
-};
-
-static inline void INIT_SWORK(struct swork_event *event,
-			      void (*func)(struct swork_event *))
-{
-	event->flags = 0;
-	event->func = func;
-}
-
-bool swork_queue(struct swork_event *sev);
-
-int swork_get(void);
-void swork_put(void);
-
-#endif /* _LINUX_SWORK_H */
diff --git a/kernel/sched/Makefile b/kernel/sched/Makefile
index debedbee5692..01b9994b367a 100644
--- a/kernel/sched/Makefile
+++ b/kernel/sched/Makefile
@@ -13,7 +13,7 @@ endif
 
 obj-y += core.o loadavg.o clock.o cputime.o
 obj-y += idle_task.o fair.o rt.o deadline.o stop_task.o
-obj-y += wait.o swait.o work-simple.o completion.o idle.o
+obj-y += wait.o swait.o swork.o completion.o idle.o
 obj-$(CONFIG_SMP) += cpupri.o cpudeadline.o
 obj-$(CONFIG_SCHED_AUTOGROUP) += auto_group.o
 obj-$(CONFIG_SCHEDSTATS) += stats.o
diff --git a/kernel/sched/swork.c b/kernel/sched/swork.c
new file mode 100644
index 000000000000..1950f40ca725
--- /dev/null
+++ b/kernel/sched/swork.c
@@ -0,0 +1,173 @@
+/*
+ * Copyright (C) 2014 BMW Car IT GmbH, Daniel Wagner daniel.wagner@bmw-carit.de
+ *
+ * Provides a framework for enqueuing callbacks from irq context
+ * PREEMPT_RT_FULL safe. The callbacks are executed in kthread context.
+ */
+
+#include <linux/swait.h>
+#include <linux/swork.h>
+#include <linux/kthread.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/export.h>
+
+#define SWORK_EVENT_PENDING     (1 << 0)
+
+static DEFINE_MUTEX(worker_mutex);
+static struct sworker *glob_worker;
+
+struct sworker {
+	struct list_head events;
+	struct swait_queue_head wq;
+
+	raw_spinlock_t lock;
+
+	struct task_struct *task;
+	int refs;
+};
+
+static bool swork_readable(struct sworker *worker)
+{
+	bool r;
+
+	if (kthread_should_stop())
+		return true;
+
+	raw_spin_lock_irq(&worker->lock);
+	r = !list_empty(&worker->events);
+	raw_spin_unlock_irq(&worker->lock);
+
+	return r;
+}
+
+static int swork_kthread(void *arg)
+{
+	struct sworker *worker = arg;
+
+	for (;;) {
+		swait_event_interruptible(worker->wq,
+					swork_readable(worker));
+		if (kthread_should_stop())
+			break;
+
+		raw_spin_lock_irq(&worker->lock);
+		while (!list_empty(&worker->events)) {
+			struct swork_event *sev;
+
+			sev = list_first_entry(&worker->events,
+					struct swork_event, item);
+			list_del(&sev->item);
+			raw_spin_unlock_irq(&worker->lock);
+
+			WARN_ON_ONCE(!test_and_clear_bit(SWORK_EVENT_PENDING,
+							 &sev->flags));
+			sev->func(sev);
+			raw_spin_lock_irq(&worker->lock);
+		}
+		raw_spin_unlock_irq(&worker->lock);
+	}
+	return 0;
+}
+
+static struct sworker *swork_create(void)
+{
+	struct sworker *worker;
+
+	worker = kzalloc(sizeof(*worker), GFP_KERNEL);
+	if (!worker)
+		return ERR_PTR(-ENOMEM);
+
+	INIT_LIST_HEAD(&worker->events);
+	raw_spin_lock_init(&worker->lock);
+	init_swait_queue_head(&worker->wq);
+
+	worker->task = kthread_run(swork_kthread, worker, "kswork");
+	if (IS_ERR(worker->task)) {
+		kfree(worker);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	return worker;
+}
+
+static void swork_destroy(struct sworker *worker)
+{
+	kthread_stop(worker->task);
+
+	WARN_ON(!list_empty(&worker->events));
+	kfree(worker);
+}
+
+/**
+ * swork_queue - queue swork
+ *
+ * Returns %false if @work was already on a queue, %true otherwise.
+ *
+ * The work is queued and processed on a random CPU
+ */
+bool swork_queue(struct swork_event *sev)
+{
+	unsigned long flags;
+
+	if (test_and_set_bit(SWORK_EVENT_PENDING, &sev->flags))
+		return false;
+
+	raw_spin_lock_irqsave(&glob_worker->lock, flags);
+	list_add_tail(&sev->item, &glob_worker->events);
+	raw_spin_unlock_irqrestore(&glob_worker->lock, flags);
+
+	swake_up(&glob_worker->wq);
+	return true;
+}
+EXPORT_SYMBOL_GPL(swork_queue);
+
+/**
+ * swork_get - get an instance of the sworker
+ *
+ * Returns an negative error code if the initialization if the worker did not
+ * work, %0 otherwise.
+ *
+ */
+int swork_get(void)
+{
+	struct sworker *worker;
+
+	mutex_lock(&worker_mutex);
+	if (!glob_worker) {
+		worker = swork_create();
+		if (IS_ERR(worker)) {
+			mutex_unlock(&worker_mutex);
+			return -ENOMEM;
+		}
+
+		glob_worker = worker;
+	}
+
+	glob_worker->refs++;
+	mutex_unlock(&worker_mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(swork_get);
+
+/**
+ * swork_put - puts an instance of the sworker
+ *
+ * Will destroy the sworker thread. This function must not be called until all
+ * queued events have been completed.
+ */
+void swork_put(void)
+{
+	mutex_lock(&worker_mutex);
+
+	glob_worker->refs--;
+	if (glob_worker->refs > 0)
+		goto out;
+
+	swork_destroy(glob_worker);
+	glob_worker = NULL;
+out:
+	mutex_unlock(&worker_mutex);
+}
+EXPORT_SYMBOL_GPL(swork_put);
diff --git a/kernel/sched/work-simple.c b/kernel/sched/work-simple.c
deleted file mode 100644
index 9ffe40543c81..000000000000
--- a/kernel/sched/work-simple.c
+++ /dev/null
@@ -1,173 +0,0 @@
-/*
- * Copyright (C) 2014 BMW Car IT GmbH, Daniel Wagner daniel.wagner@bmw-carit.de
- *
- * Provides a framework for enqueuing callbacks from irq context
- * PREEMPT_RT_FULL safe. The callbacks are executed in kthread context.
- */
-
-#include <linux/swait.h>
-#include <linux/work-simple.h>
-#include <linux/kthread.h>
-#include <linux/slab.h>
-#include <linux/spinlock.h>
-#include <linux/export.h>
-
-#define SWORK_EVENT_PENDING     (1 << 0)
-
-static DEFINE_MUTEX(worker_mutex);
-static struct sworker *glob_worker;
-
-struct sworker {
-	struct list_head events;
-	struct swait_queue_head wq;
-
-	raw_spinlock_t lock;
-
-	struct task_struct *task;
-	int refs;
-};
-
-static bool swork_readable(struct sworker *worker)
-{
-	bool r;
-
-	if (kthread_should_stop())
-		return true;
-
-	raw_spin_lock_irq(&worker->lock);
-	r = !list_empty(&worker->events);
-	raw_spin_unlock_irq(&worker->lock);
-
-	return r;
-}
-
-static int swork_kthread(void *arg)
-{
-	struct sworker *worker = arg;
-
-	for (;;) {
-		swait_event_interruptible(worker->wq,
-					swork_readable(worker));
-		if (kthread_should_stop())
-			break;
-
-		raw_spin_lock_irq(&worker->lock);
-		while (!list_empty(&worker->events)) {
-			struct swork_event *sev;
-
-			sev = list_first_entry(&worker->events,
-					struct swork_event, item);
-			list_del(&sev->item);
-			raw_spin_unlock_irq(&worker->lock);
-
-			WARN_ON_ONCE(!test_and_clear_bit(SWORK_EVENT_PENDING,
-							 &sev->flags));
-			sev->func(sev);
-			raw_spin_lock_irq(&worker->lock);
-		}
-		raw_spin_unlock_irq(&worker->lock);
-	}
-	return 0;
-}
-
-static struct sworker *swork_create(void)
-{
-	struct sworker *worker;
-
-	worker = kzalloc(sizeof(*worker), GFP_KERNEL);
-	if (!worker)
-		return ERR_PTR(-ENOMEM);
-
-	INIT_LIST_HEAD(&worker->events);
-	raw_spin_lock_init(&worker->lock);
-	init_swait_queue_head(&worker->wq);
-
-	worker->task = kthread_run(swork_kthread, worker, "kswork");
-	if (IS_ERR(worker->task)) {
-		kfree(worker);
-		return ERR_PTR(-ENOMEM);
-	}
-
-	return worker;
-}
-
-static void swork_destroy(struct sworker *worker)
-{
-	kthread_stop(worker->task);
-
-	WARN_ON(!list_empty(&worker->events));
-	kfree(worker);
-}
-
-/**
- * swork_queue - queue swork
- *
- * Returns %false if @work was already on a queue, %true otherwise.
- *
- * The work is queued and processed on a random CPU
- */
-bool swork_queue(struct swork_event *sev)
-{
-	unsigned long flags;
-
-	if (test_and_set_bit(SWORK_EVENT_PENDING, &sev->flags))
-		return false;
-
-	raw_spin_lock_irqsave(&glob_worker->lock, flags);
-	list_add_tail(&sev->item, &glob_worker->events);
-	raw_spin_unlock_irqrestore(&glob_worker->lock, flags);
-
-	swake_up(&glob_worker->wq);
-	return true;
-}
-EXPORT_SYMBOL_GPL(swork_queue);
-
-/**
- * swork_get - get an instance of the sworker
- *
- * Returns an negative error code if the initialization if the worker did not
- * work, %0 otherwise.
- *
- */
-int swork_get(void)
-{
-	struct sworker *worker;
-
-	mutex_lock(&worker_mutex);
-	if (!glob_worker) {
-		worker = swork_create();
-		if (IS_ERR(worker)) {
-			mutex_unlock(&worker_mutex);
-			return -ENOMEM;
-		}
-
-		glob_worker = worker;
-	}
-
-	glob_worker->refs++;
-	mutex_unlock(&worker_mutex);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(swork_get);
-
-/**
- * swork_put - puts an instance of the sworker
- *
- * Will destroy the sworker thread. This function must not be called until all
- * queued events have been completed.
- */
-void swork_put(void)
-{
-	mutex_lock(&worker_mutex);
-
-	glob_worker->refs--;
-	if (glob_worker->refs > 0)
-		goto out;
-
-	swork_destroy(glob_worker);
-	glob_worker = NULL;
-out:
-	mutex_unlock(&worker_mutex);
-}
-EXPORT_SYMBOL_GPL(swork_put);
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 4a48f97a2256..5bd79b347398 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -246,6 +246,14 @@ void *trace_event_buffer_reserve(struct trace_event_buffer *fbuffer,
 
 	local_save_flags(fbuffer->flags);
 	fbuffer->pc = preempt_count();
+	/*
+	 * If CONFIG_PREEMPT is enabled, then the tracepoint itself disables
+	 * preemption (adding one to the preempt_count). Since we are
+	 * interested in the preempt_count at the time the tracepoint was
+	 * hit, we need to subtract one to offset the increment.
+	 */
+	if (IS_ENABLED(CONFIG_PREEMPT))
+		fbuffer->pc--;
 	fbuffer->trace_file = trace_file;
 
 	fbuffer->event =
diff --git a/localversion-rt b/localversion-rt
index 483ad771f201..e095ab819714 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt19
+-rt20
diff --git a/mm/swap.c b/mm/swap.c
index ca194aeb45d0..ad16649221d7 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -821,9 +821,15 @@ void lru_add_drain_cpu(int cpu)
 		unsigned long flags;
 
 		/* No harm done if a racing interrupt already did this */
+#ifdef CONFIG_PREEMPT_RT_BASE
+		local_lock_irqsave_on(rotate_lock, flags, cpu);
+		pagevec_move_tail(pvec);
+		local_unlock_irqrestore_on(rotate_lock, flags, cpu);
+#else
 		local_lock_irqsave(rotate_lock, flags);
 		pagevec_move_tail(pvec);
 		local_unlock_irqrestore(rotate_lock, flags);
+#endif
 	}
 
 	pvec = &per_cpu(lru_deactivate_file_pvecs, cpu);
@@ -866,12 +872,32 @@ void lru_add_drain(void)
 	local_unlock_cpu(swapvec_lock);
 }
 
+
+#ifdef CONFIG_PREEMPT_RT_BASE
+static inline void remote_lru_add_drain(int cpu, struct cpumask *has_work)
+{
+	local_lock_on(swapvec_lock, cpu);
+	lru_add_drain_cpu(cpu);
+	local_unlock_on(swapvec_lock, cpu);
+}
+
+#else
+
 static void lru_add_drain_per_cpu(struct work_struct *dummy)
 {
 	lru_add_drain();
 }
 
 static DEFINE_PER_CPU(struct work_struct, lru_add_drain_work);
+static inline void remote_lru_add_drain(int cpu, struct cpumask *has_work)
+{
+	struct work_struct *work = &per_cpu(lru_add_drain_work, cpu);
+
+	INIT_WORK(work, lru_add_drain_per_cpu);
+	schedule_work_on(cpu, work);
+	cpumask_set_cpu(cpu, has_work);
+}
+#endif
 
 void lru_add_drain_all(void)
 {
@@ -884,20 +910,17 @@ void lru_add_drain_all(void)
 	cpumask_clear(&has_work);
 
 	for_each_online_cpu(cpu) {
-		struct work_struct *work = &per_cpu(lru_add_drain_work, cpu);
-
 		if (pagevec_count(&per_cpu(lru_add_pvec, cpu)) ||
 		    pagevec_count(&per_cpu(lru_rotate_pvecs, cpu)) ||
 		    pagevec_count(&per_cpu(lru_deactivate_file_pvecs, cpu)) ||
-		    need_activate_page_drain(cpu)) {
-			INIT_WORK(work, lru_add_drain_per_cpu);
-			schedule_work_on(cpu, work);
-			cpumask_set_cpu(cpu, &has_work);
-		}
+		    need_activate_page_drain(cpu))
+			remote_lru_add_drain(cpu, &has_work);
 	}
 
+#ifndef CONFIG_PREEMPT_RT_BASE
 	for_each_cpu(cpu, &has_work)
 		flush_work(&per_cpu(lru_add_drain_work, cpu));
+#endif
 
 	put_online_cpus();
 	mutex_unlock(&lock);
