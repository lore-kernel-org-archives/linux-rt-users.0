From: Tommi Rantala <tommi.t.rantala@nokia.com>
Subject: [PATCH 29/34] cyclicdeadline: fix stack corruption in setup_ftrace_marker()
Date: Mon, 22 May 2017 11:25:35 +0300
Message-ID: <20170522082540.15467-30-tommi.t.rantala@nokia.com>
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
        id S1757326AbdEVI0t (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 May 2017 04:26:49 -0400
In-Reply-To: <20170522082540.15467-1-tommi.t.rantala@nokia.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Make sure that files[] has correct length.

Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
---
 src/sched_deadline/cyclicdeadline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
index 761f8d7..59f06d5 100644
--- a/src/sched_deadline/cyclicdeadline.c
+++ b/src/sched_deadline/cyclicdeadline.c
@@ -283,7 +283,7 @@ static void setup_ftrace_marker(void)
 {
 	struct stat st;
 	const char *debugfs = find_debugfs();
-	char files[strlen(debugfs) + 14];
+	char files[strlen(debugfs) + strlen("/tracing/trace_marker") + 1];
 	int ret;
 
 	if (strlen(debugfs) == 0)
-- 
2.9.3

