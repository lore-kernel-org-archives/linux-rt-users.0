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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B0CC4338F
	for <linux-rt-users@archiver.kernel.org>; Tue, 24 Aug 2021 11:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B72961373
	for <linux-rt-users@archiver.kernel.org>; Tue, 24 Aug 2021 11:30:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236681AbhHXLas (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 24 Aug 2021 07:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236614AbhHXLaq (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 24 Aug 2021 07:30:46 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A351BC061757;
        Tue, 24 Aug 2021 04:29:59 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id 2so4025037pfo.8;
        Tue, 24 Aug 2021 04:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JVr8PGszwG12RQLxsTfg9itjnLUTmikBGfspTpaerwM=;
        b=ZDZBH2mSLT+feJJpheykz9SuYyO5rGEd8xjPms8ZJXHWR7UNVDo6OrcCv6/ZZJbR6v
         LrCo4oy2tfRuKERpq5jszz44yJEx6I00vvNAxPd1AT6nBE0V0C1iA5KJ/8thCrUYnsCS
         041S9U/TAG31QccfiPJChN6WbA+DsTyfwPoeP1I1/C71hW2b31StShyBit/D+bDTWmen
         1JOKBV/6QWT3pWDsG3oxVbjstkaRsAjpsrB/Aq1GW0PzTmlIZJ16TAlpRHTOwjKk1wlo
         Qs1yjj0DnMQ45kI/FhidW03DGkx7UojtDQhFckrJr8rW1Bkl6sQFlOJTZo4Oyhk+G9OV
         XmJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JVr8PGszwG12RQLxsTfg9itjnLUTmikBGfspTpaerwM=;
        b=Mun1T59gC1owNqiNRDJ3xc/3lxDOr2bedN8wMYY9M49PCTQOyvGOVTBUbajlc+wSvk
         ZxQZR89N5zltlTUw81B/Drio4X5wCOzSe6rBELFtzB0g7kB0SaDBVz4ijzKrsZsIcRqw
         ec+XX5Wg8nHwBQgTHNYL65zDz7YJcq6whmlx6ZrNhq7Fh5l7z5oplYqnF7OdPlpIiI/n
         lyYhn45aIf8ioyDAZpV5k+MwlZB0W+qG7RVdkgPYsi8kunkS6BHs48MibTaBEqiFva6K
         0khB/XK6fCEBW2p/Ozjiz7QTJbU+HWUMU3GELvZtwWR376dSXkXo84jtZswHvMymqsMv
         Fsrw==
X-Gm-Message-State: AOAM532p8cLMIwjd3UYt+qfkmUC0an7OgV7evmSrqgHGQKBwGxlSEcR3
        4w70FGTZludfEOFTuAzWHKw=
X-Google-Smtp-Source: ABdhPJxLUEzIuAMnwdG2zQjfjy3YxnU+T74jFM8L65lCKMs6eTvFCNINd2kll67RMj14dV2SKj62jw==
X-Received: by 2002:a62:1888:0:b029:3c9:7957:519b with SMTP id 130-20020a6218880000b02903c97957519bmr38551885pfy.17.1629804599244;
        Tue, 24 Aug 2021 04:29:59 -0700 (PDT)
Received: from localhost.localdomain ([45.77.24.247])
        by smtp.gmail.com with ESMTPSA id on15sm2128732pjb.19.2021.08.24.04.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 04:29:58 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org, mgorman@suse.de,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, achaiken@aurora.tech
Cc:     lkp@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v3 1/7] sched, fair: use __schedstat_set() in set_next_entity()
Date:   Tue, 24 Aug 2021 11:29:40 +0000
Message-Id: <20210824112946.9324-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210824112946.9324-1-laoar.shao@gmail.com>
References: <20210824112946.9324-1-laoar.shao@gmail.com>
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
index 5aa3cfd15a2e..422426768b84 100644
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

