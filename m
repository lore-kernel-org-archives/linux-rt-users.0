From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH rt-v4.11] sched/clock: fix early boot splat on clock
 transition to unstable
Date: Wed, 11 Oct 2017 09:30:14 -0400
Message-ID: <20171011133014.GG3723@windriver.com>
References: <1507003039-16583-1-git-send-email-paul.gortmaker@windriver.com>
 <20171006100929.3dgt6rb7rdq64cq5@linutronix.de>
 <20171006123147.ejkezfjvhcycoyyo@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:46791 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757428AbdJKNaa (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 11 Oct 2017 09:30:30 -0400
Content-Disposition: inline
In-Reply-To: <20171006123147.ejkezfjvhcycoyyo@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

[Re: [PATCH rt-v4.11] sched/clock: fix early boot splat on clock transition to unstable] On 06/10/2017 (Fri 14:31) Sebastian Andrzej Siewior wrote:

> On 2017-10-06 12:09:29 [+0200], To Paul Gortmaker wrote:
> > On 2017-10-02 23:57:19 [-0400], Paul Gortmaker wrote:
> > > On an older machine with a Pentium(R) Dual-Core E5300 I see the
> > > the following early (see time stamps) boot splat on clock transition
> > > due to TSC unstable (indicated in the last line):
> > 
> > Would that work for you?
> please excuse the nonsense. Now:

No problem.  I had to look to see we already had that patch in order
to realize why you called it nonsense.  :)

> 
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Fri, 21 Apr 2017 12:11:53 +0200
> Subject: [PATCH] sched/clock: Initialize all per-CPU state before switching
>  (back) to unstable
> 
> In preparation for not keeping the sched_clock_tick() active for
> stable TSC, we need to explicitly initialize all per-CPU state
> before switching back to unstable.
> 
> Note: this patch looses the __gtod_offset calculation; it will be
> restored in the next one.

Since the commit log mentions taking the next one, I used this (mainline
cf15ca8deda8) and "x86/tsc, sched/clock, clocksource: Use clocksource watchdog
to provide stable sync points" (which is mainline b421b22b00b00)

The tree patched up from scratch without any need to refresh the two newly
exported commits and the old trash box with the broken tsc doesn't have the
boot splat. Note:  I've not [yet] tested on something with a working tsc, but I
doubt that is a concern...

Patch to linux-4.11.y-rt-patches branch follows.  Note that the two newly added
commits are in the series file right above:

  0001-sched-clock-Fix-early-boot-preempt-assumption-in-__s.patch

since that is where they belong chronologically.

Paul.
--

>From e2e84968995428c6472046793c763884971c58ec Mon Sep 17 00:00:00 2001
From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Wed, 11 Oct 2017 08:47:36 -0400
Subject: [PATCH 4.11-rt] sched/tsc: add two mainline commits to fix boot splat

On an older machine with a Pentium(R) Dual-Core E5300 I see the
the following early (see time stamps) boot splat on clock transition
due to TSC unstable (indicated in the last line):

  [  2.487904] BUG: using smp_processor_id() in preemptible [00000000] code: swapper/0/1
  [  2.487909] caller is debug_smp_processor_id+0x17/0x20
  [  2.487911] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.11.12-rt14-00451
  [  2.487911] Hardware name: Dell Inc. OptiPlex 760                 /0M858N, BIOS A16 08/06/2013
  [  2.487912] Call Trace:
  [  2.487918]  dump_stack+0x4f/0x6a
  [  2.487919]  check_preemption_disabled+0xda/0xe0
  [  2.487921]  debug_smp_processor_id+0x17/0x20
  [  2.487924]  clear_sched_clock_stable+0x28/0x80
  [  2.487927]  mark_tsc_unstable+0x22/0x70
  [  2.487930]  acpi_processor_get_power_info+0x3e3/0x6a0
  [  2.487932]  acpi_processor_power_init+0x3a/0x1d0
  [  2.487933]  __acpi_processor_start+0x162/0x1b0
               ....
  [  2.487950]  acpi_processor_driver_init+0x20/0x96
  [  2.487951]  do_one_initcall+0x3f/0x170
  [  2.487954]  kernel_init_freeable+0x18e/0x216
  [  2.487955]  ? rest_init+0xd0/0xd0
  [  2.487956]  kernel_init+0x9/0x100
  [  2.487958]  ret_from_fork+0x22/0x30
  [  2.487960] sched_clock: Marking unstable (2488005383, -223143)<-(2590866395, -103084155)
  [  2.488004] tsc: Marking TSC unstable due to TSC halts in idle

(gdb) list *clear_sched_clock_stable+0x28
0xffffffff8108bbb8 is in clear_sched_clock_stable (kernel/sched/clock.c:114).

[...]

112     static inline struct sched_clock_data *this_scd(void)
113     {
114             return this_cpu_ptr(&sched_clock_data);
115     }

Make use of two mainline commits from post v4.11 to fix this.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

diff --git a/patches/sched-clock-Initialize-all-per-CPU-state-before-swit.patch b/patches/sched-clock-Initialize-all-per-CPU-state-before-swit.patch
new file mode 100644
index 000000000000..95d17edcf2fb
--- /dev/null
+++ b/patches/sched-clock-Initialize-all-per-CPU-state-before-swit.patch
@@ -0,0 +1,122 @@
+From cf15ca8deda86b27b66e27848b4b0fe58098fc0b Mon Sep 17 00:00:00 2001
+From: Peter Zijlstra <peterz@infradead.org>
+Date: Fri, 21 Apr 2017 12:11:53 +0200
+Subject: [PATCH] sched/clock: Initialize all per-CPU state before switching
+ (back) to unstable
+
+commit cf15ca8deda86b27b66e27848b4b0fe58098fc0b upstream.
+
+In preparation for not keeping the sched_clock_tick() active for
+stable TSC, we need to explicitly initialize all per-CPU state
+before switching back to unstable.
+
+Note: this patch looses the __gtod_offset calculation; it will be
+restored in the next one.
+
+Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
+Cc: Linus Torvalds <torvalds@linux-foundation.org>
+Cc: Mike Galbraith <efault@gmx.de>
+Cc: Peter Zijlstra <peterz@infradead.org>
+Cc: Thomas Gleixner <tglx@linutronix.de>
+Cc: linux-kernel@vger.kernel.org
+Signed-off-by: Ingo Molnar <mingo@kernel.org>
+
+diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
+index 00a45c45beca..dc650851935f 100644
+--- a/kernel/sched/clock.c
++++ b/kernel/sched/clock.c
+@@ -124,6 +124,12 @@ int sched_clock_stable(void)
+ 	return static_branch_likely(&__sched_clock_stable);
+ }
+ 
++static void __scd_stamp(struct sched_clock_data *scd)
++{
++	scd->tick_gtod = ktime_get_ns();
++	scd->tick_raw = sched_clock();
++}
++
+ static void __set_sched_clock_stable(void)
+ {
+ 	struct sched_clock_data *scd = this_scd();
+@@ -141,8 +147,37 @@ static void __set_sched_clock_stable(void)
+ 	tick_dep_clear(TICK_DEP_BIT_CLOCK_UNSTABLE);
+ }
+ 
++/*
++ * If we ever get here, we're screwed, because we found out -- typically after
++ * the fact -- that TSC wasn't good. This means all our clocksources (including
++ * ktime) could have reported wrong values.
++ *
++ * What we do here is an attempt to fix up and continue sort of where we left
++ * off in a coherent manner.
++ *
++ * The only way to fully avoid random clock jumps is to boot with:
++ * "tsc=unstable".
++ */
+ static void __sched_clock_work(struct work_struct *work)
+ {
++	struct sched_clock_data *scd;
++	int cpu;
++
++	/* take a current timestamp and set 'now' */
++	preempt_disable();
++	scd = this_scd();
++	__scd_stamp(scd);
++	scd->clock = scd->tick_gtod + __gtod_offset;
++	preempt_enable();
++
++	/* clone to all CPUs */
++	for_each_possible_cpu(cpu)
++		per_cpu(sched_clock_data, cpu) = *scd;
++
++	printk(KERN_INFO "sched_clock: Marking unstable (%lld, %lld)<-(%lld, %lld)\n",
++			scd->tick_gtod, __gtod_offset,
++			scd->tick_raw,  __sched_clock_offset);
++
+ 	static_branch_disable(&__sched_clock_stable);
+ }
+ 
+@@ -150,27 +185,11 @@ static DECLARE_WORK(sched_clock_work, __sched_clock_work);
+ 
+ static void __clear_sched_clock_stable(void)
+ {
+-	struct sched_clock_data *scd = this_scd();
+-
+-	/*
+-	 * Attempt to make the stable->unstable transition continuous.
+-	 *
+-	 * Trouble is, this is typically called from the TSC watchdog
+-	 * timer, which is late per definition. This means the tick
+-	 * values can already be screwy.
+-	 *
+-	 * Still do what we can.
+-	 */
+-	__gtod_offset = (scd->tick_raw + __sched_clock_offset) - (scd->tick_gtod);
+-
+-	printk(KERN_INFO "sched_clock: Marking unstable (%lld, %lld)<-(%lld, %lld)\n",
+-			scd->tick_gtod, __gtod_offset,
+-			scd->tick_raw,  __sched_clock_offset);
++	if (!sched_clock_stable())
++		return;
+ 
+ 	tick_dep_set(TICK_DEP_BIT_CLOCK_UNSTABLE);
+-
+-	if (sched_clock_stable())
+-		schedule_work(&sched_clock_work);
++	schedule_work(&sched_clock_work);
+ }
+ 
+ void clear_sched_clock_stable(void)
+@@ -357,8 +376,7 @@ void sched_clock_tick(void)
+ 	 * XXX arguably we can skip this if we expose tsc_clocksource_reliable
+ 	 */
+ 	scd = this_scd();
+-	scd->tick_raw  = sched_clock();
+-	scd->tick_gtod = ktime_get_ns();
++	__scd_stamp(scd);
+ 
+ 	if (!sched_clock_stable() && likely(sched_clock_running))
+ 		sched_clock_local(scd);
+-- 
+2.1.4
+
diff --git a/patches/series b/patches/series
index 32bfb07ec7d9..5f7de7b66ad9 100644
--- a/patches/series
+++ b/patches/series
@@ -67,6 +67,8 @@ smp-hotplug-Move-unparking-of-percpu-threads-to-the-.patch
 0013-crypto-N2-Replace-racy-task-affinity-logic.patch
 
 # a few patches from tip's sched/core
+sched-clock-Initialize-all-per-CPU-state-before-swit.patch
+x86-tsc-sched-clock-clocksource-Use-clocksource-watc.patch
 0001-sched-clock-Fix-early-boot-preempt-assumption-in-__s.patch
 0001-init-Pin-init-task-to-the-boot-CPU-initially.patch
 0002-arm-Adjust-system_state-check.patch
diff --git a/patches/x86-tsc-sched-clock-clocksource-Use-clocksource-watc.patch b/patches/x86-tsc-sched-clock-clocksource-Use-clocksource-watc.patch
new file mode 100644
index 000000000000..6db62adb5339
--- /dev/null
+++ b/patches/x86-tsc-sched-clock-clocksource-Use-clocksource-watc.patch
@@ -0,0 +1,155 @@
+From b421b22b00b0011f6a2ce3561176c4e79e640c49 Mon Sep 17 00:00:00 2001
+From: Peter Zijlstra <peterz@infradead.org>
+Date: Fri, 21 Apr 2017 12:14:13 +0200
+Subject: [PATCH] x86/tsc, sched/clock, clocksource: Use clocksource watchdog
+ to provide stable sync points
+
+commit b421b22b00b0011f6a2ce3561176c4e79e640c49 upstream.
+
+Currently we keep sched_clock_tick() active for stable TSC in order to
+keep the per-CPU state semi up-to-date. The (obvious) problem is that
+by the time we detect TSC is borked, our per-CPU state is also borked.
+
+So hook into the clocksource watchdog and call a method after we've
+found it to still be stable.
+
+There's the obvious race where the TSC goes wonky between finding it
+stable and us running the callback, but closing that is too much work
+and not really worth it, since we're already detecting TSC wobbles
+after the fact, so we cannot, per definition, fully avoid funny clock
+values.
+
+And since the watchdog runs less often than the tick, this is also an
+optimization.
+
+Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
+Cc: Linus Torvalds <torvalds@linux-foundation.org>
+Cc: Mike Galbraith <efault@gmx.de>
+Cc: Peter Zijlstra <peterz@infradead.org>
+Cc: Thomas Gleixner <tglx@linutronix.de>
+Cc: linux-kernel@vger.kernel.org
+Signed-off-by: Ingo Molnar <mingo@kernel.org>
+
+diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
+index 66015195bd18..c1b16b328abe 100644
+--- a/arch/x86/kernel/tsc.c
++++ b/arch/x86/kernel/tsc.c
+@@ -1033,6 +1033,15 @@ static void tsc_cs_mark_unstable(struct clocksource *cs)
+ 	pr_info("Marking TSC unstable due to clocksource watchdog\n");
+ }
+ 
++static void tsc_cs_tick_stable(struct clocksource *cs)
++{
++	if (tsc_unstable)
++		return;
++
++	if (using_native_sched_clock())
++		sched_clock_tick_stable();
++}
++
+ /*
+  * .mask MUST be CLOCKSOURCE_MASK(64). See comment above read_tsc()
+  */
+@@ -1046,6 +1055,7 @@ static struct clocksource clocksource_tsc = {
+ 	.archdata               = { .vclock_mode = VCLOCK_TSC },
+ 	.resume			= tsc_resume,
+ 	.mark_unstable		= tsc_cs_mark_unstable,
++	.tick_stable		= tsc_cs_tick_stable,
+ };
+ 
+ void mark_tsc_unstable(char *reason)
+diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
+index f2b10d9ebd04..81490456c242 100644
+--- a/include/linux/clocksource.h
++++ b/include/linux/clocksource.h
+@@ -96,6 +96,7 @@ struct clocksource {
+ 	void (*suspend)(struct clocksource *cs);
+ 	void (*resume)(struct clocksource *cs);
+ 	void (*mark_unstable)(struct clocksource *cs);
++	void (*tick_stable)(struct clocksource *cs);
+ 
+ 	/* private: */
+ #ifdef CONFIG_CLOCKSOURCE_WATCHDOG
+diff --git a/include/linux/sched/clock.h b/include/linux/sched/clock.h
+index 34fe92ce1ebd..978cbb0af5f3 100644
+--- a/include/linux/sched/clock.h
++++ b/include/linux/sched/clock.h
+@@ -63,8 +63,8 @@ extern void clear_sched_clock_stable(void);
+  */
+ extern u64 __sched_clock_offset;
+ 
+-
+ extern void sched_clock_tick(void);
++extern void sched_clock_tick_stable(void);
+ extern void sched_clock_idle_sleep_event(void);
+ extern void sched_clock_idle_wakeup_event(u64 delta_ns);
+ 
+diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
+index dc650851935f..f861637f7fdc 100644
+--- a/kernel/sched/clock.c
++++ b/kernel/sched/clock.c
+@@ -366,20 +366,38 @@ void sched_clock_tick(void)
+ {
+ 	struct sched_clock_data *scd;
+ 
++	if (sched_clock_stable())
++		return;
++
++	if (unlikely(!sched_clock_running))
++		return;
++
+ 	WARN_ON_ONCE(!irqs_disabled());
+ 
+-	/*
+-	 * Update these values even if sched_clock_stable(), because it can
+-	 * become unstable at any point in time at which point we need some
+-	 * values to fall back on.
+-	 *
+-	 * XXX arguably we can skip this if we expose tsc_clocksource_reliable
+-	 */
+ 	scd = this_scd();
+ 	__scd_stamp(scd);
++	sched_clock_local(scd);
++}
++
++void sched_clock_tick_stable(void)
++{
++	u64 gtod, clock;
+ 
+-	if (!sched_clock_stable() && likely(sched_clock_running))
+-		sched_clock_local(scd);
++	if (!sched_clock_stable())
++		return;
++
++	/*
++	 * Called under watchdog_lock.
++	 *
++	 * The watchdog just found this TSC to (still) be stable, so now is a
++	 * good moment to update our __gtod_offset. Because once we find the
++	 * TSC to be unstable, any computation will be computing crap.
++	 */
++	local_irq_disable();
++	gtod = ktime_get_ns();
++	clock = sched_clock();
++	__gtod_offset = (clock + __sched_clock_offset) - gtod;
++	local_irq_enable();
+ }
+ 
+ /*
+diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
+index 93621ae718d3..03918a19cf2d 100644
+--- a/kernel/time/clocksource.c
++++ b/kernel/time/clocksource.c
+@@ -233,6 +233,9 @@ static void clocksource_watchdog(unsigned long data)
+ 			continue;
+ 		}
+ 
++		if (cs == curr_clocksource && cs->tick_stable)
++			cs->tick_stable(cs);
++
+ 		if (!(cs->flags & CLOCK_SOURCE_VALID_FOR_HRES) &&
+ 		    (cs->flags & CLOCK_SOURCE_IS_CONTINUOUS) &&
+ 		    (watchdog->flags & CLOCK_SOURCE_IS_CONTINUOUS)) {
+-- 
+2.1.4
+
-- 
2.1.4

