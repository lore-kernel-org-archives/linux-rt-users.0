From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: [PATCH 8/9] backport function profiler fixes
Date: Tue, 19 May 2009 12:03:41 -0300
Message-ID: <20090519150341.GP27687@unix.sh>
References: <20090519143607.GH27687@unix.sh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>,
	williams <williams@redhat.com>, tglx <tglx@linutronix.de>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-px0-f123.google.com ([209.85.216.123]:47856 "EHLO
	mail-px0-f123.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751212AbZESPDn (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 19 May 2009 11:03:43 -0400
Received: by pxi29 with SMTP id 29so2462291pxi.33
        for <linux-rt-users@vger.kernel.org>; Tue, 19 May 2009 08:03:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090519143607.GH27687@unix.sh>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Additional fixes to the backport of Ftrace's Function Profiler

Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
---

 kernel/trace/ftrace.c     |    2 +-
 kernel/trace/trace_stat.c |    2 +-
 kernel/trace/trace_stat.h |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)


diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index cd91e88..ed1fc50 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -301,7 +301,7 @@ function_stat_next(void *v, int idx)
 	return rec;
 }
 
-static void *function_stat_start(void)
+static void *function_stat_start(struct tracer_stat *trace)
 {
 	struct ftrace_profile_stat *stat =
 		container_of(trace, struct ftrace_profile_stat, stat);
diff --git a/kernel/trace/trace_stat.c b/kernel/trace/trace_stat.c
index acdebd7..fdde3a4 100644
--- a/kernel/trace/trace_stat.c
+++ b/kernel/trace/trace_stat.c
@@ -85,7 +85,7 @@ static int stat_seq_init(struct tracer_stat_session *session)
 	if (!ts->stat_cmp)
 		ts->stat_cmp = dummy_cmp;
 
-	stat = ts->stat_start();
+	stat = ts->stat_start(ts);
 	if (!stat)
 		goto exit;
 
diff --git a/kernel/trace/trace_stat.h b/kernel/trace/trace_stat.h
index 202274c..f3546a2 100644
--- a/kernel/trace/trace_stat.h
+++ b/kernel/trace/trace_stat.h
@@ -12,7 +12,7 @@ struct tracer_stat {
 	/* The name of your stat file */
 	const char		*name;
 	/* Iteration over statistic entries */
-	void			*(*stat_start)(void);
+	void			*(*stat_start)(struct tracer_stat *trace);
 	void			*(*stat_next)(void *prev, int idx);
 	/* Compare two entries for stats sorting */
 	int			(*stat_cmp)(void *p1, void *p2);
-- 
[ Luis Claudio R. Goncalves                    Bass - Gospel - RT ]
[ Fingerprint: 4FDD B8C4 3C59 34BD 8BE9  2696 7203 D980 A448 C8F8 ]

