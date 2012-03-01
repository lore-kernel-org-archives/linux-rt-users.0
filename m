From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 2/9][RFC] [PATCH 2/9] futex/rt: Fix possible lockup when taking pi_lock in proxy handler
Date: Thu, 01 Mar 2012 13:55:29 -0500
Message-ID: <20120301190345.165160680@goodmis.org>
References: <20120301185527.064629423@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Clark Williams <clark.williams@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:5167 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756345Ab2CATDr (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 1 Mar 2012 14:03:47 -0500
Content-Disposition: inline; filename=0002-futex-rt-Fix-possible-lockup-when-taking-pi_lock-in-.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

When taking the pi_lock, we must disable interrupts because the
pi_lock can also be taken in an interrupt handler.

Use raw_spin_lock_irq() instead of raw_spin_lock().

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/rtmutex.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/rtmutex.c b/kernel/rtmutex.c
index 9850dc0..b525158 100644
--- a/kernel/rtmutex.c
+++ b/kernel/rtmutex.c
@@ -1373,14 +1373,14 @@ int rt_mutex_start_proxy_lock(struct rt_mutex *lock,
 	 * PI_REQUEUE_INPROGRESS, so that if the task is waking up
 	 * it will know that we are in the process of requeuing it.
 	 */
-	raw_spin_lock(&task->pi_lock);
+	raw_spin_lock_irq(&task->pi_lock);
 	if (task->pi_blocked_on) {
-		raw_spin_unlock(&task->pi_lock);
+		raw_spin_unlock_irq(&task->pi_lock);
 		raw_spin_unlock(&lock->wait_lock);
 		return -EAGAIN;
 	}
 	task->pi_blocked_on = PI_REQUEUE_INPROGRESS;
-	raw_spin_unlock(&task->pi_lock);
+	raw_spin_unlock_irq(&task->pi_lock);
 #endif
 
 	ret = task_blocks_on_rt_mutex(lock, waiter, task, detect_deadlock);
-- 
1.7.3.4


