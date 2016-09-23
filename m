From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 1/8] timers: wakeup all timer waiters
Date: Fri, 23 Sep 2016 11:30:32 -0400
Message-ID: <20160923153202.455089690@goodmis.org>
References: <20160923153031.676858930@goodmis.org>
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

3.10.103-rt115-rc1 stable review patch.
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
index 2fd6ea5c6519..ddcd6480cb4d 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -1009,7 +1009,7 @@ static void wait_for_running_timer(struct timer_list *timer)
 			   base->running_timer != timer);
 }
 
-# define wakeup_timer_waiters(b)	wake_up(&(b)->wait_for_running_timer)
+# define wakeup_timer_waiters(b)	wake_up_all(&(b)->wait_for_running_timer)
 #else
 static inline void wait_for_running_timer(struct timer_list *timer)
 {
-- 
2.8.1
