From: Julia Cartwright <julia@ni.com>
Subject: [PATCH RT 18/22] posix-timers: move the rcu head out of the union
Date: Mon,  6 Aug 2018 04:17:34 -0500
Message-ID: <63db6ca7324ab08eaad12613bf865382e54cd6c0.1533540554.git.julia@ni.com>
References: <cover.1533540554.git.julia@ni.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com, stable-rt@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1533540554.git.julia@ni.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

4.9.115-rt94-rc1 stable review patch.
If you have any objection to the inclusion of this patch, let me know.

--- 8< --- 8< --- 8< ---
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
(cherry picked from commit b8401365af110949f12c7cf1fa86b4c0ea069bbd)
Signed-off-by: Julia Cartwright <julia@ni.com>
---
 include/linux/posix-timers.h | 2 +-
 kernel/time/posix-timers.c   | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index 62d44c176071..cbd3f9334543 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -92,8 +92,8 @@ struct k_itimer {
 			struct alarm alarmtimer;
 			ktime_t interval;
 		} alarm;
-		struct rcu_head rcu;
 	} it;
+	struct rcu_head		rcu;
 };
 
 struct k_clock {
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 6084618436fd..45d8033caec4 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -568,7 +568,7 @@ static struct k_itimer * alloc_posix_timer(void)
 
 static void k_itimer_rcu_free(struct rcu_head *head)
 {
-	struct k_itimer *tmr = container_of(head, struct k_itimer, it.rcu);
+	struct k_itimer *tmr = container_of(head, struct k_itimer, rcu);
 
 	kmem_cache_free(posix_timers_cache, tmr);
 }
@@ -585,7 +585,7 @@ static void release_posix_timer(struct k_itimer *tmr, int it_id_set)
 	}
 	put_pid(tmr->it_pid);
 	sigqueue_free(tmr->sigq);
-	call_rcu(&tmr->it.rcu, k_itimer_rcu_free);
+	call_rcu(&tmr->rcu, k_itimer_rcu_free);
 }
 
 static struct k_clock *clockid_to_kclock(const clockid_t id)
-- 
2.18.0
