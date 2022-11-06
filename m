Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D43BC4332F
	for <linux-rt-users@archiver.kernel.org>; Sun,  6 Nov 2022 19:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbiKFTRS (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 6 Nov 2022 14:17:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiKFTRR (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 6 Nov 2022 14:17:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E89BC19
        for <linux-rt-users@vger.kernel.org>; Sun,  6 Nov 2022 11:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667762179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dtk5d0NaWkpY8+Pb5ei3G1yNnpHhzOtq7E2yo1DA7s8=;
        b=IsWFvlOaMC+u88eusBQ2A9rnJ2+/cke74xlkW0hZe3t+teCLE7jobudrXEVPOnWlc31Y0W
        QJySwF4ua5uMvguk69AhdTRSQ3Vlf9uv5qR4+AxJB0cpxtcISZY22hj6KzuBYYc0JnGUF0
        aCFlpf91GjwerUmatH9rHnVlBn4MdsA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-322-wAJtqb5RPZaPVnqgYtbetg-1; Sun, 06 Nov 2022 14:16:16 -0500
X-MC-Unique: wAJtqb5RPZaPVnqgYtbetg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2C8E31C0512A;
        Sun,  6 Nov 2022 19:16:16 +0000 (UTC)
Received: from localhost (unknown [10.22.32.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D5039492B05;
        Sun,  6 Nov 2022 19:16:15 +0000 (UTC)
From:   "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        stable-rt <stable-rt@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Mark Gross <markgross@kernel.org>,
        Luis Goncalves <lgoncalv@redhat.com>
Subject: [PATCH RT 1/4] timers: Prepare support for PREEMPT_RT
Date:   Sun,  6 Nov 2022 16:16:09 -0300
Message-Id: <20221106191612.21730-2-lgoncalv@redhat.com>
In-Reply-To: <20221106191612.21730-1-lgoncalv@redhat.com>
References: <20221106191612.21730-1-lgoncalv@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Anna-Maria Gleixner <anna-maria@linutronix.de>

v4.14.298-rt141-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


Upstream commit 030dcdd197d77374879bb5603d091eee7d8aba80

When PREEMPT_RT is enabled, the soft interrupt thread can be preempted.  If
the soft interrupt thread is preempted in the middle of a timer callback,
then calling del_timer_sync() can lead to two issues:

  - If the caller is on a remote CPU then it has to spin wait for the timer
    handler to complete. This can result in unbound priority inversion.

  - If the caller originates from the task which preempted the timer
    handler on the same CPU, then spin waiting for the timer handler to
    complete is never going to end.

To avoid these issues, add a new lock to the timer base which is held
around the execution of the timer callbacks. If del_timer_sync() detects
that the timer callback is currently running, it blocks on the expiry
lock. When the callback is finished, the expiry lock is dropped by the
softirq thread which wakes up the waiter and the system makes progress.

This addresses both the priority inversion and the life lock issues.

This mechanism is not used for timers which are marked IRQSAFE as for those
preemption is disabled accross the callback and therefore this situation
cannot happen. The callbacks for such timers need to be individually
audited for RT compliance.

The same issue can happen in virtual machines when the vCPU which runs a
timer callback is scheduled out. If a second vCPU of the same guest calls
del_timer_sync() it will spin wait for the other vCPU to be scheduled back
in. The expiry lock mechanism would avoid that. It'd be trivial to enable
this when paravirt spinlocks are enabled in a guest, but it's not clear
whether this is an actual problem in the wild, so for now it's an RT only
mechanism.

As the softirq thread can be preempted with PREEMPT_RT=y, the SMP variant
of del_timer_sync() needs to be used on UP as well.

[ tglx: Refactored it for mainline ]

Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20190726185753.832418500@linutronix.de
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
---
 kernel/time/timer.c | 121 ++++++++++++++++++++++++++++++++------------
 1 file changed, 88 insertions(+), 33 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 34b6784282ba..316cac30366f 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -198,7 +198,10 @@ EXPORT_SYMBOL(jiffies_64);
 struct timer_base {
 	raw_spinlock_t		lock;
 	struct timer_list	*running_timer;
+#ifdef CONFIG_PREEMPT_RT
 	spinlock_t		expiry_lock;
+	atomic_t		timer_waiters;
+#endif
 	unsigned long		clk;
 	unsigned long		next_expiry;
 	unsigned int		cpu;
@@ -1178,8 +1181,14 @@ int del_timer(struct timer_list *timer)
 }
 EXPORT_SYMBOL(del_timer);
 
-static int __try_to_del_timer_sync(struct timer_list *timer,
-				   struct timer_base **basep)
+/**
+ * try_to_del_timer_sync - Try to deactivate a timer
+ * @timer: timer to delete
+ *
+ * This function tries to deactivate a timer. Upon successful (ret >= 0)
+ * exit the timer is not queued and the handler is not running on any CPU.
+ */
+int try_to_del_timer_sync(struct timer_list *timer)
 {
 	struct timer_base *base;
 	unsigned long flags;
@@ -1187,7 +1196,7 @@ static int __try_to_del_timer_sync(struct timer_list *timer,
 
 	debug_assert_init(timer);
 
-	*basep = base = lock_timer_base(timer, &flags);
+	base = lock_timer_base(timer, &flags);
 
 	if (base->running_timer != timer)
 		ret = detach_if_pending(timer, base, true);
@@ -1196,42 +1205,80 @@ static int __try_to_del_timer_sync(struct timer_list *timer,
 
 	return ret;
 }
+EXPORT_SYMBOL(try_to_del_timer_sync);
 
-/**
- * try_to_del_timer_sync - Try to deactivate a timer
- * @timer: timer to delete
+#ifdef CONFIG_PREEMPT_RT
+static __init void timer_base_init_expiry_lock(struct timer_base *base)
+{
+	spin_lock_init(&base->expiry_lock);
+}
+
+static inline void timer_base_lock_expiry(struct timer_base *base)
+{
+	spin_lock(&base->expiry_lock);
+}
+
+static inline void timer_base_unlock_expiry(struct timer_base *base)
+{
+	spin_unlock(&base->expiry_lock);
+}
+
+/*
+ * The counterpart to del_timer_wait_running().
  *
- * This function tries to deactivate a timer. Upon successful (ret >= 0)
- * exit the timer is not queued and the handler is not running on any CPU.
+ * If there is a waiter for base->expiry_lock, then it was waiting for the
+ * timer callback to finish. Drop expiry_lock and reaquire it. That allows
+ * the waiter to acquire the lock and make progress.
  */
-int try_to_del_timer_sync(struct timer_list *timer)
+static void timer_sync_wait_running(struct timer_base *base)
 {
-	struct timer_base *base;
-
-	return __try_to_del_timer_sync(timer, &base);
+	if (atomic_read(&base->timer_waiters)) {
+		spin_unlock(&base->expiry_lock);
+		spin_lock(&base->expiry_lock);
+	}
 }
-EXPORT_SYMBOL(try_to_del_timer_sync);
 
-#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT_FULL)
-static int __del_timer_sync(struct timer_list *timer)
+/*
+ * This function is called on PREEMPT_RT kernels when the fast path
+ * deletion of a timer failed because the timer callback function was
+ * running.
+ *
+ * This prevents priority inversion, if the softirq thread on a remote CPU
+ * got preempted, and it prevents a life lock when the task which tries to
+ * delete a timer preempted the softirq thread running the timer callback
+ * function.
+ */
+static void del_timer_wait_running(struct timer_list *timer)
 {
-	struct timer_base *base;
-	int ret;
+	u32 tf;
 
-	for (;;) {
-		ret = __try_to_del_timer_sync(timer, &base);
-		if (ret >= 0)
-			return ret;
+	tf = READ_ONCE(timer->flags);
+	if (!(tf & TIMER_MIGRATING)) {
+		struct timer_base *base = get_timer_base(tf);
 
 		/*
-		 * When accessing the lock, timers of base are no longer expired
-		 * and so timer is no longer running.
+		 * Mark the base as contended and grab the expiry lock,
+		 * which is held by the softirq across the timer
+		 * callback. Drop the lock immediately so the softirq can
+		 * expire the next timer. In theory the timer could already
+		 * be running again, but that's more than unlikely and just
+		 * causes another wait loop.
 		 */
-		spin_lock(&base->expiry_lock);
-		spin_unlock(&base->expiry_lock);
+		atomic_inc(&base->timer_waiters);
+		spin_lock_bh(&base->expiry_lock);
+		atomic_dec(&base->timer_waiters);
+		spin_unlock_bh(&base->expiry_lock);
 	}
 }
+#else
+static inline void timer_base_init_expiry_lock(struct timer_base *base) { }
+static inline void timer_base_lock_expiry(struct timer_base *base) { }
+static inline void timer_base_unlock_expiry(struct timer_base *base) { }
+static inline void timer_sync_wait_running(struct timer_base *base) { }
+static inline void del_timer_wait_running(struct timer_list *timer) { }
+#endif
 
+#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT_FULL)
 /**
  * del_timer_sync - deactivate a timer and wait for the handler to finish.
  * @timer: the timer to be deactivated
@@ -1270,6 +1317,8 @@ static int __del_timer_sync(struct timer_list *timer)
  */
 int del_timer_sync(struct timer_list *timer)
 {
+	int ret;
+
 #ifdef CONFIG_LOCKDEP
 	unsigned long flags;
 
@@ -1288,7 +1337,16 @@ int del_timer_sync(struct timer_list *timer)
 	 */
 	WARN_ON(in_irq() && !(timer->flags & TIMER_IRQSAFE));
 
-	return __del_timer_sync(timer);
+	do {
+		ret = try_to_del_timer_sync(timer);
+
+		if (unlikely(ret < 0)) {
+			del_timer_wait_running(timer);
+			cpu_relax();
+		}
+	} while (ret < 0);
+
+	return ret;
 }
 EXPORT_SYMBOL(del_timer_sync);
 #endif
@@ -1356,15 +1414,12 @@ static void expire_timers(struct timer_base *base, struct hlist_head *head)
 			raw_spin_unlock(&base->lock);
 			call_timer_fn(timer, fn, data);
 			base->running_timer = NULL;
-			spin_unlock(&base->expiry_lock);
-			spin_lock(&base->expiry_lock);
 			raw_spin_lock(&base->lock);
 		} else {
 			raw_spin_unlock_irq(&base->lock);
 			call_timer_fn(timer, fn, data);
 			base->running_timer = NULL;
-			spin_unlock(&base->expiry_lock);
-			spin_lock(&base->expiry_lock);
+			timer_sync_wait_running(base);
 			raw_spin_lock_irq(&base->lock);
 		}
 	}
@@ -1658,7 +1713,7 @@ static inline void __run_timers(struct timer_base *base)
 	if (!time_after_eq(jiffies, base->clk))
 		return;
 
-	spin_lock(&base->expiry_lock);
+	timer_base_lock_expiry(base);
 	raw_spin_lock_irq(&base->lock);
 
 	/*
@@ -1686,7 +1741,7 @@ static inline void __run_timers(struct timer_base *base)
 			expire_timers(base, heads + levels);
 	}
 	raw_spin_unlock_irq(&base->lock);
-	spin_unlock(&base->expiry_lock);
+	timer_base_unlock_expiry(base);
 }
 
 /*
@@ -1920,7 +1975,7 @@ static void __init init_timer_cpu(int cpu)
 		base->cpu = cpu;
 		raw_spin_lock_init(&base->lock);
 		base->clk = jiffies;
-		spin_lock_init(&base->expiry_lock);
+		timer_base_init_expiry_lock(base);
 	}
 }
 
-- 
2.38.1

