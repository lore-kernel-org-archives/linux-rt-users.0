From: Tommi Rantala <tommi.t.rantala@nokia.com>
Subject: [PATCH 06/34] cyclictest: fix typo in warn() message
Date: Mon, 22 May 2017 11:25:12 +0300
Message-ID: <20170522082540.15467-7-tommi.t.rantala@nokia.com>
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
        id S1752743AbdEVI0I (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 May 2017 04:26:08 -0400
In-Reply-To: <20170522082540.15467-1-tommi.t.rantala@nokia.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
---
 src/cyclictest/cyclictest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 4f94b06..8f7b28c 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1149,7 +1149,7 @@ static void *timerthread(void *param)
 		ret = clock_gettime(par->clock, &now);
 		if (ret != 0) {
 			if (ret != EINTR)
-				warn("clock_getttime() failed. errno: %d\n",
+				warn("clock_gettime() failed. errno: %d\n",
 				     errno);
 			goto out;
 		}
-- 
2.9.3

