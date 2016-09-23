From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 1/7] timers: wakeup all timer waiters
Date: Fri, 23 Sep 2016 12:48:01 -0400
Message-ID: <20160923164809.200384238@goodmis.org>
References: <20160923164800.627094159@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        <stable-rt@vger.kernel.org>
To: linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:53724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1760907AbcIWQsO (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 23 Sep 2016 12:48:14 -0400
Content-Disposition: inline; filename=0001-timers-wakeup-all-timer-waiters.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

3.4.112-rt144-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

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
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/timer.c b/kernel/timer.c
index c9b100922747..4954adeff38c 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -978,7 +978,7 @@ static void wait_for_running_timer(struct timer_list *timer)
 			   base->running_timer != timer);
 }
 
-# define wakeup_timer_waiters(b)	wake_up(&(b)->wait_for_running_timer)
+# define wakeup_timer_waiters(b)	wake_up_all(&(b)->wait_for_running_timer)
 #else
 static inline void wait_for_running_timer(struct timer_list *timer)
 {
-- 
2.8.1


