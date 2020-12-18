Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABFDC2D0E4
	for <linux-rt-users@archiver.kernel.org>; Fri, 18 Dec 2020 14:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 895B023AC0
	for <linux-rt-users@archiver.kernel.org>; Fri, 18 Dec 2020 14:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbgLROVK (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 18 Dec 2020 09:21:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:37944 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727079AbgLROVJ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 18 Dec 2020 09:21:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 29536B720;
        Fri, 18 Dec 2020 14:19:49 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [rt-tests v1 6/6] cyclictest: Move verbose message into main
Date:   Fri, 18 Dec 2020 15:19:35 +0100
Message-Id: <20201218141935.24151-7-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201218141935.24151-1-dwagner@suse.de>
References: <20201218141935.24151-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

By moving the verbose message down we print the message with the final
affinity_mask. This also handles the case where the bitmask is not set.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/cyclictest/cyclictest.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index a364b4ad203a..5abb69d0b28f 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1020,10 +1020,6 @@ static void process_options(int argc, char *argv[], int max_cpus)
 				    argv[optind][0] == '!')) {
 				parse_cpumask(argv[optind], max_cpus, &affinity_mask);
 			}
-
-			if (verbose)
-				printf("Using %u cpus.\n",
-					numa_bitmask_weight(affinity_mask));
 			break;
 		case 'A':
 		case OPT_ALIGNED:
@@ -1732,6 +1728,10 @@ int main(int argc, char **argv)
 		res = numa_sched_setaffinity(getpid(), affinity_mask);
 		if (res != 0)
 			warn("Couldn't setaffinity in main thread: %s\n", strerror(errno));
+
+		if (verbose)
+			printf("Using %u cpus.\n",
+				numa_bitmask_weight(affinity_mask));
 	}
 
 	if (trigger) {
-- 
2.29.2

