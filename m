From: Luiz Capitulino <lcapitulino@redhat.com>
Subject: [PATCH 4/4] cyclictest: add --tracemark option
Date: Thu, 25 Feb 2016 11:29:17 -0500
Message-ID: <1456417757-13444-5-git-send-email-lcapitulino@redhat.com>
References: <1456417757-13444-1-git-send-email-lcapitulino@redhat.com>
Cc: jkacur@redhat.com, williams@redhat.com
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37935 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932712AbcBYQ3a (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 25 Feb 2016 11:29:30 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (Postfix) with ESMTPS id 30C656DDC0
	for <linux-rt-users@vger.kernel.org>; Thu, 25 Feb 2016 16:29:30 +0000 (UTC)
In-Reply-To: <1456417757-13444-1-git-send-email-lcapitulino@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

cyclictest will only write to /sys/kernel/debug/tracing/trace_maker
if it's also setup to do tracing. This conflicts with
running cyclictest under trace-cmd.

The --tracemark option tells cyclictest to write to the
trace_marker file even when it's not doing tracing.

It's can be used like this:

 # trace-cmd record [...] cyclictest [...] -bX --tracemark --notrace

Signed-off-by: Luiz Capitulino <lcapitulino@redhat.com>
---
 src/cyclictest/cyclictest.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index e35088b..5a261e2 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -167,6 +167,7 @@ struct thread_stat {
 static int shutdown;
 static int tracelimit = 0;
 static int notrace = 0;
+static int trace_marker = 0;
 static int ftrace = 0;
 static int kernelversion;
 static int verbose = 0;
@@ -510,6 +511,18 @@ static void open_tracemark_fd(void)
 		warn("unable to open trace_marker file: %s\n", path);
 }
 
+static void enable_trace_mark(void)
+{
+	if (!trace_marker)
+		return;
+
+	if (!tracelimit)
+		fatal("--tracemark requires -b\n");
+
+	debugfs_prepare();
+	open_tracemark_fd();
+}
+
 static void setup_tracer(void)
 {
 	if (!tracelimit || notrace)
@@ -1234,7 +1247,7 @@ enum option_values {
 	OPT_QUIET, OPT_PRIOSPREAD, OPT_RELATIVE, OPT_RESOLUTION, OPT_SYSTEM,
 	OPT_SMP, OPT_THREADS, OPT_TRACER, OPT_UNBUFFERED, OPT_NUMA, OPT_VERBOSE,
 	OPT_WAKEUP, OPT_WAKEUPRT, OPT_DBGCYCLIC, OPT_POLICY, OPT_HELP, OPT_NUMOPTS,
-	OPT_ALIGNED, OPT_LAPTOP, OPT_SECALIGNED,
+	OPT_ALIGNED, OPT_LAPTOP, OPT_SECALIGNED, OPT_TRACEMARK,
 };
 
 /* Process commandline options */
@@ -1285,6 +1298,7 @@ static void process_options (int argc, char *argv[], int max_cpus)
 			{"system",           no_argument,       NULL, OPT_SYSTEM },
 			{"smp",              no_argument,       NULL, OPT_SMP },
 			{"threads",          optional_argument, NULL, OPT_THREADS },
+			{"tracemark",        no_argument,       NULL, OPT_TRACEMARK },
 			{"tracer",           required_argument, NULL, OPT_TRACER },
 			{"unbuffered",       no_argument,       NULL, OPT_UNBUFFERED },
 			{"numa",             no_argument,       NULL, OPT_NUMA },
@@ -1509,6 +1523,8 @@ static void process_options (int argc, char *argv[], int max_cpus)
 			ct_debug = 1; break;
 		case OPT_LAPTOP:
 			laptop = 1; break;
+		case OPT_TRACEMARK:
+			trace_marker = 1; break;
 		}
 	}
 
@@ -1850,6 +1866,8 @@ int main(int argc, char **argv)
 
 	setup_tracer();
 
+	enable_trace_mark();
+
 	if (check_timer())
 		warn("High resolution timers not available\n");
 
-- 
2.1.0

