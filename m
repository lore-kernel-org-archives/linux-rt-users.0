From: Geunsik Lim <leemgs1@gmail.com>
Subject: [PATCH RESEND v3] cyclictest: Fixed incorrect wakeup reset interface
Date: Thu, 10 Mar 2011 08:54:22 +0900
Message-ID: <1299714862-4078-1-git-send-email-leemgs1@gmail.com>
Cc: Carsten Emde <C.Emde@osadl.org>, linux-rt-users@vger.kernel.org,
	tglx@linutronix.de
To: williams@redhat.com, jkacur@redhat.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:42893 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752390Ab1CIXyg (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 9 Mar 2011 18:54:36 -0500
Received: by gwaa18 with SMTP id a18so210517gwa.19
        for <linux-rt-users@vger.kernel.org>; Wed, 09 Mar 2011 15:54:35 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

When we try to run ftrace with cyclictest command of rt-test,
We view the error according to different kernel version.
We need to modify this hard coded interface.

* Directory name of each kernel version
2.6.24.7-rt23     /sys/kernel/debug/tracing/latency_hist/wakeup_latency/reset
2.6.31-rc9-rt9.1  /sys/kernel/debug/tracing/latency_hist/wakeup/reset
2.6.33.7.2-rt30   /sys/kernel/debug/tracing/latency_hist/wakeup/reset

* parsing verification: ./linux-2.6/scripts/checkpatch.pl  --> OK

Signed-off-by: Geunsik Lim <geunsik.lim@samsung.com>
Reviewed-by: John Kacur <jkacur@redhat.com>
Reviewed-by: Carsten Emde <C.Emde@osadl.org>
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
1.7.3

