Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A670CC2B9F2
	for <linux-rt-users@archiver.kernel.org>; Sat, 22 May 2021 19:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CFC561164
	for <linux-rt-users@archiver.kernel.org>; Sat, 22 May 2021 19:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbhEVTdm (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 22 May 2021 15:33:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:52772 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231364AbhEVTdj (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 22 May 2021 15:33:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1621711929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=oG9LBcQrTWck0r2mLls9gv+heMM0Ld+b54SVF/XhFTU=;
        b=CcghOSr0UYEnOFEBbmrNsrGRVZ8HC6Rtdi9ddLZizFaenJG94U76Gpv2/XhzHYapkhokOx
        CYRChALl+9cdtEQNUgZ+F24xHCQG67mgFccmZc4g9YDZLj1oioIruNYyNy82ll5WIqJfyX
        1OQCg76gkZIPgM5oIu3xYB+UxcMQUVg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1621711929;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=oG9LBcQrTWck0r2mLls9gv+heMM0Ld+b54SVF/XhFTU=;
        b=RZwF94qn+IM7pq5Dlxq0d7uRS5KLI7ejau2PevcPri2r2sjhrCCA+GzocdTeum+GZCI1Uq
        CbDeX1r/Fif+/RAQ==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F1E5AAB5F;
        Sat, 22 May 2021 19:32:08 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH rt-tests] signaltest: Fix printf format specifier
Date:   Sat, 22 May 2021 21:32:05 +0200
Message-Id: <20210522193205.4529-1-dwagner@suse.de>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The fields are not uint64 just longs, update the printf format
specifiers.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---

Found while building on ARMv7

 src/signaltest/signaltest.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
index 2dd22070cb5d..8df39528730d 100644
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
2.31.1

