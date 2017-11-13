From: Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH PREEMPT RT] rt-mutex: fix deadlock in device mapper
Date: Mon, 13 Nov 2017 12:56:53 -0500 (EST)
Message-ID: <alpine.LRH.2.02.1711131245580.23280@file01.intranet.prod.int.rdu2.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users@vger.kernel.org
To: linux-kernel@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41190 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752044AbdKMR4z (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 13 Nov 2017 12:56:55 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi

I'm submitting this patch for the CONFIG_PREEMPT_RT patch. It fixes 
deadlocks in device mapper when real time preemption is used.

Mikulas


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

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 kernel/locking/rtmutex.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

Index: linux-stable/kernel/locking/rtmutex.c
===================================================================
--- linux-stable.orig/kernel/locking/rtmutex.c
+++ linux-stable/kernel/locking/rtmutex.c
@@ -24,6 +24,7 @@
 #include <linux/sched/debug.h>
 #include <linux/timer.h>
 #include <linux/ww_mutex.h>
+#include <linux/blkdev.h>
 
 #include "rtmutex_common.h"
 
@@ -1939,6 +1940,15 @@ rt_mutex_fastlock(struct rt_mutex *lock,
 	if (likely(rt_mutex_cmpxchg_acquire(lock, NULL, current)))
 		return 0;
 
+	/*
+	 * If rt_mutex blocks, the function sched_submit_work will not call
+	 * blk_schedule_flush_plug (because tsk_is_pi_blocked would be true).
+	 * We must call blk_schedule_flush_plug here, if we don't call it,
+	 * a deadlock in device mapper may happen.
+	 */
+	if (unlikely(blk_needs_flush_plug(current)))
+		blk_schedule_flush_plug(current);
+
 	return slowfn(lock, state, NULL, RT_MUTEX_MIN_CHAINWALK, ww_ctx);
 }
 
@@ -1956,6 +1966,9 @@ rt_mutex_timed_fastlock(struct rt_mutex
 	    likely(rt_mutex_cmpxchg_acquire(lock, NULL, current)))
 		return 0;
 
+	if (unlikely(blk_needs_flush_plug(current)))
+		blk_schedule_flush_plug(current);
+
 	return slowfn(lock, state, timeout, chwalk, ww_ctx);
 }
 
