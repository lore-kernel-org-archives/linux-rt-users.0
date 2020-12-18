Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B64C4361B
	for <linux-rt-users@archiver.kernel.org>; Fri, 18 Dec 2020 16:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E56572071E
	for <linux-rt-users@archiver.kernel.org>; Fri, 18 Dec 2020 16:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731526AbgLRQUz (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 18 Dec 2020 11:20:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:38182 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731482AbgLRQUz (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 18 Dec 2020 11:20:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 32E52AE46;
        Fri, 18 Dec 2020 16:19:03 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [rt-tests v2 v2 17/20] rt-numa: Use CPU_SETSIZE as upper loop limit
Date:   Fri, 18 Dec 2020 17:18:40 +0100
Message-Id: <20201218161843.1764-18-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201218161843.1764-1-dwagner@suse.de>
References: <20201218161843.1764-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The cpeset might not be dense, so user the CPU_SETSIZE as upper limit.

Reviewed-by: Daniel Wagner <dwagner@suse.de>
---
 src/lib/rt-numa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/lib/rt-numa.c b/src/lib/rt-numa.c
index 3a8441d5151c..45d4f1193d5f 100644
--- a/src/lib/rt-numa.c
+++ b/src/lib/rt-numa.c
@@ -60,7 +60,7 @@ static int cpu_for_thread_ua(int thread_num, int max_cpus)
 	num_cpus = CPU_COUNT(&cpuset);
 	m = thread_num % num_cpus;
 
-	for (i = 0, cpu = 0; i < max_cpus; i++) {
+	for (i = 0, cpu = 0; i < CPU_SETSIZE; i++) {
 		if (CPU_ISSET(i, &cpuset)) {
 			if (cpu == m)
 				return i;
-- 
2.29.2

