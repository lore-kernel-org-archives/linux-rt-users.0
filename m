From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: cyclictest problem/bug as non-root
Date: Fri, 10 Feb 2012 12:57:21 +0100
Message-ID: <20120210115721.GA13313@opentech.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hofr.at ([212.69.189.236]:50516 "EHLO mail.hofr.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751205Ab2BJMIL (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 10 Feb 2012 07:08:11 -0500
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


HI !

 minor bug in cyclictest but potential causing confusion on cyclictest 
 resuults when running as non-root user.

Setup:
 if one sets the rtprio in /etc/security/limits.conf to something below
 prio max - like:

 @hofrat          hard    rtprio          10
 @hofrat          soft    rtprio          10

 but then starts cylictest with -p 80 cyclictest will not fuss and also
 display priority 80 (as it uses par->prio in print_stat) but effectively 
 runs with prio 0 as the return value of sched_setscheduler is not being
 checked in timerthread), resulting in semingly bad scheduling jitter values.

 So maybe cyclictest should take the effective maximum schduling priority
 of the user and not the scheduling policy maximum. Not sur if the check
 in timerthread is actually really needed - but it should not hurt ither.
 patch below (against current git) at "works for me" quality.

thx!
hofrat


diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 731b4bd..fa89502 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -33,6 +33,7 @@
 #include <sys/time.h>
 #include <sys/utsname.h>
 #include <sys/mman.h>
+#include <sys/resource.h>
 #include "rt_numa.h"
 
 #include "rt-utils.h"
@@ -641,7 +642,10 @@ void *timerthread(void *param)
 
 	memset(&schedp, 0, sizeof(schedp));
 	schedp.sched_priority = par->prio;
-	sched_setscheduler(0, par->policy, &schedp);
+	if(sched_setscheduler(0, par->policy, &schedp) == -1){
+		fprintf(stderr,"sched_setscheduler prio %d failed\n",par->prio);
+		par->prio=0; 
+	}
 
 	/* Get current time */
 	clock_gettime(par->clock, &now);
@@ -943,6 +947,7 @@ static void process_options (int argc, char *argv[])
 {
 	int error = 0;
 	int max_cpus = sysconf(_SC_NPROCESSORS_CONF);
+	struct rlimit rlim;
 
 	for (;;) {
 		int option_index = 0;
@@ -1145,6 +1150,15 @@ static void process_options (int argc, char *argv[])
 		policy = SCHED_FIFO;
 	}
 
+	/* check against rlimit see /etc/security/limits.conf */
+	getrlimit(RLIMIT_RTPRIO, &rlim);
+	if ( priority > rlim.rlim_max){
+		fprintf(stderr, "defaulting realtime priority to %d\n", 
+			(int) rlim.rlim_max);
+		priority = rlim.rlim_max;
+	}
+
+
 	if ((policy == SCHED_FIFO || policy == SCHED_RR) && priority == 0) {
 		fprintf(stderr, "defaulting realtime priority to %d\n", 
 			num_threads+1);

