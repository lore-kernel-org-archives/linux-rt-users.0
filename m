From: Henrik Austad <haustad@cisco.com>
Subject: [PATCH] RFC: Android: clean up the bypass ifdeffery
Date: Wed, 23 Sep 2015 13:30:34 +0200
Message-ID: <1443007834-31932-1-git-send-email-haustad@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Henrik Austad <haustad@cisco.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from aer-iport-3.cisco.com ([173.38.203.53]:48843 "EHLO
	aer-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753467AbbIWLcp (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 23 Sep 2015 07:32:45 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is an RFC patch, I'd like to get some feedback if this is a prefer=
red
way of doing it, or if I should seek other options (I really hate the i=
fdef
introduced earlier, and I know others do as well).

END INTRO
-H

Android: clean up the bypass ifdeffery

88af643971b9 (android: adjust target for android) introduced some reall=
y
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
Cc: John Kacur <jkacur@redhat.com>=C3=A5
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>
---
 Makefile                    |  4 +---
 include/bionic.h            | 32 ++++++++++++++++++++++++++++++++
 src/cyclictest/cyclictest.c | 25 +++----------------------
 3 files changed, 36 insertions(+), 25 deletions(-)
 create mode 100644 include/bionic.h

diff --git a/Makefile b/Makefile
index 351c349..1f5e561 100644
--- a/Makefile
+++ b/Makefile
@@ -25,7 +25,7 @@ srcdir	?=3D $(prefix)/src
 machinetype =3D $(shell $(CC) -dumpmachine | \
     sed -e 's/-.*//' -e 's/i.86/i386/' -e 's/mips.*/mips/' -e 's/ppc.*=
/powerpc/')
=20
-CFLAGS ?=3D -Wall -Wno-nonnull
+CFLAGS ?=3D -Wall -Wno-nonnull -Iinclude/
 CPPFLAGS +=3D -D_GNU_SOURCE -Isrc/include
 LDFLAGS ?=3D
=20
@@ -54,7 +54,6 @@ endif
 # - pthread_[gs]etaffinity
 #
 # Typically see something like "aarch64-linux-android"
-
 ifneq ($(shell $(CC) -dumpmachine | grep -i android),)
 	USE_BIONIC :=3D 1
 	CFLAGS +=3D -DNO_PTHREAD_BARRIER
@@ -70,7 +69,6 @@ ifneq ($(shell $(CC) -dumpmachine | grep -i android),=
)
 # and link properly:
 # - cyclictest
 # - hackbench
-# - hwlatdetect
 	sources :=3D cyclictest.c hackbench.c
 	TARGETS =3D $(sources:.c=3D)
 endif
diff --git a/include/bionic.h b/include/bionic.h
new file mode 100644
index 0000000..5c46bec
--- /dev/null
+++ b/include/bionic.h
@@ -0,0 +1,32 @@
+#ifndef BIONIC_BYPASS_H
+#define BIONIC_BYPASS_H
+
+/* we do not have pthread barriers, add as small an emt */
+#ifdef NO_PTHREAD_BARRIER
+#warning Program is being compiled without PTHREAD_BARRIER support, so=
me options may behave erratic.
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
+                                       const pthread_barrierattr_t * a=
ttr,
+                                       unsigned count)
+{
+        return 0;
+}
+
+#endif /* NO_PTHREAD_BARRIER */
+
+#endif /* BIONIC_BYPASS_H */
diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 96fa864..5167585 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -40,6 +40,8 @@
=20
 #include "rt-utils.h"
=20
+#include <bionic.h>
+
 #define DEFAULT_INTERVAL 1000
 #define DEFAULT_DISTANCE 500
=20
@@ -203,14 +205,12 @@ static pthread_mutex_t break_thread_id_lock =3D P=
THREAD_MUTEX_INITIALIZER;
 static pid_t break_thread_id =3D 0;
 static uint64_t break_thread_value =3D 0;
=20
-#ifndef NO_PTHREAD_BARRIER
 static int aligned =3D 0;
 static int secaligned =3D 0;
 static int offset =3D 0;
 static pthread_barrier_t align_barr;
 static pthread_barrier_t globalt_barr;
 static struct timespec globalt;
-#endif
=20
 /* Backup of kernel variables that we modify */
 static struct kvars {
@@ -816,7 +816,6 @@ static void *timerthread(void *param)
 		fatal("timerthread%d: failed to set priority to %d\n", par->cpu, par=
->prio);
=20
 	/* Get current time */
-#ifndef NO_PTHREAD_BARRIER
 	if(aligned || secaligned){
 		pthread_barrier_wait(&globalt_barr);
 		if (par->tnum =3D=3D 0) {
@@ -842,7 +841,6 @@ static void *timerthread(void *param)
 		}
 	}
 	else
-#endif
 		clock_gettime(par->clock, &now);
=20
 	next =3D now;
@@ -1049,9 +1047,7 @@ static void display_help(int error)
 	       "-a [NUM] --affinity        run thread #N on processor #N, if =
possible\n"
 	       "                           with NUM pin all threads to the pr=
ocessor NUM\n"
 #endif
-#ifndef NO_PTHREAD_BARRIER
 	       "-A USEC  --aligned=3DUSEC    align thread wakeups to a specif=
ic offset\n"
-#endif
 	       "-b USEC  --breaktrace=3DUSEC send break trace command when la=
tency > USEC\n"
 	       "-B       --preemptirqs     both preempt and irqsoff tracing (=
used with -b)\n"
 	       "-c CLOCK --clock=3DCLOCK     select clock\n"
@@ -1092,9 +1088,7 @@ static void display_help(int error)
 	       "-R       --resolution      check clock resolution, calling cl=
ock_gettime() many\n"
 	       "                           times.  list of clock_gettime() va=
lues will be\n"
 	       "                           reported with -X\n"
-#ifndef NO_PTHREAD_BARRIER
 	       "         --secaligned [USEC] align thread wakeups to the next=
 full second,\n"
-#endif
 	       "                           and apply the optional offset\n"
 	       "-s       --system          use sys_nanosleep and sys_setitime=
r\n"
 	       "-S       --smp             Standard SMP testing: options -a -=
t -n and\n"
@@ -1244,10 +1238,7 @@ enum option_values {
 	OPT_PRIOSPREAD, OPT_RELATIVE, OPT_RESOLUTION, OPT_SYSTEM, OPT_SMP, OP=
T_THREADS,
 	OPT_TRACER, OPT_UNBUFFERED, OPT_NUMA, OPT_VERBOSE, OPT_WAKEUP, OPT_WA=
KEUPRT,
 	OPT_DBGCYCLIC, OPT_POLICY, OPT_HELP, OPT_NUMOPTS,
-#ifndef NO_PTHREAD_BARRIER
-	OPT_ALIGNED, OPT_SECALIGNED,
-#endif
-        OPT_LAPTOP,
+	OPT_ALIGNED, OPT_SECALIGNED, OPT_LAPTOP,
 };
=20
 /* Process commandline options */
@@ -1265,9 +1256,7 @@ static void process_options (int argc, char *argv=
[], int max_cpus)
 		static struct option long_options[] =3D {
 			{"affinity",         optional_argument, NULL, OPT_AFFINITY},
 			{"notrace",          no_argument,       NULL, OPT_NOTRACE },
-#ifndef NO_PTHREAD_BARRIER
 			{"aligned",          optional_argument, NULL, OPT_ALIGNED },
-#endif
 			{"breaktrace",       required_argument, NULL, OPT_BREAKTRACE },
 			{"preemptirqs",      no_argument,       NULL, OPT_PREEMPTIRQ },
 			{"clock",            required_argument, NULL, OPT_CLOCK },
@@ -1297,9 +1286,7 @@ static void process_options (int argc, char *argv=
[], int max_cpus)
 			{"priospread",       no_argument,       NULL, OPT_PRIOSPREAD },
 			{"relative",         no_argument,       NULL, OPT_RELATIVE },
 			{"resolution",       no_argument,       NULL, OPT_RESOLUTION },
-#ifndef NO_PTHREAD_BARRIER
 			{"secaligned",       optional_argument, NULL, OPT_SECALIGNED },
-#endif
 			{"system",           no_argument,       NULL, OPT_SYSTEM },
 			{"smp",              no_argument,       NULL, OPT_SMP },
 			{"threads",          optional_argument, NULL, OPT_THREADS },
@@ -1334,7 +1321,6 @@ static void process_options (int argc, char *argv=
[], int max_cpus)
 				setaffinity =3D AFFINITY_USEALL;
 			}
 			break;
-#ifndef NO_PTHREAD_BARRIER
 		case 'A':
 		case OPT_ALIGNED:
 			aligned=3D1;
@@ -1345,7 +1331,6 @@ static void process_options (int argc, char *argv=
[], int max_cpus)
 			else
 				offset =3D 0;
 			break;
-#endif
 		case 'b':
 		case OPT_BREAKTRACE:
 			tracelimit =3D atoi(optarg); break;
@@ -1446,7 +1431,6 @@ static void process_options (int argc, char *argv=
[], int max_cpus)
 		case OPT_RESOLUTION:
 			check_clock_resolution =3D 1; break;
 		case 's':
-#ifndef NO_PTHREAD_BARRIER
 		case OPT_SECALIGNED:
 			secaligned =3D 1;
 			if (optarg !=3D NULL)
@@ -1456,7 +1440,6 @@ static void process_options (int argc, char *argv=
[], int max_cpus)
 			else
 				offset =3D 0;
 			break;
-#endif
 		case OPT_SYSTEM:
 			use_system =3D MODE_SYS_OFFSET; break;
 		case 'S':
@@ -1593,7 +1576,6 @@ static void process_options (int argc, char *argv=
[], int max_cpus)
 	if (num_threads < 1)
 		error =3D 1;
=20
-#ifndef NO_PTHREAD_BARRIER
 	if (aligned && secaligned)
 		error =3D 1;
=20
@@ -1601,7 +1583,6 @@ static void process_options (int argc, char *argv=
[], int max_cpus)
 		pthread_barrier_init(&globalt_barr, NULL, num_threads);
 		pthread_barrier_init(&align_barr, NULL, num_threads);
 	}
-#endif
 	if (error) {
 		if (affinity_mask)
 			rt_bitmask_free(affinity_mask);
--=20
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
