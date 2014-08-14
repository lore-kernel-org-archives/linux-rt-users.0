From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 5/6] cyclictest: Fix help for long options only
Date: Thu, 14 Aug 2014 18:18:09 +0200
Message-ID: <1408033090-24866-6-git-send-email-jkacur@redhat.com>
References: <1408033090-24866-1-git-send-email-jkacur@redhat.com>
Cc: John Kacur <jkacur@redhat.com>
To: rt-users <linux-rt-users@vger.kernel.org>,
	Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:33593 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752474AbaHNQS0 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 14 Aug 2014 12:18:26 -0400
Received: by mail-wg0-f48.google.com with SMTP id x13so1297121wgg.19
        for <linux-rt-users@vger.kernel.org>; Thu, 14 Aug 2014 09:18:25 -0700 (PDT)
In-Reply-To: <1408033090-24866-1-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

At some point in the history of cyclictest, a number of short options
were removed and changed to long only options. However the display_help
was not updated to reflect this and indicates short options that
no longer exist. Fix this. I also found a long option that wasn't listed
at all and added that.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/cyclictest.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index ad7890ffaa95..b45041e01f3a 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1009,7 +1009,7 @@ static void display_help(int error)
 	       "-D       --duration=t      specify a length for the test run\n"
 	       "                           default is in seconds, but 'm', 'h', or 'd' maybe added\n"
 	       "                           to modify value to minutes, hours or days\n"
-	       "-e       --latency=PM_QOS  write PM_QOS to /dev/cpu_dma_latency\n"
+	       "	 --latency=PM_QOS  write PM_QOS to /dev/cpu_dma_latency\n"
 	       "-E       --event           event tracing (used with -b)\n"
 	       "-f       --ftrace          function trace (when -b is active)\n"
 	       "-F       --fifo=<path>     create a named pipe at path and write stats to it\n"
@@ -1023,13 +1023,14 @@ static void display_help(int error)
 	       "-m       --mlockall        lock current and future memory allocations\n"
 	       "-M       --refresh_on_max  delay updating the screen until a new max latency is hit\n"
 	       "-n       --nanosleep       use clock_nanosleep\n"
+	       "	 --notrace	   suppress tracing\n"
 	       "-N       --nsecs           print results in ns instead of us (default us)\n"
 	       "-o RED   --oscope=RED      oscilloscope mode, reduce verbose output by RED\n"
 	       "-O TOPT  --traceopt=TOPT   trace option\n"
 	       "-p PRIO  --prio=PRIO       priority of highest prio thread\n"
 	       "-P       --preemptoff      Preempt off tracing (used with -b)\n"
 	       "-q       --quiet           print only a summary on exit\n"
-	       "-Q       --priospread       spread priority levels starting at specified value\n"
+	       "	 --priospread       spread priority levels starting at specified value\n"
 	       "-r       --relative        use relative timer instead of absolute\n"
 	       "-R       --resolution      check clock resolution, calling clock_gettime() many\n"
 	       "                           times.  list of clock_gettime() values will be\n"
@@ -1052,8 +1053,8 @@ static void display_help(int error)
 	       "                           format: n:c:v n=tasknum c=count v=value in us\n"
 	       "-w       --wakeup          task wakeup tracing (used with -b)\n"
 	       "-W       --wakeuprt        rt task wakeup tracing (used with -b)\n"
-	       "-X       --dbg_cyclictest  print info useful for debugging cyclictest\n"
-	       "-y POLI  --policy=POLI     policy of realtime thread, POLI may be fifo(default) or rr\n"
+	       "	 --dbg_cyclictest  print info useful for debugging cyclictest\n"
+	       "	 --policy=POLI     policy of realtime thread, POLI may be fifo(default) or rr\n"
 	       "                           format: --policy=fifo(default) or --policy=rr\n",
 	       tracers
 		);
-- 
1.8.1.4

