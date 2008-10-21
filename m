From: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Subject: [PATCH] Cyclictest Hiistogram Support
Date: Tue, 21 Oct 2008 13:19:56 -0700
Message-ID: <1224620396.5039.8.camel@dd>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: RT Users List <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-gx0-f16.google.com ([209.85.217.16]:40429 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751045AbYJUUUB (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 21 Oct 2008 16:20:01 -0400
Received: by gxk9 with SMTP id 9so6249593gxk.13
        for <linux-rt-users@vger.kernel.org>; Tue, 21 Oct 2008 13:19:59 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



Subject: Add histogram support to cyclictest
From: Sven-Thorsten Dietrich <sdietrich@suse.de>

Add -h <size> parameter and functionality to log histograms of latencies
in cyclictest.

Signed-off-by: Sven-Thorsten Dietrich <sdietrich@suse.de>

diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
index 9827458..82c2c43 100644
--- a/src/cyclictest/cyclictest.8
+++ b/src/cyclictest/cyclictest.8
@@ -16,7 +16,7 @@
 cyclictest \- High resolution test program
 .SH SYNOPSIS
 .B cyclictest
-.RI "[ \-hfmnqrsv ] [\-a " proc " ] [\-b " usec " ] [\-c " clock " ] [\-d " dist " ] [\-i " intv " ] [\-l " loop " ] [\-o " red " ] [\-p " prio " ] [\-t " num " ]"
+.RI "[ \-hfmnqrsv ] [\-a " proc " ] [\-b " usec " ] [\-c " clock " ] [\-d " dist " ] [\-h " histogram " ] [\-i " intv " ] [\-l " loop " ] [\-o " red " ] [\-p " prio " ] [\-t " num " ]"
 .\" .SH DESCRIPTION
 .\" This manual page documents briefly the
 .\" .B cyclictest commands.
@@ -81,6 +81,9 @@ Set the distance of thread intervals in microseconds (default is 500us). When cy
 .B \-f, \-\-ftrace
 Enable function tracing using ftrace as tracer. This option is available only with \-b.
 .TP
+.B \-h=MAXLATENCYINUS
+Dump latency histogram to stdout.
+.TP
 .B \-i, \-\-interval=INTV
 Set the base interval of the thread(s) in microseconds (default is 1000us). This sets the interval of the first thread. See also \-d.
 .TP
diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 149c2ec..c604131 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -93,6 +93,8 @@ enum {
 	IRQPREEMPTOFF,
 };
 
+#define HIST_MAX		1000000
+
 /* Struct to transfer parameters to the thread */
 struct thread_param {
 	int prio;
@@ -116,6 +118,7 @@ struct thread_stat {
 	long act;
 	double avg;
 	long *values;
+	long *hist_array;
 	pthread_t thread;
 	int threadstarted;
 	int tid;
@@ -132,6 +135,7 @@ static int verbose = 0;
 static int oscope_reduction = 1;
 static int tracetype;
 static int lockall = 0;
+static int histogram = 0;
 
 /* Backup of kernel variables that we modify */
 static struct kvars {
@@ -536,6 +540,9 @@ void *timerthread(void *param)
 
 		if (par->bufmsk)
 			stat->values[stat->cycles & par->bufmsk] = diff;
+	
+		if (histogram && (diff < histogram))
+			stat->hist_array[diff] += 1;
 
 		next.tv_sec += interval.tv_sec;
 		next.tv_nsec += interval.tv_nsec;
@@ -582,6 +589,7 @@ static void display_help(void)
 	       "                           1 = CLOCK_REALTIME\n"
 	       "-d DIST  --distance=DIST   distance of thread intervals in us default=500\n"
 	       "-f       --ftrace          function trace (when -b is active)\n"
+ 	       "-h H_MAX                   latency histogram size in us default 0 (off)\n"
 	       "-i INTV  --interval=INTV   base interval of thread in us default=1000\n"
 	       "-I       --irqsoff         Irqsoff tracing (used with -b)\n"
 	       "-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
@@ -642,6 +650,7 @@ static void process_options (int argc, char *argv[])
 			{"clock", required_argument, NULL, 'c'},
 			{"distance", required_argument, NULL, 'd'},
 			{"ftrace", no_argument, NULL, 'f'},
+			{"histogram", required_argument, NULL, 'h'},
 			{"interval", required_argument, NULL, 'i'},
 			{"irqsoff", no_argument, NULL, 'I'},
 			{"loops", required_argument, NULL, 'l'},
@@ -658,7 +667,7 @@ static void process_options (int argc, char *argv[])
 			{"help", no_argument, NULL, '?'},
 			{NULL, 0, NULL, 0}
 		};
-		int c = getopt_long (argc, argv, "a::b:Bc:d:fi:Il:nmo:p:Pqrst::v",
+		int c = getopt_long (argc, argv, "a::b:Bc:d:fh:i:Il:nmo:p:Pqrst::v",
 			long_options, &option_index);
 		if (c == -1)
 			break;
@@ -679,6 +688,7 @@ static void process_options (int argc, char *argv[])
 		case 'c': clocksel = atoi(optarg); break;
 		case 'd': distance = atoi(optarg); break;
 		case 'f': ftrace = 1; break;
+ 		case 'h': histogram = atoi(optarg); break;
 		case 'i': interval = atoi(optarg); break;
 		case 'I': tracetype = IRQSOFF; break;
 		case 'l': max_cycles = atoi(optarg); break;
@@ -724,6 +734,9 @@ static void process_options (int argc, char *argv[])
 		error = 1;
 	}
 
+	if (histogram < 0)
+		error = 1;
+
 	if (priority < 0 || priority > 99)
 		error = 1;
 
@@ -776,6 +789,36 @@ static void sighand(int sig)
 		tracing(0);
 }
 
+static void print_hist(struct thread_param *par, int nthreads)
+{
+	int i, j;
+	unsigned long long log_entries[nthreads];
+	unsigned long max_latency = 0;
+	
+	bzero(log_entries, sizeof(log_entries));
+
+	printf("# Histogram\n");
+	for (i = 0; i < histogram; i++) {
+
+		printf("%05d ", i);
+
+		for (j = 0; j < nthreads; j++) {
+			unsigned long curr_latency=par[j].stats->hist_array[i];
+			printf("%06lu\t", curr_latency);
+			log_entries[j] += curr_latency;
+			if (curr_latency && max_latency < i)
+				max_latency = i;
+		}
+		printf("\n");
+		
+	}
+	printf("# Total:");
+	for (j = 0; j < nthreads; j++)
+		printf(" %09llu", log_entries[j]);
+	printf("\n");
+	printf("# Max Latency: %lu / %d\n", max_latency, histogram);
+}
+
 static void print_stat(struct thread_param *par, int index, int verbose)
 {
 	struct thread_stat *stat = par->stats;
@@ -874,6 +917,12 @@ int main(int argc, char **argv)
 		goto outpar;
 
 	for (i = 0; i < num_threads; i++) {
+		if (histogram) {
+			if (histogram > HIST_MAX)
+				histogram = HIST_MAX;
+			stat[i].hist_array = calloc(histogram, sizeof(long));
+		}
+
 		if (verbose) {
 			stat[i].values = calloc(VALBUF_SIZE, sizeof(long));
 			if (!stat[i].values)
@@ -882,14 +931,17 @@ int main(int argc, char **argv)
 		}
 
 		par[i].prio = priority;
-		if (priority)
+		if (priority && !histogram)
 			priority--;
 		par[i].clock = clocksources[clocksel];
 		par[i].mode = mode;
 		par[i].timermode = timermode;
 		par[i].signal = signum;
 		par[i].interval = interval;
-		interval += distance;
+		if (!histogram) /* histogram requires same interval on CPUs*/
+			interval += distance;
+		if (verbose)
+			printf("Thread %d Interval: %d\n", i, interval);
 		par[i].max_cycles = max_cycles;
 		par[i].stats = &stat[i];
 		switch (setaffinity) {
@@ -932,6 +984,7 @@ int main(int argc, char **argv)
  outall:
 	shutdown = 1;
 	usleep(50000);
+
 	if (quiet)
 		quiet = 2;
 	for (i = 0; i < num_threads; i++) {
@@ -939,12 +992,19 @@ int main(int argc, char **argv)
 			pthread_kill(stat[i].thread, SIGTERM);
 		if (stat[i].threadstarted) {
 			pthread_join(stat[i].thread, NULL);
-			if (quiet)
+			if (quiet && !histogram)
 				print_stat(&par[i], i, 0);
 		}
 		if (stat[i].values)
 			free(stat[i].values);
 	}
+
+	if (histogram) {
+		print_hist(par, num_threads);
+		for (i = 0; i < num_threads; i++) 
+			free (stat[i].hist_array);
+	}
+
 	free(stat);
  outpar:
 	free(par);


