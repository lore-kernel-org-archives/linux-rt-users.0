Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B658C433E4
	for <linux-rt-users@archiver.kernel.org>; Sat, 20 Mar 2021 18:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 260BC61944
	for <linux-rt-users@archiver.kernel.org>; Sat, 20 Mar 2021 18:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhCTSjE (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 20 Mar 2021 14:39:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:51858 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229787AbhCTSid (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 20 Mar 2021 14:38:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AB183AD4A;
        Sat, 20 Mar 2021 18:38:32 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH rt-tests v3 04/33] rt-util: Add rt_init function
Date:   Sat, 20 Mar 2021 19:38:00 +0100
Message-Id: <20210320183829.1318-5-dwagner@suse.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210320183829.1318-1-dwagner@suse.de>
References: <20210320183829.1318-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

rt_init() should be called as first in the test program.
The main job for this function is to copy the command line
before getopt() runs. By default, getopt_long() permutes
the contents of argv as it scans, so that eventually all the
nonoptions are at the end. This is confusing in the JSON
output, thus copy the command line before we call getopt_long().

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/include/rt-utils.h |  2 ++
 src/lib/rt-utils.c     | 47 +++++++++++++++++++++++++++++++++++-------
 2 files changed, 42 insertions(+), 7 deletions(-)

diff --git a/src/include/rt-utils.h b/src/include/rt-utils.h
index 36af92b170df..1dbd3f1dd8e3 100644
--- a/src/include/rt-utils.h
+++ b/src/include/rt-utils.h
@@ -80,6 +80,8 @@ static inline int64_t calctime(struct timespec t)
 	return time;
 }
 
+void rt_init(int argc, char *argv[]);
+
 void rt_write_json(const char *filename, int argc, char *argv[],
 		   void (*cb)(FILE *, void *),
 		   void *data);
diff --git a/src/lib/rt-utils.c b/src/lib/rt-utils.c
index 00907c573d6a..8f0e0943b137 100644
--- a/src/lib/rt-utils.c
+++ b/src/lib/rt-utils.c
@@ -29,12 +29,15 @@
 #include "rt-error.h"
 
 #define  TRACEBUFSIZ  1024
+#define  MAX_COMMAND_LINE 4096
 
 static char debugfileprefix[MAX_PATH];
 static char *fileprefix;
 static int trace_fd = -1;
 static int tracemark_fd = -1;
 static __thread char tracebuf[TRACEBUFSIZ];
+static char test_cmdline[MAX_COMMAND_LINE];
+static int rt_init_run;
 
 /*
  * Finds the tracing directory in a mounted debugfs
@@ -486,6 +489,34 @@ void disable_trace_mark(void)
 	close_tracemark_fd();
 }
 
+void rt_init(int argc, char *argv[])
+{
+	int offset = 0;
+	int len, i;
+
+	test_cmdline[0] = '\0';
+
+	/*
+	 * getopt_long() permutes the contents of argv as it scans, so
+	 * that eventually all the nonoptions are at the end. Make a
+	 * copy before calling getopt_long().
+	 */
+	for (i = 0; i < argc;) {
+		len = strlen(argv[i]);
+		if (offset + len + 1 >= MAX_COMMAND_LINE)
+			break;
+
+		strcat(test_cmdline, argv[i]);
+		i++;
+		if (i < argc)
+			strcat(test_cmdline, " ");
+
+		offset += len + 1;
+	}
+
+	rt_init_run = 1;
+}
+
 static char *get_cmdline(int argc, char *argv[])
 {
 	char *cmdline;
@@ -519,7 +550,7 @@ void rt_write_json(const char *filename, int argc, char *argv[],
 	struct timeval tv;
 	char tsbuf[64];
 	struct tm *tm;
-	char *cmdline;
+	char *cmdline = NULL;
 	FILE *f, *s;
 	time_t t;
 	size_t n;
@@ -533,10 +564,11 @@ void rt_write_json(const char *filename, int argc, char *argv[],
 			err_exit(errno, "Failed to open '%s'\n", filename);
 	}
 
-	cmdline = get_cmdline(argc, argv);
-	if (!cmdline)
-		err_exit(ENOMEM, "get_cmdline()");
-
+	if (!rt_init_run) {
+		cmdline = get_cmdline(argc, argv);
+		if (!cmdline)
+			err_exit(ENOMEM, "get_cmdline()");
+	}
 
 	gettimeofday(&tv, NULL);
 	t = tv.tv_sec;
@@ -557,7 +589,7 @@ void rt_write_json(const char *filename, int argc, char *argv[],
 
 	fprintf(f, "{\n");
 	fprintf(f, "  \"file_version\": 1,\n");
-	fprintf(f, "  \"cmdline:\": \"%s\",\n", cmdline);
+	fprintf(f, "  \"cmdline:\": \"%s\",\n", rt_init_run? test_cmdline : cmdline);
 	fprintf(f, "  \"rt_test_version:\": \"%1.2f\",\n", VERSION);
 	fprintf(f, "  \"finished\": \"%s\",\n", tsbuf);
 	fprintf(f, "  \"sysinfo\": {\n");
@@ -573,7 +605,8 @@ void rt_write_json(const char *filename, int argc, char *argv[],
 
 	fprintf(f, "}\n");
 
-	free(cmdline);
+	if (!rt_init_run)
+		free(cmdline);
 
 	if (!filename || strcmp("-", filename))
 		fclose(f);
-- 
2.30.2

