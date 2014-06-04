From: "Brad Mouring" <bmouring@ni.com>
Subject: [PATCH] rtmutex: Handle when top lock owner changes
Date: Wed, 4 Jun 2014 17:22:37 -0500
Message-ID: <1401920557-21387-1-git-send-email-brad.mouring@ni.com>
References: <alpine.DEB.2.10.1406042217140.18296@nanos>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Clark Williams <williams@redhat.com>,
	Brad Mouring <brad.mouring@ni.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.10.1406042217140.18296@nanos>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

If, during walking the priority chain on a task blocking on a rtmutex,
and the task is examining the waiter blocked on the lock owned by a task
that is not blocking (the end of the chain), the current task is ejected
from the processor and the owner of the end lock is scheduled in,
releasing that lock, before the original task is scheduled back in, the
task misses the fact that the previous owner of the current lock no
longer holds it.

Consider the following scenario:
Tasks A, B, C, and D
Locks L1, L2, L3, and L4

D owns L4, C owns L3, B owns L2. C blocks on L4, B blocks on L3.

We have
L2->B->L3->C->L4->D

A comes along and blocks on L2.
A->L2->B->L3->C->L4->D

We walking the priority chain, and, while walking the chain, with
task pointing to D, top_waiter at C->L4. We fail to take L4's pi_lock
and are scheduled out.

Let's assume that the chain changes prior to A being scheduled in.
All of the owners finish with their locks and drop them. We have

A->L2

But, as things are still running, the chain can continue to change,
leading to

       A->L2->B
C->L1->D->L2

That is, B ends up winning L2, D blocks on L2 after grabbing L1,
and L1 blocks C. A is scheduled back in and continues the walk.

Since task was pointing to D, and D is indeed blocked, it will
have a waiter (D->L2), and, sadly, the lock is orig_lock. The
deadlock detection will come in and report a deadlock to userspace.

This change provides an additional check for this situation before
reporting a deadlock to userspace.

Signed-off-by: Brad Mouring <brad.mouring@ni.com>
Acked-by: Scot Salmon <scot.salmon@ni.com>
Acked-by: Ben Shelton <ben.shelton@ni.com>
Tested-by: Jeff Westfahl <jeff.westfahl@ni.com>
---
 kernel/locking/rtmutex.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index fbf152b..8ad7f7d 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -384,6 +384,26 @@ static int rt_mutex_adjust_prio_chain(struct task_struct *task,
 
 	/* Deadlock detection */
 	if (lock == orig_lock || rt_mutex_owner(lock) == top_task) {
+		/*
+		 * If the prio chain has changed out from under us, set the task
+		 * to the current owner of the lock in the current waiter and
+		 * continue walking the prio chain
+		 */
+		if (rt_mutex_owner(lock) && rt_mutex_owner(lock) != task &&
+			rt_mutex_owner(lock) != top_task) {
+			/* Release the old task (blocked before the chain chaged) */
+			raw_spin_unlock_irqrestore(&task->pi_lock, flags);
+			put_task_struct(task);
+
+			/* Move to the owner of the lock now described in waiter */
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
