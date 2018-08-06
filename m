From: Julia Cartwright <julia@ni.com>
Subject: [PATCH RT 14/22] Revert "rt,ntp: Move call to schedule_delayed_work() to helper thread"
Date: Mon,  6 Aug 2018 04:17:30 -0500
Message-ID: <b9699e9fe2effcc1e54e54e04d247f5b6cf1b294.1533540554.git.julia@ni.com>
References: <cover.1533540554.git.julia@ni.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com, stable-rt@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1533540554.git.julia@ni.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

4.9.115-rt94-rc1 stable review patch.
If you have any objection to the inclusion of this patch, let me know.

--- 8< --- 8< --- 8< ---
I've been looking at this in v3.10-RT where it got in. The patch
description says

|The ntp code for notify_cmos_timer() is called from a hard interrupt
|context.

I see only one caller of ntp_notify_cmos_timer() and that is
do_adjtimex() after "raw_spin_unlock_irqrestore()".
I see a few callers of do_adjtimex() which is SYS_adjtimex() (+compat)
and posix_clock_realtime_adj() which in turn is called by
SYS_clock_adjtime().

Reverting the patch.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
(cherry picked from commit 932c5783d4434250a1019f49ae81b80731dfd4cd)
Signed-off-by: Julia Cartwright <julia@ni.com>
---
 kernel/time/ntp.c | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 05b7391bf9bd..6df8927c58a5 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -17,7 +17,6 @@
 #include <linux/module.h>
 #include <linux/rtc.h>
 #include <linux/math64.h>
-#include <linux/swork.h>
 
 #include "ntp_internal.h"
 #include "timekeeping_internal.h"
@@ -569,35 +568,10 @@ static void sync_cmos_clock(struct work_struct *work)
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
2.18.0
