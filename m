From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 08/15] kernel/hrtimer: dont wakeup a process while holding the hrtimer base
 lock
Date: Fri, 01 Dec 2017 19:01:57 -0500
Message-ID: <20171202000427.883405532@goodmis.org>
References: <20171202000149.842718953@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com, Alex Shi <alex.shi@linaro.org>,
        Mike Galbraith <efault@gmx.de>
To: linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0008-kernel-hrtimer-don-t-wakeup-a-process-while-holding-.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

4.9.65-rt57-rc2 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

We must not wake any process (and thus acquire the pi->lock) while
holding the hrtimer's base lock. This does not happen usually because
the hrtimer-callback is invoked in IRQ-context and so
raise_softirq_irqoff() does not wakeup a process.
However during CPU-hotplug it might get called from hrtimers_dead_cpu()
which would wakeup the thread immediately.

Reported-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/time/hrtimer.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 39e4435b8451..8a20ef6919d9 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1440,7 +1440,7 @@ static inline int hrtimer_rt_defer(struct hrtimer *timer) { return 0; }
 
 static enum hrtimer_restart hrtimer_wakeup(struct hrtimer *timer);
 
-static void __hrtimer_run_queues(struct hrtimer_cpu_base *cpu_base, ktime_t now)
+static int __hrtimer_run_queues(struct hrtimer_cpu_base *cpu_base, ktime_t now)
 {
 	struct hrtimer_clock_base *base = cpu_base->clock_base;
 	unsigned int active = cpu_base->active_bases;
@@ -1490,8 +1490,7 @@ static void __hrtimer_run_queues(struct hrtimer_cpu_base *cpu_base, ktime_t now)
 				raise = 1;
 		}
 	}
-	if (raise)
-		raise_softirq_irqoff(HRTIMER_SOFTIRQ);
+	return raise;
 }
 
 #ifdef CONFIG_HIGH_RES_TIMERS
@@ -1505,6 +1504,7 @@ void hrtimer_interrupt(struct clock_event_device *dev)
 	struct hrtimer_cpu_base *cpu_base = this_cpu_ptr(&hrtimer_bases);
 	ktime_t expires_next, now, entry_time, delta;
 	int retries = 0;
+	int raise;
 
 	BUG_ON(!cpu_base->hres_active);
 	cpu_base->nr_events++;
@@ -1523,7 +1523,7 @@ void hrtimer_interrupt(struct clock_event_device *dev)
 	 */
 	cpu_base->expires_next.tv64 = KTIME_MAX;
 
-	__hrtimer_run_queues(cpu_base, now);
+	raise = __hrtimer_run_queues(cpu_base, now);
 
 	/* Reevaluate the clock bases for the next expiry */
 	expires_next = __hrtimer_get_next_event(cpu_base);
@@ -1534,6 +1534,8 @@ void hrtimer_interrupt(struct clock_event_device *dev)
 	cpu_base->expires_next = expires_next;
 	cpu_base->in_hrtirq = 0;
 	raw_spin_unlock(&cpu_base->lock);
+	if (raise)
+		raise_softirq_irqoff(HRTIMER_SOFTIRQ);
 
 	/* Reprogramming necessary ? */
 	if (!tick_program_event(expires_next, 0)) {
@@ -1613,6 +1615,7 @@ void hrtimer_run_queues(void)
 {
 	struct hrtimer_cpu_base *cpu_base = this_cpu_ptr(&hrtimer_bases);
 	ktime_t now;
+	int raise;
 
 	if (__hrtimer_hres_active(cpu_base))
 		return;
@@ -1631,8 +1634,10 @@ void hrtimer_run_queues(void)
 
 	raw_spin_lock(&cpu_base->lock);
 	now = hrtimer_update_base(cpu_base);
-	__hrtimer_run_queues(cpu_base, now);
+	raise = __hrtimer_run_queues(cpu_base, now);
 	raw_spin_unlock(&cpu_base->lock);
+	if (raise)
+		raise_softirq_irqoff(HRTIMER_SOFTIRQ);
 }
 
 /*
-- 
2.13.2
