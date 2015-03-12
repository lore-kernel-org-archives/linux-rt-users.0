From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 07/39] rtmutex: Simplify remove_waiter()
Date: Thu, 12 Mar 2015 15:13:14 -0400
Message-ID: <20150312191408.255925775@goodmis.org>
References: <20150312191307.081068717@goodmis.org>
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
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.230]:7301 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751630AbbCLTPL (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 12 Mar 2015 15:15:11 -0400
Content-Disposition: inline; filename=0007-rtmutex-Simplify-remove_waiter.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

3.14.34-rt32-rc1 stable review patch.
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
	kernel/locking/rtmutex.c
---
 kernel/locking/rtmutex.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 400026ec7f05..6c74a0525dcb 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -985,7 +985,7 @@ static void wakeup_next_waiter(struct rt_mutex *lock)
 static void remove_waiter(struct rt_mutex *lock,
 			  struct rt_mutex_waiter *waiter)
 {
-	int first = (waiter == rt_mutex_top_waiter(lock));
+	bool is_top_waiter = (waiter == rt_mutex_top_waiter(lock));
 	struct task_struct *owner = rt_mutex_owner(lock);
 	struct rt_mutex *next_lock = NULL;
 	unsigned long flags;
@@ -995,30 +995,32 @@ static void remove_waiter(struct rt_mutex *lock,
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
+	raw_spin_lock_irqsave(&owner->pi_lock, flags);
 
-		raw_spin_lock_irqsave(&owner->pi_lock, flags);
+	rt_mutex_dequeue_pi(owner, waiter);
 
-		rt_mutex_dequeue_pi(owner, waiter);
+	if (rt_mutex_has_waiters(lock))
+		rt_mutex_enqueue_pi(owner, rt_mutex_top_waiter(lock));
 
-		if (rt_mutex_has_waiters(lock)) {
-			struct rt_mutex_waiter *next;
+	__rt_mutex_adjust_prio(owner);
 
-			next = rt_mutex_top_waiter(lock);
-			rt_mutex_enqueue_pi(owner, next);
-		}
-		__rt_mutex_adjust_prio(owner);
