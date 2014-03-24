From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: [PATCH RT] dont calculate hweight in update_migrate_disable
Date: Mon, 24 Mar 2014 13:18:48 +0100
Message-ID: <20140324121848.GA18300@opentech.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, rostedt@goodmis.org,
	tglx@linutronix.de,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hofr.at ([212.69.189.236]:59826 "EHLO mail.hofr.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752767AbaCXMSt (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 24 Mar 2014 08:18:49 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi ! 

Proposal for a minor optimization in update_migrate_disable - its only a few 
instructions saved but those are in the hot path of locks so it might be worth
it

When being scheduled out while migrate_disable > 0 and migrate_disabled_updated
is not yet set we end up here (kernel/sched/core.c):

static inline void update_migrate_disable(struct task_struct *p)
{
        ...

        mask = tsk_cpus_allowed(p);

        if (p->sched_class->set_cpus_allowed)
                p->sched_class->set_cpus_allowed(p, mask);
        p->nr_cpus_allowed = cpumask_weight(mask);


as we only can get here if migrate_disable > 0 there is no need to calculate
the cpumask_weight(mask) as tsk_cpus_allowed in that case will return
cpumask_of(task_cpu(p)) which only can have a hamming weight of 1 anyway.
So we can simply do:

        p->nr_cpus_allowed = 1;

without changing the behavior.

Patch is on top of 3.12.13-rt21


Signed-off-by: Nicholas Mc Guire <der.herr@hofr.at>
---
 kernel/sched/core.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index bf93f63..6c07fe9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2405,7 +2405,8 @@ static inline void update_migrate_disable(struct task_struct *p)
 
 	if (p->sched_class->set_cpus_allowed)
 		p->sched_class->set_cpus_allowed(p, mask);
-	p->nr_cpus_allowed = cpumask_weight(mask);
+	/* mask==cpumask_of(task_cpu(p)) which has a cpumask_weight==1 */
+	p->nr_cpus_allowed = 1;
 
 	/* Let migrate_enable know to fix things back up */
 	p->migrate_disable |= MIGRATE_DISABLE_SET_AFFIN;
-- 
1.7.10.4

