Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 220E2C433E9
	for <linux-rt-users@archiver.kernel.org>; Wed, 10 Feb 2021 16:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3C9D64E02
	for <linux-rt-users@archiver.kernel.org>; Wed, 10 Feb 2021 16:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232683AbhBJQ4i (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 10 Feb 2021 11:56:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:45254 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233308AbhBJQyu (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 10 Feb 2021 11:54:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E7B96B024;
        Wed, 10 Feb 2021 16:54:09 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>,
        Peter Xu <peterx@redhat.com>
Subject: [PATCH rt-tests 1/2] oslat: Print version string
Date:   Wed, 10 Feb 2021 17:54:06 +0100
Message-Id: <20210210165407.9770-2-dwagner@suse.de>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210210165407.9770-1-dwagner@suse.de>
References: <20210210165407.9770-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

During the streamlining of the command line options we missed to hook
up the command line option '--version' with usage().

Fixes: e411219d27b1 ("oslat: Streamline usage output and man page")
Reported-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/oslat/oslat.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
index 5b7e0d5b5d5c..d3f659b218b0 100644
--- a/src/oslat/oslat.c
+++ b/src/oslat/oslat.c
@@ -655,16 +655,10 @@ static void parse_options(int argc, char *argv[])
 			 */
 			g.single_preheat_thread = true;
 			break;
-		case 'v':
-			/*
-			 * Because we always dump the version even before parsing options,
-			 * what we need to do is to quit..
-			 */
-			exit(0);
-			break;
 		case 'z':
 			g.output_omit_zero_buckets = 1;
 			break;
+		case 'v':
 		case 'h':
 			usage(0);
 			break;
-- 
2.30.0

