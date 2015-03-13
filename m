From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 03/27] rtmutex: Simplify rtmutex_slowtrylock()
Date: Fri, 13 Mar 2015 11:17:44 -0400
Message-ID: <20150313151755.417150799@goodmis.org>
References: <20150313151741.132137234@goodmis.org>
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
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0003-rtmutex-Simplify-rtmutex_slowtrylock.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.4.106-rt132-rc1 stable review patch.
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
index 98d563b18c0e..9eea0d8548b7 100644
--- a/kernel/rtmutex.c
+++ b/kernel/rtmutex.c
@@ -1251,24 +1251,33 @@ rt_mutex_slowlock(struct rt_mutex *lock, int state,
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
