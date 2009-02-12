From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 2/2] cyclictest: support for latest mainline tracer
Date: Thu, 12 Feb 2009 22:40:25 -0000
Message-ID: <20090212222052.263840253@linutronix.de>
References: <20090212221944.272839206@linutronix.de>
Cc: Clark Williams <williams@redhat.com>
To: rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:47292 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756980AbZBLWl0 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 12 Feb 2009 17:41:26 -0500
Content-Disposition: inline; filename=support-for-latest-mainline-tracers.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

The tracer in mainline changed the interface another time. Make it
work again.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 src/cyclictest/cyclictest.c |   47 ++++++++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 21 deletions(-)

Index: rt-tests/src/cyclictest/cyclictest.c
===================================================================
--- rt-tests.orig/src/cyclictest/cyclictest.c
+++ rt-tests/src/cyclictest/cyclictest.c
@@ -166,6 +166,9 @@ enum {
 	ERROR_NOTFOUND	= -2,
 };
 
+static char functiontracer[MAX_PATH];
+static char traceroptions[MAX_PATH];
+
 /*
  * Finds the path to the debugfs/tracing
  */
@@ -278,7 +281,6 @@ static inline void tsnorm(struct timespe
 static inline long calcdiff(struct timespec t1, struct timespec t2)
 {
 	long diff;
-
 	diff = USEC_PER_SEC * ((int) t1.tv_sec - (int) t2.tv_sec);
 	diff += ((int) t1.tv_nsec - (int) t2.tv_nsec) / 1000;
 	return diff;
@@ -313,8 +315,7 @@ static int settracer(char *tracer)
 
 	/* Make sure tracer is available */
 	strncpy(filename, debugfileprefix, sizeof(filename));
-	strncat(filename, "available_tracers",
-		sizeof(filename) - strlen(debugfileprefix));
+	strncat(filename, "available_tracers", sizeof(filename) - strlen(debugfileprefix));
 
 	fp = fopen(filename, "r");
 	if (!fp)
@@ -432,7 +433,7 @@ void *timerthread(void *param)
 			switch (tracetype) {
 			case NOTRACE:
 				if (ftrace)
-					ret = settracer("ftrace");
+					ret = settracer(functiontracer);
 				else
 					ret = 0;
 				break;
@@ -448,7 +449,7 @@ void *timerthread(void *param)
 			case EVENTS:
 				ret = settracer("events");
 				if (ftrace)
-					ret = settracer("ftrace");
+					ret = settracer(functiontracer);
 				break;
 			case CTXTSWITCH:
 				ret = settracer("sched_switch");
@@ -462,15 +463,15 @@ void *timerthread(void *param)
 			if (ret)
 				fprintf(stderr, "Requested tracer not available\n");
 
-			setkernvar("iter_ctrl", "print-parent");
+			setkernvar(traceroptions, "print-parent");
 			if (verbose) {
-				setkernvar("iter_ctrl", "sym-offset");
-				setkernvar("iter_ctrl", "sym-addr");
-				setkernvar("iter_ctrl", "verbose");
+				setkernvar(traceroptions, "sym-offset");
+				setkernvar(traceroptions, "sym-addr");
+				setkernvar(traceroptions, "verbose");
 			} else {
-				setkernvar("iter_ctrl", "nosym-offset");
-				setkernvar("iter_ctrl", "nosym-addr");
-				setkernvar("iter_ctrl", "noverbose");
+				setkernvar(traceroptions, "nosym-offset");
+				setkernvar(traceroptions, "nosym-addr");
+				setkernvar(traceroptions, "noverbose");
 			}
 			setkernvar("tracing_max_latency", "0");
 			setkernvar("latency_hist/wakeup_latency/reset", "1");
@@ -737,9 +738,8 @@ static void process_options (int argc, c
 			{"help", no_argument, NULL, '?'},
 			{NULL, 0, NULL, 0}
 		};
-		int c = getopt_long (argc, argv,
-				     "a::b:Bc:d:fh:i:Il:no:p:Pmqrst::vD:",
-				     long_options, &option_index);
+		int c = getopt_long (argc, argv, "a::b:Bc:d:fh:i:Il:no:p:Pmqrst::vD:",
+			long_options, &option_index);
 		if (c == -1)
 			break;
 		switch (c) {
@@ -792,9 +792,8 @@ static void process_options (int argc, c
 		if (affinity < 0)
 			error = 1;
 		if (affinity >= max_cpus) {
-			fprintf(stderr, "ERROR: CPU #%d not found, "
-				"only %d CPUs available\n",
-				affinity, max_cpus);
+			fprintf(stderr, "ERROR: CPU #%d not found, only %d CPUs available\n",
+			    affinity, max_cpus);
 			error = 1;
 		}
 	} else if (tracelimit)
@@ -807,8 +806,7 @@ static void process_options (int argc, c
 		error = 1;
 
 	if (oscope_reduction > 1 && !verbose) {
-		fprintf(stderr,
-			"ERROR: -o option only meaningful, if verbose\n");
+		fprintf(stderr, "ERROR: -o option only meaningful, if verbose\n");
 		error = 1;
 	}
 
@@ -842,8 +840,15 @@ static int check_kernel(void)
 			kv = KV_26_LT18;
 		else if (sub < 24)
 			kv = KV_26_LT24;
-		else
+		else if (sub < 28) {
 			kv = KV_26_CURR;
+			strcpy(functiontracer, "ftrace");
+			strcpy(traceroptions, "iter_ctrl");
+		} else {
+			kv = KV_26_CURR;
+			strcpy(functiontracer, "function");
+			strcpy(traceroptions, "trace_options");
+		}
 	} else
 		kv = KV_NOT_26;
 


