Return-Path: <SRS0=Dbld=RP=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D76C10F00
	for <linux-rt-users@archiver.kernel.org>; Tue, 12 Mar 2019 17:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3A512175B
	for <linux-rt-users@archiver.kernel.org>; Tue, 12 Mar 2019 17:25:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730168AbfCLRZC (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:25:02 -0400
Received: from thoth.sbs.de ([192.35.17.2]:49715 "EHLO thoth.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728847AbfCLRZC (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 12 Mar 2019 13:25:02 -0400
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
        by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id x2CHOtBB002451
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Mar 2019 18:24:55 +0100
Received: from localhost ([139.25.69.33])
        by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id x2CHOtbU015814;
        Tue, 12 Mar 2019 18:24:55 +0100
From:   Daniel Wagner <daniel.wagner@siemens.com>
To:     linux-rt-users@vger.kernel.org
Cc:     John Kacur <jkacur@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Daniel Wagner <daniel.wagner@siemens.com>
Subject: [PATCH 1/4] cyclicdeadline: Fix stack corruption
Date:   Tue, 12 Mar 2019 18:24:33 +0100
Message-Id: <20190312172436.18314-2-daniel.wagner@siemens.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190312172436.18314-1-daniel.wagner@siemens.com>
References: <20190312172436.18314-1-daniel.wagner@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The buffer is too short for the string.

Signed-off-by: Daniel Wagner <daniel.wagner@siemens.com>
---
 src/sched_deadline/cyclicdeadline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
index 577ad95cfee1..095e6ccc166f 100644
--- a/src/sched_deadline/cyclicdeadline.c
+++ b/src/sched_deadline/cyclicdeadline.c
@@ -285,7 +285,7 @@ static void setup_ftrace_marker(void)
 {
 	struct stat st;
 	const char *debugfs = find_debugfs();
-	char files[strlen(debugfs) + 14];
+	char files[strlen(debugfs) + strlen("/tracing/trace_marker")];
 	int ret;
 
 	if (strlen(debugfs) == 0)
-- 
2.20.1

