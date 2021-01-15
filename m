Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8997BC433E0
	for <linux-rt-users@archiver.kernel.org>; Fri, 15 Jan 2021 19:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47DAB23A5E
	for <linux-rt-users@archiver.kernel.org>; Fri, 15 Jan 2021 19:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729043AbhAOTKV (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 15 Jan 2021 14:10:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:43260 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727855AbhAOTKU (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 15 Jan 2021 14:10:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 96DCFAE76;
        Fri, 15 Jan 2021 19:09:39 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [RFC v3 02/19] ptsematest: Return correct exit code when showing help
Date:   Fri, 15 Jan 2021 20:09:19 +0100
Message-Id: <20210115190936.26148-3-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210115190936.26148-1-dwagner@suse.de>
References: <20210115190936.26148-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Instead always return success, use the provided exist code.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/ptsematest/ptsematest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/ptsematest/ptsematest.c b/src/ptsematest/ptsematest.c
index 2e392299fdc4..f8f075591f4b 100644
--- a/src/ptsematest/ptsematest.c
+++ b/src/ptsematest/ptsematest.c
@@ -164,7 +164,7 @@ static void display_help(int error)
 	       "                           without NUM, threads = max_cpus\n"
 	       "                           without -t default = 1\n"
 	       );
-	exit(0);
+	exit(error);
 }
 
 
-- 
2.29.2

