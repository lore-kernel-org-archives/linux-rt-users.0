Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F03DC61DB3
	for <linux-rt-users@archiver.kernel.org>; Thu, 12 Jan 2023 10:03:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235845AbjALKDI (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 12 Jan 2023 05:03:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236568AbjALKBG (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 12 Jan 2023 05:01:06 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57145CD6
        for <linux-rt-users@vger.kernel.org>; Thu, 12 Jan 2023 02:00:53 -0800 (PST)
Date:   Thu, 12 Jan 2023 11:00:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673517651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=SIo5RR9Xb6qN9+3Y21sXIWWdQ+Gin+ug73sGChYsu4A=;
        b=lbGOGug7eTpOuDADxyxcfT83zgoKtirnthsDdBogiUcXERpPDOiioP/Gu5Qf5GADO3d95e
        S+8j+MC3/5lEYgLJlHfybo5xQFJGJLULTJulZF0HbbAeDCXwc6yf5gY0kSoRLXGQ5SwVOZ
        lDb0wIjP32etADIe65f0OWBG93seBMUkFxIU3fnEicnbCzLhXmHDvy5Tf1HceI13s2XG2q
        9nmLgdrKXwBm/h4SNdgRDEQSoSWscVMwMby2RtX40BHajmOam+hhDtNTxfbG80a9Fw62Uz
        qOvnCjB70BVRrg0gYiZtF2d9u9uOzHvlFGJsXOU8R9fQOM2dyRZpoEYGQQTvMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673517651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=SIo5RR9Xb6qN9+3Y21sXIWWdQ+Gin+ug73sGChYsu4A=;
        b=KKBVK7d0szqEEmxsZYzXXh48IszKzy368BKFBvIIORxDV6mj7YhB3jxgoI11FCzUyY/hf+
        I6oLfrcLS1oL7kCQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     John Kacur <jkacur@redhat.com>
Cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: [PATCH] rt-numa: Use a reasonable default max CPU value.
Message-ID: <Y7/aS/dW0H0CK8Oe@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

numa_num_task_cpus() returns here > 100 CPUs while the system has only
32 populated. The BIOS assumes that I can probably use larger CPUs (with
more cores) on the socket so the number of "configured CPUs" is rather
high.
For default configuration, only with the -S option, it makes sense to
use the current affinity instead looking at the number of possible CPUs
which could be brought online. It still depends on the affinity of the
created threads if the additional CPUs can be used. In a container setup
this may not be the case.

Use sched_getaffinity() to figure out the number of possible CPUs.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 src/lib/rt-numa.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/src/lib/rt-numa.c b/src/lib/rt-numa.c
index 3eead80c3b2b3..1b09cff8d9485 100644
--- a/src/lib/rt-numa.c
+++ b/src/lib/rt-numa.c
@@ -35,10 +35,19 @@ int numa_initialize(void)
 
 int get_available_cpus(struct bitmask *cpumask)
 {
+	cpu_set_t cpuset;
+	int ret;
+
 	if (cpumask)
 		return numa_bitmask_weight(cpumask);
 
-	return numa_num_task_cpus();
+	CPU_ZERO(&cpuset);
+
+	ret = sched_getaffinity(0, sizeof(cpu_set_t), &cpuset);
+	if (ret < 0)
+		fatal("sched_getaffinity failed: %m\n");
+
+	return CPU_COUNT(&cpuset);
 }
 
 int cpu_for_thread_sp(int thread_num, int max_cpus, struct bitmask *cpumask)
-- 
2.39.0
