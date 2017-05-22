From: Tommi Rantala <tommi.t.rantala@nokia.com>
Subject: [PATCH 25/34] deadline_test: fix stack corruption in setup_ftrace_marker()
Date: Mon, 22 May 2017 11:25:31 +0300
Message-ID: <20170522082540.15467-26-tommi.t.rantala@nokia.com>
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
        id S1752882AbdEVI0g (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 May 2017 04:26:36 -0400
In-Reply-To: <20170522082540.15467-1-tommi.t.rantala@nokia.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Make sure that files[] has correct length.

Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
---
 src/sched_deadline/deadline_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/sched_deadline/deadline_test.c b/src/sched_deadline/deadline_test.c
index 2a63c5f..e5621a3 100644
--- a/src/sched_deadline/deadline_test.c
+++ b/src/sched_deadline/deadline_test.c
@@ -435,7 +435,7 @@ static void setup_ftrace_marker(void)
 {
 	struct stat st;
 	const char *debugfs = find_debugfs();
-	char files[strlen(debugfs) + 14];
+	char files[strlen(debugfs) + strlen("/tracing/trace_marker") + 1];
 	int ret;
 
 	if (strlen(debugfs) == 0)
-- 
2.9.3

