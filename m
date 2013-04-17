From: Zhao Hongjiang <zhaohongjiang@huawei.com>
Subject: [PATCH] timers: prepare for full preemption improve
Date: Wed, 17 Apr 2013 17:44:16 +0800
Message-ID: <516E6EF0.3080309@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: <tglx@linutronix.de>, <rostedt@goodmis.org>
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:7054 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965780Ab3DQJom (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 17 Apr 2013 05:44:42 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

wake_up should do nothing on the nort, so we should use wakeup_timer_waiters,
also fix a spell mistake.

Signed-off-by: Zhao Hongjiang <zhaohongjiang@huawei.com>
---
 kernel/timer.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/timer.c b/kernel/timer.c
index 62fc642..211e836 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -76,7 +76,9 @@ struct tvec_root {
 struct tvec_base {
 	spinlock_t lock;
 	struct timer_list *running_timer;
+#ifdef CONFIG_PREEMPT_RT_BASE
 	wait_queue_head_t wait_for_running_timer;
+#endif
 	unsigned long timer_jiffies;
 	unsigned long next_timer;
 	struct tvec_root tv1;
@@ -974,7 +976,7 @@ static void wait_for_running_timer(struct timer_list *timer)
 			   base->running_timer != timer);
 }
 
-# define wakeup_timer_waiters(b)	wake_up(&(b)->wait_for_tunning_timer)
+# define wakeup_timer_waiters(b)	wake_up(&(b)->wait_for_running_timer)
 #else
 static inline void wait_for_running_timer(struct timer_list *timer)
 {
@@ -1231,7 +1233,7 @@ static inline void __run_timers(struct tvec_base *base)
 			spin_lock_irq(&base->lock);
 		}
 	}
-	wake_up(&base->wait_for_running_timer);
+	wakeup_timer_waiters(base);
 	spin_unlock_irq(&base->lock);
 }
 
@@ -1759,7 +1761,9 @@ static int __cpuinit init_timers_cpu(int cpu)
 	}
 
 	spin_lock_init(&base->lock);
+#ifdef CONFIG_PREEMPT_RT_BASE
 	init_waitqueue_head(&base->wait_for_running_timer);
+#endif
 
 	for (j = 0; j < TVN_SIZE; j++) {
 		INIT_LIST_HEAD(base->tv5.vec + j);
-- 1.7.1

