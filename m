From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: v4.11.12-rt10 - hotplug lockdep splat
Date: Thu, 31 Aug 2017 18:18:34 +0200
Message-ID: <20170831161834.t7ymwsnpbko6und5@linutronix.de>
References: <20170818120939.b2rj2whb2hgfzjpm@linutronix.de>
 <1503482024.4970.5.camel@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Mike Galbraith <efault@gmx.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1503482024.4970.5.camel@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2017-08-23 11:53:44 [+0200], Mike Galbraith wrote:
> virt box reminded me this morning to report this gripe.

if you can reproduce it, then this should make it go away:

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1391,7 +1391,7 @@ static inline int hrtimer_rt_defer(struct hrtimer *timer) { return 0; }
 
 #endif
 
-static void __hrtimer_run_queues(struct hrtimer_cpu_base *cpu_base, ktime_t now)
+static int __hrtimer_run_queues(struct hrtimer_cpu_base *cpu_base, ktime_t now)
 {
 	struct hrtimer_clock_base *base = cpu_base->clock_base;
 	unsigned int active = cpu_base->active_bases;
@@ -1432,8 +1432,7 @@ static void __hrtimer_run_queues(struct hrtimer_cpu_base *cpu_base, ktime_t now)
 				raise = 1;
 		}
 	}
-	if (raise)
-		raise_softirq_irqoff(HRTIMER_SOFTIRQ);
+	return raise;
 }
 
 #ifdef CONFIG_HIGH_RES_TIMERS
@@ -1447,6 +1446,7 @@ void hrtimer_interrupt(struct clock_event_device *dev)
 	struct hrtimer_cpu_base *cpu_base = this_cpu_ptr(&hrtimer_bases);
 	ktime_t expires_next, now, entry_time, delta;
 	int retries = 0;
+	int raise;
 
 	BUG_ON(!cpu_base->hres_active);
 	cpu_base->nr_events++;
@@ -1465,7 +1465,7 @@ void hrtimer_interrupt(struct clock_event_device *dev)
 	 */
 	cpu_base->expires_next = KTIME_MAX;
 
-	__hrtimer_run_queues(cpu_base, now);
+	raise = __hrtimer_run_queues(cpu_base, now);
 
 	/* Reevaluate the clock bases for the next expiry */
 	expires_next = __hrtimer_get_next_event(cpu_base);
@@ -1476,6 +1476,8 @@ void hrtimer_interrupt(struct clock_event_device *dev)
 	cpu_base->expires_next = expires_next;
 	cpu_base->in_hrtirq = 0;
 	raw_spin_unlock(&cpu_base->lock);
+	if (raise)
+		raise_softirq_irqoff(HRTIMER_SOFTIRQ);
 
 	/* Reprogramming necessary ? */
 	if (!tick_program_event(expires_next, 0)) {
@@ -1555,6 +1557,7 @@ void hrtimer_run_queues(void)
 {
 	struct hrtimer_cpu_base *cpu_base = this_cpu_ptr(&hrtimer_bases);
 	ktime_t now;
+	int raise;
 
 	if (__hrtimer_hres_active(cpu_base))
 		return;
@@ -1573,8 +1576,10 @@ void hrtimer_run_queues(void)
 
 	raw_spin_lock(&cpu_base->lock);
 	now = hrtimer_update_base(cpu_base);
-	__hrtimer_run_queues(cpu_base, now);
+	raise = __hrtimer_run_queues(cpu_base, now);
 	raw_spin_unlock(&cpu_base->lock);
+	if (raise)
+		raise_softirq_irqoff(HRTIMER_SOFTIRQ);
 }
 
 /*

Sebastian
