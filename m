From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: [PATCH 1/1] cyclictest: Fix long priority help text option
Date: Wed, 22 Jul 2015 14:44:59 +0200
Message-ID: <1437569099-2965-1-git-send-email-alexander.stein@systec-electronic.com>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>,
	linux-rt-users@vger.kernel.org
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:36262 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932702AbbGVMxN (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 22 Jul 2015 08:53:13 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

The help text shows prio as the long option name for the process priority.
But it is actually priority.

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
 src/cyclictest/cyclictest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 34053c5..c178a74 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1062,7 +1062,7 @@ static void display_help(int error)
 	       "-N       --nsecs           print results in ns instead of us (default us)\n"
 	       "-o RED   --oscope=RED      oscilloscope mode, reduce verbose output by RED\n"
 	       "-O TOPT  --traceopt=TOPT   trace option\n"
-	       "-p PRIO  --prio=PRIO       priority of highest prio thread\n"
+	       "-p PRIO  --priority=PRIO   priority of highest prio thread\n"
 	       "-P       --preemptoff      Preempt off tracing (used with -b)\n"
 	       "-q       --quiet           print only a summary on exit\n"
 	       "	 --priospread       spread priority levels starting at specified value\n"
-- 
2.3.6

