Return-Path: <SRS0=5+M/=CL=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C3B5C433E2
	for <linux-rt-users@archiver.kernel.org>; Wed,  2 Sep 2020 08:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73EB22078B
	for <linux-rt-users@archiver.kernel.org>; Wed,  2 Sep 2020 08:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgIBI1o (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 2 Sep 2020 04:27:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:43896 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726268AbgIBI1g (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 2 Sep 2020 04:27:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BBE0CB65F;
        Wed,  2 Sep 2020 08:27:35 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [rt-tests 4/4] oslat: Use string parser utilies
Date:   Wed,  2 Sep 2020 10:27:25 +0200
Message-Id: <20200902082725.20037-5-dwagner@suse.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200902082725.20037-1-dwagner@suse.de>
References: <20200902082725.20037-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Use available parse_time_string() instead locally implemented
version. While at it move the mem parser helper to the global utility
header.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/include/rt-utils.h |  1 +
 src/lib/rt-utils.c     | 30 +++++++++++++++++++
 src/oslat/oslat.c      | 67 ++----------------------------------------
 3 files changed, 33 insertions(+), 65 deletions(-)

diff --git a/src/include/rt-utils.h b/src/include/rt-utils.h
index 4ed1cbc53ece..d7f369cdbb47 100644
--- a/src/include/rt-utils.h
+++ b/src/include/rt-utils.h
@@ -28,6 +28,7 @@ uint32_t string_to_policy(const char *str);
 pid_t gettid(void);
 
 int parse_time_string(char *val);
+int parse_mem_string(char *str, uint64_t *val);
 
 void enable_trace_mark(void);
 void tracemark(char *fmt, ...) __attribute__((format(printf, 1, 2)));
diff --git a/src/lib/rt-utils.c b/src/lib/rt-utils.c
index f786588706cd..f9cbfb82febb 100644
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
 void open_tracemark_fd(void)
 {
 	char path[MAX_PATH];
diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
index 79d2b6754461..3a5acae95c1f 100644
--- a/src/oslat/oslat.c
+++ b/src/oslat/oslat.c
@@ -570,69 +570,6 @@ static int parse_cpu_list(char *cpu_list, cpu_set_t *cpu_set)
 	return n_cores;
 }
 
-static int parse_runtime(const char *str)
-{
-	char *endptr;
-	int v = strtol(str, &endptr, 10);
-
-	if (!*endptr)
-		return v;
-
-	switch (*endptr) {
-	case 'd':
-	case 'D':
-		/* Days */
-		v *= 24;
-	case 'h':
-	case 'H':
-		/* Hours */
-		v *= 60;
-	case 'm':
-	case 'M':
-		/* Minutes */
-		v *= 60;
-	case 's':
-	case 'S':
-		/* Seconds */
-		break;
-	default:
-		printf("Unknown runtime suffix: %s\n", endptr);
-		v = 0;
-		break;
-	}
-
-	return v;
-}
-
-static int parse_mem_size(char *str, uint64_t *val)
-{
-	char *endptr;
-	int v = strtol(str, &endptr, 10);
-
-	if (!*endptr)
-		return v;
-
-	switch (*endptr) {
-	case 'g':
-	case 'G':
-		v *= 1024;
-	case 'm':
-	case 'M':
-		v *= 1024;
-	case 'k':
-	case 'K':
-		v *= 1024;
-	case 'b':
-	case 'B':
-		break;
-	default:
-		return -1;
-	}
-
-	*val = v;
-
-	return 0;
-}
 
 static int workload_select(char *name)
 {
@@ -700,7 +637,7 @@ static void parse_options(int argc, char *argv[])
 			}
 			break;
 		case 'D':
-			g.runtime = parse_runtime(optarg);
+			g.runtime = parse_time_string(optarg);
 			if (!g.runtime) {
 				printf("Illegal runtime: %s\n", optarg);
 				exit(1);
@@ -734,7 +671,7 @@ static void parse_options(int argc, char *argv[])
 			}
 			break;
 		case 'm':
-			if (parse_mem_size(optarg, &g.workload_mem_size)) {
+			if (parse_mem_string(optarg, &g.workload_mem_size)) {
 				printf("Unknown workload memory size '%s'.\n\n", optarg);
 				exit(1);
 			}
-- 
2.28.0

