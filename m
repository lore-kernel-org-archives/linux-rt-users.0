From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 1/2] cyclictest: preopen trace_enabled
Date: Mon, 13 Oct 2008 15:09:14 -0400 (EDT)
Message-ID: <alpine.DEB.1.10.0810131506150.380@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:60027 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753686AbYJMTJR (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 13 Oct 2008 15:09:17 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


The conversion to use kernvar caused an open and close at every iteration,
which is very expensive. This patch opens the file at start up and closes
it at exit.

Signed-off-by: Steven Rostedt <srostedt@redhat.com>
---
 src/cyclictest/cyclictest.c |   17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

Index: rt-tests.git/src/cyclictest/cyclictest.c
===================================================================
--- rt-tests.git.orig/src/cyclictest/cyclictest.c	2008-10-13 13:01:59.000000000 -0400
+++ rt-tests.git/src/cyclictest/cyclictest.c	2008-10-13 15:01:00.000000000 -0400
@@ -133,6 +133,8 @@ static int oscope_reduction = 1;
 static int tracetype;
 static int lockall = 0;
 
+static int traceenable_fd = -1;
+
 /* Backup of kernel variables that we modify */
 static struct kvars {
 	char name[KVARNAMELEN];
@@ -276,20 +278,25 @@ static inline long calcdiff(struct times
 	return diff;
 }
 
+void set_trace_enable(char val)
+{
+	write(traceenable_fd, &val, 1);
+}
+
 void tracing(int on)
 {
 	if (on) {
 		switch (kernelversion) {
 		case KV_26_LT18: gettimeofday(0,(struct timezone *)1); break;
 		case KV_26_LT24: prctl(0, 1); break;
-		case KV_26_CURR: setkernvar("tracing_enabled", "1"); break;
+		case KV_26_CURR: set_trace_enable('1'); break;
 		default:	 break;
 		}
 	} else {
 		switch (kernelversion) {
 		case KV_26_LT18: gettimeofday(0,0); break;
 		case KV_26_LT24: prctl(0, 0); break;
-		case KV_26_CURR: setkernvar("tracing_enabled", "0"); break;
+		case KV_26_CURR: set_trace_enable('0'); break;
 		default:	 break;
 		}
 	}
@@ -846,7 +853,8 @@ int main(int argc, char **argv)
 
 		strcpy(testname, debugfileprefix);
 		strcat(testname, "tracing_enabled");
-		if (access(testname, R_OK)) {
+		traceenable_fd = open(testname, O_RDWR);
+		if (traceenable_fd < 0) {
 			fprintf(stderr, "ERROR: %s not found\n"
 			    "debug fs not mounted, "
 			    "TRACERs not configured?\n", testname);
@@ -958,5 +966,8 @@ int main(int argc, char **argv)
 	if (kernelversion != KV_26_CURR)
 		restorekernvars();
 
+	if (traceenable_fd >= 0)
+		close(traceenable_fd);
+
 	exit(ret);
 }

