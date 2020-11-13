Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 440D6C55ABD
	for <linux-rt-users@archiver.kernel.org>; Fri, 13 Nov 2020 21:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC97C22255
	for <linux-rt-users@archiver.kernel.org>; Fri, 13 Nov 2020 21:09:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgKMVJU (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 13 Nov 2020 16:09:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:39770 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726003AbgKMVJT (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 13 Nov 2020 16:09:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C5F57AD1E;
        Fri, 13 Nov 2020 21:09:18 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [rt-tests v1 1/6] rt-utils: Introduce parse_mem_string()
Date:   Fri, 13 Nov 2020 22:09:05 +0100
Message-Id: <20201113210910.21807-2-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201113210910.21807-1-dwagner@suse.de>
References: <20201113210910.21807-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Add helper to parse common memory prefixes on strings.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/include/rt-utils.h |  1 +
 src/lib/rt-utils.c     | 30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/src/include/rt-utils.h b/src/include/rt-utils.h
index c6fb220cdb0a..39ddbd9eae29 100644
--- a/src/include/rt-utils.h
+++ b/src/include/rt-utils.h
@@ -28,6 +28,7 @@ uint32_t string_to_policy(const char *str);
 pid_t gettid(void);
 
 int parse_time_string(char *val);
+int parse_mem_string(char *str, uint64_t *val);
 
 void enable_trace_mark(void);
 void tracemark(char *fmt, ...) __attribute__((format(printf, 1, 2)));
diff --git a/src/lib/rt-utils.c b/src/lib/rt-utils.c
index a30e1e4ce436..2d68d62cd875 100644
--- a/src/lib/rt-utils.c
+++ b/src/lib/rt-utils.c
@@ -362,6 +362,36 @@ int parse_time_string(char *val)
 	return t;
 }
 
+int parse_mem_string(char *str, uint64_t *val)
+{
+	char *endptr;
+	int v = strtol(str, &endptr, 10);
+
+	if (!*endptr)
+		return v;
+
+	switch (*endptr) {
+	case 'g':
+	case 'G':
+		v *= 1024;
+	case 'm':
+	case 'M':
+		v *= 1024;
+	case 'k':
+	case 'K':
+		v *= 1024;
+	case 'b':
+	case 'B':
+		break;
+	default:
+		return -1;
+	}
+
+	*val = v;
+
+	return 0;
+}
+
 static void open_tracemark_fd(void)
 {
 	char path[MAX_PATH];
-- 
2.29.2

