From: GeunSik Lim <leemgs1@gmail.com>
Subject: [PATCH 3/3] cyclictest: Arrange alphabetically for readability of
	"cyclictest --help" output.
Date: Sat, 27 Jun 2009 00:38:32 +0900
Message-ID: <1246030712.2153.34.camel@centos51>
Reply-To: leemgs1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: tglx <tglx@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.237]:11951 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751312AbZFZPii (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 26 Jun 2009 11:38:38 -0400
Received: by rv-out-0506.google.com with SMTP id f6so649951rvb.1
        for <linux-rt-users@vger.kernel.org>; Fri, 26 Jun 2009 08:38:40 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



>From 8d5c2ce5eeec92cca91a448a9699cab9ebc58704 Mon Sep 17 00:00:00 2001
From: GeunSik,Lim <leemgs1@gmail.com>
Date: Sat, 27 Jun 2009 00:05:18 +0900
Subject: [PATCH 3/3] cyclictest: Arrange alphabetically for readability of "cyclictest --help" output.

When we use "#> cyclictest --help" command, we are confusing because of
random order of many options. Arrange alphabetically.

      Signed-by-off: GeunSik Lim <geunsik.lim@samsung.com>

---
 src/cyclictest/cyclictest.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 3505de5..f9d8d1f 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -746,8 +746,13 @@ static void display_help(void)
 	       "                           1 = CLOCK_REALTIME\n"
 	       "-C       --context         context switch tracing (used with -b)\n"
 	       "-d DIST  --distance=DIST   distance of thread intervals in us default=500\n"
+	       "-D       --duration=t      specify a length for the test run\n"
+	       "                           default is in seconds, but 'm', 'h', or 'd' maybe added\n"
+	       "                           to modify value to minutes, hours or days\n"
 	       "-E       --event           event tracing (used with -b)\n"
 	       "-f       --ftrace          function trace (when -b is active)\n"
+	       "-h       --histogram=US    dump a latency histogram to stdout after the run\n"
+	       "                           US is the max time to be be tracked in microseconds\n"
 	       "-i INTV  --interval=INTV   base interval of thread in us default=1000\n"
 	       "-I       --irqsoff         Irqsoff tracing (used with -b)\n"
 	       "-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
@@ -755,25 +760,20 @@ static void display_help(void)
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
-	       "                           US is the max time to be be tracked in microseconds\n"
                "-w       --wakeup          task wakeup tracing (used with -b)\n"
                "-W       --wakeuprt        rt task wakeup tracing (used with -b)\n"
 	       "-y POLI  --policy=POLI     policy of realtime thread (0:OTHER, 1:FIFO, 2:RR)\n"
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



