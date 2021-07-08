Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2192C11F67
	for <linux-rt-users@archiver.kernel.org>; Thu,  8 Jul 2021 15:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F26D613D1
	for <linux-rt-users@archiver.kernel.org>; Thu,  8 Jul 2021 15:18:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbhGHPVP (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 8 Jul 2021 11:21:15 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:43346 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbhGHPVO (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 8 Jul 2021 11:21:14 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id BE6EA21F6C;
        Thu,  8 Jul 2021 15:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1625757511; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bMJhYoeMj0eMMWp9w6kEHsJ02/1wdajPhRsTxe9Y3PM=;
        b=H0d/8svRdMpJf6cGQc4HU9Yj+G2gQNI+hElEzN/wKxgVv9g1rnMTNluuSbjSSw2DqOKaxj
        iTuw0x38i+GqsoH5wrczShp2nrtOQFLte6RM7GkQpjSMcHlVgBpxkaDYv3lyaOvWAERQc7
        fTat5s/yht+ISa0nRp8zF3efETGiAKU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1625757511;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bMJhYoeMj0eMMWp9w6kEHsJ02/1wdajPhRsTxe9Y3PM=;
        b=xKZR4j0Na6/476ChPYIoqflUJWwfprvcen0mSpEzwC6Hrr9A4qpbXORFDdMiYEsybNNny0
        tYuoQhDxQfQwvpCQ==
Received: from localhost (unknown [10.163.25.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A2DF7A3B97;
        Thu,  8 Jul 2021 15:18:31 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH rt-tests v2 3/3] cyclicdeadline: Fix buffer allocation
Date:   Thu,  8 Jul 2021 17:18:27 +0200
Message-Id: <20210708151827.21430-4-dwagner@suse.de>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210708151827.21430-1-dwagner@suse.de>
References: <20210708151827.21430-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

gcc complains with "‘sprintf’ output between 2 and 12 bytes" but
the buffer is only 10 bytes long. Update the buffer size to hold
the complete range of [-2147483648, 2147483646].

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/sched_deadline/cyclicdeadline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
index ffefa9e6fecb..8447424273ee 100644
--- a/src/sched_deadline/cyclicdeadline.c
+++ b/src/sched_deadline/cyclicdeadline.c
@@ -1092,7 +1092,7 @@ int main(int argc, char **argv)
 
 	/* Default cpu to use is the last one */
 	if (!all_cpus && !setcpu) {
-		setcpu_buf = malloc(10);
+		setcpu_buf = malloc(12);
 		if (!setcpu_buf)
 			fatal("malloc");
 		sprintf(setcpu_buf, "%d", cpu_count - 1);
-- 
2.32.0

