Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122DAC43381
	for <linux-rt-users@archiver.kernel.org>; Sat, 20 Mar 2021 18:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F057661932
	for <linux-rt-users@archiver.kernel.org>; Sat, 20 Mar 2021 18:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbhCTSjJ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 20 Mar 2021 14:39:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:51868 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229874AbhCTSig (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 20 Mar 2021 14:38:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0D081AD4A;
        Sat, 20 Mar 2021 18:38:36 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH rt-tests v3 15/33] rt-util: Introduce rt_test_start()
Date:   Sat, 20 Mar 2021 19:38:11 +0100
Message-Id: <20210320183829.1318-16-dwagner@suse.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210320183829.1318-1-dwagner@suse.de>
References: <20210320183829.1318-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

For the JSON output records a timestamp when the test ended.
Let's introduce a new API to record a timestamp when the test
starts. We could put this into rt_init() but in this case we
would meassure also the time test needs to setup or warm up.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/include/rt-utils.h |  2 ++
 src/lib/rt-utils.c     | 34 ++++++++++++++++++++++++----------
 2 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/src/include/rt-utils.h b/src/include/rt-utils.h
index 115791c55185..42c2772262db 100644
--- a/src/include/rt-utils.h
+++ b/src/include/rt-utils.h
@@ -82,6 +82,8 @@ static inline int64_t calctime(struct timespec t)
 
 void rt_init(int argc, char *argv[]);
 
+void rt_test_start(void);
+
 void rt_write_json(const char *filename,
 		   void (*cb)(FILE *, void *),
 		   void *data);
diff --git a/src/lib/rt-utils.c b/src/lib/rt-utils.c
index f736a3449bf7..efb5d1d9e866 100644
--- a/src/lib/rt-utils.c
+++ b/src/lib/rt-utils.c
@@ -30,6 +30,7 @@
 
 #define  TRACEBUFSIZ  1024
 #define  MAX_COMMAND_LINE 4096
+#define  MAX_TS_SIZE 64
 
 static char debugfileprefix[MAX_PATH];
 static char *fileprefix;
@@ -37,6 +38,7 @@ static int trace_fd = -1;
 static int tracemark_fd = -1;
 static __thread char tracebuf[TRACEBUFSIZ];
 static char test_cmdline[MAX_COMMAND_LINE];
+static char ts_start[MAX_TS_SIZE];
 
 /*
  * Finds the tracing directory in a mounted debugfs
@@ -514,17 +516,32 @@ void rt_init(int argc, char *argv[])
 	}
 }
 
+static void get_timestamp(char *tsbuf)
+{
+	struct timeval tv;
+	struct tm *tm;
+	time_t t;
+
+	gettimeofday(&tv, NULL);
+	t = tv.tv_sec;
+	tm = localtime(&t);
+	/* RFC 2822-compliant date format */
+	strftime(tsbuf, MAX_TS_SIZE, "%a, %d %b %Y %T %z", tm);
+}
+
+void rt_test_start(void)
+{
+	get_timestamp(ts_start);
+}
+
 void rt_write_json(const char *filename,
 		  void (*cb)(FILE *, void *),
 		  void *data)
 {
 	unsigned char buf[1];
 	struct utsname uts;
-	struct timeval tv;
-	char tsbuf[64];
-	struct tm *tm;
+	char ts_end[MAX_TS_SIZE];
 	FILE *f, *s;
-	time_t t;
 	size_t n;
 	int rt = 0;
 
@@ -536,11 +553,7 @@ void rt_write_json(const char *filename,
 			err_exit(errno, "Failed to open '%s'\n", filename);
 	}
 
-	gettimeofday(&tv, NULL);
-	t = tv.tv_sec;
-	tm = localtime(&t);
-	/* RFC 2822-compliant date format */
-	strftime(tsbuf, sizeof(tsbuf), "%a, %d %b %Y %T %z", tm);
+	get_timestamp(ts_end);
 
 	s = fopen("/sys/kernel/realtime", "r");
 	if (s) {
@@ -557,7 +570,8 @@ void rt_write_json(const char *filename,
 	fprintf(f, "  \"file_version\": 1,\n");
 	fprintf(f, "  \"cmdline:\": \"%s\",\n", test_cmdline);
 	fprintf(f, "  \"rt_test_version:\": \"%1.2f\",\n", VERSION);
-	fprintf(f, "  \"finished\": \"%s\",\n", tsbuf);
+	fprintf(f, "  \"start_time\": \"%s\",\n", ts_start);
+	fprintf(f, "  \"end_time\": \"%s\",\n", ts_end);
 	fprintf(f, "  \"sysinfo\": {\n");
 	fprintf(f, "    \"sysname\": \"%s\",\n", uts.sysname);
 	fprintf(f, "    \"nodename\": \"%s\",\n", uts.nodename);
-- 
2.30.2

