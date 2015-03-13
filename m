From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 08/31] rtmutex: Simplify remove_waiter()
Date: Fri, 13 Mar 2015 11:15:02 -0400
Message-ID: <20150313151516.157818183@goodmis.org>
References: <20150313151454.809081378@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Lai Jiangshan <laijs@cn.fujitsu.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0008-rtmutex-Simplify-remove_waiter.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.10.70-rt75-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

upstream commit: 1ca7b86062ec8473d03c5cdfd336abc8b1c8098c

Exit right away, when the removed waiter was not the top priority
waiter on the lock. Get rid of the extra indent level.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Steven Rostedt <rostedt@goodmis.org>
Reviewed-by: Lai Jiangshan <laijs@cn.fujitsu.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Conflicts:
	kernel/rtmutex.c
---
 kernel/rtmutex.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/kernel/rtmutex.c b/kernel/rtmutex.c
index b6c48cb7f337..823f782b1847 100644
--- a/kernel/rtmutex.c
+++ b/kernel/rtmutex.c
@@ -898,7 +898,7 @@ static void wakeup_next_waiter(struct rt_mutex *lock)
 static void remove_waiter(struct rt_mutex *lock,
 			  struct rt_mutex_waiter *waiter)
 {
-	int first = (waiter == rt_mutex_top_waiter(lock));
+	bool is_top_waiter = (waiter == rt_mutex_top_waiter(lock));
 	struct task_struct *owner = rt_mutex_owner(lock);
 	struct rt_mutex *next_lock = NULL;
 	unsigned long flags;
@@ -908,31 +908,34 @@ static void remove_waiter(struct rt_mutex *lock,
 	current->pi_blocked_on = NULL;
 	raw_spin_unlock_irqrestore(&current->pi_lock, flags);
 
-	if (!owner)
+	/*
+	 * Only update priority if the waiter was the highest priority
+	 * waiter of the lock and there is an owner to update.
+	 */
+	if (!owner || !is_top_waiter)
 		return;
 
-	if (first) {
-
-		raw_spin_lock_irqsave(&owner->pi_lock, flags);
+	raw_spin_lock_irqsave(&owner->pi_lock, flags);
 
-		rt_mutex_dequeue_pi(owner, waiter);
+	rt_mutex_dequeue_pi(owner, waiter);
 
-		if (rt_mutex_has_waiters(lock)) {
-			struct rt_mutex_waiter *next;
+	if (rt_mutex_has_waiters(lock))
+		rt_mutex_enqueue_pi(owner, rt_mutex_top_waiter(lock));
 
-			next = rt_mutex_top_waiter(lock);
-			rt_mutex_enqueue_pi(owner, next);
-		}
-		__rt_mutex_adjust_prio(owner);
+	__rt_mutex_adjust_prio(owner);
 
-		/* Store the lock on which owner is blocked or NULL */
+	/* Store the lock on which owner is blocked or NULL */
+	if (rt_mutex_real_waiter(owner->pi_blocked_on))
 		next_lock = task_blocked_on_lock(owner);
 
-		raw_spin_unlock_irqrestore(&owner->pi_lock, flags);
-	}
+	raw_spin_unlock_irqrestore(&owner->pi_lock, flags);
 
 	WARN_ON(!plist_node_empty(&waiter->pi_list_entry));
 
+	/*
+	 * Don't walk the chain, if the owner task is not blocked
+	 * itself.
+	 */
 	if (!next_lock)
 		return;
 
-- 
2.1.4
