From: Tim Blechmann <tim@klingt.org>
Subject: [PATCH] [RT] avoid preemption in memory controller code
Date: Thu, 11 Dec 2008 20:00:45 +0100
Message-ID: <1229022045-31670-1-git-send-email-tim@klingt.org>
References: <preempt_enable_rt();>
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	mingo@elte.hu, tglx@linutronix.de, Tim Blechmann <tim@klingt.org>
To: rostedt@goodmis.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.klingt.org ([86.59.21.178]:49894 "EHLO klingt.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750767AbYLKTBO (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 11 Dec 2008 14:01:14 -0500
In-Reply-To: <preempt_enable_rt();>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

the lru_lock of struct mem_group_per_zone is used to avoid preemption
during the mem_cgroup_charge_statistics function. this does not work
correctly, when CONFIG_PREEMPT_RT is enabled.
therefore, the preemption is disabled using the preempt_disable_rt macro
in these cases.

Signed-off-by: Tim Blechmann <tim@klingt.org>
---
 mm/memcontrol.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 562b94f..70493c4 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -158,7 +158,7 @@ pcg_default_flags[NR_CHARGE_TYPE] = {
 };
 
 /*
- * Always modified under lru lock. Then, not necessary to preempt_disable()
+ * Always modified under lru lock. Disable preemption with preempt_disable_rt()
  */
 static void mem_cgroup_charge_statistics(struct mem_cgroup *mem,
 					 struct page_cgroup *pc,
@@ -170,6 +170,7 @@ static void mem_cgroup_charge_statistics(struct mem_cgroup *mem,
 
 	VM_BUG_ON(!irqs_disabled());
 
+	preempt_disable_rt();
 	cpustat = &stat->cpustat[smp_processor_id()];
 	if (PageCgroupCache(pc))
 		__mem_cgroup_stat_add_safe(cpustat, MEM_CGROUP_STAT_CACHE, val);
@@ -182,6 +183,7 @@ static void mem_cgroup_charge_statistics(struct mem_cgroup *mem,
 	else
 		__mem_cgroup_stat_add_safe(cpustat,
 				MEM_CGROUP_STAT_PGPGOUT_COUNT, 1);
+	preempt_enable_rt();
 }
 
 static struct mem_cgroup_per_zone *
-- 
1.5.6.3

