From: Scott Wood <swood@redhat.com>
Subject: [PATCH RT] rtmutex: Flush block plug on __down_read()
Date: Fri,  4 Jan 2019 15:33:21 -0500
Message-ID: <1546634001-4450-1-git-send-email-swood@redhat.com>
Cc: Mikulas Patocka <mpatocka@redhat.com>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Scott Wood <swood@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

__down_read() bypasses the rtmutex frontend to call
rt_mutex_slowlock_locked() directly, and thus it needs to call
blk_schedule_flush_flug() itself.

Signed-off-by: Scott Wood <swood@redhat.com>
---
 kernel/locking/rwsem-rt.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/locking/rwsem-rt.c b/kernel/locking/rwsem-rt.c
index 660e22caf709..f73cd4eda5cd 100644
--- a/kernel/locking/rwsem-rt.c
+++ b/kernel/locking/rwsem-rt.c
@@ -1,5 +1,6 @@
 /*
  */
+#include <linux/blkdev.h>
 #include <linux/rwsem.h>
 #include <linux/sched/debug.h>
 #include <linux/sched/signal.h>
@@ -88,6 +89,15 @@ static int __sched __down_read_common(struct rw_semaphore *sem, int state)
 	if (__down_read_trylock(sem))
 		return 0;
 
+	/*
+	 * If sem->rtmutex blocks, the function sched_submit_work will not
+	 * call blk_schedule_flush_plug (because tsk_is_pi_blocked would be
+	 * true).  We must call blk_schedule_flush_plug here; if we don't
+	 * call it, an I/O deadlock may occur.
+	 */
+	if (unlikely(blk_needs_flush_plug(current)))
+		blk_schedule_flush_plug(current);
+
 	might_sleep();
 	raw_spin_lock_irq(&m->wait_lock);
 	/*
-- 
1.8.3.1
