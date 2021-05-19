Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B8E4C43611
	for <linux-rt-users@archiver.kernel.org>; Wed, 19 May 2021 17:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1545A611AB
	for <linux-rt-users@archiver.kernel.org>; Wed, 19 May 2021 17:10:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355564AbhESRLX (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 19 May 2021 13:11:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:43922 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347431AbhESRLS (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 19 May 2021 13:11:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 892A2B1F1;
        Wed, 19 May 2021 17:09:58 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH rt-tests v1 22/23] ssdd: Add --json to man page
Date:   Wed, 19 May 2021 19:09:44 +0200
Message-Id: <20210519170945.21941-23-dwagner@suse.de>
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
 src/ssdd/ssdd.8 | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/ssdd/ssdd.8 b/src/ssdd/ssdd.8
index 5c29d0abb732..a3b9d790dec4 100644
--- a/src/ssdd/ssdd.8
+++ b/src/ssdd/ssdd.8
@@ -3,7 +3,7 @@
 ssdd \- have a tracer do a bunch of PTRACE_SINGLESTEPs
 .SH SYNOPSIS
 .LP
-ssdd [-f|--forks NUM] [-h|--help] [-i|--iters NUM]
+ssdd [-f|--forks NUM] [-h|--help] [-i|--iters NUM] [--json FILENAME]
 .SH DESCRIPTION
 Have a tracer do a bunch of PTRACE_SINGLESTEPs against a tracee as
 fast as possible. Create several of these tracer/tracee pairs and
@@ -25,6 +25,9 @@ number of PTRACE_SINGLESTEP iterations to do before declaring
 success, for each tracer tracee pair set up.
 .br
 Default is 10,000.
+.TP
+.B \-\-json=FILENAME
+Write final results into FILENAME, JSON formatted.
 .SH AUTHOR
 ssdd was written by Joe Korty <joe.korty@concurrent-rt.com>
 .PP
-- 
2.31.1

