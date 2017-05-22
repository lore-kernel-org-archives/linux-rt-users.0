From: Tommi Rantala <tommi.t.rantala@nokia.com>
Subject: [PATCH 17/34] cyclictest: tsnorm() after adjusting next
Date: Mon, 22 May 2017 11:25:23 +0300
Message-ID: <20170522082540.15467-18-tommi.t.rantala@nokia.com>
References: <20170522082540.15467-1-tommi.t.rantala@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-rt-users@vger.kernel.org>,
        Tommi Rantala <tommi.t.rantala@nokia.com>
To: Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-eopbgr50126.outbound.protection.outlook.com ([40.107.5.126]:6656
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1757279AbdEVI0Z (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 May 2017 04:26:25 -0400
In-Reply-To: <20170522082540.15467-1-tommi.t.rantala@nokia.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Only do the normalization right after adjusting next.

Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
---
 src/cyclictest/cyclictest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index aae65ef..369ba04 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1232,6 +1232,7 @@ static void *timerthread(void *param)
 			}
 			next.tv_sec += overrun_count * interval.tv_sec;
 			next.tv_nsec += overrun_count * interval.tv_nsec;
+			tsnorm(&next);
 		} else {
 			while (tsgreater(&now, &next)) {
 				next.tv_sec += interval.tv_sec;
@@ -1239,7 +1240,6 @@ static void *timerthread(void *param)
 				tsnorm(&next);
 			}
 		}
-		tsnorm(&next);
 
 		if (par->max_cycles && par->max_cycles == stat->cycles)
 			break;
-- 
2.9.3

