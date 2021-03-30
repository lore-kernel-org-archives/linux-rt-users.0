Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94602C433C1
	for <linux-rt-users@archiver.kernel.org>; Tue, 30 Mar 2021 03:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B9EA6195D
	for <linux-rt-users@archiver.kernel.org>; Tue, 30 Mar 2021 03:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbhC3DI5 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 29 Mar 2021 23:08:57 -0400
Received: from inva020.nxp.com ([92.121.34.13]:34368 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230303AbhC3DIg (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 29 Mar 2021 23:08:36 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 388E91A1270;
        Tue, 30 Mar 2021 05:08:35 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 81E781A1646;
        Tue, 30 Mar 2021 05:08:31 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 6A912402EC;
        Tue, 30 Mar 2021 05:08:26 +0200 (CEST)
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Sebastian Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiafei Pan <jiafei.pan@nxp.com>, linux-rt-users@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ran Wang <ran.wang_1@nxp.com>
Subject: [PATCH v2] rt: cpufreq: Fix cpu hotplug hang
Date:   Tue, 30 Mar 2021 11:15:13 +0800
Message-Id: <20210330031513.17903-1-ran.wang_1@nxp.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

When selecting PREEMPT_RT, cpufreq_driver->stop_cpu(policy) might get
stuck due to irq_work_sync() pending for work on lazy_list, which had
no chance to be served in softirq context sometimes.

The reason of lazy_list was not served is because the nearest activated
timer might have been set to expire after long time (such as 100+ seconds).
Then function run_local_timers() would not call raise_softirq(TIMER_SOFTIRQ)
to handle enqueued irq_work.

This is observed on LX2160ARDB and LS1088ARDB with cpufreq governor of
‘schedutil’ or ‘ondemand’.

Configure related irqwork to run on raw-irq context could fix this issue.

Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
---
Change in v2:
 - Update commit message to explain root cause more clear.

 drivers/cpufreq/cpufreq_governor.c | 2 +-
 kernel/sched/cpufreq_schedutil.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index 63f7c219062b..731a7b1434df 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -360,7 +360,7 @@ static struct policy_dbs_info *alloc_policy_dbs_info(struct cpufreq_policy *poli
 	policy_dbs->policy = policy;
 	mutex_init(&policy_dbs->update_mutex);
 	atomic_set(&policy_dbs->work_count, 0);
-	init_irq_work(&policy_dbs->irq_work, dbs_irq_work);
+	policy_dbs->irq_work = IRQ_WORK_INIT_HARD(dbs_irq_work);
 	INIT_WORK(&policy_dbs->work, dbs_work_handler);
 
 	/* Set policy_dbs for all CPUs, online+offline */
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 50cbad89f7fa..1d5af87ec92e 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -611,7 +611,7 @@ static int sugov_kthread_create(struct sugov_policy *sg_policy)
 
 	sg_policy->thread = thread;
 	kthread_bind_mask(thread, policy->related_cpus);
-	init_irq_work(&sg_policy->irq_work, sugov_irq_work);
+	sg_policy->irq_work = IRQ_WORK_INIT_HARD(sugov_irq_work);
 	mutex_init(&sg_policy->work_lock);
 
 	wake_up_process(thread);
-- 
2.25.1

