From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 19/20] trace: correct off by one while recording the trace-event
Date: Tue, 12 Jul 2016 10:24:24 -0400
Message-ID: <20160712142420.663589817@goodmis.org>
References: <20160712142405.634544943@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	<stable-rt@vger.kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50820 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754559AbcGLOYX (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 12 Jul 2016 10:24:23 -0400
Content-Disposition: inline; filename=0019-trace-correct-off-by-one-while-recording-the-trace-e.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

4.1.27-rt31-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Trace events like raw_syscalls show always a preempt code of one. The
reason is that on PREEMPT kernels rcu_read_lock_sched_notrace()
increases the preemption counter and the function recording the counter
is caller within the RCU section.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
[ Changed this to upstream version. See commit e947841c0dce ]
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace_events.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 64c1ac17af8f..b83d6a4d3912 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -200,6 +200,14 @@ void *ftrace_event_buffer_reserve(struct ftrace_event_buffer *fbuffer,
 
 	local_save_flags(fbuffer->flags);
 	fbuffer->pc = preempt_count();
+	/*
+	 * If CONFIG_PREEMPT is enabled, then the tracepoint itself disables
+	 * preemption (adding one to the preempt_count). Since we are
+	 * interested in the preempt_count at the time the tracepoint was
+	 * hit, we need to subtract one to offset the increment.
+	 */
+	if (IS_ENABLED(CONFIG_PREEMPT))
+		fbuffer->pc--;
 	fbuffer->ftrace_file = ftrace_file;
 
 	fbuffer->event =
-- 
2.8.1


