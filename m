Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FD6C4361A
	for <linux-rt-users@archiver.kernel.org>; Wed, 19 May 2021 17:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97B0E611BD
	for <linux-rt-users@archiver.kernel.org>; Wed, 19 May 2021 17:10:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355459AbhESRLV (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 19 May 2021 13:11:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:43958 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355551AbhESRLS (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 19 May 2021 13:11:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E88D4B1E6;
        Wed, 19 May 2021 17:09:57 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH rt-tests v1 20/23] signaltest: Add --json to man page
Date:   Wed, 19 May 2021 19:09:42 +0200
Message-Id: <20210519170945.21941-21-dwagner@suse.de>
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
 src/signaltest/signaltest.8 | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/signaltest/signaltest.8 b/src/signaltest/signaltest.8
index 5ce119b54461..da818ecdef67 100644
--- a/src/signaltest/signaltest.8
+++ b/src/signaltest/signaltest.8
@@ -5,7 +5,7 @@
 signaltest \- signal roundtrip test software
 .SH SYNOPSIS
 .LP
-signaltest [ -a|--affinity NUM] [ -b|--backtrace USEC ] [-D|--duration TIME] [-h|--help] [-l|--loops LOOPS ] [-p|--prio PRIO] [-q|--quiet] [-S|--smp] [-t|--threads NUM] [-m|--mlockall ] [-v|--verbose ]
+signaltest [ -a|--affinity NUM] [ -b|--backtrace USEC ] [-D|--duration TIME] [-h|--help] [--json FILENAME] [-l|--loops LOOPS ] [-p|--prio PRIO] [-q|--quiet] [-S|--smp] [-t|--threads NUM] [-m|--mlockall ] [-v|--verbose ]
 .SH OPTIONS
 These programs follow the usual GNU command line syntax, with long options
 starting with two dashes ('\-\-').
@@ -35,6 +35,9 @@ Append 'm', 'h', or 'd' to specify minutes, hours or days.
 .br
 display usage information
 .TP
+.B \-\-json=FILENAME
+Write final results into FILENAME, JSON formatted.
+.TP
 .B \-l, \-\-loops=LOOPS
 Number of loops: default=0 (endless)
 .TP
-- 
2.31.1

