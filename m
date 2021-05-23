Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E52C4707A
	for <linux-rt-users@archiver.kernel.org>; Sun, 23 May 2021 18:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 624F06128A
	for <linux-rt-users@archiver.kernel.org>; Sun, 23 May 2021 18:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbhEWSlu (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 23 May 2021 14:41:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:60246 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231857AbhEWSlt (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 23 May 2021 14:41:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1621795222; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WFF0GmfXYGHoV9+TW73yRaoG37lYhZqXEdeIcVMzN38=;
        b=IPAmn4BAdpZBU6x4B/jPaBPdYDZHAIlAb0zUPQ/I0cy0/ooj3pigJG04v1nLgRLl3E6lSY
        7Q9P+7zqQv3hN5+GErCfe5uqSUJuv789gqU42h1dWWqUn61u7+vVu9Of5A9nNi6sUc6p40
        ltL+ryLsApUwtuFiSWHiqhqNzAHQLEw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1621795222;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WFF0GmfXYGHoV9+TW73yRaoG37lYhZqXEdeIcVMzN38=;
        b=pecDAC0ue3Aq9yrusr1/lcXPSz561tlkDvHaD8EMT+5/3H/1eE8jINsBFO7WtU1Y47ppKC
        TIg4/pnyQ0si5fAw==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 57C7BAC8B;
        Sun, 23 May 2021 18:40:22 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH rt-tests v1 2/2] cyclicdeadline: Document --debug command line option
Date:   Sun, 23 May 2021 20:40:16 +0200
Message-Id: <20210523184016.32314-3-dwagner@suse.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210523184016.32314-1-dwagner@suse.de>
References: <20210523184016.32314-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Describe what the newly introduced --debug command line is doing.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/sched_deadline/cyclicdeadline.8 | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/src/sched_deadline/cyclicdeadline.8 b/src/sched_deadline/cyclicdeadline.8
index 1a56ed028d81..63fe9ebc6657 100644
--- a/src/sched_deadline/cyclicdeadline.8
+++ b/src/sched_deadline/cyclicdeadline.8
@@ -17,7 +17,7 @@ cyclicdeadline \- This program is used to test the deadline scheduler (SCHED_DEA
 .PP
 .SH SYNOPSIS
 .B cyclicdeadline
-.RI "[-a [CPUSET]] [-D TIME] [-h]  [-i INTV] [--json FILENAME] [-s STEP] [-t NUM] [-q]"
+.RI "[-a [CPUSET]] [-D TIME] [--debug] [-h] [-i INTV] [--json FILENAME] [-s STEP] [-t NUM] [-q]"
 .PP
 .SH DESCRIPTION
 .B cyclicdeadline
@@ -32,6 +32,10 @@ Comma / hypen separated list of CPUs to run deadline tasks on
 Specify a length for the test to run
 Append 'm', 'h', or 'd' to specify minutes, hours, or days
 .TP
+.B \-\-debug
+Enable ftrace logging. When enabled cyclicdeadline will log the start
+of every cycle in the ftrace log buffer.
+.TP
 .B \-h \-\-help
 Show this help menu
 .TP
-- 
2.31.1

