From: Henrik Austad <haustad@cisco.com>
Subject: [PATCH 1/4] Android: clean up the bypass ifdeffery
Date: Wed, 21 Oct 2015 15:48:59 +0200
Message-ID: <1445435342-16969-2-git-send-email-haustad@cisco.com>
References: <1445435342-16969-1-git-send-email-haustad@cisco.com>
Cc: Henrik Austad <henrik@austad.us>,
	Henrik Austad <haustad@cisco.com>,
	John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from aer-iport-1.cisco.com ([173.38.203.51]:58279 "EHLO
	aer-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013AbbJUNxQ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 21 Oct 2015 09:53:16 -0400
In-Reply-To: <1445435342-16969-1-git-send-email-haustad@cisco.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

88af643971b9 (android: adjust target for android) introduced some really
ugly ifdefs to avoid calling into pthread_barrier_wait and
pthread_barrier_init.

This patch attempts to coalesce this into a single place and let the
compiler handle the linking so that cyclictest.c is untouched by evil
ifdefs.

Compiled and tested on:
- x86_64 (v3.13 kernel)
- tilegx (v3.10 kernel)
- arm64 android (v3.10 kernel)

Note: this includes bionic.h unconditionally, so it makes most sense to
keep bionic.h in src/include/ (and not in src/arch/bionic/).

Cc: John Kacur <jkacur@redhat.com>
Signed-off-by: Henrik Austad <haustad@cisco.com>
---
 src/arch/bionic/Makefile    |  4 +---
 src/cyclictest/cyclictest.c | 25 +++----------------------
 src/include/bionic.h        | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 36 insertions(+), 25 deletions(-)
 create mode 100644 src/include/bionic.h

diff --git a/src/arch/bionic/Makefile b/src/arch/bionic/Makefile
index 410d2c9c7c37..8e169f080adb 100644
--- a/src/arch/bionic/Makefile
+++ b/src/arch/bionic/Makefile
@@ -19,7 +19,5 @@ ifeq (android,$(ostype))
 # and link properly:
 # - cyclictest
 # - hackbench
-# - hwlatdetect
-	sources := cyclictest.c hackbench.c hwlatdetect.c
+	sources := cyclictest.c hackbench.c
 endif
-
diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index b1f99ab22c57..5311d52d760d 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -40,6 +40,8 @@
 
 #include "rt-utils.h"
 
+#include <bionic.h>
+
 #define DEFAULT_INTERVAL 1000
 #define DEFAULT_DISTANCE 500
 
@@ -203,14 +205,12 @@ static pthread_mutex_t break_thread_id_lock = PTHREAD_MUTEX_INITIALIZER;
 static pid_t break_thread_id = 0;
 static uint64_t break_thread_value = 0;
 
-#ifndef NO_PTHREAD_BARRIER
 static int aligned = 0;
 static int secaligned = 0;
 static int offset = 0;
 static pthread_barrier_t align_barr;
 static pthread_barrier_t globalt_barr;
 static struct timespec globalt;
-#endif
 
 /* Backup of kernel variables that we modify */
 static struct kvars {
@@ -812,7 +812,6 @@ static void *timerthread(void *param)
 		fatal("timerthread%d: failed to set priority to %d\n", par->cpu, par->prio);
 
 	/* Get current time */
-#ifndef NO_PTHREAD_BARRIER
 	if(aligned || secaligned){
 		pthread_barrier_wait(&globalt_barr);
 		if (par->tnum == 0) {
@@ -838,7 +837,6 @@ static void *timerthread(void *param)
 		}
 	}
 	else
-#endif
 		clock_gettime(par->clock, &now);
 
 	next = now;
@@ -1045,9 +1043,7 @@ static void display_help(int error)
 	       "-a [NUM] --affinity        run thread #N on processor #N, if possible\n"
 	       "                           with NUM pin all threads to the processor NUM\n"
 #endif
-#ifndef NO_PTHREAD_BARRIER
 	       "-A USEC  --aligned=USEC    align thread wakeups to a specific offset\n"
-#endif
 	       "-b USEC  --breaktrace=USEC send break trace command when latency > USEC\n"
 	       "-B       --preemptirqs     both preempt and irqsoff tracing (used with -b)\n"
 	       "-c CLOCK --clock=CLOCK     select clock\n"
@@ -1088,9 +1084,7 @@ static void display_help(int error)
 	       "-R       --resolution      check clock resolution, calling clock_gettime() many\n"
 	       "                           times.  list of clock_gettime() values will be\n"
 	       "                           reported with -X\n"
-#ifndef NO_PTHREAD_BARRIER
 	       "         --secaligned [USEC] align thread wakeups to the next full second,\n"
-#endif
 	       "                           and apply the optional offset\n"
 	       "-s       --system          use sys_nanosleep and sys_setitimer\n"
 	       "-S       --smp             Standard SMP testing: options -a -t -n and\n"
@@ -1240,10 +1234,7 @@ enum option_values {
 	OPT_PRIOSPREAD, OPT_RELATIVE, OPT_RESOLUTION, OPT_SYSTEM, OPT_SMP, OPT_THREADS,
 	OPT_TRACER, OPT_UNBUFFERED, OPT_NUMA, OPT_VERBOSE, OPT_WAKEUP, OPT_WAKEUPRT,
 	OPT_DBGCYCLIC, OPT_POLICY, OPT_HELP, OPT_NUMOPTS,
-#ifndef NO_PTHREAD_BARRIER
-	OPT_ALIGNED, OPT_SECALIGNED,
-#endif
-        OPT_LAPTOP,
+	OPT_ALIGNED, OPT_SECALIGNED, OPT_LAPTOP,
 };
 
 /* Process commandline options */
@@ -1261,9 +1252,7 @@ static void process_options (int argc, char *argv[], int max_cpus)
 		static struct option long_options[] = {
 			{"affinity",         optional_argument, NULL, OPT_AFFINITY},
 			{"notrace",          no_argument,       NULL, OPT_NOTRACE },
-#ifndef NO_PTHREAD_BARRIER
 			{"aligned",          optional_argument, NULL, OPT_ALIGNED },
-#endif
 			{"breaktrace",       required_argument, NULL, OPT_BREAKTRACE },
 			{"preemptirqs",      no_argument,       NULL, OPT_PREEMPTIRQ },
 			{"clock",            required_argument, NULL, OPT_CLOCK },
@@ -1293,9 +1282,7 @@ static void process_options (int argc, char *argv[], int max_cpus)
 			{"priospread",       no_argument,       NULL, OPT_PRIOSPREAD },
 			{"relative",         no_argument,       NULL, OPT_RELATIVE },
 			{"resolution",       no_argument,       NULL, OPT_RESOLUTION },
-#ifndef NO_PTHREAD_BARRIER
 			{"secaligned",       optional_argument, NULL, OPT_SECALIGNED },
-#endif
 			{"system",           no_argument,       NULL, OPT_SYSTEM },
 			{"smp",              no_argument,       NULL, OPT_SMP },
 			{"threads",          optional_argument, NULL, OPT_THREADS },
@@ -1330,7 +1317,6 @@ static void process_options (int argc, char *argv[], int max_cpus)
 				setaffinity = AFFINITY_USEALL;
 			}
 			break;
-#ifndef NO_PTHREAD_BARRIER
 		case 'A':
 		case OPT_ALIGNED:
 			aligned=1;
@@ -1341,7 +1327,6 @@ static void process_options (int argc, char *argv[], int max_cpus)
 			else
 				offset = 0;
 			break;
-#endif
 		case 'b':
 		case OPT_BREAKTRACE:
 			tracelimit = atoi(optarg); break;
@@ -1442,7 +1427,6 @@ static void process_options (int argc, char *argv[], int max_cpus)
 		case OPT_RESOLUTION:
 			check_clock_resolution = 1; break;
 		case 's':
-#ifndef NO_PTHREAD_BARRIER
 		case OPT_SECALIGNED:
 			secaligned = 1;
 			if (optarg != NULL)
@@ -1452,7 +1436,6 @@ static void process_options (int argc, char *argv[], int max_cpus)
 			else
 				offset = 0;
 			break;
-#endif
 		case OPT_SYSTEM:
 			use_system = MODE_SYS_OFFSET; break;
 		case 'S':
@@ -1589,7 +1572,6 @@ static void process_options (int argc, char *argv[], int max_cpus)
 	if (num_threads < 1)
 		error = 1;
 
-#ifndef NO_PTHREAD_BARRIER
 	if (aligned && secaligned)
 		error = 1;
 
@@ -1597,7 +1579,6 @@ static void process_options (int argc, char *argv[], int max_cpus)
 		pthread_barrier_init(&globalt_barr, NULL, num_threads);
 		pthread_barrier_init(&align_barr, NULL, num_threads);
 	}
-#endif
 	if (error) {
 		if (affinity_mask)
 			rt_bitmask_free(affinity_mask);
diff --git a/src/include/bionic.h b/src/include/bionic.h
new file mode 100644
index 000000000000..8526299a75d2
--- /dev/null
+++ b/src/include/bionic.h
@@ -0,0 +1,32 @@
+#ifndef BIONIC_H
+#define BIONIC_H
+
+/* we do not have pthread barriers, add as small an emt */
+#ifdef NO_PTHREAD_BARRIER
+#warning Program is being compiled without PTHREAD_BARRIER support, some options may behave erratic.
+typedef int pthread_barrier_t;
+typedef int pthread_barrierattr_t;
+
+#ifndef PTHREAD_BARRIER_SERIAL_THREAD
+#define PTHREAD_BARRIER_SERIAL_THREAD 0
+#endif
+
+static inline int pthread_barrier_wait(pthread_barrier_t *barrier)
+{
+        return PTHREAD_BARRIER_SERIAL_THREAD;
+}
+
+static inline int pthread_barrier_destroy(pthread_barrier_t *barrier)
+{
+        return 0;
+}
+static inline int pthread_barrier_init(pthread_barrier_t * barrier,
+                                       const pthread_barrierattr_t * attr,
+                                       unsigned count)
+{
+        return 0;
+}
+
+#endif /* NO_PTHREAD_BARRIER */
+
+#endif /* BIONIC_H */
-- 
1.9.1

