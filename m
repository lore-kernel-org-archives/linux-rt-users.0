From: Gratian Crisan <gratian.crisan@ni.com>
Subject: latency induced by hrtimer stacking
Date: Wed, 04 Jan 2017 10:16:44 -0600
Message-ID: <87k2aa242b.fsf@kerf.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Piotr Gregor <piotrgregor@rsyncme.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi all,

Re-posting hopefully with the right CC's this time around. Apologies
again for messing that up the first time around. I've also pulled the
changes provided by Piotr to the timer stress test/Makefile.

We are running into a PREEMPT_RT latency issue related to multiple
hrtimers getting stacked and adding up to large latencies for real-time
threads.

Currently, we don't think this is a kernel regression per se, rather it
is triggered by upgrades to our user-space stack after which more
non-real-time processes use hrtimers. We are still tracking where they
are coming from; based on traces it looks like clock_nanosleep() and
futex calls with a timeout (e.g. things like pthread_cond_timedwait()).

I wrote a quick test load[1] which in combination with cyclictest shows
the problem. The test spawns a configurable number of threads doing
sub-second, random interval, clock_nanosleep() in a loop. It doesn't
take many threads (5 to 7) for the problem to be evident in the
cyclictest numbers.

Using this test with 4.8.6-rt5, on a Xilinx Zynq 7020 dual-core ARMv7 @
667MHz shows a maximum cyclictest latency of 164us over a 16 hour run.
By comparison using a hackbench + iperf load under the same conditions
results in 120us max latency. These numbers can be reproduced with other
kernel versions (i.e. is not specific to 4.8-rt).

I have uploaded the cyclictest numbers, histograms, and an event trace
to: https://github.com/gratian/tests
The READMEs should (hopefully) get you started.

What I wanted to pick your brains about is: if deferring the hrtimer
expiration processing done in __hrtimer_run_queues for non-RT tasks to
the corresponding softirq is a workable and/or bad idea. The actual
deferral mechanism is already in place, we are just talking here about
flagging hrtimers coming from non-RT tasks as deferrable.

A quick hack/patch[2] that lets me tweak the deferral, via a sysfs
entry, for timers going through hrtimer_init_sleeper() shows a large
improvement when using the (admittedly artificial) timer stress test
described above. The max cyclictest numbers over the same 16 hour test
run period drops to 101us.

The final patch will have to look different i.e. it won't have the sysfs
mess and it needs a mechanism to figure out at what point during boot is
safe to start deferring to the timer softirq but before going down that
rabbit hole I wanted to check if the idea has any merit. As it stands
now non-RT processes can create unbounded latencies for RT threads by
doing relatively innocuous things like clock_nanosleep, futex calls that
have timeouts etc.

Thanks,
    Gratian

[1]
---
#define _GNU_SOURCE

#include <stdlib.h>
#include <stdint.h>
#include <stdarg.h>
#include <string.h>
#include <stdio.h>
#include <unistd.h>
#include <signal.h>
#include <fcntl.h>
#include <getopt.h>
#include <pthread.h>
#include <sched.h>
#include <time.h>
#include <errno.h>
#include <sys/mman.h>

#define CLOCK CLOCK_MONOTONIC

static int g_nthreads = 1;
sig_atomic_t g_stop = 0;

enum {
	OPT_HELP = 1,
	OPT_NTHREADS
};

static struct option opt_long[] = {
	{"help", no_argument, NULL, OPT_HELP},
	{"threads", required_argument, NULL, OPT_NTHREADS},
	{NULL, 0, NULL, 0}
};

const char *opt_short = "t:h";

static void usage()
{
	printf("Usage:\n"
	       "ttest <options>\n\t"
	       "-t <NUM> --threads=<NUM>	Start <NUM> threads in parallel\n\t"
	       "-h --help			Display this help\n"
		);
}

static int parse_options(int argc, char *argv[])
{
	int c;
	int index = 0;

	for (;;) {
		c = getopt_long(argc, argv, opt_short, opt_long, &index);
		if (c < 0)
			break;
		switch (c) {
			case 't':
			case OPT_NTHREADS:
				g_nthreads = atoi(optarg);
				break;
			case '?':
			case 'h':
			case OPT_HELP:
				return EXIT_FAILURE;
		}
	}

	return EXIT_SUCCESS;
}

void* test_thread(void *param)
{
	struct timespec t;
	uint64_t interval;

	while (!g_stop) {
		t.tv_sec = 0;
		interval = rand();
		interval = (interval * 1000000LL) / RAND_MAX;
		t.tv_nsec = interval;
		clock_nanosleep(CLOCK, 0, &t, NULL);
	}

	return NULL;
}

void sighandler(int sig)
{
	g_stop = 1;
}

int main(int argc, char *argv[])
{
	pthread_t *threads;
	int i;
	struct timespec t = {0, 1000000L};	/* 1ms interval */

	mlockall(MCL_CURRENT | MCL_FUTURE);

	if (argc < 2 || parse_options(argc, argv) == EXIT_FAILURE) {
		usage();
		return EXIT_FAILURE;
	}

	threads = (pthread_t*)malloc(sizeof(pthread_t) * g_nthreads);
	if (threads == NULL) {
		fprintf(stderr, "Failed to allocate memory for %d threads\n",
			g_nthreads);
		return EXIT_FAILURE;
	}

	signal(SIGINT, sighandler);
	signal(SIGHUP, SIG_IGN);

	for (i = 0; i < g_nthreads; i++) {
		if (pthread_create(&threads[i], NULL, test_thread, NULL) != 0) {
			perror("Failed to create thread");
			return EXIT_FAILURE;
		}
	}

	while (!g_stop)
		clock_nanosleep(CLOCK, 0, &t, NULL);

	for (i = 0; i < g_nthreads; i++)
		pthread_join(threads[i], NULL);

	return EXIT_SUCCESS;
}
---

[2]
---
>From 6e6e7c852fc8efc95dbfa6becc14b3a7846fd6f8 Mon Sep 17 00:00:00 2001
From: Gratian Crisan <gratian.crisan@ni.com>
Date: Wed, 9 Nov 2016 15:43:03 -0600
Subject: [HACK][RFC] sysfs, hrtimer: Add sysfs knob to defer non-rt timers to
 softirq context

Current hrtimer implementation processes all expired timers marked as
irqsafe in the timer irq context. This includes timers created by non-rt
tasks and as a result it can create unbounded latencies for real-time tasks
waiting on an hrtimer to expire.

Provide /sys/kernel/hrtimer_defer_nonrt configuration knob which when set
results in only marking as irqsafe timers created by a rt task. The rest
will get deferred to the HRTIMER_SOFTIRQ for handling via the existing
mechanism in __hrtimer_run_queues/hrtimer_rt_defer.

Signed-off-by: Gratian Crisan <gratian.crisan@ni.com>
---
 kernel/ksysfs.c       | 18 ++++++++++++++++++
 kernel/time/hrtimer.c |  4 +++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/kernel/ksysfs.c b/kernel/ksysfs.c
index ddef079..9fd4f50 100644
--- a/kernel/ksysfs.c
+++ b/kernel/ksysfs.c
@@ -189,6 +189,23 @@ static ssize_t rcu_normal_store(struct kobject *kobj,
 KERNEL_ATTR_RW(rcu_normal);
 #endif /* #ifndef CONFIG_TINY_RCU */
 
+extern int hrtimer_defer_nonrt;
+static ssize_t hrtimer_defer_nonrt_show(struct kobject *kobj,
+					struct kobj_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%d\n", hrtimer_defer_nonrt);
+}
+static ssize_t hrtimer_defer_nonrt_store(struct kobject *kobj,
+					struct kobj_attribute *attr,
+					const char *buf, size_t count)
+{
+	if (kstrtoint(buf, 0, &hrtimer_defer_nonrt))
+		return -EINVAL;
+
+	return count;
+}
+KERNEL_ATTR_RW(hrtimer_defer_nonrt);
+
 /*
  * Make /sys/kernel/notes give the raw contents of our kernel .notes section.
  */
@@ -237,6 +254,7 @@ static struct attribute * kernel_attrs[] = {
 #ifdef CONFIG_PREEMPT_RT_FULL
 	&realtime_attr.attr,
 #endif
+	&hrtimer_defer_nonrt_attr.attr,
 	NULL
 };
 
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index d85f638..df5783a 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -106,6 +106,8 @@ static inline int hrtimer_clockid_to_base(clockid_t clock_id)
 	return hrtimer_clock_to_base_table[clock_id];
 }
 
+int hrtimer_defer_nonrt;
+
 /*
  * Functions and macros which are different for UP/SMP systems are kept in a
  * single place
@@ -1644,7 +1646,7 @@ static enum hrtimer_restart hrtimer_wakeup(struct hrtimer *timer)
 void hrtimer_init_sleeper(struct hrtimer_sleeper *sl, struct task_struct *task)
 {
 	sl->timer.function = hrtimer_wakeup;
-	sl->timer.irqsafe = 1;
+	sl->timer.irqsafe = (hrtimer_defer_nonrt) ? rt_task(task) : 1;
 	sl->task = task;
 }
 EXPORT_SYMBOL_GPL(hrtimer_init_sleeper);
-- 
2.10.2
