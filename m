From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 09/11] trace: correct off by one while recording the trace-event
Date: Tue, 12 Jul 2016 12:49:59 -0400
Message-ID: <20160712165021.977847557@goodmis.org>
References: <20160712164950.490572026@goodmis.org>
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
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0009-trace-correct-off-by-one-while-recording-the-trace-e.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.12.61-rt82-rc1 stable review patch.
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
 include/trace/ftrace.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/trace/ftrace.h b/include/trace/ftrace.h
index 645d749d3c9c..1c74dcd4c76e 100644
--- a/include/trace/ftrace.h
+++ b/include/trace/ftrace.h
@@ -536,6 +536,9 @@ ftrace_raw_event_##call(void *__data, proto)				\
 									\
 	local_save_flags(irq_flags);					\
 	pc = preempt_count();						\
+	/* Account for tracepoint preempt disable */			\
+	if (IS_ENABLED(CONFIG_PREEMPT))					\
+		pc--;							\
 									\
 	__data_size = ftrace_get_offsets_##call(&__data_offsets, args); \
 									\
-- 
2.8.1
