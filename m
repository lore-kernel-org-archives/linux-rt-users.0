Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE03C433E6
	for <linux-rt-users@archiver.kernel.org>; Wed, 10 Feb 2021 16:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C48464E7C
	for <linux-rt-users@archiver.kernel.org>; Wed, 10 Feb 2021 16:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbhBJQ4k (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 10 Feb 2021 11:56:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:45272 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233311AbhBJQyu (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 10 Feb 2021 11:54:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3CB18AF2C;
        Wed, 10 Feb 2021 16:54:10 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>,
        Peter Xu <peterx@redhat.com>
Subject: [PATCH rt-tests 2/2] oslat: Use cpuset size as upper bound
Date:   Wed, 10 Feb 2021 17:54:07 +0100
Message-Id: <20210210165407.9770-3-dwagner@suse.de>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210210165407.9770-1-dwagner@suse.de>
References: <20210210165407.9770-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

To assign the threads to the correct CPU we need to use the cpuset
size as upper bound for the loop and not the number of threads.

Fixes: 85b0763dacd9 ("oslat: Use parse_cpumask() from rt-numa.h")
Reported-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/oslat/oslat.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
index d3f659b218b0..62b82098419a 100644
--- a/src/oslat/oslat.c
+++ b/src/oslat/oslat.c
@@ -742,9 +742,12 @@ int main(int argc, char *argv[])
 	n_cores = numa_bitmask_weight(cpu_set);
 
 	TEST(threads = calloc(1, n_cores * sizeof(threads[0])));
-	for (i = 0; i < n_cores; ++i)
-		if (numa_bitmask_isbitset(cpu_set, i) && move_to_core(i) == 0)
+	for (i = 0; n_cores && i < cpu_set->size; i++) {
+		if (numa_bitmask_isbitset(cpu_set, i) && move_to_core(i) == 0) {
 			threads[g.n_threads_total++].core_i = i;
+			n_cores--;
+		}
+	}
 
 	if (numa_bitmask_isbitset(cpu_set, 0) && g.rtprio)
 		printf("WARNING: Running SCHED_FIFO workload on CPU 0 may hang the thread\n");
-- 
2.30.0

