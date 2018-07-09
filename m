Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from Galois.linutronix.de ([146.0.238.70]:60337 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754011AbeGIJ6M (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 9 Jul 2018 05:58:12 -0400
Date: Mon, 9 Jul 2018 11:58:08 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH RT 7/6] rcu: Do not include rtmutex_common.h unconditionally
Message-ID: <20180709095807.7lhflcfgy3yujt6z@linutronix.de>
References: <20180606133131.7747-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180606133131.7747-1-bigeasy@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: julia@ni.com
Cc: linux-rt-users@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>

[ upstream commit b88697810d7c1d102a529990f9071b0f14cfe6df ]

This commit adjusts include files and provides definitions in preparation
for suppressing lockdep false-positive ->boost_mtx complaints.  Without
this preparation, architectures not supporting rt_mutex will get build
failures.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---

Without this one we get build failures for RCU_BOOST=n. It would make
sense to apply this one before

   [PATCH 6/6] rcu: Suppress lockdep false-positive ->boost_mtx complaints

 kernel/rcu/tree_plugin.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index ce069b37d961..d97eedd9c6d4 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -37,6 +37,7 @@
  * This probably needs to be excluded from -rt builds.
  */
 #define rt_mutex_owner(a) ({ WARN_ON_ONCE(1); NULL; })
+#define rt_mutex_futex_unlock(x) WARN_ON_ONCE(1)
 
 #endif /* #else #ifdef CONFIG_RCU_BOOST */
 
@@ -828,8 +829,6 @@ static void rcu_cpu_kthread_setup(unsigned int cpu)
 
 #ifdef CONFIG_RCU_BOOST
 
-#include "../locking/rtmutex_common.h"
-
 #ifdef CONFIG_RCU_TRACE
 
 static void rcu_initiate_boost_trace(struct rcu_node *rnp)
-- 
2.18.0

