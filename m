From: Isaac Griswold-Steiner <isaac.griswold.steiner@gmail.com>
Subject: [PATCH v2 RFC] rdtscbench: a nohz_full validation and benchmarking tool
Date: Wed, 23 Dec 2015 14:43:33 -0600
Message-ID: <1450903413-7518-1-git-send-email-isaac.griswold.steiner@gmail.com>
References: <alpine.LFD.2.20.1512211412150.6623@riemann>
Cc: williams@redhat.com, isaac.griswold.steiner@gmail.com,
	linux-rt-users@vger.kernel.org, joshc@ni.com
To: jkacur@redhat.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:35227 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751481AbbLWUn4 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 23 Dec 2015 15:43:56 -0500
Received: by mail-ob0-f176.google.com with SMTP id 18so173517691obc.2
        for <linux-rt-users@vger.kernel.org>; Wed, 23 Dec 2015 12:43:55 -0800 (PST)
In-Reply-To: <alpine.LFD.2.20.1512211412150.6623@riemann>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

rdtscbench is a cyclictest-like tool that spawns a thread per
cpu. Each thread measures the difference in cycle count (using the tsc)
during the exectuion of a tight loop.

This is a simple tool intended to be used for the validation of
nohz_full CPU configurations. As the validation of nohz_full CPUs
is the objective, the tool avoids the usage of system calls,
timers, or anything that might break nohz_full.
---
 Makefile                    |   8 +
 src/rdtscbench/README       |  29 ++
 src/rdtscbench/rdtscbench.c | 728 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 765 insertions(+)
 create mode 100644 src/rdtscbench/README
 create mode 100644 src/rdtscbench/rdtscbench.c

diff --git a/Makefile b/Makefile
index a48e759..d5844a8 100644
--- a/Makefile
+++ b/Makefile
@@ -34,6 +34,10 @@ ifdef HAVE_PARSE_CPUSTRING_ALL
 endif
 endif
 
+ifneq ($(filter x86_64 i386,$(machinetype)),)
+sources += rdtscbench.c
+endif
+
 PYLIB  := $(shell python -c 'import distutils.sysconfig;  print distutils.sysconfig.get_python_lib()')
 
 ifndef DEBUG
@@ -58,6 +62,7 @@ VPATH	+= src/pmqtest:
 VPATH	+= src/backfire:
 VPATH	+= src/lib
 VPATH	+= src/hackbench
+VPATH	+= src/rdtscbench
 
 %.o: %.c
 	$(CC) -D VERSION_STRING=$(VERSION_STRING) -c $< $(CFLAGS) $(CPPFLAGS)
@@ -112,6 +117,9 @@ hackbench: hackbench.o
 librttest.a: rt-utils.o error.o rt-get_cpu.o rt-sched.o
 	$(AR) rcs librttest.a $^
 
+rdtscbench: rdtscbench.o
+	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS)
+
 CLEANUP  = $(TARGETS) *.o .depend *.*~ *.orig *.rej rt-tests.spec *.d *.a
 CLEANUP += $(if $(wildcard .git), ChangeLog)
 
diff --git a/src/rdtscbench/README b/src/rdtscbench/README
new file mode 100644
index 0000000..77d5806
--- /dev/null
+++ b/src/rdtscbench/README
@@ -0,0 +1,29 @@
+rdtscbench is a cyclictest-like tool that spawns a thread per cpu. Each thread
+measures the difference in cycle count (using the tsc) during the execution of a
+tight loop.
+
+This is a simple tool intended to be used for the validation of nohz_full CPU
+configurations. As the validation of nohz_full CPUs is the objective, the tool
+avoids the usage of system calls, timers, or anything that might break nohz_full.
+
+USAGE EXAMPLES
+There are no required steps prior to running rdtscbench. If CPUs are not
+isolated, the test will show a relatively balanced workload across all CPUs.
+If the Avg or Max statistics for the test are spiking beyond expected levels
+then there's likely a problem with the configuration or a new task is causing
+those spikes.
+
+The following example runs a basic rdtscbench, it does not provide a histogram.
+Only stops running when Ctrl-C is pressed.
+./rdtscbench
+
+Benchmarking test that runs for approximately 24 hours with 100 buckets.
+Includes histogram.
+./rdtscbench -t 86400 -h
+
+Benchmarking test that runs for approximately 24 hours with 150 buckets,
+an upper bound of 22 microseconds, and a break point of 30 microseconds.
+./rdtscbench -t 86400 -b 150 -u 22 -B 30
+
+NOTES
+rdtscbench assumes CPU 0 is the housekeeping cpu.
diff --git a/src/rdtscbench/rdtscbench.c b/src/rdtscbench/rdtscbench.c
new file mode 100644
index 0000000..7268e7c
--- /dev/null
+++ b/src/rdtscbench/rdtscbench.c
@@ -0,0 +1,728 @@
+/*
+ * rdtscbench is a tool for measuring the efficacy of a nohz_full setup.
+ * It does so by guaranteeing that the benchmarking tool itself does not
+ * cause a CPU to leave NOHZ mode during the testing phase.
+ *
+ * (C) 2015      National Instruments Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License Version
+ * 2 as published by the Free Software Foundation.
+ *
+ */
+
+#include <sys/time.h>
+#include <time.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <sys/mman.h>
+#include <string.h>
+#include <fcntl.h>
+#include <sched.h>
+#include <getopt.h>
+#include <stdbool.h>
+#include <time.h>
+#include <pthread.h>
+#include <signal.h>
+
+#include <sys/resource.h>
+#include <errno.h>
+
+/* Variables used by the benchmarking tool to track jitter */
+struct thread_data {
+	unsigned long long *buckets;
+	unsigned long long cycle_max;
+	unsigned long long loop_count;
+	unsigned long overflow;
+	unsigned long cycle_avg;
+	unsigned long cycle_min;
+	pthread_t thread;
+};
+
+/*
+ * The following variables are used for configuring the benchmark and
+ * tweaking certain options.
+ *
+ * run_time:		The total time in seconds that the benchmark runs (seconds).
+ *			If -1 it will run until stopped by Ctrl-C.
+ * cycles_per_sec:	This is the number of cpu cycles per second.
+ *			However it's somewhat of an estimate.
+ * start_time:		This is considered the starting time for the
+ *			benchmarking tests.
+ * upper_bound:		This variable gives the max jitter that will be recorded
+ *			in a specific bucket, anything higher will be placed in
+ *			the last bucket (measured in microseconds).
+ *			overflowing.
+ * hist_bound:		Similar to upper_bound, but gets converted to cycles rather
+ *			than some degree of seconds.
+ * breaking_point:	This is the breaking point in nanoseconds of the benchmark
+ *			loop.
+ * num_buckets:		This is the number of jitter blocks (or buckets) that are
+ *			used for tracking and benchmarking.
+ * warmup_period:	This allows a certain number of iterations before
+ *			data gets tracked, just in case there is leftover
+ *			jitter balancing itself out. Not really necessary to
+ *			modify this. Measured in iterations.
+ * units:		This variable is used to modify the execution of the tests
+ *			based on whether the user is using microseconds or
+ *			nanoseconds.
+ * policy:		This is the scheduling policy used by the test (FIFO or RR)
+ * priority:		This is the priority of the threads running the test.
+ * memlock:		A bool that tells the benchmark to use mlockall
+ * 			and munlockall.
+ * prefault:		This tells the benchmark to prefault memory.
+ * mod:			Simple variable to help convert us data to ns for certain
+ * 			situations where microseconds aren't precise enough.
+ * trace_fd:		Identifier for toggling the trace on and off.
+ * marker_fd:		Identifier for sending a message to the trace.
+ * num_cpus:		This gives the number of active CPUs, a test will be run on each.
+ * should_stop:		Special condition for telling the benchmark to stop.
+ * benchmark:		Variable used to store all of the test data.
+ */
+static unsigned long long run_time = -1;
+static unsigned long long cycles_per_sec;
+static unsigned long long start_time;
+static unsigned long long upper_bound = 100;
+static unsigned long long hist_bound;
+static unsigned long breaking_point = -1;
+static int num_buckets = 100;
+static int warmup_period = 10000;
+static int units = 1000000;
+static int policy = SCHED_OTHER;
+static int priority = -1;
+static bool memlock = false;
+static bool prefault = false;
+static bool histogram = false;
+static int mod = 100;
+static int trace_fd = -1;
+static int marker_fd = -1;
+static int num_cpus;
+static volatile bool should_stop = false;
+static struct thread_data *benchmark;
+
+static inline unsigned long long get_cycles(void)
+{
+	unsigned a, d;
+	asm volatile("rdtsc" : "=a" (a), "=d" (d));
+
+	return (((unsigned long long)a) | (((unsigned long long)d) << 32));
+}
+
+static unsigned long long get_cycles_per_second(void)
+{
+	static const int measurements = 10;
+	unsigned long long strt, end, total = 0;
+	struct timespec ts;
+	int i = 0;
+
+	printf("# getting cycles per second for %d seconds\n", measurements);
+
+	ts.tv_sec = 1;
+	ts.tv_nsec = 0;
+	for (i = 0; i < measurements; i++) {
+		strt = get_cycles();
+		if (clock_nanosleep(CLOCK_MONOTONIC, 0, &ts, NULL) < 0) {
+			fprintf(stderr, "get_cycles_per_second: clock_nanosleep() failed: %s\n", strerror(errno));
+			exit(errno);
+		}
+		end = get_cycles();
+		total += end - strt;
+	}
+
+	return total / measurements;
+}
+
+#define trace_marker_write(s) trace_marker_write_str(s, sizeof(s))
+
+/*
+ * Inline tracing function that can be optionally turned on.
+ */
+static inline void trace_marker_write_str(const char *str, size_t len)
+{
+	if (marker_fd != -1)
+		write(marker_fd, str, len);
+}
+
+/*
+ * Inline function to turn tracing on or off.
+ */
+static inline void trace_set_enabled(bool on)
+{
+	if (trace_fd != -1)
+		write(trace_fd, on ? "1" : "0", 1);
+}
+
+#define MAX_SAFE_STACK (8*1024)
+
+static void stack_prefault(void)
+{
+	unsigned char dummy[MAX_SAFE_STACK];
+
+	memset(dummy, 0, MAX_SAFE_STACK);
+	return;
+}
+
+static void setup_tracing(void)
+{
+	trace_fd = open("/sys/kernel/debug/tracing/tracing_on", O_WRONLY);
+
+	if (trace_fd == -1) {
+		perror("# rdtscbench: setup_tracing trace");
+		exit(EXIT_FAILURE);
+	}
+
+	marker_fd = open("/sys/kernel/debug/tracing/trace_marker", O_WRONLY);
+
+	if (marker_fd == -1) {
+		perror("# rdtscbench: setup_tracing marker");
+		exit(EXIT_FAILURE);
+	}
+
+	write(trace_fd, "1", 1);
+}
+
+static void set_mlock(void)
+{
+	/* locking memory */
+	if (mlockall(MCL_CURRENT | MCL_FUTURE) == -1) {
+		perror("# set_mlock");
+		exit(EXIT_FAILURE);
+	}
+}
+
+static void handlepolicy(const char *polname)
+{
+	if (strncasecmp(polname, "other", 5) == 0)
+		policy = SCHED_OTHER;
+	else if (strncasecmp(polname, "batch", 5) == 0)
+		policy = SCHED_BATCH;
+	else if (strncasecmp(polname, "idle", 4) == 0)
+		policy = SCHED_IDLE;
+	else if (strncasecmp(polname, "fifo", 4) == 0)
+		policy = SCHED_FIFO;
+	else if (strncasecmp(polname, "rr", 2) == 0)
+		policy = SCHED_RR;
+	else    /* default policy if we don't recognize the request */
+		policy = SCHED_OTHER;
+}
+
+static void sighand(int sig)
+{
+	should_stop = true;
+}
+
+/*
+ * These enum values are options for the benchmarking tool.
+ *
+ * OPT_TIME:		This option allows you to set the runtime of the test.
+ * OPT_UPPERBOUND:	This option allows you to set the max jitter that buckets
+ *			will explicitly measure.
+ * OPT_BUCKETS:		This is the number of buckets that are used to measure
+ *			and categorize jitter.
+ * OPT_BREAK:		This option allows you to tell the benchmark to stop
+ *			running if jitter reaches a certain point.
+ * OPT_HIST:		This option enables printing of the histogram.
+ * OPT_NANOSEC:		This tells the test to use nanoseconds as a measurement
+ *			system rather than microseconds.
+ * OPT_TRACE:		This enables tracing.
+ * OPT_MLOCK:		This enables mlockall.
+ * OPT_PREFAULT:	This enables prefaulting.
+ * OPT_POLICY:		This determines the scheduling policy used for the
+ *			benchmark.
+ * OPT_PRIORITY:	This determines the priority of the threads.
+ * OPT_HELP:		Simple parameter to let the user get more usage details.
+ */
+enum option_vals {
+	OPT_TIME,
+	OPT_UPPERBOUND,
+	OPT_BUCKETS,
+	OPT_BREAK,
+	OPT_HIST,
+	OPT_NANOSEC,
+	OPT_TRACE,
+	OPT_MLOCK,
+	OPT_PREFAULT,
+	OPT_POLICY,
+	OPT_PRIORITY,
+	OPT_HELP,
+};
+
+static void show_help(int error)
+{
+	puts("rdtscbench usage:\n"
+	       "rdtscbench <options>\n"
+	       "-t              --run-time              Run the benchmark for this amount of time (seconds)\n"
+	       "                                        this helps standardize tests and compare jitter\n"
+	       "                                        across devices.\n"
+	       "-u              --upper-bound           The upper bound (in microseconds) allows you to\n"
+	       "                                        say what the highest acceptable jitter is for\n"
+	       "                                        your buckets. Anything else will be placed\n"
+	       "                                        in the <overflow> bucket.\n"
+	       "-b              --buckets               Setting a high detail level allows you to see\n"
+	       "                                        in more detail the different clusters of jitter.\n"
+	       "                                        While low detail just gives an overview of whether\n"
+	       "                                        your are reducing jitter overall within a range.\n"
+	       "-B              --break-on              Breaking when you hit a specific level of jitter\n"
+	       "                                        can be especially useful when trying to find the\n"
+	       "                                        exact source of a certain level of jitter.\n"
+	       "                                        This value is measured in your units.\n"
+	       "                                        NOTE: Using the function graph will require adjusting\n"
+	       "                                        the point at which you break, due to overhead\n"
+	       "-h              --histo                 This option prints the histogram at the end.\n"
+	       "-n              --nanosec               This option enables nanosecond based measurements\n"
+	       "                                        rather than microsecond based measurements (for buckets)\n"
+	       "-T              --trace                 This option allows certain tracing options that\n"
+	       "                                        an help debug causes of jitter.\n"
+	       "-m              --mlockall              This tells the benchmark to lock all of its virtual\n"
+	       "                                        address space into RAM using mlockall.\n"
+	       "-f              --prefault              Tells the benchmark to prefault its memory.\n"
+	       "-p              --policy                Allows the user to use either FIFO or RR based\n"
+	       "                                        scheduling policy.\n"
+	       "-P              --priority              This allows the user to set the priority of the\n"
+	       "                                        benchmarking tests.\n"
+	       "-?              --help                  This command will bring up the help information.\n"
+	     );
+	exit(error ? EXIT_FAILURE : EXIT_SUCCESS);
+}
+
+static void process_options(int argc, char *argv[])
+{
+	for (;;) {
+		int option_index = 0;
+
+		/*
+		 * Options for getopt
+		 */
+		static const struct option long_options[] = {
+			{"run-time", required_argument, NULL, OPT_TIME},
+			{"upper-bound", required_argument, NULL, OPT_UPPERBOUND},
+			{"buckets", required_argument, NULL, OPT_BUCKETS},
+			{"break-on", required_argument, NULL, OPT_BREAK},
+			{"histo", no_argument, NULL, OPT_HIST},
+			{"nanosec", no_argument, NULL, OPT_NANOSEC},
+			{"trace", no_argument, NULL, OPT_TRACE},
+			{"mlockall", no_argument, NULL, OPT_MLOCK},
+			{"prefault", no_argument, NULL, OPT_PREFAULT},
+			{"policy", required_argument, NULL, OPT_POLICY},
+			{"priority", required_argument, NULL, OPT_PRIORITY},
+			{"help", no_argument, NULL, OPT_HELP},
+			{NULL, 0, NULL, 0}
+		};
+
+		int c = getopt_long(argc, argv, "t:u:b:B:hnTmfp:P:?", long_options, &option_index);
+		if (c == -1)
+			break;
+
+		switch (c) {
+		case 't':
+		case OPT_TIME:
+			if (optarg != NULL && atoi(optarg) > 0)
+				run_time = atoi(optarg);
+			break;
+		case 'u':
+		case OPT_UPPERBOUND:
+			if (optarg != NULL && atoi(optarg) > 0)
+				upper_bound = atoi(optarg);
+			break;
+		case 'b':
+		case OPT_BUCKETS:
+			if (optarg != NULL && atoi(optarg) > 0)
+				num_buckets = atoi(optarg);
+			break;
+		case 'B':
+		case OPT_BREAK:
+			if (optarg != NULL && atoi(optarg) > 0)
+				breaking_point = atoi(optarg);
+			break;
+		case 'h':
+		case OPT_HIST:
+			histogram = true;
+			break;
+		case 'n':
+		case OPT_NANOSEC:
+			units = 1000000000;
+			break;
+		case 'T':
+		case OPT_TRACE:
+			setup_tracing();
+			break;
+		case 'm':
+		case OPT_MLOCK:
+			memlock = true;
+			break;
+		case 'f':
+		case OPT_PREFAULT:
+			prefault = true;
+			break;
+		case 'p':
+		case OPT_POLICY:
+			handlepolicy(optarg);
+			break;
+		case 'P':
+		case OPT_PRIORITY:
+			if (optarg != NULL && atoi(optarg) >= 0 && atoi(optarg) <= 99) {
+				priority = atoi(optarg);
+				if (policy != SCHED_FIFO && policy != SCHED_RR)
+					policy = SCHED_FIFO;
+			}
+			break;
+		case '?':
+		case OPT_HELP:
+			show_help(0);
+			break;
+		}
+	}
+}
+
+/*
+ * live_updates:
+ * This function provides live updates to the user on the progress of
+ * the tests.
+ */
+static void *live_updates(void *param)
+{
+	int j;
+
+	while (!should_stop) {
+
+		for (j = 0; j < num_cpus; j++) {
+			unsigned long min = (unsigned long long)(benchmark[j].cycle_min * units * mod / cycles_per_sec);
+			unsigned long avg = (unsigned long long)(benchmark[j].cycle_avg * units * mod / cycles_per_sec);
+			unsigned long long max = (unsigned long long)(benchmark[j].cycle_max * units / cycles_per_sec);
+			printf("T: %2d P: %2d C: %7llu Min: \t%3lu (ns) Avg: \t%3lu (ns) Max: \t%3llu (%s)\n", j, priority, \
+				benchmark[j].loop_count, min, avg, max, units == 1000000 ? "us" : "ns");
+		}
+
+		for (j = 0; j < num_cpus; j++)
+			fputs("\033[A", stdout);
+	}
+
+	for (j = 0; j < num_cpus; j++)
+		printf("\n");
+
+	return NULL;
+}
+
+/*
+ * print_benchmark: void -> void
+ * This function takes the completed benchmark and prints in table form
+ * the resulting max jitter and bucket data.
+ */
+static void print_histogram(void)
+{
+	int i, j, step;
+	unsigned long long jitter, sum_column, high;
+
+	step = upper_bound / num_buckets;
+
+	printf("# Jitter (%s) | Instances\n", units == 1000000 ? "us" : "ns");
+
+	for (i = 0; i < num_buckets; i++) {
+		sum_column = 0;
+		high = step * i + 1;
+		printf("%06llu ", high);
+
+		for (j = 0; j < num_cpus; j++) {
+			jitter = benchmark[j].buckets[i];
+			sum_column += jitter;
+
+			printf("%08llu ", jitter);
+		}
+		printf("%08llu\n", sum_column);
+	}
+
+	printf("# Histogram Overflows: ");
+
+	for (j = 0; j < num_cpus; j++) {
+		printf("%06lu ", benchmark[j].overflow);
+		j++;
+	}
+
+	printf("\n");
+	printf("# Min Latencies (ns):   ");
+
+	for (j = 0; j < num_cpus; j++) {
+		unsigned long min = (unsigned long)(benchmark[j].cycle_min * units * mod / cycles_per_sec);
+		printf("%06lu ", min);
+		j++;
+	}
+
+	printf("\n");
+	printf("# Avg Latencies (ns):   ");
+
+	for (j = 0; j < num_cpus; j++) {
+		unsigned long avg = (unsigned long)(benchmark[j].cycle_avg * units * mod / cycles_per_sec);
+		printf("%06lu ", avg);
+		j++;
+	}
+
+	printf("\n");
+	printf("# Max Latencies (%s):   ", units == 1000000 ? "us" : "ns");
+
+	for (j = 0; j < num_cpus; j++) {
+		unsigned long long maximum = (unsigned long long)(benchmark[j].cycle_max * units / cycles_per_sec);
+		printf("%06llu ", maximum);
+		j++;
+	}
+
+	printf("\n");
+}
+
+/*
+ * analyze_jitter: void -> void
+ * This function executes a benchmark for each thread and stores the
+ * results so they can be printed after every thread is joined.
+ */
+static void *thread_start(void *bench)
+{
+	struct thread_data *data = bench;
+	unsigned long long cyc_now, cyc_prev, cyc_total, cyc_delta;
+	data->loop_count = cyc_prev = cyc_total = 0;
+	cyc_prev = cyc_now = get_cycles();
+
+	data->buckets = calloc(num_buckets, sizeof(unsigned long long));
+	data->cycle_min = -1;
+
+	if (!data->buckets) {
+		printf("# setup_bench: buckets");
+		exit(EXIT_FAILURE);
+	}
+
+	trace_marker_write("starting rdtscbench");
+
+	while (!should_stop) {
+
+		if (run_time >= 0 && cyc_now - start_time > run_time)
+			break;
+
+		data->loop_count++;
+		cyc_now = get_cycles();
+
+		if (data->loop_count > warmup_period) {
+
+			cyc_delta = cyc_now - cyc_prev;
+
+			if (cyc_delta < data->cycle_min)
+				data->cycle_min = cyc_delta;
+
+			if (cyc_delta > data->cycle_max)
+				data->cycle_max = cyc_delta;
+
+			cyc_total += cyc_delta;
+
+			int jitter_loc = (cyc_delta) / (hist_bound / num_buckets);
+
+			if (jitter_loc >= num_buckets)
+				data->overflow++;
+			else
+				data->buckets[jitter_loc]++;
+
+			if (breaking_point > 0 && (cyc_delta) > breaking_point) {
+				trace_marker_write("stopping rdtscbench: hit latency max");
+				break;
+			}
+
+			data->cycle_avg = cyc_total / data->loop_count;
+		}
+
+		cyc_prev = cyc_now;
+	}
+
+	trace_marker_write("stopping rdtscbench");
+
+	return NULL;
+}
+
+/*
+ * config_tests: void -> void
+ * This function calculates some shared values for all of the tests.
+ */
+static void config_tests(void)
+{
+	num_cpus = sysconf(_SC_NPROCESSORS_ONLN);
+	cycles_per_sec = get_cycles_per_second();
+	run_time *= cycles_per_sec;
+	mod = units == 1000000 ? 100 : 1;
+	hist_bound = upper_bound * cycles_per_sec / units;
+	breaking_point *= cycles_per_sec / units;
+	start_time = get_cycles();
+}
+
+/*
+ * run_live: void -> pthread_t
+ * This function sets up and runs the live reporting thread
+ * and returns the pthread_t for joining later on.
+ */
+static pthread_t run_live(void)
+{
+	int err;
+	pthread_attr_t attr;
+	pthread_t live;
+	struct sched_param param;
+	cpu_set_t mask;
+
+	err = pthread_attr_init(&attr);
+	if (err != 0) {
+		perror("# run_rdtscbench_threads: attr_init");
+		exit(EXIT_FAILURE);
+	}
+
+	CPU_ZERO(&mask);
+	CPU_SET(0, &mask);
+
+	err = pthread_attr_setaffinity_np(&attr, sizeof(mask), &mask);
+
+	if (err != 0) {
+		perror(strerror(err));
+		exit(EXIT_FAILURE);
+	}
+
+	if (pthread_attr_setschedpolicy(&attr, policy)) {
+		perror("# run_rdtscbench_threads: pthread_attr_setschedpolicy");
+		exit(EXIT_FAILURE);
+	}
+
+	if (priority - 1 > 0) {
+		param.sched_priority = priority - 1;
+		if (pthread_attr_setschedparam(&attr, &param)) {
+			perror("# run_rdtscbench_threads: pthread_attr_setschedparam");
+			exit(EXIT_FAILURE);
+		}
+	}
+
+	err = pthread_create(&live, &attr, live_updates, NULL);
+	if (err) {
+		perror("# run_rdtscbench_threads: pthread_create");
+		exit(EXIT_FAILURE);
+	}
+
+	pthread_attr_destroy(&attr);
+
+	return live;
+}
+
+/*
+ * run_rdtscbench_threads: void -> void
+ * This function sets up the necessary test threads and executes them,
+ * rejoins them, and makes the call to print the output.
+ */
+static void run_rdtscbench_threads(void)
+{
+	int err, i;
+
+	config_tests();
+
+	signal(SIGINT, sighand);
+
+	benchmark = calloc(num_cpus, sizeof(struct thread_data));
+
+	for (i = 0; i < num_cpus; i++) {
+		pthread_attr_t attr;
+		struct sched_param param;
+		cpu_set_t mask;
+
+		err = pthread_attr_init(&attr);
+		if (err != 0) {
+			perror("# run_rdtscbench_threads: attr_init");
+			exit(EXIT_FAILURE);
+		}
+
+		CPU_ZERO(&mask);
+		CPU_SET(i, &mask);
+
+		err = pthread_attr_setaffinity_np(&attr, sizeof(mask), &mask);
+
+		if (err != 0) {
+			perror(strerror(err));
+			exit(EXIT_FAILURE);
+		}
+
+		if (pthread_attr_setschedpolicy(&attr, policy)) {
+			perror("# run_rdtscbench_threads: pthread_attr_setschedpolicy");
+			exit(EXIT_FAILURE);
+		}
+
+		if (priority != -1) {
+			param.sched_priority = priority;
+			if (pthread_attr_setschedparam(&attr, &param)) {
+				perror("# run_rdtscbench_threads: pthread_attr_setschedparam");
+				exit(EXIT_FAILURE);
+			}
+		}
+
+		err = pthread_create(&benchmark[i].thread, &attr, thread_start, &benchmark[i]);
+		if (err) {
+			perror("# run_rdtscbench_threads: pthread_create");
+			exit(EXIT_FAILURE);
+		}
+
+		pthread_attr_destroy(&attr);
+	}
+
+	pthread_t live = run_live();
+
+	for (i = 0; i < num_cpus; i++) {
+		err = pthread_join(benchmark[i].thread, NULL);
+
+		if (err != 0)
+			printf("# error in thread join of %d\n", err);
+	}
+
+	should_stop = true;
+
+	err = pthread_join(live, NULL);
+
+	if (err != 0)
+		printf("# error in thread join of %d\n", 0);
+
+	trace_set_enabled(false);
+
+	if (histogram)
+		print_histogram();
+}
+
+/*
+ * This function cleans up after the benchmark runs.
+ */
+static void cleanup(void)
+{
+	free(benchmark);
+
+	/* Unlocking memory */
+	if (memlock)
+		munlockall();
+}
+
+/*
+ * This function does work based on the processed options
+ */
+static void post_process_options(void)
+{
+	/* Possible mlockall */
+	if (memlock)
+		set_mlock();
+
+	/* Pre-faulting stack */
+	if (prefault)
+		stack_prefault();
+
+	// This has to go after because the units could change.
+	if (units != 1000000) {
+		upper_bound *= 1000;
+		breaking_point *= 1000;
+	}
+}
+
+int main(int argc, char* argv[])
+{
+	process_options(argc, argv);
+	post_process_options();
+
+	/* Benchmarking test */
+	run_rdtscbench_threads();
+
+	cleanup();
+
+	return 0;
+}
-- 
1.9.1

