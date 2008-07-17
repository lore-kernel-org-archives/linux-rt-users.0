From: Alessio Igor Bogani <abogani@texware.it>
Subject: [PATCH] Differentiate hyphen and minus in manpages
Date: Thu, 17 Jul 2008 11:49:27 +0200
Message-ID: <1216288167-24814-1-git-send-email-abogani@texware.it>
Cc: Alessio Igor Bogani <abogani@texware.it>
To: linux-rt-users@vger.kernel.org, tglx@linutronix.de
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.186]:3768 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758477AbYGQJtk (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 17 Jul 2008 05:49:40 -0400
Received: by fk-out-0910.google.com with SMTP id 18so3713102fkq.5
        for <linux-rt-users@vger.kernel.org>; Thu, 17 Jul 2008 02:49:38 -0700 (PDT)
In-Reply-To: <>
References: <>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Signed-off-by: Alessio Igor Bogani <abogani@texware.it>
---
 src/cyclictest/cyclictest.8 |   20 +++++++++---------
 src/pi_tests/pi_stress.8    |   44 +++++++++++++++++++++---------------------
 2 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
index a4fd24b..9827458 100644
--- a/src/cyclictest/cyclictest.8
+++ b/src/cyclictest/cyclictest.8
@@ -16,7 +16,7 @@
 cyclictest \- High resolution test program
 .SH SYNOPSIS
 .B cyclictest
-.RI "[ -hfmnqrsv ] [\-a " proc " ] [\-b " usec " ] [\-c " clock " ] [\-d " dist " ] [\-i " intv " ] [\-l " loop " ] [\-o " red " ] [\-p " prio " ] [\-t " num " ]"
+.RI "[ \-hfmnqrsv ] [\-a " proc " ] [\-b " usec " ] [\-c " clock " ] [\-d " dist " ] [\-i " intv " ] [\-l " loop " ] [\-o " red " ] [\-p " prio " ] [\-t " num " ]"
 .\" .SH DESCRIPTION
 .\" This manual page documents briefly the
 .\" .B cyclictest commands.
@@ -25,7 +25,7 @@ cyclictest \- High resolution test program
 .\" \fBcyclictest\fP is a program that...
 .SH OPTIONS
 These programs follow the usual GNU command line syntax, with long
-options starting with two dashes ('--').
+options starting with two dashes ('\-\-').
 .br
 A summary of options is included below.
 .\" For a complete description, see the Info files.
@@ -64,7 +64,7 @@ It is useful to track down unexpected large latencies on a system. This option d
     * CONFIG_WAKEUP_LATENCY_HIST
 
 
-kernel configuration options enabled. The USEC parameter to the -b option defines a maximum latency value, which is compared against the actual latencies of the test. Once the measured latency is higher than the given maximum, the kernel tracer and cyclictest is stopped. The trace can be read from /proc/latency_trace. Please be aware that the tracer adds significant overhead to the kernel, so the latencies will be much higher than on a kernel with latency tracing disabled.
+kernel configuration options enabled. The USEC parameter to the \-b option defines a maximum latency value, which is compared against the actual latencies of the test. Once the measured latency is higher than the given maximum, the kernel tracer and cyclictest is stopped. The trace can be read from /proc/latency_trace. Please be aware that the tracer adds significant overhead to the kernel, so the latencies will be much higher than on a kernel with latency tracing disabled.
 .TP
 .B \-c, \-\-clock=CLOCK
 Selects the clock, which is used:
@@ -73,16 +73,16 @@ Selects the clock, which is used:
     * 1 selects CLOCK_REALTIME, which is the time of day time.
 
 CLOCK_REALTIME can be set by settimeofday, while CLOCK_MONOTONIC can not be modified by the user.
-This option has no influence when the -s option is given.
+This option has no influence when the \-s option is given.
 .TP
 .B \-d, \-\-distance=DIST
-Set the distance of thread intervals in microseconds (default is 500us). When cylictest is called with the -t option and more than one thread is created, then this distance value is added to the interval of the threads: Interval(thread N) = Interval(thread N-1) + DIST
+Set the distance of thread intervals in microseconds (default is 500us). When cylictest is called with the \-t option and more than one thread is created, then this distance value is added to the interval of the threads: Interval(thread N) = Interval(thread N-1) + DIST
 .TP
 .B \-f, \-\-ftrace
-Enable function tracing using ftrace as tracer. This option is available only with -b.
+Enable function tracing using ftrace as tracer. This option is available only with \-b.
 .TP
 .B \-i, \-\-interval=INTV
-Set the base interval of the thread(s) in microseconds (default is 1000us). This sets the interval of the first thread. See also -d.
+Set the base interval of the thread(s) in microseconds (default is 1000us). This sets the interval of the first thread. See also \-d.
 .TP
 .B \-l, \-\-loops=LOOPS
 Set the number of loops. The default is 0 (endless). This option is useful for automated tests with a given number of test cycles. Cyclictest is stopped once the number of timer intervals has been reached.
@@ -104,11 +104,11 @@ Run the tests quiet and print only a summary on exit. Useful for automated tests
 Use relative timers instead of absolute. The default behaviour of the tests is to use absolute timers. This option is there for completeness and should not be used for reproducible tests.
 .TP
 .B \-s, \-\-system
-Use sys_nanosleep and sys_setitimer instead of posix timers. Note, that -s can only be used with one thread because itimers are per process and not per thread. -s in combination with -n uses the nanosleep syscall and is not restricted to one thread.
+Use sys_nanosleep and sys_setitimer instead of posix timers. Note, that \-s can only be used with one thread because itimers are per process and not per thread. \-s in combination with \-n uses the nanosleep syscall and is not restricted to one thread.
 .TP
 .B \-t, \-\-threads[=NUM]
 Set the number of test threads (default is 1). Create NUM test threads. If NUM is not specifed, NUM is set to
-the number of available CPUs. See -d, -i and -p for further information.
+the number of available CPUs. See \-d, \-i and \-p for further information.
 .TP
 .B \-m, \-\-mlockall
 Lock current an future memory allocations to prevent being paged out
@@ -118,7 +118,7 @@ Output values on stdout for statistics. This option is used to gather statistica
 
 n:c:v
 
-where n=task number c=count v=latency value in us. Use this option in combination with -l
+where n=task number c=count v=latency value in us. Use this option in combination with \-l
 .\" .SH SEE ALSO
 .\" .BR bar (1),
 .\" .BR baz (1).
diff --git a/src/pi_tests/pi_stress.8 b/src/pi_tests/pi_stress.8
index 3723671..16f0074 100644
--- a/src/pi_tests/pi_stress.8
+++ b/src/pi_tests/pi_stress.8
@@ -13,23 +13,23 @@ pi_stress \- a stress test for POSIX Priority Inheritance mutexes
 .\" Usage:  pi_stress [-i n ] [-g n] [-v] [-d] [-s] [-r] [-p] [-u] [-m]
 .SH SYNOPSIS
 .B pi_stress
-.RB [ \-i|--inversions
+.RB [ \-i|\-\-inversions
 .IR inversions ]
-.RB [ \-t|--duration
+.RB [ \-t|\-\-duration
 .IR seconds ]
-.RB [ \-g|--groups
+.RB [ \-g|\-\-groups
 .IR groups
-.RB [ \-d|--debug ]
-.RB [ \-v|--verbose ]
-.RB [ \-s|--signal ]
-.RB [ \-r|--rr ]
-.RB [ \-p|--prompt ]
-.RB [ \-m|--mlockall ]
-.RB [ \-u|--uniprocessor ]
+.RB [ \-d|\-\-debug ]
+.RB [ \-v|\-\-verbose ]
+.RB [ \-s|\-\-signal ]
+.RB [ \-r|\-\-rr ]
+.RB [ \-p|\-\-prompt ]
+.RB [ \-m|\-\-mlockall ]
+.RB [ \-u|\-\-uniprocessor ]
 .br
 .\" help
 .B pi_stress
-.RB \-h|--help
+.RB \-h|\-\-help
 .SH DESCRIPTION
 .B pi_stress
 is a program used to stress the
@@ -44,37 +44,37 @@ condition that will deadlock if
 doesn't work.
 
 .SH OPTIONS
-.IP "-i n|--inversions=n"
+.IP "\-i n|\-\-inversions=n"
 Run for
 .I n
 number of inversion conditions. This is the total number of inversions
 for all inversion groups. Default is -1 for infinite.
-.IP "-t n|--duration=n"
+.IP "\-t n|\-\-duration=n"
 Run the test for 
 .I n
 seconds and then terminate.
-.IP "-g n|--groups=n"
+.IP "\-g n|\-\-groups=n"
 The number of inversion groups to run. Defaults to 10.
-.IP \-d|--debug
+.IP \-d|\-\-debug
 Run in debug mode; lots of extra prints
-.IP -v|--verbose
+.IP \-v|\-\-verbose
 Run with verbose messages
-.IP \-s|--signal
+.IP \-s|\-\-signal
 Terminate on receipt of SIGTERM (Ctrl-C). Default is to terminate on
 any keypress.
-.IP \-r|--rr
+.IP \-r|\-\-rr
 Run inversion group threads as SCHED_RR (round-robin). The default is
 to run the inversion threads as SCHED_FIFO.
-.IP \-p|--prompt
+.IP \-p|\-\-prompt
 Prompt before actually starting the stress test
-.IP \-u|--uniprocessor
+.IP \-u|\-\-uniprocessor
 Run all threads on one processor. The default is to run all inversion
 group threads on one processor and the admin threads (reporting
 thread, keyboard reader, etc.) on a different processor.
-.IP \m|--mlockall
+.IP \m|\-\-mlockall
 Call mlockall to lock currnet and future memory allocations and
 prevent being paged out
-.IP -h|--help
+.IP \-h|\-\-help
 Display a short help message and options.
 .SH CAVEATS
 The pi_stress test threads run as SCHED_FIFO or SCHED_RR threads,
-- 
1.5.4.3

