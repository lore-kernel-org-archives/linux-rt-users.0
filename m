Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E651EC433E0
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Feb 2021 08:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 943A264EC0
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Feb 2021 08:37:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbhBSIh1 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 19 Feb 2021 03:37:27 -0500
Received: from inva021.nxp.com ([92.121.34.21]:49880 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229639AbhBSIhZ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 19 Feb 2021 03:37:25 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id ED351200614;
        Fri, 19 Feb 2021 09:36:33 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1A7F420061E;
        Fri, 19 Feb 2021 09:36:29 +0100 (CET)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 723C1402D2;
        Fri, 19 Feb 2021 09:36:22 +0100 (CET)
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Sebastian Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiafei Pan <jiafei.pan@nxp.com>, linux-rt-users@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ran Wang <ran.wang_1@nxp.com>
Subject: [PATCH] rt: cpufreq: Fix cpu hotplug hang
Date:   Fri, 19 Feb 2021 16:44:20 +0800
Message-Id: <20210219084420.23379-1-ran.wang_1@nxp.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

When selecting PREEMPT_RT, cpufreq_driver->stop_cpu(policy) might got
stuck due to irq_work_sync() pending for work on lazy_list. That’s
because lazy_list may have no chance to be served in softirq context
sometimes. Below is one of scenarios that was captured:

...
ret_from_fork
 kthread
  smpboot_thread_fn
   cpuhp_thread_fun
    cpuhp_invoke_callback: state: 193
     cpuhp_cpufreq_online
      cpufreq_online
       cpufreq_driver->stop_cpu(policy);
        cpufreq_dbs_governor_stop
         sugov_stop  // kernel/sched/cpufreq_schedutil.c
          irq_work_sync(&sg_policy->irq_work);

This is observed on LX2160ARDB (16 A72 cores) with cpufreq governor of
‘schedutil’ or ‘ondemand’.

Configure related irqwork to run on raw-irq context could fix this.

Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
---
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
index 6931f0cdeb80..054a01ef4f57 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -719,7 +719,7 @@ static int sugov_kthread_create(struct sugov_policy *sg_policy)
 
 	sg_policy->thread = thread;
 	kthread_bind_mask(thread, policy->related_cpus);
-	init_irq_work(&sg_policy->irq_work, sugov_irq_work);
+	sg_policy->irq_work = IRQ_WORK_INIT_HARD(sugov_irq_work);
 	mutex_init(&sg_policy->work_lock);
 
 	wake_up_process(thread);
-- 
2.25.1

