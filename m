Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15EDDC636CB
	for <linux-rt-users@archiver.kernel.org>; Mon, 19 Jul 2021 09:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F005B6115B
	for <linux-rt-users@archiver.kernel.org>; Mon, 19 Jul 2021 09:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235265AbhGSItu (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 19 Jul 2021 04:49:50 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:47482 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234970AbhGSItt (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 19 Jul 2021 04:49:49 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 54D75221CB;
        Mon, 19 Jul 2021 08:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1626682508; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JC8Wy50U7d+I8U5FcB9k5ZEzRH+PDWhCYjSoGHbU1b4=;
        b=abXADw7oyMWxsp3C0zpof46XoCnwuNoRZoBl5sBjQrkWttwed023jeTC/nEW8cXsUhJ9Ds
        GdS2pOJ/8EDATPas0y7kABf+sHR00ZEoXQn0Dyo5Pg6JA9S7PohFYDOnyKgiHNPwiIC1nm
        Fe+rIXPXj7gzKvyXYU/5cEwgFQ/Yn9w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1626682508;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JC8Wy50U7d+I8U5FcB9k5ZEzRH+PDWhCYjSoGHbU1b4=;
        b=Yq/HfqolC4t3USJDgoU/cbLUnYLhdeJUGQ+fGegR7M2xHEu1tdfI0ZTjRqBGrQtGnrQtdk
        OXEL3dbEhAMZHrBA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 44B8B133D0;
        Mon, 19 Jul 2021 08:15:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 4UZkEIw09WDYCgAAGKfGzw
        (envelope-from <dwagner@suse.de>); Mon, 19 Jul 2021 08:15:08 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH rt-tests v3 1/1] rt-numa: Use sched_getaffinity() instead of pthread_getaffinity_np()
Date:   Mon, 19 Jul 2021 10:15:05 +0200
Message-Id: <20210719081505.520-2-dwagner@suse.de>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210719081505.520-1-dwagner@suse.de>
References: <20210719081505.520-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

pthread_getaffinity_np() prevents static builds as glibc does not
expose it for this configuration. Instead use sched_getaffinity()
directly as pthread_getaffinity_np() is just a fancy glibc wrapper
around sched_getaffinity().

Static builds helps in in situation where the rootfs is minimal
and does for example not ship libnuma.

The pthread_getaffinity_np call was introduced by commit
f240656b056b ("rt-tests: cyclictest: Fix -t without a user specified
[NUM]")

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

