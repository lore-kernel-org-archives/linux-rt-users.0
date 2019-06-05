Return-Path: <SRS0=TVKX=UE=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2039C28CC6
	for <linux-rt-users@archiver.kernel.org>; Wed,  5 Jun 2019 16:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 948B92083E
	for <linux-rt-users@archiver.kernel.org>; Wed,  5 Jun 2019 16:06:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbfFEQGg (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 5 Jun 2019 12:06:36 -0400
Received: from mail.monom.org ([188.138.9.77]:35608 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbfFEQGc (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 5 Jun 2019 12:06:32 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id EE026500709;
        Wed,  5 Jun 2019 18:06:30 +0200 (CEST)
Received: from localhost (ppp-93-104-174-142.dynamic.mnet-online.de [93.104.174.142])
        by mail.monom.org (Postfix) with ESMTPSA id B20115004BB;
        Wed,  5 Jun 2019 18:06:30 +0200 (CEST)
From:   Daniel Wagner <wagi@monom.org>
To:     John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <wagi@monom.org>
Subject: [PATCH v2 03/12] rt-utils: Move parse_time_string()
Date:   Wed,  5 Jun 2019 18:06:08 +0200
Message-Id: <20190605160617.22987-4-wagi@monom.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190605160617.22987-1-wagi@monom.org>
References: <20190605160617.22987-1-wagi@monom.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Move parse_time_string() to rt-utils.c so we can re use it.

Signed-off-by: Daniel Wagner <wagi@monom.org>
---
 src/cyclictest/cyclictest.c | 33 ---------------------------------
 src/include/rt-utils.h      |  2 ++
 src/lib/rt-utils.c          | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 36 insertions(+), 33 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index ed59edefbf97..03d56e4f520c 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -406,39 +406,6 @@ static void enable_trace_mark(void)
 	open_tracemark_fd();
 }
 
-/*
- * parse an input value as a base10 value followed by an optional
- * suffix. The input value is presumed to be in seconds, unless
- * followed by a modifier suffix: m=minutes, h=hours, d=days
- *
- * the return value is a value in seconds
- */
-static int parse_time_string(char *val)
-{
-	char *end;
-	int t = strtol(val, &end, 10);
-	if (end) {
-		switch (*end) {
-		case 'm':
-		case 'M':
-			t *= 60;
-			break;
-
-		case 'h':
-		case 'H':
-			t *= 60*60;
-			break;
-
-		case 'd':
-		case 'D':
-			t *= 24*60*60;
-			break;
-
-		}
-	}
-	return t;
-}
-
 /*
  * Raise the soft priority limit up to prio, if that is less than or equal
  * to the hard limit
diff --git a/src/include/rt-utils.h b/src/include/rt-utils.h
index ef0f6acf4ab5..405fa7855346 100644
--- a/src/include/rt-utils.h
+++ b/src/include/rt-utils.h
@@ -24,4 +24,6 @@ uint32_t string_to_policy(const char *str);
 
 pid_t gettid(void);
 
+int parse_time_string(char *val);
+
 #endif	/* __RT_UTILS.H */
diff --git a/src/lib/rt-utils.c b/src/lib/rt-utils.c
index ac6878ccacf1..e1b166afcd6c 100644
--- a/src/lib/rt-utils.c
+++ b/src/lib/rt-utils.c
@@ -13,6 +13,7 @@
 #include <sched.h>
 #include <stdarg.h>
 #include <errno.h>
+#include <ctype.h>
 #include <fcntl.h>
 #include <sys/types.h>
 #include <sys/stat.h>
@@ -320,3 +321,36 @@ pid_t gettid(void)
 {
 	return syscall(SYS_gettid);
 }
+
+/*
+ * parse an input value as a base10 value followed by an optional
+ * suffix. The input value is presumed to be in seconds, unless
+ * followed by a modifier suffix: m=minutes, h=hours, d=days
+ *
+ * the return value is a value in seconds
+ */
+int parse_time_string(char *val)
+{
+	char *end;
+	int t = strtol(val, &end, 10);
+	if (end) {
+		switch (*end) {
+		case 'm':
+		case 'M':
+			t *= 60;
+			break;
+
+		case 'h':
+		case 'H':
+			t *= 60*60;
+			break;
+
+		case 'd':
+		case 'D':
+			t *= 24*60*60;
+			break;
+
+		}
+	}
+	return t;
+}
-- 
2.20.1
