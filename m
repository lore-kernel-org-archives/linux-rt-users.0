From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: [patch] ftrace: Fix latency trace header alignment
Date: Sun, 16 Oct 2016 05:08:30 +0200
Message-ID: <1476587310.1538.3.camel@gmail.com>
References: <20161006085228.jl6rpszdp5c2p2nr@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161006085228.jl6rpszdp5c2p2nr@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Line up helper arrows to the right column.

Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>
---
 kernel/trace/trace.c |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2896,17 +2896,17 @@ get_total_entries(struct trace_buffer *b
 
 static void print_lat_help_header(struct seq_file *m)
 {
-	seq_puts(m, "#                   _--------=> CPU#              \n"
-		    "#                  / _-------=> irqs-off          \n"
-		    "#                 | / _------=> need-resched      \n"
-		    "#                 || / _-----=> need-resched_lazy \n"
-		    "#                 ||| / _----=> hardirq/softirq   \n"
-		    "#                 |||| / _---=> preempt-depth     \n"
-		    "#                 ||||| / _--=> preempt-lazy-depth\n"
-		    "#                 |||||| / _-=> migrate-disable   \n"
-		    "#                 ||||||| /     delay             \n"
-		    "#  cmd     pid    |||||||| time  |   caller       \n"
-		    "#     \\   /      ||||||||  \\   |   /            \n");
+	seq_puts(m, "#                  _--------=> CPU#              \n"
+		    "#                 / _-------=> irqs-off          \n"
+		    "#                | / _------=> need-resched      \n"
+		    "#                || / _-----=> need-resched_lazy \n"
+		    "#                ||| / _----=> hardirq/softirq   \n"
+		    "#                |||| / _---=> preempt-depth     \n"
+		    "#                ||||| / _--=> preempt-lazy-depth\n"
+		    "#                |||||| / _-=> migrate-disable   \n"
+		    "#                ||||||| /     delay             \n"
+		    "# cmd     pid    |||||||| time   |  caller       \n"
+		    "#     \\   /      ||||||||   \\    |  /            \n");
 }
 
 static void print_event_info(struct trace_buffer *buf, struct seq_file *m)
