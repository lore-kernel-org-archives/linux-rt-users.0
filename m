From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 3/5] trace: correct off by one while recording the trace-event
Date: Tue, 12 Jul 2016 10:21:56 -0400
Message-ID: <20160712142214.920054617@goodmis.org>
References: <20160712142153.609204728@goodmis.org>
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
Received: from mail.kernel.org ([198.145.29.136]:50040 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750978AbcGLOWS (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 12 Jul 2016 10:22:18 -0400
Content-Disposition: inline; filename=0003-trace-correct-off-by-one-while-recording-the-trace-e.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

4.4.12-rt20-rc1 stable review patch.
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
index 4a48f97a2256..5bd79b347398 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -246,6 +246,14 @@ void *trace_event_buffer_reserve(struct trace_event_buffer *fbuffer,
 
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
 	fbuffer->trace_file = trace_file;
 
 	fbuffer->event =
-- 
2.8.1


