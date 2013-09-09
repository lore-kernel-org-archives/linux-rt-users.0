From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 06/16] timers: prepare for full preemption improve
Date: Mon, 09 Sep 2013 10:35:23 -0400
Message-ID: <20130909143535.120360363@goodmis.org>
References: <20130909143517.641735717@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>, <stable-rt@vger.kernel.org>,
	Zhao Hongjiang <zhaohongjiang@huawei.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:21912 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754331Ab3IIP0s (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 9 Sep 2013 11:26:48 -0400
Content-Disposition: inline; filename=0006-timers-prepare-for-full-preemption-improve.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Zhao Hongjiang <zhaohongjiang@huawei.com>

wake_up should do nothing on the nort, so we should use wakeup_timer_waiters,
also fix a spell mistake.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Zhao Hongjiang <zhaohongjiang@huawei.com>
[bigeasy: s/CONFIG_PREEMPT_RT_BASE/CONFIG_PREEMPT_RT_FULL/]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/timer.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/timer.c b/kernel/timer.c
index 2e21a6c..07070cb 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -76,7 +76,9 @@ struct tvec_root {
 struct tvec_base {
 	spinlock_t lock;
 	struct timer_list *running_timer;
+#ifdef CONFIG_PREEMPT_RT_FULL
 	wait_queue_head_t wait_for_running_timer;
+#endif
 	unsigned long timer_jiffies;
 	unsigned long next_timer;
 	struct tvec_root tv1;
@@ -930,7 +932,7 @@ static void wait_for_running_timer(struct timer_list *timer)
 			   base->running_timer != timer);
 }
 
-# define wakeup_timer_waiters(b)	wake_up(&(b)->wait_for_tunning_timer)
+# define wakeup_timer_waiters(b)	wake_up(&(b)->wait_for_running_timer)
 #else
 static inline void wait_for_running_timer(struct timer_list *timer)
 {
@@ -1183,7 +1185,7 @@ static inline void __run_timers(struct tvec_base *base)
 			spin_lock_irq(&base->lock);
 		}
 	}
-	wake_up(&base->wait_for_running_timer);
+	wakeup_timer_waiters(base);
 	spin_unlock_irq(&base->lock);
 }
 
@@ -1706,7 +1708,9 @@ static int __cpuinit init_timers_cpu(int cpu)
 			base = &boot_tvec_bases;
 		}
 		spin_lock_init(&base->lock);
+#ifdef CONFIG_PREEMPT_RT_FULL
 		init_waitqueue_head(&base->wait_for_running_timer);
+#endif
 		tvec_base_done[cpu] = 1;
 	} else {
 		base = per_cpu(tvec_bases, cpu);
-- 
1.7.10.4


