From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 06/13] locking/rt-mutex: fix deadlock in device mapper / block-IO
Date: Wed, 17 Jan 2018 10:14:10 -0500
Message-ID: <20180117151431.425437643@goodmis.org>
References: <20180117151404.093229667@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com, Alex Shi <alex.shi@linaro.org>,
        stable-rt@vger.kernel.org, Mikulas Patocka <mpatocka@redhat.com>
To: linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753016AbeAQPOd (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 17 Jan 2018 10:14:33 -0500
Content-Disposition: inline; filename=0006-locking-rt-mutex-fix-deadlock-in-device-mapper-block.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

3.18.91-rt98-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Mikulas Patocka <mpatocka@redhat.com>

When some block device driver creates a bio and submits it to another
block device driver, the bio is added to current->bio_list (in order to
avoid unbounded recursion).

However, this queuing of bios can cause deadlocks, in order to avoid them,
device mapper registers a function flush_current_bio_list. This function
is called when device mapper driver blocks. It redirects bios queued on
current->bio_list to helper workqueues, so that these bios can proceed
even if the driver is blocked.

The problem with CONFIG_PREEMPT_RT_FULL is that when the device mapper
driver blocks, it won't call flush_current_bio_list (because
tsk_is_pi_blocked returns true in sched_submit_work), so deadlocks in
block device stack can happen.

Note that we can't call blk_schedule_flush_plug if tsk_is_pi_blocked
returns true - that would cause
BUG_ON(rt_mutex_real_waiter(task->pi_blocked_on)) in
task_blocks_on_rt_mutex when flush_current_bio_list attempts to take a
spinlock.

So the proper fix is to call blk_schedule_flush_plug in rt_mutex_fastlock,
when fast acquire failed and when the task is about to block.

CC: stable-rt@vger.kernel.org
[bigeasy: The deadlock is not device-mapper specific, it can also occur
          in plain EXT4]
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/locking/rtmutex.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index da35f7ef5324..d58780b59583 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -22,6 +22,7 @@
 #include <linux/sched/deadline.h>
 #include <linux/timer.h>
 #include <linux/ww_mutex.h>
+#include <linux/blkdev.h>
 
 #include "rtmutex_common.h"
 
@@ -1843,9 +1844,19 @@ rt_mutex_fastlock(struct rt_mutex *lock, int state,
 	if (likely(rt_mutex_cmpxchg(lock, NULL, current))) {
 		rt_mutex_deadlock_account_lock(lock, current);
 		return 0;
-	} else
-		return slowfn(lock, state, NULL, RT_MUTEX_MIN_CHAINWALK,
-			      ww_ctx);
+	}
+
+	/*
+	 * If rt_mutex blocks, the function sched_submit_work will not call
+	 * blk_schedule_flush_plug (because tsk_is_pi_blocked would be true).
+	 * We must call blk_schedule_flush_plug here, if we don't call it,
+	 * a deadlock in device mapper may happen.
+	 */
+	if (unlikely(blk_needs_flush_plug(current)))
+		blk_schedule_flush_plug(current);
+
+	return slowfn(lock, state, NULL, RT_MUTEX_MIN_CHAINWALK,
+		      ww_ctx);
 }
 
 static inline int
@@ -1862,8 +1873,12 @@ rt_mutex_timed_fastlock(struct rt_mutex *lock, int state,
 	    likely(rt_mutex_cmpxchg(lock, NULL, current))) {
 		rt_mutex_deadlock_account_lock(lock, current);
 		return 0;
-	} else
-		return slowfn(lock, state, timeout, chwalk, ww_ctx);
+	}
+
+	if (unlikely(blk_needs_flush_plug(current)))
+		blk_schedule_flush_plug(current);
+
+	return slowfn(lock, state, timeout, chwalk, ww_ctx);
 }
 
 static inline int
-- 
2.13.2


