From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 2/2] add function_trace_stop
Date: Mon, 13 Oct 2008 15:16:34 -0400 (EDT)
Message-ID: <alpine.DEB.1.10.0810131509240.380@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.123]:44960 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754204AbYJMTQf (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 13 Oct 2008 15:16:35 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


2.6.26.6-rt10 added /debug/tracing/function_trace_stop which is a very 
quick way of starting and stopping the tracer. It does not disable the 
mcount call, but just sets a variable in the mcount call to return.

This patch tries to open the function_trace_stop file and if it succeeds
it will use the trace stop to start and stop the tracer an keep the ftrace 
enabled the entire time.

Signed-off-by: Steven Rostedt <srostedt@redhat.com>
---
 src/cyclictest/cyclictest.c |   37 +++++++++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

Index: rt-tests.git/src/cyclictest/cyclictest.c
===================================================================
--- rt-tests.git.orig/src/cyclictest/cyclictest.c	2008-10-13 15:04:11.000000000 -0400
+++ rt-tests.git/src/cyclictest/cyclictest.c	2008-10-13 15:13:36.000000000 -0400
@@ -134,6 +134,7 @@ static int tracetype;
 static int lockall = 0;
 
 static int traceenable_fd = -1;
+static int funcstop_fd = -1;
 
 /* Backup of kernel variables that we modify */
 static struct kvars {
@@ -153,7 +154,8 @@ enum kernelversion {
 	KV_NOT_26,
 	KV_26_LT18,
 	KV_26_LT24,
-	KV_26_CURR
+	KV_26_CURR,
+	KV_26_QUICKSTOP,
 };
 
 enum {
@@ -223,7 +225,7 @@ static void setkernvar(const char *name,
 	int i;
 	char oldvalue[KVALUELEN];
 
-	if (kernelversion != KV_26_CURR) {
+	if (kernelversion < KV_26_CURR) {
 		if (kernvar(O_RDONLY, name, oldvalue, sizeof(oldvalue)))
 			fprintf(stderr, "could not retrieve %s\n", name);
 		else {
@@ -283,6 +285,11 @@ void set_trace_enable(char val)
 	write(traceenable_fd, &val, 1);
 }
 
+static void setfuncstop(char val)
+{
+	write(funcstop_fd, &val, 1);
+}
+
 void tracing(int on)
 {
 	if (on) {
@@ -290,6 +297,7 @@ void tracing(int on)
 		case KV_26_LT18: gettimeofday(0,(struct timezone *)1); break;
 		case KV_26_LT24: prctl(0, 1); break;
 		case KV_26_CURR: set_trace_enable('1'); break;
+		case KV_26_QUICKSTOP: setfuncstop('0'); break;
 		default:	 break;
 		}
 	} else {
@@ -297,6 +305,7 @@ void tracing(int on)
 		case KV_26_LT18: gettimeofday(0,0); break;
 		case KV_26_LT24: prctl(0, 0); break;
 		case KV_26_CURR: set_trace_enable('0'); break;
+		case KV_26_QUICKSTOP: setfuncstop('1'); break;
 		default:	 break;
 		}
 	}
@@ -378,7 +387,7 @@ void *timerthread(void *param)
 	interval.tv_nsec = (par->interval % USEC_PER_SEC) * 1000;
 
 	if (tracelimit) {
-		if (kernelversion == KV_26_CURR) {
+		if (kernelversion >= KV_26_CURR) {
 			char buffer[32];
 			int ret;
 
@@ -858,6 +867,19 @@ int main(int argc, char **argv)
 			fprintf(stderr, "ERROR: %s not found\n"
 			    "debug fs not mounted, "
 			    "TRACERs not configured?\n", testname);
+		} else {
+			char *name = "function_trace_stop";
+
+			strncpy(testname, fileprefix, sizeof(testname));
+			strncat(testname, name, sizeof(testname) - strlen(fileprefix));
+			funcstop_fd = open(testname, O_RDWR);
+			if (funcstop_fd >= 0) {
+				/* enable tracing */
+				tracing(1);
+				kernelversion = KV_26_QUICKSTOP;
+				/* stop it */
+				tracing(0);
+			}
 		}
 	} else if (tracelimit)
 		fileprefix = procfileprefix;
@@ -963,9 +985,16 @@ int main(int argc, char **argv)
 		munlockall();
 
 	/* Be a nice program, cleanup */
-	if (kernelversion != KV_26_CURR)
+	if (kernelversion < KV_26_CURR)
 		restorekernvars();
 
+	if (funcstop_fd >= 0) {
+		/* disable tracing */
+		kernelversion = KV_26_CURR;
+		tracing(0);
+		close(funcstop_fd);
+	}
+
 	if (traceenable_fd >= 0)
 		close(traceenable_fd);
 
