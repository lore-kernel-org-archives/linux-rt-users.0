From: Tommi Rantala <tommi.t.rantala@nokia.com>
Subject: [PATCH 24/34] signaltest: remove unused ARRAY_SIZE macro
Date: Mon, 22 May 2017 11:25:30 +0300
Message-ID: <20170522082540.15467-25-tommi.t.rantala@nokia.com>
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
        id S1757349AbdEVI0e (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 May 2017 04:26:34 -0400
In-Reply-To: <20170522082540.15467-1-tommi.t.rantala@nokia.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
---
 src/signaltest/signaltest.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
index 59f979e..72a549d 100644
--- a/src/signaltest/signaltest.c
+++ b/src/signaltest/signaltest.c
@@ -30,8 +30,6 @@
 #include "error.h"
 #include "rt-utils.h"
 
-#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
-
 /* Ugly, but .... */
 #define gettid() syscall(__NR_gettid)
 
-- 
2.9.3

