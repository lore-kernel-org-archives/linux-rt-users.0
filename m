From: Yang Shi <yang.shi@windriver.com>
Subject: [v4.4-rt PATCH] rt: trace: add rcuidle version macro for preemptirqsoff_hist and hrtimer_interrupt
Date: Mon, 7 Mar 2016 15:45:38 -0800
Message-ID: <1457394338-11865-1-git-send-email-yang.shi@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-kernel@vger.kernel.org>, <linux-rt-users@vger.kernel.org>,
	<yang.shi@windriver.com>
To: <tglx@linutronix.de>, <bigeasy@linutronix.de>,
	<rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:32788 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932708AbcCHAJb (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 7 Mar 2016 19:09:31 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

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

Reported-by: Henning Schild <henning.schild@siemens.com>
Signed-off-by: Yang Shi <yang.shi@windriver.com>
---
Forward port the 4.1 version patch [1] to 4.4.
[1] http://www.spinics.net/lists/linux-rt-users/msg14037.html

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

