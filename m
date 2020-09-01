Return-Path: <SRS0=uG0Q=CK=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B9A6C433E6
	for <linux-rt-users@archiver.kernel.org>; Tue,  1 Sep 2020 15:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68C5C206EF
	for <linux-rt-users@archiver.kernel.org>; Tue,  1 Sep 2020 15:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgIAPrX (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:47:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:48264 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731967AbgIAPrI (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 1 Sep 2020 11:47:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CA427AC85;
        Tue,  1 Sep 2020 15:47:06 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [rt-tests 2/4] rt-utils: Move time defininitions to common header
Date:   Tue,  1 Sep 2020 17:46:55 +0200
Message-Id: <20200901154657.30198-3-dwagner@suse.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901154657.30198-1-dwagner@suse.de>
References: <20200901154657.30198-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Several tests define the same time values. Move them all to
common header to avoid code duplication.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/backfire/sendme.c         | 3 ---
 src/include/rt-utils.h        | 6 ++++++
 src/pi_tests/pi_stress.c      | 9 ---------
 src/pmqtest/pmqtest.c         | 4 ----
 src/ptsematest/ptsematest.c   | 2 --
 src/queuelat/queuelat.c       | 2 +-
 src/signaltest/signaltest.c   | 3 ---
 src/sigwaittest/sigwaittest.c | 2 --
 src/svsematest/svsematest.c   | 2 --
 9 files changed, 7 insertions(+), 26 deletions(-)

diff --git a/src/backfire/sendme.c b/src/backfire/sendme.c
index c1854d9660cb..d963723b1c93 100644
--- a/src/backfire/sendme.c
+++ b/src/backfire/sendme.c
@@ -38,9 +38,6 @@
 #include <sys/time.h>
 #include <sys/mman.h>
 
-#define USEC_PER_SEC		1000000
-#define NSEC_PER_SEC		1000000000
-
 #define SIGTEST SIGHUP
 
 enum {
diff --git a/src/include/rt-utils.h b/src/include/rt-utils.h
index fdd790600d68..f7b98d9605a0 100644
--- a/src/include/rt-utils.h
+++ b/src/include/rt-utils.h
@@ -30,8 +30,14 @@ int parse_time_string(char *val);
 void enable_trace_mark(void);
 void tracemark(char *fmt, ...) __attribute__((format(printf, 1, 2)));
 
+#define MSEC_PER_SEC		1000
 #define USEC_PER_SEC		1000000
 #define NSEC_PER_SEC		1000000000
+#define USEC_TO_NSEC(u)		((u) * 1000)
+#define USEC_TO_SEC(u)		(u) / USEC_PER_SEC)
+#define NSEC_TO_USEC(n)		((n) / 1000)
+#define SEC_TO_NSEC(s)		((s) * NSEC_PER_SEC)
+#define SEC_TO_USEC(s)		((s) * USEC_PER_SEC)
 
 static inline void tsnorm(struct timespec *ts)
 {
diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
index 93d7044c9f22..e03cca25b933 100644
--- a/src/pi_tests/pi_stress.c
+++ b/src/pi_tests/pi_stress.c
@@ -50,15 +50,6 @@
 
 #include "error.h"
 
-/* conversions */
-#define USEC_PER_SEC 	1000000
-#define NSEC_PER_SEC 	1000000000
-#define USEC_TO_NSEC(u) ((u) * 1000)
-#define USEC_TO_SEC(u) 	((u) / USEC_PER_SEC)
-#define NSEC_TO_USEC(n) ((n) / 1000)
-#define SEC_TO_NSEC(s) 	((s) * NSEC_PER_SEC)
-#define SEC_TO_USEC(s) 	((s) * USEC_PER_SEC)
-
 /* test timeout */
 #define TIMEOUT 2
 
diff --git a/src/pmqtest/pmqtest.c b/src/pmqtest/pmqtest.c
index 3ce29252b9a2..5db8d348cdf8 100644
--- a/src/pmqtest/pmqtest.c
+++ b/src/pmqtest/pmqtest.c
@@ -27,13 +27,9 @@
 
 #include <pthread.h>
 
-#define USEC_PER_SEC 1000000
-
 #define SYNCMQ_NAME "/syncmsg%d"
 #define TESTMQ_NAME "/testmsg%d"
 #define MSG_SIZE 8
-#define MSEC_PER_SEC 1000
-#define NSEC_PER_SEC 1000000000
 
 char *syncmsg = "Syncing";
 char *testmsg = "Testing";
diff --git a/src/ptsematest/ptsematest.c b/src/ptsematest/ptsematest.c
index 485c991ec173..de8ea2fe1b0c 100644
--- a/src/ptsematest/ptsematest.c
+++ b/src/ptsematest/ptsematest.c
@@ -25,8 +25,6 @@
 
 #include <pthread.h>
 
-#define USEC_PER_SEC 1000000
-
 enum {
 	AFFINITY_UNSPECIFIED,
 	AFFINITY_SPECIFIED,
diff --git a/src/queuelat/queuelat.c b/src/queuelat/queuelat.c
index 22b68a84d6ae..2b9118d8a8a5 100644
--- a/src/queuelat/queuelat.c
+++ b/src/queuelat/queuelat.c
@@ -17,7 +17,7 @@
 #include <signal.h>
 #include <time.h>
 
-#define NSEC_PER_SEC 1000000000
+#include "rt-utils.h"
 
 /* Program parameters:
  * max_queue_len: maximum latency allowed, in nanoseconds (int).
diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
index 42a70facc6b3..49d42ff20b6f 100644
--- a/src/signaltest/signaltest.c
+++ b/src/signaltest/signaltest.c
@@ -34,9 +34,6 @@
 
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
 
-#define USEC_PER_SEC		1000000
-#define NSEC_PER_SEC		1000000000
-
 /* Must be power of 2 ! */
 #define VALBUF_SIZE		16384
 
diff --git a/src/sigwaittest/sigwaittest.c b/src/sigwaittest/sigwaittest.c
index 4678b68675b2..e7393f791519 100644
--- a/src/sigwaittest/sigwaittest.c
+++ b/src/sigwaittest/sigwaittest.c
@@ -43,8 +43,6 @@
 
 #include <pthread.h>
 
-#define USEC_PER_SEC 1000000
-
 enum {
 	AFFINITY_UNSPECIFIED,
 	AFFINITY_SPECIFIED,
diff --git a/src/svsematest/svsematest.c b/src/svsematest/svsematest.c
index 023a303fd7df..607b397bf39e 100644
--- a/src/svsematest/svsematest.c
+++ b/src/svsematest/svsematest.c
@@ -32,8 +32,6 @@
 #include "rt-get_cpu.h"
 #include "error.h"
 
-#define USEC_PER_SEC 1000000
-
 #define SEM_WAIT_FOR_RECEIVER 0
 #define SEM_WAIT_FOR_SENDER 1
 
-- 
2.28.0

