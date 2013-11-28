From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [3.4-rt] backport of completion-use-simple-wait-queues.patch
Date: Thu, 28 Nov 2013 15:10:29 -0500
Message-ID: <20131128201029.GA28966@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Thomas Gleixner <tglx@linutronix.de>,
	<linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:49154 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754406Ab3K1UK3 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 28 Nov 2013 15:10:29 -0500
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Steve,

Someone tripped over this with usb console:

    in_atomic(): 0, irqs_disabled(): 1, pid: 36, name: kworker/1:1
    Pid: 36, comm: kworker/1:1 Tainted: G           O 3.4.34-rt40_preempt-rt #1
    Call Trace:
     [<c105461e>] __might_sleep+0xce/0xf0
     [<c14fe24c>] rt_spin_lock+0x1c/0x40
     [<c1056f65>] complete+0x25/0x60
     [<c14fde10>] ? rt_mutex_lock+0x20/0x50
     [<c135e1b0>] usb_stor_blocking_completion+0x10/0x20
     [<c13317b7>] usb_poll_irq_flush_helper+0x67/0xf0
     [<c1056ad4>] ? migrate_enable+0x74/0x170
     [<c10427f7>] process_one_work+0x107/0x410
     [<c1331750>] ? usb_get_hcd+0x30/0x30
     [<c1043045>] worker_thread+0x135/0x2e0
     [<c1042f10>] ? manage_workers.isra.26+0x200/0x200
     [<c1042f10>] ? manage_workers.isra.26+0x200/0x200
     [<c1047b83>] kthread+0x73/0x80
     [<c1047b10>] ? __init_kthread_worker+0x40/0x40
     [<c1505276>] kernel_thread_helper+0x6/0x10

and I'm pretty sure if we had the patch from Thomas' 
completion-use-simple-wait-queues.patch in 3.4 it would fix it.
(I'm not 100% sure since I don't have their hardware, but it
seems fairly obvious from the above.)

It 1st appeared in 3.6-rt, and that version of it, commit
a5ab387bb58ecb3244a4c665cc21d4b14c35333c in v3.6-rt-rebase
applies trivially to 3.4-rt.

Passes basic RT_FULL build/boot and reading off a USB flash drive
when applied to 3.4.69-rt85.

Thanks,
Paul.
--

 From f90801ecaa213e5d332e8d5f4fb783ff18bab8b5 Mon Sep 17 00:00:00 2001
From: Thomas Gleixner <tglx@linutronix.de>
Date: Fri, 11 Jan 2013 11:23:51 +0100
Subject: [PATCH] completion: Use simple wait queues

Completions have no long lasting callbacks and therefor do not need
the complex waitqueue variant. Use simple waitqueues which reduces the
contention on the waitqueue lock.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
[PG: backport from 3.6-rt ; drop part that adds wait-simple.h to
include/linux/uprobe.h as uprobes didn't appear until v3.5.]
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

diff --git a/include/linux/completion.h b/include/linux/completion.h
index 51494e6..ebb6565 100644
--- a/include/linux/completion.h
+++ b/include/linux/completion.h
@@ -8,7 +8,7 @@
  * See kernel/sched.c for details.
  */
 
-#include <linux/wait.h>
+#include <linux/wait-simple.h>
 
 /*
  * struct completion - structure used to maintain state for a "completion"
@@ -24,11 +24,11 @@
  */
 struct completion {
 	unsigned int done;
-	wait_queue_head_t wait;
+	struct swait_head wait;
 };
 
 #define COMPLETION_INITIALIZER(work) \
-	{ 0, __WAIT_QUEUE_HEAD_INITIALIZER((work).wait) }
+	{ 0, SWAIT_HEAD_INITIALIZER((work).wait) }
 
 #define COMPLETION_INITIALIZER_ONSTACK(work) \
 	({ init_completion(&work); work; })
@@ -73,7 +73,7 @@ struct completion {
 static inline void init_completion(struct completion *x)
 {
 	x->done = 0;
-	init_waitqueue_head(&x->wait);
+	init_swait_head(&x->wait);
 }
 
 extern void wait_for_completion(struct completion *);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8674878..829b644 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3811,10 +3811,10 @@ void complete(struct completion *x)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&x->wait.lock, flags);
+	raw_spin_lock_irqsave(&x->wait.lock, flags);
 	x->done++;
-	__wake_up_common(&x->wait, TASK_NORMAL, 1, 0, NULL);
-	spin_unlock_irqrestore(&x->wait.lock, flags);
+	__swait_wake_locked(&x->wait, TASK_NORMAL, 1);
+	raw_spin_unlock_irqrestore(&x->wait.lock, flags);
 }
 EXPORT_SYMBOL(complete);
 
@@ -3831,10 +3831,10 @@ void complete_all(struct completion *x)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&x->wait.lock, flags);
+	raw_spin_lock_irqsave(&x->wait.lock, flags);
 	x->done += UINT_MAX/2;
-	__wake_up_common(&x->wait, TASK_NORMAL, 0, 0, NULL);
-	spin_unlock_irqrestore(&x->wait.lock, flags);
+	__swait_wake_locked(&x->wait, TASK_NORMAL, 0);
+	raw_spin_unlock_irqrestore(&x->wait.lock, flags);
 }
 EXPORT_SYMBOL(complete_all);
 
@@ -3842,20 +3842,20 @@ static inline long __sched
 do_wait_for_common(struct completion *x, long timeout, int state)
 {
 	if (!x->done) {
-		DECLARE_WAITQUEUE(wait, current);
+		DEFINE_SWAITER(wait);
 
-		__add_wait_queue_tail_exclusive(&x->wait, &wait);
+		swait_prepare_locked(&x->wait, &wait);
 		do {
 			if (signal_pending_state(state, current)) {
 				timeout = -ERESTARTSYS;
 				break;
 			}
 			__set_current_state(state);
-			spin_unlock_irq(&x->wait.lock);
+			raw_spin_unlock_irq(&x->wait.lock);
 			timeout = schedule_timeout(timeout);
-			spin_lock_irq(&x->wait.lock);
+			raw_spin_lock_irq(&x->wait.lock);
 		} while (!x->done && timeout);
-		__remove_wait_queue(&x->wait, &wait);
+		swait_finish_locked(&x->wait, &wait);
 		if (!x->done)
 			return timeout;
 	}
@@ -3868,9 +3868,9 @@ wait_for_common(struct completion *x, long timeout, int state)
 {
 	might_sleep();
 
-	spin_lock_irq(&x->wait.lock);
+	raw_spin_lock_irq(&x->wait.lock);
 	timeout = do_wait_for_common(x, timeout, state);
-	spin_unlock_irq(&x->wait.lock);
+	raw_spin_unlock_irq(&x->wait.lock);
 	return timeout;
 }
 
@@ -4001,12 +4001,12 @@ bool try_wait_for_completion(struct completion *x)
 	unsigned long flags;
 	int ret = 1;
 
-	spin_lock_irqsave(&x->wait.lock, flags);
+	raw_spin_lock_irqsave(&x->wait.lock, flags);
 	if (!x->done)
 		ret = 0;
 	else
 		x->done--;
-	spin_unlock_irqrestore(&x->wait.lock, flags);
+	raw_spin_unlock_irqrestore(&x->wait.lock, flags);
 	return ret;
 }
 EXPORT_SYMBOL(try_wait_for_completion);
@@ -4024,10 +4024,10 @@ bool completion_done(struct completion *x)
 	unsigned long flags;
 	int ret = 1;
 
-	spin_lock_irqsave(&x->wait.lock, flags);
+	raw_spin_lock_irqsave(&x->wait.lock, flags);
 	if (!x->done)
 		ret = 0;
-	spin_unlock_irqrestore(&x->wait.lock, flags);
+	raw_spin_unlock_irqrestore(&x->wait.lock, flags);
 	return ret;
 }
 EXPORT_SYMBOL(completion_done);
-- 
1.8.5.rc3

