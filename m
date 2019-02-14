From: Juri Lelli <juri.lelli@redhat.com>
Subject: [RFC PATCH RT 2/2] time/hrtimer: Embed hrtimer mode into hrtimer_sleeper
Date: Thu, 14 Feb 2019 14:37:16 +0100
Message-ID: <20190214133716.10187-3-juri.lelli@redhat.com>
References: <20190214133716.10187-1-juri.lelli@redhat.com>
Cc: linux-rt-users@vger.kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, bristot@redhat.com,
        williams@redhat.com, Juri Lelli <juri.lelli@redhat.com>
To: tglx@linutronix.de, bigeasy@linutronix.de
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190214133716.10187-1-juri.lelli@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Changes to hrtimer mode (potentially made by __hrtimer_init_sleeper() on
PREEMPT_RT_FULL are not visible to do_nanosleep(), and thus not
accounted for by hrtimer_start_expires() call path.

Embed hrtimer mode into hrtimer_sleeper struct, so that the same mode is
used by code following hrtimer_sleeper initialization.

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 include/linux/hrtimer.h |  2 ++
 kernel/time/hrtimer.c   | 11 ++++++-----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index c6d4941c7dd8..d5f11ef5330a 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -130,12 +130,14 @@ struct hrtimer {
  * struct hrtimer_sleeper - simple sleeper structure
  * @timer:	embedded timer structure
  * @task:	task to wake up
+ * @mode:	hrtimer mode
  *
  * task is set to NULL, when the timer expires.
  */
 struct hrtimer_sleeper {
 	struct hrtimer timer;
 	struct task_struct *task;
+	enum hrtimer_mode mode;
 };
 
 #ifdef CONFIG_64BIT
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 4a905fb721a1..5067aba434fe 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1725,6 +1725,7 @@ static void __hrtimer_init_sleeper(struct hrtimer_sleeper *sl,
 	__hrtimer_init(&sl->timer, clock_id, mode);
 	sl->timer.function = hrtimer_wakeup;
 	sl->task = task;
+	sl->mode = mode;
 }
 
 /**
@@ -1774,20 +1775,20 @@ int nanosleep_copyout(struct restart_block *restart, struct timespec64 *ts)
 	return -ERESTART_RESTARTBLOCK;
 }
 
-static int __sched do_nanosleep(struct hrtimer_sleeper *t, enum hrtimer_mode mode)
+static int __sched do_nanosleep(struct hrtimer_sleeper *t)
 {
 	struct restart_block *restart;
 
 	do {
 		set_current_state(TASK_INTERRUPTIBLE);
-		hrtimer_start_expires(&t->timer, mode);
+		hrtimer_start_expires(&t->timer, t->mode);
 
 		if (likely(t->task))
 			freezable_schedule();
 
 		__set_current_state(TASK_RUNNING);
 		hrtimer_cancel(&t->timer);
-		mode = HRTIMER_MODE_ABS;
+		t->mode = HRTIMER_MODE_ABS;
 
 	} while (t->task && !signal_pending(current));
 
@@ -1817,7 +1818,7 @@ static long __sched hrtimer_nanosleep_restart(struct restart_block *restart)
 	hrtimer_init_sleeper_on_stack(&t, restart->nanosleep.clockid,
 				      HRTIMER_MODE_ABS, current);
 	hrtimer_set_expires_tv64(&t.timer, restart->nanosleep.expires);
-	ret = do_nanosleep(&t, HRTIMER_MODE_ABS);
+	ret = do_nanosleep(&t);
 	destroy_hrtimer_on_stack(&t.timer);
 	return ret;
 }
@@ -1836,7 +1837,7 @@ long hrtimer_nanosleep(const struct timespec64 *rqtp,
 
 	hrtimer_init_sleeper_on_stack(&t, clockid, mode, current);
 	hrtimer_set_expires_range_ns(&t.timer, timespec64_to_ktime(*rqtp), slack);
-	ret = do_nanosleep(&t, mode);
+	ret = do_nanosleep(&t);
 	if (ret != -ERESTART_RESTARTBLOCK)
 		goto out;
 
-- 
2.17.2
