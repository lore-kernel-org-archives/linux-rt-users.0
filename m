From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 06/12] softirq: Fix nohz pending issue for real
Date: Wed, 13 Feb 2013 17:13:45 +0100
Message-ID: <1360772031-27186-7-git-send-email-bigeasy@linutronix.de>
References: <1360772031-27186-1-git-send-email-bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Carsten Emde <C.Emde@osadl.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1360772031-27186-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

We really need to iterate through all softirqs to find a potentially
blocked runner.

T1 runs softirq X (that cleared pending bit for X)

Interrupt raises softirq Y

T1 gets blocked on a lock and lock owner is not runnable

T1 schedules out

CPU goes idle and complains about pending softirq Y.

Now iterating over all softirqs lets us find the runner for X and
eliminate Y from the to warn about list as well.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/softirq.c |   13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 499329d..3f67aff 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -100,20 +100,15 @@ void softirq_check_pending_idle(void)
 {
 	static int rate_limit;
 	struct softirq_runner *sr = &__get_cpu_var(softirq_runners);
-	u32 warnpending, pending = local_softirq_pending();
+	u32 warnpending = local_softirq_pending();
+	int i;
 
 	if (rate_limit >= 10)
 		return;
 
-	warnpending = pending;
-
-	while (pending) {
-		struct task_struct *tsk;
-		int i = __ffs(pending);
-
-		pending &= ~(1 << i);
+	for (i = 0; i < NR_SOFTIRQS; i++) {
+		struct task_struct *tsk = sr->runner[i];
 
-		tsk = sr->runner[i];
 		/*
 		 * The wakeup code in rtmutex.c wakes up the task
 		 * _before_ it sets pi_blocked_on to NULL under
-- 
1.7.10.4
