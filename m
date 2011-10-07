From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH, RFC, -rt] Make lockdep-RCU insist on rcu_read_lock_bh()
Date: Thu, 6 Oct 2011 17:44:51 -0700
Message-ID: <20111007004451.GA13738@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: tglx@linutronix.de, peterz@infradead.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e4.ny.us.ibm.com ([32.97.182.144]:54540 "EHLO e4.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758402Ab1JGAo6 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 6 Oct 2011 20:44:58 -0400
Received: from /spool/local
	by e4.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-rt-users@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Thu, 6 Oct 2011 20:44:57 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

rcu: Make -rt complain about lack of rcu_read_lock_bh()

Mainline permits local_bh_disable() to be used in place of
rcu_read_lock_bh(), but this fails for CONFIG_PREEMPT_RT_FULL.  This
commit therefore makes rcu_read_lock_bh_held() insist on
rcu_read_lock_bh() for CONFIG_PREEMPT_RT_FULL.

Signed-off-by: Paul E. McKenney <paul.mckenney@linaro.org>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

diff --git a/kernel/rcupdate.c b/kernel/rcupdate.c
index 5e0577b..e91a85d 100644
--- a/kernel/rcupdate.c
+++ b/kernel/rcupdate.c
@@ -89,7 +89,11 @@ int rcu_read_lock_bh_held(void)
 {
 	if (!debug_lockdep_rcu_enabled())
 		return 1;
+#ifdef CONFIG_PREEMPT_RT_FULL
+	return lock_is_held(&rcu_bh_lock_map);
+#else
 	return in_softirq() || irqs_disabled();
+#endif
 }
 EXPORT_SYMBOL_GPL(rcu_read_lock_bh_held);
 #endif

