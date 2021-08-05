Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C29A4C4338F
	for <linux-rt-users@archiver.kernel.org>; Thu,  5 Aug 2021 11:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 948206112E
	for <linux-rt-users@archiver.kernel.org>; Thu,  5 Aug 2021 11:48:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238798AbhHELs7 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 5 Aug 2021 07:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232513AbhHELs7 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 5 Aug 2021 07:48:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41482C061765;
        Thu,  5 Aug 2021 04:48:45 -0700 (PDT)
Date:   Thu, 5 Aug 2021 13:48:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628164121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=4CWYMOj5K/+9Dsnoaz9DJw6EXH78exnXAHH9daSyTIY=;
        b=YBx42bid4thUkvh16LziI3p0FlSLNMUJoGdnOUCQ9idooRrbAt4bdh80HA9bNtlq49hBHT
        bMgvROTJ+knGc8zVUonKQ0wdI5jKD56bwkIHY+L/ILS8FU6Q5p3KGBc8NaJllSaHD3EAt5
        RG332ldh2qjkt81Z6mBC8GcdsBXSOZdNwajsEJAHWBf7UOOUMAOTMgt4ovvn1nkODeUqyZ
        XN6jUUSzFJzGx8d12C5jXG+M3T4UvYh/MoF6u30GuGp/TSadnpcYh04T4Q0uhBmSI57Nnb
        CepB2K9cPB1UQGVII7g51kxg8s4wMn+22/8NA4NDjtMlOiA0ZnE2pC2FkiqT1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628164121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=4CWYMOj5K/+9Dsnoaz9DJw6EXH78exnXAHH9daSyTIY=;
        b=2N9QgUQS4gIqLxXgdJfP437KBJ+Hq5bMOsBYL8bmEHr4ich26Jg0S6t/4CnLjVG2Al1KOn
        HLjJxt/NLxhV0KAw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.14-rc4-rt6
Message-ID: <20210805114839.n4nfqqtqhvoepynn@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.14-rc4-rt6 patch set. 

Changes since v5.14-rc4-rt5:

  - The locking bits haven been updated:
    
	- Compile fixes. Regressions were reported by Mike Galbraith,
	  Daniel Wagner and Daniel Bristot de Oliveira.
    
        - Thomas Gleixner addressed Peter Zijlstra's review comments.

Known issues
     - netconsole triggers WARN.

     - The "Memory controller" (CONFIG_MEMCG) has been disabled.

     - A RCU and ARM64 warning has been fixed by Valentin Schneider. It is
       still not clear if the RCU related change is correct.

The delta patch against v5.14-rc4-rt5 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.14/incr/patch-5.14-rc4-rt5-rt6.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.14-rc4-rt6

The RT patch against v5.14-rc4 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.14/older/patch-5.14-rc4-rt6.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.14/older/patches-5.14-rc4-rt6.tar.xz

Sebastian

diff --git a/include/linux/sched.h b/include/linux/sched.h
index d3daccb0097ea..b77d65f677f66 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -127,33 +127,34 @@ struct task_group;
 	((state) & (__TASK_STOPPED | __TASK_TRACED | TASK_PARKED | TASK_DEAD))
 
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
-# debug_normal_state_change(state_value)				\
+# define debug_normal_state_change(state_value)				\
 	do {								\
 		WARN_ON_ONCE(is_special_task_state(state_value));	\
 		current->task_state_change = _THIS_IP_;			\
 	} while (0)
 
-# debug_special_state_change(state_value)				\
+# define debug_special_state_change(state_value)			\
 	do {								\
 		WARN_ON_ONCE(!is_special_task_state(state_value));	\
 		current->task_state_change = _THIS_IP_;			\
 	} while (0)
 
-# debug_rtlock_wait_set_state()						 \
+# define debug_rtlock_wait_set_state()					\
 	do {								 \
 		current->saved_state_change = current->task_state_change;\
 		current->task_state_change = _THIS_IP_;			 \
 	} while (0)
 
-# debug_rtlock_wait_restore_state()					 \
+# define debug_rtlock_wait_restore_state()				\
 	do {								 \
 		current->task_state_change = current->saved_state_change;\
 	} while (0)
+
 #else
-# debug_normal_state_change(cond)	do { } while (0)
-# debug_special_state_change(cond)	do { } while (0)
-# debug_rtlock_wait_set_state()		do { } while (0)
-# debug_rtlock_wait_restore_state()	do { } while (0)
+# define debug_normal_state_change(cond)	do { } while (0)
+# define debug_special_state_change(cond)	do { } while (0)
+# define debug_rtlock_wait_set_state()		do { } while (0)
+# define debug_rtlock_wait_restore_state()	do { } while (0)
 #endif
 
 /*
diff --git a/include/linux/spinlock_types.h b/include/linux/spinlock_types.h
index 572aa058a98a1..8a9aadbaf2938 100644
--- a/include/linux/spinlock_types.h
+++ b/include/linux/spinlock_types.h
@@ -11,46 +11,6 @@
 
 #include <linux/spinlock_types_raw.h>
 
-#define SPINLOCK_MAGIC		0xdead4ead
-
-#define SPINLOCK_OWNER_INIT	((void *)-1L)
-
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-# define RAW_SPIN_DEP_MAP_INIT(lockname)		\
-	.dep_map = {					\
-		.name = #lockname,			\
-		.wait_type_inner = LD_WAIT_SPIN,	\
-	}
-# define SPIN_DEP_MAP_INIT(lockname)			\
-	.dep_map = {					\
-		.name = #lockname,			\
-		.wait_type_inner = LD_WAIT_CONFIG,	\
-	}
-#else
-# define RAW_SPIN_DEP_MAP_INIT(lockname)
-# define SPIN_DEP_MAP_INIT(lockname)
-#endif
-
-#ifdef CONFIG_DEBUG_SPINLOCK
-# define SPIN_DEBUG_INIT(lockname)		\
-	.magic = SPINLOCK_MAGIC,		\
-	.owner_cpu = -1,			\
-	.owner = SPINLOCK_OWNER_INIT,
-#else
-# define SPIN_DEBUG_INIT(lockname)
-#endif
-
-#define __RAW_SPIN_LOCK_INITIALIZER(lockname)	\
-	{					\
-	.raw_lock = __ARCH_SPIN_LOCK_UNLOCKED,	\
-	SPIN_DEBUG_INIT(lockname)		\
-	RAW_SPIN_DEP_MAP_INIT(lockname) }
-
-#define __RAW_SPIN_LOCK_UNLOCKED(lockname)	\
-	(raw_spinlock_t) __RAW_SPIN_LOCK_INITIALIZER(lockname)
-
-#define DEFINE_RAW_SPINLOCK(x)	raw_spinlock_t x = __RAW_SPIN_LOCK_UNLOCKED(x)
-
 #ifndef CONFIG_PREEMPT_RT
 
 /* Non PREEMPT_RT kernels map spinlock to raw_spinlock */
diff --git a/kernel/futex.c b/kernel/futex.c
index c05a33a2f865c..41e3d63160a78 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1896,14 +1896,14 @@ static inline void futex_requeue_pi_complete(struct futex_q *q, int locked)
 		if (locked >= 0) {
 			/* Requeue succeeded. Set DONE or LOCKED */
 			WARN_ON_ONCE(old != Q_REQUEUE_PI_IN_PROGRESS &&
-				     old != Q_REQUEUE_PI_WAIT)
+				     old != Q_REQUEUE_PI_WAIT);
 			new = Q_REQUEUE_PI_DONE + locked;
 		} else if (old == Q_REQUEUE_PI_IN_PROGRESS) {
 			/* Deadlock, no early wakeup interleave */
 			new = Q_REQUEUE_PI_NONE;
 		} else {
 			/* Deadlock, early wakeup interleave. */
-			WARN_ON_ONCE(old != Q_REQUEUE_PI_IN_WAIT);
+			WARN_ON_ONCE(old != Q_REQUEUE_PI_WAIT);
 			new = Q_REQUEUE_PI_IGNORE;
 		}
 	} while (!atomic_try_cmpxchg(&q->requeue_state, &old, new));
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index eadaface1fd29..7522c3abacb6c 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1303,7 +1303,8 @@ static bool rtmutex_adaptive_spinwait(struct rt_mutex_base *lock,
 		 * checking the above to be valid.
 		 */
 		barrier();
-		if (!owner->on_cpu) {
+		if (!owner->on_cpu || need_resched() ||
+		    vcpu_is_preempted(task_cpu(owner))) {
 			res = false;
 			break;
 		}
diff --git a/kernel/locking/spinlock_rt.c b/kernel/locking/spinlock_rt.c
index dd23fbbc89c65..d54681d6ad078 100644
--- a/kernel/locking/spinlock_rt.c
+++ b/kernel/locking/spinlock_rt.c
@@ -11,7 +11,7 @@
  *   during that time are redirected to the saved state so no wake up is
  *   missed.
  *
- * - Non RT spin/rw_locks disable preemption and evtl. interrupts.
+ * - Non RT spin/rw_locks disable preemption and eventually interrupts.
  *   Disabling preemption has the side effect of disabling migration and
  *   preventing RCU grace periods.
  *
diff --git a/localversion-rt b/localversion-rt
index 0efe7ba1930e1..8fc605d806670 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt5
+-rt6
