From: GeunSik Lim <leemgs1@gmail.com>
Subject: [PATCH] cyclictest : Appended man & usage about the same priority
	of many threads with -h
Date: Fri, 03 Jul 2009 10:08:34 +0900
Message-ID: <1246583314.2153.43.camel@centos51>
Reply-To: leemgs1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	tglx <tglx@linutronix.de>, sdietrich@suse.de
To: williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.226]:17550 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756212AbZGCBIk (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 2 Jul 2009 21:08:40 -0400
Received: by rv-out-0506.google.com with SMTP id f6so690056rvb.1
        for <linux-rt-users@vger.kernel.org>; Thu, 02 Jul 2009 18:08:42 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


 
Dear Clark Williams,

Please, merge this patch. 
I made this patch with ver 0.46 . 
Thanks, 


== CUT HERE ==

Subject: [PATCH] cyclictest:Appended man & usage about the same priority of many threads with -h

If we run a many threads with -t option, "priority--" rt priority will assign
per thread in sequence. But, If we use -h option, all threads is same priority.

Append man page and cyclictest usage about the same priority of many threads
with -h option.

ex) cyclictest -t 5 -p 50        [enter] <-- without -h
ex) cyclictest -t 5 -p 50 -h 100 [enter] <-- with    -h

        Signed-off-by: GeunSik Lim <geunsik.lim@samsung.com>
        Acked-by     : Sven-Thorsten Dietrich <sdietrich@suse.de>
---
 src/cyclictest/cyclictest.8 |    2 +-
 src/cyclictest/cyclictest.c |    1 +
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
index 48b2c5e..6059cee 100644
--- a/src/cyclictest/cyclictest.8
+++ b/src/cyclictest/cyclictest.8
@@ -91,7 +91,7 @@ event tracing (used with \-b)
 Enable function tracing using ftrace as tracer. This option is available only with \-b.
 .TP
 .B \-h, \-\-histogram=MAXLATENCYINUS
-Dump latency histogram to stdout
+Dump latency histogram to stdout. US means the max time to be be tracked in microseconds. When you use -h option to get histogram data, Cyclictest runs many threads with same priority without priority--.
 .TP
 .B \-i, \-\-interval=INTV
 Set the base interval of the thread(s) in microseconds (default is 1000us). This sets the interval of the first thread. See also \-d.
diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 7bfc2b1..dfc209e 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -790,6 +790,7 @@ static void display_help(void)
 	       "                           default is in seconds, but 'm', 'h', or 'd' maybe added\n"
 	       "                           to modify value to minutes, hours or days\n"
 	       "-h       --histogram=US    dump a latency histogram to stdout after the run\n"
+               "                           (with same priority about many threads)\n"
 	       "                           US is the max time to be be tracked in microseconds\n"
                "-w       --wakeup          task wakeup tracing (used with -b)\n"
                "-W       --wakeuprt        rt task wakeup tracing (used with -b)\n",
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

