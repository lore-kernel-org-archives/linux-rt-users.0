From: Mike Galbraith <efault@gmx.de>
Subject: Re: v4.11.12-rt10 - hotplug lockdep splat
Date: Sun, 03 Sep 2017 04:48:10 +0200
Message-ID: <1504406890.3054.3.camel@gmx.de>
References: <20170818120939.b2rj2whb2hgfzjpm@linutronix.de>
         <1503482024.4970.5.camel@gmx.de>
         <20170831161834.t7ymwsnpbko6und5@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Cc: Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170831161834.t7ymwsnpbko6und5@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 2017-08-31 at 18:18 +0200, Sebastian Andrzej Siewior wrote:
> On 2017-08-23 11:53:44 [+0200], Mike Galbraith wrote:
> > virt box reminded me this morning to report this gripe.
> 
> if you can reproduce it, then this should make it go away:

Missed a spot.  With this on top, lockdep went silent.

kernel/hrtimer/hotplug: don't wake ktimersoftd while holding the hrtimer base lock

kernel/hrtimer: don't wakeup a process while holding the hrtimer base lock
missed a path, namely hrtimers_dead_cpu() -> migrate_hrtimer_list().  Defer
raising softirq until after base lock has been released there as well.

Signed-off-by: Mike Galbraith <efault@gmx.de>
---
 kernel/time/hrtimer.c |   19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1779,7 +1779,7 @@ int hrtimers_prepare_cpu(unsigned int cp
 
 #ifdef CONFIG_HOTPLUG_CPU
 
-static void migrate_hrtimer_list(struct hrtimer_clock_base *old_base,
+static int migrate_hrtimer_list(struct hrtimer_clock_base *old_base,
 				struct hrtimer_clock_base *new_base)
 {
 	struct hrtimer *timer;
@@ -1809,15 +1809,19 @@ static void migrate_hrtimer_list(struct
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
 
 int hrtimers_dead_cpu(unsigned int scpu)
 {
 	struct hrtimer_cpu_base *old_base, *new_base;
-	int i;
+	int i, raise = 0;
 
 	BUG_ON(cpu_online(scpu));
 	tick_cancel_sched_timer(scpu);
@@ -1833,13 +1837,16 @@ int hrtimers_dead_cpu(unsigned int scpu)
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
