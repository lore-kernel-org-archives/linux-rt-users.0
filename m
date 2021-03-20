Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1179DC433E1
	for <linux-rt-users@archiver.kernel.org>; Sat, 20 Mar 2021 18:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9A8961944
	for <linux-rt-users@archiver.kernel.org>; Sat, 20 Mar 2021 18:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbhCTSjD (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 20 Mar 2021 14:39:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:51820 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229766AbhCTSic (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 20 Mar 2021 14:38:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C3E06AC71;
        Sat, 20 Mar 2021 18:38:31 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH rt-tests v3 01/33] cyclictest: Remove unused include header
Date:   Sat, 20 Mar 2021 19:37:57 +0100
Message-Id: <20210320183829.1318-2-dwagner@suse.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210320183829.1318-1-dwagner@suse.de>
References: <20210320183829.1318-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The header was introduced by 24aaf9619bc2 ("cyclictest: Add JSON
output feature") for PRIu64 format specifier. As PRIu64 was removed in
commit f6881fc42baa ("cyclictest: Fix printf format specifier") remove
the include header again.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/cyclictest/cyclictest.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index dca961025433..c43dd7cbbd64 100644
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
-- 
2.30.2

