From: Tommi Rantala <tommi.t.rantala@nokia.com>
Subject: [PATCH 16/34] cyclictest: normalize next before tsgreater() check
Date: Mon, 22 May 2017 11:25:22 +0300
Message-ID: <20170522082540.15467-17-tommi.t.rantala@nokia.com>
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
        id S1754116AbdEVI0X (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 May 2017 04:26:23 -0400
In-Reply-To: <20170522082540.15467-1-tommi.t.rantala@nokia.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

We should normalize the next timespec before checking if now > next, so
that the tsgreater() check really works as expected.

Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
---
 src/cyclictest/cyclictest.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index b4dec98..aae65ef 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1221,6 +1221,8 @@ static void *timerthread(void *param)
 
 		next.tv_sec += interval.tv_sec;
 		next.tv_nsec += interval.tv_nsec;
+		tsnorm(&next);
+
 		if (par->mode == MODE_CYCLIC) {
 			int overrun_count = timer_getoverrun(timer);
 			if (overrun_count < 0) {
-- 
2.9.3

