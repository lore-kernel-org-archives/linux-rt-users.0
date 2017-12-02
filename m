From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 13/15] locking/rtmutex: dont drop the wait_lock twice
Date: Fri, 01 Dec 2017 19:02:02 -0500
Message-ID: <20171202000428.695865910@goodmis.org>
References: <20171202000149.842718953@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com, Alex Shi <alex.shi@linaro.org>,
        Gusenleitner Klaus <gus@keba.com>
To: linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0013-locking-rtmutex-don-t-drop-the-wait_lock-twice.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

4.9.65-rt57-rc2 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Since the futex rework, __rt_mutex_start_proxy_lock() does no longer
acquire the wait_lock so it must not drop it. Otherwise the lock is not
only unlocked twice but also the preemption counter is underflown.

It is okay to remove that line because this function does not disable
interrupts nor does it acquire the ->wait_lock. The caller does this so it is
wrong do it here (after the futex rework).

Cc: stable-rt@vger.kernel.org #v4.9.18-rt14+
Reported-by: Gusenleitner Klaus <gus@keba.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/locking/rtmutex.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 5dbf6789383b..3a8b5d44aaf8 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -2312,7 +2312,6 @@ int __rt_mutex_start_proxy_lock(struct rt_mutex *lock,
 	raw_spin_lock(&task->pi_lock);
 	if (task->pi_blocked_on) {
 		raw_spin_unlock(&task->pi_lock);
-		raw_spin_unlock_irq(&lock->wait_lock);
 		return -EAGAIN;
 	}
 	task->pi_blocked_on = PI_REQUEUE_INPROGRESS;
-- 
2.13.2
