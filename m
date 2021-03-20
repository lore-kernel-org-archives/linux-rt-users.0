Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E4BC433ED
	for <linux-rt-users@archiver.kernel.org>; Sat, 20 Mar 2021 18:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6A1161944
	for <linux-rt-users@archiver.kernel.org>; Sat, 20 Mar 2021 18:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbhCTSjH (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 20 Mar 2021 14:39:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:51898 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229894AbhCTSih (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 20 Mar 2021 14:38:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E6235AD8A;
        Sat, 20 Mar 2021 18:38:36 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH rt-tests v3 18/33] pmqtest: Record start of test execution
Date:   Sat, 20 Mar 2021 19:38:14 +0100
Message-Id: <20210320183829.1318-19-dwagner@suse.de>
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
 src/pmqtest/pmqtest.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/pmqtest/pmqtest.c b/src/pmqtest/pmqtest.c
index f96b3d0bf400..adf72c10ce83 100644
--- a/src/pmqtest/pmqtest.c
+++ b/src/pmqtest/pmqtest.c
@@ -583,6 +583,7 @@ int main(int argc, char *argv[])
 	sigemptyset(&sigset);
 	pthread_sigmask(SIG_SETMASK, &sigset, NULL);
 
+	rt_test_start();
 	do {
 		int newsamples = 0, newtimeoutcount = 0;
 		int minsamples = INT_MAX;
-- 
2.30.2

