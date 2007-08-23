From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: Re: [PATCH] Fixes spurious system load spikes in /proc/loadavgrt
Date: Thu, 23 Aug 2007 13:13:04 -0300
Message-ID: <20070823161304.GA27162@unix.sh>
References: <20070817003751.GN3954@unix.sh> <1187883233.1453.60.camel@sx.thebigcorporation.com> <20070823155105.GA29405@elte.hu> <1187884653.1453.67.camel@sx.thebigcorporation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org
To: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from itaqui.hst.terra.com.br ([200.176.10.211]:41134 "EHLO
	itaqui.hst.terra.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756628AbXHWQWg (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 23 Aug 2007 12:22:36 -0400
Received: from sr01-01.mta.terra.com.br (sr01-01.mta.terra.com.br [200.154.152.20])
	by itaqui.hst.terra.com.br (Postfix) with ESMTP id 68376FC08C
	for <linux-rt-users@vger.kernel.org>; Thu, 23 Aug 2007 13:19:48 -0300 (BRT)
Content-Disposition: inline
In-Reply-To: <1187884653.1453.67.camel@sx.thebigcorporation.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, Aug 23, 2007 at 08:57:32AM -0700, Sven-Thorsten Dietrich wrote:
| On Thu, 2007-08-23 at 17:51 +0200, Ingo Molnar wrote:
| > * Sven-Thorsten Dietrich <sven@thebigcorporation.com> wrote:
| > 
| > > On Thu, 2007-08-16 at 21:37 -0300, Luis Claudio R. Goncalves wrote:
| > > > Hello,
| > > > 
| > > > The values in /proc/loadavgrt are sometimes the real load and sometimes
| > > > garbage. As you can see in th tests below, it occurs from in 2.6.21.5-rt20 
| > > > to 2.6.23-rc2-rt2. The code for calc_load(), in kernel/timer.c has not
| > > > changed much in -rt patches.
...
| > > >  		active_tasks = count_active_tasks();
| > > > +		active_rt_tasks = count_active_rt_tasks();
| > > 
| > > Where is this used?
| > 
| > what is "this"? /proc/loadavg? Or the code/patch you quoted?
| 
| active_rt_tasks

Good point! I misspelled it in my first patch. 
This one should be better!

---------->

Fixes spurious system load spikes observed in /proc/loadavgrt, as described in:

  Bug 253103: /proc/loadavgrt issues weird results
  https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=253103

Signed-off-by: Luis Claudio R. Goncalves <lclaudio@uudg.org>
---

diff --git a/kernel/sched.c b/kernel/sched.c
index 811a502..c61609a 100644
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -2520,6 +2520,13 @@ unsigned long rt_nr_uninterruptible(void)
 	for_each_online_cpu(i)
 		sum += cpu_rq(i)->rt_nr_uninterruptible;
 
+	/*
+	 * Since we read the counters lockless, it might be slightly
+	 * inaccurate. Do not allow it to go below zero though:
+	 */
+	if (unlikely((long)sum < 0))
+		sum = 0;
+
 	return sum;
 }
 
diff --git a/kernel/timer.c b/kernel/timer.c
index 882ca9d..0e49bf6 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -1432,23 +1432,25 @@ unsigned long avenrun_rt[3];
 static inline void calc_load(unsigned long ticks)
 {
 	unsigned long active_tasks; /* fixed-point */
+	unsigned long active_rt_tasks; /* fixed-point */
 	static int count = LOAD_FREQ;
 
 	count -= ticks;
 	if (unlikely(count < 0)) {
 		active_tasks = count_active_tasks();
+		active_rt_tasks = count_active_rt_tasks();
 		do {
 			CALC_LOAD(avenrun[0], EXP_1, active_tasks);
 			CALC_LOAD(avenrun[1], EXP_5, active_tasks);
 			CALC_LOAD(avenrun[2], EXP_15, active_tasks);
-			count += LOAD_FREQ;
-		} while (count < 0);
 #ifdef CONFIG_PREEMPT_RT
-		active_tasks = count_active_rt_tasks();
-		CALC_LOAD(avenrun_rt[0], EXP_1, active_tasks);
-		CALC_LOAD(avenrun_rt[1], EXP_5, active_tasks);
-		CALC_LOAD(avenrun_rt[2], EXP_15, active_tasks);
+			CALC_LOAD(avenrun_rt[0], EXP_1, active_rt_tasks);
+			CALC_LOAD(avenrun_rt[1], EXP_5, active_rt_tasks);
+			CALC_LOAD(avenrun_rt[2], EXP_15, active_rt_tasks);
 #endif
+			count += LOAD_FREQ;
+
+		} while (count < 0);
 	}
 }
 
-
-- 
