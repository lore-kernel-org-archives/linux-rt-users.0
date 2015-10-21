From: John Kacur <jkacur@redhat.com>
Subject: [RFC PATCH] Add a feature to record spikes
Date: Wed, 21 Oct 2015 15:14:36 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1510211509080.7437@riemann>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Clark Williams <williams@redhat.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:33906 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751697AbbJUNOr (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 21 Oct 2015 09:14:47 -0400
Received: by wikq8 with SMTP id q8so93184865wik.1
        for <linux-rt-users@vger.kernel.org>; Wed, 21 Oct 2015 06:14:45 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


The idea of recording the time stamp everytime the latency spikes belongs 
to Clark Williams.

The blame for the implementation is all mine. Consider this a prototype 
for now, but it is useable.

>From 96b5aca222e7b4ea8159c16ba1b9f6a7661f224b Mon Sep 17 00:00:00 2001
From: John Kacur <jkacur@redhat.com>
Date: Wed, 21 Oct 2015 13:34:13 +0200
Subject: [PATCH] cyclictest: Add a feature to record spikes

Create a linked-list of data, including a time stamp, that is
recorded everytime a latency measurement is above a given number (trigger).
This data is printed out at the end of a run. If we have
more spikes than we have allocated nodes in our list for, we stop
recording the data, but keep counting the number of spikes.

This introduces two new long options.

--spike=trigger, where the trigger is given in usec. Any time a
spike > trigger occurs we record the data.

--spike-nodes=num_of_nodes, is the amount of data we can record, the
default is 1024

Here is what a sample run looks like. (non-rt kernel)

su -c './cyclictest -t4 -p99 --spike=30 --duration=60'
Password:
policy: fifo: loadavg: 0.69 0.78 0.60 1/641 6420

T: 0 ( 6385) P:99 I:1000 C:  59996 Min:      2 Act:    2 Avg:    2 Max:
1476
T: 1 ( 6386) P:99 I:1500 C:  39999 Min:      1 Act:    2 Avg:    2 Max:
952
T: 2 ( 6387) P:99 I:2000 C:  29999 Min:      2 Act:    2 Avg:    3 Max:
504
T: 3 ( 6388) P:99 I:2500 C:  23999 Min:      1 Act:    2 Avg:    2 Max:
1423

T: 2 Spike:     504: TS:    490531620
T: 2 Spike:     270: TS:    526847386
T: 2 Spike:      51: TS:    527211167
T: 2 Spike:      44: TS:    528261160
T: 1 Spike:      31: TS:    528952631
T: 2 Spike:      32: TS:    529253148
T: 2 Spike:      52: TS:    529317169
T: 0 Spike:    1444: TS:    530049519
T: 1 Spike:     419: TS:    530049520
T: 0 Spike:    1476: TS:    530318551
T: 1 Spike:     952: TS:    530318553
T: 3 Spike:    1423: TS:    530318551
T: 0 Spike:     972: TS:    531532046
T: 0 Spike:      34: TS:    531987109
spikes = 14

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/cyclictest.c | 114 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 112 insertions(+), 2 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 00168e22fc7f..a208165ac034 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -173,6 +173,29 @@ struct thread_stat {
 	long num_outliers;
 };
 
+static pthread_mutex_t trigger_lock = PTHREAD_MUTEX_INITIALIZER;
+
+static int trigger = 0;	/* Record spikes > trigger, 0 means don't record */
+static int trigger_list_size = 1024;	/* Number of list nodes */
+
+/* Info to store when the diff is greater than the trigger */
+struct thread_trigger {
+	int cpu;
+	int tnum;	/* thread number */
+	int64_t  ts;	/* time-stamp */
+	int diff;
+	struct thread_trigger *next;
+};
+
+struct thread_trigger *head = NULL;
+struct thread_trigger *tail = NULL;
+struct thread_trigger *current = NULL;
+static int spikes;	/* count of the number of spikes */
+
+static int trigger_init();
+static void trigger_print();
+static void trigger_update(struct thread_param *par, int diff, int64_t ts);
+
 static int shutdown;
 static int tracelimit = 0;
 static int notrace = 0;
@@ -405,6 +428,14 @@ static inline int64_t calcdiff_ns(struct timespec t1, struct timespec t2)
 	return diff;
 }
 
+static inline int64_t calctime(struct timespec t)
+{
+	int64_t time;
+	time = USEC_PER_SEC * t.tv_sec;
+	time += ((int) t.tv_nsec) / 1000;
+	return time;
+}
+
 static void traceopt(char *option)
 {
 	char *ptr;
@@ -950,6 +981,10 @@ static void *timerthread(void *param)
 		}
 		stat->avg += (double) diff;
 
+		if (trigger && (diff > trigger)) {
+			trigger_update(par, diff, calctime(now));
+		}
+
 		if (duration && (calcdiff(now, stop) >= 0))
 			shutdown++;
 
@@ -1103,6 +1138,9 @@ static void display_help(int error)
 	       "-s       --system          use sys_nanosleep and sys_setitimer\n"
 	       "-S       --smp             Standard SMP testing: options -a -t -n and\n"
 	       "                           same priority of all threads\n"
+	       "	--spike=trigger	   record all spikes > trigger\n"
+	       "	--spike-nodes	   these are the number of spikes we can record\n"
+	       "			   the default is 1024 if not specified\n"
 	       "-t       --threads         one thread per available processor\n"
 	       "-t [NUM] --threads=NUM     number of threads:\n"
 	       "                           without NUM, threads = max_cpus\n"
@@ -1246,8 +1284,8 @@ enum option_values {
 	OPT_INTERVAL, OPT_IRQSOFF, OPT_LOOPS, OPT_MLOCKALL, OPT_REFRESH, OPT_NANOSLEEP,
 	OPT_NSECS, OPT_OSCOPE, OPT_TRACEOPT, OPT_PRIORITY, OPT_PREEMPTOFF, OPT_QUIET,
 	OPT_PRIOSPREAD, OPT_RELATIVE, OPT_RESOLUTION, OPT_SYSTEM, OPT_SMP, OPT_THREADS,
-	OPT_TRACER, OPT_UNBUFFERED, OPT_NUMA, OPT_VERBOSE, OPT_WAKEUP, OPT_WAKEUPRT,
-	OPT_DBGCYCLIC, OPT_POLICY, OPT_HELP, OPT_NUMOPTS,
+	OPT_TRACER, OPT_TRIGGER, OPT_TRIGGER_NODES, OPT_UNBUFFERED, OPT_NUMA, OPT_VERBOSE,
+	OPT_WAKEUP, OPT_WAKEUPRT, OPT_DBGCYCLIC, OPT_POLICY, OPT_HELP, OPT_NUMOPTS,
 #ifndef NO_PTHREAD_BARRIER
 	OPT_ALIGNED, OPT_SECALIGNED,
 #endif
@@ -1306,6 +1344,8 @@ static void process_options (int argc, char *argv[], int max_cpus)
 #endif
 			{"system",           no_argument,       NULL, OPT_SYSTEM },
 			{"smp",              no_argument,       NULL, OPT_SMP },
+			{"spike",	     required_argument, NULL, OPT_TRIGGER },
+			{"spike-nodes",	     required_argument, NULL, OPT_TRIGGER_NODES },
 			{"threads",          optional_argument, NULL, OPT_THREADS },
 			{"tracer",           required_argument, NULL, OPT_TRACER },
 			{"unbuffered",       no_argument,       NULL, OPT_UNBUFFERED },
@@ -1485,6 +1525,13 @@ static void process_options (int argc, char *argv[], int max_cpus)
 			else
 				num_threads = max_cpus;
 			break;
+		case OPT_TRIGGER:
+			trigger = atoi(optarg);
+			break;
+		case OPT_TRIGGER_NODES:
+			if (trigger)
+				trigger_list_size = atoi(optarg);
+			break;
 		case 'T':
 		case OPT_TRACER:
 			tracetype = CUSTOM;
@@ -1853,6 +1900,58 @@ static void *fifothread(void *param)
 	return NULL;
 }
 
+static int trigger_init()
+{
+	int i;
+	int size = trigger_list_size;
+	struct thread_trigger *trig = NULL;
+	for(i=0; i<size; i++) {
+		trig = malloc(sizeof(struct thread_trigger));
+		if (trig != NULL) {
+			if  (head == NULL) {
+				head = trig;
+				tail = trig;
+			} else {
+				tail->next = trig;
+				tail = trig;
+			}
+			trig->tnum = i;
+			trig->next = NULL;
+		} else {
+			return -1;
+		}
+	}
+	current = head;
+	return 0;
+}
+
+static void trigger_print()
+{
+	struct thread_trigger *trig = head;
+	char *fmt = "T:%2d Spike:%8ld: TS: %12ld\n";
+
+	if (current == head) return;
+	printf("\n");
+	while (trig->next != current) {
+		fprintf(stdout, fmt,  trig->tnum, trig->diff, trig->ts);
+		trig = trig->next;
+	}
+		fprintf(stdout, fmt,  trig->tnum, trig->diff, trig->ts);
+		printf("spikes = %d\n\n", spikes);
+}
+
+static void trigger_update(struct thread_param *par, int diff, int64_t ts)
+{
+	pthread_mutex_lock(&trigger_lock);
+	if (current != NULL) {
+		current->tnum = par->tnum;
+		current->ts = ts;
+		current->diff = diff;
+		current = current->next;
+	}
+	spikes++;
+	pthread_mutex_unlock(&trigger_lock);
+}
 
 int main(int argc, char **argv)
 {
@@ -1871,6 +1970,14 @@ int main(int argc, char **argv)
 	if (verbose)
 		printf("Max CPUs = %d\n", max_cpus);
 
+	if (trigger) {
+		int retval;
+		retval = trigger_init();
+		if (retval != 0) {
+			fprintf(stderr, "trigger_init() failed\n");
+			exit(EXIT_FAILURE);
+		}
+	}
 
 	/* lock all memory (prevent swapping) */
 	if (lockall)
@@ -2189,6 +2296,9 @@ int main(int argc, char **argv)
 			threadfree(statistics[i]->values, VALBUF_SIZE*sizeof(long), parameters[i]->node);
 	}
 
+	if (trigger)
+		trigger_print();
+
 	if (histogram) {
 		print_hist(parameters, num_threads);
 		for (i = 0; i < num_threads; i++) {
-- 
2.4.3

