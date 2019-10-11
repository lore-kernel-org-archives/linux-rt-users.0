Return-Path: <SRS0=iU+X=YE=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 763F4ECE58C
	for <linux-rt-users@archiver.kernel.org>; Fri, 11 Oct 2019 14:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 566D020679
	for <linux-rt-users@archiver.kernel.org>; Fri, 11 Oct 2019 14:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbfJKOJr (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 11 Oct 2019 10:09:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51880 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728033AbfJKOJq (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 11 Oct 2019 10:09:46 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 619E3316D8C8;
        Fri, 11 Oct 2019 14:09:46 +0000 (UTC)
Received: from llong.com (dhcp-17-160.bos.redhat.com [10.18.17.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 245D360BF4;
        Fri, 11 Oct 2019 14:09:43 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juri Lelli <jlelli@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH RT] kernel/sched: Don't recompute cpumask weight in migrate_enable_update_cpus_allowed()
Date:   Fri, 11 Oct 2019 10:09:08 -0400
Message-Id: <20191011140908.5161-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Fri, 11 Oct 2019 14:09:46 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

At each invocation of rt_spin_unlock(), cpumask_weight() is called
via migrate_enable_update_cpus_allowed() to recompute the weight of
cpus_mask which doesn't change that often.

The following is a sample output of perf-record running the testpmd
microbenchmark on an RT kernel:

  34.77%   1.65%  testpmd  [kernel.kallsyms]  [k] rt_spin_unlock
  34.32%   2.52%  testpmd  [kernel.kallsyms]  [k] migrate_enable
  21.76%  21.76%  testpmd  [kernel.kallsyms]  [k] __bitmap_weight

By adding an extra variable to keep track of the weight of cpus_mask,
we could eliminate the frequent call to cpumask_weight() and replace
it with simple assignment.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/sched.h | 3 ++-
 init/init_task.c      | 1 +
 kernel/fork.c         | 4 +++-
 kernel/sched/core.c   | 8 +++++---
 4 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 7e892e727f12..c65c75b82056 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -656,7 +656,8 @@ struct task_struct {
 #endif
 
 	unsigned int			policy;
-	int				nr_cpus_allowed;
+	unsigned int			nr_cpus_allowed; /* # in cpus_ptr */
+	unsigned int			nr_cpus_mask;	 /* # in cpus_mask */
 	const cpumask_t			*cpus_ptr;
 	cpumask_t			cpus_mask;
 #if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT_BASE)
diff --git a/init/init_task.c b/init/init_task.c
index e402413dc47d..36bc82439ff1 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -81,6 +81,7 @@ struct task_struct init_task
 	.cpus_ptr	= &init_task.cpus_mask,
 	.cpus_mask	= CPU_MASK_ALL,
 	.nr_cpus_allowed= NR_CPUS,
+	.nr_cpus_mask   = NR_CPUS,
 	.mm		= NULL,
 	.active_mm	= &init_mm,
 	.restart_block	= {
diff --git a/kernel/fork.c b/kernel/fork.c
index 3c7738d87ddb..e00b92a18444 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -935,8 +935,10 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 #ifdef CONFIG_STACKPROTECTOR
 	tsk->stack_canary = get_random_canary();
 #endif
-	if (orig->cpus_ptr == &orig->cpus_mask)
+	if (orig->cpus_ptr == &orig->cpus_mask) {
 		tsk->cpus_ptr = &tsk->cpus_mask;
+		tsk->nr_cpus_allowed = tsk->nr_cpus_mask;
+	}
 
 	/*
 	 * One for us, one for whoever does the "release_task()" (usually
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 93b4ae1ecaff..a299b7dd3de0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1126,7 +1126,9 @@ static int migration_cpu_stop(void *data)
 void set_cpus_allowed_common(struct task_struct *p, const struct cpumask *new_mask)
 {
 	cpumask_copy(&p->cpus_mask, new_mask);
-	p->nr_cpus_allowed = cpumask_weight(new_mask);
+	p->nr_cpus_mask = cpumask_weight(new_mask);
+	if (p->cpus_ptr == &p->cpus_mask)
+		p->nr_cpus_allowed = p->nr_cpus_mask;
 }
 
 #if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT_BASE)
@@ -1173,7 +1175,7 @@ void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
 	if (__migrate_disabled(p)) {
 		lockdep_assert_held(&p->pi_lock);
 
-		cpumask_copy(&p->cpus_mask, new_mask);
+		set_cpus_allowed_common(p, new_mask);
 		p->migrate_disable_update = 1;
 		return;
 	}
@@ -7335,7 +7337,7 @@ migrate_enable_update_cpus_allowed(struct task_struct *p)
 
 	rq = task_rq_lock(p, &rf);
 	p->cpus_ptr = &p->cpus_mask;
-	p->nr_cpus_allowed = cpumask_weight(&p->cpus_mask);
+	p->nr_cpus_allowed = p->nr_cpus_mask;
 	update_nr_migratory(p, 1);
 	task_rq_unlock(rq, p, &rf);
 }
-- 
2.18.1

