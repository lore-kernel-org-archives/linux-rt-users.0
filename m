From: Henrik Austad <haustad@cisco.com>
Subject: [PATCH 3/4] Android: clean up the bypass ifdeffery
Date: Tue,  6 Oct 2015 11:08:22 +0200
Message-ID: <1444122503-8112-3-git-send-email-haustad@cisco.com>
References: <1444122503-8112-1-git-send-email-haustad@cisco.com>
Cc: Henrik Austad <haustad@cisco.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from alln-iport-2.cisco.com ([173.37.142.89]:34488 "EHLO
	alln-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752155AbbJFJLc (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 6 Oct 2015 05:11:32 -0400
In-Reply-To: <1444122503-8112-1-git-send-email-haustad@cisco.com>
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

Signed-off-by: Henrik Austad <haustad@cisco.com>
Cc: Clark Williams <williams@redhat.com>
Cc: John Kacur <jkacur@redhat.com>
---
 Makefile                    |  2 +-
 include/bionic.h            | 32 ++++++++++++++++++++++++++++++++
 src/arch/bionic/Makefile    |  4 +---
 src/cyclictest/cyclictest.c | 25 +++----------------------
 4 files changed, 37 insertions(+), 26 deletions(-)
 create mode 100644 include/bionic.h

diff --git a/Makefile b/Makefile
index 2d20ea4..24ef8fe 100644
--- a/Makefile
+++ b/Makefile
@@ -22,7 +22,7 @@ bindir  ?= $(prefix)/bin
 mandir	?= $(prefix)/share/man
 srcdir	?= $(prefix)/src
 
-CFLAGS ?= -Wall -Wno-nonnull
+CFLAGS ?= -Wall -Wno-nonnull -Iinclude/
 CPPFLAGS += -D_GNU_SOURCE -Isrc/include
 LDFLAGS ?=
 
diff --git a/include/bionic.h b/include/bionic.h
new file mode 100644
index 0000000..8526299
--- /dev/null
+++ b/include/bionic.h
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
diff --git a/src/arch/bionic/Makefile b/src/arch/bionic/Makefile
index 410d2c9..8e169f0 100644
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
index 22932e9..b52cabd 100644
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
@@ -815,7 +815,6 @@ static void *timerthread(void *param)
 		fatal("timerthread%d: failed to set priority to %d\n", par->cpu, par->prio);
 
 	/* Get current time */
-#ifndef NO_PTHREAD_BARRIER
 	if(aligned || secaligned){
 		pthread_barrier_wait(&globalt_barr);
 		if (par->tnum == 0) {
@@ -841,7 +840,6 @@ static void *timerthread(void *param)
 		}
 	}
 	else
-#endif
 		clock_gettime(par->clock, &now);
 
 	next = now;
@@ -1048,9 +1046,7 @@ static void display_help(int error)
 	       "-a [NUM] --affinity        run thread #N on processor #N, if possible\n"
 	       "                           with NUM pin all threads to the processor NUM\n"
 #endif
-#ifndef NO_PTHREAD_BARRIER
 	       "-A USEC  --aligned=USEC    align thread wakeups to a specific offset\n"
-#endif
 	       "-b USEC  --breaktrace=USEC send break trace command when latency > USEC\n"
 	       "-B       --preemptirqs     both preempt and irqsoff tracing (used with -b)\n"
 	       "-c CLOCK --clock=CLOCK     select clock\n"
@@ -1091,9 +1087,7 @@ static void display_help(int error)
 	       "-R       --resolution      check clock resolution, calling clock_gettime() many\n"
 	       "                           times.  list of clock_gettime() values will be\n"
 	       "                           reported with -X\n"
-#ifndef NO_PTHREAD_BARRIER
 	       "         --secaligned [USEC] align thread wakeups to the next full second,\n"
-#endif
 	       "                           and apply the optional offset\n"
 	       "-s       --system          use sys_nanosleep and sys_setitimer\n"
 	       "-S       --smp             Standard SMP testing: options -a -t -n and\n"
@@ -1243,10 +1237,7 @@ enum option_values {
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
@@ -1264,9 +1255,7 @@ static void process_options (int argc, char *argv[], int max_cpus)
 		static struct option long_options[] = {
 			{"affinity",         optional_argument, NULL, OPT_AFFINITY},
 			{"notrace",          no_argument,       NULL, OPT_NOTRACE },
-#ifndef NO_PTHREAD_BARRIER
 			{"aligned",          optional_argument, NULL, OPT_ALIGNED },
-#endif
 			{"breaktrace",       required_argument, NULL, OPT_BREAKTRACE },
 			{"preemptirqs",      no_argument,       NULL, OPT_PREEMPTIRQ },
 			{"clock",            required_argument, NULL, OPT_CLOCK },
@@ -1296,9 +1285,7 @@ static void process_options (int argc, char *argv[], int max_cpus)
 			{"priospread",       no_argument,       NULL, OPT_PRIOSPREAD },
 			{"relative",         no_argument,       NULL, OPT_RELATIVE },
 			{"resolution",       no_argument,       NULL, OPT_RESOLUTION },
-#ifndef NO_PTHREAD_BARRIER
 			{"secaligned",       optional_argument, NULL, OPT_SECALIGNED },
-#endif
 			{"system",           no_argument,       NULL, OPT_SYSTEM },
 			{"smp",              no_argument,       NULL, OPT_SMP },
 			{"threads",          optional_argument, NULL, OPT_THREADS },
@@ -1333,7 +1320,6 @@ static void process_options (int argc, char *argv[], int max_cpus)
 				setaffinity = AFFINITY_USEALL;
 			}
 			break;
-#ifndef NO_PTHREAD_BARRIER
 		case 'A':
 		case OPT_ALIGNED:
 			aligned=1;
@@ -1344,7 +1330,6 @@ static void process_options (int argc, char *argv[], int max_cpus)
 			else
 				offset = 0;
 			break;
-#endif
 		case 'b':
 		case OPT_BREAKTRACE:
 			tracelimit = atoi(optarg); break;
@@ -1445,7 +1430,6 @@ static void process_options (int argc, char *argv[], int max_cpus)
 		case OPT_RESOLUTION:
 			check_clock_resolution = 1; break;
 		case 's':
-#ifndef NO_PTHREAD_BARRIER
 		case OPT_SECALIGNED:
 			secaligned = 1;
 			if (optarg != NULL)
@@ -1455,7 +1439,6 @@ static void process_options (int argc, char *argv[], int max_cpus)
 			else
 				offset = 0;
 			break;
-#endif
 		case OPT_SYSTEM:
 			use_system = MODE_SYS_OFFSET; break;
 		case 'S':
@@ -1592,7 +1575,6 @@ static void process_options (int argc, char *argv[], int max_cpus)
 	if (num_threads < 1)
 		error = 1;
 
-#ifndef NO_PTHREAD_BARRIER
 	if (aligned && secaligned)
 		error = 1;
 
@@ -1600,7 +1582,6 @@ static void process_options (int argc, char *argv[], int max_cpus)
 		pthread_barrier_init(&globalt_barr, NULL, num_threads);
 		pthread_barrier_init(&align_barr, NULL, num_threads);
 	}
-#endif
 	if (error) {
 		if (affinity_mask)
 			rt_bitmask_free(affinity_mask);
-- 
1.9.1

