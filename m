From: Carsten Emde <C.Emde@osadl.org>
Subject: [PATCH 1/1] fix-policy-display-for-cyclictest.patch
Date: Mon, 08 Mar 2010 09:37:50 +0100
Message-ID: <20100308083945.956980588@osadl.org>
References: <20100308083749.529203420@osadl.org>
Cc: Clark Williams <williams@redhat.com>,
	RT-users <linux-rt-users@vger.kernel.org>,
	Carsten Emde <C.Emde@osadl.org>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:35458 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751319Ab0CHIk3 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 8 Mar 2010 03:40:29 -0500
Content-Disposition: inline; filename=fix-policy-display-for-cyclictest.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

If the policy is forced to SCHED_OTHER, since the priority no longer
fits into the SCHED_FIFO or SCHED_RR range, the policy display of
cyclictest is somewhat incorrect.

Display all policies.

Also make the variable policystr static; the condition
"if (!policystr)" is useless, otherwise.

In addition, place the priority logic before decrementing the priority;
a priority of 1 is incorrectly made SCHED_OTHER, otherwise.

Signed-off-by: Carsten Emde <C.Emde@osadl.org>

Index: rt-tests/src/cyclictest/cyclictest.c
===================================================================
--- rt-tests.orig/src/cyclictest/cyclictest.c
+++ rt-tests/src/cyclictest/cyclictest.c
@@ -156,6 +156,7 @@ static int histogram = 0;
 static int duration = 0;
 static int use_nsecs = 0;
 static int refresh_on_max;
+static int force_sched_other;
 
 static pthread_cond_t refresh_on_max_cond = PTHREAD_COND_INITIALIZER;
 static pthread_mutex_t refresh_on_max_lock = PTHREAD_MUTEX_INITIALIZER;
@@ -1295,11 +1296,14 @@ int main(int argc, char **argv)
 		}
 
 		par->prio = priority;
+                if (priority && (policy == SCHED_FIFO || policy == SCHED_RR))
+			par->policy = policy;
+                else {
+			par->policy = SCHED_OTHER;
+			force_sched_other = 1;
+		}
 		if (priority && !histogram && !smp && !numa)
 			priority--;
-                if (priority && policy == SCHED_FIFO) par->policy = SCHED_FIFO;
-                else if (priority && policy == SCHED_RR) par->policy = SCHED_RR;
-                else  par->policy = SCHED_OTHER;
 		par->clock = clocksources[clocksel];
 		par->mode = mode;
 		par->timermode = timermode;
@@ -1330,18 +1334,27 @@ int main(int argc, char **argv)
 	while (!shutdown) {
 		char lavg[256];
 		int fd, len, allstopped = 0;
-		char *policystr = NULL;
+		static char *policystr = NULL;
+		static char *slash = NULL;
+		static char *policystr2;
 
 		if (!policystr)
 			policystr = policyname(policy);
 
+		if (!slash) {
+			if (force_sched_other) {
+				slash = "/";
+				policystr2 = policyname(SCHED_OTHER);
+			} else
+				slash = policystr2 = "";
+		}
 		if (!verbose && !quiet) {
 			fd = open("/proc/loadavg", O_RDONLY, 0666);
 			len = read(fd, &lavg, 255);
 			close(fd);
 			lavg[len-1] = 0x0;
-			printf("policy: %s: loadavg: %s          \n\n", 
-			       policystr, lavg);
+			printf("policy: %s%s%s: loadavg: %s          \n\n",
+			       policystr, slash, policystr2, lavg);
 		}
 
 		for (i = 0; i < num_threads; i++) {

