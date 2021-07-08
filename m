Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB895C07E99
	for <linux-rt-users@archiver.kernel.org>; Thu,  8 Jul 2021 15:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2FA6613D1
	for <linux-rt-users@archiver.kernel.org>; Thu,  8 Jul 2021 15:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbhGHPVO (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 8 Jul 2021 11:21:14 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:43338 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbhGHPVN (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 8 Jul 2021 11:21:13 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1B88821D1A;
        Thu,  8 Jul 2021 15:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1625757511; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PJALGm/UJuYtsiLT5DCOXNqTowrtTlQ1muuYP/2gBMM=;
        b=1Dw+pJAdZNbbag7QayBqP1tmN+86qmtq+RE1L798a2hkwdsmagg3pVSFHVXCI0uqmjQQY3
        FyIH5SSARs2zlMpvlsCAZ0Kn3K0o/mtmDvejQFZnoiDgfapZMemATlH0pap2wciNtYnCro
        l+EVvMdB933MqW9s/8QgGN3GpQlmDNg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1625757511;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PJALGm/UJuYtsiLT5DCOXNqTowrtTlQ1muuYP/2gBMM=;
        b=IfYACxh1JiG0CXNUreJ9zXUsKy2tJECKHm/sqmmcl1eB44kP1EY01YcH3rbUBJ9lo52W6z
        h/Dlm2AmMpS8hYAQ==
Received: from localhost (unknown [10.163.25.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id F121FA3B8D;
        Thu,  8 Jul 2021 15:18:30 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH rt-tests v2 1/3] rt-numa: Use sched_getaffinity() instead of pthread_getaffinity_np()
Date:   Thu,  8 Jul 2021 17:18:25 +0200
Message-Id: <20210708151827.21430-2-dwagner@suse.de>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210708151827.21430-1-dwagner@suse.de>
References: <20210708151827.21430-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

pthread_getaffinity_np() prevents static builds as glibc does not
expose it for this configuration. Instead use sched_getaffinity()
which is always present and has the exact same semantics.

Fixes: f240656b056b ("rt-tests: cyclictest: Fix -t without a user specified [NUM]")

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/lib/rt-numa.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/src/lib/rt-numa.c b/src/lib/rt-numa.c
index babcc634d57e..bb0121a65eca 100644
--- a/src/lib/rt-numa.c
+++ b/src/lib/rt-numa.c
@@ -68,15 +68,13 @@ int cpu_for_thread_sp(int thread_num, int max_cpus, struct bitmask *cpumask)
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
-		fatal("pthread_getaffinity_np failed: %s\n", strerror(res));
+		fatal("sched_getaffinity failed: %s\n", strerror(res));
 
 	num_cpus = CPU_COUNT(&cpuset);
 	m = thread_num % num_cpus;
-- 
2.32.0

