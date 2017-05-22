From: Tommi Rantala <tommi.t.rantala@nokia.com>
Subject: [PATCH 12/34] cyclictest: fix off-by-one in clocksel check
Date: Mon, 22 May 2017 11:25:18 +0300
Message-ID: <20170522082540.15467-13-tommi.t.rantala@nokia.com>
References: <20170522082540.15467-1-tommi.t.rantala@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-rt-users@vger.kernel.org>,
        Tommi Rantala <tommi.t.rantala@nokia.com>
To: Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-eopbgr50097.outbound.protection.outlook.com ([40.107.5.97]:43936
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752848AbdEVI0T (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 May 2017 04:26:19 -0400
In-Reply-To: <20170522082540.15467-1-tommi.t.rantala@nokia.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Fix off-by-one when checking that clocksel is valid index to the array.

Also fix a compiler warning:

src/cyclictest/cyclictest.c: In function 'process_options':
src/cyclictest/cyclictest.c:1828:31: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]
  if (clocksel < 0 || clocksel > ARRAY_SIZE(clocksources))

Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
---
 src/cyclictest/cyclictest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index f2747e4..d89cb0f 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1823,7 +1823,7 @@ static void process_options (int argc, char *argv[], int max_cpus)
 	if (tracelimit)
 		fileprefix = procfileprefix;
 
-	if (clocksel < 0 || clocksel > ARRAY_SIZE(clocksources))
+	if (clocksel < 0 || clocksel >= (int)ARRAY_SIZE(clocksources))
 		error = 1;
 
 	if (oscope_reduction < 1)
-- 
2.9.3

