Return-Path: <SRS0=BA5Y=SK=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C5D8C10F14
	for <linux-rt-users@archiver.kernel.org>; Mon,  8 Apr 2019 19:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00675218FC
	for <linux-rt-users@archiver.kernel.org>; Mon,  8 Apr 2019 19:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554750867;
	bh=RO8g8Bkeg0OX5k3pLgVOkyGX79APyegOKZFWbogP8zc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=Op2kFGb7ABcpkiIT3GI5F84UHBc7QY08wvh/Thz9IPkIcwDJ0oMqHvVMGkMz8/D1X
	 BTACY9mI3c5olUXFaqWvmF+GDr+5m7KuzbKMqG3ZaCyKsmWXhnEyOZuJYPnx7PCVht
	 ubmLrnQw+7UfeYfCzq520xfB6cvPMn0PZ6pJ6bVs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfDHTOZ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 8 Apr 2019 15:14:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:45136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726898AbfDHTOY (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 8 Apr 2019 15:14:24 -0400
Received: from tzanussi-mobl.hsd1.il.comcast.net (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06F8D20880;
        Mon,  8 Apr 2019 19:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554750863;
        bh=RO8g8Bkeg0OX5k3pLgVOkyGX79APyegOKZFWbogP8zc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=t7VtfGXOdT19BX8oMFyk/CuT4pBP+Q7nkrmZkDH83vi4eOs9BKRH3nE6oT+qRSulx
         sebh5Gm7c0Fd0h54XpD9OlS9z4nVAh20jETVrnrlw6L51fne3yP5/bOJ5QwsosmorM
         6OI3lVT730TV2f9iXH2pZYgVRu+BIhLdA1ojSD1M=
From:   Tom Zanussi <zanussi@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Cc:     rostedt@goodmis.org, tglx@linutronix.de, C.Emde@osadl.org,
        jkacur@redhat.com, bigeasy@linutronix.de,
        daniel.wagner@siemens.com, julia@ni.com, amartin@nvidia.com
Subject: [PATCH 03/13] sched/fair: Make the hrtimers non-hard again
Date:   Mon,  8 Apr 2019 14:14:05 -0500
Message-Id: <5916f8123c2cac32790a91414b17e1b9d6dbf7bf.1554737688.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1554737688.git.tom.zanussi@linux.intel.com>
References: <cover.1554737688.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1554737688.git.tom.zanussi@linux.intel.com>
References: <cover.1554737688.git.tom.zanussi@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

4.14.109-rt58-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit 73d5c2697339118cd33dc1ff1ffcb21d59cafe1a ]

Since commit "sched/fair: Robustify CFS-bandwidth timer locking" both
hrtimer can run in softirq context because now interrupts are disabled
as part of the locking procedure.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 46403e462404..7d2a8fa9a6ed 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4704,9 +4704,9 @@ void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
 	cfs_b->period = ns_to_ktime(default_cfs_period());
 
 	INIT_LIST_HEAD(&cfs_b->throttled_cfs_rq);
-	hrtimer_init(&cfs_b->period_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED_HARD);
+	hrtimer_init(&cfs_b->period_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED);
 	cfs_b->period_timer.function = sched_cfs_period_timer;
-	hrtimer_init(&cfs_b->slack_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
+	hrtimer_init(&cfs_b->slack_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	cfs_b->slack_timer.function = sched_cfs_slack_timer;
 	cfs_b->distribute_running = 0;
 }
-- 
2.14.1

