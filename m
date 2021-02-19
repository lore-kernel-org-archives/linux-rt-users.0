Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B15C433E6
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Feb 2021 16:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C01F064E92
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Feb 2021 16:34:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhBSQee (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 19 Feb 2021 11:34:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:55360 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229993AbhBSQe0 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 19 Feb 2021 11:34:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F17EDACBF;
        Fri, 19 Feb 2021 16:33:42 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH rt-tests v1 2/2] cyclicdeadline.c: Fix printf format specifier
Date:   Fri, 19 Feb 2021 17:33:40 +0100
Message-Id: <20210219163340.6290-3-dwagner@suse.de>
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
 src/sched_deadline/cyclicdeadline.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
index ed3c960d9916..bb8ffc3642bc 100644
--- a/src/sched_deadline/cyclicdeadline.c
+++ b/src/sched_deadline/cyclicdeadline.c
@@ -978,9 +978,9 @@ static void write_stats(FILE *f, void *data)
 	for (i = 0; i < nr_threads; i++) {
 		s = &sd[i].stat;
 		fprintf(f, "    \"%u\": {\n", i);
-		fprintf(f, "	 \"cycles\": %" PRIu64 ",\n", s->cycles);
-		fprintf(f, "	 \"min\": %" PRIu64 ",\n", s->min);
-		fprintf(f, "	 \"max\": %" PRIu64 ",\n", s->max);
+		fprintf(f, "	 \"cycles\": %ld,\n", s->cycles);
+		fprintf(f, "	 \"min\": %ld,\n", s->min);
+		fprintf(f, "	 \"max\": %ld\n", s->max);
 		fprintf(f, "	 \"avg\": %.2f\n", s->avg/s->cycles);
 		fprintf(f, "    }%s\n", i == nr_threads - 1 ? "" : ",");
 	}
-- 
2.30.0

