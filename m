From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 2/3] Convert C99 commenting style to C89 style
Date: Tue, 15 Sep 2009 10:23:47 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.0909151021110.4591@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: williams@redhat.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:29330 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756600AbZIOIXs (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 15 Sep 2009 04:23:48 -0400
Received: from int-mx03.intmail.prod.int.phx2.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id n8F8Npqn020659
	for <linux-rt-users@vger.kernel.org>; Tue, 15 Sep 2009 04:23:52 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

>From 1aea888e3fa49d69b4b85e3388756318eb2ecd90 Mon Sep 17 00:00:00 2001
From: John Kacur <jkacur@redhat.com>
Date: Mon, 14 Sep 2009 19:00:05 +0200
Subject: [PATCH] Convert C99 commenting style to C89 style, like in the linux kernel.

Convert C99 commenting style to C89 style, like in the linux kernel.
When multiple people start working on a program, it is good when it has
a consistent style. I suggest we use the linux kernel coding style. We don't
have to follow it quite as religiously as the kernel - but it's a good start.
---
 src/pi_tests/pi_stress.c |  166 ++++++++++++++++++++++++----------------------
 1 files changed, 87 insertions(+), 79 deletions(-)

diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
index c6b9175..c250d47 100644
--- a/src/pi_tests/pi_stress.c
+++ b/src/pi_tests/pi_stress.c
@@ -38,7 +38,8 @@
 
    That's the theory, anyway...
 
-   CW - 2006  */
+   CW - 2006
+ */
 
 #include <stdio.h>
 #include <errno.h>
@@ -55,10 +56,10 @@
 #include <sys/wait.h>
 #include <termios.h>
 
-// version
+/* version */
 const char *version = "pi_stress v" VERSION_STRING " (" __DATE__ " " __TIME__ ")";
 
-// conversions
+/* conversions */
 #define USEC_PER_SEC	1000000
 #define NSEC_PER_SEC	1000000000
 #define USEC_TO_NSEC(u) ((u) * 1000)
@@ -84,55 +85,56 @@ const char *version = "pi_stress v" VERSION_STRING " (" __DATE__ " " __TIME__ ")
 #define SUCCESS 0
 #define FAILURE 1
 
-// cursor control
+/* cursor control */
 #define UP_ONE "\033[1A"
 #define DOWN_ONE "\033[1B"
 
-// the length of the test
-// default is infinite
+/* the length of the test, default = -1 (infinite) */
 int duration = -1;
 
-// times for starting and finishing the stress test
+/* times for starting and finishing the stress test */
 time_t start, finish;
 
-// the number of groups to create
+/* the number of groups to create */
 int ngroups = 0;
 
-// the number of times a group causes a priority inversion situation
-// default to infinite
+/*
+ * the number of times a group causes a priority inversion situation
+ * default to infinite
+ */
 int inversions = -1;
 
-// turn on lots of prints
+/* turn on lots of prints */
 int verbose = 0;
 
-// turn on debugging prints
+/* turn on debugging prints */
 int debugging = 0;
 
-// turn off all prints
+/* turn off all prints */
 int quiet = 0;
 
-// prompt to start test
+/* prompt to start test */
 int prompt = 0;
 
-// report interval
+/* report interval */
 unsigned long report_interval = (unsigned long) SEC_TO_USEC(0.75);
 
-// global that indicates we should shut down
+/* global that indicates we should shut down */
 volatile int shutdown = 0;
 
-// indicate if errors have occured
+/* indicate if errors have occured */
 int have_errors = 0;
 
-// indicated that keyboard interrupt has happened
+/* indicated that keyboard interrupt has happened */
 int interrupted = 0;
 
-// force running on one cpu
+/* force running on one cpu */
 int uniprocessor = 0;
 
-// lock all memory
+/* lock all memory */
 int lockall = 0;
 
-// command line options
+/* command line options */
 struct option options [] = {
 	{ "duration", required_argument, NULL, 't' },
 	{ "verbose", no_argument, NULL, 'v' },
@@ -150,7 +152,7 @@ struct option options [] = {
 	{ NULL, 0, NULL, 0},
 };
 
-// max priority for the scheduling policy
+/* max priority for the scheduling policy */
 int prio_min;
 
 /* define priorities for the threads */
@@ -173,24 +175,24 @@ int policy = SCHED_FIFO;
 
 struct group_parameters {
 
-	// group id (index)
+	/* group id (index) */
 	int id;
 
-	// cpu this group is bound to
+	/* cpu this group is bound to */
 	long cpu;
 
-	// threads in the group
+	/* threads in the group */
 	pthread_t low_tid;
 	pthread_t med_tid;
 	pthread_t high_tid;
 
-	// number of machine iterations to perform
+	/* number of machine iterations to perform */
 	int inversions;
 
-	// group mutex
+	/* group mutex */
 	pthread_mutex_t mutex;
 
-        // state barriers
+        /* state barriers */
 	pthread_barrier_t start_barrier;
 	pthread_barrier_t locked_barrier;
 	pthread_barrier_t elevate_barrier;
@@ -201,20 +203,20 @@ struct group_parameters {
 	pthread_mutex_t loop_mtx;	/* Protect access to int loop */
 	int loop;	/* boolean, loop or not, connected to shutdown */
 
-	// state variables
+	/* state variables */
 	volatile int high_has_run;
 	volatile int low_unlocked;
 	volatile int watchdog;
 
-	// total number of inversions performed
+	/* total number of inversions performed */
 	unsigned long total;
 
-	// total watchdog hits
+	/* total watchdog hits */
 	int watchdog_hits;
 
 } *groups;
 
-// number of consecutive watchdog hits before quitting
+// /* of consecutive watchdog hits before quitting */
 #define WATCHDOG_LIMIT 5
 
 /* number of online processors */
@@ -274,7 +276,7 @@ main (int argc, char **argv)
 			return FAILURE;
 		}
 
-	// boost main's priority (so we keep running) :)
+	/* boost main's priority (so we keep running) :) */
 	prio_min = sched_get_priority_min(policy);
 	thread_param.sched_priority = MAIN_PRIO();
 	status = pthread_setschedparam(pthread_self(), policy, &thread_param);
@@ -283,17 +285,17 @@ main (int argc, char **argv)
 		return FAILURE;
 	}
 
-	// block unwanted signals
+	/* block unwanted signals */
 	block_signals();
 
-	// allocate our groups array
+	/* allocate our groups array */
 	groups = calloc(ngroups, sizeof(struct group_parameters));
 	if (groups == NULL) {
 		error("main: failed to allocate %d groups\n", ngroups);
 		return FAILURE;
 	}
 
-	// set up CPU affinity masks
+	/* set up CPU affinity masks */
 	if (set_cpu_affinity(&test_cpu_mask, &admin_cpu_mask))
 		return FAILURE;
 
@@ -308,7 +310,7 @@ main (int argc, char **argv)
 	if (barrier_init(&all_threads_done, NULL, nthreads, "all_threads_done"))
 		return FAILURE;
 
-	// create the groups
+	/* create the groups */
 	info("Creating %d test groups\n", ngroups);
 	for (core = 0; core < num_processors; core++)
 		if (CPU_ISSET(core, &test_cpu_mask))
@@ -322,17 +324,17 @@ main (int argc, char **argv)
 			return FAILURE;
 	}
 
-	// prompt if requested
+	/* prompt if requested */
 	if (prompt) {
 		printf("Press return to start test: ");
 		getchar();
 	}
 
-	// report
+	/* report */
 	banner();
 	start = time(NULL);
 
-	// turn loose the threads
+	/* turn loose the threads */
 	info("Releasing all threads\n");
 	status = pthread_barrier_wait(&all_threads_ready);
 	if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
@@ -349,7 +351,7 @@ main (int argc, char **argv)
 	}
 	set_shutdown_flag();
 
-	// wait for all threads to notice the shutdown flag
+	/* wait for all threads to notice the shutdown flag */
 	if (have_errors == 0 && interrupted == 0) {
 		info("waiting for all threads to complete\n");
 		status = pthread_barrier_wait(&all_threads_done);
@@ -411,7 +413,7 @@ set_cpu_affinity(cpu_set_t *test_mask, cpu_set_t *admin_mask)
 	int status, i, admin_proc;
 	cpu_set_t current_mask;
 
-	// handle uniprocessor case
+	/* handle uniprocessor case */
 	if (num_processors == 1 || uniprocessor) {
 		CPU_ZERO(admin_mask);
 		CPU_ZERO(test_mask);
@@ -421,8 +423,10 @@ set_cpu_affinity(cpu_set_t *test_mask, cpu_set_t *admin_mask)
 		return SUCCESS;
 	}
 
-	// first set our main thread to run on the first
-	// scheduleable processor we can find
+	/*
+	 * first set our main thread to run on the first
+	 * scheduleable processor we can find
+	 */
 	status = sched_getaffinity(0, sizeof(cpu_set_t), &current_mask);
 	if (status) {
 		error("failed getting CPU affinity mask: 0x%x\n", status);
@@ -461,7 +465,7 @@ set_cpu_affinity(cpu_set_t *test_mask, cpu_set_t *admin_mask)
 	return SUCCESS;
 }
 
-// clear all watchdog counters
+/* clear all watchdog counters */
 void
 watchdog_clear(void)
 {
@@ -470,7 +474,7 @@ watchdog_clear(void)
 		groups[i].watchdog = 0;
 }
 
-// check for zero watchdog counters
+/* check for zero watchdog counters */
 int
 watchdog_check(void)
 {
@@ -481,7 +485,7 @@ watchdog_check(void)
 	for (i = 0; i < ngroups; i++) {
 		g = &groups[i];
 		if (g->watchdog == 0) {
-			// don't report deadlock if group is finished
+			/* don't report deadlock if group is finished */
 			if (g->inversions == g->total)
 				continue;
 			if (++g->watchdog_hits >= WATCHDOG_LIMIT) {
@@ -516,11 +520,11 @@ static inline void tsnorm(struct timespec *ts)
 	}
 }
 
-//
-// this routine serves two purposes:
-//   1. report progress
-//   2. check for deadlocks
-//
+/*
+ * this routine serves two purposes:
+ * 	1. report progress
+ * 	2. check for deadlocks
+ */
 void *
 reporter(void *arg)
 {
@@ -536,7 +540,7 @@ reporter(void *arg)
 	if (duration >= 0)
 		end = duration + time(NULL);
 
-	// sleep initially to let everything get up and running
+	/* sleep initially to let everything get up and running */
 	status = clock_nanosleep(CLOCK_MONOTONIC, 0, &ts, NULL);
 	if (status) {
 		error("from clock_nanosleep: %s\n", strerror(status));
@@ -547,14 +551,14 @@ reporter(void *arg)
 	info("Press Control-C to stop test\nCurrent Inversions: \n");
 
 	while (shutdown == 0) {
-		// wait for our reporting interval
+		/* wait for our reporting interval */
 		status = clock_nanosleep(CLOCK_MONOTONIC, 0, &ts, NULL);
 		if (status) {
 			error("from clock_nanosleep: %s\n", strerror(status));
 			break;
 		}
 
-		// check for signaled shutdown
+		/* check for signaled shutdown */
 		if (shutdown == 0) {
 			if(!quiet) {
 				fputs(UP_ONE, stdout);
@@ -562,27 +566,27 @@ reporter(void *arg)
 			}
 		}
 
-		// if we specified a duration, see if it has expired
+		/* if we specified a duration, see if it has expired */
 		if (end && time(NULL) > end) {
 			info("duration reached (%d seconds)\n", duration);
 			set_shutdown_flag();
 			continue;
 		}
 
-		// check for a pending SIGINT
+		/* check for a pending SIGINT */
 		if (pending_interrupt()) {
 			info("Keyboard Interrupt!\n");
 			break;
 		}
 
-		// check watchdog stuff
+		/* check watchdog stuff */
 		if ((watchdog_check())) {
 			error("reporter stopping due to watchdog event\n");
 			set_shutdown_flag();
 			break;
 		}
 
-		// clear watchdog counters
+		/* clear watchdog counters */
 		watchdog_clear();
 
 	}
@@ -635,7 +639,8 @@ low_priority(void *arg)
 	debug("low_priority[%d]: starting inversion loop\n", p->id);
 
 	for(;;) {
-		/* We can't set the 'loop' boolean here, because some flags
+		/*
+		 * We can't set the 'loop' boolean here, because some flags
 		 * may have already reached the loop_barr
 		 */
 		if (!unbounded && (p->total >= p->inversions)) {
@@ -685,7 +690,7 @@ low_priority(void *arg)
 			return NULL;
 		}
 
-		// wait for priority boost
+		/* wait for priority boost */
 		debug("low_priority[%d]: entering elevated wait\n", p->id);
 		p->low_unlocked = 0; /* prevent race with med_priority */
 		status = pthread_barrier_wait(&p->elevate_barrier);
@@ -695,11 +700,11 @@ low_priority(void *arg)
 		}
 		p->low_unlocked = 1;
 
-		// release the mutex
+		/* release the mutex */
 		debug("low_priority[%d]: unlocking mutex\n", p->id);
 		pthread_mutex_unlock(&p->mutex);
 
-		// finish state
+		/* finish state */
 		debug("low_priority[%d]: entering finish wait\n", p->id);
 		status = pthread_barrier_wait(&p->finish_barrier);
 		if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
@@ -752,7 +757,8 @@ med_priority(void *arg)
 		if (!unbounded && (p->total >= p->inversions)) {
 			set_shutdown_flag();
 		}
-				/* Either all threads go through the loop_barr, or none do */
+
+		/* Either all threads go through the loop_barr, or none do */
 		pthread_mutex_lock(loop_mtx);
 		if (*loop == 0) {
 			pthread_mutex_unlock(loop_mtx);
@@ -810,7 +816,7 @@ med_priority(void *arg)
 			return NULL;
 		}
 	}
-	// exit
+	/* exit */
 	debug("med_priority[%d]: exiting\n", p->id);
 	return NULL;
 }
@@ -898,10 +904,10 @@ high_priority(void *arg)
 			return NULL;
 		}
 
-		// update the group stats
+		/* update the group stats */
 		p->total++;
 
-		// update the watchdog counter
+		/* update the watchdog counter */
 		p->watchdog++;
 
 	}
@@ -918,7 +924,7 @@ high_priority(void *arg)
 			return NULL;
 		}
 	}
-	// exit
+	/* exit */
 	debug("high_priority[%d]: exiting\n", p->id);
 	return NULL;
 }
@@ -976,14 +982,14 @@ usage(void)
 	printf("\t--help\t\t- print this message\n");
 }
 
-// block all signals (called from main)
+/* block all signals (called from main) */
 int
 block_signals(void)
 {
 	int status;
 	sigset_t sigset;
 
-	// mask off all signals
+	/* mask off all signals */
 	status = sigfillset(&sigset);
 	if (status) {
 		error("setting up full signal set %s\n", strerror(status));
@@ -997,7 +1003,7 @@ block_signals(void)
 	return SUCCESS;
 }
 
-// allow SIGTERM delivery (called from worker threads)
+/* allow SIGTERM delivery (called from worker threads) */
 int
 allow_sigterm(void)
 {
@@ -1026,13 +1032,13 @@ allow_sigterm(void)
 void set_shutdown_flag(void)
 {
 	if (shutdown == 0) {
-		// tell anyone that's looking that we're done
+		/* tell anyone that's looking that we're done */
 		info("setting shutdown flag\n");
 		shutdown = 1;
 	}
 }
 
-// set up a test group
+/* set up a test group */
 int
 initialize_group(struct group_parameters *group)
 {
@@ -1041,8 +1047,10 @@ initialize_group(struct group_parameters *group)
 
 	group->inversions = inversions;
 
-	// setup default attributes for the group mutex
-	// (make it a PI mutex)
+	/*
+	 * setup default attributes for the group mutex
+	 * (make it a PI mutex)
+	 */
 	status = pthread_mutexattr_init(&mutex_attr);
 	if (status) {
 		error("initializing mutex attribute: %s\n", strerror(status));
@@ -1057,7 +1065,7 @@ initialize_group(struct group_parameters *group)
 		return FAILURE;
 	}
 
-	// initialize the group mutex
+	/* initialize the group mutex */
 	status = pthread_mutex_init(&group->mutex, &mutex_attr);
 	if (status) {
 		error("initializing mutex: %s\n", strerror(status));
@@ -1102,7 +1110,7 @@ initialize_group(struct group_parameters *group)
 
 	return SUCCESS;
 }
-// setup and create a groups threads
+/* setup and create a groups threads */
 int
 create_group(struct group_parameters *group)
 {
@@ -1110,7 +1118,7 @@ create_group(struct group_parameters *group)
 	pthread_attr_t thread_attr;
 	cpu_set_t mask;
 
-	// initialize group structure
+	/* initialize group structure */
 	status = initialize_group(group);
 	if (status) {
 		error("initializing group %d\n", group->id);
@@ -1215,7 +1223,7 @@ process_command_line(int argc, char **argv)
 	}
 }
 
-// total the number of inversions that have been performed
+/* total the number of inversions that have been performed */
 unsigned long
 total_inversions(void)
 {
-- 
1.6.0.6

