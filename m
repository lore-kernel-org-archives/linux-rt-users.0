From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH RT 3/2] softirq: Avoid "local_softirq_pending" messages if
 task is in cpu_chill()
Date: Tue, 19 Feb 2019 17:07:56 +0100
Message-ID: <20190219160755.fn4c65ph4lzqflw2@linutronix.de>
References: <20190218163107.iwdpngwmbs6xyk7x@linutronix.de>
 <20190218163137.cmor4ek3odus5m6j@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190218163137.cmor4ek3odus5m6j@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

If the softirq thread enters cpu_chill() then ->state is UNINTERRUPTIBLE
and has no ->pi_blocked_on set and so its mask is not taken into account.

->sleeping_lock is increased by cpu_chill() since it is also requried to
avoid a splat by RCU in case cpu_chill() is used while a RCU-read lock
is held. Use the same mechanism for the softirq-pending check.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/softirq.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 48ae7dae81b9c..25bcf2f2714ba 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -105,9 +105,12 @@ static bool softirq_check_runner_tsk(struct task_struct *tsk,
 	 * _before_ it sets pi_blocked_on to NULL under
 	 * tsk->pi_lock. So we need to check for both: state
 	 * and pi_blocked_on.
+	 * The test against UNINTERRUPTIBLE + ->sleeping_lock is in case the
+	 * task does cpu_chill().
 	 */
 	raw_spin_lock(&tsk->pi_lock);
-	if (tsk->pi_blocked_on || tsk->state == TASK_RUNNING) {
+	if (tsk->pi_blocked_on || tsk->state == TASK_RUNNING ||
+	    (tsk->state == TASK_UNINTERRUPTIBLE && tsk->sleeping_lock)) {
 		/* Clear all bits pending in that task */
 		*pending &= ~(tsk->softirqs_raised);
 		ret = true;
-- 
2.20.1
