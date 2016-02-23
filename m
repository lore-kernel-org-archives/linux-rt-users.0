From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 01/11] tools lib traceevent: Implement '%' operation
Date: Tue, 23 Feb 2016 17:00:42 -0300
Message-ID: <1456257652-20059-2-git-send-email-acme@kernel.org>
References: <1456257652-20059-1-git-send-email-acme@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Juri Lelli <juri.lelli@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
To: Ingo Molnar <mingo@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456257652-20059-1-git-send-email-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Daniel Bristot de Oliveira <bristot@redhat.com>

The operation '%' is not implemented on event-parse.c, causing an error
when parsing events with '%' the operation in its printk format. For
example,

  # perf record -e sched:sched_deadline_yield ~/yield-test
    Warning: [sched:sched_deadline_yield] unknown op '%'
  ....
  # perf script
    Warning: [sched:sched_deadline_yield] unknown op '%'
        test  1641 [006]  3364.109319: sched:sched_deadline_yield: \
                        [FAILED TO PARSE] now=3364109314595        \
                        deadline=3364139295135 runtime=19975597

This patch implements the '%' operation. With this patch, we see the
correct output:

  # perf record -e sched:sched_deadline_yield ~/yield-test
    No Warning

  # perf script
        yield-test  4005 [001]  4623.650978: sched:sched_deadline_yield: \
                now=4623.650974050                                       \
                deadline=4623.680957364 remaining_runtime=19979611

Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Reviewed-by: Steven Rostedt <rostedt@goodmis.org>
Cc: Juri Lelli <juri.lelli@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
Link: http://lkml.kernel.org/r/5c96a395c56cea6d3d13d949051bdece86cc26e0.1456157869.git.bristot@redhat.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/event-parse.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index c3bd294a63d1..575e75174087 100644
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
