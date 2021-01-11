Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2227C4332D
	for <linux-rt-users@archiver.kernel.org>; Mon, 11 Jan 2021 17:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 885C522CAD
	for <linux-rt-users@archiver.kernel.org>; Mon, 11 Jan 2021 17:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389609AbhAKRem (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 11 Jan 2021 12:34:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:51010 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389493AbhAKRel (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 11 Jan 2021 12:34:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A81EFAE1F;
        Mon, 11 Jan 2021 17:33:59 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [RFC v2 4/6] rt-utils: Add JSON common header output helper
Date:   Mon, 11 Jan 2021 18:33:49 +0100
Message-Id: <20210111173351.4971-5-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210111173351.4971-1-dwagner@suse.de>
References: <20210111173351.4971-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

rt_write_json writes the common system information header of the
rt-test currently executed.

Reviewed-by: Daniel Wagner <dwagner@suse.de>
---
 src/include/rt-utils.h |  4 +++
 src/lib/rt-utils.c     | 58 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/src/include/rt-utils.h b/src/include/rt-utils.h
index 39ddbd9eae29..ca9984d7cf35 100644
--- a/src/include/rt-utils.h
+++ b/src/include/rt-utils.h
@@ -80,4 +80,8 @@ static inline int64_t calctime(struct timespec t)
 	return time;
 }
 
+void rt_write_json(FILE *f, int argc, char *argv[],
+		   void (*cb)(FILE *, void *),
+		   void *data);
+
 #endif	/* __RT_UTILS.H */
diff --git a/src/lib/rt-utils.c b/src/lib/rt-utils.c
index 321a11b1172d..8fe0b7ed1f63 100644
--- a/src/lib/rt-utils.c
+++ b/src/lib/rt-utils.c
@@ -20,6 +20,7 @@
 #include <sys/stat.h>
 #include <unistd.h>
 #include <sys/syscall.h> /* For SYS_gettid definitions */
+#include <sys/utsname.h>
 
 #include "rt-utils.h"
 #include "rt-sched.h"
@@ -482,3 +483,60 @@ void disable_trace_mark(void)
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
+	cmdline[0] = '\0';
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
+void rt_write_json(FILE *f, int argc, char *argv[],
+		  void (*cb)(FILE *, void *),
+		  void *data)
+{
+	struct utsname buf;
+	char *cmdline;
+
+	cmdline = get_cmdline(argc, argv);
+	if (!cmdline)
+		err_exit(ENOMEM, "get_cmdline()");
+
+	if (uname(&buf))
+		err_exit(errno, "Could not retrieve system information");
+
+	fprintf(f, "{\n");
+	fprintf(f, "  \"file_version\": 1,\n");
+	fprintf(f, "  \"cmdline:\": \"%s\",\n", cmdline);
+	fprintf(f, "  \"rt_test_version:\": \"%1.2f\",\n", VERSION);
+	fprintf(f, "  \"sysinfo\": {\n");
+	fprintf(f, "    \"sysname\": \"%s\",\n", buf.sysname);
+	fprintf(f, "    \"nodename\": \"%s\",\n", buf.nodename);
+	fprintf(f, "    \"release\": \"%s\",\n", buf.release);
+	fprintf(f, "    \"version\": \"%s\",\n", buf.version);
+	fprintf(f, "    \"machine\": \"%s\"\n", buf.machine);
+	fprintf(f, "  },\n");
+
+	(cb)(f, data);
+
+	fprintf(f, "}\n");
+
+	free(cmdline);
+}
-- 
2.29.2

