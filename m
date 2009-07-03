From: GeunSik Lim <leemgs1@gmail.com>
Subject: [PATCH] cyclictest: Add policy option to support FIFO or RR by
	users
Date: Fri, 03 Jul 2009 11:39:55 +0900
Message-ID: <1246588795.2153.52.camel@centos51>
Reply-To: leemgs1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	tglx <tglx@linutronix.de>
To: williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-px0-f190.google.com ([209.85.216.190]:51939 "EHLO
	mail-px0-f190.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752834AbZGCCkB (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 2 Jul 2009 22:40:01 -0400
Received: by pxi28 with SMTP id 28so1946598pxi.33
        for <linux-rt-users@vger.kernel.org>; Thu, 02 Jul 2009 19:40:05 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


 
Hi Clark Williams,

This is patch based on rt-test ver 0.46.
Please merge this patch files If this patch is not problem. . 
Hope it helps.

Regards.


==CUT HERE==

Subject: [PATCH] cyclictest: Add policy option to support FIFO or RR by users.

Current cyclictest support FIFO policy for static priority of
RT threads only. Append policy option to support FIFO or RR by user.

After this patch.
1) with FIFO about RT threads(default)
   ./cyclictest -t 5 -p 50
or ./cyclictest -t 5 -p 50 -y 1
or ./cyclictest -t 5 -p 50 --policy 1

2) with RR about RT threads(default)
   ./cyclictest -t 5 -p 50 -y 2
or ./cyclictest -t 5 -p 50 --policy 2

This is screenshot of threads using cyclictest & tuna utility after patch.
http://blogfiles6.naver.net/20090703_5/invain_1246588185266_sc7zEq_PNG/cyclictest-tuna-policy.PNG

        Signed-off-by: GeunSik Lim <geunsik.lim@samsung.com>
---
 src/cyclictest/cyclictest.8 |    4 ++++
 src/cyclictest/cyclictest.c |   26 ++++++++++++++++++--------
 2 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
index 6059cee..7109fdc 100644
--- a/src/cyclictest/cyclictest.8
+++ b/src/cyclictest/cyclictest.8
@@ -151,6 +151,10 @@ task wakeup tracing (used with \-b)
 .TP
 .B \\-W, \-\-wakeuprt
 rt-task wakeup tracing (used with \-b)
+.TP
+.B \\-y, \-\-policy
+policy of realtime thread (1:FIFO, 2:RR)
+format: --policy=1(default) or --policy=2
 .\" .SH SEE ALSO
 .\" .BR bar (1),
 .\" .BR baz (1).
diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index dfc209e..4a6f634 100644
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
@@ -564,7 +565,6 @@ void *timerthread(void *param)
 	struct itimerval itimer;
 	struct itimerspec tspec;
 	struct thread_stat *stat = par->stats;
-	int policy = par->prio ? SCHED_FIFO : SCHED_OTHER;
 	int stopped = 0;
 	cpu_set_t mask;
 
@@ -595,7 +595,7 @@ void *timerthread(void *param)
 
 	memset(&schedp, 0, sizeof(schedp));
 	schedp.sched_priority = par->prio;
-	sched_setscheduler(0, policy, &schedp);
+	sched_setscheduler(0, par->policy, &schedp);
 
 	/* Get current time */
 	clock_gettime(par->clock, &now);
@@ -793,7 +793,9 @@ static void display_help(void)
                "                           (with same priority about many threads)\n"
 	       "                           US is the max time to be be tracked in microseconds\n"
                "-w       --wakeup          task wakeup tracing (used with -b)\n"
-               "-W       --wakeuprt        rt task wakeup tracing (used with -b)\n",
+               "-W       --wakeuprt        rt task wakeup tracing (used with -b)\n"
+               "-y POLI  --policy=POLI     policy of realtime thread (1:FIFO, 2:RR)\n"
+               "                           format: --policy=1(default) or --policy=2\n",
 	       tracers
 		);
 	exit(0);
@@ -803,6 +805,7 @@ static int use_nanosleep;
 static int timermode = TIMER_ABSTIME;
 static int use_system;
 static int priority;
+static int policy = 0;
 static int num_threads = 1;
 static int max_cycles;
 static int clocksel = 0;
@@ -850,6 +853,7 @@ static void process_options (int argc, char *argv[])
 			{"nsecs", no_argument, NULL, 'N'},
 			{"oscope", required_argument, NULL, 'o'},
 			{"priority", required_argument, NULL, 'p'},
+                        {"policy", required_argument, NULL, 'y'},
 			{"preemptoff", no_argument, NULL, 'P'},
 			{"quiet", no_argument, NULL, 'q'},
 			{"relative", no_argument, NULL, 'r'},
@@ -864,7 +868,7 @@ static void process_options (int argc, char *argv[])
 			{"traceopt", required_argument, NULL, 'O'},
 			{NULL, 0, NULL, 0}
 		};
-		int c = getopt_long (argc, argv, "a::b:Bc:Cd:Efh:i:Il:nNo:O:p:Pmqrst::vD:wWT:",
+                int c = getopt_long (argc, argv, "a::b:Bc:Cd:Efh:i:Il:nNo:O:p:Pmqrst::vD:wWTy:",
 			long_options, &option_index);
 		if (c == -1)
 			break;
@@ -915,6 +919,7 @@ static void process_options (int argc, char *argv[])
 			break;
                 case 'w': tracetype = WAKEUP; break;
                 case 'W': tracetype = WAKEUPRT; break;
+                case 'y': policy = atoi(optarg); break;
 		case '?': error = 1; break;
 		}
 	}
@@ -949,6 +954,8 @@ static void process_options (int argc, char *argv[])
 
 	if (priority < 0 || priority > 99)
 		error = 1;
+        if (policy < 0 || policy > 2) 
+                error = 1;
 
 	if (num_threads < 1)
 		error = 1;
@@ -1043,13 +1050,13 @@ static void print_stat(struct thread_param *par, int index, int verbose)
 		if (quiet != 1) {
 			char *fmt;
 			if (use_nsecs)
-				fmt = "T:%2d (%5d) P:%2d I:%ld C:%7lu "
+                                fmt = "T:%2d (%5d) P:%2d Y:%1d I:%ld C:%7lu "
 					"Min:%7ld Act:%8ld Avg:%8ld Max:%8ld\n";
 			else
-				fmt = "T:%2d (%5d) P:%2d I:%ld C:%7lu "
+                                fmt = "T:%2d (%5d) P:%2d Y:%1d I:%ld C:%7lu "
 					"Min:%7ld Act:%5ld Avg:%5ld Max:%8ld\n";
-			printf(fmt, index, stat->tid, par->prio, par->interval,
-			       stat->cycles, stat->min, stat->act,
+                        printf(fmt, index, stat->tid, par->prio, par->policy, 
+                               par->interval, stat->cycles, stat->min, stat->act,
 			       stat->cycles ?
 			       (long)(stat->avg/stat->cycles) : 0, stat->max);
 		}
@@ -1167,6 +1174,9 @@ int main(int argc, char **argv)
 		par[i].prio = priority;
 		if (priority && !histogram)
 			priority--;
+                if      (priority && policy <= 1) par[i].policy = SCHED_FIFO;
+                else if (priority && policy == 2) par[i].policy = SCHED_RR;
+                else                              par[i].policy = SCHED_OTHER;
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

