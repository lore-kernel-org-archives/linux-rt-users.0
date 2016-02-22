From: Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH 4/4] tools lib traceevent: Implements '%' operation
Date: Mon, 22 Feb 2016 14:08:22 -0300
Message-ID: <5c96a395c56cea6d3d13d949051bdece86cc26e0.1456157869.git.bristot@redhat.com>
References: <cover.1456157869.git.bristot@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juri Lelli <juri.lelli@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1456157869.git.bristot@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

The operation '%' is not implemented on event-parse.c, causing
an error on the parse of events with '%' operation on its
printk format. For example,

# perf record -e sched:sched_deadline_yield ~/y
  Warning: [sched:sched_deadline_yield] unknown op '%'
....
# perf script
  Warning: [sched:sched_deadline_yield] unknown op '%'
	y  1641 [006]  3364.109319: sched:sched_deadline_yield: \
			[FAILED TO PARSE] now=3364109314595 	\
			deadline=3364139295135 runtime=19975597

This patch implements the '%' operation. With this patch, we see the
correct output:

# perf record -e sched:sched_deadline_yield ~/y
  No Warning

# perf script
	y  4005 [001]  4623.650978: sched:sched_deadline_yield: \
		now=4623.650974050				\
		deadline=4623.680957364 remaining_runtime=19979611

Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
---
 tools/lib/traceevent/event-parse.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index c3bd294..575e751 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -1951,6 +1951,7 @@ process_op(struct event_format *event, struct print_arg *arg, char **tok)
 		   strcmp(token, "*") == 0 ||
 		   strcmp(token, "^") == 0 ||
 		   strcmp(token, "/") == 0 ||
+		   strcmp(token, "%") == 0 ||
 		   strcmp(token, "<") == 0 ||
 		   strcmp(token, ">") == 0 ||
 		   strcmp(token, "<=") == 0 ||
@@ -3689,6 +3690,9 @@ eval_num_arg(void *data, int size, struct event_format *event, struct print_arg
 		case '/':
 			val = left / right;
 			break;
+		case '%':
+			val = left % right;
+			break;
 		case '*':
 			val = left * right;
 			break;
-- 
2.5.0
