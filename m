Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA6E0C433E6
	for <linux-rt-users@archiver.kernel.org>; Mon, 15 Mar 2021 19:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFD3D64F4C
	for <linux-rt-users@archiver.kernel.org>; Mon, 15 Mar 2021 19:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233696AbhCOTh3 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 15 Mar 2021 15:37:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60871 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233690AbhCOThN (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 15 Mar 2021 15:37:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615837032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=a0qTL4wKZvmuXjxoHom8o5M+xxEaDKCOYhKra3NAchs=;
        b=ffOX3ofyBYGIfJZHcs0+r52OhQYvK87xTeansu1JbLUnYIr864UXCNNbwXN5KvOnGMUoO9
        P2xBy0u44rwec5T0MwipLobbFqa0G3RRiDQcnFiByGH2sNnOHz72GCqCubKGLej3lBf2TK
        jhXFHmGO8yCWd4wuzHroDlBUpjgob4E=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-r1iKHi9kNA6UglkRKtr2rg-1; Mon, 15 Mar 2021 15:37:11 -0400
X-MC-Unique: r1iKHi9kNA6UglkRKtr2rg-1
Received: by mail-qt1-f197.google.com with SMTP id p10so4448914qtq.12
        for <linux-rt-users@vger.kernel.org>; Mon, 15 Mar 2021 12:37:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a0qTL4wKZvmuXjxoHom8o5M+xxEaDKCOYhKra3NAchs=;
        b=fFrxncKwYkaSNojuV6aO15m3VoDy2VkHBk7dtbuu14CCTzGafzHjMllNYtlE9x0hdH
         79nBte0iiW3Hm6ZXYz8GYsrdpoI5cHodjsOLqO3yX+h2u6C5T3/hRCigkIIu5FXhJZrH
         4K89rKTzL5af0aCASvDQPG3SUKWw7rEoALBU2OH31y3WUWuEdg/ysU9lbHeK1p9uHVlT
         lDce3xDch1kNQKZGEmZL8gux0XbvtLVBVrYkzrBQcrknQ6kbjLLWKUnK703PNXrvxoyK
         HjQMQIN/K/zgHavRK4Oobdx/tJyUpkRhU/6aEQ6DRJCiJa88kBC3w47iEzTVCNLFt5ok
         2x3A==
X-Gm-Message-State: AOAM531E4xPS9cKHpB2B5O78mLvuF+eA4m+nm8xQ4ZROkGZ0GKjEXnIm
        X/oFl/DkgI6V6JCpoVVNkln0MSqLYxQ0OEji4S7KuBi4XHLpX1/CiRzO6EY4ASXmanafw56dIpj
        VU3reLloZos843xc5Q4U+L7gBq9fynsK+uYA3rPk3ZdzFny0fBmDtvERbA5MTj46ct9qya3iudg
        OB
X-Received: by 2002:a05:6214:1c47:: with SMTP id if7mr12580738qvb.50.1615837030369;
        Mon, 15 Mar 2021 12:37:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzxE9bQcTFPzE4C96l8D+FadlQWf6lYzT9apFb5TrCvQrbt0Rv/WdYLAoNzzHTIL11m1/CBFA==
X-Received: by 2002:a05:6214:1c47:: with SMTP id if7mr12580709qvb.50.1615837030008;
        Mon, 15 Mar 2021 12:37:10 -0700 (PDT)
Received: from xz-x1.redhat.com ([142.126.89.138])
        by smtp.gmail.com with ESMTPSA id g7sm11952985qti.20.2021.03.15.12.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 12:37:09 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     John Kacur <jkacur@redhat.com>, peterx@redhat.com,
        Clark Williams <williams@redhat.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH] rt-tests: Drop use_current_cpuset() check
Date:   Mon, 15 Mar 2021 15:37:07 -0400
Message-Id: <20210315193707.359702-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

CPU list should allow to be any list rather than only the cores that are
allowed to schedule for the current process.

Before this patch, cyclictest will fail with below condition:

$ taskset -pc $$
pid 2316's current affinity list: 0,2,4,6,8
$ sudo cyclictest -m -N -p 1 -a 1,3,5,7 -t 4
WARN: Couldn't setaffinity in main thread: Invalid argument

After this patch, it'll be allowed to run.

Cc: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 src/lib/rt-numa.c | 27 ---------------------------
 1 file changed, 27 deletions(-)

diff --git a/src/lib/rt-numa.c b/src/lib/rt-numa.c
index babcc63..f581020 100644
--- a/src/lib/rt-numa.c
+++ b/src/lib/rt-numa.c
@@ -93,32 +93,6 @@ int cpu_for_thread_ua(int thread_num, int max_cpus)
 	return 0;
 }
 
-/*
- * After this function is called, affinity_mask is the intersection of
- * the user supplied affinity mask and the affinity mask from the run
- * time environment
- */
-static void use_current_cpuset(int max_cpus, struct bitmask *cpumask)
-{
-	struct bitmask *curmask;
-	int i;
-
-	curmask = numa_allocate_cpumask();
-	numa_sched_getaffinity(getpid(), curmask);
-
-	/*
-	 * Clear bits that are not set in both the cpuset from the
-	 * environment, and in the user specified affinity.
-	 */
-	for (i = 0; i < max_cpus; i++) {
-		if ((!numa_bitmask_isbitset(cpumask, i)) ||
-		    (!numa_bitmask_isbitset(curmask, i)))
-			numa_bitmask_clearbit(cpumask, i);
-	}
-
-	numa_bitmask_free(curmask);
-}
-
 int parse_cpumask(char *str, int max_cpus, struct bitmask **cpumask)
 {
 	struct bitmask *mask;
@@ -133,7 +107,6 @@ int parse_cpumask(char *str, int max_cpus, struct bitmask **cpumask)
 		return 0;
 	}
 
-	use_current_cpuset(max_cpus, mask);
 	*cpumask = mask;
 
 	return 0;
-- 
2.26.2

