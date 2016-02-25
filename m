From: tip-bot for Daniel Bristot de Oliveira <tipbot@zytor.com>
Subject: [tip:perf/core] tools lib traceevent: Implement '%' operation
Date: Wed, 24 Feb 2016 21:41:41 -0800
Message-ID: <tip-0e47b38dcd24c78d0699b42f28d5986154d2aa11@git.kernel.org>
References: <5c96a395c56cea6d3d13d949051bdece86cc26e0.1456157869.git.bristot@redhat.com>
Reply-To: tglx@linutronix.de, juri.lelli@gmail.com, acme@redhat.com,
	  linux-rt-users@vger.kernel.org, mingo@kernel.org,
	  rostedt@goodmis.org, peterz@infradead.org, bristot@redhat.com,
	  hpa@zytor.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: mingo@kernel.org, rostedt@goodmis.org,
	linux-rt-users@vger.kernel.org, juri.lelli@gmail.com,
	acme@redhat.com, tglx@linutronix.de, linux-kernel@vger.kernel.org,
	bristot@redhat.com, hpa@zytor.com, peterz@infradead.org
To: linux-tip-commits@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5c96a395c56cea6d3d13d949051bdece86cc26e0.1456157869.git.bristot@redhat.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Commit-ID:  0e47b38dcd24c78d0699b42f28d5986154d2aa11
Gitweb:     http://git.kernel.org/tip/0e47b38dcd24c78d0699b42f28d5986154d2aa11
Author:     Daniel Bristot de Oliveira <bristot@redhat.com>
AuthorDate: Mon, 22 Feb 2016 14:08:22 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 23 Feb 2016 11:40:51 -0300

tools lib traceevent: Implement '%' operation

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
