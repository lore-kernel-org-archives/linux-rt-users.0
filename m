From: Daniel Wagner <daniel.wagner@oss.bmw-carit.de>
Subject: [RFC v1 1/3] work-simple: Simple work queue implemenation
Date: Fri, 11 Jul 2014 15:26:11 +0200
Message-ID: <1405085173-20449-2-git-send-email-daniel.wagner@oss.bmw-carit.de>
References: <1405085173-20449-1-git-send-email-daniel.wagner@oss.bmw-carit.de>
Cc: Daniel Wagner <daniel.wagner@bmw-carit.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.bmw-carit.de ([62.245.222.98]:52409 "EHLO
	linuxmail.bmw-carit.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753716AbaGKNco (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 11 Jul 2014 09:32:44 -0400
In-Reply-To: <1405085173-20449-1-git-send-email-daniel.wagner@oss.bmw-carit.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

Provides a framework for enqueuing callbacks from irq context
PREEMPT_RT_FULL safe. The callbacks are executed in kthread context.

Bases on wait-simple.

Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/work-simple.h |  35 ++++++++++
 kernel/sched/Makefile       |   1 +
 kernel/sched/work-simple.c  | 165 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 201 insertions(+)
 create mode 100644 include/linux/work-simple.h
 create mode 100644 kernel/sched/work-simple.c

diff --git a/include/linux/work-simple.h b/include/linux/work-simple.h
new file mode 100644
index 0000000..4cf169b
--- /dev/null
+++ b/include/linux/work-simple.h
@@ -0,0 +1,35 @@
+#ifndef _LINUX_SWORK_H
+#define _LINUX_SWORK_H
+
+#include <linux/list.h>
+#include <linux/atomic.h>
+
+/*
+ * An event can be in one of three states:
+ *
+ * free		0: free to be used
+ * pending	1: queued, pending callback
+ */
+
+#define SWORK_EVENT_PENDING	1UL
+
+struct swork_event {
+	unsigned long flags;
+	struct list_head list;
+	void (*func)(struct swork_event *);
+};
+
+static inline void init_swork_event(struct swork_event *event,
+					void (*func)(struct swork_event *))
+{
+	event->flags = 0;
+	INIT_LIST_HEAD(&event->list);
+	event->func = func;
+}
+
+void swork_queue(struct swork_event *event);
+
+int swork_get(void);
+void swork_put(void);
+
+#endif /* _LINUX_SWORK_H */
diff --git a/kernel/sched/Makefile b/kernel/sched/Makefile
index b14a512..539e287 100644
--- a/kernel/sched/Makefile
+++ b/kernel/sched/Makefile
@@ -14,6 +14,7 @@ endif
 obj-y += core.o proc.o clock.o cputime.o
 obj-y += idle_task.o fair.o rt.o deadline.o stop_task.o
 obj-y += wait.o wait-simple.o completion.o
+obj-y += work-simple.o
 obj-$(CONFIG_SMP) += cpupri.o cpudeadline.o
 obj-$(CONFIG_SCHED_AUTOGROUP) += auto_group.o
 obj-$(CONFIG_SCHEDSTATS) += stats.o
diff --git a/kernel/sched/work-simple.c b/kernel/sched/work-simple.c
new file mode 100644
index 0000000..2a8b2ca
--- /dev/null
+++ b/kernel/sched/work-simple.c
@@ -0,0 +1,165 @@
+/*
+ * Copyright (C) 2014 BMW Car IT GmbH, Daniel Wagner <daniel.wagner@bmw-carit.de>
+ *
+ * Provides a framework for enqueuing callbacks from irq context
+ * PREEMPT_RT_FULL safe. The callbacks are executed in kthread context.
+ */
+
+#include <linux/wait-simple.h>
+#include <linux/work-simple.h>
+#include <linux/kthread.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+
+/* protect swork_data */
+static DEFINE_MUTEX(worker_mutex);
+/* there is only one work thread available */
+static struct sworker *worker;
+
+struct sworker {
+	/* all pending work_events */
+	struct list_head events;
+	struct swait_head wq;
+	/* protects the events list */
+	raw_spinlock_t lock;
+	/* kthread */
+	struct task_struct *task;
+	/* number of sworker users */
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
+	raw_spin_lock(&worker->lock);
+	r = !list_empty(&worker->events);
+	raw_spin_unlock(&worker->lock);
+
+	return r;
+}
+
+static int swork_kthread(void *arg)
+{
+	struct sworker *sw = arg;
+	struct swork_event *ev;
+
+	pr_info("swork_kthread enter\n");
+
+	for (;;) {
+		swait_event_interruptible(sw->wq,
+					swork_readable(sw));
+		if (kthread_should_stop())
+			break;
+
+		raw_spin_lock(&sw->lock);
+		while (!list_empty(&sw->events)) {
+			ev = list_first_entry(&sw->events,
+					struct swork_event, list);
+			list_del_init(&ev->list);
+
+			raw_spin_unlock(&sw->lock);
+
+			ev->func(ev);
+			xchg(&ev->flags, 0);
+
+			raw_spin_lock(&sw->lock);
+		}
+		raw_spin_unlock(&sw->lock);
+
+	}
+
+	pr_info("swork_kthread exit\n");
+	return 0;
+}
+
+static struct sworker *swork_create(void)
+{
+	struct sworker *sw;
+
+	sw = kzalloc(sizeof(*sw), GFP_KERNEL);
+	if (!sw)
+		return ERR_PTR(-ENOMEM);
+
+	INIT_LIST_HEAD(&sw->events);
+	raw_spin_lock_init(&sw->lock);
+	init_swait_head(&sw->wq);
+
+	sw->task = kthread_run(swork_kthread, sw, "swork_thread");
+	if (IS_ERR(sw->task)) {
+		kfree(sw);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	return sw;
+}
+
+static void swork_destroy(struct sworker *sw)
+{
+	struct swork_event *e, *tmp;
+
+	if (sw->task)
+		kthread_stop(sw->task);
+
+	list_for_each_entry_safe(e, tmp, &sw->events, list) {
+		list_del(&e->list);
+		e->func(e);
+	}
+
+	kfree(sw);
+}
+
+
+void swork_queue(struct swork_event *ev)
+{
+	if (cmpxchg(&ev->flags, 0, SWORK_EVENT_PENDING) != 0)
+		return;
+
+	raw_spin_lock(&worker->lock);
+	list_add(&worker->events, &ev->list);
+	raw_spin_unlock(&worker->lock);
+
+	swait_wake(&worker->wq);
+}
+EXPORT_SYMBOL_GPL(swork_queue);
+
+int swork_get(void)
+{
+	struct sworker *sw;
+
+	mutex_lock(&worker_mutex);
+	if (!worker) {
+		sw = swork_create();
+		if (IS_ERR(sw)) {
+			mutex_unlock(&worker_mutex);
+			return -ENOMEM;
+		}
+
+		worker = sw;
+	}
+
+	worker->refs++;
+	mutex_unlock(&worker_mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(swork_get);
+
+void swork_put(void)
+{
+	mutex_lock(&worker_mutex);
+
+	worker->refs--;
+	if (worker->refs > 0)
+		goto out;
+
+	swork_destroy(worker);
+	worker = NULL;
+
+out:
+	mutex_unlock(&worker_mutex);
+}
+EXPORT_SYMBOL_GPL(swork_put);
-- 
1.9.3

