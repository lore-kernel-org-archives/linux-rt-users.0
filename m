From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 16/20] trace: Use rcuidle version for preemptoff_hist trace point
Date: Wed, 02 Mar 2016 10:37:14 -0500
Message-ID: <20160302153717.187187823@goodmis.org>
References: <20160302153658.995489487@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Yang Shi <yang.shi@windriver.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:58337 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755138AbcCBPhV (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 2 Mar 2016 10:37:21 -0500
Content-Disposition: inline; filename=0016-trace-Use-rcuidle-version-for-preemptoff_hist-trace-.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

3.18.27-rt27-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Yang Shi <yang.shi@windriver.com>

When running -rt kernel with both PREEMPT_OFF_HIST and LOCKDEP enabled,
the below error is reported:

 [ INFO: suspicious RCU usage. ]
 4.4.1-rt6 #1 Not tainted
 include/trace/events/hist.h:31 suspicious rcu_dereference_check() usage!

 other info that might help us debug this:

 RCU used illegally from idle CPU!
 rcu_scheduler_active = 1, debug_locks = 0
 RCU used illegally from extended quiescent state!
 no locks held by swapper/0/0.

 stack backtrace:
 CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.4.1-rt6-WR8.0.0.0_standard #1
 Stack : 0000000000000006 0000000000000000 ffffffff81ca8c38 ffffffff81c8fc80
    ffffffff811bdd68 ffffffff81cb0000 0000000000000000 ffffffff81cb0000
    0000000000000000 0000000000000000 0000000000000004 0000000000000000
    0000000000000004 ffffffff811bdf50 0000000000000000 ffffffff82b60000
    0000000000000000 ffffffff812897ac ffffffff819f0000 000000000000000b
    ffffffff811be460 ffffffff81b7c588 ffffffff81c8fc80 0000000000000000
    0000000000000000 ffffffff81ec7f88 ffffffff81d70000 ffffffff81b70000
    ffffffff81c90000 ffffffff81c3fb00 ffffffff81c3fc28 ffffffff815e6f98
    0000000000000000 ffffffff81c8fa87 ffffffff81b70958 ffffffff811bf2c4
    0707fe32e8d60ca5 ffffffff81126d60 0000000000000000 0000000000000000
    ...
 Call Trace:
 [<ffffffff81126d60>] show_stack+0xe8/0x108
 [<ffffffff815e6f98>] dump_stack+0x88/0xb0
 [<ffffffff8124b88c>] time_hardirqs_off+0x204/0x300
 [<ffffffff811aa5dc>] trace_hardirqs_off_caller+0x24/0xe8
 [<ffffffff811a4ec4>] cpu_startup_entry+0x39c/0x508
 [<ffffffff81d7dc68>] start_kernel+0x584/0x5a0

Replace regular trace_preemptoff_hist to rcuidle version to avoid the error.

Signed-off-by: Yang Shi <yang.shi@windriver.com>
Cc: bigeasy@linutronix.de
Cc: rostedt@goodmis.org
Cc: linux-rt-users@vger.kernel.org
Link: http://lkml.kernel.org/r/1456262603-10075-1-git-send-email-yang.shi@windriver.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 include/trace/events/hist.h  | 1 +
 kernel/trace/trace_irqsoff.c | 8 ++++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/hist.h b/include/trace/events/hist.h
index 6122e4286177..f7710de1b1f3 100644
--- a/include/trace/events/hist.h
+++ b/include/trace/events/hist.h
@@ -9,6 +9,7 @@
 
 #if !defined(CONFIG_PREEMPT_OFF_HIST) && !defined(CONFIG_INTERRUPT_OFF_HIST)
 #define trace_preemptirqsoff_hist(a, b)
+#define trace_preemptirqsoff_hist_rcuidle(a, b)
 #else
 TRACE_EVENT(preemptirqsoff_hist,
 
diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index de4f1a812c41..d1940b095d85 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -436,13 +436,13 @@ void start_critical_timings(void)
 {
 	if (preempt_trace() || irq_trace())
 		start_critical_timing(CALLER_ADDR0, CALLER_ADDR1);
-	trace_preemptirqsoff_hist(TRACE_START, 1);
+	trace_preemptirqsoff_hist_rcuidle(TRACE_START, 1);
 }
 EXPORT_SYMBOL_GPL(start_critical_timings);
 
 void stop_critical_timings(void)
 {
-	trace_preemptirqsoff_hist(TRACE_STOP, 0);
+	trace_preemptirqsoff_hist_rcuidle(TRACE_STOP, 0);
 	if (preempt_trace() || irq_trace())
 		stop_critical_timing(CALLER_ADDR0, CALLER_ADDR1);
 }
@@ -487,7 +487,7 @@ inline void print_irqtrace_events(struct task_struct *curr)
  */
 void trace_hardirqs_on(void)
 {
-	trace_preemptirqsoff_hist(IRQS_ON, 0);
+	trace_preemptirqsoff_hist_rcuidle(IRQS_ON, 0);
 	if (!preempt_trace() && irq_trace())
 		stop_critical_timing(CALLER_ADDR0, CALLER_ADDR1);
 }
@@ -497,7 +497,7 @@ void trace_hardirqs_off(void)
 {
 	if (!preempt_trace() && irq_trace())
 		start_critical_timing(CALLER_ADDR0, CALLER_ADDR1);
-	trace_preemptirqsoff_hist(IRQS_OFF, 1);
+	trace_preemptirqsoff_hist_rcuidle(IRQS_OFF, 1);
 }
 EXPORT_SYMBOL(trace_hardirqs_off);
 
-- 
2.7.0


