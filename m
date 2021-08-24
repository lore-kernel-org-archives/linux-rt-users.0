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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8223FC432BE
	for <linux-rt-users@archiver.kernel.org>; Tue, 24 Aug 2021 11:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6928E613AD
	for <linux-rt-users@archiver.kernel.org>; Tue, 24 Aug 2021 11:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236858AbhHXLbH (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 24 Aug 2021 07:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236900AbhHXLbB (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 24 Aug 2021 07:31:01 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB91C061796;
        Tue, 24 Aug 2021 04:30:16 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id n18so19498459pgm.12;
        Tue, 24 Aug 2021 04:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4DXvdN5Je/o6na7RsjQfMKd0MSHmdj3a0FLf0NHnXF4=;
        b=I7nz3ZSdlWOuLXhdOJF5Rx2EBPYnF9BmEI6gv4sNYvnUeRm2nt4sZK9hzxrP70k2ce
         4/iWIKrJdeE/drPzVX3a95aKmVF6IR7MEJzgTCeVZ5RVlyfFX6EN3I/KFrLjFKiRrWfI
         uGgYPIpbA3yYFrMsmOG3/TuVecfuHxjQCxCy0MsnDCBKxy5r5s8YpBudpYLnexi+t6DB
         f07Acbp+GhXSwZZYwbr6ai93Syc6nDXdQc/uS0Y0bIeg1V8zyGDBLxetYPPy6GbZyZB0
         sHnBphE9U1nECcLG3o/vM1B3jaDcMjAD3WeliGlSydf8HGkmPRmi2Lh6jmcK3gONOKtq
         G8uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4DXvdN5Je/o6na7RsjQfMKd0MSHmdj3a0FLf0NHnXF4=;
        b=kF6nrHUiC32MwQjjhsGMrFg3jf51L1ox1Sob0LN1mTZoalj+aO2bqCJSqdLuvXAVFY
         lAL/tkfYE+qlPv7uvTQS+cmfD4dwnp+kqYmOigEQmLohhlxg0x/1nuMZC16YuFCJT9At
         HtoS0r7sAqxFJb9oFOoLA2m4kR2/s6lRx6j4YouetpFfPKc2d0VCxdajwa5wcmZXB2H3
         2Jj63oa7jTKOqkD0CN4XQNkQ7t7v5VkTS3zT+fUDSl74XZaHUqNtlbnRMvT4xERSrTfw
         yg1KNpb6aYJ9I0TOiaig+9oKyX26U0RbBPjEADaWDGMhOLibalnsWRiQ3f1i7K7iJiP2
         eIsA==
X-Gm-Message-State: AOAM530wIlzJFnRsYSDbolq3WQe1tqb/p3pcm5jmxm9hwNOAZ7/iTi4m
        ReznOrKpBtPfaeAxLpsAXL0=
X-Google-Smtp-Source: ABdhPJyzzTBIL+jiF5xnCWqZrkKm1d6RGJcuN/f5Irydngr6YM57xdtPP4wUqconoQ5HUErbXT0KOA==
X-Received: by 2002:a65:5a89:: with SMTP id c9mr36569268pgt.274.1629804616302;
        Tue, 24 Aug 2021 04:30:16 -0700 (PDT)
Received: from localhost.localdomain ([45.77.24.247])
        by smtp.gmail.com with ESMTPSA id on15sm2128732pjb.19.2021.08.24.04.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 04:30:15 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org, mgorman@suse.de,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, achaiken@aurora.tech
Cc:     lkp@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v3 6/7] sched, rt: support sched_stat_runtime tracepoint for RT sched class
Date:   Tue, 24 Aug 2021 11:29:45 +0000
Message-Id: <20210824112946.9324-7-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210824112946.9324-1-laoar.shao@gmail.com>
References: <20210824112946.9324-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The runtime of a RT task has already been there, so we only need to
add a tracepoint.

One difference between fair task and RT task is that there is no vruntime
in RT task. To reuse the sched_stat_runtime tracepoint, '0' is passed as
vruntime for RT task.

The output of this tracepoint for RT task as follows,
          stress-9748    [039] d.h.   113.519352: sched_stat_runtime: comm=stress pid=9748 runtime=997573 [ns] vruntime=0 [ns]
          stress-9748    [039] d.h.   113.520352: sched_stat_runtime: comm=stress pid=9748 runtime=997627 [ns] vruntime=0 [ns]
          stress-9748    [039] d.h.   113.521352: sched_stat_runtime: comm=stress pid=9748 runtime=998203 [ns] vruntime=0 [ns]

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Alison Chaiken <achaiken@aurora.tech>
---
 kernel/sched/rt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 95a7c3ad2dc3..5d251112e51c 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1012,6 +1012,8 @@ static void update_curr_rt(struct rq *rq)
 	schedstat_set(curr->stats.exec_max,
 		      max(curr->stats.exec_max, delta_exec));
 
+	trace_sched_stat_runtime(curr, delta_exec, 0);
+
 	curr->se.sum_exec_runtime += delta_exec;
 	account_group_exec_runtime(curr, delta_exec);
 
-- 
2.18.2

