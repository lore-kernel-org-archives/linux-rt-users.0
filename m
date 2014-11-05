From: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [RFC v0 2/9] rt-tests.h: Remove unused header file
Date: Wed,  5 Nov 2014 10:09:38 +0100
Message-ID: <1415178585-3192-3-git-send-email-daniel.wagner@bmw-carit.de>
References: <1415178585-3192-1-git-send-email-daniel.wagner@bmw-carit.de>
Cc: linux-rt-users@vger.kernel.org,
	Daniel Wagner <daniel.wagner@bmw-carit.de>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.bmw-carit.de ([62.245.222.98]:52811 "EHLO
	linuxmail.bmw-carit.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751438AbaKEJJt (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 5 Nov 2014 04:09:49 -0500
In-Reply-To: <1415178585-3192-1-git-send-email-daniel.wagner@bmw-carit.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

There is no user of this header file.

Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
---
 src/include/rt-tests.h | 124 -------------------------------------------------
 1 file changed, 124 deletions(-)
 delete mode 100644 src/include/rt-tests.h

diff --git a/src/include/rt-tests.h b/src/include/rt-tests.h
deleted file mode 100644
index d7eefd9..0000000
--- a/src/include/rt-tests.h
+++ /dev/null
@@ -1,124 +0,0 @@
-#ifndef __RT_TESTS_H__
-#define __RT_TESTS_H__
-
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#define __USE_GNU
-#include <fcntl.h>
-#include <getopt.h>
-#include <pthread.h>
-#include <signal.h>
-#include <sched.h>
-#include <string.h>
-#include <time.h>
-#include <errno.h>
-
-#include <linux/unistd.h>
-
-#include <sys/prctl.h>
-#include <sys/stat.h>
-#include <sys/sysinfo.h>
-#include <sys/types.h>
-#include <sys/time.h>
-#include <sys/utsname.h>
-#include <sys/mman.h>
-
-#ifndef SCHED_IDLE
-#define SCHED_IDLE 5
-#endif
-#ifndef SCHED_NORMAL
-#define SCHED_NORMAL SCHED_OTHER
-#endif
-
-/* Ugly, but .... */
-#define gettid() syscall(__NR_gettid)
-#define sigev_notify_thread_id _sigev_un._tid
-
-#ifdef __UCLIBC__
-#define MAKE_PROCESS_CPUCLOCK(pid, clock) \
-	((~(clockid_t) (pid) << 3) | (clockid_t) (clock))
-#define CPUCLOCK_SCHED          2
-
-static int clock_nanosleep(clockid_t clock_id, int flags, const struct timespec *req,
-		struct timespec *rem)
-{
-	if (clock_id == CLOCK_THREAD_CPUTIME_ID)
-		return -EINVAL;
-	if (clock_id == CLOCK_PROCESS_CPUTIME_ID)
-		clock_id = MAKE_PROCESS_CPUCLOCK (0, CPUCLOCK_SCHED);
-
-	return syscall(__NR_clock_nanosleep, clock_id, flags, req, rem);
-}
-
-static int sched_setaffinity(pid_t pid, unsigned int cpusetsize,
-		cpu_set_t *mask)
-{
-	return -EINVAL;
-}
-
-static void CPU_SET(int cpu, cpu_set_t *set) { }
-static void CPU_ZERO(cpu_set_t *set) { }
-#else
-extern int clock_nanosleep(clockid_t __clock_id, int __flags,
-			   __const struct timespec *__req,
-			   struct timespec *__rem);
-#endif
-
-#define USEC_PER_SEC		1000000
-#define NSEC_PER_SEC		1000000000
-
-#define HIST_MAX		1000000
-
-/* Struct to transfer parameters to the thread */
-struct thread_param {
-	int prio;
-	int policy;
-	int mode;
-	int timermode;
-	int signal;
-	int clock;
-	unsigned long max_cycles;
-	struct thread_stat *stats;
-	int bufmsk;
-	unsigned long interval;
-	int cpu;
-};
-
-/* Struct for statistics */
-struct thread_stat {
-	unsigned long cycles;
-	unsigned long cyclesread;
-	long min;
-	long max;
-	long act;
-	double avg;
-	long *values;
-	long *hist_array;
-	pthread_t thread;
-	int threadstarted;
-	int tid;
-	long reduce;
-	long redmax;
-	long cycleofmax;
-	long hist_overflow;
-};
-
-enum kernelversion {
-	KV_NOT_26,	/* not a 2.6 kernel */
-	KV_26_LT18,	/* less than 2.6.18 */
-	KV_26_LT24,	/* less than 2.6.24 */
-	KV_26_LT28,	/* less than 2.6.28 */
-	KV_26_CURR,	/* 2.6.28+          */
-};
-
-enum kernelversion check_kernel(void);
-
-enum {
-	ERROR_GENERAL	= -1,
-	ERROR_NOTFOUND	= -2,
-};
-
-#define TIMER_RELTIME		0
