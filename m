From: Mike Galbraith <efault@gmx.de>
Subject: [patch] rt-tests::signaltest: update trace/display capability to
 match cyclictest
Date: Fri, 30 Jul 2010 14:28:28 +0200
Message-ID: <1280492908.8705.14.camel@marge.simson.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:40939 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1755659Ab0G3M2T (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 30 Jul 2010 08:28:19 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Greetings,

signaltest's trace capability is busted with latest -rt.  It seemed
reasonable to clone and plug in differences, since they were apparently
twins at one time. 

commit 473f90f133343bc80557a85244dd0d58e6b7117a
Author: Mike Galbraith <efault@gmx.de>
Date:   Fri Jul 30 14:12:36 2010 +0200

signaltest: update trace/display capability to match cyclictest

Clone/edit src/cyclictest/cyclictest.c -> src/signaltest/signaltest.c, and insert
signaltest.c functionality.  Move src/cyclictest/rt_numa.h to src/include, as it's
common now.  Clone/edit the cyclictest manpage as well.

Deduct time the first thread sleeps, so it doesn't affect max latency of followers.

Signed-off-by: Mike Galbraith <efault@gmx.de>

---

 Makefile                    |    3 +-
 rt-tests.spec-in            |    6 +
 src/cyclictest/rt_numa.h    |  125 -----
 src/include/rt_numa.h       |  125 +++++
 src/signaltest/signaltest.8 |  174 +++++++
 src/signaltest/signaltest.c | 1167 ++++++++++++++++++++++++++++++++++++++-----
 6 files changed, 1352 insertions(+), 248 deletions(-)

diff --git a/Makefile b/Makefile
index b83614c..d0859d1 100644
--- a/Makefile
+++ b/Makefile
@@ -58,7 +58,7 @@ cyclictest: cyclictest.o rt-utils.o
 	$(CC) $(CFLAGS) -o $@ $^ $(LIBS) $(NUMA_LIBS)
 
 signaltest: signaltest.o rt-utils.o
-	$(CC) $(CFLAGS) -o $@ $^ $(LIBS)
+	$(CC) $(CFLAGS) -o $@ $^ $(LIBS) $(NUMA_LIBS)
 
 pi_stress: pi_stress.o
 	$(CC) $(CFLAGS) -o $@ $^ $(LIBS)
@@ -122,6 +122,7 @@ install: all
 	install -m 644 src/backfire/backfire.c "$(DESTDIR)$(srcdir)/backfire/backfire.c"
 	gzip src/backfire/backfire.4 -c >"$(DESTDIR)$(mandir)/man4/backfire.4.gz"
 	gzip src/cyclictest/cyclictest.8 -c >"$(DESTDIR)$(mandir)/man8/cyclictest.8.gz"
+	gzip src/signaltest/signaltest.8 -c >"$(DESTDIR)$(mandir)/man8/signaltest.8.gz"
 	gzip src/pi_tests/pi_stress.8 -c >"$(DESTDIR)$(mandir)/man8/pi_stress.8.gz"
 	gzip src/hwlatdetect/hwlatdetect.8 -c >"$(DESTDIR)$(mandir)/man8/hwlatdetect.8.gz"
 	gzip src/ptsematest/ptsematest.8 -c >"$(DESTDIR)$(mandir)/man8/ptsematest.8.gz"
diff --git a/rt-tests.spec-in b/rt-tests.spec-in
index e9afb1e..013d447 100644
--- a/rt-tests.spec-in
+++ b/rt-tests.spec-in
@@ -50,6 +50,7 @@ rm -rf $RPM_BUILD_ROOT
 /usr/src/backfire/backfire.c
 %doc
 /usr/share/man/man8/cyclictest.8.gz
+/usr/share/man/man8/signaltest.8.gz
 /usr/share/man/man8/pi_stress.8.gz
 /usr/share/man/man8/hwlatdetect.8.gz
 /usr/share/man/man4/backfire.4.gz
@@ -61,6 +62,11 @@ rm -rf $RPM_BUILD_ROOT
 /usr/share/man/man8/hackbench.8.gz
 
 %changelog
+* Fri Jul 30 2010 Mike Galbraith <efault@gmx.de> - 0.72-1
+- update signaltest: convert cyclictest.c to signaltest.c, so
+  the two look/act the same, and have the same trace capability.
+  Copy/edit manpage for same.
+
 * Fri Jun 25 2010 Clark Williams <williams@redhat.com> - 0.72-1
 - changed 'diff' variable in timerthread() routine to be unsigned
   64-bit to avoid overflow issues in debugging
diff --git a/src/cyclictest/rt_numa.h b/src/cyclictest/rt_numa.h
deleted file mode 100644
index 2b91615..0000000
--- a/src/cyclictest/rt_numa.h
+++ /dev/null
@@ -1,125 +0,0 @@
-/*
- * A numa library for cyclictest.
- * The functions here are designed to work whether cyclictest has been
- * compiled with numa support or not, and whether the user uses the --numa
- * option or not.
- * They should also work correctly with older versions of the numactl lib
- * such as the one found on RHEL5, or with the newer version 2 and above.
- *
- * (C) 2010 John Kacur <jkacur@redhat.com>
- * (C) 2010 Clark Williams <williams@redhat.com>
- *
- */
-
-#ifndef _RT_NUMA_H
-#define _RT_NUMA_H
-
-#include "rt-utils.h"
-
-static int numa = 0;
-
-#ifdef NUMA
-#include <numa.h>
-
-#ifndef LIBNUMA_API_VERSION
-#define LIBNUMA_API_VERSION 1
-#endif
-
-static void *
-threadalloc(size_t size, int node)
-{
-	if (node == -1)
-		return malloc(size);
-	return numa_alloc_onnode(size, node);
-}
-
-static void
-threadfree(void *ptr, size_t size, int node)
-{
-	if (node == -1)
-		free(ptr);
-	else
-		numa_free(ptr, size);
-}
-
-static void rt_numa_set_numa_run_on_node(int node, int cpu)
-{
-	int res;
-	res = numa_run_on_node(node);
-	if (res)
-		warn("Could not set NUMA node %d for thread %d: %s\n",
-				node, cpu, strerror(errno));
-	return;
-}
-
-static void numa_on_and_available()
-{
-	if (numa && numa_available() == -1)
-		fatal("--numa specified and numa functions not available.\n");
-}
-
-#if LIBNUMA_API_VERSION >= 2
-static int rt_numa_numa_node_of_cpu(int cpu)
-{
-	int node;
-	node = numa_node_of_cpu(cpu);
-	if (node == -1)
-		fatal("invalid cpu passed to numa_node_of_cpu(%d)\n", cpu);
-	return node;
-}
-
-#else	/* LIBNUMA_API_VERSION == 1 */
-
-static int rt_numa_numa_node_of_cpu(int cpu)
-{
-	unsigned char cpumask[256];
-	int node, idx, bit;
-	int max_node, max_cpus;
-
-	max_node = numa_max_node();
-	max_cpus = sysconf(_SC_NPROCESSORS_CONF);
-
-	if (cpu > max_cpus) {
-		errno = EINVAL;
-		return -1;
-	}
-
-	/* calculate bitmask index and relative bit position of cpu */
-	idx = cpu / 8;
-	bit = cpu % 8;
-
-	for (node = 0; node <= max_node; node++) {
-		if (numa_node_to_cpus(node, (void *) cpumask, sizeof(cpumask)))
-			return -1;
-
-		if (cpumask[idx] & (1<<bit))
-			return node;
-	}
-	errno = EINVAL;
-	return -1;
-}
-
-#endif	/* LIBNUMA_API_VERSION */
-
-static void *rt_numa_numa_alloc_onnode(size_t size, int node, int cpu)
-{
-	void *stack;
-	stack = numa_alloc_onnode(size, node);
-	if (stack == NULL)
-		fatal("failed to allocate %d bytes on node %d for cpu %d\n",
-				size, node, cpu);
-	return stack;
-}
-
-#else
-
-static inline void *threadalloc(size_t size, int n) { return malloc(size); }
-static inline void threadfree(void *ptr, size_t s, int n) { free(ptr); }
-static inline void rt_numa_set_numa_run_on_node(int n, int c) { }
-static inline void numa_on_and_available() { };
-static inline int rt_numa_numa_node_of_cpu(int cpu) { return -1; }
-static void *rt_numa_numa_alloc_onnode(size_t s, int n, int c) { return NULL; }
-
-#endif	/* NUMA */
-
-#endif	/* _RT_NUMA_H */
diff --git a/src/include/rt_numa.h b/src/include/rt_numa.h
new file mode 100644
index 0000000..2b91615
--- /dev/null
+++ b/src/include/rt_numa.h
@@ -0,0 +1,125 @@
+/*
+ * A numa library for cyclictest.
+ * The functions here are designed to work whether cyclictest has been
+ * compiled with numa support or not, and whether the user uses the --numa
+ * option or not.
+ * They should also work correctly with older versions of the numactl lib
+ * such as the one found on RHEL5, or with the newer version 2 and above.
+ *
+ * (C) 2010 John Kacur <jkacur@redhat.com>
+ * (C) 2010 Clark Williams <williams@redhat.com>
+ *
+ */
+
+#ifndef _RT_NUMA_H
+#define _RT_NUMA_H
+
+#include "rt-utils.h"
+
+static int numa = 0;
+
+#ifdef NUMA
+#include <numa.h>
+
+#ifndef LIBNUMA_API_VERSION
+#define LIBNUMA_API_VERSION 1
+#endif
+
+static void *
+threadalloc(size_t size, int node)
+{
+	if (node == -1)
+		return malloc(size);
+	return numa_alloc_onnode(size, node);
+}
+
+static void
+threadfree(void *ptr, size_t size, int node)
+{
+	if (node == -1)
+		free(ptr);
+	else
+		numa_free(ptr, size);
+}
+
+static void rt_numa_set_numa_run_on_node(int node, int cpu)
+{
+	int res;
+	res = numa_run_on_node(node);
+	if (res)
+		warn("Could not set NUMA node %d for thread %d: %s\n",
+				node, cpu, strerror(errno));
+	return;
+}
+
+static void numa_on_and_available()
+{
+	if (numa && numa_available() == -1)
+		fatal("--numa specified and numa functions not available.\n");
+}
+
+#if LIBNUMA_API_VERSION >= 2
+static int rt_numa_numa_node_of_cpu(int cpu)
+{
+	int node;
+	node = numa_node_of_cpu(cpu);
+	if (node == -1)
+		fatal("invalid cpu passed to numa_node_of_cpu(%d)\n", cpu);
+	return node;
+}
+
+#else	/* LIBNUMA_API_VERSION == 1 */
+
+static int rt_numa_numa_node_of_cpu(int cpu)
+{
+	unsigned char cpumask[256];
+	int node, idx, bit;
+	int max_node, max_cpus;
+
+	max_node = numa_max_node();
+	max_cpus = sysconf(_SC_NPROCESSORS_CONF);
+
+	if (cpu > max_cpus) {
+		errno = EINVAL;
+		return -1;
+	}
+
+	/* calculate bitmask index and relative bit position of cpu */
+	idx = cpu / 8;
+	bit = cpu % 8;
+
+	for (node = 0; node <= max_node; node++) {
+		if (numa_node_to_cpus(node, (void *) cpumask, sizeof(cpumask)))
+			return -1;
+
+		if (cpumask[idx] & (1<<bit))
+			return node;
+	}
+	errno = EINVAL;
+	return -1;
+}
+
+#endif	/* LIBNUMA_API_VERSION */
+
+static void *rt_numa_numa_alloc_onnode(size_t size, int node, int cpu)
+{
+	void *stack;
+	stack = numa_alloc_onnode(size, node);
+	if (stack == NULL)
+		fatal("failed to allocate %d bytes on node %d for cpu %d\n",
+				size, node, cpu);
+	return stack;
+}
+
+#else
+
+static inline void *threadalloc(size_t size, int n) { return malloc(size); }
+static inline void threadfree(void *ptr, size_t s, int n) { free(ptr); }
+static inline void rt_numa_set_numa_run_on_node(int n, int c) { }
+static inline void numa_on_and_available() { };
+static inline int rt_numa_numa_node_of_cpu(int cpu) { return -1; }
+static void *rt_numa_numa_alloc_onnode(size_t s, int n, int c) { return NULL; }
+
+#endif	/* NUMA */
+
+#endif	/* _RT_NUMA_H */
diff --git a/src/signaltest/signaltest.8 b/src/signaltest/signaltest.8
new file mode 100644
index 0000000..92ad474
--- /dev/null
+++ b/src/signaltest/signaltest.8
@@ -0,0 +1,174 @@
+.\"                                      Hey, EMACS: -*- nroff -*-
+.TH SIGNALTEST 8 "december  20, 2007"
+.\" Please adjust this date whenever revising the manpage.
+.\"
+.\" Some roff macros, for reference:
+.\" .nh        disable hyphenation
+.\" .hy        enable hyphenation
+.\" .ad l      left justify
+.\" .ad b      justify to both left and right margins
+.\" .nf        disable filling
+.\" .fi        enable filling
+.\" .br        insert line break
+.\" .sp <n>    insert n+1 empty lines
+.\" for manpage-specific macros, see man(7)
+.SH NAME
+signaltest \- RT signal roundtrip test program
+.SH SYNOPSIS
+.B signaltest
+.RI "[ \-hfmqvMS ] [\-a " proc " ] [\-b " usec " ] [\-c " clock " ] [\-d " dist " ] \
+[\-h " histogram " ] [\-l " loop " ] [\-o " red " ] [\-p " prio " ] \
+[\-t " num " ] [\-D " time "] [\-w] [\-W] [\-y " policy " ] [ \-S | \-U ]"
+
+.\" .SH DESCRIPTION
+.\" This manual page documents briefly the
+.\" .B signaltest commands.
+.\" .PP
+.\" \fI<whatever>\fP escape sequences to invode bold face and italics, respectively.
+.\" \fBsignaltest\fP is a program that...
+.SH OPTIONS
+These programs follow the usual GNU command line syntax, with long
+options starting with two dashes ('\-\-').
+.br
+A summary of options is included below.
+.\" For a complete description, see the Info files.
+.TP
+.B \-a, \-\-affinity[=PROC]
+Run all threads on procesor number PROC. If PROC is not specified, run thread #N on processor #N.
+.TP
+.B \-b, \-\-breaktrace=USEC
+Send break trace command when latency > USEC. This is a debugging option to control the latency tracer in the realtime preemption patch.
+It is useful to track down unexpected large latencies on a system. This option does only work with following kernel config options.
+
+    For kernel < 2.6.24:
+.br
+    * CONFIG_PREEMPT_RT=y
+.br
+    * CONFIG_WAKEUP_TIMING=y
+.br
+    * CONFIG_LATENCY_TRACE=y
+.br
+    * CONFIG_CRITICAL_PREEMPT_TIMING=y
+.br
+    * CONFIG_CRITICAL_IRQSOFF_TIMING=y
+.sp 1
+    For kernel >= 2.6.24:
+.br
+    * CONFIG_PREEMPT_RT=y
+.br
+    * CONFIG_FTRACE
+.br
+    * CONFIG_IRQSOFF_TRACER=y
+.br
+    * CONFIG_PREEMPT_TRACER=y
+.br
+    * CONFIG_SCHED_TRACER=y
+.br
+    * CONFIG_WAKEUP_LATENCY_HIST
+
+
+kernel configuration options enabled. The USEC parameter to the \-b option defines a maximum latency value, which is compared against the actual latencies of the test. Once the measured latency is higher than the given maximum, the kernel tracer and signaltest is stopped. The trace can be read from /proc/latency_trace. Please be aware that the tracer adds significant overhead to the kernel, so the latencies will be much higher than on a kernel with latency tracing disabled.
+.TP
+.B \-c, \-\-clock=CLOCK
+Selects the clock, which is used:
+
+    * 0 selects CLOCK_MONOTONIC, which is the monotonic increasing system time (default).
+    * 1 selects CLOCK_REALTIME, which is the time of day time.
+
+CLOCK_REALTIME can be set by settimeofday, while CLOCK_MONOTONIC can not be modified by the user.
+This option has no influence when the \-s option is given.
+.TP
+.B \-C, \-\-context
+context switch tracing (used with \-b)
+.TP
+.B \-d, \-\-distance=DIST
+Set the distance of thread intervals in microseconds (default is 500us). When signaltest is called with the \-t option and more than one thread is created, then this distance value is added to the interval of the threads: Interval(thread N) = Interval(thread N\-1) + DIST
+.TP
+.B \-E, \-\-event
+event tracing (used with \-b)
+.TP
+.B \-f, \-\-ftrace
+Enable function tracing using ftrace as tracer. This option is available only with \-b.
+.TP
+.B \-h, \-\-histogram=MAXLATENCYINUS
+Dump latency histogram to stdout. US means the max time to be be tracked in microseconds. When you use \-h option to get histogram data, Cyclictest runs many threads with same priority without priority\-\-.
+.TP
+.B \-l, \-\-loops=LOOPS
+Set the number of loops. The default is 0 (endless). This option is useful for automated tests with a given number of test cycles. Cyclictest is stopped once the number of timer intervals has been reached.
+.TP
+.B \-N, \-\-nsecs
+Show results in nanoseconds instead of microseconds, which is the default unit.
+.TP
+.B \-o, \-\-oscope=RED
+Oscilloscope mode, reduce verbose output by RED.
+.TP
+.B \-O, \-\-traceopt=TRACING_OPTION
+Used to pass tracing options to ftrace tracers. May be invoked mutiple
+times for multiple trace options. For example trace options look at /sys/kernel/debug/tracing/trace_options
+.TP
+.B \-p, \-\-prio=PRIO
+Set the priority of the first thread. The given priority is set to the first test thread. Each further thread gets a lower priority:
+Priority(Thread N) = max(Priority(Thread N\-1) \- 1, 0)
+.TP
+.B \-q, \-\-quiet
+Run the tests quiet and print only a summary on exit. Useful for automated tests, where only the summary output needs to be captured.
+.TP
+.B \-T, \-\-tracer=TRACEFUNC
+set the ftrace tracer function. Used with the \-b option. Must be one
+of the trace functions available from <debugfs-mountpoint>/kernel/debug/tracing/available_tracers
+.TP
+.B \-t, \-\-threads[=NUM]
+Set the number of test threads (default is 1). Create NUM test threads. If NUM is not specified, NUM is set to
+the number of available CPUs. See \-d, \-i and \-p for further information.
+.TP
+.B \-m, \-\-mlockall
+Lock current and future memory allocations to prevent being paged out
+.TP
+.B \-v, \-\-verbose
+Output values on stdout for statistics. This option is used to gather statistical information about the latency distribution. The output is sent to stdout. The output format is:
+
+n:c:v
+
+where n=task number c=count v=latency value in us. Use this option in combination with \-l
+.TP
+.B \\-D, \-\-duration=TIME
+Run the test for the specified time, which defaults to seconds. Append 'm', 'h', or 'd' to specify minutes, hours or days
+.TP
+.B \\-w, \-\-wakeup 
+task wakeup tracing (used with \-b)
+.TP
+.B \\-W, \-\-wakeuprt
+rt-task wakeup tracing (used with \-b)
+.TP
+.B \\-y, \-\-policy=NAME
+set the scheduler policy of the measurement threads 
+where NAME is one of: other, normal, batch, idle, fifo, rr
+.TP
+.B \\-M, \-\-refresh_on_max
+delay updating the screen until a new max latency is hit (useful for
+running signaltest on low-bandwidth connections)
+.TP
+.B \\-S, \-\-smp
+Set options for standard testing on SMP systems. Equivalent to using
+the options: "\-t \-a \-n" as well keeping any specified priority
+equal across all threads 
+.TP
+.B \\-U, \-\-numa
+Similar to the above \-\-smp option, this implies the "\-t \-a \-n"
+options, as well as a constant measurement interval, but also forces
+memory allocations using the numa(3) policy library. Thread stacks and
+data structures are allocated from the NUMA node local to the core to
+which the thread is bound. Requires the underlying kernel to have NUMA
+support compiled in.
+.\" .SH SEE ALSO
+.\" .BR bar (1),
+.\" .BR baz (1).
+.\" .br
+.\" The programs are documented fully by
+.\" .IR "The Rise and Fall of a Fooish Bar" ,
+.\" available via the Info system.
+.SH AUTHOR
+signaltest was written by Thomas Gleixner <tglx@linuxtronix.de>.
+.PP
+This manual page was written by Alessio Igor Bogani <abogani@texware.it>,
+for the Debian project (but may be used by others).
diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
index 9454a26..3eca850 100644
--- a/src/signaltest/signaltest.c
+++ b/src/signaltest/signaltest.c
@@ -9,26 +9,39 @@
  *
  */
 
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <unistd.h>
 #include <fcntl.h>
 #include <getopt.h>
 #include <pthread.h>
 #include <signal.h>
-#include <stdlib.h>
-#include <stdio.h>
+#include <sched.h>
 #include <string.h>
 #include <time.h>
-#include <unistd.h>
-
+#include <errno.h>
+#include <limits.h>
 #include <linux/unistd.h>
 
 #include <sys/prctl.h>
 #include <sys/stat.h>
+#include <sys/sysinfo.h>
 #include <sys/types.h>
 #include <sys/time.h>
+#include <sys/utsname.h>
 #include <sys/mman.h>
 
+#include "rt_numa.h"
 #include "rt-utils.h"
 
+#ifndef SCHED_IDLE
+#define SCHED_IDLE 5
+#endif
+#ifndef SCHED_NORMAL
+#define SCHED_NORMAL SCHED_OTHER
+#endif
+
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
 
 /* Ugly, but .... */
@@ -37,17 +50,39 @@
 #define USEC_PER_SEC		1000000
 #define NSEC_PER_SEC		1000000000
 
+#define HIST_MAX		1000000
+
 /* Must be power of 2 ! */
 #define VALBUF_SIZE		16384
 
+#define KVARS			32
+#define KVARNAMELEN		32
+#define KVALUELEN		32
+
+enum {
+	NOTRACE,
+	EVENTS,
+	CTXTSWITCH,
+	IRQSOFF,
+	PREEMPTOFF,
+	IRQPREEMPTOFF,
+	WAKEUP,
+	WAKEUPRT,
+	CUSTOM,
+};
+
 /* Struct to transfer parameters to the thread */
 struct thread_param {
 	int id;
 	int prio;
+	int policy;
 	int signal;
+	int clock;
 	unsigned long max_cycles;
 	struct thread_stat *stats;
 	int bufmsk;
+	int cpu;
+	int node;
 };
 
 /* Struct for statistics */
@@ -59,15 +94,133 @@ struct thread_stat {
 	long act;
 	double avg;
 	long *values;
+	long *hist_array;
 	pthread_t thread;
 	pthread_t tothread;
 	int threadstarted;
 	int tid;
+	long reduce;
+	long redmax;
+	long cycleofmax;
+	long hist_overflow;
 };
 
 static int shutdown;
 static int tracelimit = 0;
-static int oldtrace = 0;
+static int ftrace = 1;
+static int kernelversion;
+static int verbose = 0;
+static int oscope_reduction = 1;
+static int lockall = 0;
+static int tracetype = NOTRACE;
+static int histogram = 0;
+static int duration = 0;
+static int use_nsecs = 0;
+static int refresh_on_max;
+static int force_sched_other;
+
+static pthread_cond_t refresh_on_max_cond = PTHREAD_COND_INITIALIZER;
+static pthread_mutex_t refresh_on_max_lock = PTHREAD_MUTEX_INITIALIZER;
+
+static pthread_mutex_t break_thread_id_lock = PTHREAD_MUTEX_INITIALIZER;
+static pid_t break_thread_id = 0;
+
+/* Backup of kernel variables that we modify */
+static struct kvars {
+	char name[KVARNAMELEN];
+	char value[KVALUELEN];
+} kv[KVARS];
+
+static char *procfileprefix = "/proc/sys/kernel/";
+static char *fileprefix;
+static char tracer[MAX_PATH];
+static char **traceptr;
+static int traceopt_count;
+static int traceopt_size;
+
+enum kernelversion {
+	KV_NOT_26,
+	KV_26_LT18,
+	KV_26_LT24,
+	KV_26_CURR
+};
+
+enum {
+	ERROR_GENERAL	= -1,
+	ERROR_NOTFOUND	= -2,
+};
+
+static char functiontracer[MAX_PATH];
+static char traceroptions[MAX_PATH];
+
+static int kernvar(int mode, const char *name, char *value, size_t sizeofvalue)
+{
+	char filename[128];
+	int retval = 1;
+	int path;
+
+	strncpy(filename, fileprefix, sizeof(filename));
+	strncat(filename, name, sizeof(filename) - strlen(fileprefix));
+	path = open(filename, mode);
+	if (path >= 0) {
+		if (mode == O_RDONLY) {
+			int got;
+			if ((got = read(path, value, sizeofvalue)) > 0) {
+				retval = 0;
+				value[got-1] = '\0';
+			}
+		} else if (mode == O_WRONLY) {
+			if (write(path, value, sizeofvalue) == sizeofvalue)
+				retval = 0;
+		}
+		close(path);
+	}
+	return retval;
+}
+
+static void setkernvar(const char *name, char *value)
+{
+	int i;
+	char oldvalue[KVALUELEN];
+
+	if (kernelversion != KV_26_CURR) {
+		if (kernvar(O_RDONLY, name, oldvalue, sizeof(oldvalue)))
+			fprintf(stderr, "could not retrieve %s\n", name);
+		else {
+			for (i = 0; i < KVARS; i++) {
+				if (!strcmp(kv[i].name, name))
+					break;
+				if (kv[i].name[0] == '\0') {
+					strncpy(kv[i].name, name,
+						sizeof(kv[i].name));
+					strncpy(kv[i].value, oldvalue,
+					    sizeof(kv[i].value));
+					break;
+				}
+			}
+			if (i == KVARS)
+				fprintf(stderr, "could not backup %s (%s)\n",
+					name, oldvalue);
+		}
+	}
+	if (kernvar(O_WRONLY, name, value, strlen(value)))
+		fprintf(stderr, "could not set %s to %s\n", name, value);
+
+}
+
+static void restorekernvars(void)
+{
+	int i;
+
+	for (i = 0; i < KVARS; i++) {
+		if (kv[i].name[0] != '\0') {
+			if (kernvar(O_WRONLY, kv[i].name, kv[i].value,
+			    strlen(kv[i].value)))
+				fprintf(stderr, "could not restore %s to %s\n",
+					kv[i].name, kv[i].value);
+		}
+	}
+}
 
 static inline void tsnorm(struct timespec *ts)
 {
@@ -77,14 +230,275 @@ static inline void tsnorm(struct timespec *ts)
 	}
 }
 
-static inline long calcdiff(struct timespec t1, struct timespec t2)
+static inline int64_t calcdiff(struct timespec t1, struct timespec t2)
 {
-	long diff;
-	diff = USEC_PER_SEC * ((int) t1.tv_sec - (int) t2.tv_sec);
+	int64_t diff;
+	diff = USEC_PER_SEC * (long long)((int) t1.tv_sec - (int) t2.tv_sec);
 	diff += ((int) t1.tv_nsec - (int) t2.tv_nsec) / 1000;
 	return diff;
 }
 
+static inline int64_t calcdiff_ns(struct timespec t1, struct timespec t2)
+{
+	int64_t diff;
+	diff = NSEC_PER_SEC * (int64_t)((int) t1.tv_sec - (int) t2.tv_sec);
+	diff += ((int) t1.tv_nsec - (int) t2.tv_nsec);
+	return diff;
+}
+
+void traceopt(char *option)
+{
+	char *ptr;
+	if (traceopt_count + 1 > traceopt_size) {
+		traceopt_size += 16;
+		printf("expanding traceopt buffer to %d entries\n", traceopt_size);
+		traceptr = realloc(traceptr, sizeof(char*) * traceopt_size);
+		if (traceptr == NULL)
+			fatal ("Error allocating space for %d trace options\n",
+			       traceopt_count+1);
+	}
+	ptr = malloc(strlen(option)+1);
+	if (ptr == NULL)
+		fatal("error allocating space for trace option %s\n", option);
+	printf("adding traceopt %s\n", option);
+	strcpy(ptr, option);
+	traceptr[traceopt_count++] = ptr;
+}
+
+
+static int
+trace_file_exists(char *name)
+{
+	struct stat sbuf;
+	char *tracing_prefix = get_debugfileprefix();
+	char path[MAX_PATH];
+	strcat(strcpy(path, tracing_prefix), name);
+	return stat(path, &sbuf) ? 0 : 1;
+}
+
+void tracing(int on)
+{
+	if (on) {
+		switch (kernelversion) {
+		case KV_26_LT18: gettimeofday(0,(struct timezone *)1); break;
+		case KV_26_LT24: prctl(0, 1); break;
+		case KV_26_CURR: 
+			if (trace_file_exists("tracing_on"))
+				setkernvar("tracing_on", "1"); 
+			else
+				setkernvar("tracing_enabled", "1");
+			break;
+
+		default:	 break;
+		}
+	} else {
+		switch (kernelversion) {
+		case KV_26_LT18: gettimeofday(0,0); break;
+		case KV_26_LT24: prctl(0, 0); break;
+		case KV_26_CURR: 
+			if (trace_file_exists("tracing_on"))
+				setkernvar("tracing_on", "0"); 
+			else
+				setkernvar("tracing_enabled", "0"); 
+			break;
+		default:	break;
+		}
+	}
+}
+
+static int settracer(char *tracer)
+{
+	char filename[MAX_PATH];
+	char tracers[MAX_PATH];
+	char *name;
+	FILE *fp;
+	int ret = -1;
+	int len;
+	const char *delim = " \t\n";
+	char *prefix = get_debugfileprefix();
+
+	/* Make sure tracer is available */
+	strncpy(filename, prefix, sizeof(filename));
+	strncat(filename, "available_tracers", 
+		sizeof(filename) - strlen(prefix));
+
+	fp = fopen(filename, "r");
+	if (!fp)
+		return -1;
+
+	if (!(len = fread(tracers, 1, sizeof(tracers), fp))) {
+		fclose(fp);
+		return -1;
+	}
+	tracers[len] = '\0';
+	fclose(fp);
+
+	name = strtok(tracers, delim);
+	while (name) {
+		if (strcmp(name, tracer) == 0) {
+			ret = 0;
+			break;
+		}
+		name = strtok(NULL, delim);
+	}
+
+	if (!ret)
+		setkernvar("current_tracer", tracer);
+
+	return ret;
+}
+
+static void setup_tracer(void)
+{
+	if (!tracelimit)
+		return;
+
+	if (kernelversion == KV_26_CURR) {
+		char testname[MAX_PATH];
+
+		fileprefix = get_debugfileprefix();
+		strcpy(testname, fileprefix);
+		strcat(testname, "tracing_enabled");
+		if (access(testname, R_OK))
+			warn("%s not found\n"
+			    "debug fs not mounted, "
+			    "TRACERs not configured?\n", testname);
+	} else
+		fileprefix = procfileprefix;
+
+	if (kernelversion == KV_26_CURR) {
+		char buffer[32];
+		int ret;
+
+		setkernvar("tracing_enabled", "1");
+
+		sprintf(buffer, "%d", tracelimit);
+		setkernvar("tracing_thresh", buffer);
+
+		/* ftrace_enabled is a sysctl variable */
+		fileprefix = procfileprefix;
+		if (ftrace)
+			setkernvar("ftrace_enabled", "1");
+		else
+			setkernvar("ftrace_enabled", "0");
+		fileprefix = get_debugfileprefix();
+
+		switch (tracetype) {
+		case NOTRACE:
+			if (ftrace)
+				ret = settracer(functiontracer);
+			else
+				ret = 0;
+			break;
+		case IRQSOFF:
+			ret = settracer("irqsoff");
+			break;
+		case PREEMPTOFF:
+			ret = settracer("preemptoff");
+			break;
+		case IRQPREEMPTOFF:
+			ret = settracer("preemptirqsoff");
+			break;
+		case EVENTS:
+			ret = settracer("events");
+			if (ftrace)
+				ret = settracer(functiontracer);
+			break;
+		case CTXTSWITCH:
+			ret = settracer("sched_switch");
+			break;
+               case WAKEUP:
+                       ret = settracer("wakeup");
+                       break;
+               case WAKEUPRT:
+                       ret = settracer("wakeup_rt");
+                       break;
+		default:
+			if (strlen(tracer)) {
+				ret = settracer(tracer);
+				if (strcmp(tracer, "events") == 0 && ftrace)
+					ret = settracer(functiontracer);
+			}
+			else {
+				printf("signaltest: unknown tracer!\n");
+				ret = 0;
+			}
+			break;
+		}
+
+		if (ret)
+			fprintf(stderr, "Requested tracer '%s' not available\n", tracer);
+
+		setkernvar(traceroptions, "print-parent");
+		setkernvar(traceroptions, "latency-format");
+		if (verbose) {
+			setkernvar(traceroptions, "sym-offset");
+			setkernvar(traceroptions, "sym-addr");
+			setkernvar(traceroptions, "verbose");
+		} else {
+			setkernvar(traceroptions, "nosym-offset");
+			setkernvar(traceroptions, "nosym-addr");
+			setkernvar(traceroptions, "noverbose");
+		}
+		if (traceopt_count) {
+			int i;
+			for (i = 0; i < traceopt_count; i++)
+				setkernvar(traceroptions, traceptr[i]);
+		}
+		setkernvar("tracing_max_latency", "0");
+		setkernvar("latency_hist/wakeup_latency/reset", "1");
+	} else {
+		setkernvar("trace_all_cpus", "1");
+		setkernvar("trace_freerunning", "1");
+		setkernvar("trace_print_on_crash", "0");
+		setkernvar("trace_user_triggered", "1");
+		setkernvar("trace_user_trigger_irq", "-1");
+		setkernvar("trace_verbose", "0");
+		setkernvar("preempt_thresh", "0");
+		setkernvar("wakeup_timing", "0");
+		setkernvar("preempt_max_latency", "0");
+		if (ftrace)
+			setkernvar("mcount_enabled", "1");
+		setkernvar("trace_enabled", "1");
+	}
+
+	tracing(1);
+}
+
+/*
+ * parse an input value as a base10 value followed by an optional
+ * suffix. The input value is presumed to be in seconds, unless
+ * followed by a modifier suffix: m=minutes, h=hours, d=days
+ *
+ * the return value is a value in seconds
+ */
+int
+parse_time_string(char *val)
+{
+	char *end;
+	int t = strtol(val, &end, 10);
+	if (end) {
+		switch (*end) {
+		case 'm':
+		case 'M':
+			t *= 60;
+			break;
+
+		case 'h':
+		case 'H':
+			t *= 60*60;
+			break;
+
+		case 'd':
+		case 'D':
+			t *= 24*60*60;
+			break;
+
+		}
+	}
+	return t;
+}
+
 /*
  * signal thread
  *
@@ -94,23 +508,31 @@ void *signalthread(void *param)
 	struct thread_param *par = param;
 	struct sched_param schedp;
 	sigset_t sigset;
-	struct timespec before, after;
+	struct timespec before, after, now, stop;
 	struct thread_stat *stat = par->stats;
-	int policy = par->prio ? SCHED_FIFO : SCHED_OTHER;
 	int stopped = 0;
 	int first = 1;
+	cpu_set_t mask;
 
-	if (tracelimit) {
-		system("echo 1 > /proc/sys/kernel/trace_all_cpus");
-		system("echo 1 > /proc/sys/kernel/trace_enabled");
-		system("echo 1 > /proc/sys/kernel/trace_freerunning");
-		system("echo 0 > /proc/sys/kernel/trace_print_at_crash");
-		system("echo 1 > /proc/sys/kernel/trace_user_triggered");
-		system("echo -1 > /proc/sys/kernel/trace_user_trigger_irq");
-		system("echo 0 > /proc/sys/kernel/trace_verbose");
-		system("echo 0 > /proc/sys/kernel/preempt_thresh");
-		system("echo 0 > /proc/sys/kernel/wakeup_timing");
-		system("echo 0 > /proc/sys/kernel/preempt_max_latency");
+	/* if we're running in numa mode, set our memory node */
+	if (par->node != -1)
+		rt_numa_set_numa_run_on_node(par->node, par->cpu);
+
+	if (par->cpu != -1) {
+		CPU_ZERO(&mask);
+		CPU_SET(par->cpu, &mask);
+		if (sched_setaffinity(0, sizeof(mask), &mask) == -1)
+			warn("Could not set CPU affinity to CPU #%d\n", par->cpu);
+	}
+
+	/* Get current time */
+	clock_gettime(par->clock, &now);
+
+	if (duration) {
+		memset(&stop, 0, sizeof(stop)); /* grrr */
+		stop = now;
+		stop.tv_sec += duration;
+		tsnorm(&stop);
 	}
 
 	stat->tid = gettid();
@@ -121,38 +543,33 @@ void *signalthread(void *param)
 
 	memset(&schedp, 0, sizeof(schedp));
 	schedp.sched_priority = par->prio;
-	sched_setscheduler(0, policy, &schedp);
+	sched_setscheduler(0, par->policy, &schedp);
 
 	stat->threadstarted++;
 
-	if (tracelimit) {
-		if (oldtrace)
-			gettimeofday(0,(struct timezone *)1);
-		else
-			prctl(0, 1);
-	}
-
-	clock_gettime(CLOCK_MONOTONIC, &before);
+	clock_gettime(par->clock, &before);
 
 	while (!shutdown) {
+		static volatile long slept;
 		struct timespec now;
 		long diff;
+		int is_sleep_cycle = !(stat->cycles & 0x0F);
 		int sigs;
 
 		if (sigwait(&sigset, &sigs) < 0)
 			goto out;
 
-		clock_gettime(CLOCK_MONOTONIC, &after);
+		clock_gettime(par->clock, &after);
 
 		/*
 		 * If it is the first thread, sleep after every 16
 		 * round trips.
 		 */
-		if (!par->id && !(stat->cycles & 0x0F))
+		if (is_sleep_cycle && !par->id)
 			usleep(10000);
 
 		/* Get current time */
-		clock_gettime(CLOCK_MONOTONIC, &now);
+		clock_gettime(par->clock, &now);
 		pthread_kill(stat->tothread, SIGUSR1);
 
 		/* Skip the first cycle */
@@ -162,21 +579,47 @@ void *signalthread(void *param)
 			continue;
 		}
 
-		diff = calcdiff(after, before);
+		if (use_nsecs)
+			diff = calcdiff_ns(after, before);
+		else
+			diff = calcdiff(after, before);
 		before = now;
+
+		/*
+		 * If it's NOT the first thread, deduct the time
+		 * the first thread slept.  Otherwise all others
+		 * will add time slept as latency, inflating max.
+		 */
+		if (is_sleep_cycle) {
+			if (!par->id) {
+				if (use_nsecs)
+					slept = calcdiff_ns(now, after);
+				else
+					slept = calcdiff(now, after);
+			} else
+				diff -= slept;
+		}
+
 		if (diff < stat->min)
 			stat->min = diff;
-		if (diff > stat->max)
+		if (diff > stat->max) {
 			stat->max = diff;
+			if (refresh_on_max)
+				pthread_cond_signal(&refresh_on_max_cond);
+		}
 		stat->avg += (double) diff;
 
+		if (duration && (calcdiff(now, stop) >= 0))
+			shutdown++;
+
 		if (!stopped && tracelimit && (diff > tracelimit)) {
 			stopped++;
-			if (oldtrace)
-				gettimeofday(0,0);
-			else
-				prctl(0, 0);
+			tracing(0);
 			shutdown++;
+			pthread_mutex_lock(&break_thread_id_lock);
+			if (break_thread_id == 0)
+				break_thread_id = stat->tid;
+			pthread_mutex_unlock(&break_thread_id_lock);
 		}
 		stat->act = diff;
 		stat->cycles++;
@@ -184,6 +627,14 @@ void *signalthread(void *param)
 		if (par->bufmsk)
 			stat->values[stat->cycles & par->bufmsk] = diff;
 
+		/* Update the histogram */
+		if (histogram) {
+			if (diff >= histogram)
+				stat->hist_overflow++;
+			else
+				stat->hist_array[diff]++;
+		}
+
 		if (par->max_cycles && par->max_cycles == stat->cycles)
 			break;
 	}
@@ -198,93 +649,403 @@ out:
 	return NULL;
 }
 
-
 /* Print usage information */
-static void display_help(void)
+static void display_help(int error)
 {
+	char tracers[MAX_PATH];
+	char *prefix;
+
+	prefix = get_debugfileprefix();
+	if (prefix[0] == '\0')
+		strcpy(tracers, "unavailable (debugfs not mounted)");
+	else {
+		fileprefix = prefix;
+		if (kernvar(O_RDONLY, "available_tracers", tracers, sizeof(tracers)))
+			strcpy(tracers, "none");
+	}
+		
 	printf("signaltest V %1.2f\n", VERSION_STRING);
 	printf("Usage:\n"
 	       "signaltest <options>\n\n"
+	       "-a [NUM] --affinity        run thread #N on processor #N, if possible\n"
+	       "                           with NUM pin all threads to the processor NUM\n"
 	       "-b USEC  --breaktrace=USEC send break trace command when latency > USEC\n"
+	       "-B       --preemptirqs     both preempt and irqsoff tracing (used with -b)\n"
+	       "-c CLOCK --clock=CLOCK     select clock\n"
+	       "                           0 = CLOCK_MONOTONIC (default)\n"
+	       "                           1 = CLOCK_REALTIME\n"
+	       "-C       --context         context switch tracing (used with -b)\n"
+	       "-D       --duration=t      specify a length for the test run\n"
+	       "                           default is in seconds, but 'm', 'h', or 'd' maybe added\n"
+	       "                           to modify value to minutes, hours or days\n"
+	       "-E       --event           event tracing (used with -b)\n"
+	       "-f       --ftrace          function trace (when -b is active)\n"
+	       "-h       --histogram=US    dump a latency histogram to stdout after the run\n"
+               "                           (with same priority about many threads)\n"
+	       "                           US is the max time to be be tracked in microseconds\n"
+	       "-I       --irqsoff         Irqsoff tracing (used with -b)\n"
 	       "-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
+	       "-m       --mlockall        lock current and future memory allocations\n"
+	       "-M       --refresh_on_max  delay updating the screen until a new max latency is hit\n" 
+	       "-N       --nsecs           print results in ns instead of us (default us)\n"
+	       "-o RED   --oscope=RED      oscilloscope mode, reduce verbose output by RED\n"
+	       "-O TOPT  --traceopt=TOPT   trace option\n"
 	       "-p PRIO  --prio=PRIO       priority of highest prio thread\n"
+	       "-P       --preemptoff      Preempt off tracing (used with -b)\n"
 	       "-q       --quiet           print only a summary on exit\n"
-	       "-t NUM   --threads=NUM     number of threads: default=2\n"
-	       "-m       --mlockall        lock current and future memory allocations\n"
+	       "-t       --threads         one thread per available processor\n"
+	       "-t [NUM] --threads=NUM     number of threads:\n"
+	       "                           without NUM, threads = max_cpus\n"
+	       "                           without -t default = 1\n"
+	       "-T TRACE --tracer=TRACER   set tracing function\n"
+	       "    configured tracers: %s\n"
+	       "-u       --unbuffered      force unbuffered output for live processing\n"
 	       "-v       --verbose         output values on stdout for statistics\n"
-	       "                           format: n:c:v n=tasknum c=count v=value in us\n");
-	exit(0);
+	       "                           format: n:c:v n=tasknum c=count v=value in us\n"
+               "-w       --wakeup          task wakeup tracing (used with -b)\n"
+               "-W       --wakeuprt        rt task wakeup tracing (used with -b)\n"
+               "-y POLI  --policy=POLI     policy of realtime thread, POLI may be fifo(default) or rr\n"
+               "                           format: --policy=fifo(default) or --policy=rr\n"
+	       "-S       --smp             Standard SMP testing: options -a -t -n and\n"
+               "                           same priority of all threads\n"
+	       "-U       --numa            Standard NUMA testing (similar to SMP option)\n"
+               "                           thread data structures allocated from local node\n",
+	       tracers
+		);
+	if (error)
+		exit(EXIT_FAILURE);
+	exit(EXIT_SUCCESS);
 }
 
 static int priority;
+static int policy = SCHED_OTHER;	/* default policy if not specified */
 static int num_threads = 2;
 static int max_cycles;
-static int verbose;
+static int clocksel = 0;
 static int quiet;
-static int lockall = 0;
+static int affinity = 0;
+static int smp = 0;
+
+enum {
+	AFFINITY_UNSPECIFIED,
+	AFFINITY_SPECIFIED,
+	AFFINITY_USEALL
+};
+static int setaffinity = AFFINITY_UNSPECIFIED;
+
+static int clocksources[] = {
+	CLOCK_MONOTONIC,
+	CLOCK_REALTIME,
+};
+
+static void handlepolicy(char *polname)
+{
+	if (strncasecmp(polname, "other", 5) == 0)
+		policy = SCHED_OTHER;
+	else if (strncasecmp(polname, "batch", 5) == 0)
+		policy = SCHED_BATCH;
+	else if (strncasecmp(polname, "idle", 4) == 0)
+		policy = SCHED_IDLE;
+	else if (strncasecmp(polname, "fifo", 4) == 0)
+		policy = SCHED_FIFO;
+	else if (strncasecmp(polname, "rr", 2) == 0)
+		policy = SCHED_RR;
+	else	/* default policy if we don't recognize the request */
+		policy = SCHED_OTHER;
+}
+
+static char *policyname(int policy)
+{
+	char *policystr = "";
+
+	switch(policy) {
+	case SCHED_OTHER:
+		policystr = "other";
+		break;
+	case SCHED_FIFO:
+		policystr = "fifo";
+		break;
+	case SCHED_RR:
+		policystr = "rr";
+		break;
+	case SCHED_BATCH:
+		policystr = "batch";
+		break;
+	case SCHED_IDLE:
+		policystr = "idle";
+		break;
+	}
+	return policystr;
+}
+
 
 /* Process commandline options */
 static void process_options (int argc, char *argv[])
 {
 	int error = 0;
+	int max_cpus = sysconf(_SC_NPROCESSORS_CONF);
+
 	for (;;) {
 		int option_index = 0;
 		/** Options for getopt */
 		static struct option long_options[] = {
+			{"affinity", optional_argument, NULL, 'a'},
 			{"breaktrace", required_argument, NULL, 'b'},
+			{"preemptirqs", no_argument, NULL, 'B'},
+			{"clock", required_argument, NULL, 'c'},
+			{"context", no_argument, NULL, 'C'},
+			{"event", no_argument, NULL, 'E'},
+			{"ftrace", no_argument, NULL, 'f'},
+			{"histogram", required_argument, NULL, 'h'},
+			{"irqsoff", no_argument, NULL, 'I'},
 			{"loops", required_argument, NULL, 'l'},
+			{"mlockall", no_argument, NULL, 'm' },
+			{"refresh_on_max", no_argument, NULL, 'M' },
+			{"nsecs", no_argument, NULL, 'N'},
+			{"oscope", required_argument, NULL, 'o'},
 			{"priority", required_argument, NULL, 'p'},
+                        {"policy", required_argument, NULL, 'y'},
+			{"preemptoff", no_argument, NULL, 'P'},
 			{"quiet", no_argument, NULL, 'q'},
-			{"threads", required_argument, NULL, 't'},
+			{"threads", optional_argument, NULL, 't'},
+			{"unbuffered", no_argument, NULL, 'u'},
 			{"verbose", no_argument, NULL, 'v'},
-			{"mlockall", no_argument, NULL, 'm'},
+			{"duration",required_argument, NULL, 'D'},
+                        {"wakeup", no_argument, NULL, 'w'},
+                        {"wakeuprt", no_argument, NULL, 'W'},
 			{"help", no_argument, NULL, '?'},
+			{"tracer", required_argument, NULL, 'T'},
+			{"traceopt", required_argument, NULL, 'O'},
+			{"smp", no_argument, NULL, 'S'},
+			{"numa", no_argument, NULL, 'U'},
 			{NULL, 0, NULL, 0}
 		};
-		int c = getopt_long (argc, argv, "b:c:d:i:l:np:qrsmt:v",
-			long_options, &option_index);
+		int c = getopt_long(argc, argv, "a::b:Bc:C:Efh:Il:MNo:O:p:PmqSt::uUvD:wWT:y:",
+				    long_options, &option_index);
 		if (c == -1)
 			break;
 		switch (c) {
+		case 'a':
+			if (smp) {
+				warn("-a ignored due to --smp\n");
+				break;
+			}
+			if (optarg != NULL) {
+				affinity = atoi(optarg);
+				setaffinity = AFFINITY_SPECIFIED;
+			} else if (optind<argc && atoi(argv[optind])) {
+				affinity = atoi(argv[optind]);
+				setaffinity = AFFINITY_SPECIFIED;
+			} else {
+				setaffinity = AFFINITY_USEALL;
+			}
+			break;
 		case 'b': tracelimit = atoi(optarg); break;
+		case 'B': tracetype = IRQPREEMPTOFF; break;
+		case 'c': clocksel = atoi(optarg); break;
+		case 'C': tracetype = CTXTSWITCH; break;
+		case 'E': tracetype = EVENTS; break;
+		case 'f': ftrace = 1; break;
+		case 'h': histogram = atoi(optarg); break;
+		case 'I': tracetype = IRQSOFF; break;
 		case 'l': max_cycles = atoi(optarg); break;
-		case 'p': priority = atoi(optarg); break;
+		case 'N': use_nsecs = 1; break;
+		case 'o': oscope_reduction = atoi(optarg); break;
+		case 'O': traceopt(optarg); break;
+		case 'p': 
+			priority = atoi(optarg); 
+			if (policy != SCHED_FIFO && policy != SCHED_RR)
+				policy = SCHED_FIFO;
+			break;
+		case 'P': tracetype = PREEMPTOFF; break;
 		case 'q': quiet = 1; break;
-		case 't': num_threads = atoi(optarg); break;
-		case 'm': lockall = 1; break;
+		case 't':
+			if (smp) {
+				warn("-t ignored due to --smp\n");
+				break;
+			}
+			if (optarg != NULL)
+				num_threads = atoi(optarg);
+			else if (optind<argc && atoi(argv[optind]))
+				num_threads = atoi(argv[optind]);
+			else
+				num_threads = max_cpus;
+			break;
+		case 'T': 
+			tracetype = CUSTOM;
+			strncpy(tracer, optarg, sizeof(tracer)); 
+			break;
+		case 'u': setvbuf(stdout, NULL, _IONBF, 0); break;
 		case 'v': verbose = 1; break;
-		case '?': error = 1; break;
+		case 'm': lockall = 1; break;
+		case 'M': refresh_on_max = 1; break;
+		case 'D': duration = parse_time_string(optarg);
+			break;
+                case 'w': tracetype = WAKEUP; break;
+                case 'W': tracetype = WAKEUPRT; break;
+                case 'y': handlepolicy(optarg); break;
+		case 'S':  /* SMP testing */
+			if (numa)
+				fatal("numa and smp options are mutually exclusive\n");
+			smp = 1;
+			num_threads = max_cpus;
+			setaffinity = AFFINITY_USEALL;
+			break;
+		case 'U':  /* NUMA testing */
+			if (smp)
+				fatal("numa and smp options are mutually exclusive\n");
+#ifdef NUMA
+			numa = 1;
+			num_threads = max_cpus;
+			setaffinity = AFFINITY_USEALL;
+#else
+			warn("signaltest was not built with the numa option\n");
+			warn("ignoring --numa or -U\n");
+#endif
+			break;
+		case '?': display_help(0); break;
 		}
 	}
 
+	if (setaffinity == AFFINITY_SPECIFIED) {
+		if (affinity < 0)
+			error = 1;
+		if (affinity >= max_cpus) {
+			warn("CPU #%d not found, only %d CPUs available\n",
+			    affinity, max_cpus);
+			error = 1;
+		}
+	} else if (tracelimit)
+		fileprefix = procfileprefix;
+
+	if (clocksel < 0 || clocksel > ARRAY_SIZE(clocksources))
+		error = 1;
+
+	if (oscope_reduction < 1)
+		error = 1;
+
+	if (oscope_reduction > 1 && !verbose) {
+		warn("-o option only meaningful, if verbose\n");
+		error = 1;
+	}
+
+	if (histogram < 0)
+		error = 1;
+
+	if (histogram > HIST_MAX)
+		histogram = HIST_MAX;
+
 	if (priority < 0 || priority > 99)
 		error = 1;
 
+	if (priority && (policy != SCHED_FIFO && policy != SCHED_RR)) {
+		fprintf(stderr, "policy and priority don't match: setting policy to SCHED_FIFO\n");
+		policy = SCHED_FIFO;
+	}
+
+	if ((policy == SCHED_FIFO || policy == SCHED_RR) && priority == 0) {
+		fprintf(stderr, "defaulting realtime priority to %d\n", 
+			num_threads+1);
+		priority = num_threads+1;
+	}
+
 	if (num_threads < 2)
 		error = 1;
 
 	if (error)
-		display_help ();
+		display_help(1);
 }
 
-static void check_kernel(void)
+static int check_kernel(void)
 {
-	size_t len;
-	char ver[256];
-	int fd, maj, min, sub;
-
-	fd = open("/proc/version", O_RDONLY, 0666);
-	len = read(fd, ver, 255);
-	close(fd);
-	ver[len-1] = 0x0;
-	sscanf(ver, "Linux version %d.%d.%d", &maj, &min, &sub);
-	if (maj == 2 && min == 6 && sub < 18)
-		oldtrace = 1;
+	struct utsname kname;
+	int maj, min, sub, kv, ret;
+
+	ret = uname(&kname);
+	if (ret) {
+		fprintf(stderr, "uname failed: %s. Assuming not 2.6\n",
+				strerror(errno));
+		return KV_NOT_26;
+	}
+	sscanf(kname.release, "%d.%d.%d", &maj, &min, &sub);
+	if (maj == 2 && min == 6) {
+		if (sub < 18)
+			kv = KV_26_LT18;
+		else if (sub < 24)
+			kv = KV_26_LT24;
+		else if (sub < 28) {
+			kv = KV_26_CURR;
+			strcpy(functiontracer, "ftrace");
+			strcpy(traceroptions, "iter_ctrl");
+		} else {
+			kv = KV_26_CURR;
+			strcpy(functiontracer, "function");
+			strcpy(traceroptions, "trace_options");
+		}
+	} else
+		kv = KV_NOT_26;
+
+	return kv;
+}
+
+static int check_timer(void)
+{
+	struct timespec ts;
+
+	if (clock_getres(CLOCK_MONOTONIC, &ts))
+		return 1;
+
+	return (ts.tv_sec != 0 || ts.tv_nsec != 1);
 }
 
 static void sighand(int sig)
 {
 	shutdown = 1;
+	if (refresh_on_max)
+		pthread_cond_signal(&refresh_on_max_cond);
+}
+
+static void print_tids(struct thread_param *par[], int nthreads)
+{
+	int i;
+
+	printf("# Thread Ids:");
+	for (i = 0; i < nthreads; i++)
+		printf(" %05d", par[i]->stats->tid);
+	printf("\n");
+}
+
+static void print_hist(struct thread_param *par[], int nthreads)
+{
+	int i, j;
+	uint64_t log_entries[nthreads];
+
+	bzero(log_entries, sizeof(log_entries));
+
+	printf("# Histogram\n");
+	for (i = 0; i < histogram; i++) {
+
+		printf("%06d ", i);
+
+		for (j = 0; j < nthreads; j++) {
+			unsigned long curr_latency=par[j]->stats->hist_array[i];
+			printf("%06lu\t", curr_latency);
+			log_entries[j] += curr_latency;
+		}
+		printf("\n");
+	}
+	printf("# Total:");
+	for (j = 0; j < nthreads; j++)
+		printf(" %09llu", log_entries[j]);
+	printf("\n");
+	printf("# Max Latencys:");
+	for (j = 0; j < nthreads; j++)
+		printf(" %05lu", par[j]->stats->max);
+	printf("\n");
+	printf("# Histogram Overflows:");
+	for (j = 0; j < nthreads; j++)
+		printf(" %05lu", par[j]->stats->hist_overflow);
+	printf("\n");
 }
 
 static void print_stat(struct thread_param *par, int index, int verbose)
@@ -293,17 +1054,33 @@ static void print_stat(struct thread_param *par, int index, int verbose)
 
 	if (!verbose) {
 		if (quiet != 1) {
-			printf("T:%2d (%5d) P:%2d C:%7lu "
-			       "Min:%7ld Act:%5ld Avg:%5ld Max:%8ld\n",
-			       index, stat->tid, par->prio,
-			       stat->cycles, stat->min, stat->act,
+			char *fmt;
+			if (use_nsecs)
+                                fmt = "T:%2d (%5d) P:%2d C:%7lu "
+					"Min:%7ld Act:%8ld Avg:%8ld Max:%8ld\n";
+			else
+                                fmt = "T:%2d (%5d) P:%2d C:%7lu "
+					"Min:%7ld Act:%5ld Avg:%5ld Max:%8ld\n";
+                        printf(fmt, index, stat->tid, par->prio, 
+                               stat->cycles, stat->min, stat->act,
 			       stat->cycles ?
 			       (long)(stat->avg/stat->cycles) : 0, stat->max);
 		}
 	} else {
 		while (stat->cycles != stat->cyclesread) {
-			long diff = stat->values[stat->cyclesread & par->bufmsk];
-			printf("%8d:%8lu:%8ld\n", index, stat->cyclesread, diff);
+			long diff = stat->values
+			    [stat->cyclesread & par->bufmsk];
+
+			if (diff > stat->redmax) {
+				stat->redmax = diff;
+				stat->cycleofmax = stat->cyclesread;
+			}
+			if (++stat->reduce == oscope_reduction) {
+				printf("%8d:%8lu:%8ld\n", index,
+				       stat->cycleofmax, stat->redmax);
+				stat->reduce = 0;
+				stat->redmax = 0;
+			}
 			stat->cyclesread++;
 		}
 	}
@@ -313,14 +1090,19 @@ int main(int argc, char **argv)
 {
 	sigset_t sigset;
 	int signum = SIGUSR1;
-	struct thread_param *par;
-	struct thread_stat *stat;
+	struct thread_param **parameters;
+	struct thread_stat **statistics;
+	int max_cpus = sysconf(_SC_NPROCESSORS_CONF);
 	int i, ret = -1;
+	int status;
+
+	process_options(argc, argv);
 
 	if (check_privs())
-		exit(-1);
+		exit(EXIT_FAILURE);
 
-	process_options(argc, argv);
+	/* Checks if numa is on, program exits if numa on but not available */
+	numa_on_and_available();
 
 	/* lock all memory (prevent paging) */
 	if (lockall)
@@ -328,8 +1110,17 @@ int main(int argc, char **argv)
 			perror("mlockall");
 			goto out;
 		}
-		
-	check_kernel();
+
+
+	kernelversion = check_kernel();
+
+	if (kernelversion == KV_NOT_26)
+		warn("Most functions require kernel 2.6\n");
+
+	setup_tracer();
+
+	if (check_timer())
+		warn("High resolution timers not available\n");
 
 	sigemptyset(&sigset);
 	sigaddset(&sigset, signum);
@@ -338,99 +1129,231 @@ int main(int argc, char **argv)
 	signal(SIGINT, sighand);
 	signal(SIGTERM, sighand);
 
-	par = calloc(num_threads, sizeof(struct thread_param));
-	if (!par)
+	parameters = calloc(num_threads, sizeof(struct thread_param *));
+	if (!parameters)
 		goto out;
-	stat = calloc(num_threads, sizeof(struct thread_stat));
-	if (!stat)
+	statistics = calloc(num_threads, sizeof(struct thread_stat *));
+	if (!statistics)
 		goto outpar;
 
 	for (i = 0; i < num_threads; i++) {
+		pthread_attr_t attr;
+		int node;
+		struct thread_param *par;
+		struct thread_stat *stat;
+
+		status = pthread_attr_init(&attr);
+		if (status != 0)
+			fatal("error from pthread_attr_init for thread %d: %s\n", i, strerror(status));
+
+		node = -1;
+		if (numa) {
+			void *stack;
+			void *currstk;
+			size_t stksize;
+
+			/* find the memory node associated with the cpu i */
+			node = rt_numa_numa_node_of_cpu(i);
+
+			/* get the stack size set for for this thread */
+			if (pthread_attr_getstack(&attr, &currstk, &stksize))
+				fatal("failed to get stack size for thread %d\n", i);
+
+			/* if the stack size is zero, set a default */
+			if (stksize == 0)
+				stksize = PTHREAD_STACK_MIN * 2;
+
+			/*  allocate memory for a stack on appropriate node */
+			stack = rt_numa_numa_alloc_onnode(stksize, node, i);
+
+			/* set the thread's stack */
+			if (pthread_attr_setstack(&attr, stack, stksize))
+				fatal("failed to set stack addr for thread %d to 0x%x\n",
+				      i, stack+stksize);
+		}
+
+		/* allocate the thread's parameter block  */
+		parameters[i] = par = threadalloc(sizeof(struct thread_param), node);
+		if (par == NULL)
+			fatal("error allocating thread_param struct for thread %d\n", i);
+		memset(par, 0, sizeof(struct thread_param));
+
+		/* allocate the thread's statistics block */
+		statistics[i] = stat = threadalloc(sizeof(struct thread_stat), node);
+		if (stat == NULL)
+			fatal("error allocating thread status struct for thread %d\n", i);
+		memset(stat, 0, sizeof(struct thread_stat));
+
+		/* allocate the histogram if requested */
+		if (histogram) {
+			int bufsize = histogram * sizeof(long);
+
+			stat->hist_array = threadalloc(bufsize, node);
+			if (stat->hist_array == NULL)
+				fatal("failed to allocate histogram of size %d on node %d\n",
+				      histogram, i);
+			memset(stat->hist_array, 0, bufsize);
+		}
+
 		if (verbose) {
-			stat[i].values = calloc(VALBUF_SIZE, sizeof(long));
-			if (!stat[i].values)
+			int bufsize = VALBUF_SIZE * sizeof(long);
+			stat->values = threadalloc(bufsize, node);
+			if (!stat->values)
 				goto outall;
-			par[i].bufmsk = VALBUF_SIZE - 1;
+			memset(stat->values, 0, bufsize);
+			par->bufmsk = VALBUF_SIZE - 1;
 		}
 
-		par[i].id = i;
-		par[i].prio = priority;
-#if 0
-		if (priority)
-			priority--;
-#endif
-		par[i].signal = signum;
-		par[i].max_cycles = max_cycles;
-		par[i].stats = &stat[i];
-		stat[i].min = 1000000;
-		stat[i].max = -1000000;
-		stat[i].avg = 0.0;
-		stat[i].threadstarted = 1;
-		pthread_create(&stat[i].thread, NULL, signalthread, &par[i]);
+		par->id = i;
+		par->prio = priority;
+                if (priority && (policy == SCHED_FIFO || policy == SCHED_RR))
+			par->policy = policy;
+                else {
+			par->policy = SCHED_OTHER;
+			force_sched_other = 1;
+		}
+		par->clock = clocksources[clocksel];
+		par->signal = signum;
+		par->max_cycles = max_cycles;
+		par->stats = stat;
+		par->node = node;
+		switch (setaffinity) {
+		case AFFINITY_UNSPECIFIED: par->cpu = -1; break;
+		case AFFINITY_SPECIFIED: par->cpu = affinity; break;
+		case AFFINITY_USEALL: par->cpu = i % max_cpus; break;
+		}
+		stat->min = 1000000;
+		stat->max = 0;
+		stat->avg = 0.0;
+		stat->threadstarted = 1;
+		status = pthread_create(&stat->thread, &attr, signalthread, par);
+		if (status)
+			fatal("failed to create thread %d: %s\n", i, strerror(status));
+
 	}
 
 	while (!shutdown) {
 		int allstarted = 1;
 
 		for (i = 0; i < num_threads; i++) {
-			if (stat[i].threadstarted != 2)
+			if (statistics[i]->threadstarted != 2)
 				allstarted = 0;
 		}
+
 		if (!allstarted)
 			continue;
 
 		for (i = 0; i < num_threads - 1; i++)
-			stat[i].tothread = stat[i+1].thread;
-		stat[i].tothread = stat[0].thread;
+			statistics[i]->tothread = statistics[i+1]->thread;
+		statistics[i]->tothread = statistics[0]->thread;
 		break;
 	}
-	pthread_kill(stat[0].thread, signum);
+
+	pthread_kill(statistics[0]->thread, signum);
 
 	while (!shutdown) {
 		char lavg[256];
 		int fd, len, allstopped = 0;
+		static char *policystr = NULL;
+		static char *slash = NULL;
+		static char *policystr2;
+
+		if (!policystr)
+			policystr = policyname(policy);
 
+		if (!slash) {
+			if (force_sched_other) {
+				slash = "/";
+				policystr2 = policyname(SCHED_OTHER);
+			} else
+				slash = policystr2 = "";
+		}
 		if (!verbose && !quiet) {
 			fd = open("/proc/loadavg", O_RDONLY, 0666);
 			len = read(fd, &lavg, 255);
 			close(fd);
 			lavg[len-1] = 0x0;
-			printf("%s          \n\n", lavg);
+			printf("policy: %s%s%s: loadavg: %s          \n\n",
+			       policystr, slash, policystr2, lavg);
 		}
 
-		print_stat(&par[0], 0, verbose);
-		if(max_cycles && stat[0].cycles >= max_cycles)
-			allstopped++;
+		for (i = 0; i < num_threads; i++) {
+
+			print_stat(parameters[i], i, verbose);
+			if(max_cycles && statistics[i]->cycles >= max_cycles)
+				allstopped++;
+		}
 
 		usleep(10000);
 		if (shutdown || allstopped)
 			break;
 		if (!verbose && !quiet)
-			printf("\033[%dA", 3);
+			printf("\033[%dA", num_threads + 2);
+
+		if (refresh_on_max) {
+			pthread_mutex_lock(&refresh_on_max_lock);
+			pthread_cond_wait(&refresh_on_max_cond,
+					  &refresh_on_max_lock);
+			pthread_mutex_unlock(&refresh_on_max_lock);
+		}
 	}
-	ret = 0;
+	ret = EXIT_SUCCESS;
+
  outall:
 	shutdown = 1;
 	usleep(50000);
+
 	if (quiet)
 		quiet = 2;
 	for (i = 0; i < num_threads; i++) {
-		if (stat[i].threadstarted > 0)
-			pthread_kill(stat[i].thread, SIGTERM);
-		if (stat[i].threadstarted) {
-			pthread_join(stat[i].thread, NULL);
-			if (quiet)
-				print_stat(&par[i], i, 0);
-		}
-		if (stat[i].values)
-			free(stat[i].values);
+		if (statistics[i]->threadstarted > 0)
+			pthread_kill(statistics[i]->thread, SIGTERM);
+		if (statistics[i]->threadstarted) {
+			pthread_join(statistics[i]->thread, NULL);
+			if (quiet && !histogram)
+				print_stat(parameters[i], i, 0);
+		}
+		if (statistics[i]->values)
+			threadfree(statistics[i]->values, VALBUF_SIZE*sizeof(long), parameters[i]->node);
+	}
+
+	if (histogram) {
+		print_hist(parameters, num_threads);
+		for (i = 0; i < num_threads; i++)
+			threadfree(statistics[i]->hist_array, histogram*sizeof(long), parameters[i]->node);
 	}
-	free(stat);
+
+	if (tracelimit) {
+		print_tids(parameters, num_threads);
+		if (break_thread_id)
+			printf("# Break thread: %d\n", break_thread_id);
+	}
+	
+
+	for (i=0; i < num_threads; i++) {
+		if (!statistics[i])
+			continue;
+		threadfree(statistics[i], sizeof(struct thread_stat), parameters[i]->node);
+	}
+
  outpar:
-	free(par);
+	for (i = 0; i < num_threads; i++) {
+		if (!parameters[i])
+			continue;
+		threadfree(parameters[i], sizeof(struct thread_param), parameters[i]->node);
+	}
  out:
+	/* ensure that the tracer is stopped */
+	if (tracelimit)
+		tracing(0);
+
+	/* unlock everything */
 	if (lockall)
 		munlockall();
 
+	/* Be a nice program, cleanup */
+	if (kernelversion != KV_26_CURR)
+		restorekernvars();
+
 	exit(ret);
 }


