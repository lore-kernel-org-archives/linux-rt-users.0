Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC17BC433EF
	for <linux-rt-users@archiver.kernel.org>; Mon, 13 Sep 2021 19:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C58661106
	for <linux-rt-users@archiver.kernel.org>; Mon, 13 Sep 2021 19:29:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240546AbhIMTbN (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 13 Sep 2021 15:31:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48197 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240112AbhIMTbM (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 13 Sep 2021 15:31:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631561396;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=hpDyFEjvizwUdny8iCcsaz2w+pIFGd/xdvvclm6yDRA=;
        b=DSvPUojOwZE/2KKzz3t6NEVbte87lnKz1JjF3Mg7q3NC2V3urnEyGjqyGgzUoEl602Lo6i
        LOv3vBM19wdjtu4GlCiHWJOwEFPWYszCayl/ZUc6MXQm/fqLxHAlAFAMa4BYTQ1E5HwzXu
        bWD18Nl9OVbMVsF/FuhNRazrx0ml57s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-EHU4cxzAOOOWcEGRucgC3g-1; Mon, 13 Sep 2021 15:29:54 -0400
X-MC-Unique: EHU4cxzAOOOWcEGRucgC3g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F22E45074C
        for <linux-rt-users@vger.kernel.org>; Mon, 13 Sep 2021 19:29:53 +0000 (UTC)
Received: from lleshchi.bos.com (unknown [10.22.10.140])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 868075D9CA;
        Mon, 13 Sep 2021 19:29:53 +0000 (UTC)
From:   lleshchi@redhat.com
To:     jkacur@redhat.com
Cc:     williams@redhat.com, linux-rt-users@vger.kernel.org
Subject: [PATCH] rt-tests: Add missing option F to optstring
Date:   Mon, 13 Sep 2021 15:29:51 -0400
Message-Id: <20210913192951.650464-1-lleshchi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Leah Leshchinsky <lleshchi@redhat.com>

The cyclictest help output lists -F as the short version of the
--fifo option, yet calling cyclictest -F produces an error"
cyclictest: invalid option --'F'".
This patch adds -F as a valid argument.

Signed-off-by: Leah Leshchinsky <lleshchi@redhat.com>
---
 src/cyclictest/cyclictest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index a08c91d..f8f7dbc 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1011,7 +1011,7 @@ static void process_options(int argc, char *argv[], int max_cpus)
 			{"posix_timers",     no_argument,	NULL, OPT_POSIX_TIMERS },
 			{NULL, 0, NULL, 0 },
 		};
-		int c = getopt_long(argc, argv, "a::A::b:c:d:D:h:H:i:l:MNo:p:mqrRsSt::uvD:x",
+		int c = getopt_long(argc, argv, "a::A::b:c:d:D:F:h:H:i:l:MNo:p:mqrRsSt::uvD:x",
 				    long_options, &option_index);
 		if (c == -1)
 			break;
-- 
2.27.0

