From: GeunSik Lim <leemgs1@gmail.com>
Subject: [PACH] cyclictest: Fixed incorrect wakeup reset interface
Date: Fri, 18 Feb 2011 15:15:13 +0900
Message-ID: <1298009713.10998.11.camel@centos55>
Reply-To: leemgs1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: tglx <tglx@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	jkacur@redhat.com
To: williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:48286 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751759Ab1BRGPY (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 18 Feb 2011 01:15:24 -0500
Received: by gxk9 with SMTP id 9so1341510gxk.19
        for <linux-rt-users@vger.kernel.org>; Thu, 17 Feb 2011 22:15:23 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Dear Clark Williams,

When we try to run ftrace with cyclictest command of rt-test testsuite,
We view the error according to base kernel version.  
We need to modify this hard coded interface.
  * Test environment: 
    . -rt patch version : 2.6.33.7.2-rt30
    . rt-tests repository version  : 0.72
http://git.kernel.org/?p=linux/kernel/git/clrkwllms/rt-tests.git

==CUT HERE==

>From f3d6427b98334e10df51f1a33cf36acd1b76b372 Mon Sep 17 00:00:00 2001
From: Geunsik Lim <geunsik.lim@samsung.com>
Date: Fri, 18 Feb 2011 23:39:56 +0900
Subject: [PATCH] [rt-tests:cyclictest] Fixed incorrect wakeup reset interface

When we try to run ftrace with cyclictest command of rt-test,
We view the error according to base kernel version.
We need to modify this hard coded interface.

Signed-off-by: Geunsik Lim <geunsik.lim@samsung.com>
---
 src/cyclictest/cyclictest.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 0847aed..abc0b4e 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -487,7 +487,7 @@ static void setup_tracer(void)
 				setkernvar(traceroptions, traceptr[i]);
 		}
 		setkernvar("tracing_max_latency", "0");
-		setkernvar("latency_hist/wakeup_latency/reset", "1");
+		setkernvar("latency_hist/wakeup/reset", "1");
 	} else {
 		setkernvar("trace_all_cpus", "1");
 		setkernvar("trace_freerunning", "1");
@@ -501,6 +501,7 @@ static void setup_tracer(void)
 		if (ftrace)
 			setkernvar("mcount_enabled", "1");
 		setkernvar("trace_enabled", "1");
+		setkernvar("latency_hist/wakeup_latency/reset", "1");
 	}
 
 	tracing(1);
-- 
1.7.1


-----------------------------------------------
To unsubscribe from this list: send the line "unsubscribe linux-***" 
in the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

Geunsik Lim ( Samsung Electronics )
e-Mail  :1) geunsik.lim@samsung.com
         2) leemgs@gmail.com , leemgs1@gmail.com
HomePage: http://blog.naver.com/invain/
-----------------------------------------------

