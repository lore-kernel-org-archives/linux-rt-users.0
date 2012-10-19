From: Jain Priyanka-B32167 <B32167@freescale.com>
Subject: RE: [PATCH 3/4] Add cyclicload calibration & load generation feature
Date: Fri, 19 Oct 2012 04:32:47 +0000
Message-ID: <AC83832D6324604BB08FAE5A33553F190B175EC1@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1346320607-6691-1-git-send-email-Priyanka.Jain@freescale.com>
 <1346320607-6691-4-git-send-email-Priyanka.Jain@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: Aggrwal Poonam-B10812 <B10812@freescale.com>,
	"jkacur@redhat.com" <jkacur@redhat.com>,
	"frank.rowand@am.sony.com" <frank.rowand@am.sony.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	Srivastava Rajan-B34330 <B34330@freescale.com>,
	"dvhart@linux.intel.com" <dvhart@linux.intel.com>,
	Jain Priyanka-B32167 <B32167@freescale.com>
To: "williams@redhat.com" <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from co1ehsobe005.messaging.microsoft.com ([216.32.180.188]:50246
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757536Ab2JSEcw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 19 Oct 2012 00:32:52 -0400
In-Reply-To: <1346320607-6691-4-git-send-email-Priyanka.Jain@freescale.com>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Dear Clark,

Its along time that since I have send patches for cyclicload.
I can see patch for cyclicload integrated into work branch on rt-test git tree.
Did you have any feedback on its working.

Also I have made some improvements on it. Should I send the next version of the cyclicload patch or a new patch for the changes based on the 'work' branch code.

Regards
Priyanka



-----Original Message-----
From: Jain Priyanka-B32167 
Sent: Thursday, August 30, 2012 3:27 PM
To: jkacur@redhat.com; williams@redhat.com; frank.rowand@am.sony.com; linux-rt-users@vger.kernel.org; dvhart@linux.intel.com; Srivastava Rajan-B34330
Cc: Aggrwal Poonam-B10812; Jain Priyanka-B32167
Subject: [PATCH 3/4] Add cyclicload calibration & load generation feature

Signed-off-by: Priyanka Jain <Priyanka.Jain@freescale.com>
---
 Makefile                    |    7 +-
 src/cyclicload/cyclicload.c |  550 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 546 insertions(+), 11 deletions(-)

diff --git a/Makefile b/Makefile
index 3a82407..5f48262 100644
--- a/Makefile
+++ b/Makefile
@@ -2,7 +2,7 @@ VERSION_STRING = 0.84
 
 sources = cyclictest.c signaltest.c pi_stress.c rt-migrate-test.c	\
 	  ptsematest.c sigwaittest.c svsematest.c pmqtest.c sendme.c 	\
-	  pip_stress.c hackbench.c
+	  pip_stress.c hackbench.c cyclicload.c
 
 TARGETS = $(sources:.c=)
 
@@ -47,6 +47,7 @@ VPATH	+= src/pmqtest:
 VPATH	+= src/backfire:
 VPATH	+= src/lib
 VPATH	+= src/hackbench
+VPATH	+= src/cyclicload
 
 %.o: %.c
 	$(CC) -D VERSION_STRING=$(VERSION_STRING) -c $< $(CFLAGS) @@ -98,6 +99,9 @@ pip_stress: pip_stress.o librttest.a
 hackbench: hackbench.o
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS)
 
+cyclicload: cyclicload.o librttest.a
+	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS) $(NUMA_LIBS)
+
 librttest.a: rt-utils.o error.o rt-get_cpu.o
 	$(AR) rcs librttest.a rt-utils.o error.o rt-get_cpu.o
 
@@ -140,6 +144,7 @@ install: all
 	gzip src/pmqtest/pmqtest.8 -c >"$(DESTDIR)$(mandir)/man8/pmqtest.8.gz"
 	gzip src/backfire/sendme.8 -c >"$(DESTDIR)$(mandir)/man8/sendme.8.gz"
 	gzip src/hackbench/hackbench.8 -c >"$(DESTDIR)$(mandir)/man8/hackbench.8.gz"
+	gzip src/cyclicload/cyclicload.8 -c >"$(DESTDIR)$(mandir)/man8/cyclicload.8.gz"
 
 .PHONY: release
 release: clean changelog
diff --git a/src/cyclicload/cyclicload.c b/src/cyclicload/cyclicload.c index 11b6cea..ee43816 100644
--- a/src/cyclicload/cyclicload.c
+++ b/src/cyclicload/cyclicload.c
@@ -1,13 +1,28 @@
 /*
- * High resolution timer test software
+ * Load generation test software
  *
- * (C) 2008-2012 Clark Williams <williams@redhat.com>
- * (C) 2005-2007 Thomas Gleixner <tglx@linutronix.de>
+ * Author: Priyanka.Jain@freescale.com
+ * Based on cyclictest code
+ *
+ * Copyright 2012 Freescale Semiconductor, Inc.
+ *
+ * See file CREDITS for list of people who contributed to this
+ * project.
  *
  * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License Version
- * 2 as published by the Free Software Foundation.
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
  *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
+ * MA 02111-1307 USA
  */
 
 #include <stdio.h>
@@ -25,6 +40,7 @@
 #include <errno.h>
 #include <limits.h>
 #include <linux/unistd.h>
+#include <semaphore.h>
 
 #include <sys/prctl.h>
 #include <sys/stat.h>
@@ -34,7 +50,7 @@
 #include <sys/resource.h>
 #include <sys/utsname.h>
 #include <sys/mman.h>
-#include "rt_numa.h"
+#include "../cyclictest/rt_numa.h"
 
 #include "rt-utils.h"
 
@@ -157,6 +173,17 @@ struct thread_stat {
 	long redmax;
 	long cycleofmax;
 	long hist_overflow;
+	unsigned long load2_start;
+	pthread_t thread_t2;
+	int threadt2_started;
+	double avg_t1;
+	double avg_t2;
+	int done_t1;
+	int done_t2;
+	int num_t1;
+	int num_t2;
+	int next_window_started;
+	sem_t next_window_sem;
 };
 
 static int shutdown;
@@ -174,6 +201,16 @@ static int use_nsecs = 0;  static int refresh_on_max;  static int force_sched_other;  static int priospread = 0;
+static int load_t1;
+static int load_t2;
+static int priority_t2;
+static int nice_t2;
+#define MAX_CORES 16
+#define FILENAME "calibrate_count"
+
+/*caliberation count in microseond*/
+#define CALIBRATE_COUNT_TIME 1000
+static int calibrate_count_array[MAX_CORES];
 
 static pthread_cond_t refresh_on_max_cond = PTHREAD_COND_INITIALIZER;  static pthread_mutex_t refresh_on_max_lock = PTHREAD_MUTEX_INITIALIZER; @@ -662,6 +699,70 @@ try_again:
 	return err;
 }
 
+static inline void generate_load(int loops, int *done, int 
+*next_window) {
+	/*initializing with some random values*/
+	/*use volatile to prevent compiler from optimizing */
+	volatile int a = 144;
+	int b = 193, c = 182, d = 987;
+	*done = 0;
+	while ((loops-- > 0) && (*next_window == 0))  {
+		a = b + c * d ;
+		b = d + a - c ;
+		c = b * d;
+		d = a * c + b;
+		*done = *done + 1;
+	}
+}
+
+void *load2_thread(void *param)
+{
+	struct thread_param *par = param;
+	struct thread_stat *stat = par->stats;
+	struct sched_param schedp;
+	pthread_t thread;
+	cpu_set_t mask;
+
+	if (par->cpu != -1) {
+		CPU_ZERO(&mask);
+		CPU_SET(par->cpu, &mask);
+		thread = pthread_self();
+		if (pthread_setaffinity_np(thread, sizeof(mask), &mask) == -1)
+			warn("Could not set CPU affinity to CPU #%d\n",
+				par->cpu);
+	}
+
+	memset(&schedp, 0, sizeof(schedp));
+	schedp.sched_priority = priority_t2;
+	if (priority_t2 == 0) {
+		if (setscheduler(0, SCHED_OTHER, &schedp))
+			fatal("load2_thread%d: failed to set priority to %d\n",
+				par->cpu, par->prio);
+		if (setpriority(PRIO_PROCESS, 0, nice_t2) == -1)
+			warn("could not set nice value\n");
+
+	} else {
+		if (setscheduler(0, par->policy, &schedp))
+			fatal("load2_thread%d: failed to set priority to %d\n",
+				par->cpu, par->prio);
+	}
+	stat->load2_start = stat->cycles;
+	while (!shutdown) {
+		stat->next_window_started = 0;
+		generate_load(stat->num_t2,  &stat->done_t2,
+			&(stat->next_window_started));
+
+		/* wait for next window*/
+		/*
+		 *load2_threadruns at lower priority than timerthread
+		 *so no locking is required
+		 */
+		sem_wait(&stat->next_window_sem);
+	}
+	stat->threadt2_started = -1;
+	return NULL;
+}
+
 /*
  * timer thread
  *
@@ -688,6 +789,9 @@ void *timerthread(void *param)
 	int stopped = 0;
 	cpu_set_t mask;
 	pthread_t thread;
+	struct timespec reduced_interval;
+	int status;
+	int red_interval = par->interval;
 
 	/* if we're running in numa mode, set our memory node */
 	if (par->node != -1)
@@ -723,6 +827,28 @@ void *timerthread(void *param)
 	if (setscheduler(0, par->policy, &schedp)) 
 		fatal("timerthread%d: failed to set priority to %d\n", par->cpu, par->prio);
 
+	if (load_t1) {
+		stat->num_t1 = (calibrate_count_array[par->cpu] *
+			(load_t1 * par->interval/100))/CALIBRATE_COUNT_TIME;
+		red_interval *= (100 - load_t1)/100;
+	}
+	reduced_interval.tv_sec = red_interval/USEC_PER_SEC;
+	reduced_interval.tv_nsec = (red_interval%USEC_PER_SEC) * 1000;
+	if (load_t2) {
+		stat->num_t2 = (calibrate_count_array[par->cpu] *
+			(load_t2 * par->interval/100))/CALIBRATE_COUNT_TIME;
+		stat->threadt2_started++;
+		status = pthread_create(&stat->thread_t2, NULL, load2_thread,
+			par);
+		if (status)
+			fatal("failed to create load thread %s\n",
+				strerror(status));
+		status = sem_init(&stat->next_window_sem, 0, 0);
+		if (status)
+			fatal("failed to init sem %s\n",
+				strerror(status));
+	}
+
 	/* Get current time */
 	clock_gettime(par->clock, &now);
 
@@ -756,6 +882,162 @@ void *timerthread(void *param)
 	}
 
 	stat->threadstarted++;
+	while (!shutdown && stat->num_t1) {
+
+		uint64_t diff;
+		int sigs, ret;
+		int temp = 0;
+		generate_load(stat->num_t1, &stat->done_t1, &temp);
+
+		/* Wait for next period */
+		switch (par->mode) {
+		case MODE_CYCLIC:
+		case MODE_SYS_ITIMER:
+			if (sigwait(&sigset, &sigs) < 0)
+				goto out;
+			break;
+
+		case MODE_CLOCK_NANOSLEEP:
+			if (par->timermode == TIMER_ABSTIME) {
+				ret = clock_nanosleep(par->clock,
+					TIMER_ABSTIME, &next, NULL);
+				if (ret) {
+					if (ret != EINTR) {
+						warn("clock_nanosleep failed %s"
+							, strerror(errno));
+					}
+					goto out;
+				}
+			} else {
+				ret = clock_gettime(par->clock, &now);
+				if (ret) {
+					if (ret != EINTR)
+						warn("clock_gettime failed %s"
+							, strerror(errno));
+					goto out;
+				}
+				/*
+				 * If simulated load, sleep should be for
+				 * reduced interval
+				 */
+				ret = clock_nanosleep(par->clock,
+						TIMER_RELTIME,
+						&reduced_interval, NULL);
+				if (ret) {
+					if (ret != EINTR)
+						warn("clock_nanosleep failed %s"
+							, strerror(errno));
+					goto out;
+				}
+				next.tv_sec = now.tv_sec +
+						reduced_interval.tv_sec;
+				next.tv_nsec = now.tv_nsec +
+						reduced_interval.tv_nsec;
+				tsnorm(&next);
+			}
+			break;
+
+		case MODE_SYS_NANOSLEEP:
+			ret = clock_gettime(par->clock, &now);
+			if (ret) {
+				if (ret != EINTR)
+					warn("clock_gettime() failed: %s",
+							strerror(errno));
+				goto out;
+			}
+			/*
+			 * If simulated load, sleep should be for
+			 * reduced interval
+			 */
+			if (nanosleep(&reduced_interval, NULL)) {
+				if (errno != EINTR)
+					warn("nanosleep failed. errno: %s\n",
+							strerror(errno));
+				goto out;
+			}
+			next.tv_sec = now.tv_sec + reduced_interval.tv_sec;
+			next.tv_nsec = now.tv_nsec + reduced_interval.tv_nsec;
+			tsnorm(&next);
+			break;
+		}
+
+		ret = clock_gettime(par->clock, &now);
+		if (ret) {
+			if (ret != EINTR)
+				warn("clock_getttime() failed. errno: %s\n",
+							strerror(errno));
+			goto out;
+		}
+
+		if (use_nsecs)
+			diff = calcdiff_ns(now, next);
+		else
+			diff = calcdiff(now, next);
+		if (diff < stat->min)
+			stat->min = diff;
+		if (diff > stat->max) {
+			stat->max = diff;
+			if (refresh_on_max)
+				pthread_cond_signal(&refresh_on_max_cond);
+		}
+		stat->avg += (double) diff;
+
+		if (duration && (calcdiff(now, stop) >= 0))
+			shutdown++;
+
+		if (!stopped && tracelimit && (diff > tracelimit)) {
+			stopped++;
+			tracing(0);
+			shutdown++;
+			pthread_mutex_lock(&break_thread_id_lock);
+			if (break_thread_id == 0)
+				break_thread_id = stat->tid;
+			break_thread_value = diff;
+			pthread_mutex_unlock(&break_thread_id_lock);
+		}
+		stat->act = diff;
+
+		if (par->bufmsk)
+			stat->values[stat->cycles & par->bufmsk] = diff;
+
+		/* Update the histogram */
+		if (histogram) {
+			if (diff >= histogram)
+				stat->hist_overflow++;
+			else
+				stat->hist_array[diff]++;
+		}
+
+		stat->cycles++;
+
+		next.tv_sec += interval.tv_sec;
+		next.tv_nsec += interval.tv_nsec;
+		if (par->mode == MODE_CYCLIC) {
+			int overrun_count = timer_getoverrun(timer);
+			next.tv_sec += overrun_count * interval.tv_sec;
+			next.tv_nsec += overrun_count * interval.tv_nsec;
+		}
+		tsnorm(&next);
+		stat->avg_t1 += (double)((stat->done_t1 * 100)/stat->num_t1);
+		/*undone load will be discarded in next window*/
+		stat->done_t1 = 0;
+
+		if (stat->num_t2) {
+			stat->avg_t2 += (double)((stat->done_t2 * 100)/
+							stat->num_t2);
+			stat->done_t2 = 0;
+			/*
+			 *flag to intimade load2_thread that next window
+			 *has started
+			 */
+			if (!stat->next_window_started) {
+				stat->next_window_started = 1;
+				sem_post(&stat->next_window_sem);
+			}
+		}
+		if (par->max_cycles && par->max_cycles == stat->cycles)
+			break;
+	}
 
 	while (!shutdown) {
 
@@ -867,6 +1149,17 @@ void *timerthread(void *param)
 		}
 		tsnorm(&next);
 
+		if (load_t2) {
+			stat->avg_t2 += (double)((stat->done_t2 * 100)/
+							stat->num_t2);
+			stat->done_t2 = 0;
+			/*
+			 *flag to intimade load2_thread that next window
+			 *has started
+			 */
+			stat->next_window_started = 1;
+			sem_post(&stat->next_window_sem);
+		}
 		if (par->max_cycles && par->max_cycles == stat->cycles)
 			break;
 	}
@@ -888,6 +1181,8 @@ out:
 	sched_setscheduler(0, SCHED_OTHER, &schedp);
 
 	stat->threadstarted = -1;
+	if (load_t2)
+		sem_destroy(&stat->next_window_sem);
 
 	return NULL;
 }
@@ -959,6 +1254,10 @@ static void display_help(int error)
                "                           format: --policy=fifo(default) or --policy=rr\n"
 	       "-S       --smp             Standard SMP testing: options -a -t -n and\n"
                "                           same priority of all threads\n"
+	       "-x       --load_t1         load in percentage for load1_thread\n"
+	       "-X       --load_t2         load in percentage for load2_thread\n"
+	       "-z       --priority_t2     priority of load2_thread\n"
+	       "-Z       --nice_t2         nice value of load2_thread\n"
 	       "-U       --numa            Standard NUMA testing (similar to SMP option)\n"
                "                           thread data structures allocated from local node\n",
 	       tracers
@@ -987,7 +1286,7 @@ enum {
 	AFFINITY_SPECIFIED,
 	AFFINITY_USEALL
 };
-static int setaffinity = AFFINITY_UNSPECIFIED;
+static int setaffinity = AFFINITY_USEALL;
 
 static int clocksources[] = {
 	CLOCK_MONOTONIC,
@@ -1083,10 +1382,15 @@ static void process_options (int argc, char *argv[])
 			{"numa", no_argument, NULL, 'U'},
 			{"latency", required_argument, NULL, 'e'},
 			{"priospread", no_argument, NULL, 'Q'},
+			{"load_t1", required_argument, NULL, 'x'},
+			{"load_t2", required_argument, NULL, 'X'},
+			{"priority_t2", required_argument, NULL, 'z'},
+			{"nice_t2", required_argument, NULL, 'Z'},
 			{NULL, 0, NULL, 0}
 		};
-		int c = getopt_long(argc, argv, "a::b:Bc:Cd:Efh:H:i:Il:MnNo:O:p:PmqQrsSt::uUvD:wWT:y:e:",
-				    long_options, &option_index);
+		int c = getopt_long(argc, argv,
+				"a::b:Bc:Cd:Efh:H:i:Il:MnNo:O:p:PmqQrsSt::uUvD:wWT:y:e:x:X:z:Z:"
+				    , long_options, &option_index);
 		if (c == -1)
 			break;
 		switch (c) {
@@ -1200,7 +1504,18 @@ static void process_options (int argc, char *argv[])
 			if (latency_target_value < 0)
 				latency_target_value = 0;
 			break;
-
+		case 'x':
+			load_t1 = atoi(optarg);
+			break;
+		case 'X':
+			load_t2 = atoi(optarg);
+			break;
+		case 'z':
+			priority_t2 = atoi(optarg);
+			break;
+		case 'Z':
+			nice_t2 = atoi(optarg);
+			break;
 		case '?': display_help(0); break;
 		}
 	}
@@ -1221,6 +1536,9 @@ static void process_options (int argc, char *argv[])
 			    affinity, max_cpus);
 			error = 1;
 		}
+	} else if (setaffinity == AFFINITY_UNSPECIFIED) {
+		warn("thread affinity can't be unspecified for cyclicload\n");
+		error = 1;
 	} else if (tracelimit)
 		fileprefix = procfileprefix;
 
@@ -1268,6 +1586,15 @@ static void process_options (int argc, char *argv[])
 
 	if (num_threads < 1)
 		error = 1;
+	/*1% load has been reserved for control framework*/
+	if ((load_t1 + load_t2) > 99) {
+		fprintf(stderr, "load can't be greater than 99%\n");
+		error = 1;
+	}
+	if (priority_t2 < 0 || priority_t2 > priority) {
+		fprintf(stderr, "incorrect priority_t2\n");
+		error = 1;
+	}
 
 	if (error)
 		display_help(1);
@@ -1344,6 +1671,7 @@ static void print_hist(struct thread_param *par[], int nthreads)
 	int i, j;
 	unsigned long long int log_entries[nthreads+1];
 	unsigned long maxmax, alloverflows;
+	unsigned long load2_cycles;
 
 	bzero(log_entries, sizeof(log_entries));
 
@@ -1401,6 +1729,24 @@ static void print_hist(struct thread_param *par[], int nthreads)
 	if (histofall && nthreads > 1)
 		printf(" %05lu", alloverflows);
 	printf("\n");
+	if (load_t1) {
+		printf("# Avg Load t1");
+		for (j = 0; j < nthreads; j++)
+			printf(" %05lu", par[j]->stats->cycles ?
+			(long)(par[j]->stats->avg_t1/par[j]->stats->cycles) :
+			0);
+		printf("\n");
+	}
+	if (load_t1) {
+		printf("# Avg Load t2");
+		for (j = 0; j < nthreads; j++) {
+			load2_cycles = par[j]->stats->cycles -
+					par[j]->stats->load2_start;
+			printf(" %05lu", load2_cycles ?
+			(long)(par[j]->stats->avg_t2/load2_cycles) : 0);
+		}
+		printf("\n");
+	}
 }
 
 static void print_stat(struct thread_param *par, int index, int verbose) @@ -1410,6 +1756,8 @@ static void print_stat(struct thread_param *par, int index, int verbose)
 	if (!verbose) {
 		if (quiet != 1) {
 			char *fmt;
+			unsigned long load2_cycles =
+					stat->cycles - stat->load2_start;
 			if (use_nsecs)
                                 fmt = "T:%2d (%5d) P:%2d I:%ld C:%7lu "
 					"Min:%7ld Act:%8ld Avg:%8ld Max:%8ld\n"; @@ -1420,6 +1768,18 @@ static void print_stat(struct thread_param *par, int index, int verbose)
                                par->interval, stat->cycles, stat->min, stat->act,
 			       stat->cycles ?
 			       (long)(stat->avg/stat->cycles) : 0, stat->max);
+			if (load_t1)
+				printf("\tAvgload1:%2ld.%2d\n",
+					stat->cycles ?
+					(long)(stat->avg_t1/stat->cycles) : 0,
+					stat->cycles ?
+					((long)stat->avg_t1%stat->cycles) : 0);
+			if (load_t2)
+				printf("\tAvgload2:%2ld.%2d\n",
+					load2_cycles ?
+					(long)(stat->avg_t2/load2_cycles) : 0,
+					load2_cycles ?
+					(long)stat->avg_t2%load2_cycles : 0);
 		}
 	} else {
 		while (stat->cycles != stat->cyclesread) { @@ -1441,6 +1801,125 @@ static void print_stat(struct thread_param *par, int index, int verbose)
 	}
 }
 
+int calibrate_count_per_unit(int interval_per_unit) {
+	int diff = 1, x = 0;
+	struct timespec start, end;
+	int i, clock, k = 0, ret;
+	int count = 1;
+	int temp = 0;
+	int flag = 0;
+	int min = -1;
+
+	clock = clocksources[clocksel];
+
+	/*interval_per)unit is in us*/
+	if (use_nsecs)
+		interval_per_unit = interval_per_unit * 1000;
+
+	/*calculate minimum of 10 iterations
+	 *to get least count to generate a particular load
+	 */
+	for (i = 0 ; i < 10 ; i++) {
+		count = 1;
+		diff = 1;
+		x = 0;
+		while (diff < interval_per_unit) {
+			count *= 10;
+			x++;
+			ret = clock_gettime(clock, &start);
+			if (ret) {
+				if (ret != EINTR)
+					warn("clock_gettime() failed: %s",
+						strerror(errno));
+				return -1;
+			}
+			generate_load(count, &temp, &flag);
+			ret = clock_gettime(clock, &end);
+			if (ret) {
+				if (ret != EINTR)
+					warn("clock_gettime() failed: %s",
+						strerror(errno));
+				return -1;
+			}
+			if (use_nsecs)
+				diff = (calcdiff_ns(end, start));
+			else
+				diff = (calcdiff(end, start));
+		}
+		k = count;
+		while ((x > 0) && (diff != interval_per_unit) && (k != 0)) {
+			x--;
+			count += k;
+			k /= 10;
+			do {
+				count -= k;
+				ret = clock_gettime(clock, &start);
+				if (ret) {
+					if (ret != EINTR)
+						warn("clock_gettime() failed:%s"
+							, strerror(errno));
+					return -1;
+				}
+				generate_load(count, &temp, &flag);
+				ret = clock_gettime(clock, &end);
+				if (ret) {
+					if (ret != EINTR)
+						warn("clock_gettime() failed:%s"
+							, strerror(errno));
+					return -1;
+				}
+				if (use_nsecs)
+					diff = (calcdiff_ns(end, start));
+				else
+					diff = (calcdiff(end, start));
+			} while (diff > interval_per_unit);
+		}
+
+		if (diff != interval_per_unit)
+			count = (count * interval_per_unit)/diff;
+
+		if (i == 0)
+			min = count;
+		if (count < min)
+			min = count;
+	}
+	return min;
+}
+
+/*
+ * thread to calibrate data i.e. loop count per unit time
+ * for multicore system, thread affine itslef to each core
+ * turn by turn to calibrate count for that core  */ void 
+*calibrate_thread(void *arg) {
+	struct sched_param schedp;
+	int max_cpus = sysconf(_SC_NPROCESSORS_CONF);
+	int i = 0;
+
+	/*should be run at highest RT priority for proper caliberation*/
+	memset(&schedp, 0, sizeof(schedp));
+	schedp.sched_priority = 99;
+	sched_setscheduler(0, SCHED_FIFO, &schedp);
+
+	/*For multicore system, do caliberation for all CPUs*/
+	for (i = 0; i < max_cpus; i++) {
+		cpu_set_t mask;
+		CPU_ZERO(&mask);
+		CPU_SET(i, &mask);
+		if (sched_setaffinity(0, sizeof(mask), &mask) == -1)
+			warn("Could not set CPU affinity to CPU #%d\n", i);
+
+		/*caliberation count is maintained per CALIBRATE_COUNT_TIME*/
+		calibrate_count_array[i] =
+			calibrate_count_per_unit(CALIBRATE_COUNT_TIME);
+		if (calibrate_count_array[i] == -1)
+			warn("Could not set set calibrate for CPU #%d\n", i);
+	}
+	return NULL;
+}
+
 int main(int argc, char **argv)
 {
 	sigset_t sigset;
@@ -1451,6 +1930,8 @@ int main(int argc, char **argv)
 	int max_cpus = sysconf(_SC_NPROCESSORS_CONF);
 	int i, ret = -1;
 	int status;
+	pthread_t calibrate_thread_id;
+	FILE *fp;
 
 	process_options(argc, argv);
 
@@ -1495,6 +1976,44 @@ int main(int argc, char **argv)
 	statistics = calloc(num_threads, sizeof(struct thread_stat *));
 	if (!statistics)
 		goto outpar;
+	/*
+	 *For first run:
+	 *		create file
+	 *		Calibrate count per time unit & store in file
+	 *for subsequent run:
+	 *		read calibrated data from file & use
+	 */
+	fp = fopen(FILENAME, "r");
+	if (!fp) {
+		int val = 0;
+		fp = fopen(FILENAME, "w");
+		if (!fp)
+			goto outpar;
+		printf("Calibrating data\n");
+		/* create thread to calibrate count for each cpu*/
+		status = pthread_create(&calibrate_thread_id,
+				NULL, calibrate_thread, NULL);
+		if (status) {
+			fatal("failed to create thread %s\n", strerror(status));
+			goto outfile;
+		}
+		printf("Be patient, it will take some time in the first run\n");
+		printf("It is recommended to run for the first run ");
+		printf("with least load for proper caliberation\n");
+		/*wait for all threads to exit*/
+		status = pthread_join(calibrate_thread_id, (void *)&val);
+		if (status) {
+			fatal("failed in pthread_join %s\n", strerror(status));
+			goto outfile;
+		}
+		/*story array into file*/
+		fwrite(calibrate_count_array,
+			sizeof(calibrate_count_array), 1, fp);
+		printf("Calibration completed\n");
+	} else {
+		/*read from array*/
+		fread(calibrate_count_array, sizeof(int), MAX_CORES, fp);
+	}
 
 	for (i = 0; i < num_threads; i++) {
 		pthread_attr_t attr;
@@ -1593,6 +2112,13 @@ int main(int argc, char **argv)
 		stat->min = 1000000;
 		stat->max = 0;
 		stat->avg = 0.0;
+		stat->avg_t1 = 0.0;
+		stat->avg_t2 = 0.0;
+		stat->num_t1 = 0;
+		stat->num_t2 = 0;
+		stat->done_t1 = 0;
+		stat->done_t2 = 0;
+		stat->next_window_started = 1;
 		stat->threadstarted = 1;
 		status = pthread_create(&stat->thread, &attr, timerthread, par);
 		if (status)
@@ -1657,6 +2183,8 @@ int main(int argc, char **argv)
 	for (i = 0; i < num_threads; i++) {
 		if (statistics[i]->threadstarted > 0)
 			pthread_kill(statistics[i]->thread, SIGTERM);
+		if (statistics[i]->threadt2_started > 0)
+			pthread_kill(statistics[i]->thread_t2, SIGTERM);
 		if (statistics[i]->threadstarted) {
 			pthread_join(statistics[i]->thread, NULL);
 			if (quiet && !histogram)
@@ -1686,6 +2214,8 @@ int main(int argc, char **argv)
 			continue;
 		threadfree(statistics[i], sizeof(struct thread_stat), parameters[i]->node);
 	}
+ outfile:
+	fclose(fp);
 
  outpar:
 	for (i = 0; i < num_threads; i++) {
--
1.7.4.1



