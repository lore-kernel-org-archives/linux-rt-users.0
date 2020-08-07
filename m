Return-Path: <SRS0=EtfJ=BR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B60C433E3
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 Aug 2020 09:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3EE42177B
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 Aug 2020 09:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jIXlkLlw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbgHGJva (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 7 Aug 2020 05:51:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36045 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728216AbgHGJv1 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 7 Aug 2020 05:51:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596793885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zjAjRBZqRUxOSD09O8un2EvyPI/eihDhik4FjIAp3oQ=;
        b=jIXlkLlw55FP7kdAYyMxixzWpuh+5+j9F3A97xC0mZpseD9UIrXVqX+brH9KUv3zAwZFwz
        RlgFzAcVylBWaDSgqrASsHzhdcSZemn5t+w+xlMKY8a7rz2/slM45H7MHC9T+7VqOaeQ1s
        JjLLmORuKvcHI5beHXJIVvuhA2w2hhk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-IKUvwA4vMciWk9gBc_EYyw-1; Fri, 07 Aug 2020 05:51:24 -0400
X-MC-Unique: IKUvwA4vMciWk9gBc_EYyw-1
Received: by mail-wm1-f71.google.com with SMTP id h7so573808wmm.7
        for <linux-rt-users@vger.kernel.org>; Fri, 07 Aug 2020 02:51:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zjAjRBZqRUxOSD09O8un2EvyPI/eihDhik4FjIAp3oQ=;
        b=sSXBV5jG12Wmj11hLqkDCUaQH+sciUqS3zVuq3DOCzuE8bS1uKtZcWh8EcDLAUqpZM
         RakfYaXG68Y+IbbcXutEZk9tiRqbMXMEOTj6OZq7TVY7ypiHiJu280E7s3wi0BLbtfhr
         ooD5M7vdY8WzRXWVP31R4FNLMYpE9JJcsu+1wc+K4lV2NOB6R+DeO/RYT0TgQDyrBBqB
         BDA0Flz31jED64CoMu2J5COCEaMYucAje6uRN8VN6Y37MOI6vZ9HvYr7InTuc0ZZSGl6
         CzQbP828TEw9xoMAD8bN9gixYtrIBSdfxdafcGCeztQLUPdCZwrBseGnK3yRw925O7Yh
         mIoA==
X-Gm-Message-State: AOAM531SSyc5ZruR1gSobmxi08HDnVGclfeNHDrvw3UHgJ1w0gXYE2y2
        hTkVRc0azJrC0LZlmZ2WXspRs+DmyiN2aceiLULq/NxyoONOVlDloPRM6JnBWMJ4uSE2XcVnT4d
        DpQrgBwdiJKvABODP7Cz29kginHc=
X-Received: by 2002:adf:9c8c:: with SMTP id d12mr11112935wre.369.1596793882750;
        Fri, 07 Aug 2020 02:51:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzkip5rLEQTz9TI9POQCDYsEa8Kk+JzuIIjQ//8hNa+MzW7XcP0R8ZojIy+dEPc7Ef8cI3L/g==
X-Received: by 2002:adf:9c8c:: with SMTP id d12mr11112927wre.369.1596793882525;
        Fri, 07 Aug 2020 02:51:22 -0700 (PDT)
Received: from localhost.localdomain.com ([151.29.36.84])
        by smtp.gmail.com with ESMTPSA id h14sm9388396wml.30.2020.08.07.02.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 02:51:21 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     peterz@infradead.org, mingo@redhat.com
Cc:     rostedt@goodmis.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        tommaso.cucinotta@santannapisa.it, alessio.balsini@gmail.com,
        bristot@redhat.com, dietmar.eggemann@arm.com,
        linux-rt-users@vger.kernel.org, mtosatti@redhat.com,
        williams@redhat.com, valentin.schneider@arm.com
Subject: [RFC PATCH v2 2/6] sched/deadline: Collect sched_dl_entity initialization
Date:   Fri,  7 Aug 2020 11:50:47 +0200
Message-Id: <20200807095051.385985-3-juri.lelli@redhat.com>
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

Create a single function that initializes a sched_dl_entity.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c     |  5 +----
 kernel/sched/deadline.c | 22 +++++++++++++++-------
 kernel/sched/sched.h    |  5 +----
 3 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 12e1f3a2cabc6..6b36bf82b53c2 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3081,10 +3081,7 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 	memset(&p->se.statistics, 0, sizeof(p->se.statistics));
 #endif
 
-	RB_CLEAR_NODE(&p->dl.rb_node);
-	init_dl_task_timer(&p->dl);
-	init_dl_inactive_task_timer(&p->dl);
-	__dl_clear_params(p);
+	init_dl_entity(&p->dl);
 
 	INIT_LIST_HEAD(&p->rt.run_list);
 	p->rt.timeout		= 0;
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 2ece83b5991f5..8d909bdb9a119 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -219,6 +219,8 @@ static void dl_change_utilization(struct task_struct *p, u64 new_bw)
 	__add_rq_bw(new_bw, &rq->dl);
 }
 
+static void __dl_clear_params(struct sched_dl_entity *dl_se);
+
 /*
  * The utilization of a task cannot be immediately removed from
  * the rq active utilization (running_bw) when the task blocks.
@@ -317,7 +319,7 @@ static void task_non_contending(struct task_struct *p)
 				sub_rq_bw(&p->dl, &rq->dl);
 			raw_spin_lock(&dl_b->lock);
 			__dl_sub(dl_b, p->dl.dl_bw, dl_bw_cpus(task_cpu(p)));
-			__dl_clear_params(p);
+			__dl_clear_params(dl_se);
 			raw_spin_unlock(&dl_b->lock);
 		}
 
@@ -1123,7 +1125,7 @@ static enum hrtimer_restart dl_task_timer(struct hrtimer *timer)
 	return HRTIMER_NORESTART;
 }
 
-void init_dl_task_timer(struct sched_dl_entity *dl_se)
+static void init_dl_task_timer(struct sched_dl_entity *dl_se)
 {
 	struct hrtimer *timer = &dl_se->dl_timer;
 
@@ -1335,7 +1337,7 @@ static enum hrtimer_restart inactive_task_timer(struct hrtimer *timer)
 		raw_spin_lock(&dl_b->lock);
 		__dl_sub(dl_b, p->dl.dl_bw, dl_bw_cpus(task_cpu(p)));
 		raw_spin_unlock(&dl_b->lock);
-		__dl_clear_params(p);
+		__dl_clear_params(dl_se);
 
 		goto unlock;
 	}
@@ -1351,7 +1353,7 @@ static enum hrtimer_restart inactive_task_timer(struct hrtimer *timer)
 	return HRTIMER_NORESTART;
 }
 
-void init_dl_inactive_task_timer(struct sched_dl_entity *dl_se)
+static void init_dl_inactive_task_timer(struct sched_dl_entity *dl_se)
 {
 	struct hrtimer *timer = &dl_se->inactive_timer;
 
@@ -2741,10 +2743,8 @@ bool __checkparam_dl(const struct sched_attr *attr)
 /*
  * This function clears the sched_dl_entity static params.
  */
-void __dl_clear_params(struct task_struct *p)
+static void __dl_clear_params(struct sched_dl_entity *dl_se)
 {
-	struct sched_dl_entity *dl_se = &p->dl;
-
 	dl_se->dl_runtime		= 0;
 	dl_se->dl_deadline		= 0;
 	dl_se->dl_period		= 0;
@@ -2759,6 +2759,14 @@ void __dl_clear_params(struct task_struct *p)
 	dl_se->dl_overrun		= 0;
 }
 
+void init_dl_entity(struct sched_dl_entity *dl_se)
+{
+	RB_CLEAR_NODE(&dl_se->rb_node);
+	init_dl_task_timer(dl_se);
+	init_dl_inactive_task_timer(dl_se);
+	__dl_clear_params(dl_se);
+}
+
 bool dl_param_changed(struct task_struct *p, const struct sched_attr *attr)
 {
 	struct sched_dl_entity *dl_se = &p->dl;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 963c16fc27500..62304d4de99cc 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -255,8 +255,6 @@ struct rt_bandwidth {
 	unsigned int		rt_period_active;
 };
 
-void __dl_clear_params(struct task_struct *p);
-
 /*
  * To keep the bandwidth of -deadline tasks and groups under control
  * we need some place where:
@@ -1939,8 +1937,7 @@ extern void init_rt_bandwidth(struct rt_bandwidth *rt_b, u64 period, u64 runtime
 
 extern struct dl_bandwidth def_dl_bandwidth;
 extern void init_dl_bandwidth(struct dl_bandwidth *dl_b, u64 period, u64 runtime);
-extern void init_dl_task_timer(struct sched_dl_entity *dl_se);
-extern void init_dl_inactive_task_timer(struct sched_dl_entity *dl_se);
+extern void init_dl_entity(struct sched_dl_entity *dl_se);
 
 #define BW_SHIFT		20
 #define BW_UNIT			(1 << BW_SHIFT)
-- 
2.26.2

