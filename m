From: GeunSik Lim <leemgs1@gmail.com>
Subject: [PATCH 1/3] cyclictest: Added policy option to support FIFO or RR.
Date: Sat, 27 Jun 2009 00:36:55 +0900
Message-ID: <1246030615.2153.30.camel@centos51>
Reply-To: leemgs1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: tglx <tglx@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.231]:9633 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751018AbZFZPg6 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 26 Jun 2009 11:36:58 -0400
Received: by rv-out-0506.google.com with SMTP id f6so649701rvb.1
        for <linux-rt-users@vger.kernel.org>; Fri, 26 Jun 2009 08:37:01 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



>From 51fa8db58c227ba151eb245a9894cd2ed239d8ce Mon Sep 17 00:00:00 2001
From: GeunSik,Lim <leemgs1@gmail.com>
Date: Fri, 26 Jun 2009 23:17:09 +0900
Subject: [PATCH 1/3] cyclictest: Added policy option to support FIFO or RR.

Current cyclictest support FIFO policy for static priority only.
We need policy option to support FIFO or RR by user.

	Signed-off-by: GeunSik Lim <geunsik.lim@samsung.com>
---
 src/cyclictest/cyclictest.c |   29 +++++++++++++++++++++--------
 1 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 3e2d500..ad4c421 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -103,6 +103,7 @@ enum {
 /* Struct to transfer parameters to the thread */
 struct thread_param {
 	int prio;
+	int policy;
 	int mode;
 	int timermode;
 	int signal;
@@ -563,7 +564,6 @@ void *timerthread(void *param)
 	struct itimerval itimer;
 	struct itimerspec tspec;
 	struct thread_stat *stat = par->stats;
-	int policy = par->prio ? SCHED_FIFO : SCHED_OTHER;
 	int stopped = 0;
 	cpu_set_t mask;
 
@@ -594,7 +594,7 @@ void *timerthread(void *param)
 
 	memset(&schedp, 0, sizeof(schedp));
 	schedp.sched_priority = par->prio;
-	sched_setscheduler(0, policy, &schedp);
+	sched_setscheduler(0, par->policy, &schedp);
 
 	/* Get current time */
 	clock_gettime(par->clock, &now);
@@ -775,9 +775,12 @@ static void display_help(void)
 	       "-h       --histogram=US    dump a latency histogram to stdout after the run\n"
 	       "                           US is the max time to be be tracked in microseconds\n"
                "-w       --wakeup          task wakeup tracing (used with -b)\n"
-               "-W       --wakeuprt        rt task wakeup tracing (used with -b)\n",
+               "-W       --wakeuprt        rt task wakeup tracing (used with -b)\n"
+	       "-y POLI  --policy=POLI     policy of realtime thread (0:OTHER, 1:FIFO, 2:RR)\n"
+	       "                           format: --policy=0(default) --policy=1 or --policy=2\n",
 	       tracers
 		);
+
 	exit(0);
 }
 
@@ -785,6 +788,7 @@ static int use_nanosleep;
 static int timermode = TIMER_ABSTIME;
 static int use_system;
 static int priority;
+static int policy = 0;
 static int num_threads = 1;
 static int max_cycles;
 static int clocksel = 0;
@@ -832,6 +836,7 @@ static void process_options (int argc, char *argv[])
 			{"nsecs", no_argument, NULL, 'N'},
 			{"oscope", required_argument, NULL, 'o'},
 			{"priority", required_argument, NULL, 'p'},
+			{"policy", required_argument, NULL, 'y'},
 			{"preemptoff", no_argument, NULL, 'P'},
 			{"quiet", no_argument, NULL, 'q'},
 			{"relative", no_argument, NULL, 'r'},
@@ -846,7 +851,7 @@ static void process_options (int argc, char *argv[])
 			{"traceopt", required_argument, NULL, 'O'},
 			{NULL, 0, NULL, 0}
 		};
-		int c = getopt_long (argc, argv, "a::b:Bc:Cd:Efh:i:Il:nNo:O:p:Pmqrst::vD:wWT:",
+		int c = getopt_long (argc, argv, "a::b:Bc:Cd:Efh:i:Il:nNo:O:p:Pmqrst::vD:wWTy:",
 			long_options, &option_index);
 		if (c == -1)
 			break;
@@ -897,6 +902,7 @@ static void process_options (int argc, char *argv[])
 			break;
                 case 'w': tracetype = WAKEUP; break;
                 case 'W': tracetype = WAKEUPRT; break;
+                case 'y': policy = atoi(optarg); break;
 		case '?': error = 1; break;
 		}
 	}
@@ -929,6 +935,9 @@ static void process_options (int argc, char *argv[])
 	if (priority < 0 || priority > 99)
 		error = 1;
 
+	if  (policy < 0 || policy > 2) 
+                error = 1;
+
 	if (num_threads < 1)
 		error = 1;
 
@@ -1022,13 +1031,13 @@ static void print_stat(struct thread_param *par, int index, int verbose)
 		if (quiet != 1) {
 			char *fmt;
 			if (use_nsecs)
-				fmt = "T:%2d (%5d) P:%2d I:%ld C:%7lu "
+				fmt = "T:%2d (%5d) P:%2d Y:%1d I:%ld C:%7lu "
 					"Min:%7ld Act:%8ld Avg:%8ld Max:%8ld\n";
 			else
-				fmt = "T:%2d (%5d) P:%2d I:%ld C:%7lu "
+				fmt = "T:%2d (%5d) P:%2d Y:%1d I:%ld C:%7lu "
 					"Min:%7ld Act:%5ld Avg:%5ld Max:%8ld\n";
-			printf(fmt, index, stat->tid, par->prio, par->interval,
-			       stat->cycles, stat->min, stat->act,
+			printf(fmt, index, stat->tid, par->prio, par->policy, 
+                               par->interval, stat->cycles, stat->min, stat->act,
 			       stat->cycles ?
 			       (long)(stat->avg/stat->cycles) : 0, stat->max);
 		}
@@ -1143,6 +1152,10 @@ int main(int argc, char **argv)
 		par[i].prio = priority;
 		if (priority && !histogram)
 			priority--;
+                if      ( policy == 0) par[i].policy = SCHED_OTHER;
+                else if ( policy == 1) par[i].policy = SCHED_FIFO;
+                else if ( policy == 2) par[i].policy = SCHED_RR;
+                else                   par[i].policy = SCHED_OTHER;
 		par[i].clock = clocksources[clocksel];
 		par[i].mode = mode;
 		par[i].timermode = timermode;
-- 
1.6.3.1


-----------------------------------------------
To unsubscribe from this list: send the line "unsubscribe linux-***" 
in the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

GeunSik Lim ( Samsung Electronics )
e-Mail  :1) geunsik.lim@samsung.com
         2) leemgs@gmail.com , leemgs1@gmail.com
HomePage: http://blog.naver.com/invain/
-----------------------------------------------

