From: Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH RT] futex/rtmutex: Cure RT double blocking issue
Date: Tue, 9 May 2017 17:11:10 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1705091707180.1798@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Sebastian Sewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Engleder Gerhard <eg@keba.com>
To: LKML <linux-kernel@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:41303 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751304AbdEIPLR (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 9 May 2017 11:11:17 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

RT has a problem when the wait on a futex/rtmutex got interrupted by a
timeout or a signal. task->pi_blocked_on is still set when returning from
rt_mutex_wait_proxy_lock(). The task must acquire the hash bucket lock
after this.

If the hash bucket lock is contended then the
BUG_ON(rt_mutex_real_waiter(task->pi_blocked_on)) in
task_blocks_on_rt_mutex() will trigger.

This can be avoided by clearing task->pi_blocked_on in the return path of
rt_mutex_wait_proxy_lock() which removes the task from the boosting chain
of the rtmutex. That's correct because the task is not longer blocked on
it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reported-by: Engleder Gerhard <eg@keba.com>
---
 kernel/locking/rtmutex.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -2380,6 +2380,7 @@ int rt_mutex_wait_proxy_lock(struct rt_m
 			       struct hrtimer_sleeper *to,
 			       struct rt_mutex_waiter *waiter)
 {
+	struct task_struct *tsk = current;
 	int ret;
 
 	raw_spin_lock_irq(&lock->wait_lock);
@@ -2389,6 +2390,22 @@ int rt_mutex_wait_proxy_lock(struct rt_m
 	/* sleep on the mutex */
 	ret = __rt_mutex_slowlock(lock, TASK_INTERRUPTIBLE, to, waiter, NULL);
 
+	/*
+	 * RT has a problem here when the wait got interrupted by a timeout
+	 * or a signal. task->pi_blocked_on is still set. The task must
+	 * acquire the hash bucket lock when returning from this function.
+	 *
+	 * If the hash bucket lock is contended then the
+	 * BUG_ON(rt_mutex_real_waiter(task->pi_blocked_on)) in
+	 * task_blocks_on_rt_mutex() will trigger. This can be avoided by
+	 * clearing task->pi_blocked_on which removes the task from the
+	 * boosting chain of the rtmutex. That's correct because the task
+	 * is not longer blocked on it.
+	 */
+	raw_spin_lock(&tsk->pi_lock);
+	tsk->pi_blocked_on = NULL;
+	raw_spin_unlock(&tsk->pi_lock);
+
 	raw_spin_unlock_irq(&lock->wait_lock);
 
 	return ret;
