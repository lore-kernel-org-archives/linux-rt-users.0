From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 1/3] ftrace: Fix trace header alignment
Date: Sun, 30 Oct 2016 12:49:32 -0400
Message-ID: <20161030164946.973232272@goodmis.org>
References: <20161030164931.614263675@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        stable-rt@vger.kernel.org,
        Mike Galbraith <umgwanakikbuti@gmail.com>
To: linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0001-ftrace-Fix-trace-header-alignment.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.10.104-rt117-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Mike Galbraith <umgwanakikbuti@gmail.com>

Line up helper arrows to the right column.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
[bigeasy: fixup function tracer header]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/trace/trace.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index e16f5be456b3..4f04527ce506 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2411,17 +2411,17 @@ get_total_entries(struct trace_buffer *buf,
 
 static void print_lat_help_header(struct seq_file *m)
 {
-	seq_puts(m, "#                   _--------=> CPU#              \n");
-	seq_puts(m, "#                  / _-------=> irqs-off          \n");
-	seq_puts(m, "#                 | / _------=> need-resched      \n");
-	seq_puts(m, "#                 || / _-----=> need-resched_lazy \n");
-	seq_puts(m, "#                 ||| / _----=> hardirq/softirq   \n");
-	seq_puts(m, "#                 |||| / _---=> preempt-depth     \n");
-	seq_puts(m, "#                 ||||| / _--=> preempt-lazy-depth\n");
-	seq_puts(m, "#                 |||||| / _-=> migrate-disable   \n");
-	seq_puts(m, "#                 ||||||| /     delay             \n");
-	seq_puts(m, "#  cmd     pid    |||||||| time  |   caller       \n");
-	seq_puts(m, "#     \\   /      ||||||||  \\   |   /            \n");
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
-- 
2.9.3
