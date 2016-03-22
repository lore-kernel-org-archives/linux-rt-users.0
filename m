From: Luiz Capitulino <lcapitulino@redhat.com>
Subject: [PATCH v3] cyclictest: add --tracemark option
Date: Tue, 22 Mar 2016 13:27:08 -0400
Message-ID: <20160322132708.20a79023@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: jkacur@redhat.com, williams@redhat.com
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59316 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751735AbcCVR1L (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 22 Mar 2016 13:27:11 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (Postfix) with ESMTPS id 58828C00B8DE
	for <linux-rt-users@vger.kernel.org>; Tue, 22 Mar 2016 17:27:11 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

cyclictest will only write to /sys/kernel/debug/tracing/trace_maker
if it's also setup to do tracing. This conflicts with
running cyclictest under trace-cmd.

The --tracemark option tells cyclictest to write to the
trace_marker file even when it's not doing tracing.

It can be used like this:

 # trace-cmd record [...] cyclictest [...] -bX --tracemark --notrace

Signed-off-by: Luiz Capitulino <lcapitulino@redhat.com>
---

John, I hope this is what you asked me to do.

o v3

 - Rebased on top of latest devel/v0.97 (HEAD a638701)
 - Add missing help text

 src/cyclictest/cyclictest.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index b9571f5..4844dfa 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -202,6 +202,7 @@ static void trigger_update(struct thread_param *par, int diff, int64_t ts);
 static int shutdown;
 static int tracelimit = 0;
 static int notrace = 0;
+static int trace_marker = 0;
 static int ftrace = 0;
 static int kernelversion;
 static int verbose = 0;
@@ -561,6 +562,18 @@ static void debugfs_prepare(void)
 		fileprefix = procfileprefix;
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
@@ -1312,6 +1325,7 @@ static void display_help(int error)
 	       "-t [NUM] --threads=NUM     number of threads:\n"
 	       "                           without NUM, threads = max_cpus\n"
 	       "                           without -t default = 1\n"
+	       "         --tracemark       write a trace mark when -b latency is exceeded\n"
 	       "-T TRACE --tracer=TRACER   set tracing function\n"
 	       "    configured tracers: %s\n"
 	       "-u       --unbuffered      force unbuffered output for live processing\n"
@@ -1453,7 +1467,7 @@ enum option_values {
 	OPT_SYSTEM, OPT_SMP, OPT_THREADS, OPT_TRACER, OPT_TRIGGER,
 	OPT_TRIGGER_NODES, OPT_UNBUFFERED, OPT_NUMA, OPT_VERBOSE, OPT_WAKEUP,
 	OPT_WAKEUPRT, OPT_DBGCYCLIC, OPT_POLICY, OPT_HELP, OPT_NUMOPTS,
-	OPT_ALIGNED, OPT_SECALIGNED, OPT_LAPTOP, OPT_SMI,
+	OPT_ALIGNED, OPT_SECALIGNED, OPT_LAPTOP, OPT_SMI, OPT_TRACEMARK,
 };
 
 /* Process commandline options */
@@ -1508,6 +1522,7 @@ static void process_options (int argc, char *argv[], int max_cpus)
 			{"spike",	     required_argument, NULL, OPT_TRIGGER },
 			{"spike-nodes",	     required_argument, NULL, OPT_TRIGGER_NODES },
 			{"threads",          optional_argument, NULL, OPT_THREADS },
+			{"tracemark",        no_argument,       NULL, OPT_TRACEMARK },
 			{"tracer",           required_argument, NULL, OPT_TRACER },
 			{"unbuffered",       no_argument,       NULL, OPT_UNBUFFERED },
 			{"numa",             no_argument,       NULL, OPT_NUMA },
@@ -1749,6 +1764,8 @@ static void process_options (int argc, char *argv[], int max_cpus)
 			fatal("--smi is not available on your arch\n");
 #endif
 			break;
+		case OPT_TRACEMARK:
+			trace_marker = 1; break;
 		}
 	}
 
@@ -2184,6 +2201,8 @@ int main(int argc, char **argv)
 
 	setup_tracer();
 
+	enable_trace_mark();
+
 	if (check_timer())
 		warn("High resolution timers not available\n");
 
-- 
2.1.0

