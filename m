From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH rt-v4.11] sched/clock: fix early boot splat on clock
 transition to unstable
Date: Fri, 6 Oct 2017 12:09:29 +0200
Message-ID: <20171006100929.3dgt6rb7rdq64cq5@linutronix.de>
References: <1507003039-16583-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:37834 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751875AbdJFKJc (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 6 Oct 2017 06:09:32 -0400
Content-Disposition: inline
In-Reply-To: <1507003039-16583-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-10-02 23:57:19 [-0400], Paul Gortmaker wrote:
> On an older machine with a Pentium(R) Dual-Core E5300 I see the
> the following early (see time stamps) boot splat on clock transition
> due to TSC unstable (indicated in the last line):

Would that work for you?

>From 45aea321678856687927c53972321ebfab77759a Mon Sep 17 00:00:00 2001
From: Peter Zijlstra <peterz@infradead.org>
Date: Wed, 24 May 2017 08:52:02 +0200
Subject: [PATCH] sched/clock: Fix early boot preempt assumption in
 __set_sched_clock_stable()

The more strict early boot preemption warnings found that
__set_sched_clock_stable() was incorrectly assuming we'd still be
running on a single CPU:

  BUG: using smp_processor_id() in preemptible [00000000] code: swapper/0/1
  caller is debug_smp_processor_id+0x1c/0x1e
  CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.12.0-rc2-00108-g1c3c5ea #1
  Call Trace:
   dump_stack+0x110/0x192
   check_preemption_disabled+0x10c/0x128
   ? set_debug_rodata+0x25/0x25
   debug_smp_processor_id+0x1c/0x1e
   sched_clock_init_late+0x27/0x87
  [...]

Fix it by disabling IRQs.

Reported-by: kernel test robot <xiaolong.ye@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: lkp@01.org
Cc: tipbuild@zytor.com
Link: http://lkml.kernel.org/r/20170524065202.v25vyu7pvba5mhpd@hirez.programming.kicks-ass.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/clock.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
index 1a0d389d2f2b..ca0f8fc945c6 100644
--- a/kernel/sched/clock.c
+++ b/kernel/sched/clock.c
@@ -133,12 +133,19 @@ static void __scd_stamp(struct sched_clock_data *scd)
 
 static void __set_sched_clock_stable(void)
 {
-	struct sched_clock_data *scd = this_scd();
+	struct sched_clock_data *scd;
 
+	/*
+	 * Since we're still unstable and the tick is already running, we have
+	 * to disable IRQs in order to get a consistent scd->tick* reading.
+	 */
+	local_irq_disable();
+	scd = this_scd();
 	/*
 	 * Attempt to make the (initial) unstable->stable transition continuous.
 	 */
 	__sched_clock_offset = (scd->tick_gtod + __gtod_offset) - (scd->tick_raw);
+	local_irq_enable();
 
 	printk(KERN_INFO "sched_clock: Marking stable (%lld, %lld)->(%lld, %lld)\n",
 			scd->tick_gtod, __gtod_offset,
-- 
2.14.2

