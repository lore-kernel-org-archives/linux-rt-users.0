Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32757C43618
	for <linux-rt-users@archiver.kernel.org>; Wed, 19 May 2021 17:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D57C611AB
	for <linux-rt-users@archiver.kernel.org>; Wed, 19 May 2021 17:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355556AbhESRLS (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 19 May 2021 13:11:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:43958 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355504AbhESRLQ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 19 May 2021 13:11:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 314A4B1C9;
        Wed, 19 May 2021 17:09:56 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH rt-tests v1 14/23] oslat: Add --json to man page
Date:   Wed, 19 May 2021 19:09:36 +0200
Message-Id: <20210519170945.21941-15-dwagner@suse.de>
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
 src/oslat/oslat.8 | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/src/oslat/oslat.8 b/src/oslat/oslat.8
index b481d8d82783..4b28abd24425 100644
--- a/src/oslat/oslat.8
+++ b/src/oslat/oslat.8
@@ -5,8 +5,9 @@ oslat \- OS Latency Detector
 .SH SYNOPSIS
 .SY oslat
 .RI "[ \-shvz ] [ \-b " bucket-size " ] [ \-B " bias " ] [ \-c " cpu-list " ] \
-[ \-C " cpu-main-thread " ] [ \-f " rt-prio " ] [ \-m " workload-mem " ] \
-[\-t " runtime " ] [ \-T " trace-threshold " ] [ \-w " workload " ]"
+[ \-C " cpu-main-thread " ] [ \-f " rt-prio " ] [ \-\-json " filename " ] \
+[ \-m " workload-mem " ] [\-t " runtime " ] [ \-T " trace-threshold " ] \
+[ \-w " workload " ]"
 .SH DESCRIPTION
 .B oslat
 is an open source userspace polling mode stress program to detect OS level
@@ -30,6 +31,9 @@ Specify which CPU the main thread runs on.  Default is cpu0.
 Using specific SCHED_FIFO priority (1-99).  Otherwise use the default
 priority, normally it will be SCHED_OTHER.
 .TP
+.B \-\-json=FILENAME
+Write final results into FILENAME, JSON formatted.
+.TP
 .B \-m, \-\-workload-mem=SIZE
 Size of the memory to use for the workload (e.g., 4K, 1M).
 Total memory usage will be this value multiplies 2*N,
-- 
2.31.1

