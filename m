From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH rt-v4.11] sched/clock: fix early boot splat on clock
 transition to unstable
Date: Fri, 6 Oct 2017 14:31:47 +0200
Message-ID: <20171006123147.ejkezfjvhcycoyyo@linutronix.de>
References: <1507003039-16583-1-git-send-email-paul.gortmaker@windriver.com>
 <20171006100929.3dgt6rb7rdq64cq5@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:38593 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751807AbdJFMbu (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 6 Oct 2017 08:31:50 -0400
Content-Disposition: inline
In-Reply-To: <20171006100929.3dgt6rb7rdq64cq5@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-10-06 12:09:29 [+0200], To Paul Gortmaker wrote:
> On 2017-10-02 23:57:19 [-0400], Paul Gortmaker wrote:
> > On an older machine with a Pentium(R) Dual-Core E5300 I see the
> > the following early (see time stamps) boot splat on clock transition
> > due to TSC unstable (indicated in the last line):
> 
> Would that work for you?
please excuse the nonsense. Now:

From: Peter Zijlstra <peterz@infradead.org>
Date: Fri, 21 Apr 2017 12:11:53 +0200
Subject: [PATCH] sched/clock: Initialize all per-CPU state before switching
 (back) to unstable

In preparation for not keeping the sched_clock_tick() active for
stable TSC, we need to explicitly initialize all per-CPU state
before switching back to unstable.

Note: this patch looses the __gtod_offset calculation; it will be
restored in the next one.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/clock.c |   60 +++++++++++++++++++++++++++++++++------------------
 1 file changed, 39 insertions(+), 21 deletions(-)

--- a/kernel/sched/clock.c
+++ b/kernel/sched/clock.c
@@ -124,6 +124,12 @@ int sched_clock_stable(void)
 	return static_branch_likely(&__sched_clock_stable);
 }
 
+static void __scd_stamp(struct sched_clock_data *scd)
+{
+	scd->tick_gtod = ktime_get_ns();
+	scd->tick_raw = sched_clock();
+}
+
 static void __set_sched_clock_stable(void)
 {
 	struct sched_clock_data *scd = this_scd();
@@ -141,8 +147,37 @@ static void __set_sched_clock_stable(voi
 	tick_dep_clear(TICK_DEP_BIT_CLOCK_UNSTABLE);
 }
 
+/*
+ * If we ever get here, we're screwed, because we found out -- typically after
+ * the fact -- that TSC wasn't good. This means all our clocksources (including
+ * ktime) could have reported wrong values.
+ *
+ * What we do here is an attempt to fix up and continue sort of where we left
+ * off in a coherent manner.
+ *
+ * The only way to fully avoid random clock jumps is to boot with:
+ * "tsc=unstable".
+ */
 static void __sched_clock_work(struct work_struct *work)
 {
+	struct sched_clock_data *scd;
+	int cpu;
+
+	/* take a current timestamp and set 'now' */
+	preempt_disable();
+	scd = this_scd();
+	__scd_stamp(scd);
+	scd->clock = scd->tick_gtod + __gtod_offset;
+	preempt_enable();
+
+	/* clone to all CPUs */
+	for_each_possible_cpu(cpu)
+		per_cpu(sched_clock_data, cpu) = *scd;
+
+	printk(KERN_INFO "sched_clock: Marking unstable (%lld, %lld)<-(%lld, %lld)\n",
+			scd->tick_gtod, __gtod_offset,
+			scd->tick_raw,  __sched_clock_offset);
+
 	static_branch_disable(&__sched_clock_stable);
 }
 
@@ -150,27 +185,11 @@ static DECLARE_WORK(sched_clock_work, __
 
 static void __clear_sched_clock_stable(void)
 {
-	struct sched_clock_data *scd = this_scd();
-
-	/*
-	 * Attempt to make the stable->unstable transition continuous.
-	 *
-	 * Trouble is, this is typically called from the TSC watchdog
-	 * timer, which is late per definition. This means the tick
-	 * values can already be screwy.
-	 *
-	 * Still do what we can.
-	 */
-	__gtod_offset = (scd->tick_raw + __sched_clock_offset) - (scd->tick_gtod);
-
-	printk(KERN_INFO "sched_clock: Marking unstable (%lld, %lld)<-(%lld, %lld)\n",
-			scd->tick_gtod, __gtod_offset,
-			scd->tick_raw,  __sched_clock_offset);
+	if (!sched_clock_stable())
+		return;
 
 	tick_dep_set(TICK_DEP_BIT_CLOCK_UNSTABLE);
-
-	if (sched_clock_stable())
-		schedule_work(&sched_clock_work);
+	schedule_work(&sched_clock_work);
 }
 
 void clear_sched_clock_stable(void)
@@ -357,8 +376,7 @@ void sched_clock_tick(void)
 	 * XXX arguably we can skip this if we expose tsc_clocksource_reliable
 	 */
 	scd = this_scd();
-	scd->tick_raw  = sched_clock();
-	scd->tick_gtod = ktime_get_ns();
+	__scd_stamp(scd);
 
 	if (!sched_clock_stable() && likely(sched_clock_running))
 		sched_clock_local(scd);

Sebastian
