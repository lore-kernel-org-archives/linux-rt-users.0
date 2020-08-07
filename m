Return-Path: <SRS0=EtfJ=BR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC26C433DF
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 Aug 2020 09:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3486C2177B
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 Aug 2020 09:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NoRg799Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbgHGJ4O (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 7 Aug 2020 05:56:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37398 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727814AbgHGJ4M (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 7 Aug 2020 05:56:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596794170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MHfOQ/QK+h0OTyBVJky4IgpUyZhQhqoeqa8VT3V3sDw=;
        b=NoRg799ZjesPN547tiyQgP9eVLqo3nepellvLBTL5AU+AZFqeBHyX7ypwd/nawcXWjTMGk
        9z98iOdheIETqojSq4+39Kr3E00UzXIXmIwFjqsggk+EF/Ncd1gIU+54TtxQATojw04GLb
        kJSW/31QWbSY83GM8bCNSbHDku02Lr8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-NensrqpbO7aWhdABPJF4uQ-1; Fri, 07 Aug 2020 05:56:09 -0400
X-MC-Unique: NensrqpbO7aWhdABPJF4uQ-1
Received: by mail-wr1-f70.google.com with SMTP id b8so550312wrr.2
        for <linux-rt-users@vger.kernel.org>; Fri, 07 Aug 2020 02:56:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MHfOQ/QK+h0OTyBVJky4IgpUyZhQhqoeqa8VT3V3sDw=;
        b=KT7x8kHgT3LipzmYUHCYwNZb4E4afCQjpNtOKEwZyAtl4fVoa6GcGGbmwK2YEnpBdX
         cAruxnliJOhQeU9nQ21j7u+X2kzbwQP9xIPmKOJW6NeMiaW3S0JWjiCsWlukrbtY3hzy
         eDVx5kOpLc5dgjry2LRXFhGvJI4sUTw49ODVZnRJfMHIPk/9X6G9AXfnQbh1n71Ek87p
         NgA+9yzAAzX4p1XDM7I8AaAEuRJTGy+xNtQ2fsAmBA3pLDU9B9EBTidJeUs3GTGEECwk
         oRnM3LYsVQrB2Y4y6Ik9Pm13Z+Zrb9M04Mu05sQyU1I3r3Ryia4UlzuGQ5CmNEd2PRxu
         hDrA==
X-Gm-Message-State: AOAM5308PcwI6Ack1YG1nuTVHglcoeOBTP8JeNRVqDNiqkXpCmkxbhHz
        r1FIuqrSw4gWs38D3S81vSOZcWc6fdEwX92n/02FmHGEHu0iL9bqZUpdimayYvAzwBH2gfn+PWK
        paKJ3lml1PeI56zpwTuw2qbw8EPk=
X-Received: by 2002:a1c:740c:: with SMTP id p12mr11662340wmc.53.1596794167866;
        Fri, 07 Aug 2020 02:56:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy8rjpwT8Kj9a+i/vsWPjDIR2BwXy8YnBl35DkAWkZyz9L9WtqmIlW45CqC0Msurwpk5XRvrg==
X-Received: by 2002:a1c:740c:: with SMTP id p12mr11662317wmc.53.1596794167552;
        Fri, 07 Aug 2020 02:56:07 -0700 (PDT)
Received: from localhost.localdomain ([151.29.36.84])
        by smtp.gmail.com with ESMTPSA id i6sm9451547wrp.92.2020.08.07.02.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 02:56:06 -0700 (PDT)
Date:   Fri, 7 Aug 2020 11:56:04 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     peterz@infradead.org, mingo@redhat.com
Cc:     rostedt@goodmis.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        tommaso.cucinotta@santannapisa.it, alessio.balsini@gmail.com,
        bristot@redhat.com, dietmar.eggemann@arm.com,
        linux-rt-users@vger.kernel.org, mtosatti@redhat.com,
        williams@redhat.com, valentin.schneider@arm.com,
        juri.lelli@redhat.com
Subject: [RFC PATCH v2 6/6] sched/fair: Implement starvation monitor
Message-ID: <20200807095604.GO42956@localhost.localdomain>
References: <20200807095051.385985-1-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807095051.385985-1-juri.lelli@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Starting deadline server for lower priority classes right away when
first task is enqueued might break guarantees, as tasks belonging to
intermediate priority classes could be uselessly preempted. E.g., a well
behaving (non hog) FIFO task can be preempted by NORMAL tasks even if
there are still CPU cycles available for NORMAL tasks to run, as they'll
be running inside the fair deadline server for some period of time.

To prevent this issue, implement a starvation monitor mechanism that
starts the deadline server only if a (fair in this case) task hasn't
been scheduled for some interval of time after it has been enqueued.
Use pick/put functions to manage starvation monitor status.

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/sched/fair.c  | 57 ++++++++++++++++++++++++++++++++++++++++++--
 kernel/sched/sched.h |  4 ++++
 2 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6a97ee2a4e26d..5cdf76e508074 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5494,6 +5494,53 @@ static int sched_idle_cpu(int cpu)
 }
 #endif
 
+
+static void fair_server_watchdog(struct timer_list *list)
+{
+	struct rq *rq = container_of(list, struct rq, fair_server_wd);
+	struct rq_flags rf;
+
+	rq_lock_irqsave(rq, &rf);
+	rq->fair_server_wd_running = 0;
+
+	if (!rq->cfs.h_nr_running)
+		goto out;
+
+	update_rq_clock(rq);
+	dl_server_start(&rq->fair_server);
+	rq->fair_server_active = 1;
+	resched_curr(rq);
+
+out:
+	rq_unlock_irqrestore(rq, &rf);
+}
+
+static inline void fair_server_watchdog_start(struct rq *rq)
+{
+	if (rq->fair_server_wd_running || rq->fair_server_active)
+		return;
+
+	timer_setup(&rq->fair_server_wd, fair_server_watchdog, 0);
+	rq->fair_server_wd.expires = jiffies + FAIR_SERVER_WATCHDOG_INTERVAL;
+	add_timer_on(&rq->fair_server_wd, cpu_of(rq));
+	rq->fair_server_active = 0;
+	rq->fair_server_wd_running = 1;
+}
+
+static inline void fair_server_watchdog_stop(struct rq *rq, bool stop_server)
+{
+	if (!rq->fair_server_wd_running && !stop_server)
+		return;
+
+	del_timer(&rq->fair_server_wd);
+	rq->fair_server_wd_running = 0;
+
+	if (stop_server && rq->fair_server_active) {
+		dl_server_stop(&rq->fair_server);
+		rq->fair_server_active = 0;
+	}
+}
+
 /*
  * The enqueue_task method is called before nr_running is
  * increased. Here we update the fair scheduling stats and
@@ -5515,7 +5562,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	util_est_enqueue(&rq->cfs, p);
 
 	if (!rq->cfs.h_nr_running)
-		dl_server_start(&rq->fair_server);
+		fair_server_watchdog_start(rq);
 
 	/*
 	 * If in_iowait is set, the code below may not trigger any cpufreq
@@ -5670,7 +5717,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
 dequeue_throttle:
 	if (!rq->cfs.h_nr_running)
-		dl_server_stop(&rq->fair_server);
+		fair_server_watchdog_stop(rq, true);
 
 	util_est_dequeue(&rq->cfs, p, task_sleep);
 	hrtick_update(rq);
@@ -7123,6 +7170,7 @@ done: __maybe_unused;
 		hrtick_start_fair(rq, p);
 
 	update_misfit_status(p, rq);
+	fair_server_watchdog_stop(rq, false);
 
 	return p;
 
@@ -7178,6 +7226,8 @@ void fair_server_init(struct rq *rq)
 	dl_se->dl_period = 20 * TICK_NSEC;
 
 	dl_server_init(dl_se, rq, fair_server_has_tasks, fair_server_pick);
+
+	rq->fair_server_wd_running = 0;
 }
 
 /*
@@ -7192,6 +7242,9 @@ static void put_prev_task_fair(struct rq *rq, struct task_struct *prev)
 		cfs_rq = cfs_rq_of(se);
 		put_prev_entity(cfs_rq, se);
 	}
+
+	if (rq->cfs.h_nr_running)
+		fair_server_watchdog_start(rq);
 }
 
 /*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index bf8c9c07705c9..1e1a5436be725 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -375,6 +375,7 @@ extern void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
 		    dl_server_has_tasks_f has_tasks,
 		    dl_server_pick_f pick);
 
+#define FAIR_SERVER_WATCHDOG_INTERVAL (HZ >> 1)
 extern void fair_server_init(struct rq *);
 
 #ifdef CONFIG_CGROUP_SCHED
@@ -962,6 +963,9 @@ struct rq {
 	struct dl_rq		dl;
 
 	struct sched_dl_entity	fair_server;
+	int			fair_server_active;
+	struct timer_list	fair_server_wd;
+	int			fair_server_wd_running;
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	/* list of leaf cfs_rq on this CPU: */
-- 
2.26.2

