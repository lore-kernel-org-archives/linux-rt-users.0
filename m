Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B638C433E0
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Jan 2021 18:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DDB222B37
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Jan 2021 18:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390871AbhAZRUW (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 26 Jan 2021 12:20:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:57504 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729028AbhAZJRZ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 26 Jan 2021 04:17:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B4833B27D;
        Tue, 26 Jan 2021 09:15:05 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [rt-tests v3 10/16] signaltest: Remove unused max_cpus argument from process_options
Date:   Tue, 26 Jan 2021 10:14:54 +0100
Message-Id: <20210126091500.31735-11-dwagner@suse.de>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210126091500.31735-1-dwagner@suse.de>
References: <20210126091500.31735-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

There is no use of this argument. Remove it.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/signaltest/signaltest.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
index 0d189483753d..3ca26fb373bb 100644
--- a/src/signaltest/signaltest.c
+++ b/src/signaltest/signaltest.c
@@ -207,7 +207,7 @@ static int lockall;
 static struct bitmask *affinity_mask = NULL;
 
 /* Process commandline options */
-static void process_options(int argc, char *argv[], unsigned int max_cpus)
+static void process_options(int argc, char *argv[])
 {
 	int error = 0;
 	int smp = 0;
@@ -325,7 +325,7 @@ int main(int argc, char **argv)
 	if (numa_available() == -1)
 		fatal("Couldn't initialize libnuma");
 
-	process_options(argc, argv, max_cpus);
+	process_options(argc, argv);
 
 	if (check_privs())
 		exit(1);
-- 
2.30.0

