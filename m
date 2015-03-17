From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 2/4] Revert "timers: do not raise softirq unconditionally"
Date: Tue, 17 Mar 2015 12:30:15 -0400
Message-ID: <20150317163059.464641932@goodmis.org>
References: <20150317163013.873592599@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:37272 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932702AbbCQQbD (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 17 Mar 2015 12:31:03 -0400
Content-Disposition: inline; filename=0037-Revert-timers-do-not-raise-softirq-unconditionally.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

3.12.38-rt53-rc2 stable review patch.
If anyone has any objections, please let me know.

------------------

From: "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>

This reverts commit e8886d18e87ca7a578cd85467418a0de693588ca

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Conflicts:
	kernel/timer.c
---
 include/linux/hrtimer.h |  3 ++-
 kernel/hrtimer.c        | 31 ++++++++++++++++++++++++-------
 kernel/timer.c          | 46 ++--------------------------------------------
 3 files changed, 28 insertions(+), 52 deletions(-)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index bdbf77db0f4d..79a7a35e1a6e 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -461,8 +461,9 @@ extern int schedule_hrtimeout_range_clock(ktime_t *expires,
 		unsigned long delta, const enum hrtimer_mode mode, int clock);
 extern int schedule_hrtimeout(ktime_t *expires, const enum hrtimer_mode mode);
 
-/* Called from the periodic timer tick */
+/* Soft interrupt function to run the hrtimer queues: */
 extern void hrtimer_run_queues(void);
+extern void hrtimer_run_pending(void);
 
 /* Bootup initialization: */
 extern void __init hrtimers_init(void);
diff --git a/kernel/hrtimer.c b/kernel/hrtimer.c
index c967b718ab37..ba64ab0d5792 100644
--- a/kernel/hrtimer.c
+++ b/kernel/hrtimer.c
@@ -1716,6 +1716,30 @@ static void run_hrtimer_softirq(struct softirq_action *h)
 }
 
 /*
+ * Called from timer softirq every jiffy, expire hrtimers:
+ *
+ * For HRT its the fall back code to run the softirq in the timer
+ * softirq context in case the hrtimer initialization failed or has
+ * not been done yet.
+ */
+void hrtimer_run_pending(void)
+{
+	if (hrtimer_hres_active())
+		return;
+
+	/*
+	 * This _is_ ugly: We have to check in the softirq context,
+	 * whether we can switch to highres and / or nohz mode. The
+	 * clocksource switch happens in the timer interrupt with
+	 * xtime_lock held. Notification from there only sets the
+	 * check bit in the tick_oneshot code, otherwise we might
+	 * deadlock vs. xtime_lock.
+	 */
+	if (tick_check_oneshot_change(!hrtimer_is_hres_enabled()))
+		hrtimer_switch_to_hres();
+}
+
+/*
  * Called from hardirq context every jiffy
  */
 void hrtimer_run_queues(void)
@@ -1728,13 +1752,6 @@ void hrtimer_run_queues(void)
 	if (hrtimer_hres_active())
 		return;
 
-	/*
-	 * Check whether we can switch to highres mode.
-	 */
-	if (tick_check_oneshot_change(!hrtimer_is_hres_enabled())
-	    && hrtimer_switch_to_hres())
-		return;
-
 	for (index = 0; index < HRTIMER_MAX_CLOCK_BASES; index++) {
 		base = &cpu_base->clock_base[index];
 		if (!timerqueue_getnext(&base->active))
diff --git a/kernel/timer.c b/kernel/timer.c
index 0ee72212b99c..2d9ba1b9f698 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -1464,6 +1464,8 @@ static void run_timer_softirq(struct softirq_action *h)
 {
 	struct tvec_base *base = __this_cpu_read(tvec_bases);
 
+	hrtimer_run_pending();
+
 #if defined(CONFIG_IRQ_WORK) && defined(CONFIG_PREEMPT_RT_FULL)
 	irq_work_run();
 #endif
@@ -1477,52 +1479,8 @@ static void run_timer_softirq(struct softirq_action *h)
  */
 void run_local_timers(void)
 {
-	struct tvec_base *base = __this_cpu_read(tvec_bases);
-
 	hrtimer_run_queues();
-	/*
-	 * We can access this lockless as we are in the timer
-	 * interrupt. If there are no timers queued, nothing to do in
-	 * the timer softirq.
-	 */
-#ifdef CONFIG_PREEMPT_RT_FULL
-
-#ifndef CONFIG_SMP
-	/*
-	 * The spin_do_trylock() later may fail as the lock may be hold before
-	 * the interrupt arrived. The spin-lock debugging code will raise a
-	 * warning if the try_lock fails on UP. Since this is only an
-	 * optimization for the FULL_NO_HZ case (not to run the timer softirq on
-	 * an nohz_full CPU) we don't really care and shedule the softirq.
-	 */
 	raise_softirq(TIMER_SOFTIRQ);
-	return;
-#endif
-
-	/* On RT, irq work runs from softirq */
-	if (irq_work_needs_cpu()) {
-		raise_softirq(TIMER_SOFTIRQ);
-		return;
-	}
-
-	if (!spin_do_trylock(&base->lock)) {
-		raise_softirq(TIMER_SOFTIRQ);
-		return;
-	}
-#endif
-
-	if (!base->active_timers)
-		goto out;
