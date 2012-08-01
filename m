From: Priyanka Jain <Priyanka.Jain@freescale.com>
Subject: [PATCH 2/2][RFC] Add cyclicload code
Date: Wed, 1 Aug 2012 10:37:48 +0530
Message-ID: <1343797668-10241-1-git-send-email-Priyanka.Jain@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <rostedt@goodmis.org>, <tglx@linutronix.de>,
	<Rajan.Srivastava@freescale.com>, <Poonam.Aggrwal@freescale.com>,
	Priyanka Jain <Priyanka.Jain@freescale.com>
To: <linux-rt-users@vger.kernel.org>, <williams@redhat.com>,
	<dvhart@linux.intel.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ch1ehsobe004.messaging.microsoft.com ([216.32.181.184]:5638
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751335Ab2HAFII (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 1 Aug 2012 01:08:08 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Add cyclicload code to existing opensource
rt-utils/cyclictest application.

Cyclicload program is designed to simulate load
at regular intervals in form of one or two threads.

Signed-off-by: Priyanka Jain <Priyanka.Jain@freescale.com>
---
 Developed against 
	git://git.kernel.org/pub/scm/linux/kernel/git/clrkwllms/rt-tests.git
	commitID: 857cdd5320ce1f293f5dbcbec79cc8fe22b0bebf

 Currently developed as patch above cyclictest application.
 May be maintained as separate application in rt-utils based
 on suggestion.

 src/cyclictest/cyclictest.c |  386 ++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 385 insertions(+), 1 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 11b6cea..0f5ba4c 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -4,6 +4,9 @@
  * (C) 2008-2012 Clark Williams <williams@redhat.com>
  * (C) 2005-2007 Thomas Gleixner <tglx@linutronix.de>
  *
+ * (C) 2012 Priyanka Jain <Priyanka.Jain@freescale.com>
+ * Add cyclicload code
+ *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License Version
  * 2 as published by the Free Software Foundation.
@@ -47,7 +50,7 @@
 #ifndef SCHED_NORMAL
 #define SCHED_NORMAL SCHED_OTHER
 #endif
-
+#define CYCLICLOAD
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
 
 /* Ugly, but .... */
@@ -157,6 +160,17 @@ struct thread_stat {
 	long redmax;
 	long cycleofmax;
 	long hist_overflow;
+#ifdef CYCLICLOAD
+	pthread_t thread_t2;
+	int threadt2_started;
+	int avg_t1;
+	int avg_t2;
+	int done_t1;
+	int done_t2;
+	int num_t1;
+	int num_t2;
+	int next_window_started;
+#endif
 };
 
 static int shutdown;
@@ -174,6 +188,20 @@ static int use_nsecs = 0;
 static int refresh_on_max;
 static int force_sched_other;
 static int priospread = 0;
+#ifdef CYCLICLOAD
+static int load_t1 = 60;
+static int load_t2 = 20;
+static int priority_t2 = 49;	/* default policy if not specified */
+static int nice_t2 = -15;	/* default policy if not specified */
+#define MAX_CORES 8
+#define FILENAME "caliberate_count"
+
+static pthread_cond_t next_window_start_cond = PTHREAD_COND_INITIALIZER;
+static pthread_mutex_t next_window_lock = PTHREAD_MUTEX_INITIALIZER;
+/*caliberation count in microseond*/
+#define CALIBERATE_COUNT_TIME 1000
+static int caliberate_count_array[MAX_CORES];
+#endif
 
 static pthread_cond_t refresh_on_max_cond = PTHREAD_COND_INITIALIZER;
 static pthread_mutex_t refresh_on_max_lock = PTHREAD_MUTEX_INITIALIZER;
@@ -662,6 +690,72 @@ try_again:
 	return err;
 }
 
+#ifdef CYCLICLOAD
+static inline void generate_load(int loops, int *done, int *next_window)
+{
+	/*initializing with some random values*/
+	/*use volatile to prevent compiler from optimizing */
+	volatile int a = 144;
+	int b = 193, c = 182, d = 987;
+	while ((loops-- > 0) && (*next_window == 0)) {
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
+	while (!shutdown) {
+		pthread_mutex_lock(&next_window_lock);
+		stat->next_window_started = 0;
+		pthread_mutex_unlock(&next_window_lock);
+		generate_load(stat->num_t2,  &stat->done_t2,
+			&(stat->next_window_started));
+
+		/* wait for next window*/
+		pthread_mutex_lock(&next_window_lock);
+		while (!stat->next_window_started)
+			pthread_cond_wait(&next_window_start_cond,
+				  &next_window_lock);
+		pthread_mutex_unlock(&next_window_lock);
+	}
+	stat->threadt2_started = -1;
+	return NULL;
+}
+#endif
+
 /*
  * timer thread
  *
@@ -688,6 +782,10 @@ void *timerthread(void *param)
 	int stopped = 0;
 	cpu_set_t mask;
 	pthread_t thread;
+#ifdef CYCLICLOAD
+	struct timespec reduced_interval;
+	int status;
+#endif
 
 	/* if we're running in numa mode, set our memory node */
 	if (par->node != -1)
@@ -704,6 +802,15 @@ void *timerthread(void *param)
 	interval.tv_sec = par->interval / USEC_PER_SEC;
 	interval.tv_nsec = (par->interval % USEC_PER_SEC) * 1000;
 
+#ifdef CYCLICLOAD
+	if (load_t1 || load_t2) {
+		int red_interval = par->interval * (100 - load_t1) / 100;
+		/*If simulated load, sleep should be for reduced interval*/
+		reduced_interval.tv_sec = red_interval / USEC_PER_SEC;
+		reduced_interval.tv_nsec = (red_interval % USEC_PER_SEC) *
+						1000;
+	}
+#endif
 	stat->tid = gettid();
 
 	sigemptyset(&sigset);
@@ -723,6 +830,22 @@ void *timerthread(void *param)
 	if (setscheduler(0, par->policy, &schedp)) 
 		fatal("timerthread%d: failed to set priority to %d\n", par->cpu, par->prio);
 
+#ifdef CYCLICLOAD
+	if (load_t1)
+		stat->num_t1 = (caliberate_count_array[par->cpu] *
+			(load_t1 * par->interval/100))/CALIBERATE_COUNT_TIME;
+	if (load_t2) {
+		stat->num_t2 = (caliberate_count_array[par->cpu] *
+			(load_t2 * par->interval/100))/CALIBERATE_COUNT_TIME;
+		stat->threadt2_started++;
+		status = pthread_create(&stat->thread_t2, NULL, load2_thread,
+			par);
+		if (status)
+			fatal("failed to create load thread %s\n",
+				strerror(status));
+	}
+#endif
+
 	/* Get current time */
 	clock_gettime(par->clock, &now);
 
@@ -761,6 +884,19 @@ void *timerthread(void *param)
 
 		uint64_t diff;
 		int sigs, ret;
+#ifdef CYCLICLOAD
+		int temp = 0;
+		ret = clock_gettime(par->clock, &now);
+		if (ret) {
+			if (ret != EINTR)
+				warn("clock_gettime() failed: %s",
+					strerror(errno));
+			goto out;
+		}
+		/*loop for load t1*/
+		if (load_t1)
+			generate_load(stat->num_t1, &stat->done_t1, &temp);
+#endif
 
 		/* Wait for next period */
 		switch (par->mode) {
@@ -778,6 +914,16 @@ void *timerthread(void *param)
 					goto out;
 				}
 			} else {
+#ifdef CYCLICLOAD
+				ret = clock_nanosleep(par->clock, TIMER_RELTIME,
+					&reduced_interval, NULL);
+				if (ret) {
+					if (ret != EINTR)
+						warn("clock_nanosleeep fail");
+						warn("errno: %d\n", errno);
+					goto out;
+				}
+#else
 				if ((ret = clock_gettime(par->clock, &now))) {
 					if (ret != EINTR)
 						warn("clock_gettime() failed: %s", strerror(errno));
@@ -788,6 +934,7 @@ void *timerthread(void *param)
 						warn("clock_nanosleep() failed. errno: %d\n", errno);
 					goto out;
 				}
+#endif
 				next.tv_sec = now.tv_sec + interval.tv_sec;
 				next.tv_nsec = now.tv_nsec + interval.tv_nsec;
 				tsnorm(&next);
@@ -795,6 +942,14 @@ void *timerthread(void *param)
 			break;
 
 		case MODE_SYS_NANOSLEEP:
+#ifdef CYCLICLOAD
+			if (nanosleep(&reduced_interval, NULL)) {
+				if (errno != EINTR)
+					warn("nanosleep failed. errno: %d\n",
+					errno);
+				goto out;
+			}
+#else
 			if ((ret = clock_gettime(par->clock, &now))) {
 				if (ret != EINTR)
 					warn("clock_gettime() failed: errno %d\n", errno);
@@ -805,6 +960,7 @@ void *timerthread(void *param)
 					warn("nanosleep failed. errno: %d\n", errno);
 				goto out;
 			}
+#endif
 			next.tv_sec = now.tv_sec + interval.tv_sec;
 			next.tv_nsec = now.tv_nsec + interval.tv_nsec;
 			tsnorm(&next);
@@ -869,6 +1025,30 @@ void *timerthread(void *param)
 
 		if (par->max_cycles && par->max_cycles == stat->cycles)
 			break;
+#ifdef CYCLICLOAD
+		pthread_mutex_lock(&next_window_lock);
+		if (load_t1)
+			stat->avg_t1 = ((stat->avg_t1 * (stat->cycles - 1)) +
+				((stat->done_t1 * 100)/stat->num_t1))/
+				(stat->cycles);
+		if (load_t2)
+			stat->avg_t2 = ((stat->avg_t2 * (stat->cycles - 1)) +
+				((stat->done_t2 * 100)/stat->num_t2))/
+				stat->cycles;
+
+		/*undone load will be discarded in next window*/
+		stat->done_t1 = 0;
+		stat->done_t2 = 0;
+		if (load_t2) {
+			/*
+			 *flag to intimade load2_thread that next window
+			 *has started
+			 */
+			stat->next_window_started = 1;
+			pthread_cond_signal(&next_window_start_cond);
+			pthread_mutex_unlock(&next_window_lock);
+		}
+#endif
 	}
 
 out:
@@ -959,6 +1139,12 @@ static void display_help(int error)
                "                           format: --policy=fifo(default) or --policy=rr\n"
 	       "-S       --smp             Standard SMP testing: options -a -t -n and\n"
                "                           same priority of all threads\n"
+#ifdef CYCLICLOAD
+	       "-x       --load_t1         load in percentage for t1 thread\n"
+	       "-X       --load_t2         load in percentage for t2 thread\n"
+	       "-z       --priority_t2     priority of t2 thread\n"
+	       "-Z       --nice_t2         nice value of t2 thread\n"
+#endif
 	       "-U       --numa            Standard NUMA testing (similar to SMP option)\n"
                "                           thread data structures allocated from local node\n",
 	       tracers
@@ -1083,10 +1269,22 @@ static void process_options (int argc, char *argv[])
 			{"numa", no_argument, NULL, 'U'},
 			{"latency", required_argument, NULL, 'e'},
 			{"priospread", no_argument, NULL, 'Q'},
+#ifdef CYCLICLOAD
+			{"load_t1", required_argument, NULL, 'x'},
+			{"load_t2", required_argument, NULL, 'X'},
+			{"priority_t2", required_argument, NULL, 'z'},
+			{"nice_t2", required_argument, NULL, 'Z'},
+#endif
 			{NULL, 0, NULL, 0}
 		};
+#ifdef CYCLICLOAD
+		int c = getopt_long(argc, argv,
+				"a::b:Bc:Cd:Efh:H:i:Il:MnNo:O:p:PmqQrsSt::uUvD:wWT:y:e:x:X:z:Z:"
+				    , long_options, &option_index);
+#else
 		int c = getopt_long(argc, argv, "a::b:Bc:Cd:Efh:H:i:Il:MnNo:O:p:PmqQrsSt::uUvD:wWT:y:e:",
 				    long_options, &option_index);
+#endif
 		if (c == -1)
 			break;
 		switch (c) {
@@ -1200,6 +1398,20 @@ static void process_options (int argc, char *argv[])
 			if (latency_target_value < 0)
 				latency_target_value = 0;
 			break;
+#ifdef CYCLICLOAD
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
+#endif
 
 		case '?': display_help(0); break;
 		}
@@ -1441,6 +1653,127 @@ static void print_stat(struct thread_param *par, int index, int verbose)
 	}
 }
 
+#ifdef CYCLICLOAD
+int caliberate_count_per_unit(int interval_per_unit)
+{
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
+ * thread to caliberate data i.e. loop count per unit time
+ * for multicore system, thread affine itslef to each core
+ * turn by turn to caliberate count for that core
+ */
+void *caliberate_thread(void *arg)
+{
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
+		/*caliberation count is maintained per CALIBERATE_COUNT_TIME*/
+		caliberate_count_array[i] =
+			caliberate_count_per_unit(CALIBERATE_COUNT_TIME);
+		if (caliberate_count_array[i] == -1)
+			warn("Could not set set caliberate for CPU #%d\n", i);
+	}
+	return NULL;
+}
+#endif
+
 int main(int argc, char **argv)
 {
 	sigset_t sigset;
@@ -1451,6 +1784,10 @@ int main(int argc, char **argv)
 	int max_cpus = sysconf(_SC_NPROCESSORS_CONF);
 	int i, ret = -1;
 	int status;
+#ifdef CYCLICLOAD
+	pthread_t caliberate_thread_id;
+	FILE *fp;
+#endif
 
 	process_options(argc, argv);
 
@@ -1495,6 +1832,45 @@ int main(int argc, char **argv)
 	statistics = calloc(num_threads, sizeof(struct thread_stat *));
 	if (!statistics)
 		goto outpar;
+#ifdef CYCLICLOAD
+	/*
+	 *For first run:
+	 *		create file
+	 *		Caliberate count per time unit & store in file
+	 *for subsequent run: read caliberated data from file & use
+	 */
+	fp = fopen(FILENAME, "r");
+	if (!fp) {
+		int val = 0;
+		fp = fopen(FILENAME, "w");
+		if (!fp)
+			goto outpar;
+		printf("Caliberating data\n");
+		/* create thread to caliberate count for each cpu*/
+		status = pthread_create(&caliberate_thread_id,
+				NULL, caliberate_thread, NULL);
+		if (status) {
+			fatal("failed to create thread %s\n", strerror(status));
+			goto outfile;
+		}
+		printf("Be patient, it will take some time in the first run\n");
+		printf("It is recommended to run for the first run ");
+		printf("with least load for proper caliberation\n");
+		/*wait for all threads to exit*/
+		status = pthread_join(caliberate_thread_id, (void *)&val);
+		if (status) {
+			fatal("failed to create thread %s\n", strerror(status));
+			goto outfile;
+		}
+		/*story array into file*/
+		printf("writing caliberation data to file\n");
+		fwrite(caliberate_count_array,
+			sizeof(caliberate_count_array), 1, fp);
+	} else {
+		/*read from array*/
+		fread(caliberate_count_array, sizeof(int), MAX_CORES, fp);
+	}
+#endif
 
 	for (i = 0; i < num_threads; i++) {
 		pthread_attr_t attr;
@@ -1657,6 +2033,10 @@ int main(int argc, char **argv)
 	for (i = 0; i < num_threads; i++) {
 		if (statistics[i]->threadstarted > 0)
 			pthread_kill(statistics[i]->thread, SIGTERM);
+#ifdef CYCLICLOAD
+		if (statistics[i]->threadt2_started > 0)
+			pthread_kill(statistics[i]->thread_t2, SIGTERM);
+#endif
 		if (statistics[i]->threadstarted) {
 			pthread_join(statistics[i]->thread, NULL);
 			if (quiet && !histogram)
@@ -1686,6 +2066,10 @@ int main(int argc, char **argv)
 			continue;
 		threadfree(statistics[i], sizeof(struct thread_stat), parameters[i]->node);
 	}
+#ifdef CYCLICLOAD
+ outfile:
+	fclose(fp);
+#endif
 
  outpar:
 	for (i = 0; i < num_threads; i++) {
-- 
1.7.4.1



