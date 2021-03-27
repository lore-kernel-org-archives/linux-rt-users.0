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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38468C433C1
	for <linux-rt-users@archiver.kernel.org>; Sat, 27 Mar 2021 10:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F1DA6196C
	for <linux-rt-users@archiver.kernel.org>; Sat, 27 Mar 2021 10:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbhC0KNz (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 27 Mar 2021 06:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbhC0KNy (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 27 Mar 2021 06:13:54 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43601C0613B1;
        Sat, 27 Mar 2021 03:13:54 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id m7so5997353qtq.11;
        Sat, 27 Mar 2021 03:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G86tcLX3l7UjqtR50Okie22jmAR/cxDIvpk0BESbCS0=;
        b=VUylPIJa/NwBKm5zQuqiiRMKpohI1ZOo3C5JtXqyvv5J412lIvPMmYZCQRW4mjJnnn
         nPhvpKISCmEBQThTkLgJ5uWKTHYWIx8PoGEYb3sT0XQxEnX0efLFCJdqwIOPkZ3h502y
         lwv7zeuLkVAaDtYru6jp7gH0UOtGSF8L3p4Cbwicb3PCUStDw1516uwNFdnsSwFc/9ha
         r41F+xsbW/7SMrqdDKIxnqzxvWVvMaaJF+hJpbDBnCimicIJICxBCueVcFsJM6QnIGr8
         0wY6CiHcVVKay81Nebva486YJSb0mR4BfjXzTygdhMWvHw3GcqFFUWKF33ktbJHW2Q7F
         oL1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G86tcLX3l7UjqtR50Okie22jmAR/cxDIvpk0BESbCS0=;
        b=fZH00SGBMpngFeJR4xsmvrag1urrVLntzQWZp5yHxGFwlV2bP8vie4HpKNpbEm0qu2
         1BCrM9/Qt1kSRzXequ5eczMayHoR2nvW7aBDbTb5a/6VWd7Rqn7yAZgjgQnnj1TkKBSw
         gXCMQlPDYhJ3kTRrcUBNcEy0Q7nkJ/LZONDo3fkUrP+rNYSsAiVBdl6i6Nf5U2Oe85sj
         KQ69SX7clRnxatQsl4rvoRLQPsttc/+4PgICmNBvEL1h4f3umUZ760Vok1//7FLns1a5
         mQWFWY3cGA7RwN+BaXPoW9Im6E3+915KdfoWB67F9QvouBDVNsB0I+nBKHd4H7wN9zKq
         UfWQ==
X-Gm-Message-State: AOAM533BsXnTdZsP7DYmBSGS95Fh/7KFImneRjRqQ5EJ9HSA7s2NfkGq
        RmHrEfcT8uPEDPEI1L/GFu4=
X-Google-Smtp-Source: ABdhPJwm54iyVl4mCxVhU4DxuioxZ0HiUOWRvIDILtgQMft2XrLxmmoBCbGFbtuATtJYP7dgKAFn8w==
X-Received: by 2002:ac8:431e:: with SMTP id z30mr15178854qtm.216.1616840032842;
        Sat, 27 Mar 2021 03:13:52 -0700 (PDT)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id d14sm7404053qtr.55.2021.03.27.03.13.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Mar 2021 03:13:52 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     mgorman@suse.de, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v2 1/6] sched, fair: use __schedstat_set() in set_next_entity()
Date:   Sat, 27 Mar 2021 18:12:48 +0800
Message-Id: <20210327101254.56872-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210327101254.56872-1-laoar.shao@gmail.com>
References: <20210327101254.56872-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

schedstat_enabled() has been already checked, so we can use
__schedstat_set() directly.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Mel Gorman <mgorman@suse.de>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index aaa0dfa29d53..114eec730698 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4429,7 +4429,7 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
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

