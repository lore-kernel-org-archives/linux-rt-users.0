From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH RT] Revert "timer: delay waking softirqs from the jiffy tick"
Date: Thu, 5 Jul 2018 17:54:36 +0200
Message-ID: <20180705155435.3zb65vwxgagpza3b@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: tglx@linutronix.de, rostedt@goodmis.org,
        Peter Zilstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
To: linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Anna-Maria Gleixner <anna-maria@linutronix.de>

This patch was required as long as RT tasks where accounted to CFS
load but this was only a work around. Upstream Commit 17bdcf949d03
("sched: Drop all load weight manipulation for RT tasks") fixed the
accounting of RT tasks into CFS load.

Remove the patch and fix dependencies.

Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/time/timer.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1666,13 +1666,13 @@ void update_process_times(int user_tick)
 
 	/* Note: this timer irq context must be accounted for as well. */
 	account_process_tick(p, user_tick);
-	scheduler_tick();
 	run_local_timers();
 	rcu_check_callbacks(user_tick);
 #ifdef CONFIG_IRQ_WORK
 	if (in_irq())
 		irq_work_tick();
 #endif
+	scheduler_tick();
 	if (IS_ENABLED(CONFIG_POSIX_TIMERS))
 		run_posix_cpu_timers(p);
 }
