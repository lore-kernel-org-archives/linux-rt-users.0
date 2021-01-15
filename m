Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F576C433E6
	for <linux-rt-users@archiver.kernel.org>; Fri, 15 Jan 2021 19:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 274BF221E2
	for <linux-rt-users@archiver.kernel.org>; Fri, 15 Jan 2021 19:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387584AbhAOTLC (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 15 Jan 2021 14:11:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:43862 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733265AbhAOTLC (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 15 Jan 2021 14:11:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EDFE6AEAC;
        Fri, 15 Jan 2021 19:09:41 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [RFC v3 09/19] cyclicdeadline: Remove unused members in struct thread_stat
Date:   Fri, 15 Jan 2021 20:09:26 +0100
Message-Id: <20210115190936.26148-10-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210115190936.26148-1-dwagner@suse.de>
References: <20210115190936.26148-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Remove all unused members in struct thread_stat.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/sched_deadline/cyclicdeadline.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
index 71cde5781499..77ee8c8e25c7 100644
--- a/src/sched_deadline/cyclicdeadline.c
+++ b/src/sched_deadline/cyclicdeadline.c
@@ -56,16 +56,10 @@ struct thread_stat {
 	long act;
 	double avg;
 	long *values;
-	long *hist_array;
-	long *outliers;
 	pthread_t thread;
-	int threadstarted;
 	int tid;
-	long reduce;
 	long redmax;
 	long cycleofmax;
-	long hist_overflow;
-	long num_outliers;
 };
 
 struct sched_data {
-- 
2.29.2

