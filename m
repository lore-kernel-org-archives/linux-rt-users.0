From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 1/6] tracing: Update the comm field in the right variable in update_max_tr
Date: Tue, 15 Jun 2010 00:21:22 +0200
Message-ID: <1276554087-3632-2-git-send-email-jkacur@redhat.com>
References: <1276554087-3632-1-git-send-email-jkacur@redhat.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Clark Williams <williams@redhat.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Ingo Molnar <mingo@elte.hu>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1276554087-3632-1-git-send-email-jkacur@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The latency output showed:

 #    | task: -3 (uid:0 nice:0 policy:1 rt_prio:99)

The comm is missing in the "task:" and it looks like a minus 3 is
the output. The correct display should be:

 #    | task: migration/0-3 (uid:0 nice:0 policy:1 rt_prio:99)

The problem is that the comm is being stored in the wrong data
structure. The max_tr.data[cpu] is what stores the comm, not the
tr->data[cpu].

Before this patch the max_tr.data[cpu]->comm was zeroed and the /debug/trace
ended up showing just the '-' sign followed by the pid.

Also remove a needless initialization of max_data.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
LKML-Reference: <1267824230-23861-1-git-send-email-acme@infradead.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Upstream commit: 1acaa1b2d9b5904c9cce06122990a2d71046ce16
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 kernel/trace/trace.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 9b66ee1..a1cf0ad 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -520,7 +520,7 @@ static void
 __update_max_tr(struct trace_array *tr, struct task_struct *tsk, int cpu)
 {
 	struct trace_array_cpu *data = tr->data[cpu];
-	struct trace_array_cpu *max_data = tr->data[cpu];
+	struct trace_array_cpu *max_data;
 
 	max_tr.cpu = cpu;
 	max_tr.time_start = data->preempt_timestamp;
@@ -530,7 +530,7 @@ __update_max_tr(struct trace_array *tr, struct task_struct *tsk, int cpu)
 	max_data->critical_start = data->critical_start;
 	max_data->critical_end = data->critical_end;
 
-	memcpy(data->comm, tsk->comm, TASK_COMM_LEN);
+	memcpy(max_data->comm, tsk->comm, TASK_COMM_LEN);
 	max_data->pid = tsk->pid;
 	max_data->uid = task_uid(tsk);
 	max_data->nice = tsk->static_prio - 20 - MAX_RT_PRIO;
-- 
1.6.6.1
