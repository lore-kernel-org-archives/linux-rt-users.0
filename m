Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF1BC2D0E4
	for <linux-rt-users@archiver.kernel.org>; Mon, 23 Nov 2020 13:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F229E206D9
	for <linux-rt-users@archiver.kernel.org>; Mon, 23 Nov 2020 13:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bug4jrxX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387686AbgKWM7E (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 23 Nov 2020 07:59:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387943AbgKWM6y (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 23 Nov 2020 07:58:54 -0500
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E9BC0613CF;
        Mon, 23 Nov 2020 04:58:53 -0800 (PST)
Received: by mail-vs1-xe41.google.com with SMTP id l22so9056259vsa.4;
        Mon, 23 Nov 2020 04:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y+SeRwvHbZQftOnFfRGkqQkmiVtK8RsTFsZN5mRi71k=;
        b=bug4jrxXcKK+FNJJGQ4a2+cGlNoFaTOm7GdIo0tVMuBvURaXmlvTpLBF+N7IRKLhDM
         pJG/jgrfh4xqWctEZO+bHNQTf/v1/r4gT8Y54P8ZyBRF4PjFSoC7Nr1Y6JGI6xapoPZz
         Q3OKMdkP3jf4l4rGVZNXKFUdS5pXM7Kt93LFcfZh0pbmzIaI/HuD/E6xzS41JF9mKpEC
         FDItjmkiDiOEGFipUCTwYzx5Zt5DrpTkUxpsCPTaDyWk9jlCy0YNGMJdnRAtkUOX9Bvq
         +VMyC1guOsy9+oyS6zqHAWKX+Ci+jFv4mPaY4gSyyklT2eTqmqhU2RKXkxE0mDfc8UeP
         t+wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y+SeRwvHbZQftOnFfRGkqQkmiVtK8RsTFsZN5mRi71k=;
        b=fLFXppsVZTk2EdwCitcEvVrScEL6jl0M4819fzT4epslNKDFjWNC5MZ9AcnpXgloe3
         5DdB0lR+leiQwHxiYZ2IdjsUGTl7+D+tU7JUpvjV6yUiCCBJV/OASGGDNvGTpC9zSEmE
         t/+HmfyCUHZ1CtjyWGPPVm8GEVHQ9Z8gnrscRob7R8ce30g0XegfaewP8vsXxPwvXQb5
         pV+k5OhAadDuo483GklilRmWlSN5GOPMZbwC71sAh3DOXC+GP1rXlz+wQnEVSG86McIH
         YK4/cupT/gr3qeytz81a5/oOiKADA83aQmZr9DeDwz2+3uj4ivTEEdvcMsz4AjqNBxcP
         Qetw==
X-Gm-Message-State: AOAM530Fluo4s6psWLXx94od2W4d4N03hlC4pD70dftsYr3fiIGlKK8a
        J3wh6DBOxO8JEtsD5WgU1o8=
X-Google-Smtp-Source: ABdhPJwld1WxIvhgSezkaptPnBHHyHsrQH1Ysg6VfbIUQDlE6vb+1LllKovZ47hgq5X2/KXdUyoHZA==
X-Received: by 2002:a67:f587:: with SMTP id i7mr18542248vso.46.1606136333068;
        Mon, 23 Nov 2020 04:58:53 -0800 (PST)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id h16sm1579091uaw.7.2020.11.23.04.58.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 04:58:52 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     mgorman@suse.de, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH v2 2/5] sched: define task_of() as a common helper
Date:   Mon, 23 Nov 2020 20:58:05 +0800
Message-Id: <20201123125808.50896-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20201123125808.50896-1-laoar.shao@gmail.com>
References: <20201123125808.50896-1-laoar.shao@gmail.com>
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
 kernel/sched/sched.h |  8 ++++++++
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8ff1daa3d9bb..59e454cae3be 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -259,12 +259,6 @@ const struct sched_class fair_sched_class;
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
@@ -446,11 +440,6 @@ find_matching_se(struct sched_entity **se, struct sched_entity **pse)
 
 #else	/* !CONFIG_FAIR_GROUP_SCHED */
 
-static inline struct task_struct *task_of(struct sched_entity *se)
-{
-	return container_of(se, struct task_struct, se);
-}
-
 #define for_each_sched_entity(se) \
 		for (; se; se = NULL)
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 871544bb9a38..9a4576ccf3d7 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2636,4 +2636,12 @@ static inline bool is_per_cpu_kthread(struct task_struct *p)
 void swake_up_all_locked(struct swait_queue_head *q);
 void __prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait);
 
+static inline struct task_struct *task_of(struct sched_entity *se)
+{
+#ifdef CONFIG_FAIR_GROUP_SCHED
+	SCHED_WARN_ON(!entity_is_task(se));
+#endif
+	return container_of(se, struct task_struct, se);
+}
+
 #endif	/* _KERNEL_SCHED_SCHED_H */
-- 
2.18.4

