From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [RT PATCH 2/2] timers: wakeup all timer waiters without holding the base lock
Date: Thu, 14 Jul 2016 18:05:04 +0200
Message-ID: <1468512304-15310-2-git-send-email-bigeasy@linutronix.de>
References: <1468512304-15310-1-git-send-email-bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
	Steven Rostedt <rostedt@goodmis.org>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:45232 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149AbcGNQFQ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 14 Jul 2016 12:05:16 -0400
In-Reply-To: <1468512304-15310-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

There should be no need to hold the base lock during the wakeup. There
should be no boosting involved, the wakeup list has its own lock so it
should be safe to do this without the lock.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/time/timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index b3c3d3a6216f..716ef84a5d87 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1313,8 +1313,8 @@ static inline void __run_timers(struct tvec_base *base)
 			}
 		}
 	}
-	wakeup_timer_waiters(base);
 	spin_unlock_irq(&base->lock);
+	wakeup_timer_waiters(base);
 }
 
 #ifdef CONFIG_NO_HZ_COMMON
-- 
2.8.1

