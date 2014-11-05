From: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [RFC v0 5/9] pi_stress: Use error.h for logging and debugging
Date: Wed,  5 Nov 2014 10:09:41 +0100
Message-ID: <1415178585-3192-6-git-send-email-daniel.wagner@bmw-carit.de>
References: <1415178585-3192-1-git-send-email-daniel.wagner@bmw-carit.de>
Cc: linux-rt-users@vger.kernel.org,
	Daniel Wagner <daniel.wagner@bmw-carit.de>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.bmw-carit.de ([62.245.222.98]:52825 "EHLO
	linuxmail.bmw-carit.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753375AbaKEJJw (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 5 Nov 2014 04:09:52 -0500
In-Reply-To: <1415178585-3192-1-git-send-email-daniel.wagner@bmw-carit.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

In order to be able to use some of the rt-utils.h function we need
to get rid of our own info() & friends implementation.

Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
---
 src/pi_tests/pi_stress.c | 255 +++++++++++++++++++++--------------------------
 1 file changed, 115 insertions(+), 140 deletions(-)

diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
index 39e6a37..d834b86 100644
--- a/src/pi_tests/pi_stress.c
+++ b/src/pi_tests/pi_stress.c
@@ -55,6 +55,8 @@
 #include <sys/wait.h>
 #include <termios.h>
 
+#include "error.h"
+
 /* conversions */
 #define USEC_PER_SEC 	1000000
 #define NSEC_PER_SEC 	1000000000
@@ -85,6 +87,13 @@
 #define UP_ONE "\033[1A"
 #define DOWN_ONE "\033[1B"
 
+#define pi_info(fmt, arg...) \
+	do { if (verbose) info(fmt, ## arg); } while (0)
+#define pi_debug(fmt, arg...) \
+	do { if (debugging) debug(fmt, ## arg); } while (0)
+#define pi_error(fmt, arg...) \
+	do { err_msg(fmt, ## arg); have_errors = 1; } while (0)
+
 /* the length of the test */
 /* default is infinite */
 int duration = -1;
@@ -102,7 +111,7 @@ int inversions = -1;
 /* turn on lots of prints */
 int verbose = 0;
 
-/* turn on debugging prints */
+/* turn on pi_debugging prints */
 int debugging = 0;
 
 int quiet = 0;	/* turn off all prints, default = 0 (off) */
@@ -220,9 +229,6 @@ void *watchdog(void *arg);
 int setup_thread_attr(pthread_attr_t * attr, int prio, cpu_set_t * mask,
 		      int schedpolicy);
 int set_cpu_affinity(cpu_set_t * test_mask, cpu_set_t * admin_mask);
-void error(char *, ...);
-void info(char *, ...);
-void debug(char *, ...);
 void process_command_line(int argc, char **argv);
 void usage(void);
 int block_signals(void);
@@ -261,7 +267,7 @@ int main(int argc, char **argv)
 	/* lock memory */
 	if (lockall)
 		if (mlockall(MCL_CURRENT | MCL_FUTURE) == -1) {
-			error("mlockall failed\n");
+			pi_error("mlockall failed\n");
 			return FAILURE;
 		}
 	/* boost main's priority (so we keep running) :) */
@@ -269,7 +275,7 @@ int main(int argc, char **argv)
 	thread_param.sched_priority = MAIN_PRIO();
 	status = pthread_setschedparam(pthread_self(), policy, &thread_param);
 	if (status) {
-		error("main: boosting to max priority: 0x%x\n", status);
+		pi_error("main: boosting to max priority: 0x%x\n", status);
 		return FAILURE;
 	}
 	/* block unwanted signals */
@@ -278,7 +284,7 @@ int main(int argc, char **argv)
 	/* allocate our groups array */
 	groups = calloc(ngroups, sizeof(struct group_parameters));
 	if (groups == NULL) {
-		error("main: failed to allocate %d groups\n", ngroups);
+		pi_error("main: failed to allocate %d groups\n", ngroups);
 		return FAILURE;
 	}
 	/* set up CPU affinity masks */
@@ -297,7 +303,7 @@ int main(int argc, char **argv)
 		return FAILURE;
 
 	/* create the groups */
-	info("Creating %d test groups\n", ngroups);
+	pi_info("Creating %d test groups\n", ngroups);
 	for (core = 0; core < num_processors; core++)
 		if (CPU_ISSET(core, &test_cpu_mask))
 			break;
@@ -320,10 +326,10 @@ int main(int argc, char **argv)
 	start = time(NULL);
 
 	/* turn loose the threads */
-	info("Releasing all threads\n");
+	pi_info("Releasing all threads\n");
 	status = pthread_barrier_wait(&all_threads_ready);
 	if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
-		error("main: pthread_barrier_wait(all_threads_ready): 0x%x\n",
+		pi_error("main: pthread_barrier_wait(all_threads_ready): 0x%x\n",
 		      status);
 		set_shutdown_flag();
 		return FAILURE;
@@ -339,15 +345,15 @@ int main(int argc, char **argv)
 
 	/* wait for all threads to notice the shutdown flag */
 	if (have_errors == 0 && interrupted == 0) {
-		info("waiting for all threads to complete\n");
+		pi_info("waiting for all threads to complete\n");
 		status = pthread_barrier_wait(&all_threads_done);
 		if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
-			error
+			pi_error
 			    ("main: pthread_barrier_wait(all_threads_ready): 0x%x\n",
 			     status);
 			return FAILURE;
 		}
-		info("All threads terminated!\n");
+		pi_info("All threads terminated!\n");
 		retval = SUCCESS;
 	} else
 		kill(0, SIGTERM);
@@ -367,14 +373,14 @@ setup_thread_attr(pthread_attr_t * attr, int prio, cpu_set_t * mask,
 
 	status = pthread_attr_init(attr);
 	if (status) {
-		error
+		pi_error
 		    ("setup_thread_attr: initializing thread attribute: 0x%x\n",
 		     status);
 		return FAILURE;
 	}
 	status = pthread_attr_setschedpolicy(attr, schedpolicy);
 	if (status) {
-		error
+		pi_error
 		    ("setup_thread_attr: setting attribute policy to %s: 0x%x\n",
 		     schedpolicy == SCHED_FIFO ? "SCHED_FIFO" : "SCHED_RR",
 		     status);
@@ -382,7 +388,7 @@ setup_thread_attr(pthread_attr_t * attr, int prio, cpu_set_t * mask,
 	}
 	status = pthread_attr_setinheritsched(attr, PTHREAD_EXPLICIT_SCHED);
 	if (status) {
-		error
+		pi_error
 		    ("setup_thread_attr: setting explicit scheduling inheritance: 0x%x\n",
 		     status);
 		return FAILURE;
@@ -390,13 +396,13 @@ setup_thread_attr(pthread_attr_t * attr, int prio, cpu_set_t * mask,
 	thread_param.sched_priority = prio;
 	status = pthread_attr_setschedparam(attr, &thread_param);
 	if (status) {
-		error("setup_thread_attr: setting scheduler param: 0x%x\n",
+		pi_error("setup_thread_attr: setting scheduler param: 0x%x\n",
 		      status);
 		return FAILURE;
 	}
 	status = pthread_attr_setaffinity_np(attr, sizeof(cpu_set_t), mask);
 	if (status) {
-		error("setup_thread_attr: setting affinity attribute: 0x%x\n",
+		pi_error("setup_thread_attr: setting affinity attribute: 0x%x\n",
 		      status);
 		return FAILURE;
 	}
@@ -414,14 +420,14 @@ int set_cpu_affinity(cpu_set_t * test_mask, cpu_set_t * admin_mask)
 		CPU_ZERO(test_mask);
 		CPU_SET(0, admin_mask);
 		CPU_SET(0, test_mask);
-		info("admin and test threads running on one processor\n");
+		pi_info("admin and test threads running on one processor\n");
 		return SUCCESS;
 	}
 	/* first set our main thread to run on the first
 	   scheduleable processor we can find */
 	status = sched_getaffinity(0, sizeof(cpu_set_t), &current_mask);
 	if (status) {
-		error("failed getting CPU affinity mask: 0x%x\n", status);
+		pi_error("failed getting CPU affinity mask: 0x%x\n", status);
 		return FAILURE;
 	}
 	for (i = 0; i < num_processors; i++) {
@@ -429,7 +435,7 @@ int set_cpu_affinity(cpu_set_t * test_mask, cpu_set_t * admin_mask)
 			break;
 	}
 	if (i >= num_processors) {
-		error("No schedulable CPU found for main!\n");
+		pi_error("No schedulable CPU found for main!\n");
 		return FAILURE;
 	}
 	admin_proc = i;
@@ -437,11 +443,11 @@ int set_cpu_affinity(cpu_set_t * test_mask, cpu_set_t * admin_mask)
 	CPU_SET(admin_proc, admin_mask);
 	status = sched_setaffinity(0, sizeof(cpu_set_t), admin_mask);
 	if (status) {
-		error("set_cpu_affinity: setting CPU affinity mask: 0x%x\n",
+		pi_error("set_cpu_affinity: setting CPU affinity mask: 0x%x\n",
 		      status);
 		return FAILURE;
 	}
-	info("Admin thread running on processor: %d\n", i);
+	pi_info("Admin thread running on processor: %d\n", i);
 
 	/* Set test affinity so that tests run on the non-admin processors */
 	CPU_ZERO(test_mask);
@@ -449,10 +455,10 @@ int set_cpu_affinity(cpu_set_t * test_mask, cpu_set_t * admin_mask)
 		CPU_SET(i, test_mask);
 
 	if (admin_proc + 1 == num_processors - 1)
-		info("Test threads running on processor: %ld\n",
+		pi_info("Test threads running on processor: %ld\n",
 		     num_processors - 1);
 	else
-		info("Test threads running on processors:  %d-%d\n",
+		pi_info("Test threads running on processors:  %d-%d\n",
 		     admin_proc + 1, (int)num_processors - 1);
 
 	return SUCCESS;
@@ -480,7 +486,7 @@ int watchdog_check(void)
 			if (g->inversions == g->total)
 				continue;
 			if (++g->watchdog_hits >= WATCHDOG_LIMIT) {
-				error
+				pi_error
 				    ("WATCHDOG triggered: group %d is deadlocked!\n",
 				     i);
 				failures++;
@@ -496,7 +502,7 @@ int pending_interrupt(void)
 	sigset_t pending;
 
 	if (sigpending(&pending) < 0) {
-		error("from sigpending: %s\n", strerror(errno));
+		pi_error("from sigpending: %s\n", strerror(errno));
 		return 0;
 	}
 
@@ -533,12 +539,12 @@ void *reporter(void *arg)
 	/* sleep initially to let everything get up and running */
 	status = clock_nanosleep(CLOCK_MONOTONIC, 0, &ts, NULL);
 	if (status) {
-		error("from clock_nanosleep: %s\n", strerror(status));
+		pi_error("from clock_nanosleep: %s\n", strerror(status));
 		return NULL;
 	}
 
-	debug("reporter: starting report loop\n");
-	info("Press Control-C to stop test\nCurrent Inversions: \n");
+	pi_debug("reporter: starting report loop\n");
+	pi_info("Press Control-C to stop test\nCurrent Inversions: \n");
 
 	for (;;) {
 		pthread_mutex_lock(&shutdown_mtx);
@@ -551,7 +557,7 @@ void *reporter(void *arg)
 		/* wait for our reporting interval */
 		status = clock_nanosleep(CLOCK_MONOTONIC, 0, &ts, NULL);
 		if (status) {
-			error("from clock_nanosleep: %s\n", strerror(status));
+			pi_error("from clock_nanosleep: %s\n", strerror(status));
 			break;
 		}
 
@@ -568,18 +574,18 @@ void *reporter(void *arg)
 
 		/* if we specified a duration, see if it has expired */
 		if (end && time(NULL) > end) {
-			info("duration reached (%d seconds)\n", duration);
+			pi_info("duration reached (%d seconds)\n", duration);
 			set_shutdown_flag();
 			continue;
 		}
 		/* check for a pending SIGINT */
 		if (pending_interrupt()) {
-			info("Keyboard Interrupt!\n");
+			pi_info("Keyboard Interrupt!\n");
 			break;
 		}
 		/* check watchdog stuff */
 		if ((watchdog_check())) {
-			error("reporter stopping due to watchdog event\n");
+			pi_error("reporter stopping due to watchdog event\n");
 			set_shutdown_flag();
 			break;
 		}
@@ -587,7 +593,7 @@ void *reporter(void *arg)
 		watchdog_clear();
 
 	}
-	debug("reporter: finished\n");
+	pi_debug("reporter: finished\n");
 	set_shutdown_flag();
 	return NULL;
 }
@@ -625,15 +631,15 @@ void *low_priority(void *arg)
 	allow_sigterm();
 
 	if (verify_cpu(p->cpu) != SUCCESS) {
-		error("low_priority[%d]: not bound to %ld\n", p->id, p->cpu);
+		pi_error("low_priority[%d]: not bound to %ld\n", p->id, p->cpu);
 		return NULL;
 	}
 
-	debug("low_priority[%d]: entering ready state\n", p->id);
+	pi_debug("low_priority[%d]: entering ready state\n", p->id);
 	/* wait for all threads to be ready */
 	status = pthread_barrier_wait(&all_threads_ready);
 	if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
-		error
+		pi_error
 		    ("low_priority[%d]: pthread_barrier_wait(all_threads_ready): %x",
 		     p->id, status);
 		return NULL;
@@ -641,7 +647,7 @@ void *low_priority(void *arg)
 
 	unbounded = (p->inversions < 0);
 
-	debug("low_priority[%d]: starting inversion loop\n", p->id);
+	pi_debug("low_priority[%d]: starting inversion loop\n", p->id);
 
 	for (;;) {
 		/*
@@ -662,7 +668,7 @@ void *low_priority(void *arg)
 
 		status = pthread_barrier_wait(loop_barr);
 		if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
-			error("%s[%d]: pthread_barrier_wait(loop): %x\n",
+			pi_error("%s[%d]: pthread_barrier_wait(loop): %x\n",
 			      __func__, p->id, status);
 			return NULL;
 		}
@@ -679,63 +685,63 @@ void *low_priority(void *arg)
 		}
 
 		/* initial state */
-		debug("low_priority[%d]: entering start wait (%d)\n", p->id,
+		pi_debug("low_priority[%d]: entering start wait (%d)\n", p->id,
 		      count++);
 		status = pthread_barrier_wait(&p->start_barrier);
 		if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
-			error
+			pi_error
 			    ("low_priority[%d]: pthread_barrier_wait(start): %x\n",
 			     p->id, status);
 			return NULL;
 		}
 
-		debug("low_priority[%d]: claiming mutex\n", p->id);
+		pi_debug("low_priority[%d]: claiming mutex\n", p->id);
 		pthread_mutex_lock(&p->mutex);
-		debug("low_priority[%d]: mutex locked\n", p->id);
+		pi_debug("low_priority[%d]: mutex locked\n", p->id);
 
-		debug("low_priority[%d]: entering locked wait\n", p->id);
+		pi_debug("low_priority[%d]: entering locked wait\n", p->id);
 		status = pthread_barrier_wait(&p->locked_barrier);
 		if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
-			error
+			pi_error
 			    ("low_priority[%d]: pthread_barrier_wait(locked): %x\n",
 			     p->id, status);
 			return NULL;
 		}
 		/* wait for priority boost */
-		debug("low_priority[%d]: entering elevated wait\n", p->id);
+		pi_debug("low_priority[%d]: entering elevated wait\n", p->id);
 		status = pthread_barrier_wait(&p->elevate_barrier);
 		if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
-			error
+			pi_error
 			    ("low_priority[%d]: pthread_barrier_wait(elevate): %x\n",
 			     p->id, status);
 			return NULL;
 		}
 
 		/* release the mutex */
-		debug("low_priority[%d]: unlocking mutex\n", p->id);
+		pi_debug("low_priority[%d]: unlocking mutex\n", p->id);
 		pthread_mutex_unlock(&p->mutex);
 
 		/* finish state */
-		debug("low_priority[%d]: entering finish wait\n", p->id);
+		pi_debug("low_priority[%d]: entering finish wait\n", p->id);
 		status = pthread_barrier_wait(&p->finish_barrier);
 		if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
-			error
+			pi_error
 			    ("low_priority[%d]: pthread_barrier_wait(elevate): %x\n",
 			     p->id, status);
 			return NULL;
 		}
 	}
 	set_shutdown_flag();
-	debug("low_priority[%d]: entering done barrier\n", p->id);
+	pi_debug("low_priority[%d]: entering done barrier\n", p->id);
 	/* wait for all threads to finish */
 	status = pthread_barrier_wait(&all_threads_done);
 	if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
-		error
+		pi_error
 		    ("low_priority[%d]: pthread_barrier_wait(all_threads_done): %x",
 		     p->id, status);
 		return NULL;
 	}
-	debug("low_priority[%d]: exiting\n", p->id);
+	pi_debug("low_priority[%d]: exiting\n", p->id);
 	return NULL;
 }
 
@@ -752,15 +758,15 @@ void *med_priority(void *arg)
 	allow_sigterm();
 
 	if (verify_cpu(p->cpu) != SUCCESS) {
-		error("med_priority[%d]: not bound to %ld\n", p->id, p->cpu);
+		pi_error("med_priority[%d]: not bound to %ld\n", p->id, p->cpu);
 		return NULL;
 	}
 
-	debug("med_priority[%d]: entering ready state\n", p->id);
+	pi_debug("med_priority[%d]: entering ready state\n", p->id);
 	/* wait for all threads to be ready */
 	status = pthread_barrier_wait(&all_threads_ready);
 	if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
-		error
+		pi_error
 		    ("med_priority[%d]: pthread_barrier_wait(all_threads_ready): %x",
 		     p->id, status);
 		return NULL;
@@ -768,7 +774,7 @@ void *med_priority(void *arg)
 
 	unbounded = (p->inversions < 0);
 
-	debug("med_priority[%d]: starting inversion loop\n", p->id);
+	pi_debug("med_priority[%d]: starting inversion loop\n", p->id);
 	for (;;) {
 		if (!unbounded && (p->total >= p->inversions)) {
 			set_shutdown_flag();
@@ -783,7 +789,7 @@ void *med_priority(void *arg)
 
 		status = pthread_barrier_wait(loop_barr);
 		if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
-			error("%s[%d]: pthread_barrier_wait(loop): %x\n",
+			pi_error("%s[%d]: pthread_barrier_wait(loop): %x\n",
 			      __func__, p->id, status);
 			return NULL;
 		}
@@ -800,26 +806,26 @@ void *med_priority(void *arg)
 		}
 
 		/* start state */
-		debug("med_priority[%d]: entering start state (%d)\n", p->id,
+		pi_debug("med_priority[%d]: entering start state (%d)\n", p->id,
 		      count++);
 		status = pthread_barrier_wait(&p->start_barrier);
 		if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
-			error
+			pi_error
 			    ("med_priority[%d]: pthread_barrier_wait(start): %x",
 			     p->id, status);
 			return NULL;
 		}
-		debug("med_priority[%d]: entering elevate state\n", p->id);
+		pi_debug("med_priority[%d]: entering elevate state\n", p->id);
 		status = pthread_barrier_wait(&p->elevate_barrier);
 		if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
-			error ("med_priority[%d]: pthread_barrier_wait(elevate): %x", p->id, status);
+			pi_error ("med_priority[%d]: pthread_barrier_wait(elevate): %x", p->id, status);
 			return NULL;
 		}
 
-		debug("med_priority[%d]: entering finish state\n", p->id);
+		pi_debug("med_priority[%d]: entering finish state\n", p->id);
 		status = pthread_barrier_wait(&p->finish_barrier);
 		if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
-			error
+			pi_error
 			    ("med_priority[%d]: pthread_barrier_wait(finished): %x",
 			     p->id, status);
 			return NULL;
@@ -827,19 +833,19 @@ void *med_priority(void *arg)
 	}
 	set_shutdown_flag();
 
-	debug("med_priority[%d]: entering done barrier\n", p->id);
+	pi_debug("med_priority[%d]: entering done barrier\n", p->id);
 	/* wait for all threads to finish */
 	if (have_errors == 0) {
 		status = pthread_barrier_wait(&all_threads_done);
 		if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
-			error
+			pi_error
 			    ("med_priority[%d]: pthread_barrier_wait(all_threads_done): %x",
 			     p->id, status);
 			return NULL;
 		}
 	}
 	/* exit */
-	debug("med_priority[%d]: exiting\n", p->id);
+	pi_debug("med_priority[%d]: exiting\n", p->id);
 	return NULL;
 }
 
@@ -855,22 +861,22 @@ void *high_priority(void *arg)
 
 	allow_sigterm();
 	if (verify_cpu(p->cpu) != SUCCESS) {
-		error("high_priority[%d]: not bound to %ld\n", p->id, p->cpu);
+		pi_error("high_priority[%d]: not bound to %ld\n", p->id, p->cpu);
 		return NULL;
 	}
 
-	debug("high_priority[%d]: entering ready state\n", p->id);
+	pi_debug("high_priority[%d]: entering ready state\n", p->id);
 
 	/* wait for all threads to be ready */
 	status = pthread_barrier_wait(&all_threads_ready);
 	if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
-		error
+		pi_error
 		    ("high_priority[%d]: pthread_barrier_wait(all_threads_ready): %x",
 		     p->id, status);
 		return NULL;
 	}
 	unbounded = (p->inversions < 0);
-	debug("high_priority[%d]: starting inversion loop\n", p->id);
+	pi_debug("high_priority[%d]: starting inversion loop\n", p->id);
 	for (;;) {
 		if (!unbounded && (p->total >= p->inversions)) {
 			set_shutdown_flag();
@@ -886,7 +892,7 @@ void *high_priority(void *arg)
 
 		status = pthread_barrier_wait(loop_barr);
 		if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
-			error("%s[%d]: pthread_barrier_wait(loop): %x\n",
+			pi_error("%s[%d]: pthread_barrier_wait(loop): %x\n",
 			      __func__, p->id, status);
 			return NULL;
 		}
@@ -901,35 +907,35 @@ void *high_priority(void *arg)
 			}
 			pthread_mutex_unlock(&shutdown_mtx);
 		}
-		debug("high_priority[%d]: entering start state (%d)\n", p->id,
+		pi_debug("high_priority[%d]: entering start state (%d)\n", p->id,
 		      count++);
 		status = pthread_barrier_wait(&p->start_barrier);
 		if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
-			error
+			pi_error
 			    ("high_priority[%d]: pthread_barrier_wait(start): %x",
 			     p->id, status);
 			return NULL;
 		}
 
-		debug("high_priority[%d]: entering running state\n", p->id);
+		pi_debug("high_priority[%d]: entering running state\n", p->id);
 		status = pthread_barrier_wait(&p->locked_barrier);
 		if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
-			error
+			pi_error
 			    ("high_priority[%d]: pthread_barrier_wait(running): %x",
 			     p->id, status);
 			return NULL;
 		}
-		debug("high_priority[%d]: locking mutex\n", p->id);
+		pi_debug("high_priority[%d]: locking mutex\n", p->id);
 		pthread_mutex_lock(&p->mutex);
-		debug("high_priority[%d]: got mutex\n", p->id);
+		pi_debug("high_priority[%d]: got mutex\n", p->id);
 
-		debug("high_priority[%d]: unlocking mutex\n", p->id);
+		pi_debug("high_priority[%d]: unlocking mutex\n", p->id);
 		pthread_mutex_unlock(&p->mutex);
-		debug("high_priority[%d]: entering finish state\n", p->id);
+		pi_debug("high_priority[%d]: entering finish state\n", p->id);
 
 		status = pthread_barrier_wait(&p->finish_barrier);
 		if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
-			error
+			pi_error
 			    ("high_priority[%d]: pthread_barrier_wait(finish): %x",
 			     status);
 			return NULL;
@@ -943,54 +949,23 @@ void *high_priority(void *arg)
 	}
 	set_shutdown_flag();
 
-	debug("high_priority[%d]: entering done barrier\n", p->id);
+	pi_debug("high_priority[%d]: entering done barrier\n", p->id);
 
 	if (have_errors == 0) {
 		/* wait for all threads to finish */
 		status = pthread_barrier_wait(&all_threads_done);
 		if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
-			error
+			pi_error
 			    ("high_priority[%d]: pthread_barrier_wait(all_threads_done): %x",
 			     p->id, status);
 			return NULL;
 		}
 	}
 	/* exit */
-	debug("high_priority[%d]: exiting\n", p->id);
+	pi_debug("high_priority[%d]: exiting\n", p->id);
 	return NULL;
 }
 
-void error(char *fmt, ...)
-{
-	va_list ap;
-	fputs("ERROR: ", stderr);
-	va_start(ap, fmt);
-	vfprintf(stderr, fmt, ap);
-	va_end(ap);
-	have_errors = 1;
-}
-
-void info(char *fmt, ...)
-{
-	if (verbose) {
-		va_list ap;
-		va_start(ap, fmt);
-		vprintf(fmt, ap);
-		va_end(ap);
-	}
-}
-
-void debug(char *fmt, ...)
-{
-	if (debugging) {
-		va_list ap;
-		fputs("DEBUG: ", stderr);
-		va_start(ap, fmt);
-		vfprintf(stderr, fmt, ap);
-		va_end(ap);
-	}
-}
-
 void usage(void)
 {
 	printf("usage: pi_stress <options>\n");
@@ -1023,12 +998,12 @@ int block_signals(void)
 	/* mask off all signals */
 	status = sigfillset(&sigset);
 	if (status) {
-		error("setting up full signal set %s\n", strerror(status));
+		pi_error("setting up full signal set %s\n", strerror(status));
 		return FAILURE;
 	}
 	status = pthread_sigmask(SIG_BLOCK, &sigset, NULL);
 	if (status) {
-		error("setting signal mask: %s\n", strerror(status));
+		pi_error("setting signal mask: %s\n", strerror(status));
 		return FAILURE;
 	}
 	return SUCCESS;
@@ -1042,17 +1017,17 @@ int allow_sigterm(void)
 
 	status = sigemptyset(&sigset);
 	if (status) {
-		error("creating empty signal set: %s\n", strerror(status));
+		pi_error("creating empty signal set: %s\n", strerror(status));
 		return FAILURE;
 	}
 	status = sigaddset(&sigset, SIGTERM);
 	if (status) {
-		error("adding SIGTERM to signal set: %s\n", strerror(status));
+		pi_error("adding SIGTERM to signal set: %s\n", strerror(status));
 		return FAILURE;
 	}
 	status = pthread_sigmask(SIG_UNBLOCK, &sigset, NULL);
 	if (status) {
-		error("unblocking SIGTERM: %s\n", strerror(status));
+		pi_error("unblocking SIGTERM: %s\n", strerror(status));
 		return FAILURE;
 	}
 	return SUCCESS;
@@ -1064,7 +1039,7 @@ void set_shutdown_flag(void)
 	pthread_mutex_lock(&shutdown_mtx);
 	if (shutdown == 0) {
 		/* tell anyone that's looking that we're done */
-		info("setting shutdown flag\n");
+		pi_info("setting shutdown flag\n");
 		shutdown = 1;
 	}
 	pthread_mutex_unlock(&shutdown_mtx);
@@ -1082,7 +1057,7 @@ int initialize_group(struct group_parameters *group)
 	/* (make it a PI mutex) */
 	status = pthread_mutexattr_init(&mutex_attr);
 	if (status) {
-		error("initializing mutex attribute: %s\n", strerror(status));
+		pi_error("initializing mutex attribute: %s\n", strerror(status));
 		return FAILURE;
 	}
 
@@ -1090,13 +1065,13 @@ int initialize_group(struct group_parameters *group)
 	status = pthread_mutexattr_setprotocol(&mutex_attr,
 					       PTHREAD_PRIO_INHERIT);
 	if (status) {
-		error("setting mutex attribute policy: %s\n", strerror(status));
+		pi_error("setting mutex attribute policy: %s\n", strerror(status));
 		return FAILURE;
 	}
 	/* initialize the group mutex */
 	status = pthread_mutex_init(&group->mutex, &mutex_attr);
 	if (status) {
-		error("initializing mutex: %s\n", strerror(status));
+		pi_error("initializing mutex: %s\n", strerror(status));
 		return FAILURE;
 	}
 
@@ -1120,19 +1095,19 @@ int initialize_group(struct group_parameters *group)
 		return FAILURE;
 
 	if ((status = pthread_mutex_init(&group->loop_mtx, NULL)) != 0) {
-		error("pthread_mutex_init, status = %d\n", status);
+		pi_error("pthread_mutex_init, status = %d\n", status);
 		return FAILURE;
 	}
 
 	if ((status = pthread_mutex_lock(&group->loop_mtx)) != 0) {
-		error("pthread_mutex_lock, status = %d\n", status);
+		pi_error("pthread_mutex_lock, status = %d\n", status);
 		return FAILURE;
 	}
 
 	group->loop = 1;
 
 	if ((status = pthread_mutex_unlock(&group->loop_mtx)) != 0) {
-		error("pthread_mutex_unlock, status = %d\n", status);
+		pi_error("pthread_mutex_unlock, status = %d\n", status);
 		return FAILURE;
 	}
 
@@ -1149,45 +1124,45 @@ int create_group(struct group_parameters *group)
 	/* initialize group structure */
 	status = initialize_group(group);
 	if (status) {
-		error("initializing group %d\n", group->id);
+		pi_error("initializing group %d\n", group->id);
 		return FAILURE;
 	}
 
 	CPU_ZERO(&mask);
 	CPU_SET(group->cpu, &mask);
 
-	debug("group %d bound to cpu %ld\n", group->id, group->cpu);
+	pi_debug("group %d bound to cpu %ld\n", group->id, group->cpu);
 
 	/* start the low priority thread */
-	debug("creating low priority thread\n");
+	pi_debug("creating low priority thread\n");
 	if (setup_thread_attr(&thread_attr, LOW_PRIO(), &mask, policy))
 		return FAILURE;
 	status = pthread_create(&group->low_tid,
 				&thread_attr, low_priority, group);
 	if (status != 0) {
-		error("creating low_priority thread: %s\n", strerror(status));
+		pi_error("creating low_priority thread: %s\n", strerror(status));
 		return FAILURE;
 	}
 
 	/* create the medium priority thread */
-	debug("creating medium priority thread\n");
+	pi_debug("creating medium priority thread\n");
 	if (setup_thread_attr(&thread_attr, MED_PRIO(), &mask, policy))
 		return FAILURE;
 	status = pthread_create(&group->med_tid,
 				&thread_attr, med_priority, group);
 	if (status != 0) {
-		error("creating med_priority thread: %s\n", strerror(status));
+		pi_error("creating med_priority thread: %s\n", strerror(status));
 		return FAILURE;
 	}
 
 	/* create the high priority thread */
-	debug("creating high priority thread\n");
+	pi_debug("creating high priority thread\n");
 	if (setup_thread_attr(&thread_attr, HIGH_PRIO(), &mask, policy))
 		return FAILURE;
 	status = pthread_create(&group->high_tid,
 				&thread_attr, high_priority, group);
 	if (status != 0) {
-		error("creating high_priority thread: %s\n", strerror(status));
+		pi_error("creating high_priority thread: %s\n", strerror(status));
 		set_shutdown_flag();
 		return FAILURE;
 	}
@@ -1216,11 +1191,11 @@ void process_command_line(int argc, char **argv)
 			break;
 		case 'i':
 			inversions = strtol(optarg, NULL, 10);
-			info("doing %d inversion per group\n", inversions);
+			pi_info("doing %d inversion per group\n", inversions);
 			break;
 		case 'g':
 			ngroups = strtol(optarg, NULL, 10);
-			info("number of groups set to %d\n", ngroups);
+			pi_info("number of groups set to %d\n", ngroups);
 			break;
 		case 'r':
 			policy = SCHED_RR;
@@ -1297,8 +1272,8 @@ barrier_init(pthread_barrier_t * b, const pthread_barrierattr_t * attr,
 	int status;
 
 	if ((status = pthread_barrier_init(b, attr, count)) != 0) {
-		error("barrier_init: failed to initialize: %s\n", name);
-		error("status = %d\n", status);
+		pi_error("barrier_init: failed to initialize: %s\n", name);
+		pi_error("status = %d\n", status);
 		return FAILURE;
 	}
 
-- 
1.9.3

