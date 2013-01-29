From: Frank Rowand <frank.rowand@am.sony.com>
Subject: [PATCH] cyclictest: white space cleanup
Date: Mon, 28 Jan 2013 18:09:46 -0800
Message-ID: <51072F6A.1050105@am.sony.com>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
To: "jkacur@redhat.com" <jkacur@redhat.com>,
	<linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from co9ehsobe005.messaging.microsoft.com ([207.46.163.28]:46928
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751728Ab3A2CJz (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 28 Jan 2013 21:09:55 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Clean up cyclictest formatting:
  Change leading spaces to tabs.
  Align function parameters.
  Place type of function on same line as function name.

Signed-off-by: Frank Rowand <frank.rowand@am.sony.com>
---
 src/cyclictest/cyclictest.c |   43 	21 +	22 -	0 !
 1 file changed, 21 insertions(+), 22 deletions(-)

Index: b/src/cyclictest/cyclictest.c
===================================================================
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -60,7 +60,7 @@
 #define CPUCLOCK_SCHED          2
 
 static int clock_nanosleep(clockid_t clock_id, int flags, const struct timespec *req,
-		struct timespec *rem)
+			   struct timespec *rem)
 {
 	if (clock_id == CLOCK_THREAD_CPUTIME_ID)
 		return -EINVAL;
@@ -71,7 +71,7 @@ static int clock_nanosleep(clockid_t clo
 }
 
 int sched_setaffinity (__pid_t __pid, size_t __cpusetsize,
-                              __const cpu_set_t *__cpuset)
+		       __const cpu_set_t *__cpuset)
 {
 	return -EINVAL;
 }
@@ -150,7 +150,7 @@ struct thread_stat {
 	double avg;
 	long *values;
 	long *hist_array;
-        long *outliers;
+	long *outliers;
 	pthread_t thread;
 	int threadstarted;
 	int tid;
@@ -158,7 +158,7 @@ struct thread_stat {
 	long redmax;
 	long cycleofmax;
 	long hist_overflow;
-        long num_outliers;
+	long num_outliers;
 };
 
 static int shutdown;
@@ -504,12 +504,12 @@ static void setup_tracer(void)
 				ret = event_enable("sched/sched_switch");
 			}
 			break;
-               case WAKEUP:
-                       ret = settracer("wakeup");
-                       break;
-               case WAKEUPRT:
-                       ret = settracer("wakeup_rt");
-                       break;
+		case WAKEUP:
+			ret = settracer("wakeup");
+			break;
+		case WAKEUPRT:
+			ret = settracer("wakeup_rt");
+			break;
 		default:
 			if (strlen(tracer)) {
 				ret = settracer(tracer);
@@ -596,8 +596,7 @@ static void setup_tracer(void)
  *
  * the return value is a value in seconds
  */
-int
-parse_time_string(char *val)
+int parse_time_string(char *val)
 {
 	char *end;
 	int t = strtol(val, &end, 10);
@@ -887,7 +886,7 @@ void *timerthread(void *param)
 		if (histogram) {
 			if (diff >= histogram) {
 				stat->hist_overflow++;
-                                if (stat->num_outliers < histogram)
+				if (stat->num_outliers < histogram)
 					stat->outliers[stat->num_outliers++] = stat->cycles;
 			}
 			else
@@ -1086,7 +1085,7 @@ static void process_options (int argc, c
 	int max_cpus = sysconf(_SC_NPROCESSORS_CONF);
 
 	for (;;) {
- 		int option_index = 0;
+		int option_index = 0;
 		/*
 		 * Options for getopt
 		 * Ordered alphabetically by single letter name
@@ -1471,15 +1470,15 @@ static void print_stat(struct thread_par
 		if (quiet != 1) {
 			char *fmt;
 			if (use_nsecs)
-                                fmt = "T:%2d (%5d) P:%2d I:%ld C:%7lu "
+				fmt = "T:%2d (%5d) P:%2d I:%ld C:%7lu "
 					"Min:%7ld Act:%8ld Avg:%8ld Max:%8ld\n";
 			else
-                                fmt = "T:%2d (%5d) P:%2d I:%ld C:%7lu "
+				fmt = "T:%2d (%5d) P:%2d I:%ld C:%7lu "
 					"Min:%7ld Act:%5ld Avg:%5ld Max:%8ld\n";
-                        printf(fmt, index, stat->tid, par->prio,
-                               par->interval, stat->cycles, stat->min, stat->act,
-			       stat->cycles ?
-			       (long)(stat->avg/stat->cycles) : 0, stat->max);
+				printf(fmt, index, stat->tid, par->prio,
+				       par->interval, stat->cycles, stat->min, stat->act,
+				       stat->cycles ?
+				       (long)(stat->avg/stat->cycles) : 0, stat->max);
 		}
 	} else {
 		while (stat->cycles != stat->cyclesread) {
@@ -1724,9 +1723,9 @@ int main(int argc, char **argv)
 		}
 
 		par->prio = priority;
-                if (priority && (policy == SCHED_FIFO || policy == SCHED_RR))
+		if (priority && (policy == SCHED_FIFO || policy == SCHED_RR))
 			par->policy = policy;
-                else {
+		else {
 			par->policy = SCHED_OTHER;
 			force_sched_other = 1;
 		}

