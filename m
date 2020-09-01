Return-Path: <SRS0=uG0Q=CK=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99788C433E2
	for <linux-rt-users@archiver.kernel.org>; Tue,  1 Sep 2020 15:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7821C206EB
	for <linux-rt-users@archiver.kernel.org>; Tue,  1 Sep 2020 15:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730652AbgIAPxX (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:53:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:48256 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731965AbgIAPrH (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 1 Sep 2020 11:47:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5E6F7AC65;
        Tue,  1 Sep 2020 15:47:06 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [rt-tests 1/4] rt-utils: Move timestamp calc helper to common header
Date:   Tue,  1 Sep 2020 17:46:54 +0200
Message-Id: <20200901154657.30198-2-dwagner@suse.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901154657.30198-1-dwagner@suse.de>
References: <20200901154657.30198-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Several test implement the same helpers. Move it to a
common header to avoid code duplication.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/cyclictest/cyclictest.c | 40 -------------------------------------
 src/include/rt-utils.h      | 40 +++++++++++++++++++++++++++++++++++++
 src/pi_tests/pi_stress.c    |  8 --------
 src/signaltest/signaltest.c | 15 --------------
 4 files changed, 40 insertions(+), 63 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index dd418939a0c2..ae1d64a46b21 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -86,9 +86,6 @@ extern int clock_nanosleep(clockid_t __clock_id, int __flags,
 			   struct timespec *__rem);
 #endif	/* __UCLIBC__ */
 
-#define USEC_PER_SEC		1000000
-#define NSEC_PER_SEC		1000000000
-
 #define HIST_MAX		1000000
 
 #define MODE_CYCLIC		0
@@ -291,43 +288,6 @@ enum {
 static int trace_fd     = -1;
 static int tracemark_fd = -1;
 
-static inline void tsnorm(struct timespec *ts)
-{
-	while (ts->tv_nsec >= NSEC_PER_SEC) {
-		ts->tv_nsec -= NSEC_PER_SEC;
-		ts->tv_sec++;
-	}
-}
-
-static inline int tsgreater(struct timespec *a, struct timespec *b)
-{
-	return ((a->tv_sec > b->tv_sec) ||
-		(a->tv_sec == b->tv_sec && a->tv_nsec > b->tv_nsec));
-}
-
-static inline int64_t calcdiff(struct timespec t1, struct timespec t2)
-{
-	int64_t diff = USEC_PER_SEC * (long long)((int) t1.tv_sec - (int) t2.tv_sec);
-	diff += ((int) t1.tv_nsec - (int) t2.tv_nsec) / 1000;
-	return diff;
-}
-
-static inline int64_t calcdiff_ns(struct timespec t1, struct timespec t2)
-{
-	int64_t diff;
-	diff = NSEC_PER_SEC * (int64_t)((int) t1.tv_sec - (int) t2.tv_sec);
-	diff += ((int) t1.tv_nsec - (int) t2.tv_nsec);
-	return diff;
-}
-
-static inline int64_t calctime(struct timespec t)
-{
-	int64_t time;
-	time = USEC_PER_SEC * t.tv_sec;
-	time += ((int) t.tv_nsec) / 1000;
-	return time;
-}
-
 /*
  * Raise the soft priority limit up to prio, if that is less than or equal
  * to the hard limit
diff --git a/src/include/rt-utils.h b/src/include/rt-utils.h
index 51489b408e6c..fdd790600d68 100644
--- a/src/include/rt-utils.h
+++ b/src/include/rt-utils.h
@@ -30,4 +30,44 @@ int parse_time_string(char *val);
 void enable_trace_mark(void);
 void tracemark(char *fmt, ...) __attribute__((format(printf, 1, 2)));
 
+#define USEC_PER_SEC		1000000
+#define NSEC_PER_SEC		1000000000
+
+static inline void tsnorm(struct timespec *ts)
+{
+	while (ts->tv_nsec >= NSEC_PER_SEC) {
+		ts->tv_nsec -= NSEC_PER_SEC;
+		ts->tv_sec++;
+	}
+}
+
+static inline int tsgreater(struct timespec *a, struct timespec *b)
+{
+	return ((a->tv_sec > b->tv_sec) ||
+		(a->tv_sec == b->tv_sec && a->tv_nsec > b->tv_nsec));
+}
+
+static inline int64_t calcdiff(struct timespec t1, struct timespec t2)
+{
+	int64_t diff = USEC_PER_SEC * (long long)((int) t1.tv_sec - (int) t2.tv_sec);
+	diff += ((int) t1.tv_nsec - (int) t2.tv_nsec) / 1000;
+	return diff;
+}
+
+static inline int64_t calcdiff_ns(struct timespec t1, struct timespec t2)
+{
+	int64_t diff;
+	diff = NSEC_PER_SEC * (int64_t)((int) t1.tv_sec - (int) t2.tv_sec);
+	diff += ((int) t1.tv_nsec - (int) t2.tv_nsec);
+	return diff;
+}
+
+static inline int64_t calctime(struct timespec t)
+{
+	int64_t time;
+	time = USEC_PER_SEC * t.tv_sec;
+	time += ((int) t.tv_nsec) / 1000;
+	return time;
+}
+
 #endif	/* __RT_UTILS.H */
diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
index eba21d7727bc..93d7044c9f22 100644
--- a/src/pi_tests/pi_stress.c
+++ b/src/pi_tests/pi_stress.c
@@ -519,14 +519,6 @@ int pending_interrupt(void)
 	return interrupted = sigismember(&pending, SIGINT);
 }
 
-static inline void tsnorm(struct timespec *ts)
-{
-	while (ts->tv_nsec >= NSEC_PER_SEC) {
-		ts->tv_nsec -= NSEC_PER_SEC;
-		ts->tv_sec++;
-	}
-}
-
 /*
  * this routine serves two purposes:
  *   1. report progress
diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
index b5c86c5635cb..42a70facc6b3 100644
--- a/src/signaltest/signaltest.c
+++ b/src/signaltest/signaltest.c
@@ -69,21 +69,6 @@ static int shutdown;
 static int tracelimit = 0;
 static int oldtrace = 0;
 
-static inline void tsnorm(struct timespec *ts)
-{
-	while (ts->tv_nsec >= NSEC_PER_SEC) {
-		ts->tv_nsec -= NSEC_PER_SEC;
-		ts->tv_sec++;
-	}
-}
-
-static inline long calcdiff(struct timespec t1, struct timespec t2)
-{
-	long diff;
-	diff = USEC_PER_SEC * ((int) t1.tv_sec - (int) t2.tv_sec);
-	diff += ((int) t1.tv_nsec - (int) t2.tv_nsec) / 1000;
-	return diff;
-}
 
 /*
  * signal thread
-- 
2.28.0

