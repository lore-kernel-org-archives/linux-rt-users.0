Return-Path: <SRS0=sFXS=XG=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E343C49ED6
	for <linux-rt-users@archiver.kernel.org>; Wed, 11 Sep 2019 16:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 221402089F
	for <linux-rt-users@archiver.kernel.org>; Wed, 11 Sep 2019 16:57:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbfIKQ5o (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 11 Sep 2019 12:57:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50418 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729028AbfIKQ5o (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 11 Sep 2019 12:57:44 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D763059449;
        Wed, 11 Sep 2019 16:57:43 +0000 (UTC)
Received: from t460p.redhat.com (ovpn-117-113.phx2.redhat.com [10.3.117.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EADD860BEC;
        Wed, 11 Sep 2019 16:57:40 +0000 (UTC)
From:   Scott Wood <swood@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Scott Wood <swood@redhat.com>
Subject: [PATCH RT v3 2/5] sched: Rename sleeping_lock to rt_invol_sleep
Date:   Wed, 11 Sep 2019 17:57:26 +0100
Message-Id: <20190911165729.11178-3-swood@redhat.com>
In-Reply-To: <20190911165729.11178-1-swood@redhat.com>
References: <20190911165729.11178-1-swood@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 11 Sep 2019 16:57:43 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

It's already used for one situation other than acquiring a lock, and the
next patch will add another, so change the name to avoid confusion.

Signed-off-by: Scott Wood <swood@redhat.com>
---
 include/linux/sched.h      | 15 ++++++++-------
 kernel/locking/rtmutex.c   | 14 +++++++-------
 kernel/locking/rwlock-rt.c | 16 ++++++++--------
 kernel/rcu/tree_plugin.h   |  6 +++---
 kernel/softirq.c           |  2 +-
 kernel/time/hrtimer.c      |  4 ++--
 6 files changed, 29 insertions(+), 28 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 7e892e727f12..edc93b74f7d8 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -674,7 +674,8 @@ struct task_struct {
 # endif
 #endif
 #ifdef CONFIG_PREEMPT_RT_FULL
-	int				sleeping_lock;
+	/* Task is blocking due to RT-specific mechanisms, not voluntarily */
+	int				rt_invol_sleep;
 #endif
 
 #ifdef CONFIG_PREEMPT_RCU
@@ -1882,20 +1883,20 @@ static __always_inline bool need_resched(void)
 }
 
 #ifdef CONFIG_PREEMPT_RT_FULL
-static inline void sleeping_lock_inc(void)
+static inline void rt_invol_sleep_inc(void)
 {
-	current->sleeping_lock++;
+	current->rt_invol_sleep++;
 }
 
-static inline void sleeping_lock_dec(void)
+static inline void rt_invol_sleep_dec(void)
 {
-	current->sleeping_lock--;
+	current->rt_invol_sleep--;
 }
 
 #else
 
-static inline void sleeping_lock_inc(void) { }
-static inline void sleeping_lock_dec(void) { }
+static inline void rt_invol_sleep_inc(void) { }
+static inline void rt_invol_sleep_dec(void) { }
 #endif
 
 /*
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 5ccbb45131e5..d7100586c597 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1135,7 +1135,7 @@ void __sched rt_spin_lock_slowunlock(struct rt_mutex *lock)
 
 void __lockfunc rt_spin_lock(spinlock_t *lock)
 {
-	sleeping_lock_inc();
+	rt_invol_sleep_inc();
 	migrate_disable();
 	spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
 	rt_spin_lock_fastlock(&lock->lock, rt_spin_lock_slowlock);
@@ -1150,7 +1150,7 @@ void __lockfunc __rt_spin_lock(struct rt_mutex *lock)
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 void __lockfunc rt_spin_lock_nested(spinlock_t *lock, int subclass)
 {
-	sleeping_lock_inc();
+	rt_invol_sleep_inc();
 	migrate_disable();
 	spin_acquire(&lock->dep_map, subclass, 0, _RET_IP_);
 	rt_spin_lock_fastlock(&lock->lock, rt_spin_lock_slowlock);
@@ -1164,7 +1164,7 @@ void __lockfunc rt_spin_unlock(spinlock_t *lock)
 	spin_release(&lock->dep_map, 1, _RET_IP_);
 	rt_spin_lock_fastunlock(&lock->lock, rt_spin_lock_slowunlock);
 	migrate_enable();
-	sleeping_lock_dec();
+	rt_invol_sleep_dec();
 }
 EXPORT_SYMBOL(rt_spin_unlock);
 
@@ -1190,14 +1190,14 @@ int __lockfunc rt_spin_trylock(spinlock_t *lock)
 {
 	int ret;
 
-	sleeping_lock_inc();
+	rt_invol_sleep_inc();
 	migrate_disable();
 	ret = __rt_mutex_trylock(&lock->lock);
 	if (ret) {
 		spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
 	} else {
 		migrate_enable();
-		sleeping_lock_dec();
+		rt_invol_sleep_dec();
 	}
 	return ret;
 }
@@ -1210,7 +1210,7 @@ int __lockfunc rt_spin_trylock_bh(spinlock_t *lock)
 	local_bh_disable();
 	ret = __rt_mutex_trylock(&lock->lock);
 	if (ret) {
-		sleeping_lock_inc();
+		rt_invol_sleep_inc();
 		migrate_disable();
 		spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
 	} else
@@ -1226,7 +1226,7 @@ int __lockfunc rt_spin_trylock_irqsave(spinlock_t *lock, unsigned long *flags)
 	*flags = 0;
 	ret = __rt_mutex_trylock(&lock->lock);
 	if (ret) {
-		sleeping_lock_inc();
+		rt_invol_sleep_inc();
 		migrate_disable();
 		spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
 	}
diff --git a/kernel/locking/rwlock-rt.c b/kernel/locking/rwlock-rt.c
index c3b91205161c..de025a7cc9c4 100644
--- a/kernel/locking/rwlock-rt.c
+++ b/kernel/locking/rwlock-rt.c
@@ -305,14 +305,14 @@ int __lockfunc rt_read_trylock(rwlock_t *rwlock)
 {
 	int ret;
 
-	sleeping_lock_inc();
+	rt_invol_sleep_inc();
 	migrate_disable();
 	ret = do_read_rt_trylock(rwlock);
 	if (ret) {
 		rwlock_acquire_read(&rwlock->dep_map, 0, 1, _RET_IP_);
 	} else {
 		migrate_enable();
-		sleeping_lock_dec();
+		rt_invol_sleep_dec();
 	}
 	return ret;
 }
@@ -322,14 +322,14 @@ int __lockfunc rt_write_trylock(rwlock_t *rwlock)
 {
 	int ret;
 
-	sleeping_lock_inc();
+	rt_invol_sleep_inc();
 	migrate_disable();
 	ret = do_write_rt_trylock(rwlock);
 	if (ret) {
 		rwlock_acquire(&rwlock->dep_map, 0, 1, _RET_IP_);
 	} else {
 		migrate_enable();
-		sleeping_lock_dec();
+		rt_invol_sleep_dec();
 	}
 	return ret;
 }
@@ -337,7 +337,7 @@ int __lockfunc rt_write_trylock(rwlock_t *rwlock)
 
 void __lockfunc rt_read_lock(rwlock_t *rwlock)
 {
-	sleeping_lock_inc();
+	rt_invol_sleep_inc();
 	migrate_disable();
 	rwlock_acquire_read(&rwlock->dep_map, 0, 0, _RET_IP_);
 	do_read_rt_lock(rwlock);
@@ -346,7 +346,7 @@ void __lockfunc rt_read_lock(rwlock_t *rwlock)
 
 void __lockfunc rt_write_lock(rwlock_t *rwlock)
 {
-	sleeping_lock_inc();
+	rt_invol_sleep_inc();
 	migrate_disable();
 	rwlock_acquire(&rwlock->dep_map, 0, 0, _RET_IP_);
 	do_write_rt_lock(rwlock);
@@ -358,7 +358,7 @@ void __lockfunc rt_read_unlock(rwlock_t *rwlock)
 	rwlock_release(&rwlock->dep_map, 1, _RET_IP_);
 	do_read_rt_unlock(rwlock);
 	migrate_enable();
-	sleeping_lock_dec();
+	rt_invol_sleep_dec();
 }
 EXPORT_SYMBOL(rt_read_unlock);
 
@@ -367,7 +367,7 @@ void __lockfunc rt_write_unlock(rwlock_t *rwlock)
 	rwlock_release(&rwlock->dep_map, 1, _RET_IP_);
 	do_write_rt_unlock(rwlock);
 	migrate_enable();
-	sleeping_lock_dec();
+	rt_invol_sleep_dec();
 }
 EXPORT_SYMBOL(rt_write_unlock);
 
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 23a54e4b649c..0da4b975cd71 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -287,15 +287,15 @@ void rcu_note_context_switch(bool preempt)
 	struct task_struct *t = current;
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 	struct rcu_node *rnp;
-	int sleeping_l = 0;
+	int rt_invol = 0;
 
 	barrier(); /* Avoid RCU read-side critical sections leaking down. */
 	trace_rcu_utilization(TPS("Start context switch"));
 	lockdep_assert_irqs_disabled();
 #if defined(CONFIG_PREEMPT_RT_FULL)
-	sleeping_l = t->sleeping_lock;
+	rt_invol = t->rt_invol_sleep;
 #endif
-	WARN_ON_ONCE(!preempt && t->rcu_read_lock_nesting > 0 && !sleeping_l);
+	WARN_ON_ONCE(!preempt && t->rcu_read_lock_nesting > 0 && !rt_invol);
 	if (t->rcu_read_lock_nesting > 0 &&
 	    !t->rcu_read_unlock_special.b.blocked) {
 
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 6080c9328df1..daa21a87838a 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -879,7 +879,7 @@ void softirq_check_pending_idle(void)
 	 */
 	raw_spin_lock(&tsk->pi_lock);
 	if (tsk->pi_blocked_on || tsk->state == TASK_RUNNING ||
-	    (tsk->state == TASK_UNINTERRUPTIBLE && tsk->sleeping_lock)) {
+	    (tsk->state == TASK_UNINTERRUPTIBLE && tsk->rt_invol_sleep)) {
 		okay = true;
 	}
 	raw_spin_unlock(&tsk->pi_lock);
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 5eb45a868de9..0e6e2dcf6fa4 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1863,9 +1863,9 @@ void cpu_chill(void)
 	chill_time = ktime_set(0, NSEC_PER_MSEC);
 
 	current->flags |= PF_NOFREEZE;
-	sleeping_lock_inc();
+	rt_invol_sleep_inc();
 	schedule_hrtimeout(&chill_time, HRTIMER_MODE_REL_HARD);
-	sleeping_lock_dec();
+	rt_invol_sleep_dec();
 	if (!freeze_flag)
 		current->flags &= ~PF_NOFREEZE;
 
-- 
1.8.3.1

