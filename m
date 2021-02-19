Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8642CC433DB
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Feb 2021 16:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42D6C60234
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Feb 2021 16:34:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhBSQec (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 19 Feb 2021 11:34:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:55348 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229796AbhBSQeZ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 19 Feb 2021 11:34:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A8CC2AC6E;
        Fri, 19 Feb 2021 16:33:42 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH rt-tests v1 1/2] cyclictest: Fix printf format specifier
Date:   Fri, 19 Feb 2021 17:33:39 +0100
Message-Id: <20210219163340.6290-2-dwagner@suse.de>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210219163340.6290-1-dwagner@suse.de>
References: <20210219163340.6290-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The fields are not uint64 just longs, update the printf format
specifiers.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/cyclictest/cyclictest.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index c3d45f3ae31b..da502d426a8c 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1732,15 +1732,15 @@ static void write_stats(FILE *f, void *data)
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
2.30.0

