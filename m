Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4CADC433E0
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Mar 2021 07:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7528064FE6
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Mar 2021 07:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbhCEHfH (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 5 Mar 2021 02:35:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:43692 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229526AbhCEHfG (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 5 Mar 2021 02:35:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0E794AE72;
        Fri,  5 Mar 2021 07:35:05 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH rt-tests v2 02/14] cyclicdeadline.c: Fix printf format specifier
Date:   Fri,  5 Mar 2021 08:34:48 +0100
Message-Id: <20210305073500.17926-3-dwagner@suse.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210305073500.17926-1-dwagner@suse.de>
References: <20210305073500.17926-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The fields are not uint64 just longs, update the printf format
specifiers.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/sched_deadline/cyclicdeadline.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
index 33bac8cda898..d7aa9bb5d269 100644
--- a/src/sched_deadline/cyclicdeadline.c
+++ b/src/sched_deadline/cyclicdeadline.c
@@ -18,7 +18,6 @@
 #include <errno.h>
 #include <signal.h>
 #include <getopt.h>
-#include <inttypes.h>
 
 #include <sys/syscall.h>
 #include <sys/types.h>
@@ -976,9 +975,9 @@ static void write_stats(FILE *f, void *data)
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
2.30.1

