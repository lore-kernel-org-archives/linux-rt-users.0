Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F16C4742C
	for <linux-rt-users@archiver.kernel.org>; Fri, 13 Nov 2020 21:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4479522255
	for <linux-rt-users@archiver.kernel.org>; Fri, 13 Nov 2020 21:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgKMVJV (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 13 Nov 2020 16:09:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:39788 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725981AbgKMVJU (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 13 Nov 2020 16:09:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1BA2CB012;
        Fri, 13 Nov 2020 21:09:19 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [rt-tests v1 2/6] oslat: Use string parser utilies
Date:   Fri, 13 Nov 2020 22:09:06 +0100
Message-Id: <20201113210910.21807-3-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201113210910.21807-1-dwagner@suse.de>
References: <20201113210910.21807-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Use available parse_time_string() instead locally implemented
version. While at it move the mem parser helper to the global utility
header.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/oslat/oslat.c | 67 ++---------------------------------------------
 1 file changed, 2 insertions(+), 65 deletions(-)

diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
index 0018c472e0c1..b2aa15001be2 100644
--- a/src/oslat/oslat.c
+++ b/src/oslat/oslat.c
@@ -572,69 +572,6 @@ static int parse_cpu_list(char *cpu_list, cpu_set_t *cpu_set)
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
@@ -702,7 +639,7 @@ static void parse_options(int argc, char *argv[])
 			}
 			break;
 		case 'D':
-			g.runtime = parse_runtime(optarg);
+			g.runtime = parse_time_string(optarg);
 			if (!g.runtime) {
 				printf("Illegal runtime: %s\n", optarg);
 				exit(1);
@@ -736,7 +673,7 @@ static void parse_options(int argc, char *argv[])
 			}
 			break;
 		case 'm':
-			if (parse_mem_size(optarg, &g.workload_mem_size)) {
+			if (parse_mem_string(optarg, &g.workload_mem_size)) {
 				printf("Unknown workload memory size '%s'.\n\n", optarg);
 				exit(1);
 			}
-- 
2.29.2

