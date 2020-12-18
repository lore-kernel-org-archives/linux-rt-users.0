Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A94EC2BBD5
	for <linux-rt-users@archiver.kernel.org>; Fri, 18 Dec 2020 16:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3296023B6C
	for <linux-rt-users@archiver.kernel.org>; Fri, 18 Dec 2020 16:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731467AbgLRQUR (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 18 Dec 2020 11:20:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:37398 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731141AbgLRQUO (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 18 Dec 2020 11:20:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7D1E5AE2B;
        Fri, 18 Dec 2020 16:19:01 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [rt-tests v2 v2 12/20] rt-numa: Use mask size for iterator limit
Date:   Fri, 18 Dec 2020 17:18:35 +0100
Message-Id: <20201218161843.1764-13-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201218161843.1764-1-dwagner@suse.de>
References: <20201218161843.1764-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The bitmask structure knows its size use, thus use it as upper limit
in the loop.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/lib/rt-numa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/lib/rt-numa.c b/src/lib/rt-numa.c
index a246dbca7291..1918f93b74eb 100644
--- a/src/lib/rt-numa.c
+++ b/src/lib/rt-numa.c
@@ -33,7 +33,7 @@ static int cpu_for_thread_sp(int thread_num, int max_cpus, struct bitmask *cpuma
 	m = thread_num % num_cpus;
 
 	/* there are num_cpus bits set, we want position of m'th one */
-	for (i = 0, cpu = 0; i < max_cpus; i++) {
+	for (i = 0, cpu = 0; i < cpumask->size; i++) {
 		if (numa_bitmask_isbitset(cpumask, i)) {
 			if (cpu == m)
 				return i;
@@ -97,7 +97,7 @@ static void use_current_cpuset(int max_cpus, struct bitmask *cpumask)
 	 * Clear bits that are not set in both the cpuset from the
 	 * environment, and in the user specified affinity.
 	 */
-	for (i = 0; i < max_cpus; i++) {
+	for (i = 0; i < cpumask->size; i++) {
 		if ((!numa_bitmask_isbitset(cpumask, i)) ||
 		    (!numa_bitmask_isbitset(curmask, i)))
 			numa_bitmask_clearbit(cpumask, i);
-- 
2.29.2

