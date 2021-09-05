Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AEFEC433F5
	for <linux-rt-users@archiver.kernel.org>; Sun,  5 Sep 2021 14:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72C6C600D0
	for <linux-rt-users@archiver.kernel.org>; Sun,  5 Sep 2021 14:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234859AbhIEOhO (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 5 Sep 2021 10:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233908AbhIEOhN (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 5 Sep 2021 10:37:13 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9AEFC061575;
        Sun,  5 Sep 2021 07:36:10 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 8so4051063pga.7;
        Sun, 05 Sep 2021 07:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5QrSQxP5jUcv60OLK9iTQu26ROLgapGunPMgJUevpeY=;
        b=RrNPksAAUhfNIqIivBW05dCf+n+41aCGjIcRDnJyBzShjMh3rUXyYe8x8rkrJU+3nh
         dn+MMI1/VvOnI/T6SXoLO5xsdFqnOiSMMZu9BciKd+PEwEgY8VUYYMqYyotRN0+MUvqA
         DgyPYdlPIJ1DQPWAkxrUyG/gl6avfnX9e9xOFmzIvDN7g2vJijnLpdwIKo0ad4rTDWoC
         PoMQo1Yp87ZpcJERxAwp+9vgq1ttUxJ6Sr03qlrRVc/Le1NPOfh2MilS+wGq4Qzekx1Z
         1ys1GwJ39xKzftx/xO4sFfYyq5ZTGciqUcI9HyAjwJaPG0KYBaJc++ZsPRNeSRMstkex
         VoqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5QrSQxP5jUcv60OLK9iTQu26ROLgapGunPMgJUevpeY=;
        b=U/73xwc7t5rgB/GwEBFqY/lVvGlWvM50L3mvf8wtJUJEwsWaGFNAoSKmazZtT7BRMc
         Ez+WE1n1Nc8PWVL7rdpzS0IBsHlgiv6+y6ID1wHboaE8a33y1l9tmfLzQKtbzTF8ayJB
         3mRkM4jElpgUuGthXQGZi/7aMFkIjM9micPJzamBR6nJzdcNtKQKxrI9FyHzlbDqTCEq
         o+bFwCPzY03K9iT/Ldm4+3uBBB9dwZgcwI+I9ITySgBXK6SR6Vn+d0G6wzZ+2MKHxGEQ
         LcyjSIMB9N5y4soWqGgYqICeN3ZZqEc0yCr25I6DwTHSLw/5VtY0viy0mxrGrom7aD5A
         RWmg==
X-Gm-Message-State: AOAM530ruZFFPS6HQHxRzNRtkZKPdqhuHIsOoNBuqVXfpw0HiGgUPUX6
        qFVSxGVXSMImu9czZl0OKf4=
X-Google-Smtp-Source: ABdhPJzw2B0xFcphSU3MrDx++aL+RxW06j2wax+tPSOwtQf/0w+ReyIvV/QdlHxf9xdhLfUgXBtQsA==
X-Received: by 2002:a65:63d0:: with SMTP id n16mr7909918pgv.432.1630852570317;
        Sun, 05 Sep 2021 07:36:10 -0700 (PDT)
Received: from localhost.localdomain ([141.164.38.246])
        by smtp.gmail.com with ESMTPSA id n185sm5186883pfn.171.2021.09.05.07.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 07:36:09 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     peterz@infradead.org, mingo@redhat.com, mgorman@suse.de,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        achaiken@aurora.tech, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v4 1/8] sched, fair: use __schedstat_set() in set_next_entity()
Date:   Sun,  5 Sep 2021 14:35:40 +0000
Message-Id: <20210905143547.4668-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210905143547.4668-1-laoar.shao@gmail.com>
References: <20210905143547.4668-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

schedstat_enabled() has been already checked, so we can use
__schedstat_set() directly.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Mel Gorman <mgorman@suse.de>
Cc: Alison Chaiken <achaiken@aurora.tech>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 25f056d87587..1b92eec48745 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4502,7 +4502,7 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	 */
 	if (schedstat_enabled() &&
 	    rq_of(cfs_rq)->cfs.load.weight >= 2*se->load.weight) {
-		schedstat_set(se->statistics.slice_max,
+		__schedstat_set(se->statistics.slice_max,
 			max((u64)schedstat_val(se->statistics.slice_max),
 			    se->sum_exec_runtime - se->prev_sum_exec_runtime));
 	}
-- 
2.18.2

