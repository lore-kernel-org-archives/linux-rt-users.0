Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B3CC433E6
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Jan 2021 18:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 882BB22A84
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Jan 2021 18:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390692AbhAZRUH (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 26 Jan 2021 12:20:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:56086 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390846AbhAZJPw (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 26 Jan 2021 04:15:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 350EAB278;
        Tue, 26 Jan 2021 09:15:03 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [rt-tests v3 02/16] cyclictest: Mimik --smp behavior with --affinity
Date:   Tue, 26 Jan 2021 10:14:46 +0100
Message-Id: <20210126091500.31735-3-dwagner@suse.de>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210126091500.31735-1-dwagner@suse.de>
References: <20210126091500.31735-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Let --affinity without an argument behave in the same way as
--smp. Run a thread on each CPU. This makes cyclictest behave as the
rest of the rt-tests when --affinity is used.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/cyclictest/cyclictest.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 6009ff2a83bc..4c02f067fbad 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1019,6 +1019,8 @@ static void process_options(int argc, char *argv[], int max_cpus)
 				    argv[optind][0] == '0' ||
 				    argv[optind][0] == '!')) {
 				parse_cpumask(argv[optind], max_cpus, &affinity_mask);
+			} else {
+				num_threads = -1;
 			}
 			break;
 		case 'A':
-- 
2.30.0

