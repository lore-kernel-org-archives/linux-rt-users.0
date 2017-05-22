From: Tommi Rantala <tommi.t.rantala@nokia.com>
Subject: [PATCH 13/34] cyclictest: check timer_getoverrun() return value for failure
Date: Mon, 22 May 2017 11:25:19 +0300
Message-ID: <20170522082540.15467-14-tommi.t.rantala@nokia.com>
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
        id S1752882AbdEVI0V (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 May 2017 04:26:21 -0400
In-Reply-To: <20170522082540.15467-1-tommi.t.rantala@nokia.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
---
 src/cyclictest/cyclictest.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index d89cb0f..7720fce 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1223,6 +1223,11 @@ static void *timerthread(void *param)
 		next.tv_nsec += interval.tv_nsec;
 		if (par->mode == MODE_CYCLIC) {
 			int overrun_count = timer_getoverrun(timer);
+			if (overrun_count < 0) {
+				warn("timer_getoverrun() failed, errno: %d\n",
+					errno);
+				goto out;
+			}
 			next.tv_sec += overrun_count * interval.tv_sec;
 			next.tv_nsec += overrun_count * interval.tv_nsec;
 		}
-- 
2.9.3

