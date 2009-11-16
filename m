From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 1/3] pi_stress: Fix indentation problems with Lindent from the kernel
Date: Mon, 16 Nov 2009 21:17:41 +0100
Message-ID: <1258402663-13621-2-git-send-email-jkacur@redhat.com>
References: <1258402663-13621-1-git-send-email-jkacur@redhat.com>
Cc: John Kacur <jkacur@redhat.com>,
	rt-users <linux-rt-users@vger.kernel.org>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:55951 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753049AbZKPURn (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 16 Nov 2009 15:17:43 -0500
Received: by bwz27 with SMTP id 27so6073291bwz.21
        for <linux-rt-users@vger.kernel.org>; Mon, 16 Nov 2009 12:17:47 -0800 (PST)
In-Reply-To: <1258402663-13621-1-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/pi_tests/pi_stress.c |  353 ++++++++++++++++++++++++----------------------
 1 files changed, 183 insertions(+), 170 deletions(-)

diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
index ae5571a..865e3b4 100644
--- a/src/pi_tests/pi_stress.c
+++ b/src/pi_tests/pi_stress.c
@@ -56,7 +56,8 @@
 #include <termios.h>
 
 // version
-const char *version = "pi_stress v" VERSION_STRING " (" __DATE__ " " __TIME__ ")";
+const char *version =
+    "pi_stress v" VERSION_STRING " (" __DATE__ " " __TIME__ ")";
 
 // conversions
 #define USEC_PER_SEC 	1000000
@@ -86,7 +87,7 @@ const char *version = "pi_stress v" VERSION_STRING " (" __DATE__ " " __TIME__ ")
 
 // cursor control
 #define UP_ONE "\033[1A"
-#define DOWN_ONE "\033[1B" 
+#define DOWN_ONE "\033[1B"
 
 // the length of the test
 // default is infinite
@@ -115,7 +116,7 @@ int quiet = 0;
 int prompt = 0;
 
 // report interval
-unsigned long report_interval = (unsigned long) SEC_TO_USEC(0.75);
+unsigned long report_interval = (unsigned long)SEC_TO_USEC(0.75);
 
 // global that indicates we should shut down
 volatile int shutdown = 0;
@@ -133,21 +134,21 @@ int uniprocessor = 0;
 int lockall = 0;
 
 // command line options
-struct option options [] = {
-	{ "duration", required_argument, NULL, 't' },
-	{ "verbose", no_argument, NULL, 'v' },
-	{ "quiet", no_argument, NULL, 'q' },
-	{ "groups", required_argument, NULL, 'g'},
-	{ "inversions" , required_argument, NULL, 'i'},
-	{ "rr", no_argument, NULL, 'r'},
-	{ "signal", no_argument, NULL, 's'},
-	{ "uniprocessor", no_argument, NULL, 'u'},
-	{ "prompt", no_argument, NULL, 'p'},
-	{ "debug", no_argument, NULL, 'd'},
-	{ "version", no_argument, NULL, 'V'},
-	{ "mlockall", no_argument, NULL, 'm'},
-	{ "help", no_argument, NULL, 'h'},
-	{ NULL, 0, NULL, 0},
+struct option options[] = {
+	{"duration", required_argument, NULL, 't'},
+	{"verbose", no_argument, NULL, 'v'},
+	{"quiet", no_argument, NULL, 'q'},
+	{"groups", required_argument, NULL, 'g'},
+	{"inversions", required_argument, NULL, 'i'},
+	{"rr", no_argument, NULL, 'r'},
+	{"signal", no_argument, NULL, 's'},
+	{"uniprocessor", no_argument, NULL, 'u'},
+	{"prompt", no_argument, NULL, 'p'},
+	{"debug", no_argument, NULL, 'd'},
+	{"version", no_argument, NULL, 'V'},
+	{"mlockall", no_argument, NULL, 'm'},
+	{"help", no_argument, NULL, 'h'},
+	{NULL, 0, NULL, 0},
 };
 
 // max priority for the scheduling policy
@@ -190,7 +191,7 @@ struct group_parameters {
 	// group mutex
 	pthread_mutex_t mutex;
 
-        // state barriers
+	// state barriers
 	pthread_barrier_t start_barrier;
 	pthread_barrier_t locked_barrier;
 	pthread_barrier_t elevate_barrier;
@@ -199,7 +200,7 @@ struct group_parameters {
 	/* Either everyone goes through the loop, or else no-ones does */
 	pthread_barrier_t loop_barr;
 	pthread_mutex_t loop_mtx;	/* Protect access to int loop */
-	int loop;	/* boolean, loop or not, connected to shutdown */
+	int loop;		/* boolean, loop or not, connected to shutdown */
 
 	// state variables
 	volatile int high_has_run;
@@ -226,8 +227,9 @@ void *med_priority(void *arg);
 void *high_priority(void *arg);
 void *reporter(void *arg);
 void *watchdog(void *arg);
-int setup_thread_attr(pthread_attr_t *attr, int prio, cpu_set_t *mask, int schedpolicy);
-int set_cpu_affinity(cpu_set_t *test_mask, cpu_set_t *admin_mask);
+int setup_thread_attr(pthread_attr_t * attr, int prio, cpu_set_t * mask,
+		      int schedpolicy);
+int set_cpu_affinity(cpu_set_t * test_mask, cpu_set_t * admin_mask);
 void error(char *, ...);
 void info(char *, ...);
 void debug(char *, ...);
@@ -242,11 +244,10 @@ unsigned long total_inversions(void);
 void banner(void);
 void summary(void);
 void wait_for_termination(void);
-int barrier_init(pthread_barrier_t *b, const pthread_barrierattr_t *attr,
-		unsigned count, const char *name);
+int barrier_init(pthread_barrier_t * b, const pthread_barrierattr_t * attr,
+		 unsigned count, const char *name);
 
-int
-main (int argc, char **argv)
+int main(int argc, char **argv)
 {
 	int status;
 	struct sched_param thread_param;
@@ -256,7 +257,7 @@ main (int argc, char **argv)
 	int nthreads;
 
 	/* Make sure we see all message, even those on stdout.  */
-	setvbuf (stdout, NULL, _IONBF, 0);
+	setvbuf(stdout, NULL, _IONBF, 0);
 
 	/* get the number of processors */
 	num_processors = sysconf(_SC_NPROCESSORS_ONLN);
@@ -269,11 +270,10 @@ main (int argc, char **argv)
 
 	/* lock memory */
 	if (lockall)
-		if (mlockall(MCL_CURRENT|MCL_FUTURE) == -1) {
+		if (mlockall(MCL_CURRENT | MCL_FUTURE) == -1) {
 			error("mlockall failed\n");
 			return FAILURE;
 		}
-
 	// boost main's priority (so we keep running) :)
 	prio_min = sched_get_priority_min(policy);
 	thread_param.sched_priority = MAIN_PRIO();
@@ -282,7 +282,6 @@ main (int argc, char **argv)
 		error("main: boosting to max priority: 0x%x\n", status);
 		return FAILURE;
 	}
-
 	// block unwanted signals
 	block_signals();
 
@@ -292,16 +291,15 @@ main (int argc, char **argv)
 		error("main: failed to allocate %d groups\n", ngroups);
 		return FAILURE;
 	}
-
 	// set up CPU affinity masks
 	if (set_cpu_affinity(&test_cpu_mask, &admin_cpu_mask))
 		return FAILURE;
-		
+
 	nthreads = ngroups * NUM_TEST_THREADS + NUM_ADMIN_THREADS;
 
 	/* set up our ready barrier */
 	if (barrier_init(&all_threads_ready, NULL, nthreads,
-				"all_threads_ready"))
+			 "all_threads_ready"))
 		return FAILURE;
 
 	/* set up our done barrier */
@@ -316,7 +314,7 @@ main (int argc, char **argv)
 	for (i = 0; i < ngroups; i++) {
 		groups[i].id = i;
 		groups[i].cpu = core++;
-		if (core >= num_processors) 
+		if (core >= num_processors)
 			core = 0;
 		if (create_group(&groups[i]) != SUCCESS)
 			return FAILURE;
@@ -327,7 +325,6 @@ main (int argc, char **argv)
 		printf("Press return to start test: ");
 		getchar();
 	}
-
 	// report
 	banner();
 	start = time(NULL);
@@ -336,7 +333,8 @@ main (int argc, char **argv)
 	info("Releasing all threads\n");
 	status = pthread_barrier_wait(&all_threads_ready);
 	if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
-		error("main: pthread_barrier_wait(all_threads_ready): 0x%x\n", status);
+		error("main: pthread_barrier_wait(all_threads_ready): 0x%x\n",
+		      status);
 		set_shutdown_flag();
 		return FAILURE;
 	}
@@ -354,13 +352,14 @@ main (int argc, char **argv)
 		info("waiting for all threads to complete\n");
 		status = pthread_barrier_wait(&all_threads_done);
 		if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
-			error("main: pthread_barrier_wait(all_threads_ready): 0x%x\n", status);
+			error
+			    ("main: pthread_barrier_wait(all_threads_ready): 0x%x\n",
+			     status);
 			return FAILURE;
 		}
 		info("All threads terminated!\n");
 		retval = SUCCESS;
-	}
-	else
+	} else
 		kill(0, SIGTERM);
 	finish = time(NULL);
 	summary();
@@ -370,43 +369,51 @@ main (int argc, char **argv)
 }
 
 int
-setup_thread_attr(pthread_attr_t *attr, int prio, cpu_set_t *mask, int schedpolicy)
+setup_thread_attr(pthread_attr_t * attr, int prio, cpu_set_t * mask,
+		  int schedpolicy)
 {
 	int status;
 	struct sched_param thread_param;
 
 	status = pthread_attr_init(attr);
 	if (status) {
-		error("setup_thread_attr: initializing thread attribute: 0x%x\n", status);
+		error
+		    ("setup_thread_attr: initializing thread attribute: 0x%x\n",
+		     status);
 		return FAILURE;
 	}
 	status = pthread_attr_setschedpolicy(attr, schedpolicy);
 	if (status) {
-		error("setup_thread_attr: setting attribute policy to %s: 0x%x\n", 
-		      schedpolicy == SCHED_FIFO ? "SCHED_FIFO" : "SCHED_RR", status);
+		error
+		    ("setup_thread_attr: setting attribute policy to %s: 0x%x\n",
+		     schedpolicy == SCHED_FIFO ? "SCHED_FIFO" : "SCHED_RR",
+		     status);
 		return FAILURE;
 	}
 	status = pthread_attr_setinheritsched(attr, PTHREAD_EXPLICIT_SCHED);
 	if (status) {
-		error("setup_thread_attr: setting explicit scheduling inheritance: 0x%x\n", status);
+		error
+		    ("setup_thread_attr: setting explicit scheduling inheritance: 0x%x\n",
+		     status);
 		return FAILURE;
 	}
 	thread_param.sched_priority = prio;
 	status = pthread_attr_setschedparam(attr, &thread_param);
 	if (status) {
-		error("setup_thread_attr: setting scheduler param: 0x%x\n", status);
+		error("setup_thread_attr: setting scheduler param: 0x%x\n",
+		      status);
 		return FAILURE;
 	}
 	status = pthread_attr_setaffinity_np(attr, sizeof(cpu_set_t), mask);
 	if (status) {
-		error("setup_thread_attr: setting affinity attribute: 0x%x\n", status);
+		error("setup_thread_attr: setting affinity attribute: 0x%x\n",
+		      status);
 		return FAILURE;
 	}
 	return SUCCESS;
 }
 
-int
-set_cpu_affinity(cpu_set_t *test_mask, cpu_set_t *admin_mask)
+int set_cpu_affinity(cpu_set_t * test_mask, cpu_set_t * admin_mask)
 {
 	int status, i, admin_proc;
 	cpu_set_t current_mask;
@@ -420,7 +427,6 @@ set_cpu_affinity(cpu_set_t *test_mask, cpu_set_t *admin_mask)
 		info("admin and test threads running on one processor\n");
 		return SUCCESS;
 	}
-
 	// first set our main thread to run on the first
 	// scheduleable processor we can find
 	status = sched_getaffinity(0, sizeof(cpu_set_t), &current_mask);
@@ -430,7 +436,7 @@ set_cpu_affinity(cpu_set_t *test_mask, cpu_set_t *admin_mask)
 	}
 	for (i = 0; i < num_processors; i++) {
 		if (CPU_ISSET(i, &current_mask))
-		break;
+			break;
 	}
 	if (i >= num_processors) {
 		error("No schedulable CPU found for main!\n");
@@ -441,29 +447,29 @@ set_cpu_affinity(cpu_set_t *test_mask, cpu_set_t *admin_mask)
 	CPU_SET(admin_proc, admin_mask);
 	status = sched_setaffinity(0, sizeof(cpu_set_t), admin_mask);
 	if (status) {
-		error("set_cpu_affinity: setting CPU affinity mask: 0x%x\n", status);
+		error("set_cpu_affinity: setting CPU affinity mask: 0x%x\n",
+		      status);
 		return FAILURE;
 	}
 	info("Admin thread running on processor: %d\n", i);
 
 	/* Set test affinity so that tests run on the non-admin processors */
 	CPU_ZERO(test_mask);
-	for (i = admin_proc+1; i < num_processors; i++)
+	for (i = admin_proc + 1; i < num_processors; i++)
 		CPU_SET(i, test_mask);
-	
-	if (admin_proc+1 == num_processors -1)
+
+	if (admin_proc + 1 == num_processors - 1)
 		info("Test threads running on processor: %ld\n",
-				num_processors-1);
+		     num_processors - 1);
 	else
-		info("Test threads running on processors:  %d-%d\n", 
-				admin_proc+1, (int)num_processors-1);
+		info("Test threads running on processors:  %d-%d\n",
+		     admin_proc + 1, (int)num_processors - 1);
 
 	return SUCCESS;
 }
 
 // clear all watchdog counters
-void
-watchdog_clear(void)
+void watchdog_clear(void)
 {
 	int i;
 	for (i = 0; i < ngroups; i++)
@@ -471,8 +477,7 @@ watchdog_clear(void)
 }
 
 // check for zero watchdog counters
-int
-watchdog_check(void)
+int watchdog_check(void)
 {
 	int i;
 	int failures = 0;
@@ -485,18 +490,18 @@ watchdog_check(void)
 			if (g->inversions == g->total)
 				continue;
 			if (++g->watchdog_hits >= WATCHDOG_LIMIT) {
-				error("WATCHDOG triggered: group %d is deadlocked!\n", i);
+				error
+				    ("WATCHDOG triggered: group %d is deadlocked!\n",
+				     i);
 				failures++;
 			}
-		}
-		else
+		} else
 			g->watchdog_hits = 0;
 	}
 	return failures ? FAILURE : SUCCESS;
-}	
+}
 
-int
-pending_interrupt(void)
+int pending_interrupt(void)
 {
 	sigset_t pending;
 
@@ -504,10 +509,10 @@ pending_interrupt(void)
 		error("from sigpending: %s\n", strerror(errno));
 		return 0;
 	}
-	
+
 	return interrupted = sigismember(&pending, SIGINT);
 }
-	
+
 static inline void tsnorm(struct timespec *ts)
 {
 	while (ts->tv_nsec >= NSEC_PER_SEC) {
@@ -521,8 +526,7 @@ static inline void tsnorm(struct timespec *ts)
 //   1. report progress
 //   2. check for deadlocks
 //
-void *
-reporter(void *arg)
+void *reporter(void *arg)
 {
 	int status;
 	int end = 0;
@@ -553,46 +557,41 @@ reporter(void *arg)
 			error("from clock_nanosleep: %s\n", strerror(status));
 			break;
 		}
-
 		// check for signaled shutdown
 		if (shutdown == 0) {
-			if(!quiet) {
+			if (!quiet) {
 				fputs(UP_ONE, stdout);
-				printf("Current Inversions: %lu\n", total_inversions());
+				printf("Current Inversions: %lu\n",
+				       total_inversions());
 			}
 		}
-
 		// if we specified a duration, see if it has expired
 		if (end && time(NULL) > end) {
 			info("duration reached (%d seconds)\n", duration);
 			set_shutdown_flag();
 			continue;
 		}
-
 		// check for a pending SIGINT
 		if (pending_interrupt()) {
 			info("Keyboard Interrupt!\n");
 			break;
 		}
-
 		// check watchdog stuff
 		if ((watchdog_check())) {
 			error("reporter stopping due to watchdog event\n");
 			set_shutdown_flag();
 			break;
 		}
-			
 		// clear watchdog counters
 		watchdog_clear();
-		
+
 	}
 	debug("reporter: finished\n");
 	set_shutdown_flag();
 	return NULL;
 }
 
-int
-verify_cpu(int cpu)
+int verify_cpu(int cpu)
 {
 	int status;
 	cpu_set_t mask;
@@ -604,8 +603,7 @@ verify_cpu(int cpu)
 	return FAILURE;
 }
 
-void *
-low_priority(void *arg)
+void *low_priority(void *arg)
 {
 	int status;
 	int unbounded;
@@ -626,7 +624,9 @@ low_priority(void *arg)
 	/* wait for all threads to be ready */
 	status = pthread_barrier_wait(&all_threads_ready);
 	if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
-		error("low_priority[%d]: pthread_barrier_wait(all_threads_ready): %x", p->id, status);
+		error
+		    ("low_priority[%d]: pthread_barrier_wait(all_threads_ready): %x",
+		     p->id, status);
 		return NULL;
 	}
 
@@ -634,7 +634,7 @@ low_priority(void *arg)
 
 	debug("low_priority[%d]: starting inversion loop\n", p->id);
 
-	for(;;) {
+	for (;;) {
 		/* We can't set the 'loop' boolean here, because some flags
 		 * may have already reached the loop_barr
 		 */
@@ -653,7 +653,7 @@ low_priority(void *arg)
 		status = pthread_barrier_wait(loop_barr);
 		if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
 			error("%s[%d]: pthread_barrier_wait(loop): %x\n",
-					__func__, p->id, status);
+			      __func__, p->id, status);
 			return NULL;
 		}
 
@@ -667,10 +667,13 @@ low_priority(void *arg)
 		}
 
 		/* initial state */
-		debug("low_priority[%d]: entering start wait (%d)\n", p->id, count++);
+		debug("low_priority[%d]: entering start wait (%d)\n", p->id,
+		      count++);
 		status = pthread_barrier_wait(&p->start_barrier);
 		if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
-			error("low_priority[%d]: pthread_barrier_wait(start): %x\n", p->id, status);
+			error
+			    ("low_priority[%d]: pthread_barrier_wait(start): %x\n",
+			     p->id, status);
 			return NULL;
 		}
 
@@ -681,16 +684,19 @@ low_priority(void *arg)
 		debug("low_priority[%d]: entering locked wait\n", p->id);
 		status = pthread_barrier_wait(&p->locked_barrier);
 		if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
-			error("low_priority[%d]: pthread_barrier_wait(locked): %x\n", p->id, status);
+			error
+			    ("low_priority[%d]: pthread_barrier_wait(locked): %x\n",
+			     p->id, status);
 			return NULL;
 		}
-
 		// wait for priority boost
 		debug("low_priority[%d]: entering elevated wait\n", p->id);
-		p->low_unlocked = 0; /* prevent race with med_priority */
+		p->low_unlocked = 0;	/* prevent race with med_priority */
 		status = pthread_barrier_wait(&p->elevate_barrier);
 		if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
-			error("low_priority[%d]: pthread_barrier_wait(elevate): %x\n", p->id, status);
+			error
+			    ("low_priority[%d]: pthread_barrier_wait(elevate): %x\n",
+			     p->id, status);
 			return NULL;
 		}
 		p->low_unlocked = 1;
@@ -703,7 +709,9 @@ low_priority(void *arg)
 		debug("low_priority[%d]: entering finish wait\n", p->id);
 		status = pthread_barrier_wait(&p->finish_barrier);
 		if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
-			error("low_priority[%d]: pthread_barrier_wait(elevate): %x\n", p->id, status);
+			error
+			    ("low_priority[%d]: pthread_barrier_wait(elevate): %x\n",
+			     p->id, status);
 			return NULL;
 		}
 	}
@@ -712,15 +720,16 @@ low_priority(void *arg)
 	/* wait for all threads to finish */
 	status = pthread_barrier_wait(&all_threads_done);
 	if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
-		error("low_priority[%d]: pthread_barrier_wait(all_threads_done): %x", p->id, status);
+		error
+		    ("low_priority[%d]: pthread_barrier_wait(all_threads_done): %x",
+		     p->id, status);
 		return NULL;
 	}
 	debug("low_priority[%d]: exiting\n", p->id);
 	return NULL;
 }
 
-void *
-med_priority(void *arg)
+void *med_priority(void *arg)
 {
 	int status;
 	int unbounded;
@@ -741,18 +750,20 @@ med_priority(void *arg)
 	/* wait for all threads to be ready */
 	status = pthread_barrier_wait(&all_threads_ready);
 	if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
-		error("med_priority[%d]: pthread_barrier_wait(all_threads_ready): %x", p->id, status);
+		error
+		    ("med_priority[%d]: pthread_barrier_wait(all_threads_ready): %x",
+		     p->id, status);
 		return NULL;
 	}
 
 	unbounded = (p->inversions < 0);
 
 	debug("med_priority[%d]: starting inversion loop\n", p->id);
-	for(;;) {
+	for (;;) {
 		if (!unbounded && (p->total >= p->inversions)) {
 			set_shutdown_flag();
 		}
-				/* Either all threads go through the loop_barr, or none do */
+		/* Either all threads go through the loop_barr, or none do */
 		pthread_mutex_lock(loop_mtx);
 		if (*loop == 0) {
 			pthread_mutex_unlock(loop_mtx);
@@ -763,7 +774,7 @@ med_priority(void *arg)
 		status = pthread_barrier_wait(loop_barr);
 		if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
 			error("%s[%d]: pthread_barrier_wait(loop): %x\n",
-					__func__, p->id, status);
+			      __func__, p->id, status);
 			return NULL;
 		}
 
@@ -777,24 +788,31 @@ med_priority(void *arg)
 		}
 
 		/* start state */
-		debug("med_priority[%d]: entering start state (%d)\n", p->id, count++);
+		debug("med_priority[%d]: entering start state (%d)\n", p->id,
+		      count++);
 		status = pthread_barrier_wait(&p->start_barrier);
 		if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
-			error("med_priority[%d]: pthread_barrier_wait(start): %x", p->id, status);
+			error
+			    ("med_priority[%d]: pthread_barrier_wait(start): %x",
+			     p->id, status);
 			return NULL;
 		}
 		debug("med_priority[%d]: entering elevate state\n", p->id);
 		do {
 			status = pthread_barrier_wait(&p->elevate_barrier);
 			if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
-				error("med_priority[%d]: pthread_barrier_wait(elevate): %x", p->id, status);
+				error
+				    ("med_priority[%d]: pthread_barrier_wait(elevate): %x",
+				     p->id, status);
 				return NULL;
 			}
 		} while (!p->high_has_run && !p->low_unlocked);
 		debug("med_priority[%d]: entering finish state\n", p->id);
 		status = pthread_barrier_wait(&p->finish_barrier);
 		if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
-			error("med_priority[%d]: pthread_barrier_wait(finished): %x", p->id, status);
+			error
+			    ("med_priority[%d]: pthread_barrier_wait(finished): %x",
+			     p->id, status);
 			return NULL;
 		}
 	}
@@ -805,8 +823,9 @@ med_priority(void *arg)
 	if (have_errors == 0) {
 		status = pthread_barrier_wait(&all_threads_done);
 		if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
-			error("med_priority[%d]: pthread_barrier_wait(all_threads_done): %x", 
-			      p->id, status);
+			error
+			    ("med_priority[%d]: pthread_barrier_wait(all_threads_done): %x",
+			     p->id, status);
 			return NULL;
 		}
 	}
@@ -815,8 +834,7 @@ med_priority(void *arg)
 	return NULL;
 }
 
-void *
-high_priority(void *arg)
+void *high_priority(void *arg)
 {
 	int status;
 	int unbounded;
@@ -837,12 +855,14 @@ high_priority(void *arg)
 	/* wait for all threads to be ready */
 	status = pthread_barrier_wait(&all_threads_ready);
 	if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
-		error("high_priority[%d]: pthread_barrier_wait(all_threads_ready): %x", p->id, status);
+		error
+		    ("high_priority[%d]: pthread_barrier_wait(all_threads_ready): %x",
+		     p->id, status);
 		return NULL;
 	}
 	unbounded = (p->inversions < 0);
 	debug("high_priority[%d]: starting inversion loop\n", p->id);
-	for(;;) {
+	for (;;) {
 		if (!unbounded && (p->total >= p->inversions)) {
 			set_shutdown_flag();
 		}
@@ -858,7 +878,7 @@ high_priority(void *arg)
 		status = pthread_barrier_wait(loop_barr);
 		if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
 			error("%s[%d]: pthread_barrier_wait(loop): %x\n",
-					__func__, p->id, status);
+			      __func__, p->id, status);
 			return NULL;
 		}
 
@@ -871,17 +891,22 @@ high_priority(void *arg)
 			}
 		}
 		p->high_has_run = 0;
-		debug("high_priority[%d]: entering start state (%d)\n", p->id, count++);
+		debug("high_priority[%d]: entering start state (%d)\n", p->id,
+		      count++);
 		status = pthread_barrier_wait(&p->start_barrier);
 		if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
-			error("high_priority[%d]: pthread_barrier_wait(start): %x", p->id, status);
+			error
+			    ("high_priority[%d]: pthread_barrier_wait(start): %x",
+			     p->id, status);
 			return NULL;
 		}
 
 		debug("high_priority[%d]: entering running state\n", p->id);
 		status = pthread_barrier_wait(&p->locked_barrier);
 		if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
-			error("high_priority[%d]: pthread_barrier_wait(running): %x", p->id, status);
+			error
+			    ("high_priority[%d]: pthread_barrier_wait(running): %x",
+			     p->id, status);
 			return NULL;
 		}
 		debug("high_priority[%d]: locking mutex\n", p->id);
@@ -894,10 +919,11 @@ high_priority(void *arg)
 
 		status = pthread_barrier_wait(&p->finish_barrier);
 		if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
-			error("high_priority[%d]: pthread_barrier_wait(finish): %x", status);
+			error
+			    ("high_priority[%d]: pthread_barrier_wait(finish): %x",
+			     status);
 			return NULL;
 		}
-
 		// update the group stats
 		p->total++;
 
@@ -913,18 +939,18 @@ high_priority(void *arg)
 		/* wait for all threads to finish */
 		status = pthread_barrier_wait(&all_threads_done);
 		if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
-			error("high_priority[%d]: pthread_barrier_wait(all_threads_done): %x",
-			      p->id, status);
+			error
+			    ("high_priority[%d]: pthread_barrier_wait(all_threads_done): %x",
+			     p->id, status);
 			return NULL;
 		}
-	}       
+	}
 	// exit
 	debug("high_priority[%d]: exiting\n", p->id);
 	return NULL;
 }
 
-void
-error(char *fmt, ...)
+void error(char *fmt, ...)
 {
 	va_list ap;
 	fputs("ERROR: ", stderr);
@@ -934,8 +960,7 @@ error(char *fmt, ...)
 	have_errors = 1;
 }
 
-void
-info(char *fmt, ...)
+void info(char *fmt, ...)
 {
 	if (verbose) {
 		va_list ap;
@@ -945,8 +970,7 @@ info(char *fmt, ...)
 	}
 }
 
-void 
-debug(char *fmt, ...)
+void debug(char *fmt, ...)
 {
 	if (debugging) {
 		va_list ap;
@@ -956,20 +980,23 @@ debug(char *fmt, ...)
 		va_end(ap);
 	}
 }
-	
-void
-usage(void)
+
+void usage(void)
 {
 	printf("usage: pi_stress <options>\n");
 	printf("    options:\n");
 	printf("\t--verbose\t- lots of output\n");
-	printf("\t--duration=<n>- length of the test run in seconds [infinite]\n");
-	printf("\t--groups=<n>\t- set the number of inversion groups [%d]\n", ngroups);
-	printf("\t--inversions=<n>- number of inversions per group [infinite]\n");
+	printf
+	    ("\t--duration=<n>- length of the test run in seconds [infinite]\n");
+	printf("\t--groups=<n>\t- set the number of inversion groups [%d]\n",
+	       ngroups);
+	printf
+	    ("\t--inversions=<n>- number of inversions per group [infinite]\n");
 	printf("\t--report=<path>\t- output to file [/dev/null]\n");
 	printf("\t--rr\t\t- use SCHED_RR for test threads [SCHED_FIFO]\n");
 	printf("\t--prompt\t- prompt before starting the test\n");
-	printf("\t--uniprocessor\t- force all threads to run on one processor\n");
+	printf
+	    ("\t--uniprocessor\t- force all threads to run on one processor\n");
 	printf("\t--mlockall\t- lock current and future memory\n");
 	printf("\t--debug\t\t- turn on debug prints\n");
 	printf("\t--version\t- print version number on output\n");
@@ -977,8 +1004,7 @@ usage(void)
 }
 
 // block all signals (called from main)
-int
-block_signals(void)
+int block_signals(void)
 {
 	int status;
 	sigset_t sigset;
@@ -998,8 +1024,7 @@ block_signals(void)
 }
 
 // allow SIGTERM delivery (called from worker threads)
-int
-allow_sigterm(void)
+int allow_sigterm(void)
 {
 	int status;
 	sigset_t sigset;
@@ -1033,8 +1058,7 @@ void set_shutdown_flag(void)
 }
 
 // set up a test group
-int
-initialize_group(struct group_parameters *group)
+int initialize_group(struct group_parameters *group)
 {
 	int status;
 	pthread_mutexattr_t mutex_attr;
@@ -1050,13 +1074,12 @@ initialize_group(struct group_parameters *group)
 	}
 
 	/* set priority inheritance attribute for mutex */
-	status = pthread_mutexattr_setprotocol(&mutex_attr, 
+	status = pthread_mutexattr_setprotocol(&mutex_attr,
 					       PTHREAD_PRIO_INHERIT);
 	if (status) {
 		error("setting mutex attribute policy: %s\n", strerror(status));
 		return FAILURE;
 	}
-
 	// initialize the group mutex
 	status = pthread_mutex_init(&group->mutex, &mutex_attr);
 	if (status) {
@@ -1066,21 +1089,21 @@ initialize_group(struct group_parameters *group)
 
 	/* initialize the group barriers */
 	if (barrier_init(&group->start_barrier, NULL, NUM_TEST_THREADS,
-				"start_barrier"))
-			return FAILURE;
+			 "start_barrier"))
+		return FAILURE;
 
 	if (barrier_init(&group->locked_barrier, NULL, 2, "locked_barrier"))
 		return FAILURE;
 
-
 	if (barrier_init(&group->elevate_barrier, NULL, 2, "elevate_barrier"))
 		return FAILURE;
 
-	if (barrier_init(&group->finish_barrier, NULL, NUM_TEST_THREADS, "finish_barrier"))
+	if (barrier_init
+	    (&group->finish_barrier, NULL, NUM_TEST_THREADS, "finish_barrier"))
 		return FAILURE;
 
 	if (barrier_init(&group->loop_barr, NULL, NUM_TEST_THREADS,
-				"loop_barrier"))
+			 "loop_barrier"))
 		return FAILURE;
 
 	if ((status = pthread_mutex_init(&group->loop_mtx, NULL)) != 0) {
@@ -1101,10 +1124,10 @@ initialize_group(struct group_parameters *group)
 	}
 
 	return SUCCESS;
-}	
+}
+
 // setup and create a groups threads
-int
-create_group(struct group_parameters *group)
+int create_group(struct group_parameters *group)
 {
 	int status;
 	pthread_attr_t thread_attr;
@@ -1126,10 +1149,8 @@ create_group(struct group_parameters *group)
 	debug("creating low priority thread\n");
 	if (setup_thread_attr(&thread_attr, LOW_PRIO(), &mask, policy))
 		return FAILURE;
-	status = pthread_create(&group->low_tid, 
-				&thread_attr, 
-				low_priority, 
-				group);
+	status = pthread_create(&group->low_tid,
+				&thread_attr, low_priority, group);
 	if (status != 0) {
 		error("creating low_priority thread: %s\n", strerror(status));
 		return FAILURE;
@@ -1140,9 +1161,7 @@ create_group(struct group_parameters *group)
 	if (setup_thread_attr(&thread_attr, MED_PRIO(), &mask, policy))
 		return FAILURE;
 	status = pthread_create(&group->med_tid,
-				&thread_attr, 
-				med_priority, 
-				group);
+				&thread_attr, med_priority, group);
 	if (status != 0) {
 		error("creating med_priority thread: %s\n", strerror(status));
 		return FAILURE;
@@ -1153,9 +1172,7 @@ create_group(struct group_parameters *group)
 	if (setup_thread_attr(&thread_attr, HIGH_PRIO(), &mask, policy))
 		return FAILURE;
 	status = pthread_create(&group->high_tid,
-				&thread_attr, 
-				high_priority, 
-				group);
+				&thread_attr, high_priority, group);
 	if (status != 0) {
 		error("creating high_priority thread: %s\n", strerror(status));
 		set_shutdown_flag();
@@ -1164,8 +1181,7 @@ create_group(struct group_parameters *group)
 	return SUCCESS;
 }
 
-void
-process_command_line(int argc, char **argv)
+void process_command_line(int argc, char **argv)
 {
 	int opt;
 	while ((opt = getopt_long(argc, argv, "+", options, NULL)) != -1) {
@@ -1216,8 +1232,7 @@ process_command_line(int argc, char **argv)
 }
 
 // total the number of inversions that have been performed
-unsigned long
-total_inversions(void)
+unsigned long total_inversions(void)
 {
 	int i;
 	unsigned long total = 0;
@@ -1242,8 +1257,8 @@ void banner(void)
 		printf("Number of inversions per group: unlimited\n");
 	else
 		printf("Number of inversions per group: %d\n", inversions);
-	printf("Test threads using scheduler policy: %s\n", 
-	     policy == SCHED_FIFO ? "SCHED_FIFO" : "SCHED_RR");
+	printf("Test threads using scheduler policy: %s\n",
+	       policy == SCHED_FIFO ? "SCHED_FIFO" : "SCHED_RR");
 	printf("    Admin thread priority:  %d\n", MAIN_PRIO());
 	printf("%d groups of 3 threads will be created\n", ngroups);
 	printf("    High thread priority:   %d\n", HIGH_PRIO());
@@ -1251,20 +1266,19 @@ void banner(void)
 	printf("    Low thread priority:    %d\n", LOW_PRIO());
 }
 
-
 void summary(void)
 {
 	time_t interval = finish - start;
 	struct tm *t = gmtime(&interval);
-	
+
 	printf("Total inversion performed: %lu\n", total_inversions());
 	printf("Test Duration: %d days, %d hours, %d minutes, %d seconds\n",
-		   t->tm_yday, t->tm_hour, t->tm_min, t->tm_sec);
+	       t->tm_yday, t->tm_hour, t->tm_min, t->tm_sec);
 }
 
 int
-barrier_init(pthread_barrier_t *b, const pthread_barrierattr_t *attr,
-		unsigned count, const char *name)
+barrier_init(pthread_barrier_t * b, const pthread_barrierattr_t * attr,
+	     unsigned count, const char *name)
 {
 	int status;
 
@@ -1276,4 +1290,3 @@ barrier_init(pthread_barrier_t *b, const pthread_barrierattr_t *attr,
 
 	return SUCCESS;
 }
