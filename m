From: GeunSik Lim <leemgs1@gmail.com>
Subject: [PATCH] cyclictest: Remove duplicated description of cyclictest
	usage like -h.
Date: Tue, 21 Apr 2009 16:28:55 +0900
Message-ID: <1240298935.30137.33.camel@centos51>
Reply-To: leemgs1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: tglx@linutronix.de, linux-rt-users@vger.kernel.org
To: williams@redhat.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:25763 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751362AbZDUH3B (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 21 Apr 2009 03:29:01 -0400
Received: by wa-out-1112.google.com with SMTP id j5so1268801wah.21
        for <linux-rt-users@vger.kernel.org>; Tue, 21 Apr 2009 00:29:00 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Author: Lim,GeunSik <leemgs1@gmail.com>
Date:   Tue Apr 21 16:03:56 2009 +0900

    [PATCH] cyclictest: Remove duplicated description of cyclictest usage like -h.
    
    We often utilize a various options with "#>cyclictest --help" command in the terminal environment.
    When We run "#> cyclictest --help" command, We can show duplicated description about "-h" option
    for latency histogram.
    Unfortunatley, Some of the users is confusing because of two options about latency histogram.
    
    [root@fedora9 invain]# ./cyclictest --help
    cyclictest V 0.36
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
    -E       --event           event tracing (used with -b)
    -f       --ftrace          function trace (when -b is active)
    -h H_MAX                   latency histogram size in us default 0 (off)
    -i INTV  --interval=INTV   base interval of thread in us default=1000
    
         ................. [Middle Omission] ...................
    
    -v       --verbose         output values on stdout for statistics
                               format: n:c:v n=tasknum c=count v=value in us
    -D       --duration=t      specify a length for the test run
                               default is in seconds, but 'm', 'h', or 'd' maybe added
                               to modify value to minutes, hours or days
    -h       --histogram=US    dump a latency histogram to stdout after the run
                               US is the max time to be be tracked in microseconds
    
    For example,
    
    -h H_MAX                   latency histogram size in us default 0 (off)
    
    -h       --histogram=US    dump a latency histogram to stdout after the run
                               US is the max time to be be tracked in microseconds

    As you see, We don't need "-h H_MAX  . . . . . ." description.    
    So, I think that We have to remove old option about description of histogram function.
    
    Signed-off-by: GeunSik Lim <leemgs1@gmail.com>
---
 src/cyclictest/cyclictest.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 1660893..884f2c3 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -688,7 +688,6 @@ static void display_help(void)
 	       "-d DIST  --distance=DIST   distance of thread intervals in us default=500\n"
 	       "-E       --event           event tracing (used with -b)\n"
 	       "-f       --ftrace          function trace (when -b is active)\n"
-	       "-h H_MAX                   latency histogram size in us default 0 (off)\n"
 	       "-i INTV  --interval=INTV   base interval of thread in us default=1000\n"
 	       "-I       --irqsoff         Irqsoff tracing (used with -b)\n"
 	       "-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"


-----------------------------------------------
To unsubscribe from this list: send the line "unsubscribe linux-***" 
in the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

GeunSik Lim (ELS - OS Group - S/W Lab - SAIT - SAMSUNG)
e-Mail  :1) geunsik.lim@samsung.com
         2) leemgs@gmail.com , leemgs1@gmail.com
HomePage: http://intomail.dnip.net/invain/me/
-----------------------------------------------

