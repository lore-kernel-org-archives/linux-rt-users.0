From: bmouring@ni.com
Subject: [PATCH] rtmutex: Use chainwalking control enum
Date: Tue, 15 Dec 2015 17:07:30 -0600
Message-ID: <1450220850-31632-1-git-send-email-brad.mouring@ni.com>
Cc: linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Brad Mouring <brad.mouring@ni.com>
To: linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

In 8930ed80 (rtmutex: Cleanup deadlock detector debug logic),
chainwalking control enums were introduced to limit the deadlock
detection logic. One of the calls to task_blocks_on_rt_mutex was
missed when converting to use the enums.

Signed-off-by: Brad Mouring <brad.mouring@ni.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/locking/rtmutex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 2026759..e0b0d9b 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1008,7 +1008,7 @@ static void  noinline __sched rt_spin_lock_slowlock(struct rt_mutex *lock)
 	__set_current_state_no_track(TASK_UNINTERRUPTIBLE);
 	pi_unlock(&self->pi_lock);
 
-	ret = task_blocks_on_rt_mutex(lock, &waiter, self, 0);
+	ret = task_blocks_on_rt_mutex(lock, &waiter, self, RT_MUTEX_MIN_CHAINWALK);
 	BUG_ON(ret);
 
 	for (;;) {
-- 
2.6.4
