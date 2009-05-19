From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: [PATCH 7/9] tracing: add average time in function to function
	profiler
Date: Tue, 19 May 2009 12:01:05 -0300
Message-ID: <20090519150105.GO27687@unix.sh>
References: <20090519143607.GH27687@unix.sh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>,
	williams <williams@redhat.com>, tglx <tglx@linutronix.de>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pz0-f202.google.com ([209.85.222.202]:62076 "EHLO
	mail-pz0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751216AbZESPIe (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 19 May 2009 11:08:34 -0400
Received: by pzk40 with SMTP id 40so257841pzk.33
        for <linux-rt-users@vger.kernel.org>; Tue, 19 May 2009 08:08:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090519143607.GH27687@unix.sh>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

tracing: add average time in function to function profiler

Show the average time in the function (Time / Hit)

Backport to 2.6.29.3-rt14.

| From: Steven Rostedt <srostedt@redhat.com>
| 
| Show the average time in the function (Time / Hit)
| 
|   Function                               Hit    Time            Avg
|   --------                               ---    ----            ---
|   mwait_idle                              51    140326.6 us     2751.503 us
|   smp_apic_timer_interrupt                47    3517.735 us     74.845 us
|   schedule                                10    2738.754 us     273.875 us
|   __schedule                              10    2732.857 us     273.285 us
|   hrtimer_interrupt                       47    1896.104 us     40.342 us
|   irq_exit                                56    1711.833 us     30.568 us
|   __run_hrtimer                           47    1315.589 us     27.991 us
|   tick_sched_timer                        47    1138.690 us     24.227 us
|   do_softirq                              56    1116.829 us     19.943 us
|   __do_softirq                            56    1066.932 us     19.052 us
|   do_IRQ                                   9    926.153 us      102.905 us
| 
| Signed-off-by: Steven Rostedt <srostedt@redhat.com>

Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
---
 kernel/trace/ftrace.c |   21 ++++++++++++++-------
 1 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 4d90c91..c7f4a4b 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -345,8 +345,10 @@ static int function_stat_cmp(void *p1, void *p2)
 static int function_stat_headers(struct seq_file *m)
 {
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
-	seq_printf(m, "  Function                               Hit    Time\n"
-		      "  --------                               ---    ----\n");
+	seq_printf(m, "  Function                               "
+		   "Hit    Time            Avg\n"
+		      "  --------                               "
+		   "---    ----            ---\n");
 #else
 	seq_printf(m, "  Function                               Hit\n"
 		      "  --------                               ---\n");
@@ -359,12 +361,9 @@ static int function_stat_show(struct seq_file *m, void *v)
 	struct ftrace_profile *rec = v;
 	char str[KSYM_SYMBOL_LEN];
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
-	static struct trace_seq s;
 	static DEFINE_MUTEX(mutex);
-
-	mutex_lock(&mutex);
-	trace_seq_init(&s);
-	trace_print_graph_duration(rec->time, &s);
+	static struct trace_seq s;
+	unsigned long long avg;
 #endif
 
 	kallsyms_lookup(rec->ip, NULL, NULL, NULL, str);
@@ -372,6 +371,14 @@ static int function_stat_show(struct seq_file *m, void *v)
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	seq_printf(m, "    ");
+	avg = rec->time;
+	do_div(avg, rec->counter);
+
+	mutex_lock(&mutex);
+	trace_seq_init(&s);
+	trace_print_graph_duration(rec->time, &s);
+	trace_seq_puts(&s, "    ");
+	trace_print_graph_duration(avg, &s);
 	trace_print_seq(m, &s);
 	mutex_unlock(&mutex);
 #endif
-- 
1.6.2

-- 
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

-- 
[ Luis Claudio R. Goncalves                    Bass - Gospel - RT ]
[ Fingerprint: 4FDD B8C4 3C59 34BD 8BE9  2696 7203 D980 A448 C8F8 ]

