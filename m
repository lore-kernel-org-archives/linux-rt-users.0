Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from Galois.linutronix.de ([146.0.238.70]:50242 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752019AbeFFNb6 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 6 Jun 2018 09:31:58 -0400
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 6/6] rcu: Suppress lockdep false-positive ->boost_mtx complaints
Date: Wed,  6 Jun 2018 15:31:31 +0200
Message-Id: <20180606133131.7747-7-bigeasy@linutronix.de>
In-Reply-To: <20180606133131.7747-1-bigeasy@linutronix.de>
References: <20180606133131.7747-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: julia@ni.com
Cc: linux-rt-users@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>

From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

[ Upstream commit 02a7c234e54052101164368ff981bd72f7acdd65 ]

RCU priority boosting uses rt_mutex_init_proxy_locked() to initialize an
rt_mutex structure in locked state held by some other task.  When that
other task releases it, lockdep complains (quite accurately, but a bit
uselessly) that the other task never acquired it.  This complaint can
suppress other, more helpful, lockdep complaints, and in any case it is
a false positive.

This commit therefore switches from rt_mutex_unlock() to
rt_mutex_futex_unlock(), thereby avoiding the lockdep annotations.
Of course, if lockdep ever learns about rt_mutex_init_proxy_locked(),
addtional adjustments will be required.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/rcu/tree_plugin.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index be12d1aac840..ce069b37d961 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -485,7 +485,7 @@ void rcu_read_unlock_special(struct task_struct *t)
=20
 		/* Unboost if we were boosted. */
 		if (IS_ENABLED(CONFIG_RCU_BOOST) && drop_boost_mutex)
-			rt_mutex_unlock(&rnp->boost_mtx);
+			rt_mutex_futex_unlock(&rnp->boost_mtx);
=20
 		/*
 		 * If this was the last task on the expedited lists,
--=20
2.17.1

