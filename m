From: Tiejun Chen <tiejun.chen@windriver.com>
Subject: [PATCH 1/1] rcutree/rcu_bh_qs: disable irq while calling rcu_preempt_qs()
Date: Thu, 5 Dec 2013 17:52:42 +0800
Message-ID: <1386237162-10141-1-git-send-email-tiejun.chen@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-rt-users@vger.kernel.org>
To: <bigeasy@linutronix.de>, <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:52960 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755270Ab3LEJwf (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 5 Dec 2013 04:52:35 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Any callers should make sure irq is disabled before calling rcu_preempt_qs().

Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
---
 kernel/rcutree.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/rcutree.c b/kernel/rcutree.c
index 7ec834d..6f6d133 100644
--- a/kernel/rcutree.c
+++ b/kernel/rcutree.c
@@ -186,7 +186,12 @@ static void rcu_preempt_qs(int cpu);
 
 void rcu_bh_qs(int cpu)
 {
+	unsigned long flags;
+
+	/* Callers to this function, rcu_preempt_qs(), must disable irqs. */
+	local_irq_save(flags);
 	rcu_preempt_qs(cpu);
+	local_irq_restore(flags);
 }
 #else
 void rcu_bh_qs(int cpu)
-- 
1.7.9.5

