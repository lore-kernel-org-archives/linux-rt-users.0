From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch RT 2/7] Latency histograms: Adjust timer,
 if already elapsed when programmed
Date: Wed, 11 Jul 2012 22:05:18 -0000
Message-ID: <20120711215611.727482885@linutronix.de>
References: <20120711214552.036760674@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	RT-users <linux-rt-users@vger.kernel.org>,
	Carsten Emde <cbe@osadl.org>
To: LKML <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline;
 filename=latency-histograms-adjust-timer-if-already-elapsed-when-programmed.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Nothing prevents a programmer from calling clock_nanosleep() with an
already elapsed wakeup time in absolute time mode or with a too small
delay in relative time mode. Such timers cannot wake up in time and,
thus, should be corrected when entered into the missed timers latency
histogram (CONFIG_MISSED_TIMERS_HIST).

This patch marks such timers and uses a corrected expiration time. 

Signed-off-by: Carsten Emde <C.Emde@osadl.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 include/linux/hrtimer.h |    3 +++
 kernel/hrtimer.c        |   16 ++++++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

Index: linux-3.4.2-rt10-64+/include/linux/hrtimer.h
===================================================================
--- linux-3.4.2-rt10-64+.orig/include/linux/hrtimer.h
+++ linux-3.4.2-rt10-64+/include/linux/hrtimer.h
@@ -113,6 +113,9 @@ struct hrtimer {
 	unsigned long			state;
 	struct list_head		cb_entry;
 	int				irqsafe;
+#ifdef CONFIG_MISSED_TIMER_OFFSETS_HIST
+	ktime_t 			praecox;
+#endif
 #ifdef CONFIG_TIMER_STATS
 	int				start_pid;
 	void				*start_site;
Index: linux-3.4.2-rt10-64+/kernel/hrtimer.c
===================================================================
--- linux-3.4.2-rt10-64+.orig/kernel/hrtimer.c
+++ linux-3.4.2-rt10-64+/kernel/hrtimer.c
@@ -1021,6 +1021,17 @@ int __hrtimer_start_range_ns(struct hrti
 #endif
 	}
 
+#ifdef CONFIG_MISSED_TIMER_OFFSETS_HIST
+	{
+		ktime_t now = new_base->get_time();
+
+		if (ktime_to_ns(tim) < ktime_to_ns(now))
+			timer->praecox = now;
+		else
+			timer->praecox = ktime_set(0, 0);
+	}
+#endif
+
 	hrtimer_set_expires_range_ns(timer, tim, delta_ns);
 
 	timer_stats_hrtimer_set_start_info(timer);
@@ -1458,8 +1469,9 @@ retry:
 			timer = container_of(node, struct hrtimer, node);
 
 			trace_hrtimer_interrupt(raw_smp_processor_id(),
-			    ktime_to_ns(ktime_sub(
-				hrtimer_get_expires(timer), basenow)),
+			    ktime_to_ns(ktime_sub(ktime_to_ns(timer->praecox) ?
+				timer->praecox : hrtimer_get_expires(timer),
+				basenow)),
 			    current,
 			    timer->function == hrtimer_wakeup ?
 			    container_of(timer, struct hrtimer_sleeper,
