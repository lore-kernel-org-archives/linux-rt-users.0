From: Carsten Emde <Carsten.Emde@osadl.org>
Subject: [PATCH] Add test of message queues to rt-tests
Date: Mon, 29 Mar 2010 17:08:35 +0200
Message-ID: <4BB0C273.2040606@osadl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050508050904010604080405"
Cc: Thomas Gleixner <tglx@linutronix.de>,
	RT-Users <linux-rt-users@vger.kernel.org>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:40802 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753437Ab0C2PK3 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 29 Mar 2010 11:10:29 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is a multi-part message in MIME format.
--------------050508050904010604080405
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

This patch adds the program pmqtest to the rt-tests suite.
The test mechanism is the same as in ptsematest, svsematest
and friends, but it uses message queues to synchronize the
test threads. To test the - now hopefully fixed - kernel
problem that occurred when a timeout was specified, the
-T option is available.

On an 8-way machine, the test result may look like:

# pmqtest -Sp99 -i100 -d0
#0: ID19903, P99, CPU0, I100; #1: ID19904, P99, CPU0, Cycles 870686
#2: ID19905, P99, CPU1, I100; #3: ID19906, P99, CPU1, Cycles 872555
#4: ID19907, P99, CPU2, I100; #5: ID19908, P99, CPU2, Cycles 894958
#6: ID19909, P99, CPU3, I100; #7: ID19910, P99, CPU3, Cycles 897776
#8: ID19911, P99, CPU4, I100; #9: ID19912, P99, CPU4, Cycles 870067
#10: ID19913, P99, CPU5, I100; #11: ID19914, P99, CPU5, Cycles 872351
#12: ID19915, P99, CPU6, I100; #13: ID19916, P99, CPU6, Cycles 894460
#14: ID19917, P99, CPU7, I100; #15: ID19918, P99, CPU7, Cycles 897480
#1 -> #0, Min    1, Cur    4, Avg    5, Max   19
#3 -> #2, Min    1, Cur    7, Avg    5, Max   18
#5 -> #4, Min    1, Cur    5, Avg    5, Max   19
#7 -> #6, Min    1, Cur    5, Avg    4, Max   23
#9 -> #8, Min    1, Cur    4, Avg    6, Max   20
#11 -> #10, Min    1, Cur    8, Avg    5, Max   18
#13 -> #12, Min    1, Cur    5, Avg    5, Max   33
#15 -> #14, Min    1, Cur    5, Avg    4, Max   18

Signed-off-by: Carsten Emde <C.Emde@osadl.org>

--------------050508050904010604080405
Content-Type: text/x-patch;
 name="add-pmqtest-program.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="add-pmqtest-program.patch"

diff --git a/Makefile b/Makefile
index d6ab07a..f98111b 100644
--- a/Makefile
+++ b/Makefile
@@ -1,8 +1,8 @@
 VERSION_STRING = 0.68
 
 sources = cyclictest.c signaltest.c pi_stress.c rt-migrate-test.c	\
-	  ptsematest.c sigwaittest.c svsematest.c sendme.c pip_stress.c \
-	  hackbench.c
+	  ptsematest.c sigwaittest.c svsematest.c pmqtest.c sendme.c 	\
+	  pip_stress.c hackbench.c
 
 TARGETS = $(sources:.c=)
 
@@ -36,6 +36,7 @@ VPATH	+= src/rt-migrate-test:
 VPATH	+= src/ptsematest:
 VPATH	+= src/sigwaittest:
 VPATH	+= src/svsematest:
+VPATH	+= src/pmqtest:
 VPATH	+= src/backfire:
 VPATH	+= src/lib
 VPATH	+= src/hackbench
@@ -78,6 +79,9 @@ sigwaittest: sigwaittest.o rt-utils.o rt-get_cpu.o
 svsematest: svsematest.o rt-utils.o rt-get_cpu.o
 	$(CC) $(CFLAGS) -o $@ $^ $(LIBS) $(EXTRA_LIBS)
 
+pmqtest: pmqtest.o rt-utils.o rt-get_cpu.o
+	$(CC) $(CFLAGS) -o $@ $^ $(LIBS) $(EXTRA_LIBS)
+
 sendme: sendme.o rt-utils.o rt-get_cpu.o
 	$(CC) $(CFLAGS) -o $@ $^ $(LIBS) $(EXTRA_LIBS)
 
@@ -120,6 +124,7 @@ install: all
 	gzip src/ptsematest/ptsematest.8 -c >"$(DESTDIR)$(mandir)/man8/ptsematest.8.gz"
 	gzip src/sigwaittest/sigwaittest.8 -c >"$(DESTDIR)$(mandir)/man8/sigwaittest.8.gz"
 	gzip src/svsematest/svsematest.8 -c >"$(DESTDIR)$(mandir)/man8/svsematest.8.gz"
+	gzip src/pmqtest/pmqtest.8 -c >"$(DESTDIR)$(mandir)/man8/pmqtest.8.gz"
 	gzip src/backfire/sendme.8 -c >"$(DESTDIR)$(mandir)/man8/sendme.8.gz"
 	gzip src/hackbench/hackbench.8 -c >"$(DESTDIR)$(mandir)/man8/hackbench.8.gz"
 
diff --git a/rt-tests.spec-in b/rt-tests.spec-in
index 6f45db4..7279813 100644
--- a/rt-tests.spec-in
+++ b/rt-tests.spec-in
@@ -45,6 +45,7 @@ rm -rf $RPM_BUILD_ROOT
 /usr/bin/sendme
 /usr/bin/sigwaittest
 /usr/bin/svsematest
+/usr/bin/pmqtest
 /usr/bin/hackbench
 /usr/src/backfire/backfire.c
 %doc
@@ -56,6 +57,7 @@ rm -rf $RPM_BUILD_ROOT
 /usr/share/man/man8/sendme.8.gz
 /usr/share/man/man8/sigwaittest.8.gz
 /usr/share/man/man8/svsematest.8.gz
+/usr/share/man/man8/pmqtest.8.gz
 /usr/share/man/man8/hackbench.8.gz
 
 %changelog
diff --git a/src/pmqtest/Makefile b/src/pmqtest/Makefile
new file mode 100644
index 0000000..0902c9b
--- /dev/null
+++ b/src/pmqtest/Makefile
@@ -0,0 +1,16 @@
+CFLAGS += -Wall -O2
+LDFLAGS += -lpthread
+
+all:	pmqtest
+	@echo Done
+
+pmqtest.o: pmqtest.c
+
+pmqtest:
+
+clean:
+	@rm -f *.o
+
+tar:	clean
+	@rm -f pmqtest
+	$(shell bn=`basename $$PWD`; cd ..; tar -zcf $$bn.tgz $$bn)
diff --git a/src/pmqtest/pmqtest.8 b/src/pmqtest/pmqtest.8
new file mode 100644
index 0000000..7c886c9
--- /dev/null
+++ b/src/pmqtest/pmqtest.8
@@ -0,0 +1,68 @@
+.TH "pmqtest" "8" "0.1" "" ""
+.SH "NAME"
+.LP
+\fBpmqtest\fR \- Start pairs of threads and measure the latency of interprocess communication with POSIX messages queues
+.SH "SYNTAX"
+.LP
+pmqtest [-a|-a PROC] [-b USEC] [-d DIST] [-i INTV] [-l loops] [-p PRIO] [-S] [-t|-t NUM] [-T TO]
+.br
+.SH "DESCRIPTION"
+.LP
+The program \fBpmqtest\fR starts pairs of threads that are synchronized via mq_send/mw_receive() and measures the latency between sending and receiving the message.
+.SH "OPTIONS"
+.TP
+.B \-a, \-\-affinity[=PROC]
+Run on procesor number PROC. If PROC is not specified, run on current processor.
+.TP
+.B \-b, \-\-breaktrace=USEC
+Send break trace command when latency > USEC. This is a debugging option to control the latency tracer in the realtime preemption patch.
+It is useful to track down unexpected large latencies of a system.
+.TP
+.B \-d, \-\-distance=DIST
+Set the distance of thread intervals in microseconds (default is 500 us). When  cylictest is called with the -t option and more than one thread is created, then this distance value is added to the interval of the threads: Interval(thread N) = Interval(thread N-1) + DIST
+.TP
+.B \-i, \-\-interval=INTV
+Set the base interval of the thread(s) in microseconds (default is 1000 us). This sets the interval of the first thread. See also -d.
+.TP
+.B \-l, \-\-loops=LOOPS
+Set the number of loops. The default is 0 (endless). This option is useful for automated tests with a given number of test cycles. pmqtest is stopped once the number of timer intervals has been reached.
+.TP
+.B \-p, \-\-prio=PRIO
+Set the priority of the process.
+.TP
+.B \-S, \-\-smp
+Test mode for symmetric multi-processing, implies -a and -t and uses the same priority on all threads.
+.TP
+.B \-t, \-\-threads[=NUM]
+Set the number of test threads (default is 1, if this option is not given). If NUM is specified, create NUM test threads. If NUM is not specifed, NUM is set to the number of available CPUs.
+.TP
+.B \-T, \-\-timeout=TO
+Use mq_timedreceive() instead of mq_receive() and specify timeout TO in seconds.
+.SH "EXAMPLES"
+The following example was running on an 8-way processor:
+.LP
+.nf
+# pmqtest -Sp99 -i100 -d0
+#0: ID10047, P99, CPU0, I100; #1: ID10048, P99, CPU0, Cycles 153695
+#2: ID10049, P99, CPU1, I100; #3: ID10050, P99, CPU1, Cycles 154211
+#4: ID10051, P99, CPU2, I100; #5: ID10052, P99, CPU2, Cycles 156823
+#6: ID10053, P99, CPU3, I100; #7: ID10054, P99, CPU3, Cycles 158202
+#8: ID10055, P99, CPU4, I100; #9: ID10056, P99, CPU4, Cycles 153399
+#10: ID10057, P99, CPU5, I100; #11: ID10058, P99, CPU5, Cycles 153992
+#12: ID10059, P99, CPU6, I100; #13: ID10060, P99, CPU6, Cycles 156576
+#14: ID10061, P99, CPU7, I100; #15: ID10062, P99, CPU7, Cycles 157957
+#1 -> #0, Min    1, Cur    8, Avg    5, Max   18
+#3 -> #2, Min    1, Cur    4, Avg    5, Max   18
+#5 -> #4, Min    1, Cur    5, Avg    5, Max   19
+#7 -> #6, Min    1, Cur    4, Avg    4, Max   17
+#9 -> #8, Min    1, Cur    9, Avg    5, Max   18
+#11 -> #10, Min    1, Cur    8, Avg    5, Max   18
+#13 -> #12, Min    1, Cur    4, Avg    5, Max   29
+#15 -> #14, Min    1, Cur    8, Avg    4, Max   17
+.fi
+.SH "AUTHORS"
+.LP
+Carsten Emde <C.Emde@osadl.org>
+.SH "SEE ALSO"
+.LP
+mq_send(3p), mq_receive(3p)
diff --git a/src/pmqtest/pmqtest.c b/src/pmqtest/pmqtest.c
new file mode 100644
index 0000000..9e81f23
--- /dev/null
+++ b/src/pmqtest/pmqtest.c
@@ -0,0 +1,510 @@
+/*
+ * pmqtest.c
+ *
+ * Copyright (C) 2009 Carsten Emde <C.Emde@osadl.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307,
+ * USA.
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <limits.h>
+#include <fcntl.h>
+#include <getopt.h>
+#include <signal.h>
+#include <string.h>
+#include <time.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/time.h>
+#include <sys/mman.h>
+#include <linux/unistd.h>
+#include <utmpx.h>
+#include <mqueue.h>
+#include "rt-utils.h"
+#include "rt-get_cpu.h"
+
+#include <pthread.h>
+
+#define gettid() syscall(__NR_gettid)
+
+#define USEC_PER_SEC 1000000
+
+#define SYNCMQ_NAME "/syncmsg%d"
+#define TESTMQ_NAME "/testmsg%d"
+#define MSG_SIZE 8
+#define MSEC_PER_SEC 1000
+#define NSEC_PER_SEC 1000000000
+
+char *syncmsg = "Syncing";
+char *testmsg = "Testing";
+
+enum {
+	AFFINITY_UNSPECIFIED,
+	AFFINITY_SPECIFIED,
+	AFFINITY_USEALL
+};
+
+struct params {
+	int num;
+	int cpu;
+	int priority;
+	int affinity;
+	int sender;
+	int samples;
+	int max_cycles;
+	int tracelimit;
+	int tid;
+	int shutdown;
+	int stopped;
+	struct timespec delay;
+	unsigned int mindiff, maxdiff;
+	double sumdiff;
+	struct timeval sent, received, diff;
+	pthread_t threadid;
+	int timeout;
+	mqd_t syncmq, testmq;
+	char recvsyncmsg[MSG_SIZE];
+	char recvtestmsg[MSG_SIZE];
+	struct params *neighbor;
+	char error[MAX_PATH * 2];
+};
+
+void *pmqthread(void *param)
+{
+	int mustgetcpu = 0;
+	struct params *par = param;
+	cpu_set_t mask;
+	int policy = SCHED_FIFO;
+	struct sched_param schedp;
+	struct timespec ts;
+
+	memset(&schedp, 0, sizeof(schedp));
+	schedp.sched_priority = par->priority;
+	sched_setscheduler(0, policy, &schedp);
+
+	if (par->cpu != -1) {
+		CPU_ZERO(&mask);
+		CPU_SET(par->cpu, &mask);
+		if(sched_setaffinity(0, sizeof(mask), &mask) == -1)
+			fprintf(stderr,	"WARNING: Could not set CPU affinity "
+				"to CPU #%d\n", par->cpu);
+	} else
+		mustgetcpu = 1;
+
+	par->tid = gettid();
+
+	while (!par->shutdown) {
+		if (par->sender) {
+			/* Send message: Start of latency measurement ... */
+			gettimeofday(&par->sent, NULL);
+			if (mq_send(par->testmq, testmsg, strlen(testmsg), 1) != 0) {
+				fprintf(stderr, "could not send test message\n");
+				par->shutdown = 1;
+			}
+			par->samples++;
+			if(par->max_cycles && par->samples >= par->max_cycles)
+				par->shutdown = 1;
+			if (mustgetcpu)
+				par->cpu = get_cpu();
+			/* Wait until receiver ready */
+			if (par->timeout) {
+				clock_gettime(CLOCK_REALTIME, &ts);
+				ts.tv_sec += par->timeout;
+	
+				if (mq_timedreceive(par->syncmq, par->recvsyncmsg, MSG_SIZE, NULL, &ts)
+				    != strlen(syncmsg)) {
+					fprintf(stderr, "could not receive sync message\n");
+					par->shutdown = 1;				
+				}
+			} else {
+				if (mq_receive(par->syncmq, par->recvsyncmsg, MSG_SIZE, NULL) !=
+				    strlen(syncmsg)) {
+					perror("could not receive sync message");
+					par->shutdown = 1;				
+				}
+			}
+			if (!par->shutdown && strcmp(syncmsg, par->recvsyncmsg)) {
+				fprintf(stderr, "ERROR: Sync message mismatch detected\n");
+				fprintf(stderr, "  %s != %s\n", syncmsg, par->recvsyncmsg);
+				par->shutdown = 1;
+			}
+		} else {
+			/* Receiver */
+			if (par->timeout) {
+				clock_gettime(CLOCK_REALTIME, &ts);
+				ts.tv_sec += par->timeout;
+				if (mq_timedreceive(par->testmq, par->recvtestmsg, MSG_SIZE, NULL, &ts) !=
+				    strlen(testmsg)) {
+					perror("could not receive test message");
+					par->shutdown = 1;
+				}
+			} else {
+				if (mq_receive(par->testmq, par->recvtestmsg, MSG_SIZE, NULL) !=
+				    strlen(testmsg)) {
+					perror("could not receive test message");
+					par->shutdown = 1;
+				}
+			}
+			/* ... Received the message: End of latency measurement */
+			gettimeofday(&par->received, NULL);
+
+			if (!par->shutdown && strcmp(testmsg, par->recvtestmsg)) {
+				fprintf(stderr, "ERROR: Test message mismatch detected\n");
+				fprintf(stderr, "  %s != %s\n", testmsg, par->recvtestmsg);
+				par->shutdown = 1;
+			}
+			par->samples++;
+			timersub(&par->received, &par->neighbor->sent,
+			    &par->diff);
+
+			if (par->diff.tv_usec < par->mindiff)
+				par->mindiff = par->diff.tv_usec;
+			if (par->diff.tv_usec > par->maxdiff)
+				par->maxdiff = par->diff.tv_usec;
+			par->sumdiff += (double) par->diff.tv_usec;
+			if (par->tracelimit && par->maxdiff > par->tracelimit) {
+				char tracing_enabled_file[MAX_PATH];
+
+				strcpy(tracing_enabled_file, get_debugfileprefix());
+				strcat(tracing_enabled_file, "tracing_enabled");
+				int tracing_enabled =
+				    open(tracing_enabled_file, O_WRONLY);
+				if (tracing_enabled >= 0) {
+					write(tracing_enabled, "0", 1);
+					close(tracing_enabled);
+				} else
+					snprintf(par->error, sizeof(par->error),
+					    "Could not access %s\n",
+					    tracing_enabled_file);
+				par->shutdown = 1;
+				par->neighbor->shutdown = 1;
+			}
+
+			if (par->max_cycles && par->samples >= par->max_cycles)
+				par->shutdown = 1;
+			if (mustgetcpu)
+				par->cpu = get_cpu();
+			nanosleep(&par->delay, NULL);
+
+			/* Tell receiver that we are ready for the next measurement */
+			if (mq_send(par->syncmq, syncmsg, strlen(syncmsg), 1) != 0) {
+				fprintf(stderr, "could not send sync message\n");
+				par->shutdown = 1;
+			}
+		}
+	}
+	par->stopped = 1;
+	return NULL;
+}
+
+
+static void display_help(void)
+{
+	printf("pmqtest V %1.2f\n", VERSION_STRING);
+	puts("Usage: pmqtest <options>");
+	puts("Function: test POSIX message queue latency");
+	puts(
+	"Options:\n"
+	"-a [NUM] --affinity        run thread #N on processor #N, if possible\n"
+	"                           with NUM pin all threads to the processor NUM\n"
+	"-b USEC  --breaktrace=USEC send break trace command when latency > USEC\n"
+	"-d DIST  --distance=DIST   distance of thread intervals in us default=500\n"
+	"-i INTV  --interval=INTV   base interval of thread in us default=1000\n"
+	"-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
+	"-p PRIO  --prio=PRIO       priority\n"
+	"-S       --smp             SMP testing: options -a -t and same priority\n"
+        "                           of all threads\n"
+	"-t       --threads         one thread per available processor\n"
+	"-t [NUM] --threads=NUM     number of threads:\n"
+	"                           without NUM, threads = max_cpus\n"
+	"                           without -t default = 1\n"
+	"-T TO    --timeout=TO      use mq_timedreceive() instead of mq_receive()\n"
+	"                           with timeout TO in seconds\n");
+	exit(1);
+}
+
+
+static int setaffinity = AFFINITY_UNSPECIFIED;
+static int affinity;
+static int tracelimit;
+static int priority;
+static int num_threads = 1;
+static int max_cycles;
+static int interval = 1000;
+static int distance = 500;
+static int smp;
+static int sameprio;
+static int timeout;
+
+static void process_options (int argc, char *argv[])
+{
+	int error = 0;
+	int max_cpus = sysconf(_SC_NPROCESSORS_CONF);
+
+	for (;;) {
+		int option_index = 0;
+		/** Options for getopt */
+		static struct option long_options[] = {
+			{"affinity", optional_argument, NULL, 'a'},
+			{"breaktrace", required_argument, NULL, 'b'},
+			{"distance", required_argument, NULL, 'd'},
+			{"interval", required_argument, NULL, 'i'},
+			{"loops", required_argument, NULL, 'l'},
+			{"priority", required_argument, NULL, 'p'},
+			{"smp", no_argument, NULL, 'S'},
+			{"threads", optional_argument, NULL, 't'},
+			{"timeout", required_argument, NULL, 'T'},
+			{"help", no_argument, NULL, '?'},
+			{NULL, 0, NULL, 0}
+		};
+		int c = getopt_long (argc, argv, "a::b:d:i:l:p:St::T:",
+			long_options, &option_index);
+		if (c == -1)
+			break;
+		switch (c) {
+		case 'a':
+			if (smp) {
+				warn("-a ignored due to --smp\n");
+				break;
+			}
+			if (optarg != NULL) {
+				affinity = atoi(optarg);
+				setaffinity = AFFINITY_SPECIFIED;
+			} else if (optind<argc && atoi(argv[optind])) {
+				affinity = atoi(argv[optind]);
+				setaffinity = AFFINITY_SPECIFIED;
+			} else {
+				setaffinity = AFFINITY_USEALL;
+			}
+			break;
+		case 'b': tracelimit = atoi(optarg); break;
+		case 'd': distance = atoi(optarg); break;
+		case 'i': interval = atoi(optarg); break;
+		case 'l': max_cycles = atoi(optarg); break;
+		case 'p': priority = atoi(optarg); break;
+		case 'S':
+			smp = 1;
+			num_threads = max_cpus;
+			setaffinity = AFFINITY_USEALL;
+			break;
+		case 't':
+			if (smp) {
+				warn("-t ignored due to --smp\n");
+				break;
+			}
+			if (optarg != NULL)
+				num_threads = atoi(optarg);
+			else if (optind<argc && atoi(argv[optind]))
+				num_threads = atoi(argv[optind]);
+			else
+				num_threads = max_cpus;
+			break;
+		case 'T': timeout = atoi(optarg); break;
+		case '?': error = 1; break;
+		}
+	}
+
+	if (setaffinity == AFFINITY_SPECIFIED) {
+		if (affinity < 0)
+			error = 1;
+		if (affinity >= max_cpus) {
+			fprintf(stderr, "ERROR: CPU #%d not found, only %d CPUs available\n",
+			    affinity, max_cpus);
+			error = 1;
+		}
+	}
+
+	if (num_threads < 0 || num_threads > 255)
+		error = 1;
+
+	if (priority < 0 || priority > 99)
+		error = 1;
+
+	if (num_threads < 1)
+		error = 1;
+
+	if (priority && smp)
+		sameprio = 1;
+
+	if (error)
+		display_help ();
+}
+
+
+static int volatile shutdown;
+
+static void sighand(int sig)
+{
+	shutdown = 1;
+}
+
+int main(int argc, char *argv[])
+{
+	int i;
+	int max_cpus = sysconf(_SC_NPROCESSORS_CONF);
+	int oldsamples = 1;
+	struct params *receiver = NULL;
+	struct params *sender = NULL;
+	sigset_t sigset;
+	struct timespec maindelay;
+	int oflag = O_CREAT|O_RDWR;
+	struct mq_attr mqstat;
+
+	memset(&mqstat, 0, sizeof(mqstat));
+	mqstat.mq_maxmsg = 1;
+	mqstat.mq_msgsize = 8;
+	mqstat.mq_flags = 0;
+
+	process_options(argc, argv);
+
+	if (check_privs())
+		return 1;
+
+	if (mlockall(MCL_CURRENT|MCL_FUTURE) == -1) {
+		perror("mlockall");
+		return 1;
+	}
+
+	signal(SIGINT, sighand);
+	signal(SIGTERM, sighand);
+
+	receiver = calloc(num_threads, sizeof(struct params));
+	sender = calloc(num_threads, sizeof(struct params));
+	if (receiver == NULL || sender == NULL)
+		goto nomem;
+
+	for (i = 0; i < num_threads; i++) {
+		char mqname[16];
+
+		sprintf(mqname, SYNCMQ_NAME, i);
+		receiver[i].syncmq = mq_open(mqname, oflag, 0777, &mqstat);
+		if (receiver[i].syncmq == (mqd_t) -1) {
+			fprintf(stderr, "could not open POSIX message queue #1\n");
+			return 1;
+		}
+		sprintf(mqname, TESTMQ_NAME, i);
+		receiver[i].testmq = mq_open(mqname, oflag, 0777, &mqstat);
+		if (receiver[i].testmq == (mqd_t) -1) {
+			fprintf(stderr, "could not open POSIX message queue #2\n");
+			return 1;
+		}
+
+		receiver[i].mindiff = UINT_MAX;
+		receiver[i].maxdiff = 0;
+		receiver[i].sumdiff = 0.0;
+
+		receiver[i].num = i;
+		receiver[i].cpu = i;
+		switch (setaffinity) {
+		case AFFINITY_UNSPECIFIED: receiver[i].cpu = -1; break;
+		case AFFINITY_SPECIFIED: receiver[i].cpu = affinity; break;
+		case AFFINITY_USEALL: receiver[i].cpu = i % max_cpus; break;
+		}
+		receiver[i].priority = priority;
+		receiver[i].tracelimit = tracelimit;
+		if (priority > 1 && !sameprio)
+			priority--;
+		receiver[i].delay.tv_sec = interval / USEC_PER_SEC;
+		receiver[i].delay.tv_nsec = (interval % USEC_PER_SEC) * 1000;
+		interval += distance;
+		receiver[i].max_cycles = max_cycles;
+		receiver[i].sender = 0;
+		receiver[i].neighbor = &sender[i];
+		receiver[i].timeout = timeout;
+		pthread_create(&receiver[i].threadid, NULL, pmqthread, &receiver[i]);
+		memcpy(&sender[i], &receiver[i], sizeof(receiver[0]));
+		sender[i].sender = 1;
+		sender[i].neighbor = &receiver[i];
+		pthread_create(&sender[i].threadid, NULL, pmqthread, &sender[i]);
+	}
+
+	maindelay.tv_sec = 0;
+	maindelay.tv_nsec = 50000000; /* 50 ms */
+
+	while (!shutdown) {
+		int printed;
+		int errorlines = 0;
+
+		for (i = 0; i < num_threads; i++)
+			shutdown |= receiver[i].shutdown | sender[i].shutdown;
+
+		if (receiver[0].samples > oldsamples || shutdown) {
+			for (i = 0; i < num_threads; i++) {
+				printf("#%1d: ID%d, P%d, CPU%d, I%ld; #%1d: ID%d, P%d, CPU%d, Cycles %d\n",
+				    i*2, receiver[i].tid, receiver[i].priority, receiver[i].cpu,
+				    receiver[i].delay.tv_nsec / 1000,
+				    i*2+1, sender[i].tid, sender[i].priority, sender[i].cpu,
+				    sender[i].samples);
+			}
+			for (i = 0; i < num_threads; i++) {
+				printf("#%d -> #%d, Min %4d, Cur %4d, Avg %4d, Max %4d\n",
+					i*2+1, i*2,
+					receiver[i].mindiff, (int) receiver[i].diff.tv_usec,
+					(int) ((receiver[i].sumdiff / receiver[i].samples) + 0.5),
+					receiver[i].maxdiff);
+				if (receiver[i].error[0] != '\0') {
+					printf(receiver[i].error);
+					errorlines++;
+					receiver[i].error[0] = '\0';
+				}
+				if (sender[i].error[0] != '\0') {
+					printf(sender[i].error);
+					errorlines++;
+					receiver[i].error[0] = '\0';
+				}
+			}
+			printed = 1;
+		} else
+			printed = 0;
+
+		sigemptyset(&sigset);
+		sigaddset(&sigset, SIGTERM);
+		sigaddset(&sigset, SIGINT);
+		pthread_sigmask(SIG_SETMASK, &sigset, NULL);
+
+		nanosleep(&maindelay, NULL);
+
+		sigemptyset(&sigset);
+		pthread_sigmask(SIG_SETMASK, &sigset, NULL);
+
+		if (printed && !shutdown)
+			printf("\033[%dA", num_threads*2 + errorlines);
+	}
+
+	for (i = 0; i < num_threads; i++) {
+		receiver[i].shutdown = 1;
+		sender[i].shutdown = 1;
+	}
+
+	for (i = 0; i < num_threads; i++) {
+		if (!receiver[i].stopped)
+			pthread_kill(receiver[i].threadid, SIGTERM);
+		if (!sender[i].stopped)
+			pthread_kill(sender[i].threadid, SIGTERM);
+	}
+	nanosleep(&maindelay, NULL);
+	for (i = 0; i < num_threads; i++) {
+		mq_close(receiver[i].syncmq);
+		mq_close(receiver[i].testmq);
+	}
+
+	nomem:
+
+	return 0;
+}
+

--------------050508050904010604080405--
