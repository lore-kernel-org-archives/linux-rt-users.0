From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: [PATCH] rcutorture: fix missing function at build time
Date: Mon, 2 Mar 2015 17:15:31 -0300
Message-ID: <20150302201530.GA4189@uudg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qg0-f48.google.com ([209.85.192.48]:54290 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754542AbbCBUPf (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 2 Mar 2015 15:15:35 -0500
Received: by mail-qg0-f48.google.com with SMTP id q107so15780084qgd.7
        for <linux-rt-users@vger.kernel.org>; Mon, 02 Mar 2015 12:15:35 -0800 (PST)
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

This is a minor issue, but as I seem to have woken up Paul at 4AM with the
many beeps from IRC I would feel bad if I did not send this patch to the
list. Actually, as that patch has been sitting on my computer for a few
days now, i already feel bad :)


rcutorture: fix missing function at build time

Trying to build the rcutorture module on 3.18.7-rt2 ends up on:

   ERROR: "rcu_force_quiescent_state" [kernel/rcu/rcutorture.ko] undefined!

Commit "71d22b5 Subject: rcu: Merge RCU-bh into RCU-preempt" encloses three
functions (rcu_batches_completed_bh, rcu_force_quiescent_state and
rcu_bh_force_quiescent_state) on an #ifndef CONFIG_PREEMPT_RT_FULL / #endif
pair, rendering them non-existent on RT. As the commit points out, that was
a wise and necessary move.

But in order to get rcutorture build working again we need to define an
empty rcu_force_quiescent_state function.

Signed-off-by: Luis Claudio R. Goncalves <lclaudio@uudg.org>

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index a4e9e25..28a54f6 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -378,6 +378,11 @@ void rcu_bh_force_quiescent_state(void)
 	force_quiescent_state(&rcu_bh_state);
 }
 EXPORT_SYMBOL_GPL(rcu_bh_force_quiescent_state);
+#else
+void rcu_force_quiescent_state(void)
+{
+}
+EXPORT_SYMBOL_GPL(rcu_force_quiescent_state);
 #endif
 
 /*

-- 
[ Luis Claudio R. Goncalves                    Bass - Gospel - RT ]
[ Fingerprint: 4FDD B8C4 3C59 34BD 8BE9  2696 7203 D980 A448 C8F8 ]

