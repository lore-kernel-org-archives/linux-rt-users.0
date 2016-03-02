From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 01/20] sched: reset tasks lockless wake-queues on fork()
Date: Wed, 02 Mar 2016 10:36:59 -0500
Message-ID: <20160302153714.251074185@goodmis.org>
References: <20160302153658.995489487@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0001-sched-reset-task-s-lockless-wake-queues-on-fork.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.18.27-rt27-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

In 7675104990ed ("sched: Implement lockless wake-queues") we gained
lockless wake-queues. -RT managed to lockup itself with those. There
could be multiple attempts for task X to enqueue it for a wakeup
_even_ if task X is already running.
The reason is that task X could be runnable but not yet on CPU. The the
task performing the wakeup did not leave the CPU it could performe
multiple wakeups.
With the proper timming task X could be running and enqueued for a
wakeup. If this happens while X is performing a fork() then its its
child will have a !NULL `wake_q` member copied.
This is not a problem as long as the child task does not participate in
lockless wakeups :)

Fixes: 7675104990ed ("sched: Implement lockless wake-queues")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/fork.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/fork.c b/kernel/fork.c
index 3a8ecfb38831..1c4edaf4ec36 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -364,6 +364,7 @@ static struct task_struct *dup_task_struct(struct task_struct *orig)
 #endif
 	tsk->splice_pipe = NULL;
 	tsk->task_frag.page = NULL;
+	tsk->wake_q.next = NULL;
 
 	account_kernel_stack(ti, 1);
 
-- 
2.7.0
