From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 05/25] rtmutex: No need to keep task ref for lock owner check
Date: Fri, 13 Mar 2015 11:18:30 -0400
Message-ID: <20150313151834.941479507@goodmis.org>
References: <20150313151825.583263173@goodmis.org>
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
Content-Disposition: inline; filename=0005-rtmutex-No-need-to-keep-task-ref-for-lock-owner-chec.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.2.68-rt99-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

upstream commit: 2ffa5a5cd2fe792b6399c903d5172adf088d8ff7

There is no point to keep the task ref across the check for lock
owner. Drop the ref before that, so the protection context is clear.

Found while documenting the chain walk.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Steven Rostedt <rostedt@goodmis.org>
Reviewed-by: Lai Jiangshan <laijs@cn.fujitsu.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/rtmutex.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/rtmutex.c b/kernel/rtmutex.c
index a74c57a75269..7d338c8b23b9 100644
--- a/kernel/rtmutex.c
+++ b/kernel/rtmutex.c
@@ -407,6 +407,8 @@ static int rt_mutex_adjust_prio_chain(struct task_struct *task,
 
 	/* Release the task */
 	raw_spin_unlock_irqrestore(&task->pi_lock, flags);
+	put_task_struct(task);
+
 	if (!rt_mutex_owner(lock)) {
 		struct rt_mutex_waiter *lock_top_waiter;
 
@@ -418,9 +420,8 @@ static int rt_mutex_adjust_prio_chain(struct task_struct *task,
 		if (top_waiter != lock_top_waiter)
 			rt_mutex_wake_waiter(lock_top_waiter);
 		raw_spin_unlock(&lock->wait_lock);
-		goto out_put_task;
+		return 0;
 	}
-	put_task_struct(task);
 
 	/* Grab the next task */
 	task = rt_mutex_owner(lock);
-- 
2.1.4
