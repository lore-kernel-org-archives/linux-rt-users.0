From: Tommi Rantala <tommi.t.rantala@nokia.com>
Subject: [PATCH 08/34] cyclictest: adjust whitespace in display_help() output
Date: Mon, 22 May 2017 11:25:14 +0300
Message-ID: <20170522082540.15467-9-tommi.t.rantala@nokia.com>
References: <20170522082540.15467-1-tommi.t.rantala@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-rt-users@vger.kernel.org>,
        Tommi Rantala <tommi.t.rantala@nokia.com>
To: Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-eopbgr50134.outbound.protection.outlook.com ([40.107.5.134]:2496
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752771AbdEVI0S (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 May 2017 04:26:18 -0400
In-Reply-To: <20170522082540.15467-1-tommi.t.rantala@nokia.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
---
 src/cyclictest/cyclictest.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 2630296..0a2cd9e 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1349,8 +1349,8 @@ static void display_help(int error)
 	       "-s       --system          use sys_nanosleep and sys_setitimer\n"
 	       "-S       --smp             Standard SMP testing: options -a -t and\n"
 	       "                           same priority of all threads\n"
-	       "	--spike=<trigger>  record all spikes > trigger\n"
-	       "	--spike-nodes=[num of nodes]\n"
+	       "	 --spike=<trigger> record all spikes > trigger\n"
+	       "	 --spike-nodes=[num of nodes]\n"
 	       "			   These are the maximum number of spikes we can record.\n"
 	       "			   The default is 1024 if not specified\n"
 #ifdef ARCH_HAS_SMI_COUNTER
-- 
2.9.3

