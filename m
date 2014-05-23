From: "Brad Mouring" <bmouring@ni.com>
Subject: [PATCH 1/1] rtmutex: Handle when top lock owner changes
Date: Fri, 23 May 2014 09:30:10 -0500
Message-ID: <1400855410-14773-2-git-send-email-brad.mouring@ni.com>
References: <1400855410-14773-1-git-send-email-brad.mouring@ni.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Brad Mouring <brad.mouring@ni.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from skprod3.natinst.com ([130.164.80.24]:36319 "EHLO ni.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752347AbaEWOjP (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 23 May 2014 10:39:15 -0400
In-Reply-To: <1400855410-14773-1-git-send-email-brad.mouring@ni.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

If, during walking the priority chain on a task blocking on a rtmutex,
and the task is examining the waiter blocked on the lock owned by a task
that is not blocking (the end of the chain), the current task is ejected
from the processor and the owner of the end lock is scheduled in,
releasing that lock, before the original task is scheduled back in, the
task misses the fact that the previous owner of the current lock no
longer holds it.

Signed-off-by: Brad Mouring <brad.mouring@ni.com>
Acked-by: Scot Salmon <scot.salmon@ni.com>
Acked-by: Ben Shelton <ben.shelton@ni.com>
Tested-by: Jeff Westfahl <jeff.westfahl@ni.com>
---
 kernel/locking/rtmutex.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index fbf152b..029a9ab 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -384,6 +384,25 @@ static int rt_mutex_adjust_prio_chain(struct task_struct *task,
 
 	/* Deadlock detection */
 	if (lock == orig_lock || rt_mutex_owner(lock) == top_task) {
+		/*
+		 * If the prio chain has changed out from under us, set the task
+		 * to the current owner of the lock in the current waiter and
+		 * continue walking the prio chain
+		 */
+		if (rt_mutex_owner(lock) && rt_mutex_owner(lock) != task) {
+			/* Release the old owner */
+			raw_spin_unlock_irqrestore(&task->pi_lock, flags);
+			put_task_struct(task);
+
+			/* Move to the new owner */
+			task = rt_mutex_owner(lock);
+			get_task_struct(task);
+
+			/* Let's try this again */
+			raw_spin_unlock(&lock->wait_lock);
+			goto retry;
+		}
+
 		debug_rt_mutex_deadlock(deadlock_detect, orig_waiter, lock);
 		raw_spin_unlock(&lock->wait_lock);
 		ret = deadlock_detect ? -EDEADLK : 0;
-- 
1.8.3-rc3

