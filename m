Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50AABC433DB
	for <linux-rt-users@archiver.kernel.org>; Mon, 21 Dec 2020 20:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17D7422C9C
	for <linux-rt-users@archiver.kernel.org>; Mon, 21 Dec 2020 20:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbgLUUID (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 21 Dec 2020 15:08:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:34676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbgLUUIC (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 21 Dec 2020 15:08:02 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BBBD22AAA;
        Mon, 21 Dec 2020 20:07:21 +0000 (UTC)
Date:   Mon, 21 Dec 2020 15:07:19 -0500
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
Subject: [ANNOUNCE] 5.4.82-rt46
Message-ID: <20201221150719.2f017239@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


Dear RT Folks,

I'm pleased to announce the 5.4.82-rt46 stable release.


You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.4-rt
  Head SHA1: 2cb0daa9d528e36f026b0c60e7eb881d2282462a


Or to build 5.4.82-rt46 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v5.x/linux-5.4.tar.xz

  http://www.kernel.org/pub/linux/kernel/v5.x/patch-5.4.82.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/5.4/patch-5.4.82-rt46.patch.xz



You can also build from 5.4.82-rt45 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/5.4/incr/patch-5.4.82-rt45-rt46.patch.xz



Enjoy,

-- Steve


Changes from v5.4.82-rt45:

---

Sebastian Andrzej Siewior (1):
      Revert "hrtimer: Allow raw wakeups during boot"

Steven Rostedt (VMware) (2):
      Revert "net: Properly annotate the try-lock for the seqlock"
      Linux 5.4.82-rt46

Thomas Gleixner (1):
      timers: Move clearing of base::timer_running under base::lock

Zanxiong Qiu (1):
      mm/swap: use local lock in deactivate_page()

----
 include/linux/seqlock.h   |  9 +++++++++
 include/net/sch_generic.h | 10 +---------
 kernel/time/hrtimer.c     |  2 +-
 kernel/time/timer.c       |  6 ++++--
 localversion-rt           |  2 +-
 mm/swap.c                 |  5 +++--
 6 files changed, 19 insertions(+), 15 deletions(-)
---------------------------
diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index f390293974ea..e5207897c33e 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -489,6 +489,15 @@ static inline void write_seqlock(seqlock_t *sl)
 	__raw_write_seqcount_begin(&sl->seqcount);
 }
 
+static inline int try_write_seqlock(seqlock_t *sl)
+{
+	if (spin_trylock(&sl->lock)) {
+		__raw_write_seqcount_begin(&sl->seqcount);
+		return 1;
+	}
+	return 0;
+}
+
 static inline void write_sequnlock(seqlock_t *sl)
 {
 	__raw_write_seqcount_end(&sl->seqcount);
diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 112d2dca8b08..e6afb4b9cede 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -168,16 +168,8 @@ static inline bool qdisc_run_begin(struct Qdisc *qdisc)
 		return false;
 	}
 #ifdef CONFIG_PREEMPT_RT
-	if (spin_trylock(&qdisc->running.lock)) {
-		seqcount_t *s = &qdisc->running.seqcount;
-		/*
-		 * Variant of write_seqcount_t_begin() telling lockdep that a
-		 * trylock was attempted.
-		 */
-		__raw_write_seqcount_begin(s);
-		seqcount_acquire(&s->dep_map, 0, 1, _RET_IP_);
+	if (try_write_seqlock(&qdisc->running))
 		return true;
-	}
 	return false;
 #else
 	/* Variant of write_seqcount_begin() telling lockdep a trylock
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 41cc1c8530d8..42705a04c808 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1819,7 +1819,7 @@ static void __hrtimer_init_sleeper(struct hrtimer_sleeper *sl,
 	 * expiry.
 	 */
 	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
-		if ((task_is_realtime(current) && !(mode & HRTIMER_MODE_SOFT)) || system_state != SYSTEM_RUNNING)
+		if (task_is_realtime(current) && !(mode & HRTIMER_MODE_SOFT))
 			mode |= HRTIMER_MODE_HARD;
 	}
 
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 15b838401af8..86bb218d1df5 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1269,8 +1269,10 @@ static inline void timer_base_unlock_expiry(struct timer_base *base)
 static void timer_sync_wait_running(struct timer_base *base)
 {
 	if (atomic_read(&base->timer_waiters)) {
+		raw_spin_unlock_irq(&base->lock);
 		spin_unlock(&base->expiry_lock);
 		spin_lock(&base->expiry_lock);
+		raw_spin_lock_irq(&base->lock);
 	}
 }
 
@@ -1461,14 +1463,14 @@ static void expire_timers(struct timer_base *base, struct hlist_head *head)
 		if (timer->flags & TIMER_IRQSAFE) {
 			raw_spin_unlock(&base->lock);
 			call_timer_fn(timer, fn, baseclk);
-			base->running_timer = NULL;
 			raw_spin_lock(&base->lock);
+			base->running_timer = NULL;
 		} else {
 			raw_spin_unlock_irq(&base->lock);
 			call_timer_fn(timer, fn, baseclk);
+			raw_spin_lock_irq(&base->lock);
 			base->running_timer = NULL;
 			timer_sync_wait_running(base);
-			raw_spin_lock_irq(&base->lock);
 		}
 	}
 }
diff --git a/localversion-rt b/localversion-rt
index 38c40b21a885..272158183778 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt45
+-rt46
diff --git a/mm/swap.c b/mm/swap.c
index cdb4f1fa3a48..463cac334fcf 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -666,12 +666,13 @@ void deactivate_file_page(struct page *page)
 void deactivate_page(struct page *page)
 {
 	if (PageLRU(page) && PageActive(page) && !PageUnevictable(page)) {
-		struct pagevec *pvec = &get_cpu_var(lru_deactivate_pvecs);
+		struct pagevec *pvec = &get_locked_var(swapvec_lock,
+							lru_deactivate_pvecs);
 
 		get_page(page);
 		if (!pagevec_add(pvec, page) || PageCompound(page))
 			pagevec_lru_move_fn(pvec, lru_deactivate_fn, NULL);
-		put_cpu_var(lru_deactivate_pvecs);
+		put_locked_var(swapvec_lock, lru_deactivate_pvecs);
 	}
 }
 
