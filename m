Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E72C433DB
	for <linux-rt-users@archiver.kernel.org>; Wed, 10 Feb 2021 13:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DD7D64E16
	for <linux-rt-users@archiver.kernel.org>; Wed, 10 Feb 2021 13:36:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbhBJNgh (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 10 Feb 2021 08:36:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:50476 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231438AbhBJNgT (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 10 Feb 2021 08:36:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 363BCB009;
        Wed, 10 Feb 2021 13:34:57 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH rt-tests v4 08/16] rt-numa: Use mask size for iterator limit
Date:   Wed, 10 Feb 2021 14:34:42 +0100
Message-Id: <20210210133450.6991-9-dwagner@suse.de>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210210133450.6991-1-dwagner@suse.de>
References: <20210210133450.6991-1-dwagner@suse.de>
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
index 7e99eab60681..b1bbb8c8052c 100644
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
2.30.0

