Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955EEC433F4
	for <linux-rt-users@archiver.kernel.org>; Sat, 20 Mar 2021 18:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 803A061948
	for <linux-rt-users@archiver.kernel.org>; Sat, 20 Mar 2021 18:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbhCTSjK (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 20 Mar 2021 14:39:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:51912 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229897AbhCTSii (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 20 Mar 2021 14:38:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3B9EBAAB8;
        Sat, 20 Mar 2021 18:38:37 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH rt-tests v3 19/33] ptesematest: Record start of test execution
Date:   Sat, 20 Mar 2021 19:38:15 +0100
Message-Id: <20210320183829.1318-20-dwagner@suse.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210320183829.1318-1-dwagner@suse.de>
References: <20210320183829.1318-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Use rt_test_start() to record a timestamp when the test starts.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/ptsematest/ptsematest.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/ptsematest/ptsematest.c b/src/ptsematest/ptsematest.c
index a32bfc1698f0..471f1b307c14 100644
--- a/src/ptsematest/ptsematest.c
+++ b/src/ptsematest/ptsematest.c
@@ -468,6 +468,7 @@ int main(int argc, char *argv[])
 	maindelay.tv_sec = 0;
 	maindelay.tv_nsec = 50000000; /* 50 ms */
 
+	rt_test_start();
 	while (!shutdown) {
 		for (i = 0; i < num_threads; i++)
 			shutdown |= receiver[i].shutdown | sender[i].shutdown;
-- 
2.30.2

