From: Mike Galbraith <efault@gmx.de>
Subject: [patch-rt] softirq: Move ksoftirqd_running() under
 !CONFIG_PREEMPT_RT_FULL
Date: Sat, 31 Dec 2016 09:20:10 +0100
Message-ID: <1483172410.9872.2.camel@gmx.de>
References: <20161223163213.szj43nv7rnelkbty@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161223163213.szj43nv7rnelkbty@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


Otherwise, ktimersoftd may not be awakened when it has work to do.

[   84.087571] NOHZ: local_softirq_pending 02
[   84.087593] NOHZ: local_softirq_pending 02
[   84.087598] NOHZ: local_softirq_pending 02
[   84.087904] NOHZ: local_softirq_pending 02
[   84.088526] NOHZ: local_softirq_pending 02
[   84.088899] NOHZ: local_softirq_pending 02
[   84.089463] NOHZ: local_softirq_pending 02
[  115.013470] NOHZ: local_softirq_pending 02
[  115.013601] NOHZ: local_softirq_pending 02
[  115.013709] NOHZ: local_softirq_pending 02

Signed-off-by: Mike Galbraith <efault@gmx.de>
---
 kernel/softirq.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -206,6 +206,7 @@ static void handle_softirq(unsigned int
 	}
 }
 
+#ifndef CONFIG_PREEMPT_RT_FULL
 /*
  * If ksoftirqd is scheduled, we do not want to process pending softirqs
  * right now. Let ksoftirqd handle this at its own rate, to get fairness.
@@ -217,7 +218,6 @@ static bool ksoftirqd_running(void)
 	return tsk && (tsk->state == TASK_RUNNING);
 }
 
-#ifndef CONFIG_PREEMPT_RT_FULL
 static inline int ksoftirqd_softirq_pending(void)
 {
 	return local_softirq_pending();
@@ -794,13 +794,10 @@ void irq_enter(void)
 
 static inline void invoke_softirq(void)
 {
-#ifdef CONFIG_PREEMPT_RT_FULL
-	unsigned long flags;
-#endif
-
+#ifndef CONFIG_PREEMPT_RT_FULL
 	if (ksoftirqd_running())
 		return;
-#ifndef CONFIG_PREEMPT_RT_FULL
+
 	if (!force_irqthreads) {
 #ifdef CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK
 		/*
@@ -821,6 +818,7 @@ static inline void invoke_softirq(void)
 		wakeup_softirqd();
 	}
 #else /* PREEMPT_RT_FULL */
+	unsigned long flags;
 
 	local_irq_save(flags);
 	if (__this_cpu_read(ksoftirqd) &&
