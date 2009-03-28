From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 2/2] cyclictest: init tracer only once
Date: Sat, 28 Mar 2009 12:18:55 -0000
Message-ID: <20090328121805.209471566@linutronix.de>
References: <20090328121720.138287980@linutronix.de>
Cc: RT-users <linux-rt-users@vger.kernel.org>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:40673 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752693AbZC1MVa (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 28 Mar 2009 08:21:30 -0400
Content-Disposition: inline; filename=cyclictest-init-tracer-only-once.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

The tracer setup happens in every thread, which is nonsense. First of
all it leads to a lot of irritating warnings because the things are
setup multiple times. The worst effect is that one tasks runs already
into the tracer stop condition and the next one reenables the tracer.

Move the tracer setup into the main thread and do it only once.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 src/cyclictest/cyclictest.c |  198 ++++++++++++++++++++++----------------------
 1 file changed, 103 insertions(+), 95 deletions(-)

Index: rt-tests/src/cyclictest/cyclictest.c
===================================================================
--- rt-tests.orig/src/cyclictest/cyclictest.c
+++ rt-tests/src/cyclictest/cyclictest.c
@@ -340,6 +340,105 @@ static int settracer(char *tracer)
 	return ret;
 }
 
+static void setup_tracer(void)
+{
+	if (!tracelimit)
+		return;
+
+	if (kernelversion == KV_26_CURR) {
+		char testname[MAX_PATH];
+
+		set_debugfileprefix();
+		fileprefix = debugfileprefix;
+
+		strcpy(testname, debugfileprefix);
+		strcat(testname, "tracing_enabled");
+		if (access(testname, R_OK)) {
+			fprintf(stderr, "ERROR: %s not found\n"
+			    "debug fs not mounted, "
+			    "TRACERs not configured?\n", testname);
+		}
+	} else
+		fileprefix = procfileprefix;
+
+	if (kernelversion == KV_26_CURR) {
+		char buffer[32];
+		int ret;
+
+		sprintf(buffer, "%d", tracelimit);
+		setkernvar("tracing_thresh", buffer);
+
+		/* ftrace_enabled is a sysctl variable */
+		fileprefix = procfileprefix;
+		if (ftrace)
+			setkernvar("ftrace_enabled", "1");
+		else
+			setkernvar("ftrace_enabled", "0");
+		fileprefix = debugfileprefix;
+
+		switch (tracetype) {
+		case NOTRACE:
+			if (ftrace)
+				ret = settracer(functiontracer);
+			else
+				ret = 0;
+			break;
+		case IRQSOFF:
+			ret = settracer("irqsoff");
+			break;
+		case PREEMPTOFF:
+			ret = settracer("preemptoff");
+			break;
+		case IRQPREEMPTOFF:
+			ret = settracer("preemptirqsoff");
+			break;
+		case EVENTS:
+			ret = settracer("events");
+			if (ftrace)
+				ret = settracer(functiontracer);
+			break;
+		case CTXTSWITCH:
+			ret = settracer("sched_switch");
+			break;
+		default:
+			printf("cyclictest: unknown tracer!\n");
+			ret = 0;
+			break;
+		}
+
+		if (ret)
+			fprintf(stderr, "Requested tracer not available\n");
+
+		setkernvar(traceroptions, "print-parent");
+		if (verbose) {
+			setkernvar(traceroptions, "sym-offset");
+			setkernvar(traceroptions, "sym-addr");
+			setkernvar(traceroptions, "verbose");
+		} else {
+			setkernvar(traceroptions, "nosym-offset");
+			setkernvar(traceroptions, "nosym-addr");
+			setkernvar(traceroptions, "noverbose");
+		}
+		setkernvar("tracing_max_latency", "0");
+		setkernvar("latency_hist/wakeup_latency/reset", "1");
+	} else {
+		setkernvar("trace_all_cpus", "1");
+		setkernvar("trace_freerunning", "1");
+		setkernvar("trace_print_on_crash", "0");
+		setkernvar("trace_user_triggered", "1");
+		setkernvar("trace_user_trigger_irq", "-1");
+		setkernvar("trace_verbose", "0");
+		setkernvar("preempt_thresh", "0");
+		setkernvar("wakeup_timing", "0");
+		setkernvar("preempt_max_latency", "0");
+		if (ftrace)
+			setkernvar("mcount_enabled", "1");
+		setkernvar("trace_enabled", "1");
+	}
+
+	tracing(1);
+}
+
 /*
  * parse an input value as a base10 value followed by an optional
  * suffix. The input value is presumed to be in seconds, unless
@@ -414,83 +513,6 @@ void *timerthread(void *param)
 	interval.tv_sec = par->interval / USEC_PER_SEC;
 	interval.tv_nsec = (par->interval % USEC_PER_SEC) * 1000;
 
-	if (tracelimit) {
-		if (kernelversion == KV_26_CURR) {
-			char buffer[32];
-			int ret;
-
-			sprintf(buffer, "%d", tracelimit);
-			setkernvar("tracing_thresh", buffer);
-
-			/* ftrace_enabled is a sysctl variable */
-			fileprefix = procfileprefix;
-			if (ftrace)
-				setkernvar("ftrace_enabled", "1");
-			else
-				setkernvar("ftrace_enabled", "0");
-			fileprefix = debugfileprefix;
-
-			switch (tracetype) {
-			case NOTRACE:
-				if (ftrace)
-					ret = settracer(functiontracer);
-				else
-					ret = 0;
-				break;
-			case IRQSOFF:
-				ret = settracer("irqsoff");
-				break;
-			case PREEMPTOFF:
-				ret = settracer("preemptoff");
-				break;
-			case IRQPREEMPTOFF:
-				ret = settracer("preemptirqsoff");
-				break;
-			case EVENTS:
-				ret = settracer("events");
-				if (ftrace)
-					ret = settracer(functiontracer);
-				break;
-			case CTXTSWITCH:
-				ret = settracer("sched_switch");
-				break;
-			default:
-				printf("cyclictest: unknown tracer!\n");
-				ret = 0;
-				break;
-			}
-
-			if (ret)
-				fprintf(stderr, "Requested tracer not available\n");
-
-			setkernvar(traceroptions, "print-parent");
-			if (verbose) {
-				setkernvar(traceroptions, "sym-offset");
-				setkernvar(traceroptions, "sym-addr");
-				setkernvar(traceroptions, "verbose");
-			} else {
-				setkernvar(traceroptions, "nosym-offset");
-				setkernvar(traceroptions, "nosym-addr");
-				setkernvar(traceroptions, "noverbose");
-			}
-			setkernvar("tracing_max_latency", "0");
-			setkernvar("latency_hist/wakeup_latency/reset", "1");
-		} else {
-			setkernvar("trace_all_cpus", "1");
-			setkernvar("trace_freerunning", "1");
-			setkernvar("trace_print_on_crash", "0");
-			setkernvar("trace_user_triggered", "1");
-			setkernvar("trace_user_trigger_irq", "-1");
-			setkernvar("trace_verbose", "0");
-			setkernvar("preempt_thresh", "0");
-			setkernvar("wakeup_timing", "0");
-			setkernvar("preempt_max_latency", "0");
-			if (ftrace)
-				setkernvar("mcount_enabled", "1");
-			setkernvar("trace_enabled", "1");
-		}
-	}
-
 	stat->tid = gettid();
 
 	sigemptyset(&sigset);
@@ -540,9 +562,6 @@ void *timerthread(void *param)
 
 	stat->threadstarted++;
 
-	if (tracelimit)
-		tracing(1);
-
 	while (!shutdown) {
 
 		long diff;
@@ -987,21 +1006,7 @@ int main(int argc, char **argv)
 	if (kernelversion == KV_NOT_26)
 		fprintf(stderr, "WARNING: Most functions require kernel 2.6\n");
 
-	if (tracelimit && kernelversion == KV_26_CURR) {
-		char testname[MAX_PATH];
-
-		set_debugfileprefix();
-		fileprefix = debugfileprefix;
-
-		strcpy(testname, debugfileprefix);
-		strcat(testname, "tracing_enabled");
-		if (access(testname, R_OK)) {
-			fprintf(stderr, "ERROR: %s not found\n"
-			    "debug fs not mounted, "
-			    "TRACERs not configured?\n", testname);
-		}
-	} else if (tracelimit)
-		fileprefix = procfileprefix;
+	setup_tracer();
 
 	if (check_timer())
 		fprintf(stderr, "WARNING: High resolution timers not available\n");
@@ -1116,6 +1121,9 @@ int main(int argc, char **argv)
  outpar:
 	free(par);
  out:
+	/* ensure that the tracer is stopped */
+	if (tracelimit)
+		tracing(0);
 
 	/* unlock everything */
 	if (lockall)


