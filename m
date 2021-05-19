Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F20C433B4
	for <linux-rt-users@archiver.kernel.org>; Wed, 19 May 2021 17:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71B6E611AB
	for <linux-rt-users@archiver.kernel.org>; Wed, 19 May 2021 17:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355531AbhESRLW (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 19 May 2021 13:11:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:43976 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355555AbhESRLS (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 19 May 2021 13:11:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3EDCBB1F0;
        Wed, 19 May 2021 17:09:58 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH rt-tests v1 21/23] sigwaittest: Add --json to man page
Date:   Wed, 19 May 2021 19:09:43 +0200
Message-Id: <20210519170945.21941-22-dwagner@suse.de>
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
 src/sigwaittest/sigwaittest.8 | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/sigwaittest/sigwaittest.8 b/src/sigwaittest/sigwaittest.8
index a2dc1bc080a3..26ad333e2841 100644
--- a/src/sigwaittest/sigwaittest.8
+++ b/src/sigwaittest/sigwaittest.8
@@ -4,7 +4,7 @@
 \fBsigwaittest\fR \- Start two threads or fork two processes and measure the latency between sending and receiving a signal
 .SH "SYNTAX"
 .LP
-sigwaittest [-a|--affinity PROC] [-b|--breaktrace USEC] [-d|--distance DIST] [-D|--duration TIME] [-f|--fork [OPT]] [-i|--interval INTV] [-l|--loops LOOPS] [-p|--prio PRIO] [-t|--threads [NUM]]
+sigwaittest [-a|--affinity PROC] [-b|--breaktrace USEC] [-d|--distance DIST] [-D|--duration TIME] [-f|--fork [OPT]] [-i|--interval INTV] [--json FILENAME] [-l|--loops LOOPS] [-p|--prio PRIO] [-t|--threads [NUM]]
 .br
 .SH "DESCRIPTION"
 .LP
@@ -32,6 +32,9 @@ Instead of creating threads (which is the default), fork new processes
 .B \-i, \-\-interval=INTV
 Set the base interval of the thread(s) in microseconds (default is 1000 us). This sets the interval of the first thread. See also -d.
 .TP
+.B \-\-json=FILENAME
+Write final results into FILENAME, JSON formatted.
+.TP
 .B \-l, \-\-loops=LOOPS
 Set the number of loops. The default is 0 (endless). This option is useful for automated tests with a given number of test cycles. sigwaittest is stopped once the number of timer intervals has been reached.
 .TP
-- 
2.31.1

