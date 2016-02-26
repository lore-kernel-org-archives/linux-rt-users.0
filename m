From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 04/10] rtmutex: Use chainwalking control enum
Date: Fri, 26 Feb 2016 16:39:15 -0500
Message-ID: <20160226213931.629140540@goodmis.org>
References: <20160226213911.445523575@goodmis.org>
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
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:52248 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423494AbcBZWUu (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 26 Feb 2016 17:20:50 -0500
Content-Disposition: inline; filename=0004-rtmutex-Use-chainwalking-control-enum.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

3.12.54-rt73-rc1 stable review patch.
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
 kernel/rtmutex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rtmutex.c b/kernel/rtmutex.c
index 03439f1bc5ea..8061201b3163 100644
--- a/kernel/rtmutex.c
+++ b/kernel/rtmutex.c
@@ -1182,7 +1182,7 @@ static void  noinline __sched rt_spin_lock_slowlock(struct rt_mutex *lock)
 	__set_current_state(TASK_UNINTERRUPTIBLE);
 	pi_unlock(&self->pi_lock);
 
-	ret = task_blocks_on_rt_mutex(lock, &waiter, self, 0);
+	ret = task_blocks_on_rt_mutex(lock, &waiter, self, RT_MUTEX_MIN_CHAINWALK);
 	BUG_ON(ret);
 
 	for (;;) {
-- 
2.7.0


