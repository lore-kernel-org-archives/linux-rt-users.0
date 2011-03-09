From: Geunsik Lim <leemgs1@gmail.com>
Subject: [PATCH RESEND v2] cyclictest: Fixed incorrect wakeup reset interface
Date: Thu, 10 Mar 2011 00:08:59 +0900
Message-ID: <1299683339-14381-1-git-send-email-leemgs1@gmail.com>
Cc: jkacur@redhat.com, linux-rt-users@vger.kernel.org,
	tglx@linutronix.de
To: williams@redhat.com, Carsten Emde <C.Emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:61618 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751984Ab1CIPJS (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 9 Mar 2011 10:09:18 -0500
Received: by yia27 with SMTP id 27so244272yia.19
        for <linux-rt-users@vger.kernel.org>; Wed, 09 Mar 2011 07:09:18 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

When we try to run ftrace with cyclictest command of rt-test,
We view the error according to base kernel version.
We need to modify this hard coded interface.

Signed-off-by: Geunsik Lim <geunsik.lim@samsung.com>
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
-- 
1.7.1

