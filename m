From: Sebastian Sewior <bigeasy@linutronix.de>
Subject: [PATCH RT v2] futex/rtmutex: Cure RT double blocking issue
Date: Thu, 11 May 2017 17:20:54 +0200
Message-ID: <20170511152054.bpgik7etss7umxzq@linutronix.de>
References: <alpine.DEB.2.20.1705091707180.1798@nanos>
 <CANRm+Cx9msxF2jVsW6ZSXp5+u+L8yKq_KjcwBm5Bm=HLsvCK8w@mail.gmail.com>
 <alpine.DEB.2.20.1705110931240.1758@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: Wanpeng Li <kernellwp@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Engleder Gerhard <eg@keba.com>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1705110931240.1758@nanos>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

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
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 v1…v2: reset ->pi_blocked_on only in the error case.

 kernel/locking/rtmutex.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 314fc65a35b1..4675f1197f33 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -2400,6 +2400,7 @@ int rt_mutex_wait_proxy_lock(struct rt_mutex *lock,
 			       struct hrtimer_sleeper *to,
 			       struct rt_mutex_waiter *waiter)
 {
+	struct task_struct *tsk = current;
 	int ret;
 
 	raw_spin_lock_irq(&lock->wait_lock);
@@ -2409,6 +2410,24 @@ int rt_mutex_wait_proxy_lock(struct rt_mutex *lock,
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
+	if (ret) {
+		raw_spin_lock(&tsk->pi_lock);
+		tsk->pi_blocked_on = NULL;
+		raw_spin_unlock(&tsk->pi_lock);
+	}
+
 	raw_spin_unlock_irq(&lock->wait_lock);
 
 	return ret;
-- 
2.11.0
