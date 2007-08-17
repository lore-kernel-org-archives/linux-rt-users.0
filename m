From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: [PATCH] Fixes spurious system load spikes in /proc/loadavgrt
Date: Thu, 16 Aug 2007 21:37:51 -0300
Message-ID: <20070817003751.GN3954@unix.sh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from marova.hst.terra.com.br ([200.176.10.215]:45135 "EHLO
	marova.hst.terra.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755073AbXHQB40 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 16 Aug 2007 21:56:26 -0400
Received: from sr04-08.mta.terra.com.br (sr04-08.mta.terra.com.br [200.154.152.57])
	by marova.hst.terra.com.br (Postfix) with ESMTP id 0B40F3B7E02
	for <linux-rt-users@vger.kernel.org>; Thu, 16 Aug 2007 21:43:09 -0300 (BRT)
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello,

The values in /proc/loadavgrt are sometimes the real load and sometimes
garbage. As you can see in th tests below, it occurs from in 2.6.21.5-rt20 
to 2.6.23-rc2-rt2. The code for calc_load(), in kernel/timer.c has not
changed much in -rt patches.

        [lclaudio@lab sandbox]$ ls /proc/loadavg*
        /proc/loadavg  /proc/loadavgrt
        [lclaudio@lab sandbox]$ uname -a
        Linux lab.casa 2.6.21-34.el5rt #1 SMP PREEMPT RT Thu Jul 12 15:26:48 EDT 2007 x86_64 x86_64 x86_64 GNU/Linux
        [lclaudio@lab sandbox]$ cat /proc/loadavg*
        4.57 4.90 4.16 3/146 23499
        0.44 0.98 1.78 0/146 23499
        ...
        [lclaudio@lab sandbox]$ cat /proc/loadavg*
        4.65 4.80 4.75 5/144 20720
        23896.04 -898421.23 383170.94 2/144 20720

        [root@neverland ~]# uname -a
        Linux neverland.casa 2.6.21.5-rt20 #2 SMP PREEMPT RT Fri Jul 1318:31:38 BRT 2007 i686 athlon i386 GNU/Linux
        [root@neverland ~]# cat /proc/loadavg*
        0.16 0.16 0.15 1/184 11240
        344.65 0.38 311.71 0/184 11240

        [williams@torg ~]$ uname -a
        Linux torg 2.6.23-rc2-rt2 #14 SMP PREEMPT RT Tue Aug 7 20:07:31 CDT 2007 x86_64 x86_64 x86_64 GNU/Linux
        [williams@torg ~]$ cat /proc/loadavg*
        0.88 0.76 0.57 1/257 7267
        122947.70 103790.53 -564712.87 0/257 7267

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
 
diff --git a/linux-2.6.21.x86_64/kernel/timer.c b/linux-2.6.21.x86_64_lc/kernel/timer.c
index 882ca9d..0e49bf6 100644
--- a/linux-2.6.21.x86_64/kernel/timer.c
+++ b/linux-2.6.21.x86_64_lc/kernel/timer.c
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
+			CALC_LOAD(avenrun_rt[0], EXP_1, active_tasks);
+			CALC_LOAD(avenrun_rt[1], EXP_5, active_tasks);
+			CALC_LOAD(avenrun_rt[2], EXP_15, active_tasks);
 #endif
+			count += LOAD_FREQ;
+
+		} while (count < 0);
 	}
 }
 
-
-- 
[ Luis Claudio R. Goncalves                   lclaudio at uudg dot org ]
[ Fingerprint:   4FDD B8C4 3C59 34BD 8BE9  2696 7203 D980 A448 C8F8    ]
[ Linux-HA Developer - LateNite Programmer - Gospel User - Bass Player ]
[ Fault Tolerance - Real-Time - Distributed Systems - IECLB - Is 40:31 ]
