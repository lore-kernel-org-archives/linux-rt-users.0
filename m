From: psomas@gentoo.org
Subject: [PATCH] Fix build error in kernel/sched_debug.c when CONFIG_PREEMPT_RT_FULL is not set
Date: Tue, 30 Aug 2011 12:48:22 +0300
Message-ID: <1314697702-19946-1-git-send-email-psomas@gentoo.org>
Cc: peterz@infradead.org, Stratos Psomadakis <psomas@gentoo.org>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ulysses.noc.ntua.gr ([147.102.222.230]:55957 "EHLO
	ulysses.noc.ntua.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752760Ab1H3Jsc (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 30 Aug 2011 05:48:32 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Stratos Psomadakis <psomas@gentoo.org>

When CONFIG_PREEMPT_RT_FULL is not set, a build error occurs due to
migrate_disable task_struct member not existing. 

Trivial fix, enclose it inside an #ifdef

Signed-off-by: Stratos Psomadakis <psomas@gentoo.org>
---
 kernel/sched_debug.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/kernel/sched_debug.c b/kernel/sched_debug.c
index dba9e40..e68cf7f 100644
--- a/kernel/sched_debug.c
+++ b/kernel/sched_debug.c
@@ -485,7 +485,9 @@ void proc_sched_show_task(struct task_struct *p, struct seq_file *m)
 	P(se.load.weight);
 	P(policy);
 	P(prio);
+#ifdef CONFIG_PREEMPT_RT_FULL
 	P(migrate_disable);
+#endif
 	P(rt.nr_cpus_allowed);
 #undef PN
 #undef __PN
-- 
1.7.6

