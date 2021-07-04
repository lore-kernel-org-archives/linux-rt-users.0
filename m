Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55648C07E96
	for <linux-rt-users@archiver.kernel.org>; Sun,  4 Jul 2021 20:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32E08613E2
	for <linux-rt-users@archiver.kernel.org>; Sun,  4 Jul 2021 20:36:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbhGDUjN (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 4 Jul 2021 16:39:13 -0400
Received: from mail.monom.org ([188.138.9.77]:39760 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229757AbhGDUjG (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 4 Jul 2021 16:39:06 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id 4DC415002BC;
        Sun,  4 Jul 2021 22:36:29 +0200 (CEST)
Received: from localhost (unknown [94.31.98.41])
        by mail.monom.org (Postfix) with ESMTPSA id 12C115005CA;
        Sun,  4 Jul 2021 22:36:29 +0200 (CEST)
From:   Daniel Wagner <wagi@monom.org>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH rt-tests v1 2/3] signaltest: Fix printf format specifier
Date:   Sun,  4 Jul 2021 22:36:20 +0200
Message-Id: <20210704203621.5612-3-wagi@monom.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210704203621.5612-1-wagi@monom.org>
References: <20210704203621.5612-1-wagi@monom.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Daniel Wagner <dwagner@suse.de>

The fields are not uint64 just longs, update the printf format
specifiers.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/signaltest/signaltest.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
index 6e8f6b51b003..4d89a1aba9d9 100644
--- a/src/signaltest/signaltest.c
+++ b/src/signaltest/signaltest.c
@@ -393,9 +393,9 @@ static void write_stats(FILE *f, void *data)
 	for (i = 0; i < num_threads; i++) {
 		fprintf(f, "    \"%u\": {\n", i);
 		s = &par->stats[i];
-		fprintf(f, "      \"cycles\": %" PRIu64 ",\n", s->cycles);
-		fprintf(f, "      \"min\": %" PRIu64 ",\n", s->min);
-		fprintf(f, "      \"max\": %" PRIu64 ",\n", s->max);
+		fprintf(f, "      \"cycles\": %ld,\n", s->cycles);
+		fprintf(f, "      \"min\": %ld,\n", s->min);
+		fprintf(f, "      \"max\": %ld,\n", s->max);
 		fprintf(f, "      \"avg\": %.2f,\n", s->avg/s->cycles);
 		fprintf(f, "      \"cpu\": %d\n", par->cpu);
 		fprintf(f, "    }%s\n", i == num_threads - 1 ? "" : ",");
-- 
2.32.0
