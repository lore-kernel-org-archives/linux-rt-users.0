From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 5/9] kernel/hrtimer/hotplug: dont wake ktimersoftd while holding the
 hrtimer base lock
Date: Fri, 01 Dec 2017 20:37:03 -0500
Message-ID: <20171202013712.043535198@goodmis.org>
References: <20171202013658.149533964@goodmis.org>
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
Content-Disposition: inline; filename=0005-kernel-hrtimer-hotplug-don-t-wake-ktimersoftd-while-.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

4.4.102-rt117-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Mike Galbraith <efault@gmx.de>

kernel/hrtimer: don't wakeup a process while holding the hrtimer base lock
missed a path, namely hrtimers_dead_cpu() -> migrate_hrtimer_list().  Defer
raising softirq until after base lock has been released there as well.

Signed-off-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/time/hrtimer.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 78066f7ea2a2..120fc8932165 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1857,7 +1857,7 @@ static void init_hrtimers_cpu(int cpu)
 
 #ifdef CONFIG_HOTPLUG_CPU
 
-static void migrate_hrtimer_list(struct hrtimer_clock_base *old_base,
+static int migrate_hrtimer_list(struct hrtimer_clock_base *old_base,
 				struct hrtimer_clock_base *new_base)
 {
 	struct hrtimer *timer;
@@ -1887,15 +1887,19 @@ static void migrate_hrtimer_list(struct hrtimer_clock_base *old_base,
 	}
 #ifdef CONFIG_PREEMPT_RT_BASE
 	list_splice_tail(&old_base->expired, &new_base->expired);
-	if (!list_empty(&new_base->expired))
-		raise_softirq_irqoff(HRTIMER_SOFTIRQ);
+	/*
+	 * Tell the caller to raise HRTIMER_SOFTIRQ.  We can't safely
+	 * acquire ktimersoftd->pi_lock while the base lock is held.
+	 */
+	return !list_empty(&new_base->expired);
 #endif
+	return 0;
 }
 
 static void migrate_hrtimers(int scpu)
 {
 	struct hrtimer_cpu_base *old_base, *new_base;
-	int i;
+	int i, raise = 0;
 
 	BUG_ON(cpu_online(scpu));
 	tick_cancel_sched_timer(scpu);
@@ -1911,13 +1915,16 @@ static void migrate_hrtimers(int scpu)
 	raw_spin_lock_nested(&old_base->lock, SINGLE_DEPTH_NESTING);
 
 	for (i = 0; i < HRTIMER_MAX_CLOCK_BASES; i++) {
-		migrate_hrtimer_list(&old_base->clock_base[i],
-				     &new_base->clock_base[i]);
+		raise |= migrate_hrtimer_list(&old_base->clock_base[i],
+					      &new_base->clock_base[i]);
 	}
 
 	raw_spin_unlock(&old_base->lock);
 	raw_spin_unlock(&new_base->lock);
 
+	if (raise)
+		raise_softirq_irqoff(HRTIMER_SOFTIRQ);
+
 	/* Check, if we got expired work to do */
 	__hrtimer_peek_ahead_timers();
 	local_irq_enable();
-- 
2.13.2
