From: Gregory Haskins <ghaskins@novell.com>
Subject: [PATCH 2/2] RT: Add priority inheritance to the VFCIPI facility
Date: Mon, 30 Jul 2007 17:15:44 -0400
Message-ID: <20070730211544.5162.18421.stgit@novell1.haskins.net>
References: <20070730211350.5162.99143.stgit@novell1.haskins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: ghaskins@novell.com
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from 75-130-111-13.dhcp.oxfr.ma.charter.com ([75.130.111.13]:50656
	"EHLO novell1.haskins.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S939471AbXG3VP5 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 30 Jul 2007 17:15:57 -0400
In-Reply-To: <20070730211350.5162.99143.stgit@novell1.haskins.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Signed-off-by: Gregory Haskins <ghaskins@novell.com>
---

 kernel/vfcipi/thread.c |   52 +++++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 44 insertions(+), 8 deletions(-)

diff --git a/kernel/vfcipi/thread.c b/kernel/vfcipi/thread.c
index 0f1ef90..c8a3950 100644
--- a/kernel/vfcipi/thread.c
+++ b/kernel/vfcipi/thread.c
@@ -27,6 +27,7 @@
 #include <linux/irqflags.h>
 #include <linux/module.h>
 #include <linux/cpumask.h>
+#include <linux/syscalls.h>
 
 #include <asm/atomic.h>
 #include <asm/cmpxchg.h>
@@ -62,6 +63,7 @@ struct prio_array {
 struct vfcipi_task {
 	raw_spinlock_t      lock;
 	struct task_struct *task;
+	int                 prio;
 	struct prio_array   rt_rq; /* Real-time request queue */
 	struct list_head    rq;    /* Normal request queue */
 };
@@ -120,6 +122,7 @@ static void prio_array_enqueue(struct prio_array *array,
 {
 	struct list_head *head;
 
+	BUG_ON(prio < 0);
 	BUG_ON(prio > MAX_RT_PRIO);
 
 	head = array->queue + prio;
@@ -220,9 +223,33 @@ static void vfcipi_workitem_wait(struct vfcipi_workitem *item, int wait)
 		 * function completes entirely.
 		 */
 		vfcipi_status_wait(&item->finished);
+}
+
+/*
+ * ----------------------------------------
+ * priority-inheritance helpers
+ * ----------------------------------------
+ */
 
+/* Assumes ftask->lock is held */
+static void vfcipi_task_setprio(struct vfcipi_task *ftask, int prio)
+{
+	struct sched_param param = { 0, };
+	pid_t              pid   = ftask->task->pid;
+
+	if (ftask->prio != prio) {
+		if (prio != -1) {
+			param.sched_priority = prio;
+			sys_sched_setscheduler(pid, SCHED_FIFO, &param);
+		} else {
+			sys_sched_setscheduler(pid, SCHED_NORMAL, &param);
+		}
+
+		ftask->prio = prio;
+	}
 }
 
+
 /*
  * ----------------------------------------
  * vfcipi_thread - daemon process for vfcipi per CPU
@@ -254,19 +281,29 @@ static int vfcipi_thread(void *data)
 
 		if (!qi) {
 			/* Nothing to process for now.. */
+
+			/* Set us back to normal priority */
+			vfcipi_task_setprio(ftask, -1);
+
 			set_current_state(TASK_INTERRUPTIBLE);
 			spin_unlock(&ftask->lock);
 			schedule();
 			continue;
 		}
 
+		item = qi->item;
+
+		/*
+		 * Adjust the priority of our task based on what was pulled
+		 * from the queue.  In theory, its our highest priority item
+		 */
+		vfcipi_task_setprio(ftask, item->prio);
+
 		spin_unlock(&ftask->lock);
 
 		/*
-		 * Extract the real pointer and discard the queueitem shell.
-		 * We no longer need it.
+		 * Discard the shell since the item is already extracted.
 		 */
-		item = qi->item;
 		vfcipi_heap_free(qi);
 
 		/*
@@ -306,16 +343,14 @@ static int vfcipi_enqueue(struct vfcipi_workitem *item, int cpu)
 
 	spin_lock(&ftask->lock);
 
-#ifdef NOT_YET
 	if (rt_task(current)) {
-		item->prio = task_prio(current);
+		item->prio = current->rt_priority;
 		prio_array_enqueue(&ftask->rt_rq, qi, item->prio);
 
 		/* Priority inheritance on the kthread */
-		if (task_prio(ftask->task) < item->prio)
-			set_prio_somehow(ftask->task, item->prio);
+		if (ftask->prio < item->prio)
+			vfcipi_task_setprio(ftask, item->prio);
 	} else
-#endif
 		list_add_tail(&qi->list, &ftask->rq);
 
 	wake_up_process(ftask->task);
@@ -427,6 +462,7 @@ int __init vfcipi_init(void)
 			goto out_free;
 
 		spin_lock_init(&ftask->lock);
+		ftask->prio = -1;
 		prio_array_init(&ftask->rt_rq);
 		INIT_LIST_HEAD(&ftask->rq);
 		per_cpu(vfcipi_tasks, cpu) = ftask;
