From: Gilles Carry <gilles.carry@bull.net>
Subject: [PATCH 1/2] [RT] hrtimers stuck in waitqueue
Date: Mon, 18 Aug 2008 16:42:31 +0200
Message-ID: <1219070552-30783-2-git-send-email-gilles.carry@bull.net>
References: <1219070552-30783-1-git-send-email-gilles.carry@bull.net>
Cc: tglx@linutronix.de, mingo@elte.hu, tinytim@us.ibm.com,
	jean-pierre.dion@bull.net, sebastien.dugue@bull.net,
	gilles.carry@bull.net
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:38193 "EHLO
	ecfrec.frec.bull.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753014AbYHROm4 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 18 Aug 2008 10:42:56 -0400
In-Reply-To: <1219070552-30783-1-git-send-email-gilles.carry@bull.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This patch makes hrtimers initialized with hrtimer_init_sleeper
to use another mode and then not be stuck in waitqueues when
hrtimer_interrupt is very busy.

The new mode is HRTIMER_CB_IRQSAFE_NO_RESTART_NO_SOFIRQ.
The above-mentionned timers have been moved from
HRTIMER_CB_IRQSAFE_NO_SOFTIRQ to
HRTIMER_CB_IRQSAFE_NO_RESTART_NO_SOFIRQ.

HRTIMER_CB_IRQSAFE_NO_RESTART_NO_SOFIRQ timers use a slightly different
state machine from HRTIMER_CB_IRQSAFE_NO_SOFTIRQ's as when removing the
timer, __run_hrtimer sets the status to INACTIVE _then_
wakes up the thread. This way, an awakened thread cannot enter
hrtimer_cancel before the timer's status has changed.

Signed-off-by: Gilles Carry <gilles.carry@bull.net>

---
 include/linux/hrtimer.h |    4 ++++
 kernel/hrtimer.c        |   26 +++++++++++++++++++++-----
 2 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index f3867fd..53f4d44 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -49,12 +49,16 @@ enum hrtimer_restart {
  *					does not restart the timer
  *	HRTIMER_CB_IRQSAFE_NO_SOFTIRQ:	Callback must run in hardirq context
  *					Special mode for tick emultation
+ *	HRTIMER_CB_IRQSAFE_NO_RESTART_NO_SOFTIRQ:
+ *					Callback must run in hardirq context and
+ *					does not restart the timer
  */
 enum hrtimer_cb_mode {
 	HRTIMER_CB_SOFTIRQ,
 	HRTIMER_CB_IRQSAFE,
 	HRTIMER_CB_IRQSAFE_NO_RESTART,
 	HRTIMER_CB_IRQSAFE_NO_SOFTIRQ,
+	HRTIMER_CB_IRQSAFE_NO_RESTART_NO_SOFTIRQ,
 };
 
 /*
diff --git a/kernel/hrtimer.c b/kernel/hrtimer.c
index fa63a24..778eb7e 100644
--- a/kernel/hrtimer.c
+++ b/kernel/hrtimer.c
@@ -668,6 +668,7 @@ static inline int hrtimer_enqueue_reprogram(struct hrtimer *timer,
 		/* Timer is expired, act upon the callback mode */
 		switch(timer->cb_mode) {
 		case HRTIMER_CB_IRQSAFE_NO_RESTART:
+		case HRTIMER_CB_IRQSAFE_NO_RESTART_NO_SOFTIRQ:
 			debug_hrtimer_deactivate(timer);
 			/*
 			 * We can call the callback from here. No restart
@@ -1089,6 +1090,8 @@ int hrtimer_cancel(struct hrtimer *timer)
 
 		if (ret >= 0)
 			return ret;
+		WARN_ON (timer->cb_mode ==
+			HRTIMER_CB_IRQSAFE_NO_RESTART_NO_SOFTIRQ);
 		hrtimer_wait_for_timer(timer);
 	}
 }
@@ -1298,11 +1301,18 @@ static void __run_hrtimer(struct hrtimer *timer)
 	int restart;
 
 	debug_hrtimer_deactivate(timer);
-	__remove_hrtimer(timer, base, HRTIMER_STATE_CALLBACK, 0);
-	timer_stats_account_hrtimer(timer);
 
 	fn = timer->function;
-	if (timer->cb_mode == HRTIMER_CB_IRQSAFE_NO_SOFTIRQ) {
+
+	switch (timer->cb_mode) {
+	case HRTIMER_CB_IRQSAFE_NO_RESTART_NO_SOFTIRQ:
+		__remove_hrtimer(timer, base, HRTIMER_STATE_INACTIVE, 0);
+		timer_stats_account_hrtimer(timer);
+		spin_unlock(&cpu_base->lock);
+		fn(timer);
+		spin_lock(&cpu_base->lock);
+		return;
+	case HRTIMER_CB_IRQSAFE_NO_SOFTIRQ:
 		/*
 		 * Used for scheduler timers, avoid lock inversion with
 		 * rq->lock and tasklist_lock.
@@ -1310,11 +1320,17 @@ static void __run_hrtimer(struct hrtimer *timer)
 		 * These timers are required to deal with enqueue expiry
 		 * themselves and are not allowed to migrate.
 		 */
+		__remove_hrtimer(timer, base, HRTIMER_STATE_CALLBACK, 0);
+		timer_stats_account_hrtimer(timer);
 		spin_unlock(&cpu_base->lock);
 		restart = fn(timer);
 		spin_lock(&cpu_base->lock);
-	} else
+		break;
+	default:
+		__remove_hrtimer(timer, base, HRTIMER_STATE_CALLBACK, 0);
+		timer_stats_account_hrtimer(timer);
 		restart = fn(timer);
+	}
 
 	/*
 	 * Note: We clear the CALLBACK bit after enqueue_hrtimer to avoid
@@ -1516,7 +1532,7 @@ void hrtimer_init_sleeper(struct hrtimer_sleeper *sl, struct task_struct *task)
 	sl->timer.function = hrtimer_wakeup;
 	sl->task = task;
 #ifdef CONFIG_HIGH_RES_TIMERS
-	sl->timer.cb_mode = HRTIMER_CB_IRQSAFE_NO_SOFTIRQ;
+	sl->timer.cb_mode = HRTIMER_CB_IRQSAFE_NO_RESTART_NO_SOFTIRQ;
 #endif
 }
 
-- 
1.5.2.2

