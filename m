From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 2/7] timers: wakeup all timer waiters without holding the base lock
Date: Fri, 23 Sep 2016 15:50:10 -0400
Message-ID: <20160923195019.101884900@goodmis.org>
References: <20160923195008.543008518@goodmis.org>
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
Received: from mail.kernel.org ([198.145.29.136]:42892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757801AbcIWTuX (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 23 Sep 2016 15:50:23 -0400
Content-Disposition: inline; filename=0002-timers-wakeup-all-timer-waiters-without-holding-the-.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

3.2.82-rt119-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

There should be no need to hold the base lock during the wakeup. There
should be no boosting involved, the wakeup list has its own lock so it
should be safe to do this without the lock.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/timer.c b/kernel/timer.c
index 3beac326b447..9e1b9db4c8b8 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -1185,8 +1185,8 @@ static inline void __run_timers(struct tvec_base *base)
 			spin_lock_irq(&base->lock);
 		}
 	}
-	wakeup_timer_waiters(base);
 	spin_unlock_irq(&base->lock);
+	wakeup_timer_waiters(base);
 }
 
 #ifdef CONFIG_NO_HZ
-- 
2.8.1


