From: Steven Rostedt <rostedt@goodmis.org>
Subject: Measure only latency of the actual signal.
Date: Mon, 30 Apr 2007 10:45:40 -0400
Message-ID: <1177944340.19619.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-zL1x5X6eC/JjsWpwNQjF"
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:57842 "EHLO
	ms-smtp-03.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423326AbXD3Ops (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 30 Apr 2007 10:45:48 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


--=-zL1x5X6eC/JjsWpwNQjF
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Thomas,

Here's a patch and code to your signaltest.c.

I see a lot of code being run between the recording of before and after.
This patch makes "now" global to all threads, which is recorded just
before the "kill". The after is still recorded after the second thread
receives the signal.  Then the "before" is assigned to the shared "now"
to use to calculate the latency.  This should work nicely since the
signals are sent and received serially among the threads.

-- Steve


--=-zL1x5X6eC/JjsWpwNQjF
Content-Disposition: attachment; filename=signaltest.patch
Content-Type: text/x-patch; name=signaltest.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit

--- /root/signaltest.c	2007-04-30 10:22:52.000000000 -0400
+++ ../signaltest.c	2007-04-30 10:20:20.000000000 -0400
@@ -89,6 +89,8 @@
 	return diff;
 }
 
+struct timespec now;
+
 /*
  * signal thread
  *
@@ -136,10 +138,7 @@
 			prctl(0, 1);
 	}
 
-	clock_gettime(CLOCK_MONOTONIC, &before);
-
 	while (!shutdown) {
-		struct timespec now;
 		long diff;
 		int sigs;
 
@@ -147,6 +146,7 @@
 			goto out;
 
 		clock_gettime(CLOCK_MONOTONIC, &after);
+		before = now;
 
 		/*
 		 * If it is the first thread, sleep after every 16
@@ -162,12 +162,10 @@
 		/* Skip the first cycle */
 		if (first) {
 			first = 0;
-			before = now;
 			continue;
 		}
 
 		diff = calcdiff(after, before);
-		before = now;
 		if (diff < stat->min)
 			stat->min = diff;
 		if (diff > stat->max)

--=-zL1x5X6eC/JjsWpwNQjF
Content-Disposition: attachment; filename=signaltest-new.c
Content-Type: text/x-csrc; name=signaltest-new.c; charset=us-ascii
Content-Transfer-Encoding: 7bit

/*
 * RT timer test software
 *
 * (C) 2005,2006 Thomas Gleixner <tglx@linutronix.de>
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License Veriosn
 * 2 as published by the Free Software Foundation;
 *
 */

#define VERSION_STRING "V 0.1"

#include <fcntl.h>
#include <getopt.h>
#include <pthread.h>
#include <signal.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <time.h>
#include <unistd.h>

#include <linux/unistd.h>

#include <sys/prctl.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/time.h>

#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))

/* Ugly, but .... */
#define gettid() syscall(__NR_gettid)
#define sigev_notify_thread_id _sigev_un._tid

extern int clock_nanosleep(clockid_t __clock_id, int __flags,
			   __const struct timespec *__req,
			   struct timespec *__rem);

#define USEC_PER_SEC		1000000
#define NSEC_PER_SEC		1000000000

/* Must be power of 2 ! */
#define VALBUF_SIZE		16384

/* Struct to transfer parameters to the thread */
struct thread_param {
	int id;
	int prio;
	int signal;
	unsigned long max_cycles;
	struct thread_stat *stats;
	int bufmsk;
};

/* Struct for statistics */
struct thread_stat {
	unsigned long cycles;
	unsigned long cyclesread;
	long min;
	long max;
	long act;
	double avg;
	long *values;
	pthread_t thread;
	pthread_t tothread;
	int threadstarted;
	int tid;
};

static int shutdown;
static int tracelimit = 0;
static int oldtrace = 0;

static inline void tsnorm(struct timespec *ts)
{
	while (ts->tv_nsec >= NSEC_PER_SEC) {
		ts->tv_nsec -= NSEC_PER_SEC;
		ts->tv_sec++;
	}
}

static inline long calcdiff(struct timespec t1, struct timespec t2)
{
	long diff;
	diff = USEC_PER_SEC * ((int) t1.tv_sec - (int) t2.tv_sec);
	diff += ((int) t1.tv_nsec - (int) t2.tv_nsec) / 1000;
	return diff;
}

struct timespec now;

/*
 * signal thread
 *
 */
void *signalthread(void *param)
{
	struct thread_param *par = param;
	struct sched_param schedp;
	sigset_t sigset;
	struct timespec before, after;
	struct thread_stat *stat = par->stats;
	int policy = par->prio ? SCHED_FIFO : SCHED_OTHER;
	int stopped = 0;
	int first = 1;

	if (tracelimit) {
		system("echo 1 > /proc/sys/kernel/trace_all_cpus");
		system("echo 1 > /proc/sys/kernel/trace_enabled");
		system("echo 1 > /proc/sys/kernel/trace_freerunning");
		system("echo 0 > /proc/sys/kernel/trace_print_at_crash");
		system("echo 1 > /proc/sys/kernel/trace_user_triggered");
		system("echo -1 > /proc/sys/kernel/trace_user_trigger_irq");
		system("echo 0 > /proc/sys/kernel/trace_verbose");
		system("echo 0 > /proc/sys/kernel/preempt_thresh");
		system("echo 0 > /proc/sys/kernel/wakeup_timing");
		system("echo 0 > /proc/sys/kernel/preempt_max_latency");
	}

	stat->tid = gettid();

	sigemptyset(&sigset);
	sigaddset(&sigset, par->signal);
	sigprocmask(SIG_BLOCK, &sigset, NULL);

	memset(&schedp, 0, sizeof(schedp));
	schedp.sched_priority = par->prio;
	sched_setscheduler(0, policy, &schedp);

	stat->threadstarted++;

	if (tracelimit) {
		if (oldtrace)
			gettimeofday(0,(struct timezone *)1);
		else
			prctl(0, 1);
	}

	while (!shutdown) {
		long diff;
		int sigs;

		if (sigwait(&sigset, &sigs) < 0)
			goto out;

		clock_gettime(CLOCK_MONOTONIC, &after);
		before = now;

		/*
		 * If it is the first thread, sleep after every 16
		 * round trips.
		 */
		if (!par->id && !(stat->cycles & 0x0F))
			usleep(10000);

		/* Get current time */
		clock_gettime(CLOCK_MONOTONIC, &now);
		pthread_kill(stat->tothread, SIGUSR1);

		/* Skip the first cycle */
		if (first) {
			first = 0;
			continue;
		}

		diff = calcdiff(after, before);
		if (diff < stat->min)
			stat->min = diff;
		if (diff > stat->max)
			stat->max = diff;
		stat->avg += (double) diff;

		if (!stopped && tracelimit && (diff > tracelimit)) {
			stopped++;
			if (oldtrace)
				gettimeofday(0,0);
			else
				prctl(0, 0);
			shutdown++;
		}
		stat->act = diff;
		stat->cycles++;

		if (par->bufmsk)
			stat->values[stat->cycles & par->bufmsk] = diff;

		if (par->max_cycles && par->max_cycles == stat->cycles)
			break;
	}

out:
	/* switch to normal */
	schedp.sched_priority = 0;
	sched_setscheduler(0, SCHED_OTHER, &schedp);

	stat->threadstarted = -1;

	return NULL;
}


/* Print usage information */
static void display_help(void)
{
	printf("signaltest %s\n", VERSION_STRING);
	printf("Usage:\n"
	       "signaltest <options>\n\n"
	       "-b USEC  --breaktrace=USEC send break trace command when latency > USEC\n"
	       "-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
	       "-p PRIO  --prio=PRIO       priority of highest prio thread\n"
	       "-q       --quiet           print only a summary on exit\n"
	       "-t NUM   --threads=NUM     number of threads: default=2\n"
	       "-v       --verbose         output values on stdout for statistics\n"
	       "                           format: n:c:v n=tasknum c=count v=value in us\n");
	exit(0);
}

static int priority;
static int num_threads = 2;
static int max_cycles;
static int verbose;
static int quiet;

/* Process commandline options */
static void process_options (int argc, char *argv[])
{
	int error = 0;
	for (;;) {
		int option_index = 0;
		/** Options for getopt */
		static struct option long_options[] = {
			{"breaktrace", required_argument, NULL, 'b'},
			{"loops", required_argument, NULL, 'l'},
			{"priority", required_argument, NULL, 'p'},
			{"quiet", no_argument, NULL, 'q'},
			{"threads", required_argument, NULL, 't'},
			{"verbose", no_argument, NULL, 'v'},
			{"help", no_argument, NULL, '?'},
			{NULL, 0, NULL, 0}
		};
		int c = getopt_long (argc, argv, "b:c:d:i:l:np:qrst:v",
			long_options, &option_index);
		if (c == -1)
			break;
		switch (c) {
		case 'b': tracelimit = atoi(optarg); break;
		case 'l': max_cycles = atoi(optarg); break;
		case 'p': priority = atoi(optarg); break;
		case 'q': quiet = 1; break;
		case 't': num_threads = atoi(optarg); break;
		case 'v': verbose = 1; break;
		case '?': error = 1; break;
		}
	}

	if (priority < 0 || priority > 99)
		error = 1;

	if (num_threads < 2)
		error = 1;

	if (error)
		display_help ();
}

static void check_kernel(void)
{
	size_t len;
	char ver[256];
	int fd, maj, min, sub;

	fd = open("/proc/version", O_RDONLY, 0666);
	len = read(fd, ver, 255);
	close(fd);
	ver[len-1] = 0x0;
	sscanf(ver, "Linux version %d.%d.%d", &maj, &min, &sub);
	if (maj == 2 && min == 6 && sub < 18)
		oldtrace = 1;
}

static void sighand(int sig)
{
	shutdown = 1;
}

static void print_stat(struct thread_param *par, int index, int verbose)
{
	struct thread_stat *stat = par->stats;

	if (!verbose) {
		if (quiet != 1) {
			printf("T:%2d (%5d) P:%2d C:%7lu "
			       "Min:%7ld Act:%5ld Avg:%5ld Max:%8ld\n",
			       index, stat->tid, par->prio,
			       stat->cycles, stat->min, stat->act,
			       stat->cycles ?
			       (long)(stat->avg/stat->cycles) : 0, stat->max);
		}
	} else {
		while (stat->cycles != stat->cyclesread) {
			long diff = stat->values[stat->cyclesread & par->bufmsk];
			printf("%8d:%8lu:%8ld\n", index, stat->cyclesread, diff);
			stat->cyclesread++;
		}
	}
}

int main(int argc, char **argv)
{
	sigset_t sigset;
	int signum = SIGUSR1;
	struct thread_param *par;
	struct thread_stat *stat;
	int i, ret = -1;

	if (geteuid()) {
		printf("need to run as root!\n");
		exit(-1);
	}

	process_options(argc, argv);

	check_kernel();

	sigemptyset(&sigset);
	sigaddset(&sigset, signum);
	sigprocmask (SIG_BLOCK, &sigset, NULL);

	signal(SIGINT, sighand);
	signal(SIGTERM, sighand);

	par = calloc(num_threads, sizeof(struct thread_param));
	if (!par)
		goto out;
	stat = calloc(num_threads, sizeof(struct thread_stat));
	if (!stat)
		goto outpar;

	for (i = 0; i < num_threads; i++) {
		if (verbose) {
			stat[i].values = calloc(VALBUF_SIZE, sizeof(long));
			if (!stat[i].values)
				goto outall;
			par[i].bufmsk = VALBUF_SIZE - 1;
		}

		par[i].id = i;
		par[i].prio = priority;
#if 0
		if (priority)
			priority--;
#endif
		par[i].signal = signum;
		par[i].max_cycles = max_cycles;
		par[i].stats = &stat[i];
		stat[i].min = 1000000;
		stat[i].max = -1000000;
		stat[i].avg = 0.0;
		pthread_create(&stat[i].thread, NULL, signalthread, &par[i]);
		stat[i].threadstarted = 1;
	}

	while (!shutdown) {
		int allstarted = 1;

		for (i = 0; i < num_threads; i++) {
			if (stat[i].threadstarted != 2)
				allstarted = 0;
		}
		if (!allstarted)
			continue;

		for (i = 0; i < num_threads - 1; i++)
			stat[i].tothread = stat[i+1].thread;
		stat[i].tothread = stat[0].thread;
		break;
	}
	pthread_kill(stat[0].thread, signum);

	while (!shutdown) {
		char lavg[256];
		int fd, len, allstopped = 0;

		if (!verbose && !quiet) {
			fd = open("/proc/loadavg", O_RDONLY, 0666);
			len = read(fd, &lavg, 255);
			close(fd);
			lavg[len-1] = 0x0;
			printf("%s          \n\n", lavg);
		}

		print_stat(&par[0], 0, verbose);
		if(max_cycles && stat[0].cycles >= max_cycles)
			allstopped++;

		usleep(10000);
		if (shutdown || allstopped)
			break;
		if (!verbose && !quiet)
			printf("\033[%dA", 3);
	}
	ret = 0;
 outall:
	shutdown = 1;
	usleep(50000);
	if (quiet)
		quiet = 2;
	for (i = 0; i < num_threads; i++) {
		if (stat[i].threadstarted > 0)
			pthread_kill(stat[i].thread, SIGTERM);
		if (stat[i].threadstarted) {
			pthread_join(stat[i].thread, NULL);
			if (quiet)
				print_stat(&par[i], i, 0);
		}
		if (stat[i].values)
			free(stat[i].values);
	}
	free(stat);
 outpar:
	free(par);
 out:
	exit(ret);
}

--=-zL1x5X6eC/JjsWpwNQjF--
