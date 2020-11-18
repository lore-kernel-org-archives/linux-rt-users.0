Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1B9C6379F
	for <linux-rt-users@archiver.kernel.org>; Wed, 18 Nov 2020 19:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10F832220B
	for <linux-rt-users@archiver.kernel.org>; Wed, 18 Nov 2020 19:07:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbgKRTGs (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 18 Nov 2020 14:06:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:49976 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727123AbgKRTGs (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 18 Nov 2020 14:06:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 58793BB14;
        Wed, 18 Nov 2020 19:06:47 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [rt-tests v1 01/12] cyclicdeadline: Remove dead code
Date:   Wed, 18 Nov 2020 20:06:31 +0100
Message-Id: <20201118190642.16006-2-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201118190642.16006-1-dwagner@suse.de>
References: <20201118190642.16006-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

my_sprintf() is not used, remove it.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 compare.py                          | 12 ++++++++++++
 src/sched_deadline/cyclicdeadline.c | 13 -------------
 2 files changed, 12 insertions(+), 13 deletions(-)
 create mode 100644 compare.py

diff --git a/compare.py b/compare.py
new file mode 100644
index 000000000000..7fb6ae818a00
--- /dev/null
+++ b/compare.py
@@ -0,0 +1,12 @@
+with open('old', 'r') as old:
+    with open('new', 'r') as new:
+        for ol in old.readlines():
+            new.seek(0)
+            for nl in new.readlines():
+                o = ol.split()
+                n = nl.split()
+
+                if o[8] == n[8]:
+                    d = int(n[4]) - int(o[4])
+                    p = d/int(o[4]) * 100
+                    print('{:20} {:>8} {:>8} {:>6} {:>2.2}%'.format(o[8], o[4], n[4], d, p))
diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
index a6309ded3c52..e0db9669f676 100644
--- a/src/sched_deadline/cyclicdeadline.c
+++ b/src/sched_deadline/cyclicdeadline.c
@@ -215,19 +215,6 @@ static int my_vsprintf(char *buf, int size, const char *fmt, va_list ap)
 	return s - buf;
 }
 
-#if 0
-static int my_sprintf(char *buf, int size, const char *fmt, ...)
-{
-	va_list ap;
-	int n;
-
-	va_start(ap, fmt);
-	n = vsnprintf(buf, size, fmt, ap);
-	va_end(ap);
-	return n;
-}
-#endif
-
 static void ftrace_write(char *buf, const char *fmt, ...)
 {
 	va_list ap;
-- 
2.29.2

