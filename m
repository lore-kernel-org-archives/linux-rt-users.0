From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 10/13] kernel/hrtimer/hotplug: dont wake ktimersoftd while holding the
 hrtimer base lock
Date: Wed, 17 Jan 2018 10:14:14 -0500
Message-ID: <20180117151432.042904667@goodmis.org>
References: <20180117151404.093229667@goodmis.org>
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
Content-Disposition: inline; filename=0010-kernel-hrtimer-hotplug-don-t-wake-ktimersoftd-while-.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.18.91-rt98-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Mike Galbraith <efault@gmx.de>

kernel/hrtimer: don't wakeup a process while holding the hrtimer base lock
missed a path, namely hrtimers_dead_cpu() -> migrate_hrtimer_list().  Defer
raising softirq until after base lock has been released there as well.

Signed-off-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/time/hrtimer.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 2e869c707628..1e7c0c9b0e77 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1928,7 +1928,7 @@ static void init_hrtimers_cpu(int cpu)
 
 #ifdef CONFIG_HOTPLUG_CPU
 
-static void migrate_hrtimer_list(struct hrtimer_clock_base *old_base,
+static int migrate_hrtimer_list(struct hrtimer_clock_base *old_base,
 				struct hrtimer_clock_base *new_base)
 {
 	struct hrtimer *timer;
@@ -1961,15 +1961,19 @@ static void migrate_hrtimer_list(struct hrtimer_clock_base *old_base,
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
@@ -1985,13 +1989,16 @@ static void migrate_hrtimers(int scpu)
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
