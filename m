From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [RT PATCH 1/2] timers: wakeup all timer waiters
Date: Thu, 14 Jul 2016 18:05:03 +0200
Message-ID: <1468512304-15310-1-git-send-email-bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
	Steven Rostedt <rostedt@goodmis.org>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:45229 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149AbcGNQFI (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 14 Jul 2016 12:05:08 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

The base lock is dropped during the invocation if the timer. That means
it is possible that we have one waiter while timer1 is running and once
this one finished, we get another waiter while timer2 is running. Since
we wake up only one waiter it is possible that we miss the other one.
This will probably heal itself over time because most of the time we
complete timers without an active wake up.
To avoid the scenario where we don't wake up all waiters at once,
wake_up_all() is used.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/time/timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 5f9d3599ef0a..b3c3d3a6216f 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1051,7 +1051,7 @@ static void wait_for_running_timer(struct timer_list *timer)
 		   base->running_timer != timer);
 }
 
-# define wakeup_timer_waiters(b)	wake_up(&(b)->wait_for_running_timer)
+# define wakeup_timer_waiters(b)	wake_up_all(&(b)->wait_for_running_timer)
 #else
 static inline void wait_for_running_timer(struct timer_list *timer)
 {
-- 
2.8.1

