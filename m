Return-Path: <SRS0=EtfJ=BR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6684C433E0
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 Aug 2020 09:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B46B82177B
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 Aug 2020 09:51:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ccII5+/Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbgHGJvg (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 7 Aug 2020 05:51:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46125 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727820AbgHGJvf (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 7 Aug 2020 05:51:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596793892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z8tgJTs+X+8vEZKUl5jq8+JAws3cxDj6P8K3XwwrUrQ=;
        b=ccII5+/Za3BwGxsRqqUMJVeGj8lLrijfSF9+VgxgsRGyQRaDZkotKa6pB9GwgnqoXLb6/A
        3LNgTAAo0HVC5UXOONvy0otPaNEdRJbCTSll89aVixeeyyvb8D2geVliXSc6Zn2rmccAuM
        h//O5c28n1C49arfmBLiOJ06aFlY7qI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-C29s-3rNOPCiTuVjJ9zamA-1; Fri, 07 Aug 2020 05:51:31 -0400
X-MC-Unique: C29s-3rNOPCiTuVjJ9zamA-1
Received: by mail-wr1-f71.google.com with SMTP id b13so535322wrq.19
        for <linux-rt-users@vger.kernel.org>; Fri, 07 Aug 2020 02:51:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z8tgJTs+X+8vEZKUl5jq8+JAws3cxDj6P8K3XwwrUrQ=;
        b=bXDjtq5E+Hfs2QY5gV5HKYr5OZ3bIM6oZL+c6M/xkbzFy6U0mBxkEu57RBaNvTqeDQ
         n/lgT+Kh/4NlEhDjdgaDiF4t3nZdofLkhGc2DxihBqbhREQU2UeFLMx5d6Wq9U1/N0WV
         zAjYkGT9nomMpNsliWHFYEnIKwjHprxaK0M1FhUTYQzGbNdjBJpEuV0YdalPvV6tbXTv
         8SjaNeBe3TkfrU1kB21L2DQmsEg63ArVelQwCUF99GcOsUjzqtDWzC4rG52raEbXwbFA
         mP2QCZ0VOF1C3E2E3kuV0GKHUuOZJ8ZvEb6B6KxEwmd+b4TjPj0gMJ2hD4C5VgKuIWfP
         RIcg==
X-Gm-Message-State: AOAM532HbDIFD53VoML8RYp2AEygxQeMKRgdoMD9WH8igP/Q65f7lIfL
        bOhEvZnnNmLczPsv1vXTVy3WxY9VQpByLS+WxBWwWYzzlcoiHvmU+bMa0mY5tft42UBJXABSVFG
        xuXtoWURqG0FcbajXEYujvqmMmNI=
X-Received: by 2002:a05:6000:12c1:: with SMTP id l1mr10782164wrx.270.1596793888628;
        Fri, 07 Aug 2020 02:51:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzoF/IgfG/wrZaT1KmhKuf9rOoHeqn6nVwIPqkddHT7tcqpp9p7N0WOqR+WS+JPz4qdSbwJ7A==
X-Received: by 2002:a05:6000:12c1:: with SMTP id l1mr10782157wrx.270.1596793888413;
        Fri, 07 Aug 2020 02:51:28 -0700 (PDT)
Received: from localhost.localdomain.com ([151.29.36.84])
        by smtp.gmail.com with ESMTPSA id h14sm9388396wml.30.2020.08.07.02.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 02:51:27 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     peterz@infradead.org, mingo@redhat.com
Cc:     rostedt@goodmis.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        tommaso.cucinotta@santannapisa.it, alessio.balsini@gmail.com,
        bristot@redhat.com, dietmar.eggemann@arm.com,
        linux-rt-users@vger.kernel.org, mtosatti@redhat.com,
        williams@redhat.com, valentin.schneider@arm.com
Subject: [RFC PATCH v2 5/6] sched/fair: Add trivial fair server
Date:   Fri,  7 Aug 2020 11:50:50 +0200
Message-Id: <20200807095051.385985-6-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200807095051.385985-1-juri.lelli@redhat.com>
References: <20200807095051.385985-1-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Use deadline servers to service fair tasks.

This patch adds a fair_server deadline entity which acts as a container
for fair entities and can be used to fix starvation when higher priority
(wrt fair) tasks are monopolizing CPU(s).

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c  |  1 +
 kernel/sched/fair.c  | 29 +++++++++++++++++++++++++++++
 kernel/sched/sched.h |  4 ++++
 3 files changed, 34 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7c471961fd0b8..6537637139c63 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7170,6 +7170,7 @@ void __init sched_init(void)
 #endif /* CONFIG_SMP */
 		hrtick_rq_init(rq);
 		atomic_set(&rq->nr_iowait, 0);
+		fair_server_init(rq);
 	}
 
 	set_load_weight(&init_task, false);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5130239c0e1e5..6a97ee2a4e26d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5514,6 +5514,9 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	 */
 	util_est_enqueue(&rq->cfs, p);
 
+	if (!rq->cfs.h_nr_running)
+		dl_server_start(&rq->fair_server);
+
 	/*
 	 * If in_iowait is set, the code below may not trigger any cpufreq
 	 * utilization updates, so do it here explicitly with the IOWAIT flag
@@ -5666,6 +5669,9 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		rq->next_balance = jiffies;
 
 dequeue_throttle:
+	if (!rq->cfs.h_nr_running)
+		dl_server_stop(&rq->fair_server);
+
 	util_est_dequeue(&rq->cfs, p, task_sleep);
 	hrtick_update(rq);
 }
@@ -7151,6 +7157,29 @@ static struct task_struct *__pick_next_task_fair(struct rq *rq)
 	return pick_next_task_fair(rq, NULL, NULL);
 }
 
+static bool fair_server_has_tasks(struct sched_dl_entity *dl_se)
+{
+	return !!dl_se->rq->cfs.nr_running;
+}
+
+static struct task_struct *fair_server_pick(struct sched_dl_entity *dl_se)
+{
+	return pick_next_task_fair(dl_se->rq, NULL, NULL);
+}
+
+void fair_server_init(struct rq *rq)
+{
+	struct sched_dl_entity *dl_se = &rq->fair_server;
+
+	init_dl_entity(dl_se);
+
+	dl_se->dl_runtime = TICK_NSEC;
+	dl_se->dl_deadline = 20 * TICK_NSEC;
+	dl_se->dl_period = 20 * TICK_NSEC;
+
+	dl_server_init(dl_se, rq, fair_server_has_tasks, fair_server_pick);
+}
+
 /*
  * Account for a descheduled task:
  */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index f035cd8ccd224..bf8c9c07705c9 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -375,6 +375,8 @@ extern void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
 		    dl_server_has_tasks_f has_tasks,
 		    dl_server_pick_f pick);
 
+extern void fair_server_init(struct rq *);
+
 #ifdef CONFIG_CGROUP_SCHED
 
 #include <linux/cgroup.h>
@@ -959,6 +961,8 @@ struct rq {
 	struct rt_rq		rt;
 	struct dl_rq		dl;
 
+	struct sched_dl_entity	fair_server;
+
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	/* list of leaf cfs_rq on this CPU: */
 	struct list_head	leaf_cfs_rq_list;
-- 
2.26.2

