From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [ANNOUNCE] 3.18.7-rt2
Date: Tue, 24 Feb 2015 14:41:41 +0100
Message-ID: <1424785301.8767.11.camel@gmail.com>
References: <20150223090617.GA26453@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>,
	Gustavo Bittencourt <gbitten@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150223090617.GA26453@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 2015-02-23 at 10:06 +0100, Sebastian Andrzej Siewior wrote:

> - a patch to properly use the rtmutex deadlock detector in ww-mutex
>   which seems to cure a nouveau deadlock (Gustavo Bittencourt)

How about the below instead.  In 4.0.0-rt, i915 deadlocked, and the
below fixed that.  DRM doesn't actually _work_ in 4.0-rt mind you,
there's something else lurking as well, but the locking is now happy,
and 3.18-rt continues to work just fine.


locking, ww_mutex: fix ww_mutex vs self-deadlock

If the caller already holds the mutex, task_blocks_on_rt_mutex()
returns -EDEADLK, we proceed directly to rt_mutex_handle_deadlock()
where it's instant game over.

Let ww_mutexes return EDEADLK/EALREADY as they want to instead.

Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>
---
 kernel/locking/rtmutex.c |   17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1706,8 +1706,12 @@ rt_mutex_slowlock(struct rt_mutex *lock,
 	ret = task_blocks_on_rt_mutex(lock, &waiter, current, chwalk);
 
 	if (likely(!ret))
-		ret = __rt_mutex_slowlock(lock, state, timeout, &waiter,
-					  ww_ctx);
+		ret = __rt_mutex_slowlock(lock, state, timeout, &waiter, ww_ctx);
+	else if (ww_ctx) {
+		/* ww_mutex received EDEADLK, let it become EALREADY */
+		ret = __mutex_lock_check_stamp(lock, ww_ctx);
+		BUG_ON(!ret);
+	}
 
 	set_current_state(TASK_RUNNING);
 
@@ -1715,6 +1719,9 @@ rt_mutex_slowlock(struct rt_mutex *lock,
 		if (rt_mutex_has_waiters(lock))
 			remove_waiter(lock, &waiter);
 		rt_mutex_handle_deadlock(ret, chwalk, &waiter);
+		/* ww_mutex want to report EDEADLK/EALREADY, let them */
+		if (!ww_ctx)
+			rt_mutex_handle_deadlock(ret, chwalk, &waiter);
 	} else if (ww_ctx) {
 		ww_mutex_account_lock(lock, ww_ctx);
 	}
@@ -2258,8 +2265,7 @@ __ww_mutex_lock_interruptible(struct ww_
 	might_sleep();
 
 	mutex_acquire_nest(&lock->base.dep_map, 0, 0, &ww_ctx->dep_map, _RET_IP_);
-	ret = rt_mutex_slowlock(&lock->base.lock, TASK_INTERRUPTIBLE, NULL,
-				RT_MUTEX_FULL_CHAINWALK, ww_ctx);
+	ret = rt_mutex_slowlock(&lock->base.lock, TASK_INTERRUPTIBLE, NULL, 0, ww_ctx);
 	if (ret)
 		mutex_release(&lock->base.dep_map, 1, _RET_IP_);
 	else if (!ret && ww_ctx->acquired > 1)
@@ -2277,8 +2283,7 @@ __ww_mutex_lock(struct ww_mutex *lock, s
 	might_sleep();
 
 	mutex_acquire_nest(&lock->base.dep_map, 0, 0, &ww_ctx->dep_map, _RET_IP_);
-	ret = rt_mutex_slowlock(&lock->base.lock, TASK_UNINTERRUPTIBLE, NULL,
-				RT_MUTEX_FULL_CHAINWALK, ww_ctx);
+	ret = rt_mutex_slowlock(&lock->base.lock, TASK_UNINTERRUPTIBLE, NULL, 0, ww_ctx);
 	if (ret)
 		mutex_release(&lock->base.dep_map, 1, _RET_IP_);
 	else if (!ret && ww_ctx->acquired > 1)
