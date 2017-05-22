From: Tommi Rantala <tommi.t.rantala@nokia.com>
Subject: [PATCH 04/34] cyclictest: remove extra argument in warn() and fatal() calls
Date: Mon, 22 May 2017 11:25:10 +0300
Message-ID: <20170522082540.15467-5-tommi.t.rantala@nokia.com>
References: <20170522082540.15467-1-tommi.t.rantala@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-rt-users@vger.kernel.org>,
        Tommi Rantala <tommi.t.rantala@nokia.com>
To: Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-eopbgr50106.outbound.protection.outlook.com ([40.107.5.106]:12016
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752771AbdEVI0G (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 May 2017 04:26:06 -0400
In-Reply-To: <20170522082540.15467-1-tommi.t.rantala@nokia.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
---
 src/cyclictest/cyclictest.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 7cd9f29..75f1fcd 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -570,14 +570,12 @@ static void debugfs_prepare(void)
 		fatal("could not mount debugfs");
 
 	if (kernelversion >= KV_26_33) {
-		char testname[MAX_PATH];
-
 		fileprefix = get_debugfileprefix();
 		if (!trace_file_exists("tracing_enabled") &&
 		    !trace_file_exists("tracing_on"))
 			warn("tracing_enabled or tracing_on not found\n"
 			    "debug fs not mounted, "
-			    "TRACERs not configured?\n", testname);
+			    "TRACERs not configured?\n");
 	} else
 		fileprefix = procfileprefix;
 }
@@ -1030,7 +1028,7 @@ static void *timerthread(void *param)
 		/* get current smi count to use as base value */
 		if (get_smi_counter(par->msr_fd, &smi_old))
 			fatal("Could not read SMI counter, errno: %d\n",
-				par->cpu, errno);
+				errno);
 	}
 
 	/* Get current time */
@@ -1159,7 +1157,7 @@ static void *timerthread(void *param)
 		if (smi) {
 			if (get_smi_counter(par->msr_fd, &smi_now)) {
 				warn("Could not read SMI counter, errno: %d\n",
-					par->cpu, errno);
+					errno);
 				goto out;
 			}
 			diff_smi = smi_now - smi_old;
-- 
2.9.3

