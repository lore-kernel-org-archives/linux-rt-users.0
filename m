Return-Path: <SRS0=9Yjy=DO=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0272C4727F
	for <linux-rt-users@archiver.kernel.org>; Wed,  7 Oct 2020 08:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E97D20870
	for <linux-rt-users@archiver.kernel.org>; Wed,  7 Oct 2020 08:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbgJGI47 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 7 Oct 2020 04:56:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:57558 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727911AbgJGI46 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 7 Oct 2020 04:56:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 73D7EB13B;
        Wed,  7 Oct 2020 08:56:57 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [rt-tests v2 02/18] cyclictest: Use numa library helpers in get_available_cpus()
Date:   Wed,  7 Oct 2020 10:56:37 +0200
Message-Id: <20201007085653.11961-3-dwagner@suse.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201007085653.11961-1-dwagner@suse.de>
References: <20201007085653.11961-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The numa library has support for counting the bits in the affinity
mask and how many CPUs are available and usable by the tasks. Let's
use those helpers.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/cyclictest/cyclictest.c | 22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 02cb92813fb7..d7477c686435 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -915,26 +915,10 @@ static int clocksources[] = {
  */
 static int get_available_cpus(void)
 {
-	int num_cpus = 0;
-	int res;
-	pthread_t thread;
-	cpu_set_t cpuset;
-
-
-	if (affinity_mask != NULL) {
-		num_cpus = rt_numa_bitmask_count(affinity_mask);
-	} else {
-		CPU_ZERO(&cpuset);
-		thread = pthread_self();
-		res = pthread_getaffinity_np(thread, sizeof(cpu_set_t), &cpuset);
-		if (res != 0) {
-			fatal("pthread_getaffinity_np failed: %s\n", strerror(res));
-		}
-		num_cpus = CPU_COUNT(&cpuset);
-	}
-
-	return num_cpus;
+	if (affinity_mask)
+		return numa_bitmask_weight(affinity_mask);
 
+	return numa_num_task_cpus();
 }
 
 /* cpu_for_thread AFFINITY_SPECIFIED */
-- 
2.28.0

