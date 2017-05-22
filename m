From: Tommi Rantala <tommi.t.rantala@nokia.com>
Subject: [PATCH 07/34] cyclictest: update --smp help: -n was removed
Date: Mon, 22 May 2017 11:25:13 +0300
Message-ID: <20170522082540.15467-8-tommi.t.rantala@nokia.com>
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
        id S1752735AbdEVI0K (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 May 2017 04:26:10 -0400
In-Reply-To: <20170522082540.15467-1-tommi.t.rantala@nokia.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Update the --smp help, now that -n has been removed.

Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
---
 src/cyclictest/cyclictest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 8f7b28c..2630296 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1347,7 +1347,7 @@ static void display_help(int error)
 	       "         --secaligned [USEC] align thread wakeups to the next full second\n"
 	       "                           and apply the optional offset\n"
 	       "-s       --system          use sys_nanosleep and sys_setitimer\n"
-	       "-S       --smp             Standard SMP testing: options -a -t -n and\n"
+	       "-S       --smp             Standard SMP testing: options -a -t and\n"
 	       "                           same priority of all threads\n"
 	       "	--spike=<trigger>  record all spikes > trigger\n"
 	       "	--spike-nodes=[num of nodes]\n"
-- 
2.9.3

