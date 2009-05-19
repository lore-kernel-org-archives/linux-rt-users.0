From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: [PATCH 9/9] ftrace: function profiler band-aid
Date: Tue, 19 May 2009 12:05:24 -0300
Message-ID: <20090519150524.GQ27687@unix.sh>
References: <20090519143607.GH27687@unix.sh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>,
	williams <williams@redhat.com>, tglx <tglx@linutronix.de>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-px0-f191.google.com ([209.85.216.191]:45298 "EHLO
	mail-px0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751769AbZESPF3 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 19 May 2009 11:05:29 -0400
Received: by pxi29 with SMTP id 29so2463283pxi.33
        for <linux-rt-users@vger.kernel.org>; Tue, 19 May 2009 08:05:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090519143607.GH27687@unix.sh>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Kernel Panic when stressing ftrace function_profiler

https://bugzilla.redhat.com/show_bug.cgi?id=500156

This patch does not fix the whole issue but removes a few probable spots
where the panic could originate from.

	[root@void ~]#  while true
	>  do echo "starting new test..."
	> ./function_profiler.sh sleep 2 > /dev/null
	> dmesg -c
	> ./function_profiler.sh ls -la > /dev/null
	> dmesg -c;
	> done
	starting new test...
	starting new test...
	...
	Kernel panic - not syncing: Fatal exception  

Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>

---
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 8509861..3228291 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -372,7 +372,8 @@ static int function_stat_show(struct seq_file *m, void *v)
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	seq_printf(m, "    ");
 	avg = rec->time;
-	do_div(avg, rec->counter);
+	if (rec->counter)
+		do_div(avg, rec->counter);
 
 	mutex_lock(&mutex);
 	trace_seq_init(&s);
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 10f6ad7..e352d82 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -436,7 +436,7 @@ trace_print_graph_duration(unsigned long long duration, struct trace_seq *s)
 	int ret, len;
 	int i;
 
-	sprintf(msecs_str, "%lu", (unsigned long) duration);
+	snprintf(msecs_str, sizeof(msecs_str), "%lu", (unsigned long) duration);
 
 	/* Print msecs */
 	ret = trace_seq_printf(s, "%s", msecs_str);
-- 
[ Luis Claudio R. Goncalves                    Bass - Gospel - RT ]
[ Fingerprint: 4FDD B8C4 3C59 34BD 8BE9  2696 7203 D980 A448 C8F8 ]

