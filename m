Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A744C43460
	for <linux-rt-users@archiver.kernel.org>; Wed, 19 May 2021 17:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CEEC611BD
	for <linux-rt-users@archiver.kernel.org>; Wed, 19 May 2021 17:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355545AbhESRLS (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 19 May 2021 13:11:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:43976 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355517AbhESRLQ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 19 May 2021 13:11:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 79ACCAEF8;
        Wed, 19 May 2021 17:09:56 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH rt-tests v1 15/23] pi_stress: Add --json to man page
Date:   Wed, 19 May 2021 19:09:37 +0200
Message-Id: <20210519170945.21941-16-dwagner@suse.de>
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
 src/pi_tests/pi_stress.8 | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/src/pi_tests/pi_stress.8 b/src/pi_tests/pi_stress.8
index c3d7889a5cd5..8c43a1ccf676 100644
--- a/src/pi_tests/pi_stress.8
+++ b/src/pi_tests/pi_stress.8
@@ -10,7 +10,7 @@
 pi_stress \- a stress test for POSIX Priority Inheritance mutexes
 .\"}}}
 .\"{{{ Synopsis
-.\" Usage:  pi_stress [-d] [-D TIME] [-g N] [-h] [-i N ] [-m] [-p] [-q] [-r] [-s OPTS] [-u] [-v] [-V]
+.\" Usage:  pi_stress [-d] [-D TIME] [-g N] [-h] [-i N ] [--json FILENAME ] [-m] [-p] [-q] [-r] [-s OPTS] [-u] [-v] [-V]
 .SH SYNOPSIS
 .B pi_stress
 .RB [ \-d|\-\-debug]
@@ -20,6 +20,8 @@ pi_stress \- a stress test for POSIX Priority Inheritance mutexes
 .IR N ]
 .RB [ \-i|\-\-inversions
 .IR INV ]
+.RB [ \-\-json
+.IR FILENAME ]
 .RB [ \-m|\-\-mlockall ]
 .RB [ \-p|\-\-prompt ]
 .RB [ \-q|\-\-quiet ]
@@ -58,6 +60,10 @@ Display a short help message and options.
 .I N
 number of inversion conditions. This is the total number of inversions
 for all inversion groups. Default is \-1 for infinite.
+.IP "\-\-json=FILENAME"
+Write final results into
+.I FILENAME
+, JSON formatted.
 .IP "\-m|\-\-mlockall"
 Call mlockall to lock current and future memory allocations and
 prevent being paged out
-- 
2.31.1

