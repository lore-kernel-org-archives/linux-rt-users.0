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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BF1C433FE
	for <linux-rt-users@archiver.kernel.org>; Sun,  5 Sep 2021 14:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A87AB60F92
	for <linux-rt-users@archiver.kernel.org>; Sun,  5 Sep 2021 14:36:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236037AbhIEOhc (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 5 Sep 2021 10:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235968AbhIEOh3 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 5 Sep 2021 10:37:29 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A58C061757;
        Sun,  5 Sep 2021 07:36:26 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 8so4051447pga.7;
        Sun, 05 Sep 2021 07:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4DXvdN5Je/o6na7RsjQfMKd0MSHmdj3a0FLf0NHnXF4=;
        b=lXNmfUcFH9Oq/SfU45zZcu6vIYtCp1x2eE4PX+2ldK3SypTLbZ2bpgD/NyHn9uu7TR
         hG4TNzcl1KxSoB/p63ZTNDVYriOd8YAvynND4Pmi3LMb9FP9Oxvj/uN8IxIDdEcZxNno
         U818Oxt5El5L7Q837RHJ6PUjeCIDoOS5tqilUA/Tfs0RtcWQ3+W0MZGxq0PNKhk1EOBx
         HAIyoc/meMiS8bRcm+y0OjA8LTWic1YXClWw1TnF5Qk3hWIrzDrWZ5x8GX7YbL6MWQ6J
         gF+1GJ7ZflX4w2C34qXb8Dqs8cqQMhSv3tG8AoB56KVYZqIisJ+uzE+8WmqjNhX1eHfi
         k8Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4DXvdN5Je/o6na7RsjQfMKd0MSHmdj3a0FLf0NHnXF4=;
        b=n5LxjlkEzAltf61Qmdev4qCDoCvYFwNZ6yUzpqtVKm9j7p9SWDvcIZEY0v1J1tyg1D
         +pXyHwNBBY/YsJzafrYOqSa+ZCQP8QO9RdraK39J0aJqA1hJui/bhlH4wf9a5N4U78n+
         ApoU0g/W2MC5ROfBxa8mAx2X530qG+vn6ktRVSzpopOZVVHvYwhd7zeXxD+HOx5pwWL9
         hAOJh1y+81AZeU+x+rb4R3U/PC1fjW62RRl0QOtC7D5mFM8GhjbMNWmKgTQY/jGzp452
         iMwnKrrkEnmIZMceq+HpFBzarvhSBoX6WmYYJFxb5BB0D+ZeXU+odIaNajPzHGTSzh1B
         sO8A==
X-Gm-Message-State: AOAM532PdI9zZWoTn/oSaL0vCWp9PUatqACFGHrv1Z+UhvF8n205CDg+
        0XG0uu6j+ij3MXIl7AEgimc=
X-Google-Smtp-Source: ABdhPJyb5Odr1iVwOEDTPqdg0dibTA5Q1dFra1kYfUopkWO020UaywGrobOYS9eTTXmk3mB0W83LUg==
X-Received: by 2002:aa7:8b07:0:b029:3c7:c29f:9822 with SMTP id f7-20020aa78b070000b02903c7c29f9822mr7878850pfd.33.1630852585996;
        Sun, 05 Sep 2021 07:36:25 -0700 (PDT)
Received: from localhost.localdomain ([141.164.38.246])
        by smtp.gmail.com with ESMTPSA id n185sm5186883pfn.171.2021.09.05.07.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 07:36:25 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     peterz@infradead.org, mingo@redhat.com, mgorman@suse.de,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        achaiken@aurora.tech, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v4 5/8] sched, rt: support sched_stat_runtime tracepoint for RT sched class
Date:   Sun,  5 Sep 2021 14:35:44 +0000
Message-Id: <20210905143547.4668-6-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210905143547.4668-1-laoar.shao@gmail.com>
References: <20210905143547.4668-1-laoar.shao@gmail.com>
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

