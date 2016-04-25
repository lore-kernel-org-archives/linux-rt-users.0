From: John Kacur <jkacur@redhat.com>
Subject: [PATCH] rt-tests: Update the cyclictest man page
Date: Mon, 25 Apr 2016 16:17:11 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1604251614270.6896@riemann>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: RT <linux-rt-users@vger.kernel.org>,
	Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33737 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752020AbcDYORT (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 25 Apr 2016 10:17:19 -0400
Received: by mail-wm0-f67.google.com with SMTP id r12so22415788wme.0
        for <linux-rt-users@vger.kernel.org>; Mon, 25 Apr 2016 07:17:18 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

>From 7e007ac70a83f62583d25b10ad2df0430306bf32 Mon Sep 17 00:00:00 2001
From: John Kacur <jkacur@redhat.com>
Date: Mon, 25 Apr 2016 16:08:28 +0200
Subject: [PATCH] rt-tests: Update the cyclictest man page

We have done a good job keeping cyclictest help up-to-date, but we have
not been actively updating the man page.

There were many missing options, as well as options that don't exist
anymore. To be more precise, some short form options had been removed,
but there are still corresponding long-version options.

This patch contains a considerable amount of updates to the man-page to
keep it in sync, and in some cases it also updates the cyclictest help
where needed. For example, the cyclictest help options were not always
in the proper order. In some cases I changed the wording to make it more
closely correspond to the man page

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/cyclictest.8 | 169 ++++++++++++++++++++++++--------------------
 src/cyclictest/cyclictest.c |  35 ++++-----
 2 files changed, 110 insertions(+), 94 deletions(-)

diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
index 437e7a68a74f..120dae23860e 100644
--- a/src/cyclictest/cyclictest.8
+++ b/src/cyclictest/cyclictest.8
@@ -1,5 +1,5 @@
 .\"                                      Hey, EMACS: -*- nroff -*-
-.TH CYCLICTEST 8 "december  20, 2007"
+.TH CYCLICTEST 8 "April 22, 2016"
 .\" Please adjust this date whenever revising the manpage.
 .\"
 .\" Some roff macros, for reference:
@@ -36,7 +36,7 @@ A summary of options is included below.
 .B \-a, \-\-affinity[=PROC-SET]
 Run threads on the set of procesors given by PROC-SET.  If PROC-SET is not
 specified, all processors will be used.  Threads will be assigned to processors
-in the set in numeric order, in a round-robin fashion.
+in the set in numeric order, in a round\-robin fashion.
 .br
 The set of processors can be specified as A,B,C, or A-C, or A-B,D-F, and so on*.
 The ! character can be used to negate a set.  For example, !B-D means to use all
@@ -47,55 +47,31 @@ field in /proc/cpuinfo.  See numa(3) for more information on specifying CPU sets
 if specified, must be a single CPU number.
 .TP
 .B \-A, \-\-align=USEC
-Align measurement thread wakeups to a specific offset in microseconds
+Align thread wakeups to a specific offset in microseconds
 .TP
 .B \-b, \-\-breaktrace=USEC
-Send break trace command when latency > USEC. This is a debugging option to control the latency tracer in the realtime preemption patch.
-It is useful to track down unexpected large latencies on a system. This option does only work with following kernel config options.
-
-    For kernel < 2.6.24:
-.br
-    * CONFIG_PREEMPT_RT=y
-.br
-    * CONFIG_WAKEUP_TIMING=y
-.br
-    * CONFIG_LATENCY_TRACE=y
-.br
-    * CONFIG_CRITICAL_PREEMPT_TIMING=y
-.br
-    * CONFIG_CRITICAL_IRQSOFF_TIMING=y
-.sp 1
-    For kernel >= 2.6.24:
-.br
-    * CONFIG_PREEMPT_RT=y
-.br
-    * CONFIG_FTRACE
-.br
-    * CONFIG_IRQSOFF_TRACER=y
-.br
-    * CONFIG_PREEMPT_TRACER=y
-.br
-    * CONFIG_SCHED_TRACER=y
-.br
-    * CONFIG_WAKEUP_LATENCY_HIST
-
-
-kernel configuration options enabled. The USEC parameter to the \-b option defines a maximum latency value, which is compared against the actual latencies of the test. Once the measured latency is higher than the given maximum, the kernel tracer and cyclictest is stopped. The trace can be read from /proc/latency_trace. Please be aware that the tracer adds significant overhead to the kernel, so the latencies will be much higher than on a kernel with latency tracing disabled.
+Sned break trace command when latency > USEC
+.TP
+.B \-B, \-\-preemptirqs
+Both preempt and irqsoff tracing (used with -b)
 .TP
 .B \-c, \-\-clock=CLOCK
-Selects the clock, which is used:
-
-    * 0 selects CLOCK_MONOTONIC, which is the monotonic increasing system time (default).
-    * 1 selects CLOCK_REALTIME, which is the time of day time.
-
-CLOCK_REALTIME can be set by settimeofday, while CLOCK_MONOTONIC can not be modified by the user.
-This option has no influence when the \-s option is given.
+select clock
+.br
+0 = CLOCK_MONOTONIC (default)
+.br
+1 = CLOCK_REALTIME
 .TP
 .B \-C, \-\-context
 context switch tracing (used with \-b)
 .TP
 .B \-d, \-\-distance=DIST
-Set the distance of thread intervals in microseconds (default is 500us). When cyclictest is called with the \-t option and more than one thread is created, then this distance value is added to the interval of the threads: Interval(thread N) = Interval(thread N\-1) + DIST
+Distance of thread intervals in us, default = 500
+.TP
+.B \-D, \-\-duration=TIME
+Specify a length for the test run.
+.br
+Append 'm', 'h', or 'd' to specify minutes, hours or days.
 .TP
 .B \-E, \-\-event
 event tracing (used with \-b)
@@ -103,21 +79,43 @@ event tracing (used with \-b)
 .B \-f, \-\-ftrace
 Enable function tracing using ftrace as tracer. This option is available only with \-b.
 .TP
-.B \-h, \-\-histogram=MAXLATENCYINUS
-Dump latency histogram to stdout. US means the max time to be be tracked in microseconds. When you use \-h option to get histogram data, Cyclictest runs many threads with same priority without priority\-\-.
+.B \-F, \-\-fifo=<path>
+Create a named pipe at path and write stats to it
+.TP
+.B \-h, \-\-histogram=US
+Dump latency histogram to stdout after the run. US is the max latency time to be be tracked in microseconds. This option runs all threads at the same priority.
 .TP
 .B \-H, \-\-histofall=MAXLATENCYINUS
 Same as -h except that an additional histogram column is displayed at the right that contains summary data of all thread histograms. If cyclictest runs a single thread only, the -H option is equivalent to -h.
 .TP
+.B \-\-histfile=<path>
+Dump the latecny histogram to <path> instead of stdout.
+.TP
 .B \-i, \-\-interval=INTV
 Set the base interval of the thread(s) in microseconds (default is 1000us). This sets the interval of the first thread. See also \-d.
 .TP
+.B \-I, \-\-irqsoff
+Irgsoff tracing (used with \-b)
+.TP
 .B \-l, \-\-loops=LOOPS
 Set the number of loops. The default is 0 (endless). This option is useful for automated tests with a given number of test cycles. Cyclictest is stopped once the number of timer intervals has been reached.
 .TP
+.B \-\-laptop
+Save battery when running cyclictest. This will give you poorer realtime results, but will not drain your battery so quickly.
+.TP
+.B \-m, \-\-mlockall
+Lock current and future memory allocations to prevent being paged out
+.TP
+.B \\-M, \-\-refresh_on_max
+Delay updating the screen until a new max latency is hit. (useful for
+running cyclictest on low-bandwidth connections)
+.TP
 .B \-n, \-\-nanosleep
 Use clock_nanosleep instead of posix interval timers. Setting this option runs the tests with clock_nanosleep instead of posix interval timers.
 .TP
+.B \-\-notrace
+suppress tracing
+.TP
 .B \-N, \-\-nsecs
 Show results in nanoseconds instead of microseconds, which is the default unit.
 .TP
@@ -132,35 +130,70 @@ times for multiple trace options. For example trace options look at /sys/kernel/
 Set the priority of the first thread. The given priority is set to the first test thread. Each further thread gets a lower priority:
 Priority(Thread N) = max(Priority(Thread N\-1) \- 1, 0)
 .TP
+.B \-P, \-\-preemptoff
+Preempt off tracing (used with -b)
+.TP
+.B \-\-policy=NAME
+set the scheduler policy of the measurement threads
+where NAME is one of: other, normal, batch, idle, fifo, rr
+.TP
+.B \-\-priospread
+spread priority levels starting at a specified value
+.TP
 .B \-q, \-\-quiet
-Run the tests quiet and print only a summary on exit. Useful for automated tests, where only the summary output needs to be captured.
+Print a summary only on exit. Useful for automated tests, where only the summary output needs to be captured.
 .TP
 .B \-r, \-\-relative
 Use relative timers instead of absolute. The default behaviour of the tests is to use absolute timers. This option is there for completeness and should not be used for reproducible tests.
 .TP
+.B \-R, \-\-resolution
+Check clock resolution, calling clock_gettime() many times. List of lock_gettime() values will be reported with -X
+.TP
+.B \-\-secaligned [USEC]
+align thread wakeups to the next full second and apply the optional offset.
+.TP
 .B \-s, \-\-system
 Use sys_nanosleep and sys_setitimer instead of posix timers. Note, that \-s can only be used with one thread because itimers are per process and not per thread. \-s in combination with \-n uses the nanosleep syscall and is not restricted to one thread.
 .TP
-.B \-T, \-\-tracer=TRACEFUNC
-set the ftrace tracer function. Used with the \-b option. Must be one
-of the trace functions available from <debugfs-mountpoint>/kernel/debug/tracing/available_tracers
+.B \\-S, \-\-smp
+Set options for standard testing on SMP systems. Equivalent to using
+the options: "\-t \-a \-n" as well keeping any specified priority
+equal across all threads
+.TP
+.B \-\-spike=<trigger>
+record all spikes > trigger
+.TP
+.B \-\-spike-nodes=[num of nodes]
+These are the maximum number of spikes we can record.
+.br
+The default is 1024 if not specified.
+.TP
+.B \\-\-smi
+Enable SMI count/detection on processors with SMI count support.
 .TP
 .B \-t, \-\-threads[=NUM]
 Set the number of test threads (default is 1). Create NUM test threads. If NUM is not specified, NUM is set to
 the number of available CPUs. See \-d, \-i and \-p for further information.
 .TP
-.B \-m, \-\-mlockall
-Lock current and future memory allocations to prevent being paged out
+.B \-\-tracemark
+write a trace mark when \-b latency is exceeded.
+.TP
+.B \-T, \-\-tracer=TRACEFUNC
+set the ftrace tracer function. Used with the \-b option. Must be one
+of the trace functions available from <debugfs-mountpoint>/kernel/debug/tracing/available_tracers
+.TP
+.B \-u, \-\-unbuffered
+force unbuffered output for live processing
+.TP
+.B \-U, --numa
+Standard NUMA testing (similar to SMP option) thread data structures allocated from local node.
 .TP
 .B \-v, \-\-verbose
 Output values on stdout for statistics. This option is used to gather statistical information about the latency distribution. The output is sent to stdout. The output format is:
 
 n:c:v
 
-where n=task number c=count v=latency value in us. Use this option in combination with \-l
-.TP
-.B \\-D, \-\-duration=TIME
-Run the test for the specified time, which defaults to seconds. Append 'm', 'h', or 'd' to specify minutes, hours or days
+where n=task number c=count v=latency value in us.
 .TP
 .B \\-w, \-\-wakeup
 task wakeup tracing (used with \-b)
@@ -168,31 +201,11 @@ task wakeup tracing (used with \-b)
 .B \\-W, \-\-wakeuprt
 rt-task wakeup tracing (used with \-b)
 .TP
-.B \\-y, \-\-policy=NAME
-set the scheduler policy of the measurement threads
-where NAME is one of: other, normal, batch, idle, fifo, rr
-.TP
-.B \\-M, \-\-refresh_on_max
-delay updating the screen until a new max latency is hit (useful for
-running cyclictest on low-bandwidth connections)
-.TP
-.B \\-S, \-\-smp
-Set options for standard testing on SMP systems. Equivalent to using
-the options: "\-t \-a \-n" as well keeping any specified priority
-equal across all threads
-.TP
-.B \\-U, \-\-numa
-Similar to the above \-\-smp option, this implies the "\-t \-a \-n"
-options, as well as a constant measurement interval, but also forces
-memory allocations using the numa(3) policy library. Thread stacks and
-data structures are allocated from the NUMA node local to the core to
-which the thread is bound. Requires the underlying kernel to have NUMA
-support compiled in.
-.TP
-.B \\-\-smi
-Enable SMI count/detection on processors with SMI count support.
+.B \-\-dbg_cyclictest
+Print info userful for debugging cyclictest
 
 .SH SEE ALSO
+.BR numa (3),
 .BR numactl (8),
 .\" .br
 .\" The programs are documented fully by
@@ -203,3 +216,5 @@ cyclictest was written by Thomas Gleixner <tglx@linuxtronix.de>.
 .PP
 This manual page was written by Alessio Igor Bogani <abogani@texware.it>,
 for the Debian project (but may be used by others).
+.br
+Updated by John Kacur <jkacur@redhat.com>
diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 158bceda1204..902167010416 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1276,17 +1276,16 @@ static void display_help(int error)
 	       "                           0 = CLOCK_MONOTONIC (default)\n"
 	       "                           1 = CLOCK_REALTIME\n"
 	       "-C       --context         context switch tracing (used with -b)\n"
-	       "-d DIST  --distance=DIST   distance of thread intervals in us default=500\n"
-	       "-D       --duration=t      specify a length for the test run\n"
-	       "                           default is in seconds, but 'm', 'h', or 'd' maybe added\n"
-	       "                           to modify value to minutes, hours or days\n"
+	       "-d DIST  --distance=DIST   distance of thread intervals in us, default=500\n"
+	       "-D       --duration=TIME   specify a length for the test run.\n"
+	       "                           Append 'm', 'h', or 'd' to specify minutes, hours or days.\n"
 	       "	 --latency=PM_QOS  write PM_QOS to /dev/cpu_dma_latency\n"
 	       "-E       --event           event tracing (used with -b)\n"
 	       "-f       --ftrace          function trace (when -b is active)\n"
 	       "-F       --fifo=<path>     create a named pipe at path and write stats to it\n"
 	       "-h       --histogram=US    dump a latency histogram to stdout after the run\n"
-	       "                           (with same priority about many threads)\n"
-	       "                           US is the max time to be be tracked in microseconds\n"
+	       "                           US is the max latency time to be be tracked in microseconds\n"
+	       "			   This option runs all threads at the same priority.\n"
 	       "-H       --histofall=US    same as -h except with an additional summary column\n"
 	       "	 --histfile=<path> dump the latency histogram to <path> instead of stdout\n"
 	       "-i INTV  --interval=INTV   base interval of thread in us default=1000\n"
@@ -1296,7 +1295,8 @@ static void display_help(int error)
 	       "			   This will give you poorer realtime results\n"
 	       "			   but will not drain your battery so quickly\n"
 	       "-m       --mlockall        lock current and future memory allocations\n"
-	       "-M       --refresh_on_max  delay updating the screen until a new max latency is hit\n"
+	       "-M       --refresh_on_max  delay updating the screen until a new max\n"
+	       "			   latency is hit. Userful for low bandwidth.\n"
 	       "-n       --nanosleep       use clock_nanosleep\n"
 	       "	 --notrace	   suppress tracing\n"
 	       "-N       --nsecs           print results in ns instead of us (default us)\n"
@@ -1304,20 +1304,23 @@ static void display_help(int error)
 	       "-O TOPT  --traceopt=TOPT   trace option\n"
 	       "-p PRIO  --priority=PRIO   priority of highest prio thread\n"
 	       "-P       --preemptoff      Preempt off tracing (used with -b)\n"
-	       "-q       --quiet           print only a summary on exit\n"
-	       "	 --priospread       spread priority levels starting at specified value\n"
+	       "	 --policy=NAME     policy of measurement thread, where NAME may be one\n"
+	       "                           of: other, normal, batch, idle, fifo or rr.\n"
+	       "	 --priospread      spread priority levels starting at specified value\n"
+	       "-q       --quiet           print a summary only on exit\n"
 	       "-r       --relative        use relative timer instead of absolute\n"
 	       "-R       --resolution      check clock resolution, calling clock_gettime() many\n"
-	       "                           times.  list of clock_gettime() values will be\n"
+	       "                           times.  List of clock_gettime() values will be\n"
 	       "                           reported with -X\n"
-	       "         --secaligned [USEC] align thread wakeups to the next full second,\n"
+	       "         --secaligned [USEC] align thread wakeups to the next full second\n"
 	       "                           and apply the optional offset\n"
 	       "-s       --system          use sys_nanosleep and sys_setitimer\n"
 	       "-S       --smp             Standard SMP testing: options -a -t -n and\n"
 	       "                           same priority of all threads\n"
-	       "	--spike=trigger	   record all spikes > trigger\n"
-	       "	--spike-nodes	   these are the number of spikes we can record\n"
-	       "			   the default is 1024 if not specified\n"
+	       "	--spike=<trigger>  record all spikes > trigger\n"
+	       "	--spike-nodes=[num of nodes]\n"
+	       "			   These are the maximum number of spikes we can record.\n"
+	       "			   The default is 1024 if not specified\n"
 #ifdef ARCH_HAS_SMI_COUNTER
                "         --smi             Enable SMI counting\n"
 #endif
@@ -1337,9 +1340,7 @@ static void display_help(int error)
 	       "                           format: n:c:v n=tasknum c=count v=value in us\n"
 	       "-w       --wakeup          task wakeup tracing (used with -b)\n"
 	       "-W       --wakeuprt        rt task wakeup tracing (used with -b)\n"
-	       "	 --dbg_cyclictest  print info useful for debugging cyclictest\n"
-	       "	 --policy=POLI     policy of realtime thread, POLI may be fifo(default) or rr\n"
-	       "                           format: --policy=fifo(default) or --policy=rr\n",
+	       "	 --dbg_cyclictest  print info useful for debugging cyclictest\n",
 	       tracers
 		);
 	if (error)
-- 
2.4.11

