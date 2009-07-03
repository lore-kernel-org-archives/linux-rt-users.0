From: GeunSik Lim <leemgs1@gmail.com>
Subject: [PATCH]cyclictest: Arrange alphabetically for readability of
	"cyclictest --help".
Date: Fri, 03 Jul 2009 13:04:15 +0900
Message-ID: <1246593855.2153.55.camel@centos51>
Reply-To: leemgs1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	tglx <tglx@linutronix.de>
To: williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.171]:40513 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742AbZGCEEV (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 3 Jul 2009 00:04:21 -0400
Received: by wf-out-1314.google.com with SMTP id 26so838481wfd.4
        for <linux-rt-users@vger.kernel.org>; Thu, 02 Jul 2009 21:04:23 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>




Hi,

This is trivial patch. 
But, We need readbility about output of the "#>cyclictest --help" command. 


Thks, 
GeunSik Lim. 


== CUT HERE ==

Subject: [PATCH]cyclictest: Arrange alphabetically for readability of "cyclictest --help".

When we use "#> cyclictest --help" command, we are confusing because of
random order of many options. Arrange alphabetically.

After Patch)
[root@fedora11 rt-tests]# ./cyclictest  --help
cyclictest V 0.46
Usage:
cyclictest <options>

-a [NUM] --affinity        run thread #N on processor #N, if possible
                           with NUM pin all threads to the processor NUM
-b USEC  --breaktrace=USEC send break trace command when latency > USEC
-B       --preemptirqs     both preempt and irqsoff tracing (used with -b)
-c CLOCK --clock=CLOCK     select clock
                           0 = CLOCK_MONOTONIC (default)
                           1 = CLOCK_REALTIME
-C       --context         context switch tracing (used with -b)
-d DIST  --distance=DIST   distance of thread intervals in us default=500
-D       --duration=t      specify a length for the test run
                           default is in seconds, but 'm', 'h', or 'd' maybe added
                           to modify value to minutes, hours or days
-E       --event           event tracing (used with -b)
-f       --ftrace          function trace (when -b is active)
-h       --histogram=US    dump a latency histogram to stdout after the run
                           (with same priority about many threads)
                           US is the max time to be be tracked in microseconds
-i INTV  --interval=INTV   base interval of thread in us default=1000
-I       --irqsoff         Irqsoff tracing (used with -b)
-l LOOPS --loops=LOOPS     number of loops: default=0(endless)
-m       --mlockall        lock current and future memory allocations
-n       --nanosleep       use clock_nanosleep
-N       --nsecs           print results in ns instead of ms (default ms)
-o RED   --oscope=RED      oscilloscope mode, reduce verbose output by RED
-O TOPT  --traceopt=TOPT   trace option
-p PRIO  --prio=PRIO       priority of highest prio thread
-P       --preemptoff      Preempt off tracing (used with -b)
-q       --quiet           print only a summary on exit
-r       --relative        use relative timer instead of absolute
-s       --system          use sys_nanosleep and sys_setitimer
-t       --threads         one thread per available processor
-t [NUM] --threads=NUM     number of threads:
                           without NUM, threads = max_cpus
                           without -t default = 1
-T TRACE --tracer=TRACER   set tracing function
    configured tracers: unavailable (debugfs not mounted)
-v       --verbose         output values on stdout for statistics
                           format: n:c:v n=tasknum c=count v=value in us
-w       --wakeup          task wakeup tracing (used with -b)
-W       --wakeuprt        rt task wakeup tracing (used with -b)
-y POLI  --policy=POLI     policy of realtime thread (1:FIFO, 2:RR)
                           format: --policy=1(default) or --policy=2

      Signed-by-off: GeunSik Lim <geunsik.lim@samsung.com>
---
 src/cyclictest/cyclictest.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 4a6f634..d16782b 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -763,8 +763,14 @@ static void display_help(void)
 	       "                           1 = CLOCK_REALTIME\n"
 	       "-C       --context         context switch tracing (used with -b)\n"
 	       "-d DIST  --distance=DIST   distance of thread intervals in us default=500\n"
+	       "-D       --duration=t      specify a length for the test run\n"
+	       "                           default is in seconds, but 'm', 'h', or 'd' maybe added\n"
+	       "                           to modify value to minutes, hours or days\n"
 	       "-E       --event           event tracing (used with -b)\n"
 	       "-f       --ftrace          function trace (when -b is active)\n"
+	       "-h       --histogram=US    dump a latency histogram to stdout after the run\n"
+               "                           (with same priority about many threads)\n"
+	       "                           US is the max time to be be tracked in microseconds\n"
 	       "-i INTV  --interval=INTV   base interval of thread in us default=1000\n"
 	       "-I       --irqsoff         Irqsoff tracing (used with -b)\n"
 	       "-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
@@ -772,26 +778,20 @@ static void display_help(void)
 	       "-n       --nanosleep       use clock_nanosleep\n"
 	       "-N       --nsecs           print results in ns instead of ms (default ms)\n"
 	       "-o RED   --oscope=RED      oscilloscope mode, reduce verbose output by RED\n"
-	       "-O TOPT  --traceopt=TOPT    trace option\n"
+	       "-O TOPT  --traceopt=TOPT   trace option\n"
 	       "-p PRIO  --prio=PRIO       priority of highest prio thread\n"
 	       "-P       --preemptoff      Preempt off tracing (used with -b)\n"
 	       "-q       --quiet           print only a summary on exit\n"
 	       "-r       --relative        use relative timer instead of absolute\n"
 	       "-s       --system          use sys_nanosleep and sys_setitimer\n"
-	       "-T TRACE --tracer=TRACER   set tracing function\n"
-	       "    configured tracers: %s\n"
 	       "-t       --threads         one thread per available processor\n"
 	       "-t [NUM] --threads=NUM     number of threads:\n"
 	       "                           without NUM, threads = max_cpus\n"
 	       "                           without -t default = 1\n"
+	       "-T TRACE --tracer=TRACER   set tracing function\n"
+	       "    configured tracers: %s\n"
 	       "-v       --verbose         output values on stdout for statistics\n"
 	       "                           format: n:c:v n=tasknum c=count v=value in us\n"
-	       "-D       --duration=t      specify a length for the test run\n"
-	       "                           default is in seconds, but 'm', 'h', or 'd' maybe added\n"
-	       "                           to modify value to minutes, hours or days\n"
-	       "-h       --histogram=US    dump a latency histogram to stdout after the run\n"
-               "                           (with same priority about many threads)\n"
-	       "                           US is the max time to be be tracked in microseconds\n"
                "-w       --wakeup          task wakeup tracing (used with -b)\n"
                "-W       --wakeuprt        rt task wakeup tracing (used with -b)\n"
                "-y POLI  --policy=POLI     policy of realtime thread (1:FIFO, 2:RR)\n"
-- 
1.6.3.1

 


-----------------------------------------------
To unsubscribe from this list: send the line "unsubscribe linux-***" 
in the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

GeunSik Lim ( Samsung Electronics )
e-Mail  :1) geunsik.lim@samsung.com
         2) leemgs@gmail.com , leemgs1@gmail.com
HomePage: http://blog.naver.com/invain/
-----------------------------------------------

