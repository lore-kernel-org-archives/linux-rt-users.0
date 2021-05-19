Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 275FCC43603
	for <linux-rt-users@archiver.kernel.org>; Wed, 19 May 2021 17:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08D68611AB
	for <linux-rt-users@archiver.kernel.org>; Wed, 19 May 2021 17:10:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355557AbhESRLU (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 19 May 2021 13:11:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:43936 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347533AbhESRLR (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 19 May 2021 13:11:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5A97AB1E2;
        Wed, 19 May 2021 17:09:57 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH rt-tests v1 18/23] rt-migrate-test: Add --json to man page
Date:   Wed, 19 May 2021 19:09:40 +0200
Message-Id: <20210519170945.21941-19-dwagner@suse.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210519170945.21941-1-dwagner@suse.de>
References: <20210519170945.21941-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Add the newly introduced --json command line to the man page.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/rt-migrate-test/rt-migrate-test.8 | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/src/rt-migrate-test/rt-migrate-test.8 b/src/rt-migrate-test/rt-migrate-test.8
index 5bbacb5333b8..53670e3757fa 100644
--- a/src/rt-migrate-test/rt-migrate-test.8
+++ b/src/rt-migrate-test/rt-migrate-test.8
@@ -5,7 +5,7 @@
 rt-migrate-test \- real-time task migration program
 .SH SYNOPSIS
 .LP
-rt-migrate-test [-c|--check] [-D|--duration TIME] [-e|--equal] [-h|--help] [-l|--loops LOOPS] [-m|--maxerr TIME] [-p|--prio PRIO] [-r|--run-time TIME] [-s|--sleep-time TIME] [NR_TASKS]
+rt-migrate-test [-c|--check] [-D|--duration TIME] [-e|--equal] [-h|--help] [--json FILENAME] [-l|--loops LOOPS] [-m|--maxerr TIME] [-p|--prio PRIO] [-r|--run-time TIME] [-s|--sleep-time TIME] [NR_TASKS]
 .SH DESCRIPTION
 Test real-time multiprocessor scheduling of tasks to ensure the highest priority tasks are running on all available CPUs
 .SH OPTIONS
@@ -31,6 +31,10 @@ Use equal prio for #CPU-1 tasks (requires > 2 CPUS)
 Display usage
 .br
 .TP
+.B \-\-json=FILENAME
+Write final results into FILENAME, JSON formatted.
+.br
+.TP
 .B \-l \-\-loops=LOOPS
 Number of iterations to run (50)
 .br
-- 
2.31.1

