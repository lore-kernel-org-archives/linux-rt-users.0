From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH RT 1/6] kernel: softirq: unlock with irqs on
Date: Sat, 13 Feb 2016 00:02:43 +0100
Message-ID: <1455318168-7125-1-git-send-email-bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
	Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

We unlock the lock while the interrupts are off. This isn't a problem
now but will get because the migrate_disable() + enable are not
symmetrical in regard to the status of interrupts.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/softirq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index d1e999e74d23..2ca63cc1469e 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -563,8 +563,10 @@ static void do_current_softirqs(void)
 			do_single_softirq(i);
 		}
 		softirq_clr_runner(i);
-		unlock_softirq(i);
 		WARN_ON(current->softirq_nestcnt != 1);
+		local_irq_enable();
+		unlock_softirq(i);
+		local_irq_disable();
 	}
 }
 
-- 
2.7.0
