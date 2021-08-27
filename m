Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C85C4320E
	for <linux-rt-users@archiver.kernel.org>; Fri, 27 Aug 2021 22:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1881D60F91
	for <linux-rt-users@archiver.kernel.org>; Fri, 27 Aug 2021 22:03:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbhH0WD5 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 27 Aug 2021 18:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbhH0WD4 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 27 Aug 2021 18:03:56 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63367C0613D9
        for <linux-rt-users@vger.kernel.org>; Fri, 27 Aug 2021 15:03:07 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id t190so8787155qke.7
        for <linux-rt-users@vger.kernel.org>; Fri, 27 Aug 2021 15:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bFoVu44IFhHLuPe2MW6s1Gf1B4nctORH24CNsqwXQis=;
        b=EpM2wGCUOjRnh3n5WWCp8ijvFUgzcmpJSrJz/nbdHoyoPDUqZoeI6ve9JXPEDtVdUx
         Mss+w/VJHV8N3VLLthZXgGyBXmQmGSCMLPYCJV2LYbZ2rshh5WQtRIqfqhvLxLZCN4uY
         pDJustZSVYR9NpopRvmG9hBd936giZp4Q+T5dGM6TSL1+qkTQedhWmoLGtS5I5GxTEkH
         l987pNMB1lKryFcK+5yht/6g9ftC063Gz29KulxTq/FPsFIDXpjPm1f/LyZtylo6NfKd
         bMUvlFbycLO53Q3PKfLhM1ydWFjKu4fnx/B78gYxnrNTtCkBZuttN3/T7Eh8/fEK8EVv
         nOow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=bFoVu44IFhHLuPe2MW6s1Gf1B4nctORH24CNsqwXQis=;
        b=P3YI1Y6AWUb5IU7jJSvzgpE3xPZNgmEL3ZPFuvWoOknawkJWesJfiUUvLcivD+0Jb5
         5QrC8/2sKRSaLwErSBvk03fFD+fZ7BrbBNgHF1A1ygW3DB4jpqdGpIVqdTBP5TdcKSus
         Mr6RcOCiel18tJJVsFm9qSsLcNFeFe+HdJ1x0sCP1izU8ssEQ4WFyAD/0FiDuAoYbDMP
         PEY9IdyWeSfQC1R9gk5L+74MOug7cO/jACrNtc2nIWyD1aeA2MR2LNOnsGdeNl+eKhs4
         KI5NIzG971AMuSUaUmuGQq34hB/TmbSCF78cBpxk30+2xhqI+0wphxiv8eB+ND5t3oZ3
         +x2Q==
X-Gm-Message-State: AOAM5335o7CD7ryIne25zBwwOEMpUGaKg9Lb/3g9tEfKtMQNggvmA/nq
        Fz9wSXwSuXVzyuqGoX5t5mpvDImyX59IWw==
X-Google-Smtp-Source: ABdhPJznu/deJVeU/77iz2PyvjbrOjtNlkktQWqNA25PJuEzbI1gpqbxfpboktLcHMX9DDojF6eJlw==
X-Received: by 2002:a37:8407:: with SMTP id g7mr11265110qkd.123.1630101786471;
        Fri, 27 Aug 2021 15:03:06 -0700 (PDT)
Received: from localhost.localdomain (bras-base-rdwyon0600w-grc-09-184-147-143-99.dsl.bell.ca. [184.147.143.99])
        by smtp.gmail.com with ESMTPSA id t64sm5659209qkd.71.2021.08.27.15.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 15:03:06 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        Daniel Wagner <dwagner@suse.de>, John Kacur <jkacur@redhat.com>
Subject: [PATCH 8/8] rt-numa: Use sched_getaffinity() instead of pthread_getaffinity_np()
Date:   Fri, 27 Aug 2021 18:02:44 -0400
Message-Id: <20210827220244.24210-9-jkacur@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210827220244.24210-1-jkacur@redhat.com>
References: <20210827220244.24210-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Daniel Wagner <dwagner@suse.de>

pthread_getaffinity_np() prevents static builds as glibc does not
expose it for this configuration. Instead use sched_getaffinity()
directly as pthread_getaffinity_np() is just a fancy glibc wrapper
around sched_getaffinity().

Static builds helps in situation where the rootfs is minimal
and does for example not ship libnuma.

The pthread_getaffinity_np call was introduced by
commit f240656b056b ("rt-tests: cyclictest: Fix -t without a user specified
[NUM]")

Signed-off-by: Daniel Wagner <dwagner@suse.de>
- Some minor fixes to the description
Signed-off-by: John Kacur <jkacur@redhat.com>
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
2.31.1

