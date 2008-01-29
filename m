From: Daniel Walker <dwalker@mvista.com>
Subject: [PATCH] fix workqueue plist init to include a spinlock
Date: Tue, 29 Jan 2008 09:04:18 -0800
Message-ID: <20080129170230.209662753__28317.7829500803$1201626468$gmane$org@mvista.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: mingo@elte.hu
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933382AbYA2RGb@vger.kernel.org>
Message-Id: <20080129170230.209662753@mvista.com>
Date: Tue, 29 Jan 2008 09:02:30 -0800
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Kevin Hilman <khilman@mvista.com>
Cc: linux-rt-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

The lock field in plist_head_init() is used for debugging the plist,
and if a NULL is sent in it spews constant errors with debugging enabled ..
So I added what looks like the correct spinlocks into the plist_head_init().

Signed-off-by: Daniel Walker <dwalker@mvista.com>

---
 kernel/workqueue.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.24/kernel/workqueue.c
===================================================================
--- linux-2.6.24.orig/kernel/workqueue.c
+++ linux-2.6.24/kernel/workqueue.c
@@ -415,7 +415,7 @@ static void insert_wq_barrier(struct cpu
 	INIT_WORK(&barr->work, wq_barrier_func);
 	__set_bit(WORK_STRUCT_PENDING, work_data_bits(&barr->work));
 
-	plist_head_init(&barr->worklist, NULL);
+	plist_head_init(&barr->worklist, &cwq->lock);
 	plist_head_splice(&cwq->worklist, &barr->worklist);
 	barr->cwq = cwq;
 	init_completion(&barr->done);
@@ -845,7 +845,7 @@ init_cpu_workqueue(struct workqueue_stru
 
 	cwq->wq = wq;
 	spin_lock_init(&cwq->lock);
-	plist_head_init(&cwq->worklist, NULL);
+	plist_head_init(&cwq->worklist, &cwq->lock);
 	init_waitqueue_head(&cwq->more_work);
 	cwq->barrier = NULL;
 	init_waitqueue_head(&cwq->work_done);
-- 

-- 
