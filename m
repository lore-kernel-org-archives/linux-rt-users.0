From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 04/10] rtmutex: Use chainwalking control enum
Date: Fri, 26 Feb 2016 16:35:55 -0500
Message-ID: <20160226213708.749464933@goodmis.org>
References: <20160226213551.557375746@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Brad Mouring <brad.mouring@ni.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0004-rtmutex-Use-chainwalking-control-enum.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.14.61-rt63-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: "bmouring@ni.com" <bmouring@ni.com>

In 8930ed80 (rtmutex: Cleanup deadlock detector debug logic),
chainwalking control enums were introduced to limit the deadlock
detection logic. One of the calls to task_blocks_on_rt_mutex was
missed when converting to use the enums.

Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Brad Mouring <brad.mouring@ni.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/locking/rtmutex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 2f61c66d6f05..4bd9790dece5 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1251,7 +1251,7 @@ static void  noinline __sched rt_spin_lock_slowlock(struct rt_mutex *lock)
 	__set_current_state(TASK_UNINTERRUPTIBLE);
 	pi_unlock(&self->pi_lock);
 
-	ret = task_blocks_on_rt_mutex(lock, &waiter, self, 0);
+	ret = task_blocks_on_rt_mutex(lock, &waiter, self, RT_MUTEX_MIN_CHAINWALK);
 	BUG_ON(ret);
 
 	for (;;) {
-- 
2.7.0
