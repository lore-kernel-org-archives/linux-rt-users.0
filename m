Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B28C07E95
	for <linux-rt-users@archiver.kernel.org>; Sun,  4 Jul 2021 20:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DD7F613D8
	for <linux-rt-users@archiver.kernel.org>; Sun,  4 Jul 2021 20:36:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbhGDUjN (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 4 Jul 2021 16:39:13 -0400
Received: from mail.monom.org ([188.138.9.77]:39748 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229731AbhGDUjG (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 4 Jul 2021 16:39:06 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id D8445500665;
        Sun,  4 Jul 2021 22:36:28 +0200 (CEST)
Received: from localhost (unknown [94.31.98.41])
        by mail.monom.org (Postfix) with ESMTPSA id 80896500609;
        Sun,  4 Jul 2021 22:36:28 +0200 (CEST)
From:   Daniel Wagner <wagi@monom.org>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH rt-tests v1 1/3] rt-numa: Use sched_getaffinity() instead of pthread_getaffinity_np()
Date:   Sun,  4 Jul 2021 22:36:19 +0200
Message-Id: <20210704203621.5612-2-wagi@monom.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210704203621.5612-1-wagi@monom.org>
References: <20210704203621.5612-1-wagi@monom.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Daniel Wagner <dwagner@suse.de>

pthread_getaffinity_np() prevents static builds as glibc does not
expose it for this configuration. Instead use sched_getaffinity()
which is always present and has the exact same semantics.

Fixes: f240656b056b ("rt-tests: cyclictest: Fix -t without a user specified [NUM]")

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/lib/rt-numa.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/src/lib/rt-numa.c b/src/lib/rt-numa.c
index babcc634d57e..2d34ae36cc03 100644
--- a/src/lib/rt-numa.c
+++ b/src/lib/rt-numa.c
@@ -68,13 +68,11 @@ int cpu_for_thread_sp(int thread_num, int max_cpus, struct bitmask *cpumask)
 int cpu_for_thread_ua(int thread_num, int max_cpus)
 {
 	int res, num_cpus, i, m, cpu;
-	pthread_t thread;
 	cpu_set_t cpuset;
 
-	thread = pthread_self();
 	CPU_ZERO(&cpuset);
 
-	res = pthread_getaffinity_np(thread, sizeof(cpu_set_t), &cpuset);
+	res = sched_getaffinity(0, sizeof(cpu_set_t), &cpuset);
 	if (res != 0)
 		fatal("pthread_getaffinity_np failed: %s\n", strerror(res));
 
-- 
2.32.0
