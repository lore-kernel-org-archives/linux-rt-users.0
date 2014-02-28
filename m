From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 02/11] timer: Raise softirq if theres irq_work
Date: Fri, 28 Feb 2014 08:34:56 -0500
Message-ID: <20140228133535.517092525@goodmis.org>
References: <20140228133454.373761937@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>, <stable-rt@vger.kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0002-timer-Raise-softirq-if-there-s-irq_work.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.10.32-rt31-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Steven Rostedt <rostedt@goodmis.org>

[ Talking with Sebastian on IRC, it seems that doing the irq_work_run()
  from the interrupt in -rt is a bad thing. Here we simply raise the
  softirq if there's irq work to do. This too boots on my i7 ]

After trying hard to figure out why my i7 box was locking up with the
new active_timers code, that does not run the timer softirq if there
are no active timers, I took an extra look at the softirq handler and
noticed that it doesn't just run timer softirqs, it also runs irq work.

This was the bug that was locking up the system. It wasn't missing a
timer, it was missing irq work. By always doing the irq work callbacks,
the system boots fine. The missing irq work callback was the RCU's
sp_wakeup() function.

No need to check for defined(CONFIG_IRQ_WORK). When that's not set the
"irq_work_needs_cpu()" is a static inline that returns false.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/timer.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/timer.c b/kernel/timer.c
index 3d7313c..25a38c4 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -1466,8 +1466,13 @@ void run_local_timers(void)
 		return;
 	}
 #endif
-	if (!base->active_timers)
-		goto out;
+	if (!base->active_timers) {
+#ifdef CONFIG_PREEMPT_RT_FULL
+		/* On RT, irq work runs from softirq */
+		if (!irq_work_needs_cpu())
+#endif
+			goto out;
+	}
 
 	/* Check whether the next pending timer has expired */
 	if (time_before_eq(base->next_timer, jiffies))
-- 
1.8.5.3
