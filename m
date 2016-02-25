From: Luiz Capitulino <lcapitulino@redhat.com>
Subject: [PATCH 3/4] cyclictest: move tracemark_fd handling to its own function
Date: Thu, 25 Feb 2016 11:29:16 -0500
Message-ID: <1456417757-13444-4-git-send-email-lcapitulino@redhat.com>
References: <1456417757-13444-1-git-send-email-lcapitulino@redhat.com>
Cc: jkacur@redhat.com, williams@redhat.com
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38085 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933038AbcBYQ32 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 25 Feb 2016 11:29:28 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id E1A18D0A9D
	for <linux-rt-users@vger.kernel.org>; Thu, 25 Feb 2016 16:29:27 +0000 (UTC)
In-Reply-To: <1456417757-13444-1-git-send-email-lcapitulino@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

A function added by the next commit will want to call
this code too.

Signed-off-by: Luiz Capitulino <lcapitulino@redhat.com>
---
 src/cyclictest/cyclictest.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index f543c34..e35088b 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -497,6 +497,19 @@ static void debugfs_prepare(void)
 		fileprefix = procfileprefix;
 }
 
+static void open_tracemark_fd(void)
+{
+	char path[MAX_PATH];
+
+	if (tracemark_fd >= 0)
+		return;
+
+	sprintf(path, "%s/%s", fileprefix, "trace_marker");
+	tracemark_fd = open(path, O_WRONLY);
+	if (tracemark_fd < 0)
+		warn("unable to open trace_marker file: %s\n", path);
+}
+
 static void setup_tracer(void)
 {
 	if (!tracelimit || notrace)
@@ -612,14 +625,7 @@ static void setup_tracer(void)
 				fatal("unable to open %s for tracing", path);
 		}
 
-		/* open the tracemark file descriptor */
-		if (tracemark_fd == -1) {
-			char path[MAX_PATH];
-			strcat(strcpy(path, fileprefix), "trace_marker");
-			if ((tracemark_fd = open(path, O_WRONLY)) == -1)
-				warn("unable to open trace_marker file: %s\n", path);
-		}
