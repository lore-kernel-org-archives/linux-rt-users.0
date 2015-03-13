From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 03/31] rtmutex: Simplify rtmutex_slowtrylock()
Date: Fri, 13 Mar 2015 11:14:57 -0400
Message-ID: <20150313151515.365546754@goodmis.org>
References: <20150313151454.809081378@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Lai Jiangshan <laijs@cn.fujitsu.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0117.hostedemail.com ([216.40.44.117]:44354 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755878AbbCMPPS (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 13 Mar 2015 11:15:18 -0400
Content-Disposition: inline; filename=0003-rtmutex-Simplify-rtmutex_slowtrylock.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

3.10.70-rt75-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

upstream-commit: 88f2b4c15e561bb5c28709d666364f273bf54b98

Oleg noticed that rtmutex_slowtrylock() has a pointless check for
rt_mutex_owner(lock) != current.

To avoid calling try_to_take_rtmutex() we really want to check whether
the lock has an owner at all or whether the trylock failed because the
owner is NULL, but the RT_MUTEX_HAS_WAITERS bit is set. This covers
the lock is owned by caller situation as well.

We can actually do this check lockless. trylock is taking a chance
whether we take lock->wait_lock to do the check or not.

Add comments to the function while at it.

Reported-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Steven Rostedt <rostedt@goodmis.org>
Reviewed-by: Lai Jiangshan <laijs@cn.fujitsu.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Conflicts:
	kernel/rtmutex.c
---
 kernel/rtmutex.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/kernel/rtmutex.c b/kernel/rtmutex.c
index 7cd751bb891a..c9989ae1cfa5 100644
--- a/kernel/rtmutex.c
+++ b/kernel/rtmutex.c
@@ -1255,24 +1255,33 @@ rt_mutex_slowlock(struct rt_mutex *lock, int state,
 /*
  * Slow path try-lock function:
  */
-static inline int
-rt_mutex_slowtrylock(struct rt_mutex *lock)
+static inline int rt_mutex_slowtrylock(struct rt_mutex *lock)
 {
-	int ret = 0;
+	int ret;
 
+	/*
+	 * If the lock already has an owner we fail to get the lock.
+	 * This can be done without taking the @lock->wait_lock as
+	 * it is only being read, and this is a trylock anyway.
+	 */
+	if (rt_mutex_owner(lock))
+		return 0;
+
+	/*
+	 * The mutex has currently no owner. Lock the wait lock and
+	 * try to acquire the lock.
+	 */
 	if (!raw_spin_trylock(&lock->wait_lock))
-		return ret;
+		return 0;
 	init_lists(lock);
 
-	if (likely(rt_mutex_owner(lock) != current)) {
+	ret = try_to_take_rt_mutex(lock, current, NULL);
 
-		ret = try_to_take_rt_mutex(lock, current, NULL);
-		/*
-		 * try_to_take_rt_mutex() sets the lock waiters
-		 * bit unconditionally. Clean this up.
-		 */
-		fixup_rt_mutex_waiters(lock);
-	}
+	/*
+	 * try_to_take_rt_mutex() sets the lock waiters bit
+	 * unconditionally. Clean this up.
+	 */
+	fixup_rt_mutex_waiters(lock);
 
 	raw_spin_unlock(&lock->wait_lock);
 
-- 
2.1.4


