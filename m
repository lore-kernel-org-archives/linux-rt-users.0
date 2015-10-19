From: Yang Shi <yang.shi@linaro.org>
Subject: [PATCH] rt: trace: add rcuidle version macro for preemptirqsoff_hist and hrtimer_interrupt
Date: Mon, 19 Oct 2015 11:40:08 -0700
Message-ID: <1445280008-8456-1-git-send-email-yang.shi@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	linaro-kernel@lists.linaro.org, yang.shi@linaro.org
To: tglx@linutronix.de, bigeasy@linutronix.de, rostedt@goodmis.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

When building rt kernel with IRQSOFF_TRACER enabled but INTERRUPT_OFF_HIST or
PREEMPT_OFF_HIST disabled, the below build failure will be triggered:

| /home/yshi/linux-rt/kernel/trace/trace_irqsoff.c: In function 'time_hardirqs_on':
| /home/yshi/linux-rt/kernel/trace/trace_irqsoff.c:453:2: error: implicit declaration of function 'trace_preemptirqsoff_hist_rcuidle' [-Werror=implicit-function-declaration]
|   trace_preemptirqsoff_hist_rcuidle(IRQS_ON, 0);
|   ^
| cc1: some warnings being treated as errors
| /home/yshi/linux-rt/scripts/Makefile.build:258: recipe for target 'kernel/trace/trace_irqsoff.o' failed
| make[4]: *** [kernel/trace/trace_irqsoff.o] Error 1
| make[4]: *** Waiting for unfinished jobs....
| /home/yshi/linux-rt/scripts/Makefile.build:403: recipe for target 'kernel/trace' failed

Because rcuidle version is just defined by TRACE_EVENT when both
PREEMPT_OFF_HIST and PREEMPT_OFF_HIST is selected, otherwise just
trace_preemptirqsoff_hist is defined as a preprocessor macro.

Added rcuidle version macro when the condition is false, and added rcuidle
version macro for trace_hrtimer_interrupt_rcuidle even though it is not called
by anyone.

Signed-off-by: Yang Shi <yang.shi@linaro.org>
---
 include/trace/events/hist.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/trace/events/hist.h b/include/trace/events/hist.h
index 6122e42..37f6eb8 100644
--- a/include/trace/events/hist.h
+++ b/include/trace/events/hist.h
@@ -9,6 +9,7 @@
 
 #if !defined(CONFIG_PREEMPT_OFF_HIST) && !defined(CONFIG_INTERRUPT_OFF_HIST)
 #define trace_preemptirqsoff_hist(a, b)
+#define trace_preemptirqsoff_hist_rcuidle(a, b)
 #else
 TRACE_EVENT(preemptirqsoff_hist,
 
@@ -33,6 +34,7 @@ TRACE_EVENT(preemptirqsoff_hist,
 
 #ifndef CONFIG_MISSED_TIMER_OFFSETS_HIST
 #define trace_hrtimer_interrupt(a, b, c, d)
+#define trace_hrtimer_interrupt_rcuidle(a, b, c, d)
 #else
 TRACE_EVENT(hrtimer_interrupt,
 
-- 
2.0.2
