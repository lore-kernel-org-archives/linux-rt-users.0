From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: [PATCH 1/3] make migrate disable/enable conditioned on
	softirq_nestcnt transition
Date: Fri, 6 Dec 2013 00:42:22 +0100
Message-ID: <20131205234222.GE15603@opentech.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Andreas Platschek <platschek@ict.tuwien.ac.at>,
	Steven Rostedt <rostedt@goodmis.org>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hofr.at ([212.69.189.236]:58570 "EHLO mail.hofr.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751271Ab3LEXm0 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 5 Dec 2013 18:42:26 -0500
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


 This patch removes the recursive calls to migrate_disable/enable in 
 local_bh_disable/enable

 the softirq-local-lock.patch introduces local_bh_disable/enable wich 
 decrements/increments the current->softirq_nestcnt and disable/enables
 migration as well. as softirq_nestcnt (include/linux/sched.h conditioned
 on CONFIG_PREEMPT_RT_BASE) already is tracking the nesting level of the
 recursive calls to local_bh_disable/enable (all in kernel/softirq.c) - no 
 need to do it twice.

 migrate_disable/enable thus can be conditionsed on softirq_nestcnt making
 a transition from 0-1 to disable migration and 1-0 to re-enable it.

 patch on top of 3.12.1-rt4

 No change of functional behavior, this does noticably reduce the observed 
 nesting level of migrate_disable/enable 

Signed-off-by: Nicholas Mc Guire <der.herr@hofr.at>
---
 kernel/softirq.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 9a7268f..16ebbd9 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -569,8 +569,8 @@ static void do_current_softirqs(int need_rcu_bh_qs)
 
 void local_bh_disable(void)
 {
-	migrate_disable();
-	current->softirq_nestcnt++;
+	if (++current->softirq_nestcnt == 1)
+		migrate_disable();
 }
 EXPORT_SYMBOL(local_bh_disable);
 
@@ -584,8 +584,8 @@ void local_bh_enable(void)
 		do_current_softirqs(1);
 	local_irq_enable();
 
-	current->softirq_nestcnt--;
-	migrate_enable();
+	if (--current->softirq_nestcnt == 0)
+		migrate_enable();
 }
 EXPORT_SYMBOL(local_bh_enable);
 
@@ -597,8 +597,10 @@ EXPORT_SYMBOL(local_bh_enable_ip);
 
 void _local_bh_enable(void)
 {
-	current->softirq_nestcnt--;
-	migrate_enable();
+	if (WARN_ON(current->softirq_nestcnt == 0))
+		return;
+	if (--current->softirq_nestcnt == 0)
+		migrate_enable();
 }
 EXPORT_SYMBOL(_local_bh_enable);
 
-- 
1.7.2.5

