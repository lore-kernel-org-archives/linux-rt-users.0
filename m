From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 3/3] pi_stress: Convert c-plus style comments to c-style comments
Date: Mon, 16 Nov 2009 21:17:43 +0100
Message-ID: <1258402663-13621-4-git-send-email-jkacur@redhat.com>
References: <1258402663-13621-1-git-send-email-jkacur@redhat.com>
 <1258402663-13621-2-git-send-email-jkacur@redhat.com>
 <1258402663-13621-3-git-send-email-jkacur@redhat.com>
Cc: John Kacur <jkacur@redhat.com>,
	rt-users <linux-rt-users@vger.kernel.org>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-fx0-f221.google.com ([209.85.220.221]:63163 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753049AbZKPURr (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 16 Nov 2009 15:17:47 -0500
Received: by mail-fx0-f221.google.com with SMTP id 21so3120684fxm.21
        for <linux-rt-users@vger.kernel.org>; Mon, 16 Nov 2009 12:17:52 -0800 (PST)
In-Reply-To: <1258402663-13621-3-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/pi_tests/pi_stress.c |  159 +++++++++++++++++++++++-----------------------
 1 files changed, 80 insertions(+), 79 deletions(-)

diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
index d90d4a9..76f466d 100644
--- a/src/pi_tests/pi_stress.c
+++ b/src/pi_tests/pi_stress.c
@@ -55,11 +55,11 @@
 #include <sys/wait.h>
 #include <termios.h>
 
-// version
+/* version */
 const char *version =
     "pi_stress v" VERSION_STRING " (" __DATE__ " " __TIME__ ")";
 
-// conversions
+/* conversions */
 #define USEC_PER_SEC 	1000000
 #define NSEC_PER_SEC 	1000000000
 #define USEC_TO_NSEC(u) ((u) * 1000)
@@ -85,55 +85,55 @@ const char *version =
 #define SUCCESS 0
 #define FAILURE 1
 
-// cursor control
+/* cursor control */
 #define UP_ONE "\033[1A"
 #define DOWN_ONE "\033[1B"
 
-// the length of the test
-// default is infinite
+/* the length of the test */
+/* default is infinite */
 int duration = -1;
 
-// times for starting and finishing the stress test
+/* times for starting and finishing the stress test */
 time_t start, finish;
 
-// the number of groups to create
+/* the number of groups to create */
 int ngroups = 0;
 
-// the number of times a group causes a priority inversion situation
-// default to infinite
+/* the number of times a group causes a priority inversion situation */
+/* default to infinite */
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
 unsigned long report_interval = (unsigned long)SEC_TO_USEC(0.75);
 
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
 struct option options[] = {
 	{"duration", required_argument, NULL, 't'},
 	{"verbose", no_argument, NULL, 'v'},
@@ -151,7 +151,7 @@ struct option options[] = {
 	{NULL, 0, NULL, 0},
 };
 
-// max priority for the scheduling policy
+/* max priority for the scheduling policy */
 int prio_min;
 
 /* define priorities for the threads */
@@ -174,24 +174,24 @@ int policy = SCHED_FIFO;
 
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
 
-	// state barriers
+	/* state barriers */
 	pthread_barrier_t start_barrier;
 	pthread_barrier_t locked_barrier;
 	pthread_barrier_t elevate_barrier;
@@ -200,22 +200,22 @@ struct group_parameters {
 	/* Either everyone goes through the loop, or else no-ones does */
 	pthread_barrier_t loop_barr;
 	pthread_mutex_t loop_mtx;	/* Protect access to int loop */
-	int loop;		/* boolean, loop or not, connected to shutdown */
+	int loop;	/* boolean, loop or not, connected to shutdown */
 
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
+/* number of consecutive watchdog hits before quitting */
 #define WATCHDOG_LIMIT 5
 
 /* number of online processors */
@@ -274,7 +274,7 @@ int main(int argc, char **argv)
 			error("mlockall failed\n");
 			return FAILURE;
 		}
-	// boost main's priority (so we keep running) :)
+	/* boost main's priority (so we keep running) :) */
 	prio_min = sched_get_priority_min(policy);
 	thread_param.sched_priority = MAIN_PRIO();
 	status = pthread_setschedparam(pthread_self(), policy, &thread_param);
@@ -282,16 +282,16 @@ int main(int argc, char **argv)
 		error("main: boosting to max priority: 0x%x\n", status);
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
 
@@ -306,7 +306,7 @@ int main(int argc, char **argv)
 	if (barrier_init(&all_threads_done, NULL, nthreads, "all_threads_done"))
 		return FAILURE;
 
-	// create the groups
+	/* create the groups */
 	info("Creating %d test groups\n", ngroups);
 	for (core = 0; core < num_processors; core++)
 		if (CPU_ISSET(core, &test_cpu_mask))
@@ -320,16 +320,16 @@ int main(int argc, char **argv)
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
@@ -347,7 +347,7 @@ int main(int argc, char **argv)
 	}
 	set_shutdown_flag();
 
-	// wait for all threads to notice the shutdown flag
+	/* wait for all threads to notice the shutdown flag */
 	if (have_errors == 0 && interrupted == 0) {
 		info("waiting for all threads to complete\n");
 		status = pthread_barrier_wait(&all_threads_done);
@@ -418,7 +418,7 @@ int set_cpu_affinity(cpu_set_t * test_mask, cpu_set_t * admin_mask)
 	int status, i, admin_proc;
 	cpu_set_t current_mask;
 
-	// handle uniprocessor case
+	/* handle uniprocessor case */
 	if (num_processors == 1 || uniprocessor) {
 		CPU_ZERO(admin_mask);
 		CPU_ZERO(test_mask);
@@ -427,8 +427,8 @@ int set_cpu_affinity(cpu_set_t * test_mask, cpu_set_t * admin_mask)
 		info("admin and test threads running on one processor\n");
 		return SUCCESS;
 	}
-	// first set our main thread to run on the first
-	// scheduleable processor we can find
+	/* first set our main thread to run on the first
+	   scheduleable processor we can find */
 	status = sched_getaffinity(0, sizeof(cpu_set_t), &current_mask);
 	if (status) {
 		error("failed getting CPU affinity mask: 0x%x\n", status);
@@ -468,7 +468,7 @@ int set_cpu_affinity(cpu_set_t * test_mask, cpu_set_t * admin_mask)
 	return SUCCESS;
 }
 
-// clear all watchdog counters
+/* clear all watchdog counters */
 void watchdog_clear(void)
 {
 	int i;
@@ -476,7 +476,7 @@ void watchdog_clear(void)
 		groups[i].watchdog = 0;
 }
 
-// check for zero watchdog counters
+/* check for zero watchdog counters */
 int watchdog_check(void)
 {
 	int i;
@@ -486,7 +486,7 @@ int watchdog_check(void)
 	for (i = 0; i < ngroups; i++) {
 		g = &groups[i];
 		if (g->watchdog == 0) {
-			// don't report deadlock if group is finished
+			/* don't report deadlock if group is finished */
 			if (g->inversions == g->total)
 				continue;
 			if (++g->watchdog_hits >= WATCHDOG_LIMIT) {
@@ -521,11 +521,11 @@ static inline void tsnorm(struct timespec *ts)
 	}
 }
 
-//
-// this routine serves two purposes:
-//   1. report progress
-//   2. check for deadlocks
-//
+/*
+ * this routine serves two purposes:
+ *   1. report progress
+ *   2. check for deadlocks
+ */
 void *reporter(void *arg)
 {
 	int status;
@@ -540,7 +540,7 @@ void *reporter(void *arg)
 	if (duration >= 0)
 		end = duration + time(NULL);
 
-	// sleep initially to let everything get up and running
+	/* sleep initially to let everything get up and running */
 	status = clock_nanosleep(CLOCK_MONOTONIC, 0, &ts, NULL);
 	if (status) {
 		error("from clock_nanosleep: %s\n", strerror(status));
@@ -551,13 +551,13 @@ void *reporter(void *arg)
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
 			if (!quiet) {
 				fputs(UP_ONE, stdout);
@@ -565,24 +565,24 @@ void *reporter(void *arg)
 				       total_inversions());
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
@@ -635,8 +635,9 @@ void *low_priority(void *arg)
 	debug("low_priority[%d]: starting inversion loop\n", p->id);
 
 	for (;;) {
-		/* We can't set the 'loop' boolean here, because some flags
-		 * may have already reached the loop_barr
+		/*
+		   We can't set the 'loop' boolean here, because some flags
+		   may have already reached the loop_barr
 		 */
 		if (!unbounded && (p->total >= p->inversions)) {
 			set_shutdown_flag();
@@ -689,7 +690,7 @@ void *low_priority(void *arg)
 			     p->id, status);
 			return NULL;
 		}
-		// wait for priority boost
+		/* wait for priority boost */
 		debug("low_priority[%d]: entering elevated wait\n", p->id);
 		p->low_unlocked = 0;	/* prevent race with med_priority */
 		status = pthread_barrier_wait(&p->elevate_barrier);
@@ -701,11 +702,11 @@ void *low_priority(void *arg)
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
@@ -829,7 +830,7 @@ void *med_priority(void *arg)
 			return NULL;
 		}
 	}
-	// exit
+	/* exit */
 	debug("med_priority[%d]: exiting\n", p->id);
 	return NULL;
 }
@@ -924,10 +925,10 @@ void *high_priority(void *arg)
 			     status);
 			return NULL;
 		}
-		// update the group stats
+		/* update the group stats */
 		p->total++;
 
-		// update the watchdog counter
+		/* update the watchdog counter */
 		p->watchdog++;
 
 	}
@@ -945,7 +946,7 @@ void *high_priority(void *arg)
 			return NULL;
 		}
 	}
-	// exit
+	/* exit */
 	debug("high_priority[%d]: exiting\n", p->id);
 	return NULL;
 }
@@ -1003,13 +1004,13 @@ void usage(void)
 	printf("\t--help\t\t- print this message\n");
 }
 
-// block all signals (called from main)
+/* block all signals (called from main) */
 int block_signals(void)
 {
 	int status;
 	sigset_t sigset;
 
-	// mask off all signals
+	/* mask off all signals */
 	status = sigfillset(&sigset);
 	if (status) {
 		error("setting up full signal set %s\n", strerror(status));
@@ -1023,7 +1024,7 @@ int block_signals(void)
 	return SUCCESS;
 }
 
-// allow SIGTERM delivery (called from worker threads)
+/* allow SIGTERM delivery (called from worker threads) */
 int allow_sigterm(void)
 {
 	int status;
@@ -1051,13 +1052,13 @@ int allow_sigterm(void)
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
 int initialize_group(struct group_parameters *group)
 {
 	int status;
@@ -1065,8 +1066,8 @@ int initialize_group(struct group_parameters *group)
 
 	group->inversions = inversions;
 
-	// setup default attributes for the group mutex
-	// (make it a PI mutex)
+	/* setup default attributes for the group mutex */
+	/* (make it a PI mutex) */
 	status = pthread_mutexattr_init(&mutex_attr);
 	if (status) {
 		error("initializing mutex attribute: %s\n", strerror(status));
@@ -1080,7 +1081,7 @@ int initialize_group(struct group_parameters *group)
 		error("setting mutex attribute policy: %s\n", strerror(status));
 		return FAILURE;
 	}
-	// initialize the group mutex
+	/* initialize the group mutex */
 	status = pthread_mutex_init(&group->mutex, &mutex_attr);
 	if (status) {
 		error("initializing mutex: %s\n", strerror(status));
@@ -1126,14 +1127,14 @@ int initialize_group(struct group_parameters *group)
 	return SUCCESS;
 }
 
-// setup and create a groups threads
+/* setup and create a groups threads */
 int create_group(struct group_parameters *group)
 {
 	int status;
 	pthread_attr_t thread_attr;
 	cpu_set_t mask;
 
-	// initialize group structure
+	/* initialize group structure */
 	status = initialize_group(group);
 	if (status) {
 		error("initializing group %d\n", group->id);
@@ -1231,7 +1232,7 @@ void process_command_line(int argc, char **argv)
 	}
 }
 
-// total the number of inversions that have been performed
+/* total the number of inversions that have been performed */
 unsigned long total_inversions(void)
 {
 	int i;
-- 
1.6.2.5

