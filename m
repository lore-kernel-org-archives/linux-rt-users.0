Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail.kernel.org ([198.145.29.99]:52340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727787AbeHNVnX (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 14 Aug 2018 17:43:23 -0400
From: Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH 03/15] posix-timers: move the rcu head out of the union
Date: Tue, 14 Aug 2018 13:53:56 -0500
Message-Id: <de298a548dbb709443972c9e1349bc194e9a44f7.1534263273.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1534263273.git.tom.zanussi@linux.intel.com>
References: <cover.1534263273.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1534263273.git.tom.zanussi@linux.intel.com>
References: <cover.1534263273.git.tom.zanussi@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: linux-rt-users@vger.kernel.org
Cc: rostedt@goodmis.org, tglx@linutronix.de, C.Emde@osadl.org, jkacur@redhat.com, bigeasy@linutronix.de, daniel.wagner@siemens.com, julia@ni.com

v3.18.117-rt105 rt-stable review patch.  If anyone has any objections,
please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream 4.4 stable-rt commit 57f93c5f597fa32af860321c5bca34bc5ffe08e1 ]

On RT the timer can be preempted while running and therefore we wait
with timer_wait_for_callback() for the timer to complete (instead of
busy looping). The RCU-readlock is held to ensure that this posix timer
is not removed while we wait on it.
If the timer is removed then it invokes call_rcu() with a pointer that
is shared with the hrtimer because it is part of the same union.
In order to avoid any possible side effects I am moving the rcu pointer
out of the union.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Daniel Wagner <wagi@monom.org>
Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 include/linux/posix-timers.h | 2 +-
 kernel/time/posix-timers.c   | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index 907f3fd191ac..e2e43c61f6a1 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -92,8 +92,8 @@ struct k_itimer {
 			struct alarm alarmtimer;
 			ktime_t interval;
 		} alarm;
-		struct rcu_head rcu;
 	} it;
+	struct rcu_head rcu;
 };
 
 struct k_clock {
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index b5e0ff549422..bdf91054e6c3 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -560,7 +560,7 @@ static struct k_itimer * alloc_posix_timer(void)
 
 static void k_itimer_rcu_free(struct rcu_head *head)
 {
-	struct k_itimer *tmr = container_of(head, struct k_itimer, it.rcu);
+	struct k_itimer *tmr = container_of(head, struct k_itimer, rcu);
 
 	kmem_cache_free(posix_timers_cache, tmr);
 }
@@ -577,7 +577,7 @@ static void release_posix_timer(struct k_itimer *tmr, int it_id_set)
 	}
 	put_pid(tmr->it_pid);
 	sigqueue_free(tmr->sigq);
-	call_rcu(&tmr->it.rcu, k_itimer_rcu_free);
+	call_rcu(&tmr->rcu, k_itimer_rcu_free);
 }
 
 static struct k_clock *clockid_to_kclock(const clockid_t id)
-- 
2.14.1
