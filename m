Return-Path: <SRS0=uG0Q=CK=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC57C433E6
	for <linux-rt-users@archiver.kernel.org>; Tue,  1 Sep 2020 15:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FB09206EF
	for <linux-rt-users@archiver.kernel.org>; Tue,  1 Sep 2020 15:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729580AbgIAPrT (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:47:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:48276 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731968AbgIAPrI (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 1 Sep 2020 11:47:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3A082AC8C;
        Tue,  1 Sep 2020 15:47:07 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [rt-tests 3/4] rt-utils: Move ARRAY_SIZE to common header
Date:   Tue,  1 Sep 2020 17:46:56 +0200
Message-Id: <20200901154657.30198-4-dwagner@suse.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901154657.30198-1-dwagner@suse.de>
References: <20200901154657.30198-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Move the ARRAY_SIZE macro to a common header to avoid code
duplication.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/cyclictest/cyclictest.c | 2 --
 src/include/rt-utils.h      | 2 ++
 src/signaltest/signaltest.c | 2 --
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index ae1d64a46b21..b41d42f13f24 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -49,8 +49,6 @@
 #define SCHED_NORMAL SCHED_OTHER
 #endif
 
-#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
-
 #define sigev_notify_thread_id _sigev_un._tid
 
 #ifdef __UCLIBC__
diff --git a/src/include/rt-utils.h b/src/include/rt-utils.h
index f7b98d9605a0..4ed1cbc53ece 100644
--- a/src/include/rt-utils.h
+++ b/src/include/rt-utils.h
@@ -8,6 +8,8 @@
 #define STR(x) _STR(x)
 #define MAX_PATH 256
 
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+
 int check_privs(void);
 char *get_debugfileprefix(void);
 int mount_debugfs(char *);
diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
index 49d42ff20b6f..0bf075456ab6 100644
--- a/src/signaltest/signaltest.c
+++ b/src/signaltest/signaltest.c
@@ -32,8 +32,6 @@
 #include "error.h"
 #include "rt-utils.h"
 
-#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
-
 /* Must be power of 2 ! */
 #define VALBUF_SIZE		16384
 
-- 
2.28.0

