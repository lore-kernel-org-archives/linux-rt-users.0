Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F6D9C56202
	for <linux-rt-users@archiver.kernel.org>; Mon, 23 Nov 2020 13:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 320762074B
	for <linux-rt-users@archiver.kernel.org>; Mon, 23 Nov 2020 13:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JwCbmYUF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387920AbgKWNAO (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 23 Nov 2020 08:00:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388089AbgKWM7Q (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 23 Nov 2020 07:59:16 -0500
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E1EC0613CF;
        Mon, 23 Nov 2020 04:59:12 -0800 (PST)
Received: by mail-ua1-x942.google.com with SMTP id 103so2302487uai.9;
        Mon, 23 Nov 2020 04:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UBZC3oh3zblyjdeIOfJKrQPEZerRPY4V37fF8XKdWfQ=;
        b=JwCbmYUFZndqE5USltdqIcZR9zNfa8+6CuI03mxaIoxcLjyCTu964vbGfoegJKs1VN
         wSfPrAPDzEVYh03a7QIeNq/cWbZlPyrVecPFb8mDtaL2Dm7gynRR48tI2dyygVm5GJPf
         du1ErgNAmjaVySrZqKmW/qdxDXr0pJBrphTCcU41gEM25uMNuGnv8JayQjyCYCkVj/r2
         0tYi8vSAUQCLz4AL9hnjUHIqdopPXtlVtBThyEW9PwpLB7To90fEwUu6nyEJWYUJTyus
         U9v5xq92HiKR6jY6ROitdq6/flzc7JvOLu48L3sQmkToGpt4LvHp5Ie15+mnbOjHri1C
         xYmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UBZC3oh3zblyjdeIOfJKrQPEZerRPY4V37fF8XKdWfQ=;
        b=GGGjYPLKuTpBr/l/9VuyaQ4BmHGiJ5zKQpj4g8UgM9yLi6FogU1gYPnkFvMRd6MswJ
         n6NROJeFlIJH4MK2HRwQHj+gRZGClCnsqjaP4d+vUoWbfSq0fAZLE8ZATCkHhk59+64b
         SAfOmfRTO5pi8LSDr/v6xqrmp5v+JKtlpGg3/xvC0bSNBhvNFQEJzfOCWbRKYOG2vjdc
         VB+EHTJwXcLh8uAWIL7l9HP/jkoBM9nH3etXPjQxfQVLqyUfQyGCfW5ZnPFCSoHCEtBf
         NdVkjUCEumh1XA6ORC+b0meTT6/P2hi52o3v/v/wT2Qrd7IXHjPNhx0GcrsgK/2c3A0c
         Fe4w==
X-Gm-Message-State: AOAM531TkBw3R2nBx2RzCYs+3Rt+b1Z0BNZaKJz1Vwus3o+y/G8t9FAf
        G6YSQ1QmiTURqKxo6bHHB5M=
X-Google-Smtp-Source: ABdhPJwaGlM1ICdvxT9KuqDKe/uYK4qIZcNRFjfT3f5ZT7V2/r0NdsMBoN6dS7VNuhuuVkmff1RvOQ==
X-Received: by 2002:ab0:35c8:: with SMTP id x8mr736382uat.72.1606136351324;
        Mon, 23 Nov 2020 04:59:11 -0800 (PST)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id h16sm1579091uaw.7.2020.11.23.04.59.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 04:59:10 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     mgorman@suse.de, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH v2 4/5] sched: define update_stats_curr_start() as a common helper
Date:   Mon, 23 Nov 2020 20:58:07 +0800
Message-Id: <20201123125808.50896-5-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20201123125808.50896-1-laoar.shao@gmail.com>
References: <20201123125808.50896-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

update_stats_curr_start() is used to update the exec_start when we are
starting a new run period, which is used by all sched class. So we'd
better define it as a common helper.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/sched/fair.c  | 14 +-------------
 kernel/sched/rt.c    |  2 +-
 kernel/sched/sched.h | 12 ++++++++++++
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 946b60f586e4..13e803369ced 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -915,18 +915,6 @@ update_stats_dequeue(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	}
 }
 
-/*
- * We are picking a new current task - update its stats:
- */
-static inline void
-update_stats_curr_start(struct cfs_rq *cfs_rq, struct sched_entity *se)
-{
-	/*
-	 * We are starting a new run period:
-	 */
-	se->exec_start = rq_clock_task(rq_of(cfs_rq));
-}
-
 /**************************************************
  * Scheduling class queueing methods:
  */
@@ -4255,7 +4243,7 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 		update_load_avg(cfs_rq, se, UPDATE_TG);
 	}
 
-	update_stats_curr_start(cfs_rq, se);
+	update_stats_curr_start(rq_of(cfs_rq), se);
 	cfs_rq->curr = se;
 
 	/*
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index af772ac0f32d..3422dd85cfb4 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1574,7 +1574,7 @@ static void check_preempt_curr_rt(struct rq *rq, struct task_struct *p, int flag
 
 static inline void set_next_task_rt(struct rq *rq, struct task_struct *p, bool first)
 {
-	p->se.exec_start = rq_clock_task(rq);
+	update_stats_curr_start(rq, &p->se);
 
 	/* The running task is never eligible for pushing */
 	dequeue_pushable_task(rq, p);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 9a4576ccf3d7..3948112dc31c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2644,4 +2644,16 @@ static inline struct task_struct *task_of(struct sched_entity *se)
 	return container_of(se, struct task_struct, se);
 }
 
+/*
+ * We are picking a new current task - update its stats:
+ */
+static inline void
+update_stats_curr_start(struct rq *rq, struct sched_entity *se)
+{
+	/*
+	 * We are starting a new run period:
+	 */
+	se->exec_start = rq_clock_task(rq);
+}
+
 #endif	/* _KERNEL_SCHED_SCHED_H */
-- 
2.18.4

