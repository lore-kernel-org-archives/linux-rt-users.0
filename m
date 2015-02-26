From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [ANNOUNCE] 3.18.7-rt2
Date: Thu, 26 Feb 2015 09:02:05 +0100
Message-ID: <1424937725.3622.31.camel@gmail.com>
References: <20150223090617.GA26453@linutronix.de>
	 <1424785301.8767.11.camel@gmail.com>
	 <CAA8Xd+9QEn0XE2pV-7fW0cBXKBSK9=oZyTaFH2urGvJLGb=gFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: Gustavo Bittencourt <gbitten@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAA8Xd+9QEn0XE2pV-7fW0cBXKBSK9=oZyTaFH2urGvJLGb=gFw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 2015-02-24 at 13:19 -0300, Gustavo Bittencourt wrote:

> The deadlock returned after I applied this patch in v3.18.7-rt2.

Grr, because dummy here munged a reject when he backported to 3.18-rt.
Please try the below, my trusty old Q6600 box is now running with
nouveau/drm in both 3.18-rt and 4.0-rt.

I found what was breaking my core2 lappy in 4.0-rt as well, namely the
rtmutex.c set_current_state() munging that went into mainline recently,
and that also broke my Q6600 box with nouveau/drm as well!  Seems you
need a slow box and drm to experience the breakage nice and repeatably,
which is kinda worrisome.  Anyway, all of my boxen can use drm just fine
in both rt trees now, so your box _should_ be happy too.

WRT nouveau locking, per lockdep it has at least one rt issue with or
without my patch. i915 OTOH runs lockdep clean.


locking, ww_mutex: fix ww_mutex vs self-deadlock

If the caller already holds the mutex, task_blocks_on_rt_mutex()
returns -EDEADLK, we proceed directly to rt_mutex_handle_deadlock()
where it's instant game over.

Let ww_mutexes return EDEADLK/EALREADY as they want to instead.

Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>
---
 kernel/locking/rtmutex.c |   24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1706,15 +1706,21 @@ rt_mutex_slowlock(struct rt_mutex *lock,
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
 
 	if (unlikely(ret)) {
 		if (rt_mutex_has_waiters(lock))
 			remove_waiter(lock, &waiter);
-		rt_mutex_handle_deadlock(ret, chwalk, &waiter);
+		/* ww_mutex want to report EDEADLK/EALREADY, let them */
+		if (!ww_ctx)
+			rt_mutex_handle_deadlock(ret, chwalk, &waiter);
 	} else if (ww_ctx) {
 		ww_mutex_account_lock(lock, ww_ctx);
 	}
@@ -2258,8 +2264,7 @@ __ww_mutex_lock_interruptible(struct ww_
 	might_sleep();
 
 	mutex_acquire_nest(&lock->base.dep_map, 0, 0, &ww_ctx->dep_map, _RET_IP_);
-	ret = rt_mutex_slowlock(&lock->base.lock, TASK_INTERRUPTIBLE, NULL,
-				RT_MUTEX_FULL_CHAINWALK, ww_ctx);
+	ret = rt_mutex_slowlock(&lock->base.lock, TASK_INTERRUPTIBLE, NULL, 0, ww_ctx);
 	if (ret)
 		mutex_release(&lock->base.dep_map, 1, _RET_IP_);
 	else if (!ret && ww_ctx->acquired > 1)
@@ -2277,8 +2282,7 @@ __ww_mutex_lock(struct ww_mutex *lock, s
 	might_sleep();
 
 	mutex_acquire_nest(&lock->base.dep_map, 0, 0, &ww_ctx->dep_map, _RET_IP_);
-	ret = rt_mutex_slowlock(&lock->base.lock, TASK_UNINTERRUPTIBLE, NULL,
-				RT_MUTEX_FULL_CHAINWALK, ww_ctx);
+	ret = rt_mutex_slowlock(&lock->base.lock, TASK_UNINTERRUPTIBLE, NULL, 0, ww_ctx);
 	if (ret)
 		mutex_release(&lock->base.dep_map, 1, _RET_IP_);
 	else if (!ret && ww_ctx->acquired > 1)
@@ -2290,11 +2294,13 @@ EXPORT_SYMBOL_GPL(__ww_mutex_lock);
 
 void __sched ww_mutex_unlock(struct ww_mutex *lock)
 {
+	int nest = !!lock->ctx;
+
 	/*
 	 * The unlocking fastpath is the 0->1 transition from 'locked'
 	 * into 'unlocked' state:
 	 */
-	if (lock->ctx) {
+	if (nest) {
 #ifdef CONFIG_DEBUG_MUTEXES
 		DEBUG_LOCKS_WARN_ON(!lock->ctx->acquired);
 #endif
@@ -2303,7 +2309,7 @@ void __sched ww_mutex_unlock(struct ww_m
 		lock->ctx = NULL;
 	}
 
-	mutex_release(&lock->base.dep_map, 1, _RET_IP_);
+	mutex_release(&lock->base.dep_map, nest, _RET_IP_);
 	rt_mutex_unlock(&lock->base.lock);
 }
 EXPORT_SYMBOL(ww_mutex_unlock);
