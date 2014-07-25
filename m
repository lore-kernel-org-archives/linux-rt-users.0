From: Michael Jones <dev@michaeljones.de>
Subject: [PATCH] cyclictest: remove non-existant short options from --help output
Date: Fri, 25 Jul 2014 21:27:24 +0200
Message-ID: <1406316444-1941-1-git-send-email-dev@michaeljones.de>
Cc: linux-rt-users@vger.kernel.org
To: Clark Williams <clark.williams@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gproxy8-pub.mail.unifiedlayer.com ([67.222.33.93]:48142 "HELO
	gproxy8-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753170AbaGYTeS (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 25 Jul 2014 15:34:18 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Update the output from 'cyclictest --help' and the man page to reflect
options which only have a long version.

Signed-off-by: Michael Jones <dev@michaeljones.de>
---
 src/cyclictest/cyclictest.8 |  2 +-
 src/cyclictest/cyclictest.c | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
index 4e169aa..dfe2de7 100644
--- a/src/cyclictest/cyclictest.8
+++ b/src/cyclictest/cyclictest.8
@@ -168,7 +168,7 @@ task wakeup tracing (used with \-b)
 .B \\-W, \-\-wakeuprt
 rt-task wakeup tracing (used with \-b)
 .TP
-.B \\-y, \-\-policy=NAME
+.B \-\-policy=NAME
 set the scheduler policy of the measurement threads
 where NAME is one of: other, normal, batch, idle, fifo, rr
 .TP
diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 4547831..51ac56b 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -999,7 +999,7 @@ static void display_help(int error)
 	       "-D       --duration=t      specify a length for the test run\n"
 	       "                           default is in seconds, but 'm', 'h', or 'd' maybe added\n"
 	       "                           to modify value to minutes, hours or days\n"
-	       "-e       --latency=PM_QOS  write PM_QOS to /dev/cpu_dma_latency\n"
+	       "         --latency=PM_QOS  write PM_QOS to /dev/cpu_dma_latency\n"
 	       "-E       --event           event tracing (used with -b)\n"
 	       "-f       --ftrace          function trace (when -b is active)\n"
 	       "-F       --fifo=<path>     create a named pipe at path and write stats to it\n"
@@ -1019,11 +1019,11 @@ static void display_help(int error)
 	       "-p PRIO  --prio=PRIO       priority of highest prio thread\n"
 	       "-P       --preemptoff      Preempt off tracing (used with -b)\n"
 	       "-q       --quiet           print only a summary on exit\n"
-	       "-Q       --priospread       spread priority levels starting at specified value\n"
+	       "         --priospread      spread priority levels starting at specified value\n"
 	       "-r       --relative        use relative timer instead of absolute\n"
 	       "-R       --resolution      check clock resolution, calling clock_gettime() many\n"
 	       "                           times.  list of clock_gettime() values will be\n"
-	       "                           reported with -X\n"
+	       "                           reported with --dbg_cyclictest\n"
 	       "-s       --system          use sys_nanosleep and sys_setitimer\n"
 	       "-S       --smp             Standard SMP testing: options -a -t -n and\n"
 	       "                           same priority of all threads\n"
@@ -1042,8 +1042,8 @@ static void display_help(int error)
 	       "                           format: n:c:v n=tasknum c=count v=value in us\n"
 	       "-w       --wakeup          task wakeup tracing (used with -b)\n"
 	       "-W       --wakeuprt        rt task wakeup tracing (used with -b)\n"
-	       "-X       --dbg_cyclictest  print info useful for debugging cyclictest\n"
-	       "-y POLI  --policy=POLI     policy of realtime thread, POLI may be fifo(default) or rr\n"
+	       "         --dbg_cyclictest  print info useful for debugging cyclictest\n"
+	       "         --policy=POLI     policy of realtime thread, POLI may be fifo(default) or rr\n"
 	       "                           format: --policy=fifo(default) or --policy=rr\n",
 	       tracers
 		);
-- 
1.9.3

