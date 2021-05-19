Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B6BC43470
	for <linux-rt-users@archiver.kernel.org>; Wed, 19 May 2021 17:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60AFF610CC
	for <linux-rt-users@archiver.kernel.org>; Wed, 19 May 2021 17:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355560AbhESRLU (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 19 May 2021 13:11:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:43946 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355540AbhESRLS (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 19 May 2021 13:11:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9FAB5B1E5;
        Wed, 19 May 2021 17:09:57 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH rt-tests v1 19/23] cyclicdeadline: Add --json to man page
Date:   Wed, 19 May 2021 19:09:41 +0200
Message-Id: <20210519170945.21941-20-dwagner@suse.de>
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
 src/sched_deadline/cyclicdeadline.8 | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/sched_deadline/cyclicdeadline.8 b/src/sched_deadline/cyclicdeadline.8
index 59b60ca7bd31..1a56ed028d81 100644
--- a/src/sched_deadline/cyclicdeadline.8
+++ b/src/sched_deadline/cyclicdeadline.8
@@ -17,7 +17,7 @@ cyclicdeadline \- This program is used to test the deadline scheduler (SCHED_DEA
 .PP
 .SH SYNOPSIS
 .B cyclicdeadline
-.RI "[-a [CPUSET]] [-D TIME] [-h]  [-i INTV] [-s STEP] [-t NUM] [-q]"
+.RI "[-a [CPUSET]] [-D TIME] [-h]  [-i INTV] [--json FILENAME] [-s STEP] [-t NUM] [-q]"
 .PP
 .SH DESCRIPTION
 .B cyclicdeadline
@@ -38,6 +38,9 @@ Show this help menu
 .B \-i \-\-interval INTV
 The shortest deadline for the tasks in us. (default 1000us)
 .TP
+.B \-\-json=FILENAME
+Write final results into FILENAME, JSON formatted.
+.TP
 .B \-s \-\-step STEP
 The amount to increase the deadline for each task in us. (default 500us)
 .TP
-- 
2.31.1

