From: Mike Galbraith <efault@gmx.de>
Subject: [patch] clockevents: Reinstate the per cpu tick skew
Date: Tue, 27 Dec 2011 10:20:05 +0100
Message-ID: <1324977605.5217.132.camel@marge.simson.net>
References: <1324717569.5025.73.camel@marge.simson.net>
	 <1324968044.5217.103.camel@marge.simson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Ingo Molnar <mingo@elte.hu>,
	Arjan van de Ven <arjan@linux.intel.com>
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:44252 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752578Ab1L0JUK (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 27 Dec 2011 04:20:10 -0500
In-Reply-To: <1324968044.5217.103.camel@marge.simson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Quoting removal commit af5ab277ded04bd9bc6b048c5a2f0e7d70ef0867
Historically, Linux has tried to make the regular timer tick on the
various CPUs not happen at the same time, to avoid contention on
xtime_lock.
    
Nowadays, with the tickless kernel, this contention no longer happens
since time keeping and updating are done differently. In addition,
this skew is actually hurting power consumption in a measurable way on
many-core systems.
End quote

Contention remains a problem if NO_HZ is either not configured, or is
nohz=off disabled due to workload constraints.  The RT kernel running
nohz=off was measured to be using > 1.4% CPU just ticking 64 CPUs, with
tick perturbation reaching ~80us.  For loads where measured (>100us)
NO_HZ latencies are intolerable, a must have.

Signed-off-by: Mike Galbraith <efault@gmx.de>
Cc: Arjan van de Ven <arjan@linux.intel.com>

---
 kernel/time/tick-sched.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -689,6 +689,7 @@ static inline void tick_check_nohz(int c
 
 static inline void tick_nohz_switch_to_nohz(void) { }
 static inline void tick_check_nohz(int cpu) { }
+#define tick_nohz_enabled 0
 
 #endif /* NO_HZ */
 
@@ -777,6 +778,14 @@ void tick_setup_sched_timer(void)
 	/* Get the next period (per cpu) */
 	hrtimer_set_expires(&ts->sched_timer, tick_init_jiffy_update());
 
+	/* Offset the tick when NO_HZ is configured out or boot disabled */
+	if (!tick_nohz_enabled) {
+		u64 offset = ktime_to_ns(tick_period) >> 1;
+		do_div(offset, num_possible_cpus());
+		offset *= smp_processor_id();
+		hrtimer_add_expires_ns(&ts->sched_timer, offset);
+	}
+
 	for (;;) {
 		hrtimer_forward(&ts->sched_timer, now, tick_period);
 		hrtimer_start_expires(&ts->sched_timer,


