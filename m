Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D47C433EB
	for <linux-rt-users@archiver.kernel.org>; Sat, 20 Mar 2021 18:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D148061946
	for <linux-rt-users@archiver.kernel.org>; Sat, 20 Mar 2021 18:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbhCTSjI (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 20 Mar 2021 14:39:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:51888 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229886AbhCTSih (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 20 Mar 2021 14:38:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9E5FAAD6D;
        Sat, 20 Mar 2021 18:38:36 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH rt-tests v3 17/33] oslat: Record start of test execution
Date:   Sat, 20 Mar 2021 19:38:13 +0100
Message-Id: <20210320183829.1318-18-dwagner@suse.de>
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
 src/oslat/oslat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
index ac54d05697ef..2f02f5399405 100644
--- a/src/oslat/oslat.c
+++ b/src/oslat/oslat.c
@@ -854,6 +854,7 @@ int main(int argc, char *argv[])
 		printf("Test starts...\n");
 	/* Reset n_threads to always run on all the cores */
 	g.n_threads = g.n_threads_total;
+	rt_test_start();
 	run_expt(threads, g.runtime);
 
 	if (!g.quiet)
-- 
2.30.2

