From: Julia Cartwright <julia@ni.com>
Subject: [PATCH RT 07/22] rcu: Suppress lockdep false-positive ->boost_mtx complaints
Date: Mon,  6 Aug 2018 04:17:23 -0500
Message-ID: <fa640586f03981ed83a1b260742b4cc600342e4a.1533540554.git.julia@ni.com>
References: <cover.1533540554.git.julia@ni.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1533540554.git.julia@ni.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

4.9.115-rt94-rc1 stable review patch.
If you have any objection to the inclusion of this patch, let me know.

--- 8< --- 8< --- 8< ---
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
Signed-off-by: Julia Cartwright <julia@ni.com>
---
 kernel/rcu/tree_plugin.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 3d18d08e8382..510de72ad8a3 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -486,7 +486,7 @@ void rcu_read_unlock_special(struct task_struct *t)
 
 		/* Unboost if we were boosted. */
 		if (IS_ENABLED(CONFIG_RCU_BOOST) && drop_boost_mutex)
-			rt_mutex_unlock(&rnp->boost_mtx);
+			rt_mutex_futex_unlock(&rnp->boost_mtx);
 
 		/*
 		 * If this was the last task on the expedited lists,
-- 
2.18.0
