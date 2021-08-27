Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5CB6C432BE
	for <linux-rt-users@archiver.kernel.org>; Fri, 27 Aug 2021 22:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC6ED60FE6
	for <linux-rt-users@archiver.kernel.org>; Fri, 27 Aug 2021 22:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbhH0Wtg (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 27 Aug 2021 18:49:36 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40808 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbhH0Wtd (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 27 Aug 2021 18:49:33 -0400
Date:   Sat, 28 Aug 2021 00:48:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630104522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=TPxS41XE6nFxDgMcdvB0oSAWsF7LEQbTeE9CIRz4vqY=;
        b=VOPKGft9XGBT3C7hb5vRx+Xf75x0MuIK23NF3N1NLjn3+O1NaP1UpM+ztrdXIbpEXThSrO
        AzCDZc9IsjHpY7nMbacZ5RttEvOmK6a2s1p5MzFtURQE08XnbxCOH0jOHM/1cPXng3HxXb
        hVpavTp1x8BLpnU7tKx61y+8jFGDRYt4hHt90JRHnYhCsDBmD/wZ1T/DLyXbDUZv3wBUdk
        CitXpGNbHEwfaImnVlFgeJJHQ2O+OQi+xt3qhRK9F5Ji92uX17dYiz3JqFuIfOx6708L/J
        kvGH9PhzXuvyGOwzBTZWu1AOXJfvDPlIns9QlwyT7Yh41ngpVVgYXBMEWWQtzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630104522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=TPxS41XE6nFxDgMcdvB0oSAWsF7LEQbTeE9CIRz4vqY=;
        b=RCoid/LpCqm9+2t9fGOb8uS3Vg2SBmY5jvt/onfx3/pq7ZGd2b7WeYI7LWbyL3mxeGEWQb
        tlOUodBNfVrPRBDg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.14-rc7-rt14
Message-ID: <20210827224841.4fov4nmceupfs2jy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.14-rc7-rt14 patch set. 

Changes since v5.14-rc7-rt13:

  - A few patches to the rtmutex / ww-mutex code. It addresses a few
    corner case in the deadlock handling of ww-mutex vs rtmutex. It also
    addresses an unsafe waiter access in the spin-on-owner check.
    Introduced during the locking rework, patches by Thomas Gleixner and
    Peter Zijlstra.

  - A change to the scheduler to not try to push tasks away which have
    disabled migration.

  - A change to the scheduler / wait_task_inactive() to use wakeups in
    hardirq context in order to avoid freezes during boot. This issue
    appeared to have been fixed but came back in a configuration with
    the function tracer enabled on boot.

  - In zsmalloc a warning was triggered by lockdep because a mutex_t was
    acquired within a local_lock_t section only on PREEMPT_RT. Patch by
    Mike Galbraith.

  - Avoid running balance_push() on remote runqueues during CPU-up.
    Patch by Thomas Gleixner.
    

Known issues
     - netconsole triggers WARN.

     - The "Memory controller" (CONFIG_MEMCG) has been disabled.

     - A RCU and ARM64 warning has been fixed by Valentin Schneider. It is
       still not clear if the RCU related change is correct.

     - Clark Williams reported issues in i915 (execlists_dequeue_irq())

     - Clark Williams reported issues with kcov enabled.

     - Valentin Schneider reported a few splats on ARM64, see
          https://https://lkml.kernel.org/r/.kernel.org/lkml/20210810134127.1394269-1-valentin.schneider@arm.com/

The delta patch against v5.14-rc7-rt13 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.14/incr/patch-5.14-rc7-rt13-rt14.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.14-rc7-rt14

The RT patch against v5.14-rc7 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.14/older/patch-5.14-rc7-rt14.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.14/older/patches-5.14-rc7-rt14.tar.xz

Sebastian

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index c1c480c52f0e0..1326cf3f88cae 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -656,6 +656,31 @@ static int __sched rt_mutex_adjust_prio_chain(struct task_struct *task,
 	if (next_lock != waiter->lock)
 		goto out_unlock_pi;
 
+	/*
+	 * There could be 'spurious' loops in the lock graph due to ww_mutex,
+	 * consider:
+	 *
+	 *   P1: A, ww_A, ww_B
+	 *   P2: ww_B, ww_A
+	 *   P3: A
+	 *
+	 * P3 should not return -EDEADLK because it gets trapped in the cycle
+	 * created by P1 and P2 (which will resolve -- and runs into
+	 * max_lock_depth above). Therefore disable detect_deadlock such that
+	 * the below termination condition can trigger once all relevant tasks
+	 * are boosted.
+	 *
+	 * Even when we start with ww_mutex we can disable deadlock detection,
+	 * since we would supress a ww_mutex induced deadlock at [6] anyway.
+	 * Supressing it here however is not sufficient since we might still
+	 * hit [6] due to adjustment driven iteration.
+	 *
+	 * NOTE: if someone were to create a deadlock between 2 ww_classes we'd
+	 * utterly fail to report it; lockdep should.
+	 */
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && waiter->ww_ctx && detect_deadlock)
+		detect_deadlock = false;
+
 	/*
 	 * Drop out, when the task has no waiters. Note,
 	 * top_waiter can be NULL, when we are in the deboosting
@@ -717,8 +742,21 @@ static int __sched rt_mutex_adjust_prio_chain(struct task_struct *task,
 	 * walk, we detected a deadlock.
 	 */
 	if (lock == orig_lock || rt_mutex_owner(lock) == top_task) {
-		raw_spin_unlock(&lock->wait_lock);
 		ret = -EDEADLK;
+
+		/*
+		 * When the deadlock is due to ww_mutex; also see above. Don't
+		 * report the deadlock and instead let the ww_mutex wound/die
+		 * logic pick which of the contending threads gets -EDEADLK.
+		 *
+		 * NOTE: assumes the cycle only contains a single ww_class; any
+		 * other configuration and we fail to report; also, see
+		 * lockdep.
+		 */
+		if (IS_ENABLED(CONFIG_PREEMPT_RT) && orig_waiter->ww_ctx)
+			ret = 0;
+
+		raw_spin_unlock(&lock->wait_lock);
 		goto out_unlock_pi;
 	}
 
@@ -1100,8 +1138,13 @@ static int __sched task_blocks_on_rt_mutex(struct rt_mutex_base *lock,
 		/* Check whether the waiter should back out immediately */
 		rtm = container_of(lock, struct rt_mutex, rtmutex);
 		res = __ww_mutex_add_waiter(waiter, rtm, ww_ctx);
-		if (res)
+		if (res) {
+			raw_spin_lock(&task->pi_lock);
+			rt_mutex_dequeue(lock, waiter);
+			task->pi_blocked_on = NULL;
+			raw_spin_unlock(&task->pi_lock);
 			return res;
+		}
 	}
 
 	if (!owner)
@@ -1347,8 +1390,9 @@ static bool rtmutex_spin_on_owner(struct rt_mutex_base *lock,
 		 *    for CONFIG_PREEMPT_RCU=y)
 		 *  - the VCPU on which owner runs is preempted
 		 */
-		if (!owner->on_cpu || waiter != rt_mutex_top_waiter(lock) ||
-		    need_resched() || vcpu_is_preempted(task_cpu(owner))) {
+		if (!owner->on_cpu || need_resched() ||
+		    rt_mutex_waiter_is_top_waiter(lock, waiter) ||
+		    vcpu_is_preempted(task_cpu(owner))) {
 			res = false;
 			break;
 		}
diff --git a/kernel/locking/rtmutex_common.h b/kernel/locking/rtmutex_common.h
index 61256de5bd66a..c47e8361bfb5c 100644
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -95,6 +95,19 @@ static inline int rt_mutex_has_waiters(struct rt_mutex_base *lock)
 	return !RB_EMPTY_ROOT(&lock->waiters.rb_root);
 }
 
+/*
+ * Lockless speculative check whether @waiter is still the top waiter on
+ * @lock. This is solely comparing pointers and not derefencing the
+ * leftmost entry which might be about to vanish.
+ */
+static inline bool rt_mutex_waiter_is_top_waiter(struct rt_mutex_base *lock,
+						 struct rt_mutex_waiter *waiter)
+{
+	struct rb_node *leftmost = rb_first_cached(&lock->waiters);
+
+	return rb_entry(leftmost, struct rt_mutex_waiter, tree_entry) == waiter;
+}
+
 static inline struct rt_mutex_waiter *rt_mutex_top_waiter(struct rt_mutex_base *lock)
 {
 	struct rb_node *leftmost = rb_first_cached(&lock->waiters);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 02718b6c7732d..3885f851997d9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3081,7 +3081,7 @@ unsigned long wait_task_inactive(struct task_struct *p, unsigned int match_state
 			ktime_t to = NSEC_PER_SEC / HZ;
 
 			set_current_state(TASK_UNINTERRUPTIBLE);
-			schedule_hrtimeout(&to, HRTIMER_MODE_REL);
+			schedule_hrtimeout(&to, HRTIMER_MODE_REL_HARD);
 			continue;
 		}
 
@@ -8588,7 +8588,6 @@ static void balance_push(struct rq *rq)
 	struct task_struct *push_task = rq->curr;
 
 	lockdep_assert_rq_held(rq);
-	SCHED_WARN_ON(rq->cpu != smp_processor_id());
 
 	/*
 	 * Ensure the thing is persistent until balance_push_set(.on = false);
@@ -8596,9 +8595,10 @@ static void balance_push(struct rq *rq)
 	rq->balance_callback = &balance_push_callback;
 
 	/*
-	 * Only active while going offline.
+	 * Only active while going offline and when invoked on the outgoing
+	 * CPU.
 	 */
-	if (!cpu_dying(rq->cpu))
+	if (!cpu_dying(rq->cpu) && rq == this_rq())
 		return;
 
 	/*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 096cfefc66c90..60a9ad2ba166b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2255,6 +2255,9 @@ static inline struct task_struct *get_push_task(struct rq *rq)
 	if (p->nr_cpus_allowed == 1)
 		return NULL;
 
+	if (p->migration_disabled)
+		return NULL;
+
 	rq->push_busy = true;
 	return get_task_struct(p);
 }
diff --git a/localversion-rt b/localversion-rt
index 9f7d0bdbffb18..08b3e75841adc 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt13
+-rt14
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index c55d5862416fc..d597df37bfb7c 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -82,7 +82,7 @@
 
 struct zsmalloc_handle {
 	unsigned long addr;
-	struct mutex lock;
+	spinlock_t lock;
 };
 
 #define ZS_HANDLE_ALLOC_SIZE (sizeof(struct zsmalloc_handle))
@@ -370,7 +370,7 @@ static unsigned long cache_alloc_handle(struct zs_pool *pool, gfp_t gfp)
 	if (p) {
 		struct zsmalloc_handle *zh = p;
 
-		mutex_init(&zh->lock);
+		spin_lock_init(&zh->lock);
 	}
 #endif
 	return (unsigned long)p;
@@ -927,7 +927,7 @@ static inline int testpin_tag(unsigned long handle)
 #ifdef CONFIG_PREEMPT_RT
 	struct zsmalloc_handle *zh = zs_get_pure_handle(handle);
 
-	return mutex_is_locked(&zh->lock);
+	return spin_is_locked(&zh->lock);
 #else
 	return bit_spin_is_locked(HANDLE_PIN_BIT, (unsigned long *)handle);
 #endif
@@ -938,7 +938,7 @@ static inline int trypin_tag(unsigned long handle)
 #ifdef CONFIG_PREEMPT_RT
 	struct zsmalloc_handle *zh = zs_get_pure_handle(handle);
 
-	return mutex_trylock(&zh->lock);
+	return spin_trylock(&zh->lock);
 #else
 	return bit_spin_trylock(HANDLE_PIN_BIT, (unsigned long *)handle);
 #endif
@@ -949,7 +949,7 @@ static void pin_tag(unsigned long handle) __acquires(bitlock)
 #ifdef CONFIG_PREEMPT_RT
 	struct zsmalloc_handle *zh = zs_get_pure_handle(handle);
 
-	return mutex_lock(&zh->lock);
+	return spin_lock(&zh->lock);
 #else
 	bit_spin_lock(HANDLE_PIN_BIT, (unsigned long *)handle);
 #endif
@@ -960,7 +960,7 @@ static void unpin_tag(unsigned long handle) __releases(bitlock)
 #ifdef CONFIG_PREEMPT_RT
 	struct zsmalloc_handle *zh = zs_get_pure_handle(handle);
 
-	return mutex_unlock(&zh->lock);
+	return spin_unlock(&zh->lock);
 #else
 	bit_spin_unlock(HANDLE_PIN_BIT, (unsigned long *)handle);
 #endif
