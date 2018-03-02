From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [RFC/PATCH RT] Revert "rt,ntp: Move call to schedule_delayed_work()
 to helper thread"
Date: Fri, 2 Mar 2018 12:11:02 +0100
Message-ID: <20180302111050.dlrh4egvgns6wwwj@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

I've been looking at this in v3.10-RT where it got in. The patch
description says

|The ntp code for notify_cmos_timer() is called from a hard interrupt
|context.

I see only one caller of ntp_notify_cmos_timer() and that is
do_adjtimex() after "raw_spin_unlock_irqrestore()".
I see a few callers of do_adjtimex() which is SYS_adjtimex() (+compat)
and posix_clock_realtime_adj() which in turn is called by
SYS_clock_adjtime().

I can't find the hard interrupt context. May I revert this patch?

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/time/ntp.c | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 2c226b90c231..99e03bec68e4 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -18,7 +18,6 @@
 #include <linux/module.h>
 #include <linux/rtc.h>
 #include <linux/math64.h>
-#include <linux/swork.h>
 
 #include "ntp_internal.h"
 #include "timekeeping_internal.h"
@@ -570,35 +569,10 @@ static void sync_cmos_clock(struct work_struct *work)
 			   &sync_cmos_work, timespec64_to_jiffies(&next));
 }
 
-#ifdef CONFIG_PREEMPT_RT_FULL
-
-static void run_clock_set_delay(struct swork_event *event)
-{
-	queue_delayed_work(system_power_efficient_wq, &sync_cmos_work, 0);
-}
-
-static struct swork_event ntp_cmos_swork;
-
-void ntp_notify_cmos_timer(void)
-{
-	swork_queue(&ntp_cmos_swork);
-}
-
-static __init int create_cmos_delay_thread(void)
-{
-	WARN_ON(swork_get());
-	INIT_SWORK(&ntp_cmos_swork, run_clock_set_delay);
-	return 0;
-}
-early_initcall(create_cmos_delay_thread);
-
-#else
-
 void ntp_notify_cmos_timer(void)
 {
 	queue_delayed_work(system_power_efficient_wq, &sync_cmos_work, 0);
 }
-#endif /* CONFIG_PREEMPT_RT_FULL */
 
 #else
 void ntp_notify_cmos_timer(void) { }
-- 
2.16.2


Sebastian
