From: Tiejun Chen <tiejun.chen@windriver.com>
Subject: [v2 PATCH] rcutree/rcu_bh_qs: disable irq while calling rcu_preempt_qs()
Date: Wed, 18 Dec 2013 17:51:49 +0800
Message-ID: <1387360309-12801-1-git-send-email-tiejun.chen@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-rt-users@vger.kernel.org>
To: <bigeasy@linutronix.de>, <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:49968 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752301Ab3LRJwH (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 18 Dec 2013 04:52:07 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Any callers to the function rcu_preempt_qs() must disable irqs in
order to protect the assignment to ->rcu_read_unlock_special. In
RT case, rcu_bh_qs() as the wrapper of rcu_preempt_qs() is called
in some scenarios where irq is enabled, like this path,

do_single_softirq()
    |
    + local_irq_enable();
    + handle_softirq()
    |    |
    |    + rcu_bh_qs()
    |        |
    |        + rcu_preempt_qs()
    |
    + local_irq_disable()

So here we'd better disable irq directly inside of rcu_bh_qs() to
fix this, otherwise the kernel may be freezable sometimes as
observed. And especially this way is also kind and safe for the
potential rcu_bh_qs() usage elsewhere in the future.

Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
Signed-off-by: Bin Jiang <bin.jiang@windriver.com>
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

