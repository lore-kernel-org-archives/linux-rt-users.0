Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0AAEC47095
	for <linux-rt-users@archiver.kernel.org>; Mon,  7 Jun 2021 19:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE9BB610A1
	for <linux-rt-users@archiver.kernel.org>; Mon,  7 Jun 2021 19:01:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbhFGTDB (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 7 Jun 2021 15:03:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50484 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231384AbhFGTDA (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 7 Jun 2021 15:03:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623092467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=IaPsyw1OYWbWckC9BsMU6tJFgUQ6HxmKSpauKGtSmPI=;
        b=P0jNaAWCuppezHw/US0wNrpFWDeXATU5YFmfEo+2HsGeyzkbMOnHeRIt0a8AJoBWC0PLp/
        Hw4ozjNtugB4BvrNrdxULK3nJoU/4DHuwA9oquJQ38TdPTdOWnJseNII6EDCtEddrITg1q
        nA+6dtRlVgzYtw0yjBjvywHOe6VtIoI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-eSuvKaxNMsqijrNU8NU8Pg-1; Mon, 07 Jun 2021 15:01:04 -0400
X-MC-Unique: eSuvKaxNMsqijrNU8NU8Pg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 757791009446;
        Mon,  7 Jun 2021 19:01:02 +0000 (UTC)
Received: from lclaudio.dyndns.org (ovpn-119-82.rdu2.redhat.com [10.10.119.82])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 882521001281;
        Mon,  7 Jun 2021 19:01:01 +0000 (UTC)
Received: by lclaudio.dyndns.org (Postfix, from userid 1000)
        id B3C1B3C0174; Mon,  7 Jun 2021 16:00:59 -0300 (-03)
Date:   Mon, 7 Jun 2021 16:00:59 -0300
From:   "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Luis Goncalves <lgoncalv@redhat.com>
Subject: [ANNOUNCE] 4.14.232-rt112
Message-ID: <162309234974.373493.9425493091685363517@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.14.232-rt112 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.14-rt
  Head SHA1: 0c3a637ee61cf091859066daf098ccf5d2198ef3

Or to build 4.14.232-rt112 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.232.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/patch-4.14.232-rt112.patch.xz


Enjoy!
Luis

Changes from v4.14.232-rt111:
---

Luis Claudio R. Goncalves (2):
      printk: revamp "Make rt aware"
      Linux 4.14.232-rt112

Sebastian Andrzej Siewior (1):
      timers: Redo the notification of canceling timers on -RT
---
fs/timerfd.c                   |  5 ++-
 include/linux/hrtimer.h        | 17 +++-----
 include/linux/posix-timers.h   |  1 +
 kernel/printk/printk.c         | 11 +++++
 kernel/time/alarmtimer.c       |  2 +-
 kernel/time/hrtimer.c          | 36 ++++------------
 kernel/time/itimer.c           |  2 +-
 kernel/time/posix-cpu-timers.c | 23 ++++++++++
 kernel/time/posix-timers.c     | 69 ++++++++++++------------------
 kernel/time/posix-timers.h     |  2 +
 kernel/time/timer.c            | 96 ++++++++++++++++++++----------------------
 localversion-rt                |  2 +-
 12 files changed, 130 insertions(+), 136 deletions(-)
---
diff --git a/fs/timerfd.c b/fs/timerfd.c
index b3d9d435926c9..2853607e79d01 100644
--- a/fs/timerfd.c
+++ b/fs/timerfd.c
@@ -471,10 +471,11 @@ static int do_timerfd_settime(int ufd, int flags,
 				break;
 		}
 		spin_unlock_irq(&ctx->wqh.lock);
+
 		if (isalarm(ctx))
-			hrtimer_wait_for_timer(&ctx->t.alarm.timer);
+			hrtimer_grab_expiry_lock(&ctx->t.alarm.timer);
 		else
-			hrtimer_wait_for_timer(&ctx->t.tmr);
+			hrtimer_grab_expiry_lock(&ctx->t.tmr);
 	}
 
 	/*
diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 0c23bbff3d6bc..11363c0bcf4e0 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -22,7 +22,6 @@
 #include <linux/percpu.h>
 #include <linux/timer.h>
 #include <linux/timerqueue.h>
-#include <linux/wait.h>
 
 struct hrtimer_clock_base;
 struct hrtimer_cpu_base;
@@ -193,6 +192,8 @@ enum  hrtimer_base_type {
  * @nr_retries:		Total number of hrtimer interrupt retries
  * @nr_hangs:		Total number of hrtimer interrupt hangs
  * @max_hang_time:	Maximum time spent in hrtimer_interrupt
+ * @softirq_expiry_lock: Lock which is taken while softirq based hrtimer are
+ *			 expired
  * @expires_next:	absolute time of the next event, is required for remote
  *			hrtimer enqueue; it is the total first expiry time (hard
  *			and soft hrtimer are taken into account)
@@ -220,12 +221,10 @@ struct hrtimer_cpu_base {
 	unsigned short			nr_hangs;
 	unsigned int			max_hang_time;
 #endif
+	spinlock_t			softirq_expiry_lock;
 	ktime_t				expires_next;
 	struct hrtimer			*next_timer;
 	ktime_t				softirq_expires_next;
-#ifdef CONFIG_PREEMPT_RT_BASE
-	wait_queue_head_t		wait;
-#endif
 	struct hrtimer			*softirq_next_timer;
 	struct hrtimer_clock_base	clock_base[HRTIMER_MAX_CLOCK_BASES];
 } ____cacheline_aligned;
@@ -426,6 +425,7 @@ static inline void hrtimer_start(struct hrtimer *timer, ktime_t tim,
 
 extern int hrtimer_cancel(struct hrtimer *timer);
 extern int hrtimer_try_to_cancel(struct hrtimer *timer);
+extern void hrtimer_grab_expiry_lock(const struct hrtimer *timer);
 
 static inline void hrtimer_start_expires(struct hrtimer *timer,
 					 enum hrtimer_mode mode)
@@ -443,13 +443,6 @@ static inline void hrtimer_restart(struct hrtimer *timer)
 	hrtimer_start_expires(timer, HRTIMER_MODE_ABS);
 }
 
-/* Softirq preemption could deadlock timer removal */
-#ifdef CONFIG_PREEMPT_RT_BASE
-  extern void hrtimer_wait_for_timer(const struct hrtimer *timer);
-#else
-# define hrtimer_wait_for_timer(timer)	do { cpu_relax(); } while (0)
-#endif
-
 /* Query timers: */
 extern ktime_t __hrtimer_get_remaining(const struct hrtimer *timer, bool adjust);
 
@@ -480,7 +473,7 @@ static inline bool hrtimer_is_queued(struct hrtimer *timer)
  * Helper function to check, whether the timer is running the callback
  * function
  */
-static inline int hrtimer_callback_running(const struct hrtimer *timer)
+static inline int hrtimer_callback_running(struct hrtimer *timer)
 {
 	return timer->base->running == timer;
 }
diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index de5c49b0dccf5..1a1cb5be686ed 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -15,6 +15,7 @@ struct cpu_timer_list {
 	u64 expires, incr;
 	struct task_struct *task;
 	int firing;
+	int firing_cpu;
 };
 
 /*
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 624ba7bb74374..fdae4fbd8a127 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1581,6 +1581,7 @@ SYSCALL_DEFINE3(syslog, int, type, char __user *, buf, int, len)
 	return do_syslog(type, buf, len, SYSLOG_FROM_READER);
 }
 
+#ifndef CONFIG_PREEMPT_RT_FULL
 /*
  * Special console_lock variants that help to reduce the risk of soft-lockups.
  * They allow to pass console_lock to another printk() call using a busy wait.
@@ -1721,6 +1722,15 @@ static int console_trylock_spinning(void)
 	return 1;
 }
 
+#else
+
+static int console_trylock_spinning(void)
+{
+	return console_trylock();
+}
+
+#endif
+
 /*
  * Call the console drivers, asking them to write out
  * log_buf[start] to log_buf[end - 1].
@@ -2855,6 +2865,7 @@ static int __init printk_late_init(void)
 	struct console *con;
 	int ret;
 
+	migrate_disable();
 	for_each_console(con) {
 		if (!(con->flags & CON_BOOT))
 			continue;
diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index f4c8cfde00b02..e7b983df6996f 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -438,7 +438,7 @@ int alarm_cancel(struct alarm *alarm)
 		int ret = alarm_try_to_cancel(alarm);
 		if (ret >= 0)
 			return ret;
-		hrtimer_wait_for_timer(&alarm->timer);
+		hrtimer_grab_expiry_lock(&alarm->timer);
 	}
 }
 EXPORT_SYMBOL_GPL(alarm_cancel);
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 261aef3db3ae5..8360817c3a06a 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -950,33 +950,16 @@ u64 hrtimer_forward(struct hrtimer *timer, ktime_t now, ktime_t interval)
 }
 EXPORT_SYMBOL_GPL(hrtimer_forward);
 
-#ifdef CONFIG_PREEMPT_RT_BASE
-# define wake_up_timer_waiters(b)	wake_up(&(b)->wait)
-
-/**
- * hrtimer_wait_for_timer - Wait for a running timer
- *
- * @timer:	timer to wait for
- *
- * The function waits in case the timers callback function is
- * currently executed on the waitqueue of the timer base. The
- * waitqueue is woken up after the timer callback function has
- * finished execution.
- */
-void hrtimer_wait_for_timer(const struct hrtimer *timer)
+void hrtimer_grab_expiry_lock(const struct hrtimer *timer)
 {
 	struct hrtimer_clock_base *base = timer->base;
 
-	if (base && base->cpu_base &&
-	    base->index >= HRTIMER_BASE_MONOTONIC_SOFT)
-		wait_event(base->cpu_base->wait,
-				!(hrtimer_callback_running(timer)));
+	if (base && base->cpu_base) {
+		spin_lock(&base->cpu_base->softirq_expiry_lock);
+		spin_unlock(&base->cpu_base->softirq_expiry_lock);
+	}
 }
 
-#else
-# define wake_up_timer_waiters(b)	do { } while (0)
-#endif
-
 /*
  * enqueue_hrtimer - internal function to (re)start a timer
  *
@@ -1214,7 +1197,7 @@ int hrtimer_cancel(struct hrtimer *timer)
 
 		if (ret >= 0)
 			return ret;
-		hrtimer_wait_for_timer(timer);
+		hrtimer_grab_expiry_lock(timer);
 	}
 }
 EXPORT_SYMBOL_GPL(hrtimer_cancel);
@@ -1485,6 +1468,7 @@ static __latent_entropy void hrtimer_run_softirq(struct softirq_action *h)
 	unsigned long flags;
 	ktime_t now;
 
+	spin_lock(&cpu_base->softirq_expiry_lock);
 	raw_spin_lock_irqsave(&cpu_base->lock, flags);
 
 	now = hrtimer_update_base(cpu_base);
@@ -1494,7 +1478,7 @@ static __latent_entropy void hrtimer_run_softirq(struct softirq_action *h)
 	hrtimer_update_softirq_timer(cpu_base, true);
 
 	raw_spin_unlock_irqrestore(&cpu_base->lock, flags);
-	wake_up_timer_waiters(cpu_base);
+	spin_unlock(&cpu_base->softirq_expiry_lock);
 }
 
 #ifdef CONFIG_HIGH_RES_TIMERS
@@ -1914,9 +1898,7 @@ int hrtimers_prepare_cpu(unsigned int cpu)
 	cpu_base->softirq_next_timer = NULL;
 	cpu_base->expires_next = KTIME_MAX;
 	cpu_base->softirq_expires_next = KTIME_MAX;
-#ifdef CONFIG_PREEMPT_RT_BASE
-	init_waitqueue_head(&cpu_base->wait);
-#endif
+	spin_lock_init(&cpu_base->softirq_expiry_lock);
 	return 0;
 }
 
diff --git a/kernel/time/itimer.c b/kernel/time/itimer.c
index a9da83d2044b8..588cbb6674573 100644
--- a/kernel/time/itimer.c
+++ b/kernel/time/itimer.c
@@ -210,7 +210,7 @@ int do_setitimer(int which, struct itimerval *value, struct itimerval *ovalue)
 		/* We are sharing ->siglock with it_real_fn() */
 		if (hrtimer_try_to_cancel(timer) < 0) {
 			spin_unlock_irq(&tsk->sighand->siglock);
-			hrtimer_wait_for_timer(&tsk->signal->real_timer);
+			hrtimer_grab_expiry_lock(timer);
 			goto again;
 		}
 		expires = timeval_to_ktime(value->it_value);
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 9358b88a984dc..8eb526b982eb8 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -789,6 +789,7 @@ check_timers_list(struct list_head *timers,
 			return t->expires;
 
 		t->firing = 1;
+		t->firing_cpu = smp_processor_id();
 		list_move_tail(&t->entry, firing);
 	}
 
@@ -1118,6 +1119,20 @@ static inline int fastpath_timer_check(struct task_struct *tsk)
 	return 0;
 }
 
+static DEFINE_PER_CPU(spinlock_t, cpu_timer_expiry_lock) = __SPIN_LOCK_UNLOCKED(cpu_timer_expiry_lock);
+
+void cpu_timers_grab_expiry_lock(struct k_itimer *timer)
+{
+	int cpu = timer->it.cpu.firing_cpu;
+
+	if (cpu >= 0) {
+		spinlock_t *expiry_lock = per_cpu_ptr(&cpu_timer_expiry_lock, cpu);
+
+		spin_lock_irq(expiry_lock);
+		spin_unlock_irq(expiry_lock);
+	}
+}
+
 /*
  * This is called from the timer interrupt handler.  The irq handler has
  * already updated our counts.  We need to check if any timers fire now.
@@ -1128,6 +1143,7 @@ static void __run_posix_cpu_timers(struct task_struct *tsk)
 	LIST_HEAD(firing);
 	struct k_itimer *timer, *next;
 	unsigned long flags;
+	spinlock_t *expiry_lock;
 
 	WARN_ON_ONCE_NONRT(!irqs_disabled());
 
@@ -1138,6 +1154,9 @@ static void __run_posix_cpu_timers(struct task_struct *tsk)
 	if (!fastpath_timer_check(tsk))
 		return;
 
+	expiry_lock = this_cpu_ptr(&cpu_timer_expiry_lock);
+	spin_lock(expiry_lock);
+
 	if (!lock_task_sighand(tsk, &flags))
 		return;
 	/*
@@ -1172,6 +1191,7 @@ static void __run_posix_cpu_timers(struct task_struct *tsk)
 		list_del_init(&timer->it.cpu.entry);
 		cpu_firing = timer->it.cpu.firing;
 		timer->it.cpu.firing = 0;
+		timer->it.cpu.firing_cpu = -1;
 		/*
 		 * The firing flag is -1 if we collided with a reset
 		 * of the timer, which already reported this
@@ -1181,6 +1201,7 @@ static void __run_posix_cpu_timers(struct task_struct *tsk)
 			cpu_timer_fire(timer);
 		spin_unlock(&timer->it_lock);
 	}
+	spin_unlock(expiry_lock);
 }
 
 #ifdef CONFIG_PREEMPT_RT_BASE
@@ -1444,6 +1465,8 @@ static int do_cpu_nanosleep(const clockid_t which_clock, int flags,
 		spin_unlock_irq(&timer.it_lock);
 
 		while (error == TIMER_RETRY) {
+
+			cpu_timers_grab_expiry_lock(&timer);
 			/*
 			 * We need to handle case when timer was or is in the
 			 * middle of firing. In other cases we already freed
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 74083d1c75298..c1b3722126006 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -833,25 +833,20 @@ static void common_hrtimer_arm(struct k_itimer *timr, ktime_t expires,
 		hrtimer_start_expires(timer, HRTIMER_MODE_ABS);
 }
 
-/*
- * Protected by RCU!
- */
-static void timer_wait_for_callback(const struct k_clock *kc, struct k_itimer *timr)
+static int common_hrtimer_try_to_cancel(struct k_itimer *timr)
 {
-#ifdef CONFIG_PREEMPT_RT_FULL
-	if (kc->timer_arm == common_hrtimer_arm)
-		hrtimer_wait_for_timer(&timr->it.real.timer);
-	else if (kc == &alarm_clock)
-		hrtimer_wait_for_timer(&timr->it.alarm.alarmtimer.timer);
-	else
-		/* FIXME: Whacky hack for posix-cpu-timers */
-		schedule_timeout(1);
-#endif
+	return hrtimer_try_to_cancel(&timr->it.real.timer);
 }
 
-static int common_hrtimer_try_to_cancel(struct k_itimer *timr)
+static void timer_wait_for_callback(const struct k_clock *kc, struct k_itimer *timer)
 {
-	return hrtimer_try_to_cancel(&timr->it.real.timer);
+	if (kc->timer_arm == common_hrtimer_arm)
+		hrtimer_grab_expiry_lock(&timer->it.real.timer);
+	else if (kc == &alarm_clock)
+		hrtimer_grab_expiry_lock(&timer->it.alarm.alarmtimer.timer);
+	else
+		/* posix-cpu-timers */
+		cpu_timers_grab_expiry_lock(timer);
 }
 
 /* Set a POSIX.1b interval timer. */
@@ -913,21 +908,21 @@ static int do_timer_settime(timer_t timer_id, int flags,
 	if (!timr)
 		return -EINVAL;
 
-	rcu_read_lock();
 	kc = timr->kclock;
 	if (WARN_ON_ONCE(!kc || !kc->timer_set))
 		error = -EINVAL;
 	else
 		error = kc->timer_set(timr, flags, new_spec64, old_spec64);
 
-	unlock_timer(timr, flag);
 	if (error == TIMER_RETRY) {
+		rcu_read_lock();
+		unlock_timer(timr, flag);
 		timer_wait_for_callback(kc, timr);
-		old_spec64 = NULL;	// We already got the old time...
 		rcu_read_unlock();
+		old_spec64 = NULL;	// We already got the old time...
 		goto retry;
 	}
-	rcu_read_unlock();
+	unlock_timer(timr, flag);
 
 	return error;
 }
@@ -989,13 +984,21 @@ int common_timer_del(struct k_itimer *timer)
 	return 0;
 }
 
-static inline int timer_delete_hook(struct k_itimer *timer)
+static int timer_delete_hook(struct k_itimer *timer)
 {
 	const struct k_clock *kc = timer->kclock;
+	int ret;
 
 	if (WARN_ON_ONCE(!kc || !kc->timer_del))
 		return -EINVAL;
-	return kc->timer_del(timer);
+	ret = kc->timer_del(timer);
+	if (ret == TIMER_RETRY) {
+		rcu_read_lock();
+		spin_unlock_irq(&timer->it_lock);
+		timer_wait_for_callback(kc, timer);
+		rcu_read_unlock();
+	}
+	return ret;
 }
 
 /* Delete a POSIX.1b interval timer. */
@@ -1009,15 +1012,8 @@ SYSCALL_DEFINE1(timer_delete, timer_t, timer_id)
 	if (!timer)
 		return -EINVAL;
 
-	rcu_read_lock();
-	if (timer_delete_hook(timer) == TIMER_RETRY) {
-		unlock_timer(timer, flags);
-		timer_wait_for_callback(clockid_to_kclock(timer->it_clock),
-					timer);
-		rcu_read_unlock();
+	if (timer_delete_hook(timer) == TIMER_RETRY)
 		goto retry_delete;
-	}
-	rcu_read_unlock();
 
 	spin_lock(&current->sighand->siglock);
 	list_del(&timer->list);
@@ -1043,20 +1039,9 @@ static void itimer_delete(struct k_itimer *timer)
 retry_delete:
 	spin_lock_irqsave(&timer->it_lock, flags);
 
-	/* On RT we can race with a deletion */
-	if (!timer->it_signal) {
-		unlock_timer(timer, flags);
-		return;
-	}
-
-	if (timer_delete_hook(timer) == TIMER_RETRY) {
-		rcu_read_lock();
-		unlock_timer(timer, flags);
-		timer_wait_for_callback(clockid_to_kclock(timer->it_clock),
-					timer);
-		rcu_read_unlock();
+	if (timer_delete_hook(timer) == TIMER_RETRY)
 		goto retry_delete;
-	}
+
 	list_del(&timer->list);
 	/*
 	 * This keeps any tasks waiting on the spin lock from thinking
diff --git a/kernel/time/posix-timers.h b/kernel/time/posix-timers.h
index ddb21145211a0..725bd230a8db4 100644
--- a/kernel/time/posix-timers.h
+++ b/kernel/time/posix-timers.h
@@ -32,6 +32,8 @@ extern const struct k_clock clock_process;
 extern const struct k_clock clock_thread;
 extern const struct k_clock alarm_clock;
 
+extern void cpu_timers_grab_expiry_lock(struct k_itimer *timer);
+
 int posix_timer_event(struct k_itimer *timr, int si_private);
 
 void common_timer_get(struct k_itimer *timr, struct itimerspec64 *cur_setting);
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index d7916559c100a..34b6784282bac 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -45,7 +45,6 @@
 #include <linux/slab.h>
 #include <linux/compat.h>
 #include <linux/random.h>
-#include <linux/swait.h>
 
 #include <linux/uaccess.h>
 #include <asm/unistd.h>
@@ -199,9 +198,7 @@ EXPORT_SYMBOL(jiffies_64);
 struct timer_base {
 	raw_spinlock_t		lock;
 	struct timer_list	*running_timer;
-#ifdef CONFIG_PREEMPT_RT_FULL
-	struct swait_queue_head	wait_for_running_timer;
-#endif
+	spinlock_t		expiry_lock;
 	unsigned long		clk;
 	unsigned long		next_expiry;
 	unsigned int		cpu;
@@ -1152,33 +1149,6 @@ void add_timer_on(struct timer_list *timer, int cpu)
 }
 EXPORT_SYMBOL_GPL(add_timer_on);
 
-#ifdef CONFIG_PREEMPT_RT_FULL
-/*
- * Wait for a running timer
- */
-static void wait_for_running_timer(struct timer_list *timer)
-{
-	struct timer_base *base;
-	u32 tf = timer->flags;
-
-	if (tf & TIMER_MIGRATING)
-		return;
-
-	base = get_timer_base(tf);
-	swait_event(base->wait_for_running_timer,
-		    base->running_timer != timer);
-}
-
-# define wakeup_timer_waiters(b)	swake_up_all(&(b)->wait_for_running_timer)
-#else
-static inline void wait_for_running_timer(struct timer_list *timer)
-{
-	cpu_relax();
-}
-
-# define wakeup_timer_waiters(b)	do { } while (0)
-#endif
-
 /**
  * del_timer - deactivate a timer.
  * @timer: the timer to be deactivated
@@ -1208,14 +1178,8 @@ int del_timer(struct timer_list *timer)
 }
 EXPORT_SYMBOL(del_timer);
 
-/**
- * try_to_del_timer_sync - Try to deactivate a timer
- * @timer: timer to delete
- *
- * This function tries to deactivate a timer. Upon successful (ret >= 0)
- * exit the timer is not queued and the handler is not running on any CPU.
- */
-int try_to_del_timer_sync(struct timer_list *timer)
+static int __try_to_del_timer_sync(struct timer_list *timer,
+				   struct timer_base **basep)
 {
 	struct timer_base *base;
 	unsigned long flags;
@@ -1223,7 +1187,7 @@ int try_to_del_timer_sync(struct timer_list *timer)
 
 	debug_assert_init(timer);
 
-	base = lock_timer_base(timer, &flags);
+	*basep = base = lock_timer_base(timer, &flags);
 
 	if (base->running_timer != timer)
 		ret = detach_if_pending(timer, base, true);
@@ -1232,9 +1196,42 @@ int try_to_del_timer_sync(struct timer_list *timer)
 
 	return ret;
 }
+
+/**
+ * try_to_del_timer_sync - Try to deactivate a timer
+ * @timer: timer to delete
+ *
+ * This function tries to deactivate a timer. Upon successful (ret >= 0)
+ * exit the timer is not queued and the handler is not running on any CPU.
+ */
+int try_to_del_timer_sync(struct timer_list *timer)
+{
+	struct timer_base *base;
+
+	return __try_to_del_timer_sync(timer, &base);
+}
 EXPORT_SYMBOL(try_to_del_timer_sync);
 
 #if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT_FULL)
+static int __del_timer_sync(struct timer_list *timer)
+{
+	struct timer_base *base;
+	int ret;
+
+	for (;;) {
+		ret = __try_to_del_timer_sync(timer, &base);
+		if (ret >= 0)
+			return ret;
+
+		/*
+		 * When accessing the lock, timers of base are no longer expired
+		 * and so timer is no longer running.
+		 */
+		spin_lock(&base->expiry_lock);
+		spin_unlock(&base->expiry_lock);
+	}
+}
+
 /**
  * del_timer_sync - deactivate a timer and wait for the handler to finish.
  * @timer: the timer to be deactivated
@@ -1290,12 +1287,8 @@ int del_timer_sync(struct timer_list *timer)
 	 * could lead to deadlock.
 	 */
 	WARN_ON(in_irq() && !(timer->flags & TIMER_IRQSAFE));
-	for (;;) {
-		int ret = try_to_del_timer_sync(timer);
-		if (ret >= 0)
-			return ret;
-		wait_for_running_timer(timer);
-	}
+
+	return __del_timer_sync(timer);
 }
 EXPORT_SYMBOL(del_timer_sync);
 #endif
@@ -1363,11 +1356,15 @@ static void expire_timers(struct timer_base *base, struct hlist_head *head)
 			raw_spin_unlock(&base->lock);
 			call_timer_fn(timer, fn, data);
 			base->running_timer = NULL;
+			spin_unlock(&base->expiry_lock);
+			spin_lock(&base->expiry_lock);
 			raw_spin_lock(&base->lock);
 		} else {
 			raw_spin_unlock_irq(&base->lock);
 			call_timer_fn(timer, fn, data);
 			base->running_timer = NULL;
+			spin_unlock(&base->expiry_lock);
+			spin_lock(&base->expiry_lock);
 			raw_spin_lock_irq(&base->lock);
 		}
 	}
@@ -1661,6 +1658,7 @@ static inline void __run_timers(struct timer_base *base)
 	if (!time_after_eq(jiffies, base->clk))
 		return;
 
+	spin_lock(&base->expiry_lock);
 	raw_spin_lock_irq(&base->lock);
 
 	/*
@@ -1688,7 +1686,7 @@ static inline void __run_timers(struct timer_base *base)
 			expire_timers(base, heads + levels);
 	}
 	raw_spin_unlock_irq(&base->lock);
-	wakeup_timer_waiters(base);
+	spin_unlock(&base->expiry_lock);
 }
 
 /*
@@ -1922,9 +1920,7 @@ static void __init init_timer_cpu(int cpu)
 		base->cpu = cpu;
 		raw_spin_lock_init(&base->lock);
 		base->clk = jiffies;
-#ifdef CONFIG_PREEMPT_RT_FULL
-		init_swait_queue_head(&base->wait_for_running_timer);
-#endif
+		spin_lock_init(&base->expiry_lock);
 	}
 }
 
diff --git a/localversion-rt b/localversion-rt
index 9969a4b69fade..0c40e2660574c 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt111
+-rt112

