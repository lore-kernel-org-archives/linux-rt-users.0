From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 09/22] Revert "timer: delay waking softirqs from the jiffy tick"
Date: Wed, 05 Sep 2018 08:28:03 -0400
Message-ID: <20180905122835.798847460@goodmis.org>
References: <20180905122754.443196118@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com,
        Anna-Maria Gleixner <anna-maria@linutronix.de>
To: linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

4.14.63-rt41-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Anna-Maria Gleixner <anna-maria@linutronix.de>

[ Upstream commit b5b16907c58280e015d5673dca4c6bd3fde0c348 ]

This patch was required as long as RT tasks where accounted to CFS
load but this was only a work around. Upstream Commit 17bdcf949d03
("sched: Drop all load weight manipulation for RT tasks") fixed the
accounting of RT tasks into CFS load.

Remove the patch and fix dependencies.

Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/time/timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index ff1d60d4c0cc..f57106c6e786 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1635,13 +1635,13 @@ void update_process_times(int user_tick)
 
 	/* Note: this timer irq context must be accounted for as well. */
 	account_process_tick(p, user_tick);
-	scheduler_tick();
 	run_local_timers();
 	rcu_check_callbacks(user_tick);
 #if defined(CONFIG_IRQ_WORK)
 	if (in_irq())
 		irq_work_tick();
 #endif
+	scheduler_tick();
 	if (IS_ENABLED(CONFIG_POSIX_TIMERS))
 		run_posix_cpu_timers(p);
 }
-- 
2.18.0
