Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2222C5517A
	for <linux-rt-users@archiver.kernel.org>; Wed, 11 Nov 2020 21:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 812B1208B3
	for <linux-rt-users@archiver.kernel.org>; Wed, 11 Nov 2020 21:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbgKKVal (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 11 Nov 2020 16:30:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:47666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbgKKVal (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 11 Nov 2020 16:30:41 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AE6920679;
        Wed, 11 Nov 2020 21:30:39 +0000 (UTC)
Date:   Wed, 11 Nov 2020 16:30:37 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Subject: [ANNOUNCE] 5.4.74-rt42
Message-ID: <20201111163037.5f126a01@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


Dear RT Folks,

I'm pleased to announce the 5.4.74-rt42 stable release.


You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.4-rt
  Head SHA1: c8dd266abfd2094d00758c27f7c37b78264f9666


Or to build 5.4.74-rt42 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v5.x/linux-5.4.tar.xz

  http://www.kernel.org/pub/linux/kernel/v5.x/patch-5.4.74.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/5.4/patch-5.4.74-rt42.patch.xz



You can also build from 5.4.74-rt41 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/5.4/incr/patch-5.4.74-rt41-rt42.patch.xz



Enjoy,

-- Steve


Changes from v5.4.74-rt41:

---

Oleg Nesterov (1):
      ptrace: fix ptrace_unfreeze_traced() race with rt-lock

Sebastian Andrzej Siewior (3):
      net: Properly annotate the try-lock for the seqlock
      mm/memcontrol: Disable preemption in __mod_memcg_lruvec_state()
      timers: Don't block on ->expiry_lock for TIMER_IRQSAFE

Steven Rostedt (VMware) (1):
      Linux 5.4.74-rt42

----
 include/linux/seqlock.h   |  9 ---------
 include/net/sch_generic.h | 10 +++++++++-
 kernel/ptrace.c           | 23 +++++++++++++++--------
 kernel/time/timer.c       |  9 ++++++++-
 localversion-rt           |  2 +-
 mm/memcontrol.c           |  2 ++
 6 files changed, 35 insertions(+), 20 deletions(-)
---------------------------
diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index e5207897c33e..f390293974ea 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -489,15 +489,6 @@ static inline void write_seqlock(seqlock_t *sl)
 	__raw_write_seqcount_begin(&sl->seqcount);
 }
 
-static inline int try_write_seqlock(seqlock_t *sl)
-{
-	if (spin_trylock(&sl->lock)) {
-		__raw_write_seqcount_begin(&sl->seqcount);
-		return 1;
-	}
-	return 0;
-}
-
 static inline void write_sequnlock(seqlock_t *sl)
 {
 	__raw_write_seqcount_end(&sl->seqcount);
diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index e6afb4b9cede..112d2dca8b08 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -168,8 +168,16 @@ static inline bool qdisc_run_begin(struct Qdisc *qdisc)
 		return false;
 	}
 #ifdef CONFIG_PREEMPT_RT
-	if (try_write_seqlock(&qdisc->running))
+	if (spin_trylock(&qdisc->running.lock)) {
+		seqcount_t *s = &qdisc->running.seqcount;
+		/*
+		 * Variant of write_seqcount_t_begin() telling lockdep that a
+		 * trylock was attempted.
+		 */
+		__raw_write_seqcount_begin(s);
+		seqcount_acquire(&s->dep_map, 0, 1, _RET_IP_);
 		return true;
+	}
 	return false;
 #else
 	/* Variant of write_seqcount_begin() telling lockdep a trylock
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 3075006d720e..3f7156f06b6c 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -197,8 +197,8 @@ static bool ptrace_freeze_traced(struct task_struct *task)
 
 static void ptrace_unfreeze_traced(struct task_struct *task)
 {
-	if (task->state != __TASK_TRACED)
-		return;
+	unsigned long flags;
+	bool frozen = true;
 
 	WARN_ON(!task->ptrace || task->parent != current);
 
@@ -207,12 +207,19 @@ static void ptrace_unfreeze_traced(struct task_struct *task)
 	 * Recheck state under the lock to close this race.
 	 */
 	spin_lock_irq(&task->sighand->siglock);
-	if (task->state == __TASK_TRACED) {
-		if (__fatal_signal_pending(task))
-			wake_up_state(task, __TASK_TRACED);
-		else
-			task->state = TASK_TRACED;
-	}
+
+	raw_spin_lock_irqsave(&task->pi_lock, flags);
+	if (task->state == __TASK_TRACED)
+		task->state = TASK_TRACED;
+	else if (task->saved_state == __TASK_TRACED)
+		task->saved_state = TASK_TRACED;
+	else
+		frozen = false;
+	raw_spin_unlock_irqrestore(&task->pi_lock, flags);
+
+	if (frozen && __fatal_signal_pending(task))
+		wake_up_state(task, __TASK_TRACED);
+
 	spin_unlock_irq(&task->sighand->siglock);
 }
 
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 89078fd848b9..3e9d7f227a5c 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1289,7 +1289,7 @@ static void del_timer_wait_running(struct timer_list *timer)
 	u32 tf;
 
 	tf = READ_ONCE(timer->flags);
-	if (!(tf & TIMER_MIGRATING)) {
+	if (!(tf & (TIMER_MIGRATING | TIMER_IRQSAFE))) {
 		struct timer_base *base = get_timer_base(tf);
 
 		/*
@@ -1373,6 +1373,13 @@ int del_timer_sync(struct timer_list *timer)
 	 */
 	WARN_ON(in_irq() && !(timer->flags & TIMER_IRQSAFE));
 
+	/*
+	 * Must be able to sleep on PREEMPT_RT because of the slowpath in
+	 * del_timer_wait_running().
+	 */
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && !(timer->flags & TIMER_IRQSAFE))
+		might_sleep();
+
 	do {
 		ret = try_to_del_timer_sync(timer);
 
diff --git a/localversion-rt b/localversion-rt
index 629e0b4384b8..8bdfb9a04683 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt41
+-rt42
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 9bdb75ef6d62..c9d02e2272e1 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -752,6 +752,7 @@ void __mod_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
 	memcg = pn->memcg;
 
+	preempt_disable_rt();
 	/* Update memcg */
 	__mod_memcg_state(memcg, idx, val);
 
@@ -767,6 +768,7 @@ void __mod_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 		x = 0;
 	}
 	__this_cpu_write(pn->lruvec_stat_cpu->count[idx], x);
+	preempt_enable_rt();
 }
 
 void __mod_lruvec_slab_state(void *p, enum node_stat_item idx, int val)
