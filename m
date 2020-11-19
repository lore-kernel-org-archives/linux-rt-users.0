Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC683C63798
	for <linux-rt-users@archiver.kernel.org>; Thu, 19 Nov 2020 03:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 846B524695
	for <linux-rt-users@archiver.kernel.org>; Thu, 19 Nov 2020 03:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0ReMKTo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbgKSDxH (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 18 Nov 2020 22:53:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgKSDxH (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 18 Nov 2020 22:53:07 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6C4C0613D4;
        Wed, 18 Nov 2020 19:53:06 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id k26so4884440oiw.0;
        Wed, 18 Nov 2020 19:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RgAZCYgWQCuFW/9DIwlFl5IqDJZfBWxgnHLdBXoornA=;
        b=T0ReMKToei1r/iXA3CWx9NJ8WmBDtwHRQZYl+9QcFIG2cep007zgjNoTBAfU2Iukkc
         DqpsfkaIfGA67sdGoAJjnP+HNf6i1Ubkl4cwexsQCbT02tEvsRNOBnMOae6LJE/SZBtt
         l5oRZjQW0BK/rxy6MRQXBeqR9SSauKEbYcfgqMzdFhNvhKfe6rbWdl3TAjNtFkkTHGlT
         cXOwrLTCaPt3EFaFXbRoi98kMyAJCn6QAgVFkPCwyMGeMUjxhOWQRTqFayJQuVYe7Bv1
         6SD+LhNVJ+hQl8FvJ6nVz8QwwOil3amG2aXuRsYYSU6elQ3gBHX3ZHaSdMW/EJjhZd6r
         ejYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RgAZCYgWQCuFW/9DIwlFl5IqDJZfBWxgnHLdBXoornA=;
        b=f0Nw0NA1+PD/mNzl/MQrVzTmTiK4omIx5UPq83sib5lsDMuJp1p6IX+L2JOVPedflH
         FxThpnHupEHR/Al7v5SMcqsJPQHtNBM3X4FcH/7v0bvEFVnDuCOG1DYHunJo19AifkRy
         k6nERPEtBWbSvpp0OykXGcHBg7HhX6OPSWcgFkgC8DK3fftZmvhU9RdV9S4TfPzFPO6J
         ylGcU0t9eMGXwlR8F6UCrGbrq3k0vBPAogqwR0MILEUzkIcC4u4kbTscgZ6jZ1en+d8Q
         qFmxr707MPyiL8wK22hGOUXNnJMIK1zqm0sEIcuXDqe+qe6rHVesmO/EDfYINutBaXLg
         Yz4A==
X-Gm-Message-State: AOAM532uVp3gPhY2gE4U7eRiJMLS+TrOXK5sNf1Pb9dL6U//ZIjOf14X
        MymwkKCNfRWx/hTuE7JXWCQ=
X-Google-Smtp-Source: ABdhPJzk61hbC4zlVhBNZjenNSBLJRyjOix/+OWliqcr1wHIscFm6nqg3IdDYTf7RcCziyraG+Iu/Q==
X-Received: by 2002:a54:4681:: with SMTP id k1mr1657017oic.121.1605757986354;
        Wed, 18 Nov 2020 19:53:06 -0800 (PST)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id k20sm8320926ots.53.2020.11.18.19.53.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Nov 2020 19:53:05 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH 1/4] sched: define task_of() as a common helper
Date:   Thu, 19 Nov 2020 11:52:27 +0800
Message-Id: <20201119035230.45330-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20201119035230.45330-1-laoar.shao@gmail.com>
References: <20201119035230.45330-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

task_of() is used to get task_struct from sched_entity. As sched_entity
in struct task_struct can be used by all sched class, we'd better move
this macro into sched.h, then it can be used by all sched class.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/sched/fair.c  | 11 -----------
 kernel/sched/sched.h |  9 +++++++++
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8917d2d715ef..9d73e8e5ebec 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -258,12 +258,6 @@ const struct sched_class fair_sched_class;
  */
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
-static inline struct task_struct *task_of(struct sched_entity *se)
-{
-	SCHED_WARN_ON(!entity_is_task(se));
-	return container_of(se, struct task_struct, se);
-}
-
 /* Walk up scheduling entities hierarchy */
 #define for_each_sched_entity(se) \
 		for (; se; se = se->parent)
@@ -445,11 +439,6 @@ find_matching_se(struct sched_entity **se, struct sched_entity **pse)
 
 #else	/* !CONFIG_FAIR_GROUP_SCHED */
 
-static inline struct task_struct *task_of(struct sched_entity *se)
-{
-	return container_of(se, struct task_struct, se);
-}
-
 #define for_each_sched_entity(se) \
 		for (; se; se = NULL)
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index df80bfcea92e..e29f2375c4f5 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2633,3 +2633,12 @@ static inline bool is_per_cpu_kthread(struct task_struct *p)
 
 void swake_up_all_locked(struct swait_queue_head *q);
 void __prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait);
+
+static inline struct task_struct *task_of(struct sched_entity *se)
+{
+#ifdef CONFIG_FAIR_GROUP_SCHED
+	SCHED_WARN_ON(!entity_is_task(se));
+#endif
+	return container_of(se, struct task_struct, se);
+}
+
-- 
2.18.4

