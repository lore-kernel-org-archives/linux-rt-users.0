From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 01/10] timers: wakeup all timer waiters
Date: Thu, 22 Sep 2016 17:57:48 -0400
Message-ID: <20160922215832.672522122@goodmis.org>
References: <20160922215747.696761304@goodmis.org>
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
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0001-timers-wakeup-all-timer-waiters.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

4.1.33-rt38-rc1 stable review patch.
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
 kernel/time/timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index c68ba873da3c..5a45162ae924 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1019,7 +1019,7 @@ static void wait_for_running_timer(struct timer_list *timer)
 			   base->running_timer != timer);
 }
 
-# define wakeup_timer_waiters(b)	wake_up(&(b)->wait_for_running_timer)
+# define wakeup_timer_waiters(b)	wake_up_all(&(b)->wait_for_running_timer)
 #else
 static inline void wait_for_running_timer(struct timer_list *timer)
 {
-- 
2.8.1
