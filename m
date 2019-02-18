From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH RT 1/2] softirq: Avoid "local_softirq_pending" messages if
 ksoftirqd is blocked
Date: Mon, 18 Feb 2019 17:31:08 +0100
Message-ID: <20190218163107.iwdpngwmbs6xyk7x@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

If the ksoftirqd thread has a softirq pending and is blocked on the
`local_softirq_locks' lock then softirq_check_pending_idle() won't
complain because the "lock owner" will mask away this softirq from the
mask of pending softirqs.
If ksoftirqd has an additional softirq pending then it won't be masked
out because we never look at ksoftirqd's mask.

If there are still pending softirqs while going to idle check
ksoftirqd's and ktimersfotd's mask before complaining about unhandled
softirqs.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/softirq.c | 58 +++++++++++++++++++++++++++++++++++-------------
 1 file changed, 42 insertions(+), 16 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index c15583162a559..8da664eb843a4 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -92,6 +92,31 @@ static inline void softirq_clr_runner(unsigned int sirq)
 	sr->runner[sirq] = NULL;
 }
 
+static bool softirq_check_runner_tsk(struct task_struct *tsk,
+				     unsigned int *pending)
+{
+	bool ret = false;
+
+	if (!tsk)
+		return ret;
+
+	/*
+	 * The wakeup code in rtmutex.c wakes up the task
+	 * _before_ it sets pi_blocked_on to NULL under
+	 * tsk->pi_lock. So we need to check for both: state
+	 * and pi_blocked_on.
+	 */
+	raw_spin_lock(&tsk->pi_lock);
+	if (tsk->pi_blocked_on || tsk->state == TASK_RUNNING) {
+		/* Clear all bits pending in that task */
+		*pending &= ~(tsk->softirqs_raised);
+		ret = true;
+	}
+	raw_spin_unlock(&tsk->pi_lock);
+
+	return ret;
+}
+
 /*
  * On preempt-rt a softirq running context might be blocked on a
  * lock. There might be no other runnable task on this CPU because the
@@ -104,6 +129,7 @@ static inline void softirq_clr_runner(unsigned int sirq)
  */
 void softirq_check_pending_idle(void)
 {
+	struct task_struct *tsk;
 	static int rate_limit;
 	struct softirq_runner *sr = this_cpu_ptr(&softirq_runners);
 	u32 warnpending;
@@ -113,26 +139,26 @@ void softirq_check_pending_idle(void)
 		return;
 
 	warnpending = local_softirq_pending() & SOFTIRQ_STOP_IDLE_MASK;
+	if (!warnpending)
+		return;
 	for (i = 0; i < NR_SOFTIRQS; i++) {
-		struct task_struct *tsk = sr->runner[i];
+		tsk = sr->runner[i];
 
-		/*
-		 * The wakeup code in rtmutex.c wakes up the task
-		 * _before_ it sets pi_blocked_on to NULL under
-		 * tsk->pi_lock. So we need to check for both: state
-		 * and pi_blocked_on.
-		 */
-		if (tsk) {
-			raw_spin_lock(&tsk->pi_lock);
-			if (tsk->pi_blocked_on || tsk->state == TASK_RUNNING) {
-				/* Clear all bits pending in that task */
-				warnpending &= ~(tsk->softirqs_raised);
-				warnpending &= ~(1 << i);
-			}
-			raw_spin_unlock(&tsk->pi_lock);
-		}
+		if (softirq_check_runner_tsk(tsk, &warnpending))
+			warnpending &= ~(1 << i);
 	}
 
+	if (warnpending) {
+		tsk = __this_cpu_read(ksoftirqd);
+		softirq_check_runner_tsk(tsk, &warnpending);
+	}
+
+	if (warnpending) {
+		tsk = __this_cpu_read(ktimer_softirqd);
+		softirq_check_runner_tsk(tsk, &warnpending);
+	}
+
+
 	if (warnpending) {
 		printk(KERN_ERR "NOHZ: local_softirq_pending %02x\n",
 		       warnpending);
-- 
2.20.1
