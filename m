Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D677C07E9C
	for <linux-rt-users@archiver.kernel.org>; Thu,  8 Jul 2021 15:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13C5261418
	for <linux-rt-users@archiver.kernel.org>; Thu,  8 Jul 2021 15:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbhGHPVO (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 8 Jul 2021 11:21:14 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:39604 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbhGHPVO (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 8 Jul 2021 11:21:14 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 6CDEC201EA;
        Thu,  8 Jul 2021 15:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1625757511; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1T9kS3zygjo3SGBbBmjpFRl4HtEuh3g4rzClCMU8OYk=;
        b=dmVuoaaJl3a7XpKPesUA55HonxZFeVbk0iSYnTRw2qsw6TecqyOrostYt0/XyCS/+YN+vb
        /V7cBSl1LWX+4PGpfMggonyJOmtLcaAbgEHLBPXhSwsw1uhNgg676UIQ8H2zJaBVWm72eh
        R7r6ionRc0as5ByK/vVnWUlg7zxRGZ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1625757511;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1T9kS3zygjo3SGBbBmjpFRl4HtEuh3g4rzClCMU8OYk=;
        b=vp2tsrEq7K/q/qrtxUfZVwkzRxk9SOUzbtbwFzXa+RbubZV+cFGGx7hhC7vxEkLtv4QK5e
        S/GCwTxyxPSTAiDQ==
Received: from localhost (unknown [10.163.25.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4FDEEA3B8F;
        Thu,  8 Jul 2021 15:18:31 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH rt-tests v2 2/3] signaltest: Fix printf format specifier
Date:   Thu,  8 Jul 2021 17:18:26 +0200
Message-Id: <20210708151827.21430-3-dwagner@suse.de>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210708151827.21430-1-dwagner@suse.de>
References: <20210708151827.21430-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

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

