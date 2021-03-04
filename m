Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 825A4C43603
	for <linux-rt-users@archiver.kernel.org>; Thu,  4 Mar 2021 19:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 541AB64F60
	for <linux-rt-users@archiver.kernel.org>; Thu,  4 Mar 2021 19:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234959AbhCDTXb (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 4 Mar 2021 14:23:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:51208 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234167AbhCDTXG (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 4 Mar 2021 14:23:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0FDEFACE5;
        Thu,  4 Mar 2021 19:22:25 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH rt-tests v1 01/13] cyclictest: Fix printf format specifier
Date:   Thu,  4 Mar 2021 20:22:08 +0100
Message-Id: <20210304192220.11272-2-dwagner@suse.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210304192220.11272-1-dwagner@suse.de>
References: <20210304192220.11272-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The fields are not uint64 just longs, update the printf format
specifiers.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/cyclictest/cyclictest.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 157047837259..c43dd7cbbd64 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -11,7 +11,6 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <stdint.h>
-#include <inttypes.h>
 #include <stdarg.h>
 #include <unistd.h>
 #include <fcntl.h>
@@ -1751,15 +1750,15 @@ static void write_stats(FILE *f, void *data)
 			if (s->hist_array[j] == 0)
 				continue;
 			fprintf(f, "%s", comma ? ",\n" : "\n");
-			fprintf(f, "        \"%u\": %" PRIu64, j, s->hist_array[j]);
+			fprintf(f, "        \"%u\": %ld", j, s->hist_array[j]);
 			comma = 1;
 		}
 		if (comma)
 			fprintf(f, "\n");
 		fprintf(f, "      },\n");
-		fprintf(f, "      \"cycles\": %" PRIu64 ",\n", s->cycles);
-		fprintf(f, "      \"min\": %" PRIu64 ",\n", s->min);
-		fprintf(f, "      \"max\": %" PRIu64 ",\n", s->max);
+		fprintf(f, "      \"cycles\": %ld,\n", s->cycles);
+		fprintf(f, "      \"min\": %ld,\n", s->min);
+		fprintf(f, "      \"max\": %ld,\n", s->max);
 		fprintf(f, "      \"avg\": %.2f,\n", s->avg/s->cycles);
 		fprintf(f, "      \"cpu\": %d,\n", par[i]->cpu);
 		fprintf(f, "      \"node\": %d\n", par[i]->node);
-- 
2.30.1

