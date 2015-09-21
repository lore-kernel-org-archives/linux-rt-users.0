From: Henrik Austad <haustad@cisco.com>
Subject: [PATCH 6/6] android: adjust target for android
Date: Mon, 21 Sep 2015 17:27:28 +0200
Message-ID: <1442849248-573-7-git-send-email-haustad@cisco.com>
References: <1442849248-573-1-git-send-email-haustad@cisco.com>
Cc: linux-rt-users@vger.kernel.org, Josh Cartwright <joshc@ni.com>,
	Henrik Austad <haustad@cisco.com>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from alln-iport-8.cisco.com ([173.37.142.95]:60829 "EHLO
	alln-iport-8.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932106AbbIUP3k (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 21 Sep 2015 11:29:40 -0400
In-Reply-To: <1442849248-573-1-git-send-email-haustad@cisco.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Bionic (Android's libc implementation) lacks support for (amongst other
things) pthread_barriers and pthread_setaffinity. The former is removed
by ifdeffery, the latter is added as a per-android wrapper to
sched_setaffinity.

Signed-off-by: Henrik Austad <haustad@cisco.com>
---
 Makefile                    | 27 ++++++++++++++++++++++++++-
 src/cyclictest/cyclictest.c | 45 +++++++++++++++++++++++++++++++++++++--------
 2 files changed, 63 insertions(+), 9 deletions(-)

diff --git a/Makefile b/Makefile
index 66de743..04ba190 100644
--- a/Makefile
+++ b/Makefile
@@ -49,6 +49,32 @@ ifeq ($(NUMA),1)
 	NUMA_LIBS = -lnuma
 endif
 
+# Bionic (android) does not have:
+# - pthread barriers
+# - pthread_[gs]etaffinity
+#
+# Typically see something like "aarch64-linux-android"
+
+ifneq ($(shell $(CC) -dumpmachine | grep -i android),)
+	USE_BIONIC := 1
+	CFLAGS += -DNO_PTHREAD_BARRIER
+	CFLAGS += -DNO_PTHREAD_SETAFFINITY
+
+	LDFLAGS += -pie
+# -lrt and -lpthread is in standard bionic library, no standalone library
+	LIBS := $(filter-out -lrt,$(LIBS))
+	LIBS := $(filter-out -lpthread,$(LIBS))
+
+# BIONIC does not support PI, barriers and have different files in
+# include/. This menas that currently, only these binaries will compile
+# and link properly:
+# - cyclictest
+# - hackbench
+# - hwlatdetect
+	sources := cyclictest.c hackbench.c hwlatdetect.c
+	TARGETS = $(sources:.c=)
+endif
+
 VPATH	= src/cyclictest:
 VPATH	+= src/signaltest:
 VPATH	+= src/pi_tests:
@@ -164,7 +190,6 @@ install_hwlatdetect: hwlatdetect
 		ln -s $(PYLIB)/hwlatdetect.py "$(DESTDIR)$(bindir)/hwlatdetect" ; \
 		gzip -c src/hwlatdetect/hwlatdetect.8 >"$(DESTDIR)$(mandir)/man8/hwlatdetect.8.gz" ; \
 	fi
-
 .PHONY: release
 release: distclean changelog
 	mkdir -p releases
diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 42cd964..96fa864 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -11,7 +11,6 @@
  * 2 as published by the Free Software Foundation.
  *
  */
-
 #include <stdio.h>
 #include <stdlib.h>
 #include <stdint.h>
@@ -36,6 +35,7 @@
 #include <sys/resource.h>
 #include <sys/utsname.h>
 #include <sys/mman.h>
+#include <sys/syscall.h>
 #include "rt_numa.h"
 
 #include "rt-utils.h"
@@ -78,6 +78,15 @@ int sched_setaffinity (__pid_t __pid, size_t __cpusetsize,
 	return -EINVAL;
 }
 
+#endif
+
+#ifdef NO_PTHREAD_SETAFFINITY
+static inline int pthread_setaffinity_np(pthread_t thread, size_t cpusetsize,
+                                         const cpu_set_t *cpuset)
+{
+    return sched_setaffinity(0, cpusetsize, cpuset);
+}
+
 #undef CPU_SET
 #undef CPU_ZERO
 #define CPU_SET(cpu, cpusetp)
@@ -184,9 +193,6 @@ static int check_clock_resolution;
 static int ct_debug;
 static int use_fifo = 0;
 static pthread_t fifo_threadid;
-static int aligned = 0;
-static int secaligned = 0;
-static int offset = 0;
 static int laptop = 0;
 static int use_histfile = 0;
 
@@ -197,9 +203,14 @@ static pthread_mutex_t break_thread_id_lock = PTHREAD_MUTEX_INITIALIZER;
 static pid_t break_thread_id = 0;
 static uint64_t break_thread_value = 0;
 
+#ifndef NO_PTHREAD_BARRIER
+static int aligned = 0;
+static int secaligned = 0;
+static int offset = 0;
 static pthread_barrier_t align_barr;
 static pthread_barrier_t globalt_barr;
 static struct timespec globalt;
+#endif
 
 /* Backup of kernel variables that we modify */
 static struct kvars {
@@ -805,7 +816,8 @@ static void *timerthread(void *param)
 		fatal("timerthread%d: failed to set priority to %d\n", par->cpu, par->prio);
 
 	/* Get current time */
-	if (aligned || secaligned) {
+#ifndef NO_PTHREAD_BARRIER
+	if(aligned || secaligned){
 		pthread_barrier_wait(&globalt_barr);
 		if (par->tnum == 0) {
 			clock_gettime(par->clock, &globalt);
@@ -830,6 +842,7 @@ static void *timerthread(void *param)
 		}
 	}
 	else
+#endif
 		clock_gettime(par->clock, &now);
 
 	next = now;
@@ -1036,7 +1049,9 @@ static void display_help(int error)
 	       "-a [NUM] --affinity        run thread #N on processor #N, if possible\n"
 	       "                           with NUM pin all threads to the processor NUM\n"
 #endif
+#ifndef NO_PTHREAD_BARRIER
 	       "-A USEC  --aligned=USEC    align thread wakeups to a specific offset\n"
+#endif
 	       "-b USEC  --breaktrace=USEC send break trace command when latency > USEC\n"
 	       "-B       --preemptirqs     both preempt and irqsoff tracing (used with -b)\n"
 	       "-c CLOCK --clock=CLOCK     select clock\n"
@@ -1077,7 +1092,9 @@ static void display_help(int error)
 	       "-R       --resolution      check clock resolution, calling clock_gettime() many\n"
 	       "                           times.  list of clock_gettime() values will be\n"
 	       "                           reported with -X\n"
+#ifndef NO_PTHREAD_BARRIER
 	       "         --secaligned [USEC] align thread wakeups to the next full second,\n"
+#endif
 	       "                           and apply the optional offset\n"
 	       "-s       --system          use sys_nanosleep and sys_setitimer\n"
 	       "-S       --smp             Standard SMP testing: options -a -t -n and\n"
@@ -1226,8 +1243,11 @@ enum option_values {
 	OPT_NSECS, OPT_OSCOPE, OPT_TRACEOPT, OPT_PRIORITY, OPT_PREEMPTOFF, OPT_QUIET,
 	OPT_PRIOSPREAD, OPT_RELATIVE, OPT_RESOLUTION, OPT_SYSTEM, OPT_SMP, OPT_THREADS,
 	OPT_TRACER, OPT_UNBUFFERED, OPT_NUMA, OPT_VERBOSE, OPT_WAKEUP, OPT_WAKEUPRT,
-	OPT_DBGCYCLIC, OPT_POLICY, OPT_HELP, OPT_NUMOPTS, OPT_ALIGNED, OPT_LAPTOP,
-	OPT_SECALIGNED,
+	OPT_DBGCYCLIC, OPT_POLICY, OPT_HELP, OPT_NUMOPTS,
+#ifndef NO_PTHREAD_BARRIER
+	OPT_ALIGNED, OPT_SECALIGNED,
+#endif
+        OPT_LAPTOP,
 };
 
 /* Process commandline options */
@@ -1245,7 +1265,9 @@ static void process_options (int argc, char *argv[], int max_cpus)
 		static struct option long_options[] = {
 			{"affinity",         optional_argument, NULL, OPT_AFFINITY},
 			{"notrace",          no_argument,       NULL, OPT_NOTRACE },
+#ifndef NO_PTHREAD_BARRIER
 			{"aligned",          optional_argument, NULL, OPT_ALIGNED },
+#endif
 			{"breaktrace",       required_argument, NULL, OPT_BREAKTRACE },
 			{"preemptirqs",      no_argument,       NULL, OPT_PREEMPTIRQ },
 			{"clock",            required_argument, NULL, OPT_CLOCK },
@@ -1275,7 +1297,9 @@ static void process_options (int argc, char *argv[], int max_cpus)
 			{"priospread",       no_argument,       NULL, OPT_PRIOSPREAD },
 			{"relative",         no_argument,       NULL, OPT_RELATIVE },
 			{"resolution",       no_argument,       NULL, OPT_RESOLUTION },
+#ifndef NO_PTHREAD_BARRIER
 			{"secaligned",       optional_argument, NULL, OPT_SECALIGNED },
+#endif
 			{"system",           no_argument,       NULL, OPT_SYSTEM },
 			{"smp",              no_argument,       NULL, OPT_SMP },
 			{"threads",          optional_argument, NULL, OPT_THREADS },
@@ -1310,6 +1334,7 @@ static void process_options (int argc, char *argv[], int max_cpus)
 				setaffinity = AFFINITY_USEALL;
 			}
 			break;
+#ifndef NO_PTHREAD_BARRIER
 		case 'A':
 		case OPT_ALIGNED:
 			aligned=1;
@@ -1320,6 +1345,7 @@ static void process_options (int argc, char *argv[], int max_cpus)
 			else
 				offset = 0;
 			break;
+#endif
 		case 'b':
 		case OPT_BREAKTRACE:
 			tracelimit = atoi(optarg); break;
@@ -1420,6 +1446,7 @@ static void process_options (int argc, char *argv[], int max_cpus)
 		case OPT_RESOLUTION:
 			check_clock_resolution = 1; break;
 		case 's':
+#ifndef NO_PTHREAD_BARRIER
 		case OPT_SECALIGNED:
 			secaligned = 1;
 			if (optarg != NULL)
@@ -1429,6 +1456,7 @@ static void process_options (int argc, char *argv[], int max_cpus)
 			else
 				offset = 0;
 			break;
+#endif
 		case OPT_SYSTEM:
 			use_system = MODE_SYS_OFFSET; break;
 		case 'S':
@@ -1565,6 +1593,7 @@ static void process_options (int argc, char *argv[], int max_cpus)
 	if (num_threads < 1)
 		error = 1;
 
+#ifndef NO_PTHREAD_BARRIER
 	if (aligned && secaligned)
 		error = 1;
 
@@ -1572,7 +1601,7 @@ static void process_options (int argc, char *argv[], int max_cpus)
 		pthread_barrier_init(&globalt_barr, NULL, num_threads);
 		pthread_barrier_init(&align_barr, NULL, num_threads);
 	}
