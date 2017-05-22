From: Tommi Rantala <tommi.t.rantala@nokia.com>
Subject: [PATCH 14/34] cyclictest: fix MODE_CYCLIC measurement failure after timer overruns
Date: Mon, 22 May 2017 11:25:20 +0300
Message-ID: <20170522082540.15467-15-tommi.t.rantala@nokia.com>
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
        id S1752859AbdEVI0U (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 May 2017 04:26:20 -0400
In-Reply-To: <20170522082540.15467-1-tommi.t.rantala@nokia.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This patch aims to fix nonsensical results sometimes reported by
cyclictest when running in MODE_CYCLIC.

In MODE_CYCLIC if we hit the "now > next" case, we can end up adjusting
the "next" timespec twice: by the tsgreater-while-loop, and after that
on a later iteration of the loop by the result of timer_getoverrun().

After this double adjustment, the results will not be correct.

Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
---
 src/cyclictest/cyclictest.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 7720fce..517f061 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1230,15 +1230,15 @@ static void *timerthread(void *param)
 			}
 			next.tv_sec += overrun_count * interval.tv_sec;
 			next.tv_nsec += overrun_count * interval.tv_nsec;
+		} else {
+			while (tsgreater(&now, &next)) {
+				next.tv_sec += interval.tv_sec;
+				next.tv_nsec += interval.tv_nsec;
+				tsnorm(&next);
+			}
 		}
 		tsnorm(&next);
 
-		while (tsgreater(&now, &next)) {
-			next.tv_sec += interval.tv_sec;
-			next.tv_nsec += interval.tv_nsec;
-			tsnorm(&next);
-		}
-
 		if (par->max_cycles && par->max_cycles == stat->cycles)
 			break;
 	}
-- 
2.9.3

