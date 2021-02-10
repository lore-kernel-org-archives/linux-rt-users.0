Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DB2C433E6
	for <linux-rt-users@archiver.kernel.org>; Wed, 10 Feb 2021 17:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87C7164EEB
	for <linux-rt-users@archiver.kernel.org>; Wed, 10 Feb 2021 17:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233439AbhBJRwq (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 10 Feb 2021 12:52:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:37072 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233277AbhBJRwD (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 10 Feb 2021 12:52:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C24FCAD6A;
        Wed, 10 Feb 2021 17:51:21 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH rt-tests v5 03/13] rt-utils: Add JSON common header output helper
Date:   Wed, 10 Feb 2021 18:51:08 +0100
Message-Id: <20210210175118.19709-4-dwagner@suse.de>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210210175118.19709-1-dwagner@suse.de>
References: <20210210175118.19709-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

rt_write_json writes the common system information header of the
rt-test currently executed.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/include/rt-utils.h |  4 ++
 src/lib/rt-utils.c     | 96 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 100 insertions(+)

diff --git a/src/include/rt-utils.h b/src/include/rt-utils.h
index 39ddbd9eae29..36af92b170df 100644
--- a/src/include/rt-utils.h
+++ b/src/include/rt-utils.h
@@ -80,4 +80,8 @@ static inline int64_t calctime(struct timespec t)
 	return time;
 }
 
+void rt_write_json(const char *filename, int argc, char *argv[],
+		   void (*cb)(FILE *, void *),
+		   void *data);
+
 #endif	/* __RT_UTILS.H */
diff --git a/src/lib/rt-utils.c b/src/lib/rt-utils.c
index 321a11b1172d..00907c573d6a 100644
--- a/src/lib/rt-utils.c
+++ b/src/lib/rt-utils.c
@@ -20,6 +20,9 @@
 #include <sys/stat.h>
 #include <unistd.h>
 #include <sys/syscall.h> /* For SYS_gettid definitions */
+#include <sys/utsname.h>
+#include <time.h>
+#include <sys/time.h>
 
 #include "rt-utils.h"
 #include "rt-sched.h"
@@ -482,3 +485,96 @@ void disable_trace_mark(void)
 {
 	close_tracemark_fd();
 }
+
+static char *get_cmdline(int argc, char *argv[])
+{
+	char *cmdline;
+	int len, i;
+
+	len = 0;
+	for (i = 0; i < argc; i++)
+		len += strlen(argv[i]) + 1;
+
+	cmdline = malloc(len);
+	if (!cmdline)
+		err_exit(ENOMEM, "Could not copy cmdline");
+
+	memset(cmdline, 0, len);
+	for (i = 0; i < argc;) {
+		cmdline = strcat(cmdline, argv[i]);
+		i++;
+		if (i < argc)
+			cmdline = strcat(cmdline, " ");
+	}
+
+	return cmdline;
+}
+
+void rt_write_json(const char *filename, int argc, char *argv[],
+		  void (*cb)(FILE *, void *),
+		  void *data)
+{
+	unsigned char buf[1];
+	struct utsname uts;
+	struct timeval tv;
+	char tsbuf[64];
+	struct tm *tm;
+	char *cmdline;
+	FILE *f, *s;
+	time_t t;
+	size_t n;
+	int rt = 0;
+
+	if (!filename || !strcmp("-", filename)) {
+		f = stdout;
+	} else {
+		f = fopen(filename, "w");
+		if (!f)
+			err_exit(errno, "Failed to open '%s'\n", filename);
+	}
+
+	cmdline = get_cmdline(argc, argv);
+	if (!cmdline)
+		err_exit(ENOMEM, "get_cmdline()");
+
+
+	gettimeofday(&tv, NULL);
+	t = tv.tv_sec;
+	tm = localtime(&t);
+	/* RFC 2822-compliant date format */
+	strftime(tsbuf, sizeof(tsbuf), "%a, %d %b %Y %T %z", tm);
+
+	s = fopen("/sys/kernel/realtime", "r");
+	if (s) {
+		n = fread(buf, 1, 1, s);
+		if (n == 1 && buf[0] == '1')
+			rt = 1;
+		fclose(s);
+	}
+
+	if (uname(&uts))
+		err_exit(errno, "Could not retrieve system information");
+
+	fprintf(f, "{\n");
+	fprintf(f, "  \"file_version\": 1,\n");
+	fprintf(f, "  \"cmdline:\": \"%s\",\n", cmdline);
+	fprintf(f, "  \"rt_test_version:\": \"%1.2f\",\n", VERSION);
+	fprintf(f, "  \"finished\": \"%s\",\n", tsbuf);
+	fprintf(f, "  \"sysinfo\": {\n");
+	fprintf(f, "    \"sysname\": \"%s\",\n", uts.sysname);
+	fprintf(f, "    \"nodename\": \"%s\",\n", uts.nodename);
+	fprintf(f, "    \"release\": \"%s\",\n", uts.release);
+	fprintf(f, "    \"version\": \"%s\",\n", uts.version);
+	fprintf(f, "    \"machine\": \"%s\",\n", uts.machine);
+	fprintf(f, "    \"realtime\": %d\n", rt);
+	fprintf(f, "  },\n");
+
+	(cb)(f, data);
+
+	fprintf(f, "}\n");
+
+	free(cmdline);
+
+	if (!filename || strcmp("-", filename))
+		fclose(f);
+}
-- 
2.30.0

