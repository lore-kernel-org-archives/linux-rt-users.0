Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E918C433ED
	for <linux-rt-users@archiver.kernel.org>; Wed, 19 May 2021 17:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ACC8610CC
	for <linux-rt-users@archiver.kernel.org>; Wed, 19 May 2021 17:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347426AbhESRLN (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 19 May 2021 13:11:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:43870 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242795AbhESRLN (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 19 May 2021 13:11:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 671DFB188;
        Wed, 19 May 2021 17:09:52 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH rt-tests v1 01/23] cyclicdeadline: Fix JSON output format
Date:   Wed, 19 May 2021 19:09:23 +0200
Message-Id: <20210519170945.21941-2-dwagner@suse.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210519170945.21941-1-dwagner@suse.de>
References: <20210519170945.21941-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Add missing comma after the max entry.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/sched_deadline/cyclicdeadline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
index 8d801b4c154a..b81fb3a2091d 100644
--- a/src/sched_deadline/cyclicdeadline.c
+++ b/src/sched_deadline/cyclicdeadline.c
@@ -977,7 +977,7 @@ static void write_stats(FILE *f, void *data)
 		fprintf(f, "    \"%u\": {\n", i);
 		fprintf(f, "	 \"cycles\": %ld,\n", s->cycles);
 		fprintf(f, "	 \"min\": %ld,\n", s->min);
-		fprintf(f, "	 \"max\": %ld\n", s->max);
+		fprintf(f, "	 \"max\": %ld,\n", s->max);
 		fprintf(f, "	 \"avg\": %.2f\n", s->avg/s->cycles);
 		fprintf(f, "    }%s\n", i == nr_threads - 1 ? "" : ",");
 	}
-- 
2.31.1

